Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ADAE63CA0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk0h7-0005bU-Nd; Sun, 25 Jan 2026 09:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <orion@orions-MacBook-Air.local>)
 id 1vk0Fv-0004YG-7q
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 08:34:19 -0500
Received: from [115.206.96.218] (helo=orions-MacBook-Air.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <orion@orions-MacBook-Air.local>) id 1vk0Fs-000361-0i
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 08:34:18 -0500
Received: by orions-MacBook-Air.local (Postfix, from userid 501)
 id 0714449BAC1; Sun, 25 Jan 2026 21:32:38 +0800 (CST)
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in
 rtl8139_write_buffer
Message-Id: <20260125133239.0714449BAC1@orions-MacBook-Air.local>
Date: Sun, 25 Jan 2026 21:32:38 +0800 (CST)
From: orion@orions-MacBook-Air.local (orion cai)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.206.96.218 (failed)
Received-SPF: none client-ip=115.206.96.218;
 envelope-from=orion@orions-MacBook-Air.local; helo=orions-MacBook-Air.local
X-Spam_score_int: 31
X-Spam_score: 3.1
X-Spam_bar: +++
X-Spam_report: (3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Jan 2026 09:02:06 -0500
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

Reply to: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer
In-Reply-To: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
References: <20260124033346.BB51747D39A@orions-MacBook-Air.local>

On Sat, 24 Jan 2026 at 06:10, orion cai <orion@orions-macbook-air.local> wrote:
>
> From d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 2001
> From: orion cai <orion@orions-MacBook-Air.local>
> Date: Sat, 24 Jan 2026 11:19:17 +0800
> Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer

Hi; thanks for this bug report and patch.

> Fix integer overflow vulnerability in rtl8139_write_buffer() that could allow
> a malicious guest to bypass DMA bounds checks and write to arbitrary memory
> locations.

For clarity, this is an arbitrary write to guest memory,
not to host (QEMU) memory, since we're doing a pci_dma_write(),
correct ?

That renders it a bit less critical, because if you can
program the RTL8139 then you almost certainly already
have kernel level privilege in the guest and can write
to arbitrary guest memory directly if you want...

Yes, you're absolutely correct. The pci_dma_write() writes to guest memory,
not host memory. An attacker would need guest kernel privileges. However,
the bug can still cause guest memory corruption and crashes, so fixing it
improves QEMU's correctness and robustness.

> - RxBufAddr is near UINT_MAX (e.g., 0xFFFF0000)

How can this happen? RxBufAddr is the device's
"Current Buffer Address" register, which is supposed to
be a 16-bit read-only register indicating the total
received byte count in the buffer. If it has ever got
larger than the size of the buffer, then I think we have
a bug somewhere else, and the correct fix is to make
sure we are not letting it get set incorrectly (with
perhaps an assertion in case of other bugs).

Do you have a repro case that triggers this bug? The
ideal here is a qtest repro case which gives the set
of memory writes etc needed to trigger it; for an example
of what that looks like see e.g. this bug:
https://gitlab.com/qemu-project/qemu/-/issues/2777
A guest binary that shows the problem would be OK too.

You raise an excellent point. Looking at the code flow:

In rtl8139_write_buffer() at line 785:
    s->RxBufAddr += size;

This happens for every received packet. The RxBufAddr accumulates over time.
While RxBufAddr is uint32_t, the bounds check at line 748 uses:
    if (s->RxBufAddr + size > s->RxBufferSize)

After many packets, if RxBufAddr reaches a high value (e.g., 0xFFFF0000) and
a moderate-sized packet arrives (size = 0x20000), the addition overflows:
    0xFFFF0000 + 0x20000 = 0x1000 (wraps around!)

The overflow causes the bounds check to pass incorrectly, allowing an
out-of-bounds write.

I've added a qtest case in patch 2/2 that sets RxBufAddr to high values
(0xFFFF0000, 0xFFFFFFFE) to verify the device handles these edge cases.

However, I realize the test only verifies the register can be set to these
values. To fully demonstrate the bug, one would need to:
1. Initialize the device
2. Simulate receiving many packets to accumulate RxBufAddr
3. Trigger the overflow scenario

This is more complex to set up in qtest. Would a unit test that directly
calls rtl8139_write_buffer() with edge case values be acceptable?

> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 9fd00574d2..41b8407acc 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -745,9 +745,16 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
>  {
>      PCIDevice *d = PCI_DEVICE(s);
>
> -    if (s->RxBufAddr + size > s->RxBufferSize)
> +    if (size < 0 || s->RxBufAddr > s->RxBufferSize - (uint32_t)size)

Is it possible to get here with a negative size ?
This is supposed to be the packet size, so if we get here
and it is negative something has gone badly wrong in the
caller. I think it would be better to assert that size >= 0
at the top of the function.

You're correct - this check is unnecessary. Looking at line 825:
    static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t size_, ...)

Since size is size_t (unsigned), it can never be negative. I've removed this
check in v2 and added an assertion instead for documentation.

>      {
> -        int wrapped = MOD2(s->RxBufAddr + size, s->RxBufferSize);
> +        /* Calculate wrapped position safely without overflow.
> +         * Use modulo on each term to prevent overflow.
> +         * RxBufferSize is always a power of 2, so MOD2 is safe. */
> +        int wrapped = MOD2((uint32_t)s->RxBufAddr, s->RxBufferSize) +
> +                    MOD2((uint32_t)size, s->RxBufferSize);
> +        if (wrapped >= s->RxBufferSize) {
> +            wrapped -= s->RxBufferSize;
> +        }

When does this produce a different result to the existing code,
given that RxBufferSize is a power of 2 ? (For QEMU, we
always use -fwrapv, so we do not need to worry about a
signed integer calculation overflowing, as long as it
still produces the right answer, which I think it does here
if I'm not getting confused.)

Good question. In v2, I've reverted to using the original MOD2 calculation
for the wrapped position. After the bounds check passes (using subtraction
to prevent overflow), the addition in MOD2() is safe.

The key is that the bounds check itself must not overflow:
- Vulnerable: RxBufAddr + size > RxBufferSize (can overflow)
- Safe: RxBufAddr > RxBufferSize - size (no overflow)

Once we've validated the bounds with subtraction, calculating the wrapped
position with MOD2(RxBufAddr + size, RxBufferSize) is safe because we know
the result won't overflow.

thanks
-- PMM

---
V2 patches are attached. Main changes:
1. Removed size < 0 check, added assert(size >= 0)
2. Added detailed comments explaining overflow scenario
3. Reverted to original MOD2 calculation for wrapped position
4. Added qtest case for edge case testing

Thank you for the thorough review!

Regards,
Orion
orionhubble@163.com

