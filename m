Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC23C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41RT-0000VG-Kz; Tue, 08 Sep 2026 15:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x41RR-0000Uw-Mf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x41RJ-0003BF-Iq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788895502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHAvTZTce39xcOp/tM+ColCCuYdI2ChBrbz+axaD9gQ=;
 b=SmY4imClwgVzf4p1DG6xrJgdtNoiS4P/b76XetSN0/VDjQV7LYlabp/sPxcpuDKVYP+Rfx
 7cfpv64mdN+/gn3mrr3V18ugiJmcteA9IaSuj0/vYmt10nEK85AJFllfhltzWILp9NsPQH
 bD6gGXj/qwZX3aWl/uQtQi4uEcCVWPk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-l1du-JDMMviqRmLU76Z8QQ-1; Tue,
 08 Sep 2026 15:25:01 -0400
X-MC-Unique: l1du-JDMMviqRmLU76Z8QQ-1
X-Mimecast-MFC-AGG-ID: l1du-JDMMviqRmLU76Z8QQ_1788895500
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D17A1956095; Tue,  8 Sep 2026 19:25:00 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0919D472; Tue,  8 Sep 2026 19:24:58 +0000 (UTC)
Date: Tue, 8 Sep 2026 20:24:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] io: bounce-buffer TLS writes to avoid nagle go-slow
Message-ID: <aqBhCHaRRERA2spt@redhat.com>
References: <20260907145112.852497-1-berrange@redhat.com>
 <aqBQJenwT_GcEr14@t14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqBQJenwT_GcEr14@t14>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 08, 2026 at 02:12:53PM -0400, Peter Xu wrote:
> On Mon, Sep 07, 2026 at 03:51:12PM +0100, Daniel P. Berrangé wrote:
> > The migration code caches vmstate/ram writes into an iovec and
> > flushes this every 128kb.
> 
> I am just curious how did this 128K came from. Perhaps this?
> 
>   MAX_IOV_SIZE / 2 * 4K
> 
> Where QEMU has:
> 
> #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> 
> And it needs to divides 2 because we always push save_page_header() first,
> which is 8B (in reality, maybe that'll also include some footers ahead from
> the last page..), then another 4K following it.  Then in average when
> hitting 64 io vectors there're 32 pages, coming up to be that.
> 
> I think that is right math for bulk ram phase, but maybe worth spelling out
> a bit.. because if above holds it's not very obvious..

Tracing the qio_channel_writev() calls yet again, I think my
mention of 128k is wrong. I'm now actually seeing alot of
1/2 MB writes. eg

Writev 64 (nvio=1)
Writev 64 (nvio=1)
Writev 64 (nvio=1)
Writev 64 (nvio=1)
Writev 1344 (nvio=1)
Writev 1344 (nvio=1)
Writev 1344 (nvio=1)
Writev 1344 (nvio=1)
Writev 281 (nvio=1)
Writev 8 (nvio=1)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)
Writev 13632 (nvio=4)
Writev 173376 (nvio=43)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)
Writev 525632 (nvio=129)


> 
> > 
> > The QIOChannelTLS receives the iovec, but size GNUTLS cannot
> > accept iovec data, it iterates calling send for each element.
> > 
> > As a result of the migration data pattern, this results in
> > GNUTLS putting writes on the wire that alternate between about
> > 4k and 30 bytes.
> > 
> > This is triggering the nagle algorithm on migration-test for
> > many of the TLS test cases, resulting in a "go slow" for I/O
> > that eventually hits the migration timeout configured by the
> > test.
> 
> Worth spell out the qio_channel_set_delay() experiment?
> 
> Frankly, even knowing qio_channel_set_delay(NO_DELAY) on all channels would
> fix it too, I don't think I fully get why the hang happened.

Note, it was never technically a "hang", it was just a "go slow".
The src was still sending and the dst was still receiving but it
was pathologically slow, a few KBs per second, instead of 100s or
1000s of MBs.

> Nagle, if my understanding is correct.. should be something trying to
> accumulate small writes only, it means write can be slightly delayed, but
> it didn't further explain why even if we push writting to it, it didn't
> flush properly.

The nagle algorithm influences the TCP window size. The src cannot
send more data, until the dst has acknowledged packets already sent.

IIUC, normally if you send large volumes of data the window size will
grow large quite quickly. If you send lots of small packets, nagle
can keep the window size small and thus delay pending writes.

Migration with large iovec arrays was causnig alot of small writes,
so I think that meant the window size did not grow enough to get
a high speed.

> Say, I understand TLS is special now with its io_writev(), being
> qio_channel_tls_writev(), split the iov into multiple calls to
> qcrypto_tls_session_write(), which is likely why the problem existed, but I
> don't think I know why multiple qcrypto_tls_session_write() (and I believe
> ultimately, assuming small but continuous write()s to the socket fd) will
> cause a hang.  Any clue?

What I can't explain is why only certain contributors ever saw this
as a problem ?

> > This patch thus queries the max TLS record size and then
> > flattens the iovec into buffers of this size. If the
> > iovec only contains a single element, bounce buffering
> > is skipped to avoid the redundant copy.
> 
> I saw there is also gnutls_record_cork() and the uncork(), which seems to
> resolve the same issue (I tried to look at gnutls git history but I didn't
> find any mention of why the API introduced.. though).
> 
> Any thoughts on why not relying on that, say, would it work too if cork()
> at start of qio_channel_tls_writev(), loop, then uncork()?

Yes, relying on gnutls_record_cork is something I can try - it would
certainly be nice to avoid the bounce buffering, as that's significant
overhead when we're talking about iovecs with 1/2 MB of data at a
time.

I'll prepare a v2.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


