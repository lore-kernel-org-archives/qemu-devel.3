Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89915CF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 04:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssEZI-0006GV-J3; Sun, 22 Sep 2024 00:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEZF-0006Fh-TE
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:51:29 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEZ3-0000mV-JW
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:51:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so422939566b.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 21:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726980674; x=1727585474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qs5rZ46TcEKYNsXBCBfK6ReHsB3/7m3x4PxTv3KVeEY=;
 b=W8QuY4UmE/ercKCna6JRJ4PIKgSJIDoAhiPLMVOEJpncALpplj6TPLqLZHwozV4mL3
 C59isaWoH/83NqbeNsKsj4rCpAPtOT6bX6kklqfLoY5f6c+3iRcBCbHbJquxJbf8mRK+
 6P59jk/OoqR2bGxJtttoMDGo6ykfy6ZrgQhQWxZHArbCz59x4Z+dJs3ODaj/aHTAYytC
 uUSQlqvq86yDAdiiDZCsaXIw00Nc8kuU0fmVGvPUxsIr2cQX7tY8tVLYG50I32gOtj5H
 vYuV0psUzeX/H7F07ECMiLM2VXH+LId0sQDOq00tY589jj9dOoIuaCII1mn5T+O5EV2x
 aA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726980674; x=1727585474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qs5rZ46TcEKYNsXBCBfK6ReHsB3/7m3x4PxTv3KVeEY=;
 b=ZfKPWwprztItTj2k/9skK5VPN+KSuaRJbZtLBxT3MSCf4aSDG7M1wfL9j3GZ8xdWos
 Y6nV57FMaVnNHd4XFlAEcG+baymTblrEW3KtHBokgn92G7+0/ntv4hqBWWEMVHy2ic6z
 Q4pBwe4st9n2TaHrAHbdCA6evjwcycOMYkNiBy0KW81DCon6wHz0tSGUOUQxbgqUYyrS
 //ZD6DOC7mhbelQPtnvN/ECRBcpo7fU3LcH1imJNU+SJ5KzDTc3vXIioHV11+/8GxkI+
 7FMmFtVGOHp97jTK87GJYC+pdo76c22iEN6TCd5W62kZAvb5zBZZqFUPHf5tI76EC7RH
 Qakg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFFhoVCqU3TlJb6m5SbvmqAVvbxspVCp/fu0v9ieOvMEYJOH3CbBoXHTa4A3G9z8F4jNc6fP4i3+kL@nongnu.org
X-Gm-Message-State: AOJu0YxSBdHOsYbXOThGNuh+5WxRlj5qyO+iZB4m3QJtXAwE+xQ5Ouh2
 iLHcj0n9b5taRMPXRgNkHE5JObvTyMYAFbXCOq3pwlXWK2DThf+2SO0TzU0kRPFuefaalse1Sen
 fdBHriA==
X-Google-Smtp-Source: AGHT+IEmQv2DTAe7oaDfnfenCEIKxTQXsZbStt2El3XomYZaXyKKwxExfd+5cnI0lwr4k/Yd622OGA==
X-Received: by 2002:a17:907:e612:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a90d5000fa9mr648813966b.37.1726980674550; 
 Sat, 21 Sep 2024 21:51:14 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109669fsm1039496366b.3.2024.09.21.21.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2024 21:51:14 -0700 (PDT)
Message-ID: <e7682112-412c-4a1a-9ded-1593d03c8994@linaro.org>
Date: Sun, 22 Sep 2024 06:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/functional: Convert the advent calendar tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240919185749.71222-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240919185749.71222-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 9/19/24 20:57, Thomas Huth wrote:
> Thomas Huth (7):
>    tests/functional/qemu_test: Add a function for launching kernels more
>      easily
>    tests/functional: Convert the vexpressa9 Avocado test
>    tests/functional: Convert the xtensa lx60 Avocado test
>    tests/functional: Convert the SPARCStation Avocado test
>    tests/functional: Convert the e500 ppc64 Avocado test
>    tests/functional: Convert the mac ppc Avocado tests
>    tests/functional: Convert the r2d sh4 Avocado test

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

