Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B0DCEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 13:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKziw-000353-Ap; Mon, 17 Nov 2025 08:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vKzis-00033u-D4; Mon, 17 Nov 2025 08:56:50 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vKzio-0006zN-Tg; Mon, 17 Nov 2025 08:56:50 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXnJiRKRtpGL4+Ag--.111S2;
 Mon, 17 Nov 2025 21:56:33 +0800 (CST)
Received: from [192.168.31.184] (unknown [113.246.232.179])
 by mail (Coremail) with SMTP id AQAAfwA3kO2NKRtpR18FAA--.10707S2;
 Mon, 17 Nov 2025 21:56:29 +0800 (CST)
Message-ID: <7f38ee63-eb24-460c-b8b3-51f3402c4d69@phytium.com.cn>
Date: Mon, 17 Nov 2025 21:56:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/3] hw/misc: introduce iommu-testdev for bare-metal
 IOMMU testing
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
 <20251112162152.447327-2-tangtao1634@phytium.com.cn>
 <b087405f179f2d2b8c4224c87c2c562455b9ab6d.camel@eviden.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <b087405f179f2d2b8c4224c87c2c562455b9ab6d.camel@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3kO2NKRtpR18FAA--.10707S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWkaMBEG7wAAsu
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWfGr43XrykCFWrXryfXw1fJFb_yoWDCFykpr
 n3JrZrtryUtrn3Jr17JF4UJFy5Zr18Ja4DJr18XF1rJw47Ar1jgryUWr1v9ryUJrW8Jr1x
 Jr1UWrnrZr17JrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Clement,

