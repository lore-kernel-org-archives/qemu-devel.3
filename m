Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900A7E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3jA-0001Wf-RW; Tue, 07 Jan 2025 02:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tV3j9-0001Va-4l; Tue, 07 Jan 2025 02:10:11 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tV3j4-00067A-Tq; Tue, 07 Jan 2025 02:10:10 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so890281766b.3; 
 Mon, 06 Jan 2025 23:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736233803; x=1736838603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6w9qOLOSzu8TxbPI+aY12uHR1MxkluwkiwlQBrD7UAE=;
 b=ESClOO795VVV7pSGjO2HET+J/yC3ktiKzvovNvwYgW8iN7Ocgh5Wnz5/gclC/DMD/d
 OBRpLf5ikmWrIATt8CAo771CsYY9fKS0VtiPBHvVXv2cA43ywy+rIzH53CfVsp8yHYep
 LIYPAZ7Nb77fGo4t64EjE6SFiQnTcmFoIxZFsYXtyitVpwT9Fc+vJ8apsA3FC4RKPCew
 lPgqBT2368QwP/Dd0rKDE31BhRQxiKD/TziwFMC2pde0GArCaAFhFu4RX91DXosqr4jz
 kmcflrSogRO0zYSR4etEQWzcS4ht9v1IEnIosEGvlFyc2z1r1xl5X3SpeRf+PDdJBswB
 6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736233803; x=1736838603;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6w9qOLOSzu8TxbPI+aY12uHR1MxkluwkiwlQBrD7UAE=;
 b=S8zKtkm31kiEYDwibt4FF4VTnY7TlOYqGubgPzuFi1kuQaom+du7XNYdx79D1mvWzG
 gLvJ1a9nc7J+tv/uPeRDiqiMqrtNRjLmVfdU/DJ0xHJpcnnDhvBYh/rSBT4B4kbO8/w5
 qJ9A3cVDauD1mNBtP52EjVBFk03X82h6r5V2epnFHDrHEV3akMKapogOMBo2TbVOn9VJ
 SozExcprBeKn4TM3xrOv1CwrZAhJS1W9I9HYPcXXLpz1SfiinHWRZKbZZF4fTvp41U/5
 mu2C4kdfIobR/QEwv4yiTknKzhe4+udASsbpfmK7DyXLbytFUedr+2+bTx2VzPzy5A+S
 FcLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUusyXxgX2hSRL356nZ7wrg4RrqwH/Q+ibQIk4aXGyF3CECTtEAmU/0wjouZxZzmX8zS9noELD5xIWO/w==@nongnu.org,
 AJvYcCVVn+ZsWzT1Ms2FraYB+3qMd1plcBeuqfWs8Q8hxnDrLS9Mgk9MbiyqzF13Xauj7CmE1XVNXmZR35Jv@nongnu.org
X-Gm-Message-State: AOJu0YxCs7+HDhnVdGqVcCuGxwHjsH9CbAH9C8j9AeTkVr0F3gn4GKpS
 52IV9xjpx1fAA55BZ5ovBLN/7rEJpfpCO2Al6UJADqFbhugWEL/a
X-Gm-Gg: ASbGncucf2sEr9Upvhao2YHrOqJdvbG6AXO3CKdcuuVNM/szmA0nDeXt6jLU/vsZBkr
 cfK4Y9SdFGz6G+2X5oiKQ8rdatPQgRBrnoFB5BCaUJOllXMfIXwwdp3Ww2XtR/hxxciRpOQcDUJ
 gZstknB+uzuQ/TfmhiI+CjOYw1SOhiv6r+S9H0jv2/i7WosH0jZBaINAR+ikIGN+MaoBi3ivjaJ
 e8RGYJqzxA3QLD+ZXQxSgWEqhDZgb4NfalXZW4+tnV595wOfByMNYOZfVtne75S9WUEXqxkgtt1
 jmhHu5xnR1rP4ccVu+HX6d1s2iSKyRlC
