Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0D5C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PYh-0003b4-P1; Wed, 09 Sep 2026 17:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4PYR-0003a9-Oq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4PYO-0000g4-QL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788988199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx37XD17OF5NoFfp4QferQ7Vfx48v+JyBfPCZdoRTK8=;
 b=Au0OTJkZlDgqCuKnSTozD8iamlD7lUoSXet8/5TX1aXewt6ZixCWfnU2cjoaH8yKnB4guv
 brO9g0CUVk4xoCBX1Dx6ixJ/46IYBfSfIISP/LoQn0eNK3UcR/I90VwCsJYd+VQKsqVSPv
 6ekj+AHwrH+eLSOX3niMYkIo2NZvdmE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-tUcsTb9QOyCMbiHG6ebJxw-1; Wed, 09 Sep 2026 17:09:57 -0400
X-MC-Unique: tUcsTb9QOyCMbiHG6ebJxw-1
X-Mimecast-MFC-AGG-ID: tUcsTb9QOyCMbiHG6ebJxw_1788988197
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939665a1ae6so828990685a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788988197; x=1789592997; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vx37XD17OF5NoFfp4QferQ7Vfx48v+JyBfPCZdoRTK8=;
 b=lrT/U0BSFDXO2gj45zoy5nT6DxsOh3/Hyt6zm0t+mS3YIBeBTmjvVn5+WX8Eo5z68p
 RM8gCLpE8xh7SvCkqlVUfhjRCT8KupeQFW871DoCUWRSXLCCQE8nNn+3D6XobKp/kmUC
 AhlqlZzUhqW5NJxw6yHExwE67F4ysNtbKDI3G4MT6uRinrdHMUgTqPjNkPEoCc/X9XaO
 hJ3TKj+gmWPgdij2WwsRPqj/dfwbl3zGajHsPiecU0SzR5VO89g2pqhOQLvzf882HSqI
 bK0PI5OdXN6LEp5c91JPtarYNDVzef4cb43OppPltYU3MEYcRRp+7CRJBJA8GFox1a1D
 vMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988197; x=1789592997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vx37XD17OF5NoFfp4QferQ7Vfx48v+JyBfPCZdoRTK8=;
 b=nCsqZPFQtsQ5NkH9M6BFRMh+RD4REEDkOWb3+hC4rHotlwUz+VuB2iOu2Cyp/yE0o6
 rLKOhC9GLqmkdqmScwIqxZOY20JrtFdem60GpnWPjk09FxRxFjQEuW9Ce0VkjUeq0NHF
 yhpGDPRF4QmxggUEonX667xDNdtPlfAmYH5Z87+ECSZvLzF+ZtzVHKwy52SMu3uOW6f8
 vrdqdZVLzTg2BYjZ6hnhouebYM1E3VLNwoQLq3v1alIM4bffEFQ5NU3SogrpklcmmG7m
 TPjIL94mHhjs6WmYCoVovP9tXYtUt6HVYGbybNyU5VIlDhXVIOwR5gDMRUAANabUTeXZ
 7mDw==
X-Gm-Message-State: AFuF++neZMrnQBmPpzAGQj3rnrzx82P/JjvHGKerNYRcrd5xGZrp2IWF
 OJcxgYw7AukAyqJZjwM46uJLoEvQ+1l0BrG15r/4Hrs9gJn109mkAh+2EuAR+JtzIT62CQrif0U
 uNsCXOsK5yg9sH9+140bMNM0YLDhp2gRQBASc/rCySHWE5ZqrMYRoAmFq4dDn/yBV6As=
X-Gm-Gg: AYBFou2CuZLHQ6VqdbD0SW+Qpg/MEvtmR2CoadaSeLKU64mfUVsHLAr23wW6JbytJKr
 /PlRUxbJVoleBdWlfjUZ2y5RL/lGwumAlkKKODkZi/Sh/czPk/Kx1rUIDtfEIpsBKoir1GX4Pak
 MZ/9DE0xDZerT+oTIJiWNXFMgPw9fxvzJ14w2JA0Jk21+gTcog7hg8w5P72oSwLM5sZEqQsaiKz
 DNcFaT8X0NZLAvdxUtTmwTOwmKmESaYda7VOYg2UoGRjHYIXvbEA3colahpo+fcczjSR7LSkJOs
 D9dNNYuPBQnNy1bYYLNhutvjS6VnxzqsaG7YeuM27mt6h/sndla6TcGXaUm9PGl6EEG/
X-Received: by 2002:a05:620a:a48e:b0:939:7144:485d with SMTP id
 af79cd13be357-9398048a654mr2962119885a.38.1788988196755; 
 Wed, 09 Sep 2026 14:09:56 -0700 (PDT)
X-Received: by 2002:a05:620a:a48e:b0:939:7144:485d with SMTP id
 af79cd13be357-9398048a654mr2962114885a.38.1788988196137; 
 Wed, 09 Sep 2026 14:09:56 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fbcc54dsm1511284885a.42.2026.09.09.14.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:09:55 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:09:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] io: bounce-buffer TLS writes to avoid nagle go-slow
Message-ID: <aqHLGCAZmWhtKSYP@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260907145112.852497-1-berrange@redhat.com>
 <aqBQJenwT_GcEr14@t14> <aqBhCHaRRERA2spt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqBhCHaRRERA2spt@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 08, 2026 at 08:24:56PM +0100, Daniel P. Berrangé wrote:
