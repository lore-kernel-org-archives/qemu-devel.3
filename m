Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44FFC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnvj-0007TJ-Su; Sat, 08 Feb 2025 11:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnvY-0007QP-Oo
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:43:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnvW-00027E-TI
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:43:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso20314655e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739033009; x=1739637809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYAW9lm31d7puN8vZkuFmuHV0nEKxUwafO59PG3rPU4=;
 b=FYPqWlMTxRsSSshrKatI93K8w5w4V4K48SD5778GCfcL/1mK3t9lovtrVwU1tl1iDw
 g4yEhkoe44jRl9vU3hOw3MKjck+ajemCJ57pC8ix5IGxM2MVET5L2xGhxS6JUw2gx4ce
 wYCPHDu3qCXvJbh9sxKZZPqGRlePwbDzxPUR8aGTfx6ocVVj+sD+8R6fCsAl5V5DMvI7
 9U9EYp5n8sSDGp2J6ICYLzdxwzUMrKAPbCocGX+4mbBQ0jyqvjFLtteLY4u6VEXKqSxy
 UBUk8Yq+gEhvgIlehCt4FMy9usHOxYj6ihOpW+/aDdHrzD2FUJHRsRYq5V4JxPcYxqxd
 x25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739033009; x=1739637809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYAW9lm31d7puN8vZkuFmuHV0nEKxUwafO59PG3rPU4=;
 b=om4Y7XNoGf2akXiPX67E67WirGNju5w+JbjZKTsi4lr+pBgGMvnALtrL963EbJgdRt
 jLD5MtaW8SpJnjF9tjnjHtcO+aWPPnoSh16vR6dWxN2gkCKAMEUULbDAe3zYdw7melaa
 RAWH1EbnyuCNMMeX4aHSJAhlOLqGW/E1HD9GWzzNwH3y6O6BoPSsA/YSLSM4+MQ2X7iq
 SOEVGTusiAuX2zquqg/xD06npsOAjcOe1D0Lokk13E+Ov1dswxyP7jnPls0y9qqWdz9r
 i1rIuh6qxIxaWHq+QCHc7E9UrnSVFF8rpiwXowr/noDJkC8Ls8pm+qah/ZHvSf1Kr9Q6
 OhsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+a5FRbGgpV134bcE4ce6eDweIc1OB4eFRB4I0wsa8wJOl0EXUL9V+qS4DaPDe2stTO82/aljC9ZjU@nongnu.org
X-Gm-Message-State: AOJu0YxGd9KRDkMEJUDMARSy3SaIc/ZDcjf4EcqvT6e9F/Sin4vTPXON
 GlFWhJzzDsns1oi+Yjr5wbL/BJTR2c+D+7QQdcYHmHX4K/UrS9FSPdCB3HKZ8u4=
X-Gm-Gg: ASbGnctt6fVNnuHZ1yJoPJD2qAKclh7FgtD1mi/MNzby3tQ3FdheKR7mjBw51+fnuyV
 NKi74+o9uqKJOFwaRUerAu5e1DEke481+wRXAmFMFNAW0LshOgpP0QB1WW5BK8YOHPWCNALROEg
 0Z+Wrxp1ScL7H//J//O2vEzaagdln7rzwdaJkpXuMeqLwsXmtQjOqE6C9x+xeOkAerd++9MYqnq
 ezUkGHlNWCD9iuFRMmPqtgJfqvZEbaTDnuMT5GkXbXQDcC1ym11L1wXBrK3P7BOsBA/p6G/mcvz
 8Syw730xBWwoA//7EXs8B/iAn0zVSieK/RmilDM+wAwrxUOENw3Buatz/yk=
X-Google-Smtp-Source: AGHT+IGJmY+tnkgtwXlK4rUU852sr+PhGqhr289V+yh1TxxqT6afSPwtYqewQg6ageGLIQtIRo5Hig==
X-Received: by 2002:a05:600c:1f0a:b0:439:3ba0:57d3 with SMTP id
 5b1f17b1804b1-4393ba05928mr2763565e9.19.1739033009278; 
 Sat, 08 Feb 2025 08:43:29 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd7fd5sm88454695e9.35.2025.02.08.08.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2025 08:43:28 -0800 (PST)
Message-ID: <78cd1ac3-79d4-4466-b029-c64922932782@linaro.org>
Date: Sat, 8 Feb 2025 17:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250207210655.16717-1-richard.henderson@linaro.org>
 <20250207210655.16717-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207210655.16717-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/2/25 22:06, Richard Henderson wrote:
> Require a 64-bit host binary to spawn a 64-bit guest.
> 
> For HVF this is trivially true because macOS 11 dropped
> support for 32-bit applications entirely.
> 
> For NVMM, NetBSD only enables nvmm on x86_64:
>    http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content-type=text%2Fplain
> 
> For WHPX, we have already dropped support for 32-bit Windows.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