On 2025/11/13 15:02, CLEMENT MATHIEU--DRIF wrote:
> Hi Tao,
>
> On Thu, 2025-11-13 at 00:21 +0800, Tao Tang wrote:
>> Add a minimal PCI test device designed to exercise IOMMU translation
>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>> provides MMIO registers to configure and trigger DMA operations with
>> controllable attributes (security state, address space), enabling
>> deterministic IOMMU testing.
>>
>> Key features:
>> - Bare-metal IOMMU testing via simple MMIO interface
>> - Configurable DMA attributes for security states and address spaces
>> - Write-then-read verification pattern with automatic result checking
>>
>> The device performs a deterministic DMA test pattern: write a known
>> value(0x88888888) to a configured IOVA, read it back, and verify data
>> integrity. Results are reported through a dedicated result register,
>> eliminating the need for complex interrupt handling or driver
>> infrastructure in tests.
>>
>> This is purely a test device and not intended for production use or
>> machine realism. It complements existing test infrastructure like
>> pci-testdev but focuses specifically on IOMMU translation path
>> validation.
>>
>> Signed-off-by: Tao Tang <[tangtao1634@phytium.com.cn](mailto:tangtao1634@phytium.com.cn)>
>> ---
>>   docs/specs/index.rst            |   1 +
>>   docs/specs/iommu-testdev.rst    |  96 +++++++++++
>>   hw/misc/Kconfig                 |   5 +
>>   hw/misc/iommu-testdev.c         | 292 ++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build             |   1 +
>>   hw/misc/trace-events            |  10 ++
>>   include/hw/misc/iommu-testdev.h |  78 +++++++++
>>   7 files changed, 483 insertions(+)
>>   create mode 100644 docs/specs/iommu-testdev.rst
>>   create mode 100644 hw/misc/iommu-testdev.c
>>   create mode 100644 include/hw/misc/iommu-testdev.h
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>> +{
>> +    int i, j, remaining_bytes;
> I think i and j could be declared in their respective loop


Thanks a lot for taking the time to review the patch. All your 
suggestions are excellent and make a lot of sense.


Move the i and j loop variable declarations into their respective for 
loops sounds a good idea. But I wasn't entirely sure if QEMU had a 
strict code style requirement for this, such as mandating all variables 
be defined at the start of the function before any executable code (C89 
style), so I appreciate the clarification.


>> +    uint32_t expected_val, actual_val;
>> +    g_autofree uint8_t *write_buf = NULL;
>> +    g_autofree uint8_t *read_buf = NULL;
>> +    MemTxResult write_res, read_res;
>> +    MemTxAttrs attrs;
>> +    AddressSpace *as;
>> +
>> +    if (!s->dma_pending) {
> As this is a test device, shouldn't we consider this as an error and provide the caller a way to know what happened?
>
> One way to do so is to set a "fatal error csr" to 1 and block the device.
> Maybe it's not the best interface but this makes things clearer to the user.


I'll set a specific error code in the dma_result register instead of 
silently returning, as you suggested.

>> +        return;
>> +    }
>> +    trace_iommu_testdev_dma_start();
>> +
>> +    s->dma_pending = false;
>> +
>> +    if (!s->dma_len) {
>> +        s->dma_result = ITD_DMA_ERR_BAD_LEN;
>> +        return;
>> +    }
>> +
>> +    write_buf = g_malloc(s->dma_len);
>> +    read_buf = g_malloc(s->dma_len);
>> +
>> +    /* Initialize MemTxAttrs from generic register */
>> +    attrs = MEMTXATTRS_UNSPECIFIED;
>> +    attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
>> +
>> +    /*
>> +     * The 'space' field in MemTxAttrs is ARM-specific.
>> +     * On other architectures where this field doesn't exist,
>> +     * the assignment will be optimized away or ignored.
>> +     */
>> +    attrs.space = ITD_ATTRS_GET_SPACE(s->dma_attrs_cfg);
>> +
>> +    as = s->dma_as;
>> +
>> +    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
>> +    trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
>> +
>> +    for (i = 0; i < s->dma_len; i++) {
>> +        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
>> +    }
>> +    write_res = dma_memory_write(as, s->dma_vaddr, write_buf, s->dma_len,
>> +                                 attrs);
>> +
>> +    if (write_res != MEMTX_OK) {
>> +        s->dma_result = ITD_DMA_ERR_TX_FAIL;
>> +        trace_iommu_testdev_dma_result(s->dma_result);
>> +        return;
>> +    }
>> +
>> +    /* Step 2: Read back from the same DMA address */
>> +    trace_iommu_testdev_dma_read(s->dma_vaddr, s->dma_len);
>> +
>> +    read_res = dma_memory_read(as, s->dma_vaddr, read_buf, s->dma_len, attrs);
>> +
>> +    if (read_res != MEMTX_OK) {
>> +        s->dma_result = ITD_DMA_ERR_RD_FAIL;
>> +        trace_iommu_testdev_dma_result(s->dma_result);
>> +        return;
>> +    }
>> +
>> +    /* Step 3: Verify the read data matches what we wrote */
>> +    for (i = 0; i < s->dma_len; i += 4) {
>> +        remaining_bytes = (s->dma_len - i) < 4 ? (s->dma_len - i) : 4;
> This is MIN


Yeah it's just MIN. I'll replace the ternary logic with the MIN() macro 
for calculating remaining_bytes.

>
>> +
>> +        expected_val = 0;
>> +        actual_val = 0;
>> +
>> +        for (j = 0; j < remaining_bytes; j++) {
>> +            expected_val |= ((uint32_t)write_buf[i + j]) << (j * 8);
>> +            actual_val |= ((uint32_t)read_buf[i + j]) << (j * 8);
>> +        }
>> +
>> +        trace_iommu_testdev_dma_verify(expected_val, actual_val);
>> +
>> +        if (expected_val != actual_val) {
>> +            s->dma_result = ITD_DMA_ERR_MISMATCH;
>> +            trace_iommu_testdev_dma_result(s->dma_result);
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* All checks passed */
>> +    s->dma_result = 0;
>> +    trace_iommu_testdev_dma_result(s->dma_result);
>> +}
>> +
>> +static uint64_t iommu_testdev_mmio_read(void *opaque, hwaddr addr,
>> +                                        unsigned size)
>> +{
>> +    IOMMUTestDevState *s = opaque;
>> +    uint64_t value = 0;
>> +
>> +    switch (addr) {
>> +    case ITD_REG_DMA_TRIGGERING:
>> +        /*
>> +         * This lets tests poll ITD_REG_DMA_RESULT to observe BUSY before
>> +         * consuming the DMA.
>> +         */
>> +        iommu_testdev_maybe_run_dma(s);
>> +        value = 0;
>> +        break;
>> +    case ITD_REG_DMA_GVA_LO:
>> +        value = (uint32_t)(s->dma_vaddr & 0xffffffffu);
>> +        break;
>> +    case ITD_REG_DMA_GVA_HI:
>> +        value = (uint32_t)(s->dma_vaddr >> 32);
>> +        break;
>> +    case ITD_REG_DMA_LEN:
>> +        value = s->dma_len;
>> +        break;
>> +    case ITD_REG_DMA_RESULT:
>> +        value = s->dma_result;
>> +        break;
>> +    case ITD_REG_DMA_ATTRS:
>> +        value = s->dma_attrs_cfg;
>> +        break;
>> +    case ITD_REG_TRANS_STATUS:
>> +        value = s->trans_status;
>> +        break;
>> +    default:
>> +        value = 0;
>> +        break;
>> +    }
>> +
>> +    trace_iommu_testdev_mmio_read(addr, value, size);
>> +    return value;
>> +}
>> +
>> +static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>> +                                     unsigned size)
>> +{
>> +    IOMMUTestDevState *s = opaque;
>> +    uint32_t data = val;
>> +
>> +    trace_iommu_testdev_mmio_write(addr, val, size);
>> +
>> +    switch (addr) {
>> +    case ITD_REG_DMA_GVA_LO:
>> +        s->dma_vaddr = (s->dma_vaddr & ~0xffffffffull) | data;
>> +        break;
>> +    case ITD_REG_DMA_GVA_HI:
>> +        s->dma_vaddr = (s->dma_vaddr & 0xffffffffull) |
>> +                       ((uint64_t)data << 32);
>> +        break;
>> +    case ITD_REG_DMA_LEN:
>> +        s->dma_len = data;
>> +        break;
>> +    case ITD_REG_DMA_RESULT:
>> +        s->dma_result = data;
>> +        break;
>> +    case ITD_REG_DMA_DBELL:
>> +        if (data & 0x1) {
> Shouldn't we define a constant for the 0x1? Like ITD_DMA_ARMED?
>
>> +            s->dma_pending = true;
>> +            s->dma_result = ITD_DMA_RESULT_BUSY;
>> +            trace_iommu_testdev_dma_pending(true);
>> +        } else {
>> +            s->dma_pending = false;
>> +            s->dma_result = ITD_DMA_RESULT_IDLE;
>> +            trace_iommu_testdev_dma_pending(false);
>> +        }
>> +        break;
>> +    case ITD_REG_DMA_ATTRS:
>> +        s->dma_attrs_cfg = data;
>> +        break;
>> +    case ITD_REG_TRANS_DBELL:
>> +        if (data & 0x2) {
> Same suggestion here


Sure I'll introduce named constants for the DMA/translation doorbell 
bits. While reviewing the code, I also noticed that ITD_REG_DMA_DBELL 
only only is written with 1 and ITD_REG_TRANS_DBELL only only is written 
with 2. I’ll fix that as part of v4.


Thanks again for your excellent suggestions!


Yours,

Tao


