Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66527C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2590-0007t5-1A; Thu, 03 Sep 2026 06:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x258y-0007ss-Qb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x258w-0000xy-Qc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788433085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuueVlgR9J0dtvZfjNUDUKkQtaNGr3QTOQUcr0Edk74=;
 b=YKxqHezLNcHRf67kmCFYHL6irHBgksRB0qMc4buqVXG414phyABZ7xGYq7A4fv+j6Hq7GC
 hosJdWoHT+po9aa2yEJ02LlxIdHFxr+9zD6pktuWlPT7JBE6z7GSjdBvlAc3TWoHaJQ+mx
 oyRXleIkEIMzeoGJHoyyMMXzuuSzKxQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-VqGOBV0dPp6ATbxJPZaXnQ-1; Thu,
 03 Sep 2026 06:58:01 -0400
X-MC-Unique: VqGOBV0dPp6ATbxJPZaXnQ-1
X-Mimecast-MFC-AGG-ID: VqGOBV0dPp6ATbxJPZaXnQ_1788433080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 267B2180884B; Thu,  3 Sep 2026 10:58:00 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8095818005AD; Thu,  3 Sep 2026 10:57:57 +0000 (UTC)
Date: Thu, 3 Sep 2026 11:57:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 04/32] system: check security for accelerator types
Message-ID: <aplSsvCbAz7N1vpz@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-5-berrange@redhat.com>
 <178708450916.1320462.9696296249019752826.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178708450916.1320462.9696296249019752826.b4-review@b4>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 19, 2026 at 12:21:49AM +0400, marcandre.lureau@redhat.com wrote:
> > This wires up the accelerator creation code to apply the compat policy
> > security check. When multiple -accel options are given, normal fallback
> > logic applies. IOW, if one is rejected by the security check, it will
> > carry on to try the next accelerator until one passes the security
> > check.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20250926140144.1998694-5-berrange@redhat.com>
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 00f36947257a..6f7fdb866359 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -2383,12 +2383,21 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
> >      AccelState *accel;
> >      int ret;
> >      bool qtest_with_kvm;
> > +    Error *local_err = NULL;
> >  
> >      if (!acc) {
> >          error_setg(errp, QERR_MISSING_PARAMETER, "accel");
> >          goto bad;
> >      }
> >  
> > +    if (!compat_policy_check_security(&compat_policy,
> > +                                      object_class_get_name(OBJECT_CLASS(ac)),
> > +                                      object_class_is_secure(OBJECT_CLASS(ac)),
> > +                                      &local_err)) {
> > +        error_report_err(local_err);
> > +        goto bad;
> > +    }
> 
> It should handle ac == NULL before

Ah yes, we need to move this check further down.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


