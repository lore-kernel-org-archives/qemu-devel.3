Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BC9EA852E
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 15:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzG6Y-000532-JM; Sun, 08 Mar 2026 11:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG6V-00052X-90
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:31:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG6T-0006Ag-7I
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:31:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so90035195e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772983896; x=1773588696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEEcnUH72Tv4WXl0bdTjUJvGVrtlmoy/Hi0iPfYk8oY=;
 b=Co0Ppjr6+VcLIBGX1bxNWQ5neOkojx+qHHEjr4g6sOqG944pHV69WmoculVcegWM4y
 MKAFNMZUByRcb62h3Bx1jhcpSZgmiSIL31GmzZau+FPJn9Ss1aXxt54b68LQ14OYMEhl
 F5RsvnIHFEUCaFEuDQF4l3fQrm63qDW4obsBcknGQI5FNVDkjcAAk/tW38BWOPc4aHZY
 hEzhrt9z7RcaCF8T1tzpMnPn13TXGDUCVKa54JngOGw+i9VbeTVN0EK3p3KYEWPDV3sG
 nHm5zJf9zghhUgS3qswmMrK8GsaUZhcQlarDrxVsa7po7T/YcABwowzWqzejZWYLTiGt
 OjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772983896; x=1773588696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZEEcnUH72Tv4WXl0bdTjUJvGVrtlmoy/Hi0iPfYk8oY=;
 b=Lde76wetiBrZkhf1RSHPbCp081rtHe5NOnp3QZynDOCJ2+2M1Yy6/zEE27IW5r757Y
 aEn1Ete1Vbq7Jjwakthp2uXHs8j+O/HU+B1eHMLDPinpk1KyVu6I5O34uE1qJdQrMihM
 tap983gdZQbXBuOlwXsxYHykEWv2XhnaGkWC4hQsnmm4g+ZRfBmd2Mw0FblkuIS7djJ2
 Dl42CRCvL2ZufyO0/mKkzb72XWvu7NBDEXxmWu/LkdMNC7R7TJWBflptOc/EWoMQCtcm
 RsPnTdnxjcp4Y/8SqHxV54CtSE/dl5FyeTeE/wOf4/yW+8mem/OcXIeCvTcAG/kaxPPf
 DRwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXdos7oJQEvUCO4cTxMG7eifzb0MwSjIW8r854Z7Tu/Ue5oIc6EBtbW22KBmoQvRx9nPv1IMxadxI@nongnu.org
X-Gm-Message-State: AOJu0Yxh7FCbVOPkJA1BBrwu5uOisvZ0Imrgbn9OYUXPzK/T9ZZLuEAS
 G4rk1Q1DQhzsKl4QoPZo5ehcgq7UGQOEoB4FVYfr8769gHm2Ur5FbjYurkpfyaKXfD8=
X-Gm-Gg: ATEYQzwsc79MlM1RAbFNzlsFrpocf/POy0GgKdOmEmghFrsTkOeNcdVQ82amNKgF+Qg
 pkQPB4ZNGP/VmlfXzAcsBsd3Zean4zUvBr+RdDzXktpSblCSSytnxX4pXrXR2qJ2KBD3kWSSpmg
 J7h4WEWrTmtIYXgldZ8mBMG9LROKbXBAFXCSrqpapt7NBWlj0fD8UdoW70B+6svP3uxSoK6ReOW
 AC8s+oIpdqgpv8EiFg6mWOIJ3sRy4Icjyo3xYEJ6LLhzW4xKIKHuu049U5OzOl9L+Z4r3+EpFei
 CnPXopUadnVxdW04bt77/AGcACxzkOqnRMTSyydD3pGl5tCCvsOL5OrGCUSQuQmbyoo8C1VKnde
 9KiaE4xZ2igv22oSeF8tZe/Q7RkoN87fDkIt9CRVBwk0SHYhVNiLO+NZ+xEhugpE4BHyDudkYAx
 zKJHeAk1zIfQ2mWO1xdqHzezyd4J8jTT/c1yK4o2Otpr0QZJ64vSr/kvIZgBDMWyHr+Q==
X-Received: by 2002:a05:600c:c4a3:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48539b2a60dmr27044045e9.25.1772983895432; 
 Sun, 08 Mar 2026 08:31:35 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a946978sm27565325e9.1.2026.03.08.08.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 08:31:34 -0700 (PDT)
Message-ID: <dc001a41-9d1c-447a-82b7-19c464cdd1c4@linaro.org>
Date: Sun, 8 Mar 2026 16:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20260307125222.3656140-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307125222.3656140-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/3/26 13:52, Peter Maydell wrote:
> The riscv-iommu device makes various allocations in its
> instance_init method. These will leak when QMP inits an
> object of this type to introspect it, as can be seen if you
> run 'make check' with the address sanitizer enabled:
> 
> Direct leak of 4096 byte(s) in 1 object(s) allocated from:
>      #0 0x5d8415b6ed9d in calloc (/home/pm215/qemu/build/san/qemu-system-riscv32+0x1832d9d) (BuildId: fedcc313e48ba803d63837329c37fd609dd50849)
>      #1 0x75c0502f1771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5d8416d09391 in riscv_iommu_instance_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu.c:2463:18
>      #3 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #4 0x5d8417104ee9 in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
>      #5 0x5d8417104ee9 in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
>      #6 0x5d8417104db1 in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
>      #7 0x5d8417106506 in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
>      #8 0x5d8416d16a12 in riscv_iommu_sys_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu-sys.c:199:5
>      #9 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #10 0x5d841710661f in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #11 0x5d841755d956 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> (and other similar backtraces).
> 
> Fix these by freeing the resources we allocate in instance_init in
> instance_finalize.  In some cases we were freeing these in unrealize,
> and in some cases not at all.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/riscv/riscv-iommu.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

