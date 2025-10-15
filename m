Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43ECCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 03:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rsZ-0001gg-Ia; Tue, 14 Oct 2025 23:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8rsX-0001gG-Oe; Tue, 14 Oct 2025 23:08:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8rsS-0000ar-4T; Tue, 14 Oct 2025 23:08:40 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59F38F4i071623
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Oct 2025 12:08:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p1vcXgX5LNI6ITg9XBbxTtiGbtgm053qEaIMZUweLEI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760497695; v=1;
 b=S1c/jl1xqHkRy3IYQyl/kXleFXvrsQ6eKx59k7u5f9PE4vwFMchIuDBgmykBXfuK
 07N/vvYt7xF5FzkLJPg71d70TniQnDVxIHdfj2LC505/qxDrf0ANFPIsZNpGcxIi
 fI8ilSAtrAVkwQ4f9O4ZbAVHVqs5RzdKXzh/3f6Dl3IQXkEE4puN7YrC0yB3GOAK
 dm5I8H2F5ef9ci3lpR6XgNpZXNF23et/lNrZLxXF6XM21bg68a9h5rj6Y+Za52Rc
 /maBZq3JFBRJNIjx1JIwooly4uS3dCWumpJTez64+JZa2+/nxXK/UfibJI51lJde
 v3u24wvEi7+RwKovhC1dCw==
Message-ID: <72228a73-c465-4c5f-b557-0e319e99d7b5@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Oct 2025 12:08:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] ui/gtk-gl-area: Remove extra draw call in refresh
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-stable@nongnu.org
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251014111234.3190346-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/14 20:12, Alex Bennée wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
> which causes some guest display corruption when gtk-gl-area
> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
> simulataneous accesses on the guest frame buffer by host compositor
> and the guest.
> 
> Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   ui/gtk-gl-area.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 05fc38096ec..9a11c9b4d18 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -165,7 +165,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>   
>       if (vc->gfx.guest_fb.dmabuf &&
>           qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_gl_area_draw(vc);


I suggested adding code comment for the lack of gd_gl_area_draw() here a 
while ago but it seems it is missed since then:
https://lore.kernel.org/qemu-devel/63911dcc-482b-45c5-9468-120ae3df691b@daynix.com/

The removal of this function call itself looks good to me.

>           return;
>       }
>   


