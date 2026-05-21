Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E05CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Uv-0000Mz-Sq; Thu, 21 May 2026 09:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ3Ua-0000HW-Rj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:31:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ3UX-0004Vx-JS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:31:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso5166325f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779370257; x=1779975057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wdkQiUdN75GBYYbmH+MsPbC1r9ZIosLYoDKDB9VqTIY=;
 b=k6EMAmR1CjMpODSCoGpuuaVMIl9+dttkXeNp5ipnky0Hb/EoRhq+uwyzd/tuvqt2Li
 evX9cCaPTf2fpc+cHPPBVXmZB74wGumR5LrSWLUtWun7Z8UtFJ7MsMx1MHyVqlDJ5Aui
 0z1QKIqoFRcLx4ZE5MxJZh9zbjigF6oPkipDj5Bhz8ZV0aT3igiVZo9VARq/GtIEWVKU
 9yf9yFXp8jlyppK/p8SyehAaPUtaiQWmP/KezlW1VFzZlP/JQ/rSGewgJL6D1Ecdx1Oe
 A+KH/bCmJZr8FFxR6L2cyEjimkz0RZCywHHJzLf3qlov8WwjFqAEcX8TbTki7YsNRE9j
 6H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370257; x=1779975057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdkQiUdN75GBYYbmH+MsPbC1r9ZIosLYoDKDB9VqTIY=;
 b=mUwM3FHZ+0GD98zLCv9lPUuJQ6M1ijVbIie5X8p1gqwZ1mBd3VG8vI6+tVNKNgUWHW
 F4aTGlnaVB49iGcTkkWiSdypIA2xrsLsVD0gpMnwHgpJHSOuOr1upH3cn2YsGB2lcmP9
 x1JoOZViG1X9JraJoru7Zq4U6VBPh6JRovcphzdZLLhOPK++DZ9126/ESjPQwOokGDuF
 8HFFp1KbzUKFYvEsdMOSJA7XrYsVFNaE4ME0Hhr/aSd97O1h1E++I8SawzEQvB8NGmVZ
 aoh/Ji6EKylgXuZa2v/XHeuYJXvy1Fp90cIuDqqCGQurmyHMrdCWNUHGBz8QGAwltYb+
 UeFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ew2ASkw/LdK2JBS2G73ceGxrL5wnTV9MRCh0MOH4czcl7lpRFpdlzx08piUKqWBSDHV5NKDdwc0Mt@nongnu.org
X-Gm-Message-State: AOJu0YzMlmO1II9rEiMYs9wLBsXQNxFZjEUHBNEAV2lmJTd5QFGh7G59
 5GQOG1ZdgKG+rbyHTylh+poH794xoUKFwXr6NJ9KIQXh1wnVBp9EtbbuzT3OyBFmKFg=
X-Gm-Gg: Acq92OGQILoZ+mIsvtMhI7z8pzdH72wiu9iCqXtt7xyLVO/TUMGsEkNMtZ89xDBCtdz
 fw3B9zz1lAW29TGM1S8ACYSgd+DoaoJLqG8FE7yArEOKeDQA3fvVOWZ/Rhs6rkLT73Jpfg7S1Z0
 EZkcsy1zK5bkSWhbP/HagnNer+YgLAGQCQQPkbapBaux4eCDHgKSKUKiHevjOn1Wj3F9/U3TxlV
 AZBGLedKERz9WPqgngGCn9E4iL0vh1ShYWXSjyzJ+76voCGMq/spKTAxMgNzXLgIiUaimjPIBn4
 ZbIcF3+wcGE7u1vMyG8WmjyXuhOaYU/nuhJpsIsbnsmjifnYBpUQMnNijUvmPMuCjbGIPu92GF4
 tfz18qLd0OY6aKP+TrQRTDVMF/6uVxHpnfKUmQNwDcykz3/WX1Tcv0XXNSUsA6+Hj9VsZBV1eEY
 WZMobLLa+knkjh3v8xIihKULB+j9htd+qAyJ9TVqazvVG0JI9UwtwC2+lqaVdyXvWh+A==
X-Received: by 2002:a05:6000:428a:b0:449:af52:614d with SMTP id
 ffacd0b85a97d-45ea38e929amr4311680f8f.11.1779370256692; 
 Thu, 21 May 2026 06:30:56 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa936333sm2900474f8f.27.2026.05.21.06.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:30:54 -0700 (PDT)
Message-ID: <fcb8a411-ec20-427c-bafe-45e4d01532af@linaro.org>
Date: Thu, 21 May 2026 15:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/nvram: add load_image_to_fw_cfg_file()
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260521112806.504961-1-kraxel@redhat.com>
 <20260521112806.504961-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521112806.504961-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/5/26 13:28, Gerd Hoffmann wrote:
> Function is simliar to load_image_to_fw_cfg() but loads the
> image into a named fw_cfg file instead of fixed keys.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
>   include/hw/nvram/fw_cfg.h | 15 +++++++++++++++
>   2 files changed, 37 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

