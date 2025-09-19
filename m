Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9ACCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZrY-0008Ap-Nc; Fri, 19 Sep 2025 08:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZr8-0007y2-AG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZr2-0006lP-7S
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfEZK7k8xoSg2IiXntacZ3MMUI62+Jt/3fFuwo7O2MI=;
 b=LA193+BoZB+99LbgUfPfdnv58EvFtNJfsznzVRpg26JQYYN03VW5KvGzGDOu9mlqf8sf4p
 5xJdTsyABQQQ9gZddcrOJkqNsqLksdNsVNPmI1GHHAS24ypcNVapdAOxMcO2g4eyYHn05C
 t+Hwq7GSBOJ/XTlxbS+vcqqSGB09o+A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-SGhr9CwCMvC0mIyNzMoD3Q-1; Fri,
 19 Sep 2025 08:04:23 -0400
X-MC-Unique: SGhr9CwCMvC0mIyNzMoD3Q-1
X-Mimecast-MFC-AGG-ID: SGhr9CwCMvC0mIyNzMoD3Q_1758283462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CB6E1800378; Fri, 19 Sep 2025 12:04:22 +0000 (UTC)
Received: from orkuz (unknown [10.44.34.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9616B1800446; Fri, 19 Sep 2025 12:04:21 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:04:19 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aM1Gw2NEYBx03Aog@orkuz.int.mamuti.net>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMwbAdKQLzLaf4Hd@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 18, 2025 at 15:45:21 +0100, Daniel P. Berrangé wrote:
> On Thu, Sep 18, 2025 at 04:16:56PM +0200, Juraj Marcin wrote:
> > If there is no outgoing traffic from the destination side (this can be
> > caused for example by a workload with no page faults or paused machine),
> > QEMU has no way of knowing if the connection is still working or not.
> > The TCP stack doesn't treat no incoming traffic as a sign of a broken
> > connection. Therefore, QEMU would stay in postcopy-active waiting for
> > pages indefinitely.
> > 
> > Also, libvirt might not be aware of a connection dropout between QEMUs,
> > if libvirt's connection is intact, especially if libvirt daemons are
> > communicating through some central entity that is managing the migration
> > and not directly. And to do postcopy migration recovery, libvirt needs
> > both sides to be in postcopy-paused state.
> 
> Whether keepalive timeouts are at the QEMU level or global kernel
> level, there will always be situations where the timeouts are too
> long. Apps/admins can have out of band liveliness checks between
> hosts that detect a problem before the keepalives will trigger
> and shouldn't have to wait to recover migration, once they have
> resolved the underlying network issue.
> 
> There needs to be a way to initiate post-copy recovery regardless
> of whether we've hit a keepalive timeout. Especially if we can
> see one QEMU in postcopy-paused, but not the other side, it
> doesn't appear to make sense to block the recovery process.
> 
> The virDomainJobCancel command can do a migrate-cancel on the
> src, but it didn't look like we could do the same on the dst.
> Unless I've overlooked something, Libvirt needs to gain a way
> to explicitly force both sides into the postcopy-paused state,
> and thus be able to immediately initiate recovery.
> 
> > Alternatively, there also might be an issue with the connection between
> > libvirt daemons, but not the migration connection. Even if the libvirt
> > connection fails, the migration is not paused, rather libvirt lets the
> > migration finish normally. Similarly, if the libvirt connection is
> > broken up due to, for example, libvirt daemon restart, the ongoing
> > migration is not paused, but after the libvirt daemon starts again, it
> > sees an ongoing migration and lets it finish.
> 
> Whole this is a reliability issue for libvirt, this doesn't have
> any bearing on migration keepalive timeouts, as we're only concerned
> about QEMU connections.
> 
> > Additionally, libvirt uses its own internal keep-alive packets with much
> > more aggressive timeouts, waiting 5 - 10 seconds idle before sending a
> > keep-alive packet and then killing the connection if there is no
> > response in 30 seconds.
> 
> Yep, this keepalive is very aggressive and has frequently caused
> problems with libvirt connections being torn down inappropriately.

This was happening when a link was saturated with storage migrations and
the keepalive messages in a separate (and otherwise idle) connection
were not sent in time. We haven't seen any reports for quite some time.
I believe it was identified as a kernel bug a few years ago and then the
reports stopped.

Jirka


