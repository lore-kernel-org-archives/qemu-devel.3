Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6C7EC01DF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dpH-0006k3-42; Mon, 23 Mar 2026 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4dpB-0006jl-Qb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4dp8-0002X7-Pp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EE6655969E4;
 Mon, 23 Mar 2026 12:51:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id V2bABg79TmSH; Mon, 23 Mar 2026 12:51:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EDDF05968DD; Mon, 23 Mar 2026 12:51:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBFED5968DC;
 Mon, 23 Mar 2026 12:51:52 +0100 (CET)
Date: Mon, 23 Mar 2026 12:51:52 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH-for-11.0] monitor: Correctly display virtual addresses
 while dumping memory
In-Reply-To: <20260323095020.66658-1-philmd@linaro.org>
Message-ID: <d0a6376c-dcb5-a12a-3b32-8a2c81f32b0e@eik.bme.hu>
References: <20260323095020.66658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-825563091-1774266712=:9762"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-825563091-1774266712=:9762
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Mar 2026, Philippe Mathieu-Daudé wrote:
> While reworking the address format width in commit 6ad593a75a8 we
> introduce a bug, leading to addresses being displayed with too many
> zeroes:
>
>  $ qemu-system-ppc -monitor stdio -S
>  QEMU 10.2.90 monitor - type 'help' for more information
>  (qemu) x/x 0
>  0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>  (qemu) x/x 0xfff00000
>  00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000
>
>  $ qemu-system-ppc64 -monitor stdio -S
>  QEMU 10.2.90 monitor - type 'help' for more information
>  (qemu) x/x 0
>  00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>
> Correct the format width to restore the previous behavior:
>
>  $ qemu-system-ppc -monitor stdio -S
>  QEMU 10.2.90 monitor - type 'help' for more information
>  (qemu) x/x 0
>  00000000: 0x00000000
>
>  $ qemu-system-ppc64 -monitor stdio -S
>  QEMU 10.2.90 monitor - type 'help' for more information
>  (qemu) x/x 0
>  0000000000000000: 0x00000000
>
> Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in memory_dump()")
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> monitor/hmp-cmds.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index bad034937a9..bc26b39d708 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -537,7 +537,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>     uint8_t buf[16];
>     uint64_t v;
>     CPUState *cs = mon_get_cpu(mon);
> -    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
> +    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() / 4);

Thanks, that should help, haven't tried yet. But is_physical used 
HWADDR_FMT_plx before which is "%016" PRIx64 so should that be 16 here to 
preserve previous behaviour? (Both 8 or 16 seem arbitrary, it should 
really depend on the physical address width of target but 64 bits for 
physical seems better as even 32 bit CPUs might have larger phys 
addresses.)

Regards,
BALATON Zoltan

>     const bool big_endian = target_big_endian();
>
>     if (!cs && (format == 'i' || !is_physical)) {
>
--3866299591-825563091-1774266712=:9762--

