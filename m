Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D83EF419A0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzcD-0005SS-H7; Wed, 15 Apr 2026 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzbz-0005NQ-It
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:44:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzbw-0002dT-TW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:44:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 90CED596EAA;
 Wed, 15 Apr 2026 14:44:49 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Hj_2Wf2MWENl; Wed, 15 Apr 2026 14:44:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 895D0596EA1; Wed, 15 Apr 2026 14:44:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87E99596EA9;
 Wed, 15 Apr 2026 14:44:47 +0200 (CEST)
Date: Wed, 15 Apr 2026 14:44:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Feifan Qian <bea1e@proton.me>
cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Chad Jablonski <chad@jablonski.xyz>
Subject: Re: [PATCH 2/2] hw/display/ati: reset host_data.next on early returns
 in ati_host_data_flush()
In-Reply-To: <U62ZPP3C0eUIUhmFb68h6Zbpn_gAjGsyJL3MlLsNd6Y4685t5cgo1IQEs3jQpw27LX8rbQaav04Kd-xLwbQXykyIUq2ouFnbFlMgXoKB_NY=@proton.me>
Message-ID: <42adf9e0-6e57-08e1-5fce-94a43ebad32a@eik.bme.hu>
References: <U62ZPP3C0eUIUhmFb68h6Zbpn_gAjGsyJL3MlLsNd6Y4685t5cgo1IQEs3jQpw27LX8rbQaav04Kd-xLwbQXykyIUq2ouFnbFlMgXoKB_NY=@proton.me>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-133826381-1776257087=:97186"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-133826381-1776257087=:97186
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 15 Apr 2026, Feifan Qian wrote:
> ati_host_data_flush() resets host_data.next to 0 only on the
> success path. Three early-return paths exit without resetting it:
>
> 1. bpp == 24 (unsupported mode)
> 2. unsupported blit direction
> 3. bpp == 0 (invalid dp_datatype nibble) which additionally
> causes an integer divide-by-zero at:
> pix_count /= ctx.bpp; /* 128 / 0 -> SIGFPE */
>
> When next is not reset it stays >= 4, allowing the HOST_DATA write
> handler to index past the end of host_data.acc[] on the next write.
>
> Reset host_data.next = 0 on every early-return path. Also add an
> explicit bpp == 0 guard (with LOG_GUEST_ERROR) before the bpp == 24
> check to prevent the divide-by-zero.
>
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> hw/display/ati_2d.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 504d1c5708..e0198ca6ea 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -367,9 +367,16 @@ bool ati_host_data_flush(ATIVGAState *s)
>
> setup_2d_blt_ctx(s, &ctx);
>
> + if (!ctx.bpp) {
> + qemu_log_mask(LOG_GUEST_ERROR,
> + "host_data_blt: invalid bpp\n");
> + s->host_data.next = 0;
> + return false;
> + }
> if (ctx.bpp == 24) {
> qemu_log_mask(LOG_UNIMP,
> "host_data_blt: unsupported in 24 bits mode\n");
> + s->host_data.next = 0;
> return false;
> }
> if (!ctx.left_to_right || !ctx.top_to_bottom) {
> @@ -377,6 +384,7 @@ bool ati_host_data_flush(ATIVGAState *s)
> "host_data_blt: unsupported blit direction %c%c\n",
> ctx.left_to_right ? '>' : '<',
> ctx.top_to_bottom ? 'v' : '^');
> + s->host_data.next = 0;
> return false;
> }

Patch again misformatted. So with this patch 1/2 should not be needed. I'd 
let Chad decide how this could be fixed best.

Regards,
BALATON Zoltan

> --
> 2.43.0
>
> On Wednesday, April 15th, 2026 at AM 11:34, Feifan Qian <bea1e@proton.me> wrote:
>
>> The HOST_DATA write handler stores guest-supplied dwords into a
>> 4-element accumulator array (host_data.acc[0..3]) and calls
>> ati_host_data_flush() once four entries are collected. When
>> ati_host_data_flush() returns early without resetting next (e.g.
>> for unsupported 24-bpp or direction modes), next remains >= 4.
>> Because the write acc[next++] occurs before the next >= 4 check,
>> the subsequent HOST_DATA dword is stored at acc[4] — one element
>> past the end of ATIHostDataState, the last field of the
>> heap-allocated ATIVGAState object. The payload is guest-controlled
>> and the overflow is repeatable.
>>
>> Confirmed with AddressSanitizer: heap-buffer-overflow WRITE of
>> 4 bytes at ati.c:1032 on QEMU 11.0.0-rc3 via QTest.
>>
>> Add an explicit bounds check on next before indexing acc[]; log a
>> guest error and break without writing if next is out of range.
>>
>> Signed-off-by: Feifan Qian <bea1e@proton.me>
>> ---
>> hw/display/ati.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 88a5bbbf07..3039606202 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -1029,6 +1029,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>> if (!s->host_data.active) {
>> break;
>> }
>> + if (s->host_data.next >= ARRAY_SIZE(s->host_data.acc)) {
>> + qemu_log_mask(LOG_GUEST_ERROR,
>> + "HOST_DATA: accumulator overflow, ignoring\n");
>> + break;
>> + }
>> s->host_data.acc[s->host_data.next++] = data;
>> if (addr == HOST_DATA_LAST) {
>> ati_host_data_finish(s);
>> --2.43.0
--3866299591-133826381-1776257087=:97186--

