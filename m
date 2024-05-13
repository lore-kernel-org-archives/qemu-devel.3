Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D714C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 02:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Lql-0001YB-Mf; Sun, 12 May 2024 22:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Lqb-0001XI-I7; Sun, 12 May 2024 22:55:29 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6LqV-0006Tb-VW; Sun, 12 May 2024 22:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715568915; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=6jHcqDqK3d+EL5SEk+FiAz0m3A68fqOQ0NX0mgBSXS0=;
 b=YIgBUSPukF8XAGAozh9VXF1g7KWXMGZ3lwSE8q6y9z1iaESfGVaQ+JC+Gs51nkgqgHpDpxMxj0s3vP6UwaFj5su0MghDy8SlvjZY6Do5aAuUTB8DShZHuJXwxEk+neh+jvfeeMncxBAJTscXXilp23mr1tVzTLQuoiJUrOuHmNA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067109;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0W6H4bhX_1715568913; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6H4bhX_1715568913) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 10:55:14 +0800
Message-ID: <fb91965c-6ff8-4dda-98cc-04668dbd2af4@linux.alibaba.com>
Date: Mon, 13 May 2024 10:54:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Reuse the conversion function of
 priv_spec and string
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-2-fea.wang@sifive.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240510065856.2436870-2-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/5/10 14:58, Fea.Wang wrote:
> From: Jim Shu <jim.shu@sifive.com>
>
> Public the conversion function of priv_spec and string in cpu.h, so that
> tcg-cpu.c could also use it.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu.c         |  4 ++--
>   target/riscv/cpu.h         |  3 +++
>   target/riscv/tcg/tcg-cpu.c | 13 +++++--------
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a74f0eb29c..b6b48e5620 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1769,7 +1769,7 @@ static const PropertyInfo prop_pmp = {
>       .set = prop_pmp_set,
>   };
>   
> -static int priv_spec_from_str(const char *priv_spec_str)
> +int priv_spec_from_str(const char *priv_spec_str)
>   {
>       int priv_version = -1;
>   
> @@ -1784,7 +1784,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
>       return priv_version;
>   }
>   
> -static const char *priv_spec_to_str(int priv_version)
> +const char *priv_spec_to_str(int priv_version)
>   {
>       switch (priv_version) {
>       case PRIV_VERSION_1_10_0:
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e0dd1828b5..7696102697 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -829,4 +829,7 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
>   uint8_t satp_mode_max_from_map(uint32_t map);
>   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   
> +const char *priv_spec_to_str(int priv_version);
> +int priv_spec_from_str(const char *priv_spec_str);
> +
>   #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4ebebebe09..faa8de9b83 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -76,16 +76,13 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
>   
>   static const char *cpu_priv_ver_to_str(int priv_ver)
>   {
> -    switch (priv_ver) {
> -    case PRIV_VERSION_1_10_0:
> -        return "v1.10.0";
> -    case PRIV_VERSION_1_11_0:
> -        return "v1.11.0";
> -    case PRIV_VERSION_1_12_0:
> -        return "v1.12.0";
> +    const char *priv_spec_str = priv_spec_to_str(priv_ver);
> +
> +    if (priv_spec_str == NULL) {
> +        g_assert_not_reached();
>       }

g_assert(priv_spec_str != NULL) or g_assert(priv_spec_str)

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>   
> -    g_assert_not_reached();
> +    return priv_spec_str;
>   }
>   
>   static void riscv_cpu_synchronize_from_tb(CPUState *cs,