X-Google-Smtp-Source: AGHT+IEIa5eYqDRRz9gHnvmZukuPyvW0E6fqziySzWB4F3nkdFrOkvfMIV/ejk3fl27rVsazfIQfAg==
X-Received: by 2002:a17:907:7da0:b0:aaf:ab71:bf79 with SMTP id
 a640c23a62f3a-aafab71c24emr1378392066b.19.1736233803047; 
 Mon, 06 Jan 2025 23:10:03 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-023-134.93.128.pool.telefonica.de.
 [93.128.23.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe4184sm2325021766b.119.2025.01.06.23.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:10:02 -0800 (PST)
Date: Tue, 07 Jan 2025 07:10:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Jamin Lin via <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: jamin_lin@aspeedtech.com, troy_lee@aspeedtech.com,
 yunlin.tang@aspeedtech.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_hw/sd/sdh?=
 =?US-ASCII?Q?ci=3A_Fix_data_transfer_did_not?=
 =?US-ASCII?Q?_complete_if_data_size_is_bigger_than_SDMA_Buffer_Boundary?=
In-Reply-To: <20241213031205.641009-3-jamin_lin@aspeedtech.com>
References: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
 <20241213031205.641009-3-jamin_lin@aspeedtech.com>
Message-ID: <D62F06C8-5247-4FBC-82A9-9127352B30A6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Dezember 2024 03:12:05 UTC schrieb Jamin Lin via <qemu-devel@nong=
nu=2Eorg>:
>According to the design of sdhci_sdma_transfer_multi_blocks, if the
>"s->blkcnt * 512" was bigger than the SDMA Buffer boundary, it break the
>while loop of data transfer and set SDHC_NISEN_DMA in the normal interrup=
t
>status to notify the firmware that this SDMA boundary buffer Transfer Com=
plete
>and firmware should set the system address of the next SDMA boundary buff=
er
>for the remained data transfer=2E
>
>However, after firmware set the system address of the next SDMA boundary =
buffer
>in the SDMA System Address Register(0x00), SDHCI model did not restart th=
e data
>transfer, again=2E Finally, firmware break the data transfer because firm=
ware
>did not receive the either "DMA Interrupt" or "Transfer Complete Interrup=
t"
>from SDHCI model=2E

I ran into a similar problem in u-boot, too=2E Apparently its Freescale uS=
DHCI driver expects the SD command to fill the whole buffer=2E Here are som=
e thoughts:

AFAIU, the SDMA buffer needs to be big enough to hold all s->blkcnt * s->b=
lksize bytes and a guest would typically expect the SD command to fill the =
buffer in one go (please correct me if I'm wrong)=2E Furthermore, I believe=
 on real hardware the command would run in the background, allowing the gue=
st to do real work rather than wait=2E After all, the block attributes regi=
ster allows for up to 4GiB to be filled on some hardware (again, please cor=
rect me if I'm wrong)=2E

The problem is that sdhci_sdma_transfer_multi_blocks() blocks QEMU, i=2Ee=
=2E does not run in the background=2E If a guest asks for huge amounts of d=
ata to be transferred, then this would disturb emulation and QEMU would fre=
eze for a while=2E To avoid that, it seems to me as if the implementation c=
hooses to exit the while loop prematurely, relying on the guest to poke it =
again=2E This, unfortunately, doesn't work for all guests=2E So ideally, sd=
hci_sdma_transfer_multi_blocks() should read all data and run in the backgr=
ound, e=2Eg=2E in a thread or in even in a coroutine? What do you think?

Best regards,
Bernhard

>
>Error log from u-boot
>```
>sdhci_transfer_data: Transfer data timeout
> ** fs_devread read error - block
>```
>
>According to the following mention from SDMA System Address Register of S=
DHCI
>spec,
>'''
>This register contains the system memory address for an SDMA transfer in
>32-bit addressing mode=2E When the Host Controller stops an SDMA transfer=
,
>this register shall point to the system address of the next contiguous da=
ta
>position=2E
>It can be accessed only if no transaction is executing (i=2Ee=2E, after a=
 transaction
>has stopped)=2E Reading this register during SDMA transfers may return an
>invalid value=2E
>The Host Driver shall initialize this register before starting an SDMA
>transaction=2E
>After SDMA has stopped, the next system address of the next contiguous
>data position can be read from this register=2E
>The SDMA transfer waits at the every boundary specified by the SDMA
>Buffer Boundary in the Block Size register=2E The Host Controller generat=
es
>DMA Interrupt to request the Host Driver to update this register=2E The H=
ost
>Driver sets the next system address of the next data position to this reg=
ister=2E
>When the most upper byte of this register (003h) is written, the Host Con=
troller
>restarts the SDMA transfer=2E
>''',
>
>restart the data transfer if firmware writes the most upper byte of SDMA =
System
>Address, s->blkcnt is bigger than 0 and SDHCI is in the data transfer sta=
te=2E
>
>Signed-off-by: Jamin Lin <jamin_lin@aspeedtech=2Ecom>
>---
> hw/sd/sdhci=2Ec | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index f1a329fdaf=2E=2Ea632177735 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -1180,6 +1180,18 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>                     sdhci_sdma_transfer_single_block(s);
>                 }
>             }
>+        } else if (TRANSFERRING_DATA(s->prnsts)) {
>+            s->sdmasysad =3D (s->sdmasysad & mask) | value;
>+            MASKED_WRITE(s->sdmasysad, mask, value);
>+            /* restarts the SDMA transfer if the most upper byte is writ=
ten */
>+            if ((s->sdmasysad & 0xFF000000) && s->blkcnt &&
>+                SDHC_DMA_TYPE(s->hostctl1) =3D=3D SDHC_CTRL_SDMA) {
>+                if (s->trnmod & SDHC_TRNS_MULTI) {
>+                    sdhci_sdma_transfer_multi_blocks(s);
>+                } else {
>+                    sdhci_sdma_transfer_single_block(s);
>+                }
>+            }
>         }
>         break;
>     case SDHC_BLKSIZE:

