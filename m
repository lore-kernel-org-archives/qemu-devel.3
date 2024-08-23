Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0665AC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shVIB-0006yj-Rk; Fri, 23 Aug 2024 10:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shVIA-0006ua-E9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 10:29:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shVI7-0006W1-CE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 10:29:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3718c176ed7so1048374f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724423366; x=1725028166; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPbbLF0GHdd+ri1cnfKNyoAt6KlPi+CZPhgJOEB10iM=;
 b=AHRhr2fHckZNt2khPKfMXAzzNNBXG/JSWYs83YBo3oClKGRdnjDUB0zD+DBcWnRAqQ
 vBf4PZZ/rGPRWfpLo8m5lADcDV+sh6Gzun2QvAjCIiXzpytWm3ZeSnBjvki+YICGvA/T
 J5Vnoqw3qzNFOTMl1xFiyCdEK+tSrl577ZNAFO6gwPvAKXK1cih/yANJ6JL3lH+pXOKz
 hcanBgW61EPTdmLBfrrjX5EJAhurniQhiAPOASFgQauTVFBbF0VXLzeEpSozeSRNnc+/
 z9g6QCbD4H+TpV8JMlwMkzCJFyeUGb+1pDBpu9rHcxL7eWoawS+i8s8xjK6laXbYb+bI
 CSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724423366; x=1725028166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPbbLF0GHdd+ri1cnfKNyoAt6KlPi+CZPhgJOEB10iM=;
 b=MIaaQb7S0gCyY/2DOOG6mjlqYM+3ha4EjXJePtA6Fd9R9fYVvqtBOr9x03GvpXuh3o
 4i+7/JGEjR3sCNYzGirMFMxImlazZKMVo+6nnllCc/PO8beHPI/JaWB4CB/GMFhwOHUE
 OUvriOnkrOLB41M9yJ6ntFoaKn1VjCM2gg7482peoZPFs3HNIbbT8l8Pecy0a0uZiZi9
 nHVPOzQYdv/OoRTSnwkzMtHQoiV1qmJX5Ky+DWHAMxAthnof3MIakrW4qQbZpgmZL5ye
 /rIgrFbIWfcs00vk4XaBJCR9sN758fN3sQ1s7Zm1YIUeG2xljEpHDl57wXhgdkbUEaWj
 e/dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHfauIpdXID+DslBKjuOc1gXmEKANKLpt7WuFQ9bF3RNL8vp65gkQ2mMwip/Jd0ifX9imIeY5HznAV@nongnu.org
X-Gm-Message-State: AOJu0YwIr2lRPzJYJhtnmyqL3icjhsjCFamlp2/s2i46NA6Ux9iu22fU
 tTdah0ubs7SAFQwunFfw/LAYf8Q4pz1sV79nhTv2jxj+lA/HRD4rCl5OW92SuCE=
X-Google-Smtp-Source: AGHT+IHhy0MPvUljam6DaNcTP8kGCEGZh78USoZJvSAbNjQ3BzzSExHvOnLrQE5np8+31XHeC0FyWQ==
X-Received: by 2002:a5d:64ef:0:b0:367:9522:5e6b with SMTP id
 ffacd0b85a97d-373118c7ce8mr2137032f8f.45.1724423365528; 
 Fri, 23 Aug 2024 07:29:25 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb34sm4295403f8f.71.2024.08.23.07.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 07:29:25 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:59:13 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR
 table revision 4 format
Message-ID: <ZsicubCBw2YAjq9c@sunil-laptop>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jee Heng,
On Fri, Aug 23, 2024 at 04:31:39AM -0700, Sia Jee Heng wrote:
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
> 
> Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
> accommodate the SPCR Table revision 4.
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
Just curious - whether this needs changes in linux side as well? Does
current linux code work fine with version 4 of SPCR table on RISC-V?

Thanks,
Sunil

