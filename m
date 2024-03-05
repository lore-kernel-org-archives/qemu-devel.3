Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA276C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOoY-00038R-DO; Tue, 05 Mar 2024 02:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rhOoW-000382-3T; Tue, 05 Mar 2024 02:02:12 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rhOoT-00085B-1P; Tue, 05 Mar 2024 02:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709622107; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=GPaIn4WCeFNHbKR0e+6J7y1vFCLTZXWYbQfLmuRa65k=;
 b=mDNTbKiAilXumxxFW8TqJAoG4fJBPV1Qn8zLvIiw3chU5c0EF7Qwq8MTY/t4/8YBhQxjn+IqTVHrtwQjMoJVl/haqPKi7nflMy0d4o3RXsUI2RUIrgNQ4XtKZWTa79aXcBVIqRxJMXkHjPqpUYX7+QQiCRHdqjU8WsrJ0NoABo0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W1tHqLW_1709622103; 
Received: from 30.198.0.247(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W1tHqLW_1709622103) by smtp.aliyun-inc.com;
 Tue, 05 Mar 2024 15:01:44 +0800
Message-ID: <2cff52d0-be4d-4f39-be24-cb8b4a7bb96c@linux.alibaba.com>
Date: Tue, 5 Mar 2024 15:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-3-atishp@rivosinc.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240228185116.1321730-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/2/29 2:51, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the properties for ISA extension smcntrpmf. Patches
> implementing it will follow.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>   target/riscv/cpu.c     | 2 ++
>   target/riscv/cpu_cfg.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1b8d001d237f..f9d3c80597fc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -169,6 +169,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -1447,6 +1448,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>   const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Defaults for standard extensions */
>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),

We should not add the configure option for users before the feature has 
been implemented for bitsect reasons.

Thanks,
Zhiwei

> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 833bf5821708..0828841445c5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -73,6 +73,7 @@ struct RISCVCPUConfig {
>       bool ext_zihpm;
>       bool ext_smstateen;
>       bool ext_sstc;
> +    bool ext_smcntrpmf;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;