> On Tue, Sep 08, 2026 at 02:12:53PM -0400, Peter Xu wrote:
> > On Mon, Sep 07, 2026 at 03:51:12PM +0100, Daniel P. Berrangé wrote:
> > > The migration code caches vmstate/ram writes into an iovec and
> > > flushes this every 128kb.
> > 
> > I am just curious how did this 128K came from. Perhaps this?
> > 
> >   MAX_IOV_SIZE / 2 * 4K
> > 
> > Where QEMU has:
> > 
> > #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> > 
> > And it needs to divides 2 because we always push save_page_header() first,
> > which is 8B (in reality, maybe that'll also include some footers ahead from
> > the last page..), then another 4K following it.  Then in average when
> > hitting 64 io vectors there're 32 pages, coming up to be that.
> > 
> > I think that is right math for bulk ram phase, but maybe worth spelling out
> > a bit.. because if above holds it's not very obvious..
> 
> Tracing the qio_channel_writev() calls yet again, I think my
> mention of 128k is wrong. I'm now actually seeing alot of
> 1/2 MB writes. eg

The 1/2 MB writes are likely from multifd senders.

> 
> Writev 64 (nvio=1)
> Writev 64 (nvio=1)
> Writev 64 (nvio=1)
> Writev 64 (nvio=1)

These are likely, MultiFDInit_t, and maybe there're just 4 multifd
channels?

> Writev 1344 (nvio=1)
> Writev 1344 (nvio=1)
> Writev 1344 (nvio=1)
> Writev 1344 (nvio=1)
> Writev 281 (nvio=1)
> Writev 8 (nvio=1)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> Writev 13632 (nvio=4)
> Writev 173376 (nvio=43)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> Writev 525632 (nvio=129)
> 
> 
> > 
> > > 
> > > The QIOChannelTLS receives the iovec, but size GNUTLS cannot
> > > accept iovec data, it iterates calling send for each element.
> > > 
> > > As a result of the migration data pattern, this results in
> > > GNUTLS putting writes on the wire that alternate between about
> > > 4k and 30 bytes.
> > > 
> > > This is triggering the nagle algorithm on migration-test for
> > > many of the TLS test cases, resulting in a "go slow" for I/O
> > > that eventually hits the migration timeout configured by the
> > > test.
> > 
> > Worth spell out the qio_channel_set_delay() experiment?
> > 
> > Frankly, even knowing qio_channel_set_delay(NO_DELAY) on all channels would
> > fix it too, I don't think I fully get why the hang happened.
> 
> Note, it was never technically a "hang", it was just a "go slow".
> The src was still sending and the dst was still receiving but it
> was pathologically slow, a few KBs per second, instead of 100s or
> 1000s of MBs.

Ah OK, yes "hang" isn't accurate.  IMHO it would be nice to mention the
bandwidth measured in the commit log.

> 
> > Nagle, if my understanding is correct.. should be something trying to
> > accumulate small writes only, it means write can be slightly delayed, but
> > it didn't further explain why even if we push writting to it, it didn't
> > flush properly.
> 
> The nagle algorithm influences the TCP window size. The src cannot
> send more data, until the dst has acknowledged packets already sent.

OK, so it's TLS specific behavior (within gnutls)?

> 
> IIUC, normally if you send large volumes of data the window size will
> grow large quite quickly. If you send lots of small packets, nagle
> can keep the window size small and thus delay pending writes.
> 
> Migration with large iovec arrays was causnig alot of small writes,
> so I think that meant the window size did not grow enough to get
> a high speed.
> 
> > Say, I understand TLS is special now with its io_writev(), being
> > qio_channel_tls_writev(), split the iov into multiple calls to
> > qcrypto_tls_session_write(), which is likely why the problem existed, but I
> > don't think I know why multiple qcrypto_tls_session_write() (and I believe
> > ultimately, assuming small but continuous write()s to the socket fd) will
> > cause a hang.  Any clue?
> 
> What I can't explain is why only certain contributors ever saw this
> as a problem ?

Me too.  I think the NODELAY test at least proved it is relevant to how ACK
happens, and if that ACK delay behaves differently on different host, it
may explain.

> 
> > > This patch thus queries the max TLS record size and then
> > > flattens the iovec into buffers of this size. If the
> > > iovec only contains a single element, bounce buffering
> > > is skipped to avoid the redundant copy.
> > 
> > I saw there is also gnutls_record_cork() and the uncork(), which seems to
> > resolve the same issue (I tried to look at gnutls git history but I didn't
> > find any mention of why the API introduced.. though).
> > 
> > Any thoughts on why not relying on that, say, would it work too if cork()
> > at start of qio_channel_tls_writev(), loop, then uncork()?
> 
> Yes, relying on gnutls_record_cork is something I can try - it would
> certainly be nice to avoid the bounce buffering, as that's significant
> overhead when we're talking about iovecs with 1/2 MB of data at a
> time.

I had a quick look at v2, when looking into the cork() a bit more, I found
that gnutls is doing the caching before encryption not after, so I think
there's still a bounce buffer..

Said that, I wonder if using cork() is still a good approach, not only if
that solves the current problem, but also because it trades "memcpy" with
"less syscalls" too as side effect: IIUC we used to write() too frequently,
in case of RAM headers maybe one write on a few bytes worst case, but now
it's one shot, and IIUC the size should be the same as qemufile caching.

What I plan to do is I want to do a simple perf test tomorrow with TLS
migration, single threaded as start, to see if v2 would improve performance
(ignoring the fact it would fix the nodelay issue).

Another thing I can report early is v2 fails to compile when gnutls-devel
isn't available.

Thanks,

> 
> I'll prepare a v2.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 

-- 
Peter Xu


