Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94494C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 11:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uERfT-0004u8-0Q; Mon, 12 May 2025 07:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uERfR-0004tt-8D
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uERfP-0006rc-Dl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747050594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBISqYsfN7Jhc6Lp50EBb17F+PJpNgcGGOBpiOwIDi0=;
 b=W9av33GvbQ/rnA00z7fFuzDwvYer8JQ5qyJ8PdK0RXSw3lEZNUtVM2gfdPP9FJd+6abh2p
 Q9t7ajsWEaFUBFVHlVPF4V3TUN4ruT1uyEtlkTpWLKhV8vWFw4iabdEofrTnMxf4dg8uWh
 ygLqqVOSDQjH6OUbgpowBIxQFD0Cvmw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-iH4m4HAgN6amiodGlCEjFA-1; Mon,
 12 May 2025 07:49:51 -0400
X-MC-Unique: iH4m4HAgN6amiodGlCEjFA-1
X-Mimecast-MFC-AGG-ID: iH4m4HAgN6amiodGlCEjFA_1747050589
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4580F1956094; Mon, 12 May 2025 11:49:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39ED319560A3; Mon, 12 May 2025 11:49:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B385F180038A; Mon, 12 May 2025 13:49:45 +0200 (CEST)
Date: Mon, 12 May 2025 13:49:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Subject: Re: [PATCH 0/9] ui: Improve scale handling
Message-ID: <q2626emzm3vbdtllumqnhi5g2fikiwlij6uwaswruocucpi55n@kyff3kn2azjt>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 11, 2025 at 03:33:10PM +0800, Weifeng Liu wrote:
> Hi all,
> 
> Now we have quite a lot of display backends for different use cases.
> Even in the context of gtk, we have various implementations (e.g., gl=on
> vs gl=off, X11 vs Wayland). However, behaviors to users are not aligned
> across the backends, especially in the part of scale handling. This
> patch set attempts to improve scale handling.
> 
> We have to deal with various coordinates due to the existence of scaling
> in different level. Firstly, in desktop level, we could have a global
> window scale factor. Secondly, users might set a zooming factor to
> adjust the size of guest content in scan-out level. Consequently, 1) the
> buffer from guest, 2) the host window and 3) OpenGl drawing area inside
> the host window are in distinct coordinates. It's important to define
> these coordinates and scales unambiguously and use a consistent naming
> convention for variables representing different concepts. The first
> patch in this set tries to achieve this goal by adding a document in
> gtk.c, and the next patch (PATCH 2) attempts to align the code with the
> document.
> 
> PATCH 3 - 5 fix bugs in mouse position calculation due to not handling
> scale properly, for both gtk and sdl.
> 
> PATCH 6 align scale update logic in gtk-egl with other implementations.
> 
> PATCH 7 fix an issue that gtk window might keep enlarging/shrinking because 
> ui info propagating to guest not considering scale.
> 
> PATCH 8 and 9 align fixed-scale mode behavior in gtk-gl-area and gtk-egl with
> other implementations by adding appropriate padding to the window to preserve
> the scale.

Series:
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


