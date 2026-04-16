Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1DF8A144
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDI4R-0001Vv-Rx; Thu, 16 Apr 2026 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI4P-0001VX-RN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:27:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI4O-0003Vq-3a
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:27:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso72286005e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776328046; x=1776932846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kUcGl4gTuoEgqk6T3KyMqtYbdhNgGPNhAouthNBAjnI=;
 b=H0o0RVe3q/LiPup8vL3cvLFI8v2qvSsXe54ZbOD4jyHflGOXKosleRcHSwzTznZ2cT
 G0wGpNx25Wm96iX8lybwu4s56D+PW1BFhVJnq4ZjdgR/sRVAUaTHw1K3IMhAui92ZYzj
 GWVCgkZrHdV3pGc3m5Nh61KtV2UoP4MJYwnYp6Nv34SoPxtsiTOevzcubW9U6VRNAO75
 vXU7hO5L2beQTPs0n8EcaVfcnHyiJ1d+kKdCNCH1xUkBPKBLfu2mrORTEq54d4JM8NEw
 Q6NRi1FpDsqgWIHzl/l69Yh4zSg7d/CnkAa0fPwStMjSjAW5B8fnOsVqQz40saYg/2Eg
 RODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328046; x=1776932846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUcGl4gTuoEgqk6T3KyMqtYbdhNgGPNhAouthNBAjnI=;
 b=joLa8wzy/UIzbJeQoim0Cf8+ZZD4Pkhr2xgUjpChSIq4Xlu565OuuvsIvEGXp/8EZv
 ENXg+cidZE3daiOIKNXqhDX2O4uIzxRLjmlA5rfzZMaSTqvwOPhYdcOoMDtKfruajTIE
 LF2LkcGADEEVMhWg1lfRcTWxMilqu76EaC2nVj6FKa2QgPqTfelHR0XjvFDAjKgrVaVT
 90ElCKrdBcksRRoDGesNzHrIVrFqi8Fv0r9d5Qe0porV3a5Q2oKc46dwgHce63hsvz59
 Dk3ZFTx6rmguLBOJiOtWhHNvBiaFVrkiHJX2GH2GTY1n7ijQYitrNdxXB9391Pxv5aPY
 m3qg==
X-Gm-Message-State: AOJu0YxS7WKMd9HgUKh1HD23Z7BbZVv/QwEugPvCFClWA6zkqyka0EuS
 ixC+wbtRnL3nIb1/4cuMn0euBNORoJwZiK7HcwrkzvdCtEsuV2oAN3fHXhiFYF6iU1U=
X-Gm-Gg: AeBDievcIdOo7BdXg6Z/Du8jgtm+kDPytnbiujfWVjDy7oNKZYIO8z5a1wDqk4uYWfa
 kXLyQFeevpxG8OAlRzty56f0sDNnBw5m68ABpFrHxS2rs0fflu/784Kqd+rGPj+/zvJhh79LfOg
 sOuBEEu5tstqmcAERF3Rb9A+ZUQo+eOhHgHfXBPNiXzq3n5n/jwTdc2TuMVw88k5iDKEP6fPV0G
 INCupJTLFeNGg3H9q5vTw1M2eQ+e7WKczUkMlO6UMy5rblbaBJkbEzQU18JlJwh+aT834vDSNTS
 qNHvDyv8C5sAUUIH32em1eMcyBjDRLj3mncEoCZiaToslwKE1KzjgMWV8LIkHGfQIf2l4z5hA9X
 c9WZ1TgjsdpNzC9sjP/mrYN4TuXYuLlu/BcenzNW0sc/8KGVj6yX9keL4ING0N6M1zjwWJqzf41
 TzrqvJa2J/Mqz5pwyinhXW7f/S0LkxCb4pQfQ=
X-Received: by 2002:a05:600c:1987:b0:488:b187:d8ed with SMTP id
 5b1f17b1804b1-488d67bf765mr350633815e9.2.1776328046376; 
 Thu, 16 Apr 2026 01:27:26 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5813954sm31486885e9.3.2026.04.16.01.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 01:27:25 -0700 (PDT)
Message-ID: <df6688f7-1111-474a-b4f9-8d7eec3ce8d9@linaro.org>
Date: Thu, 16 Apr 2026 10:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] hw/sd/sdhci: Don't use bounce buffer for ADMA
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, Stefan Hajnoczi
 <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
 <4e0536d5-d7a8-45f7-b2b2-bff9fe2d92cc@linaro.org>
 <t4mncbf2hpzecg23tmuu3rd7ha4zs7fftqyk54n7cfqltk66hw@gnnqucv72rbk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <t4mncbf2hpzecg23tmuu3rd7ha4zs7fftqyk54n7cfqltk66hw@gnnqucv72rbk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Cc'ing Paolo &  Stefan.

