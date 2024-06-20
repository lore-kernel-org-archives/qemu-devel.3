Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46005C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 07:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKC99-0005Bs-Gf; Thu, 20 Jun 2024 03:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7F4n=NW=kaod.org=clg@ozlabs.org>)
 id 1sKC97-0005BR-GT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:23:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7F4n=NW=kaod.org=clg@ozlabs.org>)
 id 1sKC94-000298-Sb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:23:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W4X653RYwz4x0v;
 Thu, 20 Jun 2024 17:23:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W4X624D0Gz4wcC;
 Thu, 20 Jun 2024 17:23:38 +1000 (AEST)
Message-ID: <54bc25fd-acea-44a3-b696-c261e7e9706d@kaod.org>
Date: Thu, 20 Jun 2024 09:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-23-clg@kaod.org>
 <59f1da17-719d-4389-b21a-053b2ee980dd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <59f1da17-719d-4389-b21a-053b2ee980dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7F4n=NW=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello

On 6/19/24 7:40 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 3/7/23 15:24, Cédric Le Goater wrote:
>> The parameters mimick a real 4GB eMMC, but it can be set to various
>> sizes. Initially from Vincent Palatin <vpalatin@chromium.org>
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sdmmc-internal.h |  97 ++++++++++++++++++++++++++++++++++++
>>   include/hw/sd/sd.h     |   1 +
>>   hw/sd/sd.c             | 109 ++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 206 insertions(+), 1 deletion(-)
> 
> First pass review, this will take time...
> 
>> +static void mmc_set_ext_csd(SDState *sd, uint64_t size)
>> +{
>> +    uint32_t sectcount = size >> HWBLOCK_SHIFT;
>> +
>> +    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
>> +
>> +    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0x1; /* supported command sets */
>> +    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
>> +    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
>> +    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
>> +    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
>> +    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
> 
> We do not support (and are not interested in) that. I'll use 0x0 for
> "do not support".
> 
>> +    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase support */
> 
> This value is obsolete, so I'd use 0x0 to avoid confusions.
> 
>> +    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM multiplier */
> 
> Again, 0x0 for "not defined".
> 
>> +    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
>> +    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
>> +    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
> 
> 16KB of super_page_size hmm. Simpler could be the underlying block
> retrieved with bdrv_nb_sectors() or simply BDRV_SECTOR_SIZE (0x1).
> 
>> +    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
> 
> 2MB of erase size hmmm why not.
> 
>> +    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase timeout */
> 
> We don't implement timeout, can we use 0?
> 
>> +    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
>> +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
>> +    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
>> +    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
>> +    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
>> +    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
>> +    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
>> +    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
>> +    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
>> +    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
>> +    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
>> +    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
>> +    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
>> +    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
>> +    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
> 
> Class B at 3MB/s. I suppose announcing up to J at 21MB/s is safe (0x46).
> 
>> +    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
> 
> SWITCH command isn't implemented so far. We could use 0x0 for "not
> defined".
> 
>> +    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
> 
> Similarly, 0x0 for "undefined" is legal.
> 
>> +    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
> 
> You anounce dual data rate. Could we just use High-Speed mode (0x3)
> to ease modelling?
> 
>> +    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
>> +    sd->ext_csd[EXT_CSD_REV] = 0x5;
> 
> This is Revision 1.5 (for MMC v4.41)... The first QEMU implementation
> was based on Revision 1.3 (for MMC v4.3) and I'm seeing some features
> from Revision 1.6 (for MMC v4.5)...
> 
> Do we want to implement all of them? Since we are adding from
> scratch, I suggest we directly start with v4.5 (0x6).
> 
> Note, EXT_CSD_BUS_WIDTH is not set (0x0) meaning 1-bit data bus.
> I'd set it to 0x2 (8-bit):
> 
>         sd->ext_csd[EXT_CSD_BUS_WIDTH] = EXT_CSD_BUS_WIDTH_8_MASK;


I applied the proposed changes from above and the rainier-bmc boots fine.
Here are the mmc related logs :


   U-Boot SPL 2019.04 (Jun 17 2024 - 07:49:13 +0000)
   Trying to boot from MMC1
   
   
   U-Boot 2019.04 (Jun 17 2024 - 07:49:13 +0000)
   
   SOC: AST2600-A3
   eMMC 2nd Boot (ABR): Enable, boot partition: 1
   LPC Mode: SIO:Disable
   Eth: MAC0: RMII/NCSI, MAC1: RMII/NCSI, MAC2: RMII/NCSI, MAC3: RMII/NCSI
   Model: IBM P10 BMC
   DRAM:  already initialized, 896 MiB (capacity:1024 MiB, VGA:64 MiB, ECC:on, ECC size:896 MiB)
   MMC:   emmc_slot0@100: 0
   Loading Environment from MMC... OK
   In:    serial@1e784000
   Out:   serial@1e784000
   Err:   serial@1e784000
   Model: IBM P10 BMC
   Net:   No MDIO found.
   ftgmac100_probe - NCSI detected
   
   ...
   
   [    0.640650] mmc0: SDHCI controller on 1e750100.sdhci [1e750100.sdhci] using ADMA
   [    0.658402] mmc0: unspecified timeout for CMD6 - use generic
   [    0.659014] mmc0: unspecified timeout for CMD6 - use generic
   [    0.659314] mmc0: unspecified timeout for CMD6 - use generic
   [    0.659722] mmc0: unspecified timeout for CMD6 - use generic
   [    0.660740] mmc0: unspecified timeout for CMD6 - use generic
   [    0.661139] mmc0: new high speed MMC card at address 0001
   [    0.662825] mmcblk0: mmc0:0001 QEMU! 16.0 GiB
   [    0.688329]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
   [    0.692837] mmcblk0boot0: mmc0:0001 QEMU! 1.00 MiB
   [    0.694416] mmcblk0boot1: mmc0:0001 QEMU! 1.00 MiB
   [    0.695166] mmcblk0rpmb: mmc0:0001 QEMU! 128 KiB, chardev (243:0)
   [    2.455427]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
   [    7.624272] EXT4-fs (mmcblk0p4): orphan cleanup on readonly fs
   [    7.624837] EXT4-fs (mmcblk0p4): mounted filesystem 6f526507-e73b-4094-8f08-f310b5da5b3a ro with ordered data mode. Quota mode: disabled.
   [    8.024897] EXT4-fs (mmcblk0p6): mounted filesystem 6dc9b0da-2b0f-4822-9eac-df4dd782ddfc r/w with ordered data mode. Quota mode: disabled.
   [   15.991016] EXT4-fs (mmcblk0p4): re-mounted 6f526507-e73b-4094-8f08-f310b5da5b3a ro. Quota mode: disabled.
   

I think these initial values are fine to start with.

Thanks,

C.



>> +    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
>> +    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
>> +    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
>> +    sd->ext_csd[158] = 0x00; /* ... */
>> +    sd->ext_csd[157] = 0xEC; /* ... */
>> +}
> 


