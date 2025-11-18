Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC597CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCKf-0004Bn-Jq; Mon, 17 Nov 2025 22:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vLCKc-0004Ac-IG; Mon, 17 Nov 2025 22:24:38 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vLCKX-0004rB-MC; Mon, 17 Nov 2025 22:24:37 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3mLe5htp1KZGAg--.28S2;
 Tue, 18 Nov 2025 11:24:14 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX8O3Z5htpoX0FAA--.10819S2;
 Tue, 18 Nov 2025 11:24:10 +0800 (CST)
Message-ID: <225c5e16-8e50-495e-9785-05edf25ce86f@phytium.com.cn>
Date: Tue, 18 Nov 2025 11:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/3] hw/misc: introduce iommu-testdev for bare-metal
 IOMMU testing
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
 <20251112162152.447327-2-tangtao1634@phytium.com.cn>
 <b087405f179f2d2b8c4224c87c2c562455b9ab6d.camel@eviden.com>
 <7f38ee63-eb24-460c-b8b3-51f3402c4d69@phytium.com.cn>
 <875xb8l4ns.fsf@draig.linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <875xb8l4ns.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8O3Z5htpoX0FAA--.10819S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWkaMBEG7wAHsp
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFyfWry3ur4rWr47Cr13XFb_yoWrWF1UpF
 93GFy3tFWUJrn7Cr4Sqw18GryFv348Jw4UXr13JFn5Xr90yr10qr1jgrWFgFykJrWrJF1U
 Zw1DtF17uw15AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hi Alex

On 2025/11/18 05:39, Alex Bennée wrote:
> Tao Tang <tangtao1634@phytium.com.cn> writes:
>
>> Hi Clement,
>>
>> On 2025/11/13 15:02, CLEMENT MATHIEU--DRIF wrote:
>>> Hi Tao,
>>>
>>> On Thu, 2025-11-13 at 00:21 +0800, Tao Tang wrote:
>>>> Add a minimal PCI test device designed to exercise IOMMU translation
>>>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>>>> provides MMIO registers to configure and trigger DMA operations with
>>>> controllable attributes (security state, address space), enabling
>>>> deterministic IOMMU testing.
>>>>
>>>> Key features:
>>>> - Bare-metal IOMMU testing via simple MMIO interface
>>>> - Configurable DMA attributes for security states and address spaces
>>>> - Write-then-read verification pattern with automatic result checking
>>>>
>>>> The device performs a deterministic DMA test pattern: write a known
>>>> value(0x88888888) to a configured IOVA, read it back, and verify data
>>>> integrity. Results are reported through a dedicated result register,
>>>> eliminating the need for complex interrupt handling or driver
>>>> infrastructure in tests.
>>>>
>>>> This is purely a test device and not intended for production use or
>>>> machine realism. It complements existing test infrastructure like
>>>> pci-testdev but focuses specifically on IOMMU translation path
>>>> validation.
>>>>
>>>> Signed-off-by: Tao Tang <[tangtao1634@phytium.com.cn](mailto:tangtao1634@phytium.com.cn)>
>>>> ---
>>>>    docs/specs/index.rst            |   1 +
>>>>    docs/specs/iommu-testdev.rst    |  96 +++++++++++
>>>>    hw/misc/Kconfig                 |   5 +
>>>>    hw/misc/iommu-testdev.c         | 292 ++++++++++++++++++++++++++++++++
>>>>    hw/misc/meson.build             |   1 +
>>>>    hw/misc/trace-events            |  10 ++
>>>>    include/hw/misc/iommu-testdev.h |  78 +++++++++
>>>>    7 files changed, 483 insertions(+)
>>>>    create mode 100644 docs/specs/iommu-testdev.rst
>>>>    create mode 100644 hw/misc/iommu-testdev.c
>>>>    create mode 100644 include/hw/misc/iommu-testdev.h
>>>>
>>>> ------------------------------<snip>------------------------------
>>>>
>>>>
>>>>
>>>> ------------------------------<snip>------------------------------
>>>> +
>>>> +static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>>>> +{
>>>> +    int i, j, remaining_bytes;
>>> I think i and j could be declared in their respective loop
>>
>> Thanks a lot for taking the time to review the patch. All your
>> suggestions are excellent and make a lot of sense.
>>
>>
>> Move the i and j loop variable declarations into their respective for
>> loops sounds a good idea. But I wasn't entirely sure if QEMU had a
>> strict code style requirement for this, such as mandating all
>> variables be defined at the start of the function before any
>> executable code (C89 style), so I appreciate the clarification.
>>
> <snip>
>
> We have a special exemption, from style.rst:
>
>    Mixed declarations (interleaving statements and declarations within
>    blocks) are generally not allowed; declarations should be at the beginning
>    of blocks. To avoid accidental re-use it is permissible to declare
>    loop variables inside for loops:
>
>    .. code-block:: c
>
>        for (int i = 0; i < ARRAY_SIZE(thing); i++) {
>            /* do something loopy */
>        }
>
>    Every now and then, an exception is made for declarations inside a
>    #ifdef or #ifndef block: if the code looks nicer, such declarations can
>    be placed at the top of the block even if there are statements above.
>    On the other hand, however, it's often best to move that #ifdef/#ifndef
>    block to a separate function altogether.
>

Thanks for the clarification and the pointer to style.rst.
Good to know for (int i = ...) is explicitly allowed — I’ll update the 
patch to declare the loop variables in the for headers in v4.

Best regards,
Tao


