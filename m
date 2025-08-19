Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A970CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoK1G-0002Wb-HJ; Tue, 19 Aug 2025 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoK1D-0002W7-GZ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoK1B-0002dH-IW
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755601000;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BW0eUyqLdGv1RzUriBirkGlfm2ScMEusxjyoM4tAPCY=;
 b=O3HXK8s38gcGlF4nsb3thPDc/vEOe5PWbiJADPw6tZB6nl+C0hO+n54TXYqx35ZSvsUC3E
 2J4psDQbUdy40mABBF1rKi5DGPHv0E6shynON9Rk7JDzqP/Z3tEXrbw9sXQVgUEyj1Encv
 Hd99hsV7jmbibIOP4+zNOLgJD7lRHUk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-t4XvotEhM9eLZqt59vMACA-1; Tue,
 19 Aug 2025 06:56:36 -0400
X-MC-Unique: t4XvotEhM9eLZqt59vMACA-1
X-Mimecast-MFC-AGG-ID: t4XvotEhM9eLZqt59vMACA_1755600995
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86F1C180034B; Tue, 19 Aug 2025 10:56:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EBF195419F; Tue, 19 Aug 2025 10:56:32 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:56:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/12] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
Message-ID: <aKRYXR688tKBJ7AQ@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-3-armbru@redhat.com>
 <e864d8f9-505c-41d0-90a2-5a6d040caacf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e864d8f9-505c-41d0-90a2-5a6d040caacf@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 08, 2025 at 04:00:42PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> On 8/8/25 10:08, Markus Armbruster wrote:
> > tcg_region_init() calls one of qemu_mprotect_rwx(),
> > qemu_mprotect_rw(), and mprotect(), then reports failure with
> > error_setg_errno(&error_fatal, errno, ...).
> > 
> > The use of &error_fatal is undesirable.  qapi/error.h advises:
> > 
> >   * Please don't error_setg(&error_fatal, ...), use error_report() and
> >   * exit(), because that's more obvious.
> > 
> > The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> > wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> > mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> > with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> > does, but error_report() may clobber it.
> > 
> > Fix tcg_region_init() to report errors only when it calls mprotect(),
> > and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> > reporting otherwise.  Use error_report(), not error_setg().
> > 
> > Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> > Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >   tcg/region.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tcg/region.c b/tcg/region.c
> > index 7ea0b37a84..74e3b4b774 100644
> > --- a/tcg/region.c
> > +++ b/tcg/region.c
> > @@ -832,13 +832,17 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
> >               } else {
> >   #ifdef CONFIG_POSIX
> >                   rc = mprotect(start, end - start, need_prot);
> > +                if (rc) {
> > +                    error_report("mprotect of jit buffer: %s",
> > +                                 strerror(errno));
> > +                }
> > +
> >   #else
> >                   g_assert_not_reached();
> >   #endif
> >               }
> >               if (rc) {
> > -                error_setg_errno(&error_fatal, errno,
> > -                                 "mprotect of jit buffer");
> > +                exit(1);
> 
> - Before:
> 
> Error displayed when qemu_mprotect_rwx/qemu_mprotect_rw/mprotect fail,
> then exit.
> 
> - After:
> 
> Error only displayed when mprotect() fails, then exit.
> Nothing displayed when qemu_mprotect_rwx() or qemu_mprotect_rw() failed,
> and exit.

Check the impl in qemu_mprotect__osdep - it calls error_report already,
so those code paths didn't need to be changedin this patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


