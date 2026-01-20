Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B2CA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGSY-0006BB-6D; Tue, 20 Jan 2026 13:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viGSW-00069X-1Y; Tue, 20 Jan 2026 13:28:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viGST-0003mL-Cn; Tue, 20 Jan 2026 13:28:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8C4B596A07;
 Tue, 20 Jan 2026 19:27:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HNc79LQCno2M; Tue, 20 Jan 2026 19:27:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8F255596A03; Tue, 20 Jan 2026 19:27:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8CC015969E4;
 Tue, 20 Jan 2026 19:27:56 +0100 (CET)
Date: Tue, 20 Jan 2026 19:27:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 00/14] Freescale SDHCI Fixes
In-Reply-To: <ae54581c-2a49-b6c2-cde1-d50bbde70a84@eik.bme.hu>
Message-ID: <25c93133-a8a7-5456-5964-a7df9e1daf88@eik.bme.hu>
References: <20260112145418.220506-1-shentey@gmail.com>
 <ae54581c-2a49-b6c2-cde1-d50bbde70a84@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 20 Jan 2026, BALATON Zoltan wrote:
> On Mon, 12 Jan 2026, Bernhard Beschow wrote:
>> This series splits TYPE_IMX_USDHC into three device models which fixes 
>> issues
>> in the ppce500 and some i.MX machines. In particular, it introduces uSDHC's
>> predecessor eSDHC in big and little endian variants. Once the eSDHCs are
>> split off, uSDHC emulation is improved which is a stepping stone towards
>> running u-boot on the i.MX8MP (not implemented yet).
>> 
>> In a way this series picks up previous efforts:
>> * 
>> https://lore.kernel.org/qemu-devel/20250310000620.70120-14-philmd@linaro.org
>> * 
>> https://lore.kernel.org/qemu-devel/20250310000620.70120-15-philmd@linaro.org
>> 
>> There is quite some code churn involved to fix all the issues addressed in
>> this series. Let me know if you have any better ideas to achieve the same.
>> 
>> Best regards,
>> Bernhard
>> 
>> Testing done:
>> * make check
>> * Boot https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz in
>> ppce500
>> * Boot guest in imx8mp-evk
>
> I've tried it with the A1222 U-Boot and it still works the same with this 
> series as before so:
>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Looks like after this series I can revert this change:
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5d8dad7bba..c86dfa281f 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -614,11 +614,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState 
> *s)
>      * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
>      * possible stop at page boundary if initial address is not page 
> aligned,
>      * allow them to work properly
>      */
>     if ((s->sdmasysad % boundary_chk) == 0) {
> -//        page_aligned = true;
> +        page_aligned = true;
>     }
>
>     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
>     if (s->trnmod & SDHC_TRNS_READ) {
>         s->prnsts |= SDHC_DOING_READ;
>
> which needed to be commented out before but now works with or without this 
> change. Is this XXX hack still needed?
>
> Another change I see is that before it ended in:
>
> SDHC wr_4b @0x44 <- 0x00000010 read-only
> SDHC wr_4b @0x44 <- 0x00000010 read-only
>
> repeated 18 times which now says:
>
> SD: CMD12 in a wrong state: transfer (spec v3.01)
> SD: CMD12 in a wrong state: transfer (spec v3.01)
>
> repeated 17 times. But this fails after not finding a bootable device so I'm 
> not sure this is not a bug in this U-Boot version. With more traces enabled 
> it seems to do some transfer then get these errors when trying to continue 
> reading:

In case that helps here's the beginning of this transfer that produces the 
above messages after the first block:

sdcard_read_data SD  READ_MULTIPLE_BLOCK/ CMD18 ofs 510 size 512 blklen  512
sdbus_read @sd-bus value 0x00
sdcard_read_data SD  READ_MULTIPLE_BLOCK/ CMD18 ofs 511 size 512 blklen 512
sdbus_read @sd-bus value 0x00
sdhci_end_transfer Automatically issue CMD12 0x00000000
sdbus_command @sd-bus CMD12 arg 0x00000000
sdcard_normal_command SD    STOP_TRANSMISSION/ CMD12 arg 0x00000000 (mode transfer, state sendingdata)
sdcard_response RESP#1 (normal cmd) (sz:4)
sdhci_access wr32: addr[0x000c] <- 0x123a0037 (305791031)
sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
sdhci_access rd32: addr[0x0010] -> 0x00000900 (2304)
sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
## Starting application at 0x00200000 ...
Invalid read at addr 0xFFFE0F200, size 4, region '(null)', reason: rejected
Invalid write at addr 0xFFFE0F200, size 4, region '(null)', reason: rejected
Invalid read at addr 0xFFFE0F204, size 4, region '(null)', reason: rejected
Invalid write at addr 0xFFFE0F204, size 4, region '(null)', reason: rejected
Invalid read at addr 0xFFFE0F208, size 4, region '(null)', reason: rejected
Invalid write at addr 0xFFFE0F208, size 4, region '(null)', reason: rejected
sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdhci_access wr32: addr[0x0038] <- 0x00000000 (0)
sdhci_access wr32: addr[0x0008] <- 0x00000200 (512)
sdhci_send_command CMD16 ARG[0x00000200]
sdbus_command @sd-bus CMD16 arg 0x00000200
sdcard_normal_command SD         SET_BLOCKLEN/ CMD16 arg 0x00000200 (mode transfer, state transfer)
sdcard_set_blocklen block len 0x200
sdcard_response RESP#1 (normal cmd) (sz:4)
sdhci_response4 RSPREG[31..0]=0x00000900
sdhci_access wr32: addr[0x000c] <- 0x101a0037 (270139447)
sdhci_access rd32: addr[0x0030] -> 0x00000001 (1)
sdhci_access rd32: addr[0x0030] -> 0x00000001 (1)
sdhci_access rd32: addr[0x0010] -> 0x00000900 (2304)
sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdbus_get_dat_lines @sd-bus dat_lines: 15
sdbus_get_cmd_line @sd-bus cmd_line: 1
sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
sdhci_access wr32: addr[0x0000] <- 0x79401de8 (2034245096)
sdhci_access wr32: addr[0x0004] <- 0x00017200 (94720)
sdhci_access rd32: addr[0x002c] -> 0x000b011f (721183)
sdhci_access wr32: addr[0x002c] <- 0x000b011f (721183)
sdhci_access wr32: addr[0x0038] <- 0x00000000 (0)
sdhci_access wr32: addr[0x0008] <- 0x00000000 (0)
sdhci_send_command CMD17 ARG[0x00000000]
sdbus_command @sd-bus CMD17 arg 0x00000000
sdcard_normal_command SD    READ_SINGLE_BLOCK/ CMD17 arg 0x00000000 (mode transfer, state transfer)
sdcard_req_addr req 0x0 addr 0x0
sdcard_read_block addr 0x0 size 0x200
sdcard_response RESP#1 (normal cmd) (sz:4)
sdhci_response4 RSPREG[31..0]=0x00000900
sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 0 size 512 blklen 512
sdbus_read @sd-bus value 0x00
sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 1 size 512 blklen 512
sdbus_read @sd-bus value 0x00

and so on with increasing ofs until:

> sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 509 size 512 blklen 512
> sdbus_read @sd-bus value 0x00
> sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 510 size 512 blklen 512
> sdbus_read @sd-bus value 0x55
> sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 511 size 512 blklen 512
> sdbus_read @sd-bus value 0xaa
> sdhci_end_transfer Automatically issue CMD12 0x00000000
> sdbus_command @sd-bus CMD12 arg 0x00000000
> sdcard_normal_command SD    STOP_TRANSMISSION/ CMD12 arg 0x00000000 (mode 
> transfer, state transfer)
> SD: CMD12 in a wrong state: transfer (spec v3.01)
> sdcard_response ILLEGAL RESP (sz:0)
> sdhci_access wr32: addr[0x000c] <- 0x113a0037 (289013815)
> sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
> sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
> sdhci_access rd32: addr[0x0010] -> 0x00000900 (2304)
> sdhci_access rd32: addr[0x0030] -> 0x0000000b (11)
> sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
> sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdhci_access wr32: addr[0x0038] <- 0x00000000 (0)
> sdhci_access wr32: addr[0x0008] <- 0x00000200 (512)
> sdhci_send_command CMD16 ARG[0x00000200]
> sdbus_command @sd-bus CMD16 arg 0x00000200
> sdcard_normal_command SD         SET_BLOCKLEN/ CMD16 arg 0x00000200 (mode 
> transfer, state transfer)
> sdcard_set_blocklen block len 0x200
> sdcard_response RESP#1 (normal cmd) (sz:4)
> sdhci_response4 RSPREG[31..0]=0x00400900
> sdhci_access wr32: addr[0x000c] <- 0x101a0037 (270139447)
> sdhci_access rd32: addr[0x0030] -> 0x00000001 (1)
> sdhci_access rd32: addr[0x0030] -> 0x00000001 (1)
> sdhci_access rd32: addr[0x0010] -> 0x00400900 (4196608)
> sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
> sdhci_access wr32: addr[0x0030] <- 0xfffffeff (4294967039)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdbus_get_dat_lines @sd-bus dat_lines: 15
> sdbus_get_cmd_line @sd-bus cmd_line: 1
> sdhci_access rd32: addr[0x0024] -> 0x01ff0000 (33488896)
> sdhci_access wr32: addr[0x0000] <- 0x79401de8 (2034245096)
> sdhci_access wr32: addr[0x0004] <- 0x00017200 (94720)
> sdhci_access rd32: addr[0x002c] -> 0x000b011f (721183)
> sdhci_access wr32: addr[0x002c] <- 0x000b011f (721183)
> sdhci_access wr32: addr[0x0038] <- 0x00000000 (0)
> sdhci_access wr32: addr[0x0008] <- 0x00000200 (512)
> sdhci_send_command CMD17 ARG[0x00000200]
> sdbus_command @sd-bus CMD17 arg 0x00000200
> sdcard_normal_command SD    READ_SINGLE_BLOCK/ CMD17 arg 0x00000200 (mode 
> transfer, state transfer)
> sdcard_req_addr req 0x200 addr 0x200
> sdcard_read_block addr 0x200 size 0x200
> sdcard_response RESP#1 (normal cmd) (sz:4)
> sdhci_response4 RSPREG[31..0]=0x00000900
> sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 0 size 512 blklen 512
> sdbus_read @sd-bus value 0x00
> sdcard_read_data SD    READ_SINGLE_BLOCK/ CMD17 ofs 1 size 512 blklen 512
> sdbus_read @sd-bus value 0x00
>
> Regards,
> BALATON Zoltan
>
>> Bernhard Beschow (14):
>>  hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by
>>    default
>>  hw/arm/fsl-imx6: Remove now redundant setting of "sd-spec-version"
>>    property
>>  hw/arm/fsl-imx6: Fix naming of SDHCI related constants and attributes
>>  hw/arm/fsl-imx25: Apply missing reset quirk
>>  Revert "hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*"
>>  hw/sd/sdhci: Consolidate eSDHC constants
>>  hw/sd/sdhci: Rename usdhc_ functions
>>  hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
>>  hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
>>  hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
>>  hw/sd/sdhci: Remove endianness property
>>  hw/sd/sdhci: Add uSDHC-specific quirk
>>  hw/sd/sdhci: Remove vendor property
>>  hw/sd/trace-events: Remove redundant "SWITCH " command name
>> 
>> hw/sd/sdhci-internal.h    |   3 -
>> include/hw/arm/fsl-imx6.h |   4 +-
>> include/hw/sd/sdhci.h     |   8 +-
>> hw/arm/fsl-imx25.c        |   5 +-
>> hw/arm/fsl-imx6.c         |  18 ++--
>> hw/ppc/e500.c             |  10 +-
>> hw/sd/sdhci.c             | 201 ++++++++++++++++++++++++--------------
>> hw/sd/trace-events        |   2 +-
>> 8 files changed, 146 insertions(+), 105 deletions(-)
>> 
>> --
>> 2.52.0
>> 
>> 
>> 
>
>

