Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8F2D70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGikd-0003vq-2z; Thu, 28 Nov 2024 12:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGikY-0003uo-T8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:56:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGikX-0006Vx-1T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:56:22 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a90fed23so9457385e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816579; x=1733421379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/WAsQwXTsevHKc7ghpHBk1f9ot2yxpaAYTIfA0Cai0=;
 b=G39EVp9SyBot3QrKSdUYzxyQkwG2aDXMF76PnXdtD3zdvmRLx7hSBNzx+7cQ7MdBtd
 kVHqBYmd6obO2jlL+uL8piVg8zuPUiNHqBY3KcPreTFejUxHxdkN/5W+iWI7e3DqPwO8
 gD7c5YH5wMIUiG8TpvZtfvGFcFWETzoKIgnNPgq9QM4dFAS5SvQwfaAt7zrkkBuT/sqX
 te2AuTvQWbxS82Ec0rnkKznSpaiYOGdMHdsuBlrj9wZYLYW4+xaVLKtIzhDz5GZbma1C
 OHQgdqd0O8PopZiwUb6YeHbwwswZCVgR/SeCJ5SwP/i4oIdyEMl8t31VOM0cPe0oDmpl
 iJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816579; x=1733421379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/WAsQwXTsevHKc7ghpHBk1f9ot2yxpaAYTIfA0Cai0=;
 b=QC6HqohIIBveIk5A8z1ZJkLs2bx7A+EvD0fU3axurqyPqcVBoIlnk2vRFLeYaRW+NW
 NIxml0UCq6raQdF4Y+pTr8u6wjyC73VJQzXWiwXMAUJgrUaP/bXqdoDgBkO4xSghsNaL
 gckvoGmkx11+shafw/5iJIj/VVc3yhiNTYfmVAtKJGuHMRnKDZb+Pwiz5Mg41zEjpy+5
 lxt8XKJXi5b4K7od8cw/men9UMRFsuQdq8pl0gjsxZ5A7sNWdJ79SEzoiVfqtl8mNNVE
 UkoDPdBnW+1sRVFtolhkY1TdwABkvf/nE9TITDiVVvqtncbPwXSO1Sb6MBIdqBaygQrB
 afNw==
X-Gm-Message-State: AOJu0YwlA2D6cmbqwCQbq09ISqoq8z/wHd+R5VTxQwIfy2wQLDRDIASY
 KErKQxZ+ts35xrT2kE2Lp+RO45f5rv0+aNdCIIWU8M4S943eqWzIRojo8R7/UaTAGOxoP+EZIMt
 n
X-Gm-Gg: ASbGncvFNfiIBYeEsg6Mon5NGYSLdtLQmQf3galJMjYcfu3Tc3707d73X+aMg64swtb
 bVRUpQnrfK8YnPLfh8RmFlXGbsPFiCIlnrxsuBnXvJ7YeIJvFFhnXEyUvF72JQAYqmkdizBYtmK
 4GUON/AqEBLyZ5yR+gR5YwR85on6VDFw9+K48LSOH8KaAy87c+qigaKrNeHgIMGvGwkzeG4ZGPE
 QHMoGdWNstvd6kWxyn6ctnoqDZ0ThYi8OnZo3cfhud7UKwcWsvGDNvxPTEiX3plry/B+MSJ2LGs
 Z88F4fbXR8NeX+LJaP5Z
X-Google-Smtp-Source: AGHT+IH0/2QjQhxMmATkUsypvuc3AJLrdA9EnQbjmRkQETWhHQ48M90w6hnGwJu3Egskp/lXiXq1fw==
X-Received: by 2002:a05:600c:3ba6:b0:434:9e63:faff with SMTP id
 5b1f17b1804b1-434a9dbc41bmr76672475e9.2.1732816578903; 
 Thu, 28 Nov 2024 09:56:18 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d1a90sm59913365e9.32.2024.11.28.09.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:56:18 -0800 (PST)
