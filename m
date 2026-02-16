Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A19E81A3C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs121-0001Q4-UV; Mon, 16 Feb 2026 11:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs11b-0001P0-Qf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:00:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs11X-0005W1-Ef
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Lwt0kwTDz7UOcAmTU0eaHMXMyjNDAEUnNXpwrIa/54c=; b=rmZEVtinWIFRyFs
 wNWTdCY4C76m2bXMvUI5ELsoyitjNHIkmJeUtMkPF9gKUDt5qxpn0ZMyuaia6/YBnPVw9hO8yhfSl
 SyUx8PU6VUa42kj/2l8ztag8NZm4Rnx7yx7A50o/I1ocxXCBa/ImlhJBB/B7zhQipA1PWR/Tln3d6
 ig=;
Date: Mon, 16 Feb 2026 17:03:52 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v2 6/8] Hexagon (target/hexagon) Disassembly of invalid
 packets
Message-ID: <aZM2v8J4RP7RgB_u@hive.localdomain>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-7-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260215220422.212249-7-ltaylorsimpson@gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/02/26, Taylor Simpson wrote:
> We pass the Hexagon CPU version to disassemble_hexagon.  This allows
> decode_packet to know if the opcodes are supported.
> 
> Note that we print valid instructions in a packet when one or more is
> invalid.  Rather than this
> 0x0002128c:  0x1eae4fec	{	<invalid>
> 0x00021290:  0x1c434c04		<invalid>
> 0x00021294:  0x1e03edf0		<invalid> }
> 
> We print this
> 0x0002128c:  0x1eae4fec	{	<invalid>
> 0x00021290:  0x1c434c04		V4.w = vadd(V12.w,V3.w)
> 0x00021294:  0x1e03edf0		V16 = V13 }
> 
> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/cpu_bits.h  |  4 +++-
>  target/hexagon/printinsn.h |  3 ++-
>  disas/hexagon.c            |  3 ++-
>  target/hexagon/cpu.c       |  3 +++
>  target/hexagon/decode.c    | 22 ++++++++++++++++++----
>  target/hexagon/printinsn.c |  9 +++++++--
>  6 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 19beca81c0..80d99f5df9 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -19,6 +19,7 @@
>  #define HEXAGON_CPU_BITS_H
>  
>  #include "qemu/bitops.h"
> +#include "cpu-qom.h"
>  
>  #define PCALIGN 4
>  #define PCALIGN_MASK (PCALIGN - 1)
> @@ -65,6 +66,7 @@ static inline bool is_packet_end(uint32_t endocing)
>      return ((bits == 0x3) || (bits == 0x0));
>  }
>  
> -int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf);
> +int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf,
> +                        HexagonVersion hex_version);
>  
>  #endif
> diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
> index 2ecd1731d0..d437d35005 100644
> --- a/target/hexagon/printinsn.h
> +++ b/target/hexagon/printinsn.h
> @@ -18,10 +18,11 @@
>  #ifndef HEXAGON_PRINTINSN_H
>  #define HEXAGON_PRINTINSN_H
>  
> +#include "cpu-qom.h"
>  #include "insn.h"
>  
>  void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
> -                         target_ulong pc);
> +                         target_ulong pc, HexagonVersion hex_version);
>  void snprint_a_pkt_debug(GString *buf, Packet *pkt);
>  
>  #endif
> diff --git a/disas/hexagon.c b/disas/hexagon.c
> index c1a4ffc5f6..9a18f12854 100644
> --- a/disas/hexagon.c
> +++ b/disas/hexagon.c
> @@ -31,6 +31,7 @@
>  
>  int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
>  {
> +    HexagonVersion hex_version = (HexagonVersion)info->target_info;


Don't store the HexagonVersion directly in the pointer, clang gets
angry, just take the address of hex_version

  ../disas/hexagon.c:34:34: error: cast to smaller integer type 'HexagonVersion' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
     34 |     HexagonVersion hex_version = (HexagonVersion)info->target_info;





>      uint32_t words[PACKET_WORDS_MAX];
>      bool found_end = false;
>      GString *buf;
> @@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
>      }
>  
>      buf = g_string_sized_new(PACKET_BUFFER_LEN);
> -    len = disassemble_hexagon(words, i, memaddr, buf);
> +    len = disassemble_hexagon(words, i, memaddr, buf, hex_version);
>      (*info->fprintf_func)(info->stream, "%s", buf->str);
>      g_string_free(buf, true);
>  
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 09a0de3c2f..4b16214ace 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -314,8 +314,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>  static void hexagon_cpu_disas_set_info(const CPUState *cs,
>                                         disassemble_info *info)
>  {
> +    CPUState *cs_nonconst = (CPUState *)cs;  /* so we can get hex_cpu */
> +    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs_nonconst));
>      info->print_insn = print_insn_hexagon;
>      info->endian = BFD_ENDIAN_LITTLE;
> +    info->target_info = (void *)HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
>  }

Take the address of hex_version here.

The const cast is a bit sad, took a look at other targets and riscv uses
the object cast macros instead, so something like

  static void hexagon_cpu_disas_set_info(const CPUState *cs,
                                         disassemble_info *info)
  {
      const HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(cs);
      ...
      info->target_info = (void *)&mcc->hex_version;
  }

but I don't know if assuming Object * == CPUState * == ArchCPU * is any
better..  Maybe someone else can comment on this.

-- 
Anton Johansson
rev.ng Labs Srl.