On 16/4/26 09:52, Christian Speich wrote:
> On Tue, Apr 14, 2026 at 03:51:24PM +0200, Philippe Mathieu-Daudé wrote:
>> On 4/2/26 14:22, Christian Speich wrote:
>>> Currently, ADMA will temporarily store data into a local bounce buffer
>>> when transferring it. This will produce unneeded copies of the data and
>>> limit us to the bounce buffer size for each step.
>>>
>>> This patch now maps the requested DMA address and passes this buffer
>>> directly to sdbus_{read,write}_data. This allows to pass much larger
>>> buffers down to increase the performance. sdbus_{read,write}_data is
>>> already able to handle arbitrary length and alignments, so we do not
>>> need to ensure this.
>>>
>>> Signed-off-by: Christian Speich <c.speich@avm.de>
>>> ---
>>>    hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
>>>    1 file changed, 55 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index c86dfa281f4b0218bf6dda7a38d46abfc9638450..6e07711478cb6ca046a7d371a82e2c682ebbda00 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -775,7 +775,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
>>>    static void sdhci_do_adma(SDHCIState *s)
>>>    {
>>> -    unsigned int begin, length;
>>> +    unsigned int length;
>>>        const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
>>>        const MemTxAttrs attrs = { .memory = true };
>>>        ADMADescr dscr = {};
>>> @@ -817,66 +817,74 @@ static void sdhci_do_adma(SDHCIState *s)
>>>                if (s->trnmod & SDHC_TRNS_READ) {
>>>                    s->prnsts |= SDHC_DOING_READ;
>>>                    while (length) {
>>> -                    if (s->data_count == 0) {
>>> -                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
>>> -                    }
>>> -                    begin = s->data_count;
>>> -                    if ((length + begin) < block_size) {
>>> -                        s->data_count = length + begin;
>>> -                        length = 0;
>>> -                     } else {
>>> -                        s->data_count = block_size;
>>> -                        length -= block_size - begin;
>>> -                    }
>>> -                    res = dma_memory_write(s->dma_as, dscr.addr,
>>> -                                           &s->fifo_buffer[begin],
>>> -                                           s->data_count - begin,
>>> -                                           attrs);
>>> -                    if (res != MEMTX_OK) {
>>> +                    dma_addr_t dma_len = length;
>>> +
>>> +                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
>>> +                                               DMA_DIRECTION_FROM_DEVICE,
>>> +                                               attrs);
>>
>> We know the descriptor is a consecutive range. Couldn't we map/unmap
>> outside of the while() loop? (Ditto write path).
> 
> The loop is there to handle dma_memory_map mapping less that we've requested. I'm not
> really sure if there are any guranteed cases where it always maps the requested length
> fully (at least there are non in the dma_memory_map doc string).
> 
> Iff this is guranteed to always map the requested length, we could remove the whie()
> loop completly.
> 
> Kind Regards,
> Christian
> 
>>
>>> +
>>> +                    if (buf == NULL) {
>>> +                        res = MEMTX_ERROR;
>>>                            break;
>>> +                    } else {
>>> +                        res = MEMTX_OK;
>>>                        }
>>> -                    dscr.addr += s->data_count - begin;
>>> -                    if (s->data_count == block_size) {
>>> -                        s->data_count = 0;
>>> -                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
>>> -                            s->blkcnt--;
>>> -                            if (s->blkcnt == 0) {
>>> -                                break;
>>> -                            }
>>> +
>>> +                    sdbus_read_data(&s->sdbus, buf, dma_len);
>>> +                    length -= dma_len;
>>> +                    dscr.addr += dma_len;
>>> +
>>> +                    dma_memory_unmap(s->dma_as, buf, dma_len,
>>> +                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
>>> +
>>> +                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
>>> +                        size_t transfered = s->data_count + dma_len;
>>> +
>>> +                        s->blkcnt -= transfered / block_size;
>>> +                        s->data_count = transfered % block_size;
>>> +
>>> +                        if (s->blkcnt == 0) {
>>> +                            s->data_count = 0;
>>> +                            break;
>>>                            }
>>>                        }
>>>                    }
>>>                } else {
>>
>>


