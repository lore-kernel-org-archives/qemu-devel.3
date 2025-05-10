Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E697C3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 04:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDcCB-0001wm-Bn; Sat, 10 May 2025 00:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDcC9-0001ul-QV
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:52:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDcC7-0007ox-I9
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:52:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7423fadbe77so1351118b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746852733; x=1747457533;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XzYIUcRqRCX8sgQOdVRbXsqbqNFycehqiA1oMJq6YHM=;
 b=Ynn7A7ocF29HxtKUAsriQHiULIvOOdiOFNMWoVu9wlawOCfSafSTjL4jaFDf88CThL
 2Fn7S1nFa+pCEAXzL69rYDmbNkcMzrBxehStA6PRWQD3URLjvgNYuxxpkUMhTo3kNiau
 OBfehEpKeAVi9NgmM+0WSjJUyhRTWs8/5tH8n0F+FxSx+bK+KdEjjxiyYrMQxEA3gw3a
 Llb6QTPJbqS6SHAqBPG93Yj/ahlzvWuUS/GY5W3g90JOW36OjnDaMzp9N67hXHu5LkM0
 5i3+BbUFjU5WuFjNVCmAyzxYIbbkivLWx64KnHut7Wd520XnKU6Lm4q+xhS03/XuMzfd
 yyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746852733; x=1747457533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XzYIUcRqRCX8sgQOdVRbXsqbqNFycehqiA1oMJq6YHM=;
 b=D1MOqi3mZU3w6os6yVSl2koD8c7l5dZ+zOJ/5zc/lVHvyyZCvkaAOdzGhqi2vTFKjJ
 37iFAStLgpM8UT/PHhCHfEJd8g+5xLwO4qzua7y8L0SGazTLNT0GddxYYt0ouqkqSR9q
 rtVCwRLMkJZOcHDaC16Tj77Bue+FF6OJKnd/w9ij45ohx9dWis+WrRZ+fuCjQoH8yNe0
 /CXNchHpp/xyNrxcxemfmmM7jV718QD6HxCkAnrMJANaia/+yj2svjZFvTxGgIBhcFLc
 J/+/PS3pM9BHEAxmCXLlWpZJG0jwjb3UhXO9tEbQA1ymZo/qBTSEs6/T/Of4ws+MXvCd
 qRTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuyM/M0NyElYsGe7aiFxhov/lc/4EeCunXPjfx8PciRENTgVHpr/bn002aew7SGocIf1fAwD9mwylm@nongnu.org
X-Gm-Message-State: AOJu0YzxIWJffwo7duQNxvlFVBaGiqLYIBqpmcqBePxoN7DwRIygtsFM
 3xCaRUFSYkipIf5hQPPzxR3pgYpvvGHe8WQiatzrR/1uyLITG3nC+UwFsLpL8Rk=
X-Gm-Gg: ASbGncuU/F540PPPQA8BjD5PyyAryUW14BqnEmyXFLtR2UcWdW+BH/OGmovD5vhgvF1
 1K3FeH3uMM2jhMESudFPoqqXk7/NYFWPCzkx1KHtgsPtWzGwTrzgTxdMnBgxDcBUo3HKDBBHPVi
 gD0Uc1UejDHLhsoiHK5eDot7VGcAvQpW8Mr8jZNjH1eDYEiw4YQhYSsegJHEHlU/ONSO5XOnXPD
 7aOv6kseb6aBHhTR6WOw4Dhi/6+2txuMkYPEhJ2r1cCBbeTZoiZyQdZP+rGiv8Ko3LLDRrkZFn9
 nf+fURQKT+LkA1FsBFYAvZS3Ir5NB5GumUgCJRluVUNqFxL21T/2dcrqVN0m3Q==
X-Google-Smtp-Source: AGHT+IHqVau87F90b1MQBIqhBECvSsJ/cvy04ceTr267TwBmYwsKCr8ygZiql9RVndj6kprrLAOecg==
X-Received: by 2002:a05:6a00:4fce:b0:736:b402:533a with SMTP id
 d2e1a72fcca58-7423bc1c81bmr7511854b3a.1.1746852733529; 
 Fri, 09 May 2025 21:52:13 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3d3e9sm2529326b3a.125.2025.05.09.21.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 21:52:13 -0700 (PDT)
Message-ID: <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
Date: Sat, 10 May 2025 13:52:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-13-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250506125715.232872-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/06 21:57, Alex Bennée wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
> which causes some guest display corruption when gtk-gl-area
> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
> simulataneous accesses on the guest frame buffer by host compositor
> and the guest.

Simply reverting the part of the commit may re-introduce the problem the 
commit tried to solve, which will be a regression as the commit is 
already included in releases.

I guess the problem is that the gl_block callback of GraphicHwOps is not 
properly implemented and it is what should be fixed.

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
> ---
>   ui/gtk-gl-area.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2c9a0db425..9f7dc697f2 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>   
>       if (vc->gfx.guest_fb.dmabuf &&
>           qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_gl_area_draw(vc);
>           return;
>       }
>   


