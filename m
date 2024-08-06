Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F56C52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFJR-00066z-IY; Tue, 06 Aug 2024 04:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFJP-0005xz-0E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:12:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFJN-0000ty-0D
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:12:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7d2a9a23d9so43061166b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722931968; x=1723536768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOE5Bm1QTyw19ukT7cwlEqP0JKI+9C+ZyLG+zJsciJQ=;
 b=KAdwUrd+RsbQSGaWmvPg5mhjXztWlktZd9uGQ/aRV5tLqaHMsTrM/TeTUxkQpotaVF
 LU3XwFqqiRrmcNuU94jeD319WuapDlxZIBWGMOR45EJWPA4vKULyH5bRX9570WFvmb54
 MqyXvKrZtBNXXeW/dvUvi0S9DOBkeboY1d496C/gS6CVq53V0EeqnAlTfxPuJn+aIlQt
 w2bWjCD9D+8rU6C9jQkZkk+CkKCa9/RHBA+2gvEE/UAwsLtA6z9/SKmzCsHgHn2aYPkZ
 ACzJO8DXBKNqXbAqwpqWhnZlB9he3r+8/AsSl2I8AkRxI71+yIDxaygvmOi8Vui0hRD4
 XF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722931968; x=1723536768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOE5Bm1QTyw19ukT7cwlEqP0JKI+9C+ZyLG+zJsciJQ=;
 b=BoDyz1iZoWwON4MSO9og+RshL4OznLVMq9BBpWrYVcmiDjjtI4s1V/5GS3WSX4cr6L
 aA+JngZdbwi65NmJyfz6sHgHls6b3I0y8sIr6nkI9yKzkE77PV5ZQ6lS+awEYBRojC83
 p0vSIVpyiCbu6pSzg/qcTKMKQ1kLJiWNr4IS6/u9+55H3QM1+uutAVR4FTDAP+IsG2t2
 MIggY4O6NexbmSYpzvdres29BTmNPM2H06mQ27/TN+LyjOx28vXe/SOtvJEE/aUx+Tp2
 1JscAehmVA4El9c7KQWDChWT9/ObhZaS7S2fdUO94rFN/LxqHGZoa96SSrAgoWwey+s6
 E2jA==
X-Gm-Message-State: AOJu0YxPU9RwbqrCZ440cL6/h6wA9tZwWl8javt6/SHm5f3S4OYP7EyQ
 z+lGzypnrTmmSUI3wdXAbXSq2wAYCG7hEs4LeTcPSAnNP//0Z/geIMDghFzPsp3fUCXEbeMccwO
 j
X-Google-Smtp-Source: AGHT+IElvm9M3k52nMPPqe1xq1VMngc/IWIHa8pJ1nMC6bHl4NQkQ06bUEIFnr+9pjdR3lTODWjyuQ==
X-Received: by 2002:a17:907:2d06:b0:a7d:a080:bb7 with SMTP id
 a640c23a62f3a-a7dc4fdfe6dmr1100474366b.36.1722931968042; 
 Tue, 06 Aug 2024 01:12:48 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4392bsm526365366b.108.2024.08.06.01.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 01:12:47 -0700 (PDT)
Message-ID: <acbc2777-d594-4fc4-a9f5-ded061091df0@linaro.org>
Date: Tue, 6 Aug 2024 10:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v6 00/15] Reconstruct loongson ipi driver
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
References: <20240805180622.21001-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 5/8/24 20:06, Philippe Mathieu-Daudé wrote:

> Bibo Mao (14):
>    hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
>    hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
>    hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
>    hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
>    hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
>    hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
>    hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
>      handler
>    hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
>    hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
>    hw/intc/loongarch_ipi: Add loongarch IPI support
>    hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI
>    hw/intc/loongson_ipi: Restrict to MIPS

Patches 1-15 queued.

