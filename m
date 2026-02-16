Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0819E7BDBD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrytj-0004pk-D1; Mon, 16 Feb 2026 08:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vrytc-0004mw-V8; Mon, 16 Feb 2026 08:44:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vrytZ-0003NK-V4; Mon, 16 Feb 2026 08:44:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A94D9189DF3;
 Mon, 16 Feb 2026 16:43:52 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9937B3662EF;
 Mon, 16 Feb 2026 16:44:01 +0300 (MSK)
Message-ID: <cd70fbd5-f8a1-407d-93d5-d586a8e44158@tls.msk.ru>
Date: Mon, 16 Feb 2026 16:44:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-7.2 1/2] hw/sd/sdhci: Do not set Buf Wr Ena before
 writing block (CVE-2022-3872)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, RivenDell
 <XRivenDell@outlook.com>, Siqi Chen <coc.cyqh@gmail.com>,
 ningqiang <ningqiang1@huawei.com>, qemu-stable <qemu-stable@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20221107221236.47841-1-philmd@linaro.org>
 <20221107221236.47841-2-philmd@linaro.org>
 <7d7bc83f-d14b-43b5-a637-517a51266a19@tls.msk.ru>
 <CAHUE=o_fL=Ni2xGgWbBs-ucamRSubHavLX928C7TRMPi=N94ag@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <CAHUE=o_fL=Ni2xGgWbBs-ucamRSubHavLX928C7TRMPi=N94ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/13/26 17:43, Alexander Bulekov wrote:
> On 260213 1205, Michael Tokarev wrote:
>> Ping once again?
>>
> 
> FWIW, none of the reproducers in the thread work for me anymore and
> OSS-Fuzz claims the issue was fixed sometime in April 2024:
> https://issues.oss-fuzz.com/issues/42524205#comment5


ok.  I bisected using the reproducer from
https://lore.kernel.org/qemu-devel/CAA8xKjXrmS0fkr28AKvNNpyAtM0y0B+5FichpsrhD+mUgnuyKg@mail.gmail.com/ 
-
and it looks like first, the invalid write were replaced with an
assertion failure after this commit, which is itself is a fix for
CVE-2024-3447:

commit 9e4b27ca6bf4974f169bbca7f3dca117b1208b6f (v9.0.0-rc2-64-g9e4b27ca6b)
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 9 16:19:27 2024 +0200

     hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is set

https://gitlab.com/qemu-project/qemu/-/commit/9e4b27ca6bf4974f169bbca7f3dca117b1208b6f

So yes, this is in Apr-24, and it is in v9.0.0.

After this commit, the invalid write has gone, instead, we started
hitting assertion failure in sdhci_write_dataport():

  hw/sd/sdhci.c:565: sdhci_write_dataport: Assertion `s->data_count < 
s->buf_maxsz' failed.

next, in

commit ed5a159c3de48a581f46de4c8c02b4b295e6c52d (v9.1.0-rc0-80-ged5a159c3d)
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Jul 30 10:41:25 2024 +0200

     hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers

https://gitlab.com/qemu-project/qemu/-/commit/ed5a159c3de48a581f46de4c8c02b4b295e6c52d

the assertion failure has gone for good, at least with this
reproducer.

(the first commit is v7.2.10-56-g2429cb7a9f in 7.2.x series,
second - v7.2.13-25-gfc2e706f4c).

So it looks like the issue has been fixed for good in v9.1.0
and v7.2.14.

Please take a look at the original bug report and the final
logic as per this message - does it look sane?

> 
>> Thanks,
>>
>> /mjt
>>
>> On 11/8/22 01:12, Philippe Mathieu-Daudé wrote:
>>> When sdhci_write_block_to_card() is called to transfer data from
>>> the FIFO to the SD bus, the data is already present in the buffer
>>> and we have to consume it directly.
>>>
>>> See the description of the 'Buffer Write Enable' bit from the
>>> 'Present State' register (prnsts::SDHC_SPACE_AVAILABLE) in Table
>>> 2.14 from the SDHCI spec v2:
>>>
>>>     Buffer Write Enable
>>>
>>>     This status is used for non-DMA write transfers.
>>>
>>>     The Host Controller can implement multiple buffers to transfer
>>>     data efficiently. This read only flag indicates if space is
>>>     available for write data. If this bit is 1, data can be written
>>>     to the buffer. A change of this bit from 1 to 0 occurs when all
>>>     the block data is written to the buffer. A change of this bit
>>>     from 0 to 1 occurs when top of block data can be written to the
>>>     buffer and generates the Buffer Write Ready interrupt.
>>>
>>> In our case, we do not want to overwrite the buffer, so we want
>>> this bit to be 0, then set it to 1 once the data is written onto
>>> the bus.
>>>
>>> This is probably a copy/paste error from commit d7dfca0807
>>> ("hw/sdhci: introduce standard SD host controller").
>>>
>>> Reproducer:
>>> https://lore.kernel.org/qemu-devel/CAA8xKjXrmS0fkr28AKvNNpyAtM0y0B+5FichpsrhD+mUgnuyKg@mail.gmail.com/
>>>
>>> Fixes: CVE-2022-3872
>>> Reported-by: RivenDell <XRivenDell@outlook.com>
>>> Reported-by: Siqi Chen <coc.cyqh@gmail.com>
>>> Reported-by: ningqiang <ningqiang1@huawei.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Tested-by: Mauro Matteo Cascella <mcascell@redhat.com>
>>> ---
>>>    hw/sd/sdhci.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 306070c872..f230e7475f 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -954,7 +954,7 @@ static void sdhci_data_transfer(void *opaque)
>>>                sdhci_read_block_from_card(s);
>>>            } else {
>>>                s->prnsts |= SDHC_DOING_WRITE | SDHC_DAT_LINE_ACTIVE |
>>> -                    SDHC_SPACE_AVAILABLE | SDHC_DATA_INHIBIT;
>>> +                                           SDHC_DATA_INHIBIT;
>>>                sdhci_write_block_to_card(s);
>>>            }
>>>        }
>>
> 


