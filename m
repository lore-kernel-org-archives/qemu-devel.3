Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8540C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg7mV-0004EF-K9; Sat, 04 Jul 2026 17:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg7mT-0004DS-NA
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 17:20:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg7mR-00008l-7y
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 17:20:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ca70925c25so20176995ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783200005; x=1783804805; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWzhfbbaLozulgPHQS33lsmLR54EHlWW3qyOTcUh7ho=;
 b=B1/T4Bo6oQpg7xusISoNaS42dMx5bIH1bEvx7ATs61Td6mLUrto0P6uXAd/ho1qxDm
 ZfphaTiWJF1uc+buVZ0zswDLHDYZhdZYMXGtTm0MBVtUjN5VegMATEFaI7q/85ulM+9m
 EhvW7yC5PdHv2wCXLTn/4kD779TZgopVRZfFwdC/NNhQMLmVtUwgtwQwwBikKOwVnV+V
 l6SLaNam95Ck7W1p/iMplcj1d65gLG2J8r4F77U1x2TVGdCJDekk2f+TME62ARWFuLBg
 XHICG6mLKDqWbj5pg6PhGiW0sAJVJMJMRfKNIOZj2GUQXTvf+HQSdZynUfgaryWUNZyZ
 SFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783200005; x=1783804805;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWzhfbbaLozulgPHQS33lsmLR54EHlWW3qyOTcUh7ho=;
 b=b6en1c6RTIRm3DXSzIJYNVe1jJRlJVIsZ9UPb4FGiJEvvODg4LKb/mUEIaEr0GXm3i
 nWkiug8ucEFGoa3yHlYImlGFUaUhbpQgxdDKmnOWZxrG5anG8+hFt0U01VVBRcLJwKYE
 IX7IUELt8GJdnzuAJg+nURE8Zm+NDR3O5Kambhvgx9ktHiT8lPVb8PKMehd3lB/EBX4d
 /cziWQ8mLmBuv5c6tPzHrA9MApzQnHYz8ZjST5RD0rwdg631scugRPi5IqoDj/p2ohOe
 Qgdgii97hxD+g3av+2HXgKq5TdZ73E7vg8mFtNInCz2Ltp0ReDCOjosriL1iCVW5PH3o
 R0+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQeXAuUgcva018jcDZTUTQ+WAkDd9kpzz5kirbSq7/4YtrhtTN1PTv5XqvcZ0PTeYRVNyfDsPUuZtQ@nongnu.org
X-Gm-Message-State: AOJu0YxxTWmPalezvzIL1Le1qClsbt0pDpQWk7P0krz0SHexbNXAsBnp
 810VGMGAx67CGQM25oToP+89bMWsbe7ghyBcBfDFWq1xwaneSUa805U5vGWlydFkG5k=
X-Gm-Gg: AfdE7cnbmWPd9N0Yhk0SdwoARsOCYf7LVhZn1vSjk/1uiruNNhdmR/6amiTz32/FAqE
 09rfEwPsVAc+cpnyFLcTnQK8oyKFtGStNd9UWzEoVVCqZFo5q0MLNJ9YKVFFrU4sOKAOq/XAtVB
 40up8k/kDpPf+G87tb4YLkVruivmK2NbWu6mtX2EAVD4WgmRVPN78EVxvXxSLKXGp12SfxKH6/J
 Z3vr66QXK0UoN8V4ba9myZ5AUApzvBkFrfVWKmLn8+k4IZeT1pDgIrviVf287CD6uMUciJRHX6v
 MWdPlVTcVOQbJJpKjawGKcYiBI4V2fR4oeMKa7tQOWOdW6dcnYsP3+V95TKNXDf0fg0c9X5xYzP
 HqMmM1cq7GIhdFyygMPcPVeya0ybLsYHZ/AQDm6vBvRU2LSShZna2Yof057qhZLmYfy/MuSLWpn
 n63KCygB9ZLcknHgmhONF4iV9cRi8xO1BQ/J01uaqvO+upvu85OeN0T0o=
X-Received: by 2002:a17:903:2286:b0:2c9:fc14:588f with SMTP id
 d9443c01a7336-2cbb9e9f48cmr41482455ad.29.1783200004859; 
 Sat, 04 Jul 2026 14:20:04 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7870f58sm26603475ad.59.2026.07.04.14.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 14:20:03 -0700 (PDT)
Message-ID: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
Date: Sat, 4 Jul 2026 14:20:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: docker-image-debian-all-test-cross errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Has anyone else been seeing

Error: Failed to fetch 
http://deb.debian.org/debian/pool/main/d/dpkg/libdpkg-perl_1.22.21_all.deb  404  Not Found 
[IP: 151.101.22.132 80]
Error: Failed to fetch 
http://deb.debian.org/debian/pool/main/d/dpkg/dpkg-dev_1.22.21_all.deb  404  Not Found 
[IP: 151.101.22.132 80]
Error: Failed to fetch 
http://deb.debian.org/debian/pool/main/p/python3.13/libpython3.13_3.13.5-2_amd64.deb  404 
Not Found [IP: 151.101.22.132 80]
Error: Failed to fetch 
http://deb.debian.org/debian/pool/main/g/glibc/libc6-i386_2.41-12_amd64.deb  404  Not 
Found [IP: 151.101.22.132 80]
Error: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive eatmydata   apt install -y 
--no-install-recommends   clang  dpkg-dev  gdb-multiarch  libclang-rt-dev": while running 
runtime: exit status 100
make: *** [/home/rth/qemu/src/tests/docker/Makefile.include:43: 
docker-image-debian-all-test-cross] Error 100

This has been consistently failing for me for a couple of weeks...


r~

