Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627A2CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLWc-00048W-VN; Thu, 03 Oct 2024 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swLWZ-00048J-A8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swLWW-0008Pp-Pm
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727960739;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+vL3dqign+P2WhTjUg3iVCNMYbhTw3Y6qxHdcMnHuLM=;
 b=SEah0U/l8PEYdKZE3iVAP+x1Xp1XP8G8J3zH2C0IRLPxVFIYItoNnU37l6hGLpEm05CLt7
 HoAJBFjzxiIsZSUStCvWiKHIY5l7J1d4+rkVWOuLdECdnnwyn3iLBjUHWl+ypWTrweyqAh
 E8NrQ2cBJHO3QYsA48IVZd/369Y6KMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-6bP6F0ytORqJ_RqhOD5B3A-1; Thu,
 03 Oct 2024 09:05:35 -0400
X-MC-Unique: 6bP6F0ytORqJ_RqhOD5B3A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D828A1955BFE; Thu,  3 Oct 2024 13:05:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC80319560A2; Thu,  3 Oct 2024 13:05:31 +0000 (UTC)
Date: Thu, 3 Oct 2024 14:05:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Simon Rowe <simon.rowe@nutanix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "freddy77@gmail.com" <freddy77@gmail.com>
Subject: Re: Corrupt VNC display for 1366x768
Message-ID: <Zv6WmOeg7lcHLxs0@redhat.com>
References: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <Zv02EDIKgmq2L0fg@redhat.com>
 <DM8PR02MB81211BB23F192988ECCF4BE193702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <DM8PR02MB81211F01833922F781C21E5893712@DM8PR02MB8121.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR02MB81211F01833922F781C21E5893712@DM8PR02MB8121.namprd02.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 03, 2024 at 01:01:04PM +0000, Simon Rowe wrote:
> Looking at the trace output it seems that the displaysurface has been rounded from the start
> vnc_client_connect VNC client connect state=0x556dce1c1b20 ioc=0x556dce9e1e70
> displaysurface_create_from surface=0x556dce104b30, 1360x768, format 0x20020888
> vnc_server_dpy_recreate VNC server dpy recreate dpy=0x7faa59026010 size=1360x768 fmt=537004168
> vnc_client_throttle_threshold VNC client throttle threshold state=0x556dce1c1b20 ioc=0x556dce9e1e70 oldoffset=0 newoffset=1048576 width=0 height=0 bpp=0 audio=(nil)
> displaysurface_free surface=0x556dcebf10d0
> vnc_auth_start VNC client auth start state=0x556dce1c1b20 method=1
> vnc_auth_pass VNC client auth passed state=0x556dce1c1b20 method=1
> vnc_client_throttle_threshold VNC client throttle threshold state=0x556dce1c1b20 ioc=0x556dce9e1e70 oldoffset=1048576 newoffset=4177920 width=1360 height=768 bpp=4 audio=(nil)
> displaysurface_create_from surface=0x556dce140de0, 1360x768, format 0x20020888
> vnc_server_dpy_pageflip VNC server dpy pageflip dpy=0x7faa59026010 size=1360x768 fmt=537004168
> displaysurface_free surface=0x556dce104b30
> vnc_client_throttle_threshold VNC client throttle threshold state=0x556dce1c1b20 ioc=0x556dce9e1e70 oldoffset=4177920 newoffset=1048576 width=1360 height=768 bpp=1 audio=(nil)
> vnc_job_add_rect VNC add rect state=0x556dce1c1b20 job=0x556dce0ea1e0 offset=0,0 size=1360x768
> vnc_job_clamp_rect VNC job clamp rect state=0x7faa42de53a0 job=0x556dce0ea1e0 offset=0,0 size=1360x768
> vnc_job_clamped_rect VNC job clamp rect state=0x7faa42de53a0 job=0x556dce0ea1e0 offset=0,0 size=1360x768
> vnc_job_nrects VNC job state=0x7faa42de53a0 job=0x556dce0ea1e0 nrects=1
> vnc_client_unthrottle_forced VNC client unthrottle forced offset state=0x556dce1c1b20 ioc=0x556dce9e1e70
> vnc_job_add_rect VNC add rect state=0x556dce1c1b20 job=0x556dce217810 offset=0,0 size=1360x13
> vnc_job_clamp_rect VNC job clamp rect state=0x7faa42de53a0 job=0x556dce217810 offset=0,0 size=1360x13
> vnc_job_clamped_rect VNC job clamp rect state=0x7faa42de53a0 job=0x556dce217810 offset=0,0 size=1360x13
> vnc_job_nrects VNC job state=0x7faa42de53a0 job=0x556dce217810 nrects=1
> vnc_client_unthrottle_forced VNC client unthrottle forced offset state=0x556dce1c1b20 ioc=0x556dce9e1e70
> 
> I'm currently struggling to follow where the width parameter is taken from.

The QEMU VNC code has logic which rounds up display sizes to a multiple
of 16:

  static int vnc_width(VncDisplay *vd)
  {
      return MIN(VNC_MAX_WIDTH, ROUND_UP(surface_width(vd->ds),
                                         VNC_DIRTY_PIXELS_PER_BIT));
  }

Separately, it also tracks the "true" width, but untangling which it
uses where & the implications is hard to do. ie i'm not going to try
to explain it further, as I don't know what's going on without spending
some hours to trace through it all :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


