Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15FC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1l4-0007IM-Rf; Sun, 26 Jan 2025 07:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1l2-0007HP-Os
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:28:56 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1l1-0005If-A5
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:28:56 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so6239887a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894534; x=1738499334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+rF3F+JSWgloz3VTZP+Zeaftgck0QjKDHwHneKd8oeI=;
 b=YUVmU+5gebhNLyoxD4ZlXeDCbeD2WyDcWY/JDQ1eUZyKCJT107M0WnqWVnrY8sEmA2
 4/LtnlaBGX/FVOL7acQtDdlxMxrLJ54xQj2L56uYuQKBkiTIJdt9JmX7Ksr0RghOyKOq
 WgmxoA7uAQsv5IH/J/+Z/GRKcRrqPdZAxnO6wvvThdEICKn0KOXxOgx3c/HMgzdr3u5l
 wk64OhUu5tKjdRvgm8r6IEAfOuamXz7Q+U+UaP5S8N9JvPXzYT1ziqH0CO4DKYid/oJh
 GPLjPiweAFsyZM6UkYNdl/eWEm29PQysQ8qreCJkgrQ2FGrWRoOenf/d7zhdsYqKwiM5
 kcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894534; x=1738499334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rF3F+JSWgloz3VTZP+Zeaftgck0QjKDHwHneKd8oeI=;
 b=ncToGnT69Mbt2rkol9rKFZmAAVGeftFLGyaUpMJbmIl8zUrZFwd41aMG+TdqLWxt4c
 a2n3S0P5h7XhnaDvU0Z/4oBRWfKy0GznDUYP79+5D9iZtO2XhoNvuj1Qf+qhmIE/2PCu
 PZSzyGAHVfVG//fBX/aHvF4i/tIO9NTpSWV74y/BNT1K8x6tkn0LchRkeGs77Ma4qTbq
 9y9qkpGZGpy4SPWlekRLg1cv8oA+mcT7tfCvwgl+R/TMmkTBpFxxKIJmT1Kkqgqx2B0X
 otkd3n+axdM5j0VVPMbuYjTo/bzwLO4vRMkVPufje7AuSXQBo7BRLDhJmRviba9nVX3z
 s0Lg==
X-Gm-Message-State: AOJu0YyLtIk0C5SgjVW8Xw0yx/3Nvl07lNacBCq2ZN9rdezirs6gh1Ey
 wpr8Lh8p7oU/b2vioUBpxB/U6Rx5Whc2gOjjtpvpUyrJEm0S7VaMOn0kiyePQi+Kx+LYAqDqjz9
 m
X-Gm-Gg: ASbGncuVwta7X8GN5YWTnPaHGKJWai4hkU6eviIUo2C25vS6KgBEeF1K9vXtPGPFzF4
 hbGCZdjJBTFZE412xeyn7PzZbU8NfPUF8F5C5B/JBWB8CzYeGHEKoh0l479h9cjbcvvaP6ERLqQ
 wv84ZoX4ItNF+dcv8Lmvk8xESEUig9ytujls6ufRXyVlAt3ye2U4FVZQLKHd8Gx2RloZY8OFFbR
 uPRWx7X8u+28qQPEUS85KDItRZW5/Hz4+hACPfInyjSchlBJ982WVeluFaa4ozc+D4JOgRJwT2C
 c098NyUm+8egantLX/Io6uY=
X-Google-Smtp-Source: AGHT+IHcBS5Nk0tmUWpU/SG3wSRtmGKBM0V2qJUjfoNDHEYTlcmtXHWcnfY+9n+reLiYDXtsqPEIiQ==
X-Received: by 2002:a17:90b:2805:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f782c8fd33mr58842771a91.10.1737894533855; 
 Sun, 26 Jan 2025 04:28:53 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa455c0sm5061401a91.3.2025.01.26.04.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:28:53 -0800 (PST)
Message-ID: <87cb3c8f-a814-48b7-b499-3af9831ed897@linaro.org>
Date: Sun, 26 Jan 2025 04:28:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qom: Introduce class_post_init() handler
To: qemu-devel@nongnu.org
References: <20250125165855.32168-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125165855.32168-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 08:58, Philippe Mathieu-Daudé wrote:
> Add a class_post_init() handler to be called by parents
> *after* child class_init() handler is called. This is
> necessary to have parent class check children properly
> set some values or mandatory handlers.
> 
> Philippe Mathieu-Daudé (2):
>    qom: Declare class_base_init() before class_init()
>    qom: Introduce class_post_init() handler
> 
>   include/qom/object.h     | 17 ++++++++++-------
>   qom/object.c             | 14 ++++++++++++--
>   rust/qemu-api/src/qom.rs |  8 +++++++-
>   3 files changed, 29 insertions(+), 10 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

