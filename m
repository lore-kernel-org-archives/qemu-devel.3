Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2770ECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZnP-0005HV-51; Fri, 19 Sep 2025 08:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZnN-0005Gl-GC
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZnF-0003rR-Tv
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK2NR9nFb3jht2d1a0BgzN93rroLpReJHNCoQnYSfT8=;
 b=E9rDcRvQ8yPcl7d5O9gV6vhRsq3fZ2yup1xHCHSfocfANDJeNyrh1EUXW3dKVqXBxynDDx
 nyBza/I1GnU6H929V0AxiTjYGYPdxdM2bMq2seNYx64Jgib0oH+oY8A2rhhN9f+zjnckUg
 kqNXIO7cWludhiqvY3nWO5SRKufp3J4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-N6lUil2DNOi00_VCG8UM_Q-1; Fri,
 19 Sep 2025 08:00:41 -0400
X-MC-Unique: N6lUil2DNOi00_VCG8UM_Q-1
X-Mimecast-MFC-AGG-ID: N6lUil2DNOi00_VCG8UM_Q_1758283240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 294241956050; Fri, 19 Sep 2025 12:00:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 035D730002C5; Fri, 19 Sep 2025 12:00:37 +0000 (UTC)
Date: Fri, 19 Sep 2025 13:00:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aM1F4vGh86vq0MW3@redhat.com>
References: <aMCjGVUiM3MY-RM3@x1.local> <aMEkY3N9ITwH_Y8Z@redhat.com>
 <aMGpHBGth05JY2hl@x1.local> <aMPz0WFmstNmKBQc@redhat.com>
 <aMQ19NmgFkLs8jkA@x1.local> <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com> <aMwg-ROjbDL_z_EM@x1.local>
 <aM1Fj6tpynIz9XHL@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aM1Fj6tpynIz9XHL@orkuz.int.mamuti.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 19, 2025 at 01:59:11PM +0200, Jiří Denemark wrote:
> On Thu, Sep 18, 2025 at 11:10:49 -0400, Peter Xu wrote:
> > On Thu, Sep 18, 2025 at 03:45:21PM +0100, Daniel P. Berrangé wrote:
> > > There needs to be a way to initiate post-copy recovery regardless
> > > of whether we've hit a keepalive timeout. Especially if we can
> > > see one QEMU in postcopy-paused, but not the other side, it
> > > doesn't appear to make sense to block the recovery process.
> > > 
> > > The virDomainJobCancel command can do a migrate-cancel on the
> > > src, but it didn't look like we could do the same on the dst.
> > > Unless I've overlooked something, Libvirt needs to gain a way
> > > to explicitly force both sides into the postcopy-paused state,
> > > and thus be able to immediately initiate recovery.
> > 
> > Right, if libvirt can do that then problem should have been solved too.
> 
> I think we should be able to use the yank command to tell QEMU to close
> migration connections. I haven't tried it on the destination, but I
> guess it should work similarly to the source where it causes the
> migration to switch to postcopy-paused. It seems to be an equivalent of
> migrate-pause. So can we safely use yank in such situations?

Can't we use migrate-pause on the target too ?  IIUC that was what Peter
was suggesting earlier in the thread, unless I mis-interpreted ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


