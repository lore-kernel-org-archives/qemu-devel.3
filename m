Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD13CC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 02:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAIG7-0001Br-QN; Fri, 25 Sep 2026 22:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAIG5-0001Bd-Qm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 22:35:25 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAIG3-000425-Ov
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 22:35:25 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so541053a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790390122; x=1790994922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YY9Uvkb1TMnwP6/3PZEkNOrqxkmz2FbExtoncGIFJFU=;
 b=MHhjDwrhYy0mHvZAu29qfnaf3Bh9ufBTGu/83MRv4Af5lvURgxLhcE39RGi7X5lyQT
 dCRLGfKDMv3dHgs75gwsNFzuqVvOYej3YZekwlF5RnzBsirec3/XSfQYTZFxyHFe1Npf
 G2sXGRftpk620mEfwlyXIy/Id845ZEww6wzUYU7QjxuoxNjdsoSUbwD/Zsb42SjEgjuI
 b8mC2A+N3aEZbG+siExXG6N+7mrvWkyyy6zVox6Q/hMEvshjXNnVS/tQzNRYlATn2mao
 CrjbiQaqhu65vopPK7BGd5axH6TEXLJbnRYe8JdM8D40S7rC4sXfJDNytRhRalcQi1kh
 4Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790390122; x=1790994922;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YY9Uvkb1TMnwP6/3PZEkNOrqxkmz2FbExtoncGIFJFU=;
 b=C8NOrHfOB780f1Qq+xbufpMWP13LKl7PhVxNl4CmpUAyogfu4g4ccwiW9Owz3zlXbN
 ZIksfxmBwMaqu4Vz2Q/nlECsPRizXM9ZgFTO/8cWiCjwJU8GUTGPWwBRXXmTLt5Hq7MK
 c515kxqF8fc8syFVsVGl277xvb0JuyJOg7sdHZ7AGM5RFHUFg2/21ik6tXRuFXJgzgdU
 vgE7VrTCCJ4kc+YtV02CEs+5QnY1tjeNKkcqeNhZz/FSsx9S/3tlqVROJD2bZRPra4QJ
 W6qHl+0yUj7TM81XZ3PQpmh1jnsznQT3mQCBka4S5XN63HILAj4l2aUT+e+AYdTQ4GiM
 /u5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxzhwc5+NuiO2aCIUTgWyXZlxMmUPA4FJTAwRHlZUN/bxdmG0wSYalnzLgPreXn0UjV4gH6IJUnvlS@nongnu.org
X-Gm-Message-State: AFuF++nrLxpqdYr6wDzIVLjxQGmnSsHRtHAa9RZih3yBl/jxrXkvLkRM
 CHlQ7rDK/RA62W41gazHbpQh/14rRv1QXEOWPMoBDk32sjcp2quxshZFhw0ur4dxpm8=
X-Gm-Gg: AYBFou2dl6i+JUJZhYo1o32Zz5Zq697ySQFtL+Uh5ECPjnZXhaPfmgAf6svuedeS/d2
 jHpRDOa4s/TQasAC9rz2t7OTlFD2Df9iEQZK1apZ29hXC2RO3Lai4XTY0IO1aLzhymM7QGYYaxX
 aOFC2GJrE8k0HemLBV8h8T6avj7G8odn5afiAB/mwzfjhy2Yqz0eNACboeC6XSSFaJVwmST4N6+
 0l4mZr7F4wQL4foHapczMXln3rbltFzN/iVkcmvAlwqxdOtp/V1c+sYHG/v8hjM+3MNvJFz+GdL
 udNo94yJs9d9hkd8lZQbLEJ1MVTjtz8Z3+nlhfKEw4tWWWwIq8ko2CjLfFf6tUWFaC42lvxDD3g
 g8Xzj/GFu2AVMGnmz/ho9mBKeSstRu0mzehzfXx+LJ3YZFj0O74VMUmlgK58iScD7x2wIJIxs76
 WobqXbqbuPEXMyzHCPhyMbt4nZCmuqxEXgRqES4If5qahAOUvx4K+EfC4jEbP6aocXxg0f6acAR
 rliyxyO8dx59FtL7c8dQlORVCgTOYDHvk+5XJSi
X-Received: by 2002:a17:90b:564d:b0:39e:6c66:cbdd with SMTP id
 98e67ed59e1d1-3a098acb900mr4373327a91.21.1790390122032; 
 Fri, 25 Sep 2026 19:35:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c3f74e5bsm5478923a91.5.2026.09.25.19.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 19:35:21 -0700 (PDT)
Message-ID: <17d2b653-e32a-4c0a-b035-ada9e9762360@linaro.org>
Date: Fri, 25 Sep 2026 19:35:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/tcg/mipsel: add float reference files
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-5-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260926010053.2840-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/25/26 18:00, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mipsel/float_convd.ref | 988 +++++++++++++++++++++++++++++++
>   tests/tcg/mipsel/float_convs.ref | 748 +++++++++++++++++++++++
>   tests/tcg/mipsel/float_madds.ref | 768 ++++++++++++++++++++++++
>   3 files changed, 2504 insertions(+)
>   create mode 100644 tests/tcg/mipsel/float_convd.ref
>   create mode 100644 tests/tcg/mipsel/float_convs.ref
>   create mode 100644 tests/tcg/mipsel/float_madds.ref

What are you using to generate these?
I noticed that you did the same for other targets.

If the answer is qemu... that's bad.
This really really should be from proper hardware.


r~

