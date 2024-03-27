Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF51C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 05:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpMFv-0006MA-K5; Wed, 27 Mar 2024 01:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMFf-0006Lj-Q3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:55:07 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMFe-0002ls-1r
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:55:07 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e677008501so3805024a34.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711518904; x=1712123704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HTkYzbgdkPGsy4gW6/ZAK1JRzHcgv/waMQAQwnYgpXE=;
 b=Rdjca5pLnU7ec1JoCl5VR8SXq3p8iF4w3OmX1Zx7qhia4znbTM0ME32RPFJVdiy6qe
 ai/HMhJ3Eq/Tih2FTRrSxt1kzT99zbjGgwjm47zrferPCPcmI0kxlolmDBbJn4zZ2TZr
 vep9x/g6H/y8uYpFWXV+0wD4PTFjdLlVjo8IZjp3kYdL4GcBjsrkKlCBUUtNZYM//rRu
 LYuEnF1ttgdHDgx6e+8OdRXVM6pzvMcyWmR0aB2CkUumcDa/kMv21CPWZRo4LdpQHlPY
 yn2EYi4yDp/A8DPfrqcH3Ye4NGzbFu04ud5tAYfbmo78/dXQT8WDlCRKY5mvHK3NHzwE
 riJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711518904; x=1712123704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTkYzbgdkPGsy4gW6/ZAK1JRzHcgv/waMQAQwnYgpXE=;
 b=Gwe8OL4eZKgA6syjdnlsBpoiM5ZKUC8TO6+w89oedD2wgXwpwzjFUbBOwm09cYgWiN
 HHtz8hdX753RGOq381XLNk7FsEo2FKab803d0UJziz46JaRUJkwKWup9ndAbPVNUDURG
 kSD7Qxoze5cYkuvVG0sj+t/fsLpkLyGrLeLaajxznoQwPmgMIuLS7SB6jIs8kjzjD2Hf
 NIBcx8FgNub2xBetsZOsnbpLgNpDuQM0CNko8FhPD1ZNRmaHbD71tBPdUL36pDW1PFNd
 Lh82lvg75hFmkJ4qJYTrup5BhtVx3yZ4g2/DJAbrABiTr3q49I7pXIf05XbHSYlc5Spi
 aTzw==
X-Gm-Message-State: AOJu0YzCQblphkpdqfwwlCDftvCAfrLaYIqHdIPdC7/I9qh6vlKaIOUD
 SEN3yyPsRWZBMYIKRWofoVGPnrWhrk1wzUwqyniO2ZF1QkKojkcPgRlL776IPhE=
X-Google-Smtp-Source: AGHT+IEeLX+gxaAdy7hKLweM2es+NVEsa0/HVoac7oA1TbVVeVgr1vjYpNk06jukzkGPi24tkowhPQ==
X-Received: by 2002:a05:6870:d3c3:b0:229:faa9:3b35 with SMTP id
 l3-20020a056870d3c300b00229faa93b35mr239961oag.21.1711518904439; 
 Tue, 26 Mar 2024 22:55:04 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b006ea92de360esm7226701pfd.93.2024.03.26.22.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 22:55:03 -0700 (PDT)
Message-ID: <12d255ff-476e-4e39-a8bc-4878d8d34447@linaro.org>
Date: Tue, 26 Mar 2024 19:55:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user: Fix shmat(NULL) for h != g
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240325192436.561154-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325192436.561154-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 3/25/24 09:22, Ilya Leoshkevich wrote:
> v1: https://lore.kernel.org/qemu-devel/20240325153313.526888-1-iii@linux.ibm.com/
> v1 -> v2: Remove an unnecessary ifdef, add R-Bs (Richard).
> 
> Hi,
> 
> I noticed that while shmat() now works with /proc/self/maps,
> shmat(NULL) got broken. This series fixes that along with two related
> strace issues, and adds a test.
> 
> Best regards,
> Ilya
> 
> 
> Ilya Leoshkevich (4):
>    linux-user: Fix semctl() strace
>    linux-user: Fix shmat() strace
>    linux-user: Fix shmat(NULL) for h != g
>    tests/tcg: Test shmat(NULL)
> 
>   linux-user/mmap.c                            |  2 +-
>   linux-user/strace.c                          | 10 ++----
>   tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
>   3 files changed, 42 insertions(+), 8 deletions(-)
>   create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c
> 

Queued, thanks.


r~

