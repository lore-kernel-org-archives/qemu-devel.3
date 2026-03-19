Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6912107527C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39CK-0007tt-UX; Thu, 19 Mar 2026 04:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w39CJ-0007rw-Dk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w39CG-00041Z-6X
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773910658;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkBt8n9DalVs6oma+veIa/stHz5C4Wl2ecDeBFozS5Q=;
 b=HSRxcamXV42nna8JtIE1+ibdKYsbopqXIXmd6volrwlBDtt6fSCxKWaSTyPq89rOCCdAI7
 3pbNqQtGN2ZjhCtWOL+uo5ux6DWX+9EuoE3ZnFs7QuzPR6D4eBmSdpwC+EV09vNDIBknjn
 0TOOvV3KE5Alq1Tg0jag+c5ydlpTM74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-eFNYyKYMM268RkXwJmt9_w-1; Thu,
 19 Mar 2026 04:57:35 -0400
X-MC-Unique: eFNYyKYMM268RkXwJmt9_w-1
X-Mimecast-MFC-AGG-ID: eFNYyKYMM268RkXwJmt9_w_1773910654
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAD8B18005BB; Thu, 19 Mar 2026 08:57:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24D071955F21; Thu, 19 Mar 2026 08:57:29 +0000 (UTC)
Date: Thu, 19 Mar 2026 08:57:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 02/10] io: Fix TLS bye task leak
Message-ID: <abu6drYEygCgA0R9@redhat.com>
References: <20260317182320.31991-1-farosas@suse.de>
 <20260317182320.31991-3-farosas@suse.de>
 <f6c365e9-7d4e-4ad5-afc3-1fe31230baae@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6c365e9-7d4e-4ad5-afc3-1fe31230baae@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, Mar 18, 2026 at 11:36:50PM +0300, Michael Tokarev wrote:
> On 17.03.2026 21:23, Fabiano Rosas wrote:
> > Recent fixes to TLS tasks memory handling have left the TLS bye task
> > uncovered. Fix by freeing the task in the same way the handshake task
> > is freed.
> > 
> > Direct leak of 704 byte(s) in 4 object(s) allocated from:
> >      #1 0x7f5909b1d6a0 in g_malloc0 ../glib/gmem.c:163
> >      #2 0x557650496d61 in qio_task_new ../io/task.c:58:12
> >      #3 0x557650475d7f in qio_channel_tls_bye ../io/channel-tls.c:352:12
> >      #4 0x55764f7a1bb4 in migration_tls_channel_end ../migration/tls.c:159:5
> >      #5 0x55764f709750 in migration_ioc_shutdown_gracefully ../migration/multifd.c:462:9
> >      #6 0x55764f6fcf53 in multifd_send_terminate_threads ../migration/multifd.c:493:13
> >      #7 0x55764f6fcafb in multifd_send_shutdown ../migration/multifd.c:580:5
> >      #8 0x55764f6e1b14 in migration_cleanup ../migration/migration.c:1323:9
> >      #9 0x55764f6f5bac in migration_cleanup_bh ../migration/migration.c:1350:5
> > 
> > Fixes: d39d0f3acd ("io: fix cleanup for TLS I/O source data on cancellation")
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> > Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-3-farosas@suse.de
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> This seems like a qemu-stable material, -- since the above mentioned
> commit is in currently active stable branches.
> 
> Please let me know if I shouldn't pick it up for the currently active
> stable branches (10.0 & 10.2).

Yes, please take to stable.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


