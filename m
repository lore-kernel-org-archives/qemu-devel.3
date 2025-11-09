Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B0CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5z3-0002aU-Hk; Sun, 09 Nov 2025 09:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5ym-0002IQ-1x
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:01:21 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5yk-0003yz-4p
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:01:15 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b710601e659so347531566b.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762696872; x=1763301672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7uHbJVGqhREGBEbw2X+gQk3wl7ZTZUNiM46Y/Qff18=;
 b=gNPwlp8Os1xyempChrv+lf5/5uxOtDqvHyy1y34EjJSOhC+tlk63Vd9bzFs+Q6K1nj
 /a6a2rgtIojmNfq5nEv3xK+TDH9hPrtE5NR7FGS4PCG3cZvounwak55YWYqRVcW9g17Y
 6RRXPyhAtdbUCmsfLzyhsxMq2YTg/lrXQ3ytn+cveUHxKKsjZSvGvKm9GQtgAUjYYBwi
 36iCgmSxmkf5b92t111MSEswA3xqbWABEphoX9cbT/OBhDklUFpd+RtrAEUlDOTVziJg
 yE/R0TPL6X/8JvpoicrGPVp5YI4XSO+3b8aI/fcjyVGAWvIHDAMITpDKeS96q9ioGF6/
 mubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696872; x=1763301672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7uHbJVGqhREGBEbw2X+gQk3wl7ZTZUNiM46Y/Qff18=;
 b=FHE9ZFsdtD8J0SDBor/URQi9KMYH6t8cWucK/Aa5APOKMbFI8+zbbezRP97XTfVCQU
 iXyAJ69+wWh2g5S/eexCSMV2o7gFvbn2iKZEMBPwGIUU6M4BnrUM59QkBUNZh5f+/WPg
 DVhDNlGmTr5dbLtt5EvuUgwTS/f+CNIdnQsd8mGFh3ZodCBlhvYdWtsmNCl1tqz/9HD4
 jLCrVKLz8aY2y9a/sTtGcy5ylk2PRrI3AziRXUZKo5mgP31rHE2BT/SOkSdEkqq8Ap0d
 KJgeOT8dNCb8RleyZVrNWRM7nI/gl1cQvLhXPygmnfbm+v+FiQNCjo9bxY1e+TP2DqLV
 JR7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSecvJCfCwjYzcvHppOfmx20SPn+knqzw55p8+Vzz9mgCYk7TFsQ0ONBETFEYCMgjbNtOVf4YCqDT8@nongnu.org
X-Gm-Message-State: AOJu0YwWvueKnrsYP/yN3TlXD9iXBrm5xLxTeJR4Mh91yUh6aFLu1lgC
 E6u8BL1hnZNYDQBbYSsAhuEHOmhF9JmaZtvmyueGh35MPTBvSrhWN5M9WLZ0jlvyTys=
X-Gm-Gg: ASbGncvnSNJkgbhQ5CJ0KFmMn7OntM7gxjSTJA7bWtdU1xE46fxqjgHdtkayFdsNKTf
 qNqiDAZjeIISk/GkRUTAqI7GY44QXy61wts0PxgktR1xapKbrtyahhsLUSghE3lYZFWuTVzindQ
 Cb2vAOi4SFPvM4M73UzSuQNHAIgQyyVCHJmzeZdbu5JQUpwMrS7I7MwX/yWHr1K5ph46/tS+Agh
 np04fLrG9MrAUlyYmT5f4k8uN1hgd6OuFDol3x8s5NTz3WVolu/0TSzhE7B+zk9t6ARzEkBmQox
 0Cb/MX5arXk9K1YYsl6N3u9HHrOwUnm7qI4Izgm253MF+acvVtpvH3Fh78UYvzlDH3TUoas5URo
 p85Vs3imMiL1/Bu+QgLFteUO7sgNNP9HskMtUGV/j7899Vin9YfOpSl4MJl0+S3NjaG2K6Oh1TK
 meizMD7inLsPpOx/X4DXqBkgrh5fwFOXvo5awOsydmhdjiweQgYdjYcTbn+g==
X-Google-Smtp-Source: AGHT+IEcPv+thLGo6KDe7lVOpO77zeE35E2PFHmmrRaK+7Jv2QnjElSOJGuex3A+OuFkV6uHC1ODNw==
X-Received: by 2002:a17:906:7309:b0:b70:8519:44a3 with SMTP id
 a640c23a62f3a-b72e02b33b7mr490602766b.21.1762696872478; 
 Sun, 09 Nov 2025 06:01:12 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa11367sm799597666b.68.2025.11.09.06.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 06:01:12 -0800 (PST)
Message-ID: <efd13f61-d14d-4016-b187-6917ce37bf80@linaro.org>
Date: Sun, 9 Nov 2025 15:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/intc/riscv_aclint: implement the RISCVCPUTimeSrcIf
 interface
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-6-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-6-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Implement the RISCVCPUTimeSrcIf QOM interface in the ACLINT mtimer device
> model.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/intc/riscv_aclint.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


