Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4E2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8P06-0006FT-0n; Fri, 25 Apr 2025 15:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ozz-00064Z-KP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:46:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ozx-00086y-Pt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:46:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so2439859b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610368; x=1746215168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CMB4I8pZJgG1POAp1KBGtXzRlnokScaA+5SyTQoNghE=;
 b=qO9rcQNNwmEpAVFMI076gEirIwkEB/tLa/scNVMFO3bmzSq63Nc8Jf5QiEn8swjUpn
 jtDVm7r/B+JSF8pRADdOMXoN+fm2eJhMSIMQPyt+0XU5DnYI9zs+cR5GodXpAYi3SVA7
 FDmzWF8h769y6/zs8Os8w53frRSWLWyaEv/TCVSU8A9MRIUQBhuqI0bEWYWYRF9nQws+
 VDXm+J6MFXTy8PEm+QZlEZp79M2YQxMsSd1EK/Djz3wv+9H9rDEq6VJaAC1NdhFBapHS
 zJekImhlf53J5uITBP8LVxKxtFbYHCZvThWzBzp/LKVk+MIw/KROlhK8FyFVRSANHo9a
 4aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610368; x=1746215168;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMB4I8pZJgG1POAp1KBGtXzRlnokScaA+5SyTQoNghE=;
 b=o5cmk9uERWI8sXXqQI9MRTMORXsAFpe1oAxs5CV43htDinreNFxU0bXJYlSMOJnn8V
 jW8++l9q7wrfd4z108HOSN+fK23nqXaKItr2qnqjEPLEHW62WxSKwHRZY6EN1CmAiNxL
 c2/66Go6fl2Ur42k0NEvUfPr7XV/vNplFg/yOA/H9MVKoeeSyB0Kl18DtPLtc+yy1Z0h
 UByr6hTyrHiJsGT4krka9A1M8A6GdQRaXfmPb1CdiCCKu+KasXKWu3HvYW0Gl1VVuWXF
 F5jogncWGoqS6itfJMmFNsxIGHdE3Aa39xltVtvDmXz7w1amq9tRAIwmgEEaxr+hOCZM
 1ZpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrnYGosQ+EsaKnlxnwvPsrW5+C3tPN2zVMB4sK+sIoEyiVSFZQtVLQewBg1+iL+NPtv9O/DDNA8iSJ@nongnu.org
X-Gm-Message-State: AOJu0Yw53N/m3mgaDGBIBLpDwqOcPzb6iK+Xyx63Bl5serObuS02rG+6
 sOt7/AUMcMQE6jC8Zuqt1woi8OlwTV2mY7f6+VMPO/Gu1bW0Ju9PhDDEW2R1RxQ=
X-Gm-Gg: ASbGncudyfpEPwB1r1f9g4MKhMxLYLmbBjiUo/TbipGeyuQQExuzDTEeQ0lKbhpRhqf
 W9EPjlddS3EvUHXhjKuzi5leqK0Sl3RW7V63/MwSnTCaV51o7xeWBPB7wl0d5sbfp6OQbzoEDrL
 DddRn6JraVgTyWFaPCIbKc8Kc7C8BQlXLN9cyJGrwSHoYLBbgQYArrYz0aQiM6o1EFAlRSRtAzF
 Yet4rFjBh7lUDlCsEah+Z+pAm1COJB2pCijL/K4KE+u3r3l/2ROLPP4g4meC572W5XbcJwuDI7k
 /6EziLk6R6yZyv2MotX2PrijJ5xgYTdgbEVvp91SECocfA+XjdLBRw==
X-Google-Smtp-Source: AGHT+IGvnKUJTPpQshCv3BHt8q3Cc31932iiYtHiEVFbd/Qw/1Q/4oPbM5aTy8U/e0ZAYsoqoBKgrw==
X-Received: by 2002:a05:6a20:2d22:b0:1f5:82ae:69d1 with SMTP id
 adf61e73a8af0-2045b754682mr5621326637.20.1745610368041; 
 Fri, 25 Apr 2025 12:46:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259412a0sm3556790b3a.49.2025.04.25.12.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:46:07 -0700 (PDT)
Message-ID: <ef265c67-85ee-4122-8137-f78ddcd4decd@linaro.org>
Date: Fri, 25 Apr 2025 12:46:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h          | 4 ----
>   include/exec/translation-block.h | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


