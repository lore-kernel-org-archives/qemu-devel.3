Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80796C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkCy-00011T-38; Tue, 29 Jul 2025 09:17:32 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugkCi-0000Un-3X
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugkCe-0002ZT-Bq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753795027;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A46pdvu3P8sVMAVxEZjlM/QkpXNT6aCO2+WxlHevqcU=;
 b=PaS5lV/59jb1RqUVRD8NVLjttjLmSGeD5/mAyzBaHnaGVuXd28DZpblW4/wzoIisOkISBb
 wH5xcIbiOdBOSdy6fdjYpLoJYOW+aySeOtxe3etZUjfODcfE3q0Actr5wHVBGK4prTbzu8
 jsypydUTt4uuSFZt9GhSKWIHzB2B/BI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-HNYTd7FgNs2GY06vlk4H_Q-1; Tue,
 29 Jul 2025 09:17:04 -0400
X-MC-Unique: HNYTd7FgNs2GY06vlk4H_Q-1
X-Mimecast-MFC-AGG-ID: HNYTd7FgNs2GY06vlk4H_Q_1753795023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F1631956089; Tue, 29 Jul 2025 13:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43CFF19560A2; Tue, 29 Jul 2025 13:17:00 +0000 (UTC)
Date: Tue, 29 Jul 2025 14:16:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
Message-ID: <aIjJyH_Vy0LzHH4z@redhat.com>
References: <20250729111226.3627499-1-armbru@redhat.com>
 <14fff91b-7434-4d90-adb1-ebbe3f51d605@linaro.org>
 <87v7nbdwfx.fsf@pond.sub.org>
 <15536eea-5a66-4dff-b4bd-8a43fbfa9365@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15536eea-5a66-4dff-b4bd-8a43fbfa9365@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 29, 2025 at 02:59:46PM +0200, Philippe Mathieu-Daudé wrote:
> On 29/7/25 14:16, Markus Armbruster wrote:
> > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> > 
> > > On 29/7/25 13:12, Markus Armbruster wrote:
> > > > xenfb_mouse_event() has a switch statement whose controlling
> > > > expression move->axis is an enum InputAxis.  The enum values are
> > > > INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
> > > > case for both axes.  In addition, it has an unreachable default label.
> > > > This convinces Coverity that move->axis can be greater than 1.  It
> > > > duly reports a buffer overrun when it is used to subscript an array
> > > > with two elements.
> > > > Replace the unreachable code by abort().
> > > > Resolves: Coverity CID 1613906
> > > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > > ---
> > > >    hw/display/xenfb.c | 3 +--
> > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> > > > index 22822fecea..5e6c691779 100644
> > > > --- a/hw/display/xenfb.c
> > > > +++ b/hw/display/xenfb.c
> > > > @@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
> > > >                    scale = surface_height(surface) - 1;
> > > >                    break;
> > > >                default:
> > > > -                scale = 0x8000;
> > > > -                break;
> > > > +                abort();
> > > 
> > > We prefer GLib g_assert_not_reached() over abort() because it displays
> > > the file, line number & function before aborting.
> > 
> > The purpose of this line is to tell the compiler we can't get there,
> > with the least amount of ceremony.
> > 
> > We have ~600 calls of abort().
> 
> And ~1600 of g_assert_not_reached() =)
> 
> $ git grep -w 'abort();' | wc -l
>      556
> $ git grep -w 'g_assert_not_reached();' | wc -l
>     1551

Sounds like we could create a gitlab issue for "replace abort with
g_assert_not_reached" that could be a easy on-ramp for someone to
start contributing.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