Message-ID: <2b366ba7-e786-418a-bfbc-209f1db00037@linaro.org>
Date: Thu, 28 Nov 2024 18:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vga: Do not reset 'big_endian_fb' in
 vga_common_reset()
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20241128175223.15604-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241128175223.15604-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/11/24 18:52, Philippe Mathieu-Daudé wrote:
> The 'pci-vga' device allow setting a 'big-endian-framebuffer'
> property since commit 3c2784fc864 ("vga: Expose framebuffer
> byteorder as a QOM property"). Similarly, the 'virtio-vga'
> device since commit 8be61ce2ce3 ("virtio-vga: implement
> big-endian-framebuffer property").
> 
> Both call vga_common_reset() in their reset handler, respectively
> pci_secondary_vga_reset() and virtio_vga_base_reset_hold(), which
> reset 'big_endian_fb', overwritting the property. This is not
> correct: the hardware is expected to keep its configured
> endianness during resets.
> 
> Move 'big_endian_fb' assignment from vga_common_reset() to
> vga_common_init() which is called once when the common VGA state
> is initialized.

If 2 patches are preferred, this part is:

-- >8 --
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dce..b074b58c90d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1875,3 +1875,2 @@ void vga_common_reset(VGACommonState *s)
      s->cursor_offset = 0;
-    s->big_endian_fb = s->default_endian_fb;
      memset(s->invalidated_y_table, '\0', sizeof(s->invalidated_y_table));
@@ -2268,2 +2267,3 @@ bool vga_common_init(VGACommonState *s, Object 
*obj, Error **errp)
      s->default_endian_fb = target_words_bigendian();
+    s->big_endian_fb = s->default_endian_fb;
---

> 
> 'default_endian_fb' value is always target_words_bigendian(),
> remove it as it isn't very useful.

And this one (cleanup):

-- >8 --
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index f77c1c11457..5dcdecfd422 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -137,3 +137,2 @@ typedef struct VGACommonState {
      bool big_endian_fb;
-    bool default_endian_fb;
      bool global_vmstate;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index b074b58c90d..65698923daf 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2118,3 +2118,3 @@ static bool vga_endian_state_needed(void *opaque)
       */
-    return s->default_endian_fb != s->big_endian_fb;
+    return target_words_bigendian() != s->big_endian_fb;
  }
@@ -2266,4 +2266,3 @@ bool vga_common_init(VGACommonState *s, Object 
*obj, Error **errp)
       */
-    s->default_endian_fb = target_words_bigendian();
-    s->big_endian_fb = s->default_endian_fb;
+    s->big_endian_fb = target_words_bigendian();
---

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/vga_int.h | 1 -
>   hw/display/vga.c     | 5 ++---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index f77c1c11457..5dcdecfd422 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -135,7 +135,6 @@ typedef struct VGACommonState {
>       bool full_update_text;
>       bool full_update_gfx;
>       bool big_endian_fb;
> -    bool default_endian_fb;
>       bool global_vmstate;
>       /* hardware mouse cursor support */
>       uint32_t invalidated_y_table[VGA_MAX_HEIGHT / 32];
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 892fedc8dce..6dbbbf49073 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1873,7 +1873,6 @@ void vga_common_reset(VGACommonState *s)
>       s->cursor_start = 0;
>       s->cursor_end = 0;
>       s->cursor_offset = 0;
> -    s->big_endian_fb = s->default_endian_fb;
>       memset(s->invalidated_y_table, '\0', sizeof(s->invalidated_y_table));
>       memset(s->last_palette, '\0', sizeof(s->last_palette));
>       memset(s->last_ch_attr, '\0', sizeof(s->last_ch_attr));
> @@ -2117,7 +2116,7 @@ static bool vga_endian_state_needed(void *opaque)
>        * default one, thus ensuring backward compatibility for
>        * migration of the common case
>        */
> -    return s->default_endian_fb != s->big_endian_fb;
> +    return s->big_endian_fb != target_words_bigendian();
>   }
>   
>   static const VMStateDescription vmstate_vga_endian = {
> @@ -2265,7 +2264,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
>        * into a device attribute set by the machine/platform to remove
>        * all target endian dependencies from this file.
>        */
> -    s->default_endian_fb = target_words_bigendian();
> +    s->big_endian_fb = target_words_bigendian();
>   
>       vga_dirty_log_start(s);
>   


