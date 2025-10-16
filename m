Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3218CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 21:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9VFW-0004dt-0U; Thu, 16 Oct 2025 17:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VFU-0004dH-BU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:11:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VFS-0007wP-4Y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:10:59 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-33bb0472889so1268950a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760649055; x=1761253855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xyb1nOZ+eh4MNq5s9DJmELq5g2kNAkzasbhNkSmGFT0=;
 b=jvDePxFlqJNLEAqVFsDmZltbwi7A/O3UAYmSSYtdLhNA7mnW/KUEQHI5FjLrZYtb+h
 ODvHMFRLO5N0XVKWj6lS7JROLrcMmkRv6NOhyEuxCbK9aY+FdJwuSL2tAXYGek1ytCr7
 GJWDT48IkbhEmIHs6lgMRxmn8Rrk10QMxF4vbNZldLBifYbFcwPxZqKWhhgzI7HOaoIs
 CxDTwJSqpYh+vzWkbAHIr250Uq+uAEyHJUc5PNEQcbtzr3b8PU66Ixug165Va3nOX8eZ
 kMHvwRSHZE6tD635gxNA+wGdDcLsE4WM7M26sO9iFPuz+1+wf7MBHs8EzTD10S4mcO2+
 ZXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760649055; x=1761253855;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xyb1nOZ+eh4MNq5s9DJmELq5g2kNAkzasbhNkSmGFT0=;
 b=bWKi0/o2/rMbc8qNnsZKVJpQoNa+DpUQ3amh126PBQw4PCEHE7kPfGConJBcugGNzN
 n1qFaapM+GLF/p00edYZix+sQtj1yWlP27F3QlxJk58RoOliOjJ9pip95SqF1wJz5A2S
 O6Lm+0d3Mndq1z6qDGLxSFsoU3G+PPh1j0iNW+FpbyEy6A/vewlHhg1PJEUznCcV9omC
 tHJ5iNqzpsqht51Ayak54eh3dcIOcRBE25kyvouf8csR7Ysh0wj2WhCijIfFySuP12qr
 x8MhcGWP0qTbCxeD4VwJlA8RwhF4Xo/OsAi8w6tr1JAY6Q4M7t/xd7aFPx1FJhYlDJBN
 1K+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdXVNGyA9idxAjKvLuP3IYYCkpfQjFBdW9iWBY1Mutdg2pMqMf9OSiAQvm+ieU+fmBRerfsvGWz0D9@nongnu.org
X-Gm-Message-State: AOJu0YytHZaXV3B7Sawb+drMo7/PC6Q4nMoWDcH+RIDBRcQRp3U0rPdt
 XuQa31QkAwHOohm51404rEQ0zBod0XX+SCICVpSciby60tSMSkO+KKQNhtUYd9NdVTk=
X-Gm-Gg: ASbGncupc2fWo0YXP0Mi05mCR6w0M4i5wmJjgMkaP1hL/J+WoLS1MgpbCvNrwAtDeAG
 x3Ep1U+SRDHUonceBCpXkVkG6PEoEATFrolVQOnnxtzG+kVeziyZ6p2MgRdbaMmWVw+W8ld0vqe
 B6bXRchgdClYWAP0093j38RE6NWKjMbeJyk7W6A2a2Spit6Q1t1E667QBvL2DvY6fCFZF+5jKw6
 YxZ8BUOPF9NCV07GOhgkEwCzYodzHxDVVse+jAGClzkkosQDxN7TRIskSUiTJ3qK1jyjutHi5um
 AS0Jjy1UQwaQ5xfVgmMnC5wjFN7G7Mg95HoF+n5prlKK+ddUUIYMCIsSNOR0mbz4sctUH4KqhhC
 1xtDSaJjzyGur+xlpCPau6rMQoFicnptOxf//reWSt9rQAfO2vubTFT5lRbmCL3DFK53oirTUZv
 oCQGEVbBSPeUQyIl7MsCqdBle5
X-Google-Smtp-Source: AGHT+IFYSNJw2AQjCzkjgvCGLn43zsEt555nXZUZI+ZgPLIDfsg4iLfQBfCNyC1qWf245bdTtwVEtA==
X-Received: by 2002:a17:90b:248f:b0:33b:cfae:3621 with SMTP id
 98e67ed59e1d1-33bcfae47d8mr817291a91.32.1760649055029; 
 Thu, 16 Oct 2025 14:10:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bb66a2085sm3021831a91.11.2025.10.16.14.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 14:10:54 -0700 (PDT)
Message-ID: <e869022c-ace2-4bf4-b72a-fb1d28556fb6@linaro.org>
Date: Thu, 16 Oct 2025 14:10:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Support SME2 in gdbstub
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
References: <20251016122132.737016-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016122132.737016-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 10/16/25 05:21, Peter Maydell wrote:
> This patchseries adds SME2 support to the gdbstub. This is
> fairly straightforward as the only thing we need to do is
> expose the new ZT0 register in the XML in the way that gdb
> documents that we should.

We're also missing TPIDR2.

According to gdb/features/aarch64-tls.c, "org.gnu.gdb.aarch64.tls" should contain 2 
registers, tpidr and tpidr2.  Apparently the second is optional, and we should have been 
providing the "tls" with just tpidr all along.


r~

