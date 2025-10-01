Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A18CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qGn-0006Nr-3b; Wed, 01 Oct 2025 02:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3qGj-0006NR-Gf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:24:53 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3qGW-0003w5-Pc
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:24:53 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.84])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cc4dp61jZz6V6C;
 Wed,  1 Oct 2025 06:24:30 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 1 Oct
 2025 08:24:29 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001a6082ade-8a70-4c07-ad6a-2f3024cb4671,
 D9D4E9C7278927B1F3584C3B5B4DCE3027F8E762) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8b14bde0-2ca8-4b45-a41a-f1459a7710fe@kaod.org>
Date: Wed, 1 Oct 2025 08:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: Bin Meng <bmeng.cn@gmail.com>, <qemu-block@nongnu.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>, 'Jamin Lin' <jamin_lin@aspeedtech.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
 <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
 <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
 <b09cd869-39e7-4a62-b452-4ea39ccf4df0@siemens.com>
 <e992011b-ac3f-4770-97e8-3c0321410e72@kaod.org>
 <aa63efc6-8edc-4db4-9221-a1a54fc1cdce@siemens.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <aa63efc6-8edc-4db4-9221-a1a54fc1cdce@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: a9c424e0-c3de-480f-a706-c4657ee1c571
X-Ovh-Tracer-Id: 14492020651139500862
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF/kd/Vh80SrIS60a5EMe0rYnj3l8dGTyhvcpnWA61poIYwwA/hMkcEewg/chqprPeMa8eLDn5tWQbVXkx6LM/FNQuEkNefadjsKa/vH9R7e2rX/1rAMR2R0m6SgTA0dpIAAr38JFMFwvJja4qOh7sBfA2y8pHhP9DTF10/6A+uLjHxc1VvSTGPM9Q4P2iBwaUmZSClYtxN+x3R/6rE5n8sOVzCxJihsRt06opm6QorEvoZzlEf1HItC7/7cSeiTIryHPggookEufJ9+Z8NW3+8PQBjfQ7dXBYwep9G6jd4b0AbU5OwIQajK2v7j63dZIWxifDWTKFjsLz6W0OPZnbInoiC9Xjari2/ZRfAn1eqt6sQOVgZPEodMe3gcwW0Wg1T9loAZzl7DR2qiYz054nEs2EVhG9YC3VDpFczdBzGavgvf3yW9UJkm7us+KI3ae53KghiqmyFHtXgo4FNHi7+WNzd7aReNbWfJ7I1+GhZXiCJp8rrul4r8lmC1FWZz0s3ObVzuJhlxLLywqZ8XaRjtZWwuNdHoFPxgdayaNQhmKnsMSzTzDyc2KdTvf/qpfJc/i9qQHYtkl2I+GEmSGJmvPFenE3Ajn1GHYb/Uko1rxlKug8UuoJFlQAx1GMLH2Aupesj6wtVouYQKJB6MSlVcW8O00qSwbRrKcOtxAZ93g
DKIM-Signature: a=rsa-sha256; bh=q2rSClsPL94WMS6yU8xKjv0nL1nQNJMrETq9nrcdCY0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759299873; v=1;
 b=h6MPqAv9aunm3th29LmL73G9InRVF0c0uY405vmRzFR6spm8N/vMsL10zaWnweMeF0ACXEYO
 8FdWXWaVFlgrYiAI9sP0USgTwaiLTrdIdWLELRADBgmeSkiZcaKUOxbvsRwLHlLwLGnhksVXdq5
 z3rdl0TNojDQK5/sLHjD/FpcJm+mMitWoExNqUw89LR3Tb6D4XNpgIWFZykgUL+aKvEnTKUr0OK
 lu7eTbMfbrBpbrCa/nN+CXgWnJ2xtu8dxULNQDyEhEeUSlQ91XxLOUFJjLDCEpwAdPoXzfiqllB
 0QMdVV7rDK8EQ/a5f4/zj4WLOVMI4/Yx8UDo0Ep7Kdz2w==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/30/25 11:06, Jan Kiszka wrote:
