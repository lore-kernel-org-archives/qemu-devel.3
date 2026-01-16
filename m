Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED01C982DB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 16:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgmqk-00040B-Br; Fri, 16 Jan 2026 11:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgmqf-0003zj-My
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:38:59 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgmqd-0008FI-4l
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:38:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so324806466b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768581533; x=1769186333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x4Tc973jOTHABPnQERVMdDzMxzIQZH/UhcGyjpS8qMk=;
 b=pDHEJGo8BFSumjteebPoXWfTgwvsxkC/vD5egWNDO+nyoj4Jvh0OLzpb0WhLL1l6LK
 8rILhb3kIXzOKQM6yVnwyJ1/VSGi0GLGglHdS0S2EuAvYH/67giQ2BqD3S6jyquwQ4L2
 8pi0Ys6suv7GMtMZwnVv/u0SOHCJZoh8KEw5zELHta061RmObncpV7+B8YswkO83R4N2
 n3VmmH/HlEJ2Ad34LhKMTOy+bBG1o9ILSzF4a0H6s+bkT0tw7eQTG5MEpfr5TMzOOG2A
 jTS0Czd2QDRmm4eJwItzOlfhVmoS6l07Ox9ZSQq/d27SdYpuZ5HRRWibc/FPqYpkD+WG
 RQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768581533; x=1769186333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4Tc973jOTHABPnQERVMdDzMxzIQZH/UhcGyjpS8qMk=;
 b=JRvE5EbpbAoBwvL6pLoz1qWU2QvEqJFU5+9d9GYvKEOIjE1F1fxfUZStVE7bNOLK21
 aCk3R07kx7RtJfn3RXwmiyDO9eCdtF/Iev1AmX+sPWIfJCYYCXmAEdAESBYH6q9ToWUR
 9tgjl6RYulgi3Cd0ij1QetDht1W8fyJjuU+KI7gekHf1RmvsvPostWjVFI1joFQY8HlQ
 A5rsd9YPRNt20VKoa8Nb2zHM19jVvNw8EHZ2R14pu+sFhNfrfgUpH6kdpc9l208j01yo
 +W00OyC9mgv9eyc9u4qRGRYxBKkcO8y12NOlPCwZV6GY0VXixbw+Q3ZbsShIAsUnEYWw
 TNpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQG8SG6W8A5aAZJ9RA4AUd35T/6YgMKn4nIXsdtZGir+1D8Hc5uKwH1mC7t/0RMNGHfYVhs5w2Fox8@nongnu.org
X-Gm-Message-State: AOJu0YyjCmYE7TK2D18lbdneVTRhZtnXU0YlGcwfuIJY3GIEs+PeVWLx
 oM9hzu0ltrGvsSjxyTdVDC3azLjv7n+sF5Dg91Xr4gcrEb4ZDaCAa4yzKG8d9ucrfcE=
X-Gm-Gg: AY/fxX7Q4PUpGWWqhLIKw3pdpe2Um0T+ReOTNnMDIotVZN7a3R2atibiY//Zs3eYA+k
 iJhId98cx1Zvr2gNSBs0f6h4gd2BL2Cw6ZdTjON3q4JdU7CexSDUaUBkA7lKTtl6TLGmgo3N+jZ
 IZNz3jK5wnswsieo6wdWnQ+puMEUkcrDCxaY4kr1G9q8nX2pKTPW7Xq9LO4W1SPPogWznZ2Mrc7
 ibKbapbxzrCpkcO/d7RBViKM2O/pBaFCkKpJ+JtHRqB0gpiB35TAn694uVWqaOIMmXspHGPv2ii
 VqF/MS0ff2cmPpXRc1XjZMBVSOMk0d/mAan4vGLrsMlPNect3XU1H8sdV2LJ4ycU+FEQWf2h01M
 P+VRoO600RuHgNIw0PJ9LoltLTqN19UD1FDMBg82kin/jQZbgftWk7VJEjE4AmkNmT7mT3UgRYJ
 syF/qD/aBMfcQ7vrNnANl+kowINdPwFWpuGL9seOCvWukYHoDW+gVZMw==
X-Received: by 2002:a17:907:930a:b0:b87:751:6f21 with SMTP id
 a640c23a62f3a-b879300b515mr326634066b.36.1768581532631; 
 Fri, 16 Jan 2026 08:38:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959f6e74sm277303266b.48.2026.01.16.08.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 08:38:52 -0800 (PST)
Message-ID: <bb2418df-067b-4686-8118-b7a40325b732@linaro.org>
Date: Fri, 16 Jan 2026 17:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 26/26] MAINTAINERS: update the list of maintained
 files for WHPX
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-27-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-27-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> Add arm64-specific files.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9127a82ec3..f03ffe907d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -565,6 +565,8 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
>   S: Supported
>   F: accel/whpx/
>   F: target/i386/whpx/
> +F: target/arm/whpx/

  -> squash in patch #15

> +F: hw/intc/arm_gicv3_whpx.c

  -> squash in patch #14


