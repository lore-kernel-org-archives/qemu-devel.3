Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C08D5E156
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 13:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVVHV-00029C-9V; Tue, 16 Dec 2025 08:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vVVHP-00028r-LQ; Tue, 16 Dec 2025 08:39:55 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vVVHN-0006Cj-J4; Tue, 16 Dec 2025 08:39:55 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHZkdYUFpBlWiAw--.262S2;
 Tue, 16 Dec 2025 21:39:41 +0800 (CST)
Received: from [192.168.31.184] (unknown [113.246.235.76])
 by mail (Coremail) with SMTP id AQAAfwDXLescYUFpmIIMAA--.8818S2;
 Tue, 16 Dec 2025 21:39:40 +0800 (CST)
Message-ID: <05c30ad2-2836-4f78-9c79-ad03eee2ce00@phytium.com.cn>
Date: Tue, 16 Dec 2025 21:39:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/arm/ptw: make granule_protection_check
 usable without a cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <20251216000122.763264-3-pierrick.bouvier@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <20251216000122.763264-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXLescYUFpmIIMAA--.8818S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWlAa7cHUQAAsh
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF13Jw4UJw45ur1xAw17trb_yoW8XrW5pF
 13GasxKr18JFW3uas3Jr4UZF45Grs3Jay5G3srZrn0kwnav3sI9a1DtF1rGFWjqr93Ca15
 XF1Yvr43Gw4UArUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

On 2025/12/16 08:01, Pierrick Bouvier wrote:
> By removing cpu details and use a config struct, we can use the
> same granule_protection_check with other devices, like SMMU.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 34 ++++++++++++++++++++++++++++
>   target/arm/ptw.c | 59 +++++++++++++++++++++++++++++++-----------------
>   2 files changed, 72 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index efbef0341da..5752e1f58fb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1216,6 +1216,40 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>   
>   hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>                                            MemTxAttrs *attrs);
> +
> +typedef struct ARMGranuleProtectionConfig {
> +    /* GPCCR_EL3 */
> +    uint64_t gpccr;
> +    /* GPTBR_EL3 */
> +    uint64_t gptbr;
> +    /* ID_AA64MMFR0_EL1.PARange */
> +    uint8_t parange;
> +    /* FEAT_SEL2 */
> +    bool support_sel2;
> +    /* Address space to access Granule Protection Table */
> +    AddressSpace *gpt_as;
> +} ARMGranuleProtectionConfig;

Would it make sense to add brief comments explaining how the fields in 
ARMGranuleProtectionConfig map to SMMU registers? This could help 
clarify that arm_granule_protection_check() is intended as a shared 
abstraction for both CPU MMU and SMMU.


That said, I’m also happy to defer this until we actually add the SMMU 
RME support.


Regards,

Tao


