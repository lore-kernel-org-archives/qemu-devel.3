Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2238CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrcB-0000ht-W5; Wed, 17 Jun 2026 10:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrbx-0000fz-7R
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:51:32 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrbu-000800-4W
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:51:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36b9033d230so665366a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781707879; x=1782312679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PgCd/4GxURHeAz7IuvCEm+VuBVwhUt8Q3RJle5L98es=;
 b=w4eJx2ROgduuNY2yoBjdYLkgtT28+hCjaaxcAO/PJuCxKtWJ6vBoO3Wm8za/pmf2Z2
 82+QkaVNJmFwiDcRUIZCuDwGWxZTTz7A6I70ICcbMnF4xUuCPpin1lY7twcqdJqL2dGn
 Eqf+5W3ely/Ahn7j3e/JSTRZ8i7PYYOn9fXDuMf3f4kN63B6NUmDqLDuGMWKm0wxhp0u
 p2XJ/EiMItHZM0Jn69CjcOi3EAiKR5UeM5bcJYzh/aTMio47CxGhd+7esOGuzTUe4o8k
 p8Oz95wr3NhDrSpvDuVxM8xBt5gGIArtKXPlSR54pMUlwO9QNgrNiX8jXOBrt07KnvFn
 Q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707879; x=1782312679;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgCd/4GxURHeAz7IuvCEm+VuBVwhUt8Q3RJle5L98es=;
 b=FR9bqejQfK7dK+hbvQY0EMz4FvxwqkmiycHKs5hwFEWKwAmUHM4pIyzr31sZPBCzJ1
 1OHcdSseOcjFS+psTDDD4xCzqZGthACrb/UKEkbJw09RF8gL291iOhuv3qavJkC8S5pG
 XkVc2JmVJIqOqtXDv3n9Ong/fp8q1hnRAo+78NK0tuEjanfkK98oSSGDo6A7f2LwJ/i/
 1iY1FFVQKvb1ByfLJwxTck7jre5LNNy1hWtv+rRCXtZA8uNKruysVbk1CK3U6zW/H5xi
 mJti9GL3hNFZSOge4NGHbq5RXmIF+n+6a6l1xwmvEpv9HJoT+Wd+eUI2VYDz7AtMNxXs
 bHwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PcXveir69S5OxRqqdkzhC891p0k3ZL9i7CzuwjVJlTNKTjDoA2XdDxa7QLB8MOwwgPGB25Fgjj5Ae@nongnu.org
X-Gm-Message-State: AOJu0YwZGbevkznAkj7N2w+sG1egQZnjh2LqAZ5OOvIrgV0EILY7krkE
 kIqXeDri2VDaXh6NA+68fhbL5NcKRqtcNslVKIyMVyLydBtnOADsuBPAdlHmTTDr21s=
X-Gm-Gg: AfdE7cle25iqGMdRDC5jpD0UH344VFtPCP0Qyo5vDsu7oIBKEeB0tLhV6do4CvbCdR3
 BuHAqGk4rEN5FCaAPLhJXI57h9w16KfHmR2cBhjNPPgTgmD2SzSM+ewV++4+ZIMA1LAQnkufFgh
 ZovZDDIYqt4NHX2EnhjHrQDNr8dlrCwpwbm6kZvWYaDrGwU3L2fkz4gA3mmTVPC7jBP04ouPztI
 mH3+yFzccR4szzLXvMv5S3kc25MceCgj+nLLXgJs4zc0N15lOYzi97hL1zloIPEgXiNrMJmQZHX
 QA7tZHBCSEOY8uSlRgBz31NNjkvI/PyCgVPpHuHmgr8sR1pi1/XLsiSf3f4Hlm4LEiXcAU48RvS
 1lWeYpKlw0Eg2OwkpHUvWxE21bC1YvwzeJRRqQCjfj3O683gWHqyWR2GmmFfZQfyElu+6VwAqQT
 HGjDb89kHQZCj4rTGPlLZXo8CNzQgMJ2JT+azVWQ92gKAcKAjFrY/0bzQyOEXXSZAKO2kE
X-Received: by 2002:a17:90b:3dc7:b0:369:1dbb:4732 with SMTP id
 98e67ed59e1d1-37ca57ea688mr2490514a91.0.1781707879424; 
 Wed, 17 Jun 2026 07:51:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5228ebadsm6164613a91.10.2026.06.17.07.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:51:19 -0700 (PDT)
Message-ID: <f96f7eeb-b22c-4549-be5b-85ed8bb526f2@linaro.org>
Date: Wed, 17 Jun 2026 07:51:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel/tcg: Remove cpu_loop_exit() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Last commit removed the last non-TCG use of cpu_loop_exit().
> This method is now only called within TCG files, so we can
> remove its stub for non-TCG accelerators.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/stubs/tcg-stub.c  | 20 --------------------
>   accel/stubs/meson.build |  1 -
>   2 files changed, 21 deletions(-)
>   delete mode 100644 accel/stubs/tcg-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

