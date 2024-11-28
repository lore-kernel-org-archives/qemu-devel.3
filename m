Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AA8D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkyT-0004an-TT; Thu, 28 Nov 2024 15:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkyN-0004Zj-59
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:18:50 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkyJ-0003As-U7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:18:45 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7252f48acf2so832711b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732825122; x=1733429922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P7VRDmje80mrxSrRS6Ou3eyEO9NianrFT4SNXjj6PF4=;
 b=blDCaAxv20VpWsFiptmOFLhb1lprLQU8j9b6ZsKMV08+rH2I0cqH5QZzuUWnhxN5qs
 MOg8zSi0esORUeeOyWfhNeb+CreAuosIrvEnM97M1QZ+z/34OCfuDnDSH5Oiq3W9u6pY
 Q99mm8g6opXN2iP+q6N398ISdV+LBqZbFtbvxgdS1BhoYdXP6YeTqC8GmQwibLvzd87s
 ijkpcx0Y9ZBzXZp9n5Lc68d91ybQX+S+fbksvqb+JfMwR5U0e+a1HEiZ8q4PUjJxx6O9
 OFamq6R37UUCTqs1C9XSPqKkH2p/XP1rmMxwr+3CgdcHAfWysnAaeYayOGAMD7McgrTE
 9Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732825122; x=1733429922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7VRDmje80mrxSrRS6Ou3eyEO9NianrFT4SNXjj6PF4=;
 b=CebL+D0KJcgwelcxCgeWgw68CAJHB/3tEZotsi8/reI1QJWNtRuvYi2cjTRsEC4y8m
 U3G2LPCQgkxyEJ9niDPqoJMPv1uR3nGarrLM9Rh+LMN9c/g5OPDL28xcAHvQ3sxcvCHE
 EH7uDu7T57gYl6iMZN6YQVTphWSKa+LLsD3YzA0p48E8oPexIMAiiZGOq1aENVBRxrbc
 o9q6TwBWVLORzcZS+7jlr68l5GiBfloZElIhCzYL6D2fxnuj/x3jkxGYL+z++mkFX5AO
 Ejn/aiDlNBHjYEXZnNUV+cR3Tt3HBNlt21EZGzVLB4o3mB/g8dhMi4iAxfGEC+Wq7LQp
 NNoA==
X-Gm-Message-State: AOJu0YwGuupAn+VUmRmGDqCo/BWO9KEnbA81sn+AU/9AthHSF37K7hZX
 Bg0BU+liUjbw2q/8SHciFk91TK0fT8NUFIj8CD81l3/Irnv0pCuofgiyAntvI+HpG5i31fUizji
 QOq4=
X-Gm-Gg: ASbGnctnREUsafExYbhTi/8imR+SNd33Wnd4tXItYMoeBrSyWrr6++LuzgZorEHLye3
 W9x2vqvK1CuKR2H4waZlbekph6cI/v7SnylL992XKJSfwwMnX0otLUVdlHqg0qTgEbDDEBLKzgh
 oHbkLW3yAhComGIUxn50f0QKFzlxlmQlQJ7N7zea7Pd2vOWop3ERUU/JrJl4Iy73zA1rks6qktd
 rnaSmJ9jNyjlviKD5Zgz8/pzIy94DtE7BIycYLubbjq45ZDocZZrr4f+1dBmchWacOt+T6NDcAG
 JPb2sZaVlS6Qvno4DZ0VrA==
X-Google-Smtp-Source: AGHT+IGgUK727SUUvFIPaTxpdg5ubx2YmiEMFbxErVyFnHBHggw5MO2sKpU8WltenZeqalvHNoN8Qw==
X-Received: by 2002:a05:6a00:4f88:b0:724:e582:19fd with SMTP id
 d2e1a72fcca58-7252ffdd0bemr12617691b3a.3.1732825122094; 
 Thu, 28 Nov 2024 12:18:42 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c2e1b2fsm1765066a12.20.2024.11.28.12.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 12:18:41 -0800 (PST)
Message-ID: <7be5475a-749c-432f-b8f9-dd47bf3efa0e@linaro.org>
Date: Thu, 28 Nov 2024 12:18:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] docs/system/arm/orangepi: update links
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 11/22/24 14:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/orangepi.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index 9afa54213b0..db87e81fec4 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -119,7 +119,7 @@ Orange Pi PC images
>   Note that the mainline kernel does not have a root filesystem. You may provide it
>   with an official Orange Pi PC image from the official website:
>   
> -  http://www.orangepi.org/downloadresources/
> +  http://www.orangepi.org/html/serviceAndSupport/index.html
>   
>   Another possibility is to run an Armbian image for Orange Pi PC which
>   can be downloaded from:
> @@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi P
>   board and provides a fully working system with serial console, networking and storage.
>   For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
>   
> -  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
> +  https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
>   
>   The image requires manually installing U-Boot in the image. Build U-Boot with
>   the orangepi_pc_defconfig configuration as described in the previous section.

www.orangepi.org website is available again, and after checking, they 
don't support https. So this change is correct, and we should stick to http.

