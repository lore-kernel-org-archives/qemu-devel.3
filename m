Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892EDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN82k-0000M9-So; Fri, 28 Jun 2024 05:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN82j-0000Lu-Un
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN82i-0006k2-A1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719567438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJfcqHG1kYoGKLQbAanEjI+rBT+Ue0o5CGEXjcoJxR4=;
 b=E2X0Y6rRtcCNzq+BOAilQxYX+tsytJEyMQ4QfTynvOJVXETUdrAshq1f4MO2lerwZc+QaI
 GJmhtPLFTNOzP7ca6VAOVK/PMIERCeGJhMoPf/AxWz6hXESEmujR3gMETo89su3iLtoXkU
 eO63h4cJqsQESpaOX6nNM1iUkvBHBlw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-xOXbm_PQNPiz9yuEj6Hz2g-1; Fri,
 28 Jun 2024 05:37:13 -0400
X-MC-Unique: xOXbm_PQNPiz9yuEj6Hz2g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A2811955F36; Fri, 28 Jun 2024 09:37:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F11D419773D8; Fri, 28 Jun 2024 09:37:10 +0000 (UTC)
Date: Fri, 28 Jun 2024 10:37:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v42 02/98] hw/sd/sdcard: Use spec v3.01 by default
Message-ID: <Zn6EQ39Q57KtmKPU@redhat.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-3-philmd@linaro.org>
 <Zn5w6A20UVkrP3ca@redhat.com>
 <6908ca71-6df8-4aff-b1d0-39e35aad7a1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6908ca71-6df8-4aff-b1d0-39e35aad7a1e@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 28, 2024 at 11:19:52AM +0200, Philippe Mathieu-Daudé wrote:
> On 28/6/24 10:14, Daniel P. Berrangé wrote:
> > On Fri, Jun 28, 2024 at 09:00:38AM +0200, Philippe Mathieu-Daudé wrote:
> > > Recent SDHCI expect cards to support the v3.01 spec
> > > to negociate lower I/O voltage. Select it by default.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Reviewed-by: Cédric Le Goater <clg@redhat.com>
> > > ---
> > >   hw/sd/sd.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > > index a48010cfc1..d0a1d5db18 100644
> > > --- a/hw/sd/sd.c
> > > +++ b/hw/sd/sd.c
> > > @@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
> > >   static Property sd_properties[] = {
> > >       DEFINE_PROP_UINT8("spec_version", SDState,
> > > -                      spec_version, SD_PHY_SPECv2_00_VERS),
> > > +                      spec_version, SD_PHY_SPECv3_01_VERS),
> > 
> > Shouldn't such a change be tied to machine type versions ?
> 
> I don't think so, SD cards are external to machines (like
> CDROM you can use any brand). IOW machines only provide a
> SD card reader, user can insert any card there.

Consider we release this in QEMU 9.1.0, and the user starts a VM with the
8.0 machine type. The guest will see an SD card supporting v3.

Now live migrate that guest to a host with QEMU 9.0.0, still using the 8.0
machine type. The guest will expect the SD card to still be v3, but QEMU
will internally be set to v2, and will return illegal cmd errors if the
guest tries to run v3 only cmds. Versioned machine types exist to prevent
this kind of problem.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