> On 17.09.25 07:53, Cédric Le Goater wrote:
>> On 9/16/25 19:17, Jan Kiszka wrote:
>>> On 16.09.25 18:14, Cédric Le Goater wrote:
>>>> + Jamin
>>>>
>>>> On 9/16/25 13:39, Jan Kiszka wrote:
>>>>> On 14.09.25 14:46, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Alignment rules apply the the individual partitions (user, boot, later
>>>>>> on also RPMB) and depend both on the size of the image and the type of
>>>>>> the device. Up to and including 2GB, the power-of-2 rule applies to
>>>>>> the
>>>>>> user data area. For larger images, multiples of 512 sectors must be
>>>>>> used
>>>>>> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
>>>>>> and also detect if the image is too small to even hold the boot
>>>>>> partitions.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Reviewed-by: Warner Losh <imp@bsdimp.com>
>>>>>> ---
>>>>>> CC: Warner Losh <imp@bsdimp.com>
>>>>>> CC: Cédric Le Goater <clg@kaod.org>
>>>>>> CC: Joel Stanley <joel@jms.id.au>
>>>>>> CC: Alistair Francis <alistair@alistair23.me>
>>>>>> CC: Alexander Bulekov <alxndr@bu.edu>
>>>>>> ---
>>>>>>     hw/sd/sd.c | 61 ++++++++++++++++++++++++++++++++++++
>>>>>> +-----------------
>>>>>>     1 file changed, 42 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>> index d7a496d77c..b42cd01d1f 100644
>>>>>> --- a/hw/sd/sd.c
>>>>>> +++ b/hw/sd/sd.c
>>>>>> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
>>>>>>         timer_free(sd->ocr_power_timer);
>>>>>>     }
>>>>>>     +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
>>>>>> +                              int64_t blk_size_aligned, const char
>>>>>> *rule,
>>>>>> +                              Error **errp)
>>>>>> +{
>>>>>> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
>>>>>> +    char *blk_size_str;
>>>>>> +
>>>>>> +    blk_size_str = size_to_str(blk_size);
>>>>>> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
>>>>>> +    g_free(blk_size_str);
>>>>>> +
>>>>>> +    blk_size_str = size_to_str(blk_size_aligned);
>>>>>> +    error_append_hint(errp,
>>>>>> +                      "%s size has to be %s, e.g. %s.\n"
>>>>>> +                      "You can resize disk images with"
>>>>>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>>>>>> +                      "(note that this will lose data if you make
>>>>>> the"
>>>>>> +                      " image smaller than it currently is).\n",
>>>>>> +                      dev_type, rule, blk_size_str);
>>>>>> +    g_free(blk_size_str);
>>>>>> +}
>>>>>> +
>>>>>>     static void sd_realize(DeviceState *dev, Error **errp)
>>>>>>     {
>>>>>>         SDState *sd = SDMMC_COMMON(dev);
>>>>>> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev,
>>>>>> Error **errp)
>>>>>>                 return;
>>>>>>             }
>>>>>>     -        blk_size = blk_getlength(sd->blk);
>>>>>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>> -            char *blk_size_str;
>>>>>> -
>>>>>> -            blk_size_str = size_to_str(blk_size);
>>>>>> -            error_setg(errp, "Invalid SD card size: %s",
>>>>>> blk_size_str);
>>>>>> -            g_free(blk_size_str);
>>>>>> -
>>>>>> -            blk_size_str = size_to_str(blk_size_aligned);
>>>>>> -            error_append_hint(errp,
>>>>>> -                              "SD card size has to be a power of 2,
>>>>>> e.g. %s.\n"
>>>>>> -                              "You can resize disk images with"
>>>>>> -                              " 'qemu-img resize <imagefile> <new-
>>>>>> size>'\n"
>>>>>> -                              "(note that this will lose data if you
>>>>>> make the"
>>>>>> -                              " image smaller than it currently is).
>>>>>> \n",
>>>>>> -                              blk_size_str);
>>>>>> -            g_free(blk_size_str);
>>>>>> -
>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>>> +        if (blk_size > SDSC_MAX_CAPACITY) {
>>>>>> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) !=
>>>>>> 0) {
>>>>>> +                int64_t blk_size_aligned =
>>>>>> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) <<
>>>>>> HWBLOCK_SHIFT;
>>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>>> +                                  "multiples of 512", errp);
>>>>>> +                return;
>>>>>> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
>>>>>> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) <<
>>>>>> 19;
>>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>>> +                                  "multiples of 512K", errp);
>>>>>> +                return;
>>>>>> +            }
>>>>>> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a
>>>>>> power of 2",
>>>>>> +                              errp);
>>>>>> +            return;
>>>>>> +        } else if (blk_size < 0) {
>>>>>> +            error_setg(errp, "eMMC image smaller than boot
>>>>>> partitions");
>>>>>
>>>>> Cedric, I just played with some ast* machines and noticed that they now
>>>>> trigger that error above when no eMMC disk image is specified
>>>>> ("qemu-system-aarch64 -M ast2700a1-evb"). Is that a valid error,
>>>>> i.e. we
>>>>> shouldn't have tried to boot without an eMMC at all so far, or would
>>>>> this be a regression?
>>>>
>>>> Only the ast2600-evb and the rainier-bmc have eMMC support.
>>>> I don't think the ast2700a1-evb has eMMC support. Jamin ?
>>>>
>>>>
>>>>
>>>> The rainier-bmc boots by default from eMMC. Nothing really
>>>> special about the image, the first boot partition includes
>>>> the u-boot-spl.bin and u-boot.bin images at expected offset.
>>>> The machine model loads the u-boot-spl.bin contents as a ROM.
>>>>
>>>> The ast2600-evb machine boots from flash. To add an eMMC drive
>>>> (needs to be the 3rd 'sd' drive), use this command line  :
>>>>
>>>>       $ qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev
>>>> user,id=net0 \
>>>>         -drive file=./v09.07/ast2600-default/image-
>>>> bmc,format=raw,if=mtd -
>>>> serial mon:stdio \
>>>>         -drive file=mmc-ast2600-evb-
>>>> noboot.qcow2,format=qcow2,if=sd,id=sd2,index=2
>>>>         ....
>>>>       U-Boot 2019.04-v00.04.22 (Jun 17 2025 - 08:57:39 +0000)
>>>>           SOC: AST2600-A3
>>>>       eSPI Mode: SIO:Enable : SuperIO-2e
>>>>       Eth: MAC0: RGMII, MAC1: RGMII, MAC2: RGMII, MAC3: RGMII
>>>>       Model: AST2600 EVB
>>>>       DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64
>>>> MiB,
>>>> ECC:off)
>>>>       RC Bridge phy@1e6ed200 : Link up
>>>>       MMC:   sdhci_slot0@100: 1, sdhci_slot1@200: 2, emmc_slot0@100: 0
>>>>           ....
>>>>       [    4.209117] mmc0: new high speed MMC card at address 0001
>>>>       [    4.211765] mmcblk0: mmc0:0001 QEMU!! 16.0 GiB
>>>>       [    4.233637] GPT:Primary header thinks Alt. header is not at the
>>>> end of the disk.
>>>>       [    4.233995] GPT:29624393 != 33554431
>>>>       [    4.234161] GPT:Alternate GPT header not at the end of the disk.
>>>>       [    4.234399] GPT:29624393 != 33554431
>>>>       [    4.234549] GPT: Use GNU Parted to correct GPT errors.
>>>>       [    4.235223]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>>>>      
>>>
>>> $ ./qemu-system-arm -M ast2600-evb
>>> qemu-system-arm: eMMC image smaller than boot partitions
>>> $ ./qemu-system-arm -M ast2600-evb -drive file=disk.image,if=sd
>>> <works if disk.image is large enough>
>>>
>>> Is that ok?
>>
>> No. This is wrong.
>>
>> An sd card device is auto created at init time and a 'DriveInfo *'
>> is always available for index 0. 'mc->auto_create_sdcard' should
>> be set to false IMO.
>>
>> commit cdc8d7cadaac ("hw/boards: Rename no_sdcard ->
>> auto_create_sdcard") seems to have changed the behavior of
>> several machines.  See 'make check'.
>>
> 
> Just to avoid we are in deadlock: My understanding of this issue is that
> it is not a fault of this series. Am I right? Or am I supposed to
> address that as well?

Could you add to your series :

    https://lore.kernel.org/qemu-devel/20250930142448.1030476-1-clg@redhat.com/

and retry the aspeed machines ?

I am afraid more should be done to run 'make check' with your series.
Maybe set 'mc->auto_create_sdcard' to false for all machines ?

Thanks,

C.



> 
> Regarding the rest of the series, there was another comment on potential
> improvements for the docs. I was waiting for further remarks before
> creating a potential v5.
> 
> So, what is needed now to move forward with my series?
> 
> Thanks,
> Jan
> 


