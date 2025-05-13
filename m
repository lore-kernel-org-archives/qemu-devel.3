Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB350C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEttp-0008Tq-UP; Tue, 13 May 2025 13:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtfW-00033C-RD
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:43:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtfT-0003jv-E7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:43:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so63181665e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158229; x=1747763029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ImQKxGp/9g4UCviyfMDatpt8s9LnPC896BgSX/2sPow=;
 b=XbH7CRtv56SOpalHSsxLWakSeQNV5vzN3VRkB1UY0RRiWwpAE/68YL+gqtNGhQEC5U
 pyfbE+JP6T0/KDjrXMY3N3V+bzembxT7l8NXI3XILn1XoMMt9QLRF/PotoG9NjR+3T8q
 7Sze5rB5h0y8GVYYvFRUbIqRoxaaYLPl5SLtiet8b7EilHevkwwjAq4cfDOJvgql50Ag
 vPtn0/roJloXn6VVxw68oLzgnGpdBr2NH4dJ5CnHoN8SuK1nm8SRrqWEi9TdODmjNJn3
 Ug2k5eWwvwgRJqvrW8XaTs0TS2GdWYznXxppAN3X64NJr5VjTA7D58iXNObtI/gQ8kyx
 eTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158229; x=1747763029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ImQKxGp/9g4UCviyfMDatpt8s9LnPC896BgSX/2sPow=;
 b=mMN50nJpMMz0w7FVct4a/5Di3zgGMRhgMsgdBUmhOyURahIzP/bdiQIgwSWpU30G7L
 EB9aPrJblbAyg14ZLSK14tqYzqjrLU8TKC+vfDjEnsz72k37emgWUNLeFWcdTEoEJVda
 wRHWgJlLwL5cO3YjIXCIX/1IHn/ugRlDRDPSH0w/q+FtgNypBJxoHRvUheWiQPlO/f19
 GOTQj0zUWb46SQD/x7EDOPigKtMZy0kKX9VfJYY4RhucGs69cqHdiFr92Bw4+SzJjcWe
 DYCDl4xIUP/6R0CG2foNhV3NrIyw83kjy3VxYKZy+2Oq80bc7iYbsUlLH14hezUoYFES
 jeug==
X-Gm-Message-State: AOJu0YzW9NmuFDOnom+UsXN3Nml7zMUSOpVV4Dr5Nno4Rtf+D7M6QzsY
 3DG3LF37KHhdjpjzZDhdT3G4jA2D/Jn2ff7VH7355LhTJocV3yCmZmYpE7Ac9Z4oHz82/Ryxorx
 n2Qo=
X-Gm-Gg: ASbGnctkAPpO/VF4J+VxCBAYUAaF1iJGgnyAkXIsaMbCFaL4wiHfTVKVUUx8zxijIVp
 86D/0ADrrtP9FbfF+GBxVscujyBhHhJoORQIeAU6AgPXwIBEG/OAmkjIgZp1L3MN+p5Ap0gvA1R
 7cmWTgfCvnB+8Jz1yO0LpeJNfTBhdCcWvicwYdfTo3fZih8eH3JR+Fj9gLCIAMiR5DkrJbkHqdP
 J65R3ChxIFDDMyYx62jRDHWuypM3YYymmwParTEovx+oahPFcJEuOtjFGoKtouLWIqmaJck3TFM
 +7eXYcSf1chSdudl8nW+KzpDOypn212ZdpQEXQHjQrTsnewoPAZ2NSL9SQ7v6Zyfv4U21Jwisel
 kHb/thdJlZx68w7BKmsa+z4lHwUSg
X-Google-Smtp-Source: AGHT+IFO0Mp92f+JcJsm+EVrvgo3IdfHU7r1DZX+7tEmNWWi3pRGcqOQV3en5vrWJbrRbrdVc2V1wg==
X-Received: by 2002:a05:600c:34cf:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-442f21683cemr2090565e9.20.1747158229071; 
 Tue, 13 May 2025 10:43:49 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb26sm222152085e9.29.2025.05.13.10.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 10:43:47 -0700 (PDT)
Message-ID: <25730481-491e-4c29-8230-1d5d93b0ee75@linaro.org>
Date: Tue, 13 May 2025 18:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/arm/tcg-stubs: compile file once (system)
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513173928.77376-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/5/25 19:39, Philippe Mathieu-Daudé wrote:

The objective is to remove the arm_ss[] source set soon.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index b404fa54863..e568dfb706a 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -48,7 +48,7 @@ subdir('hvf')
>   if 'CONFIG_TCG' in config_all_accel
>      subdir('tcg')
>   else
> -    arm_ss.add(files('tcg-stubs.c'))
> +    arm_common_system_ss.add(files('tcg-stubs.c'))
>   endif
>   
>   target_arch += {'arm': arm_ss}


