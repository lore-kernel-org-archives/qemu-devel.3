Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9519C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeUi-00010E-0I; Tue, 02 Jul 2024 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fXIt=OC=kaod.org=clg@ozlabs.org>)
 id 1sOeUY-0000bb-1z; Tue, 02 Jul 2024 10:28:22 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fXIt=OC=kaod.org=clg@ozlabs.org>)
 id 1sOeUU-0003wz-SZ; Tue, 02 Jul 2024 10:28:21 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WD4yP44Mhz4wcS;
 Wed,  3 Jul 2024 00:28:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WD4yG2s2Sz4x0C;
 Wed,  3 Jul 2024 00:28:06 +1000 (AEST)
Message-ID: <91ced502-aaa0-4c64-9ed4-4ea7b3257f0a@kaod.org>
Date: Tue, 2 Jul 2024 16:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest/npcm7xx_sdhci: Access the card using its
 published address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Patrick Venture <venture@google.com>
References: <20240702140842.54242-1-philmd@linaro.org>
 <20240702140842.54242-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240702140842.54242-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fXIt=OC=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/2/24 4:08 PM, Philippe Mathieu-Daudé wrote:
> Currently setup_sd_card() asks the card its address,
> but discard the response and use hardcoded 0x4567.
> 
> Set the SDHC_CMD_RESPONSE bit to have the controller
> record the bus response, and read the response from
> the RSPREG0 register. Then we can select the card with
> its real address.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Hao Wu <wuhaotsh@google.com>
> Cc: Chris Rauer <crauer@google.com>
> Cc: Shengtan Mao <stmao@google.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Tyrone Ting <kfting@nuvoton.com>
> ---
>   tests/qtest/libqos/sdhci-cmd.h   | 2 ++
>   tests/qtest/npcm7xx_sdhci-test.c | 8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)


Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/tests/qtest/libqos/sdhci-cmd.h b/tests/qtest/libqos/sdhci-cmd.h
> index 9e61dd4944..90efa028ef 100644
> --- a/tests/qtest/libqos/sdhci-cmd.h
> +++ b/tests/qtest/libqos/sdhci-cmd.h
> @@ -22,6 +22,7 @@
>   #define SDHC_ARGUMENT 0x08
>   #define SDHC_TRNMOD 0x0C
>   #define SDHC_CMDREG 0x0E
> +#define SDHC_RSPREG0 0x10
>   #define SDHC_BDATA 0x20
>   #define SDHC_PRNSTS 0x24
>   #define SDHC_BLKGAP 0x2A
> @@ -38,6 +39,7 @@
>   #define SDHC_TRNS_MULTI 0x0020
>   
>   /* CMD Reg */
> +#define SDHC_CMD_RESPONSE (3 << 0)
>   #define SDHC_CMD_DATA_PRESENT (1 << 5)
>   #define SDHC_ALL_SEND_CID (2 << 8)
>   #define SDHC_SEND_RELATIVE_ADDR (3 << 8)
> diff --git a/tests/qtest/npcm7xx_sdhci-test.c b/tests/qtest/npcm7xx_sdhci-test.c
> index 5d68540e52..01f237a816 100644
> --- a/tests/qtest/npcm7xx_sdhci-test.c
> +++ b/tests/qtest/npcm7xx_sdhci-test.c
> @@ -30,6 +30,8 @@ char *sd_path;
>   
>   static QTestState *setup_sd_card(void)
>   {
> +    uint16_t rca;
> +
>       QTestState *qts = qtest_initf(
>           "-machine kudo-bmc "
>           "-device sd-card,drive=drive0 "
> @@ -43,8 +45,10 @@ static QTestState *setup_sd_card(void)
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_APP_CMD);
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 8));
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
> -    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR);
> -    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
> +    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR
> +                                                    | SDHC_CMD_RESPONSE);
> +    rca = qtest_readl(qts, NPCM7XX_MMC_BA + SDHC_RSPREG0) >> 16;
> +    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, rca << 16, 0,
>                      SDHC_SELECT_DESELECT_CARD);
>   
>       return qts;


