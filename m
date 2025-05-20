Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03221C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQmn-000592-Bz; Tue, 20 May 2025 13:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHQml-00058o-Pn
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:29:51 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHQmj-0006fh-OL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:29:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B7BDE614BD;
 Tue, 20 May 2025 17:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3033CC4CEE9;
 Tue, 20 May 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747762186;
 bh=P1y22j6AamR/yv/Dg9qGE/a43aq5gGwW8LGZBETTRB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KuS5KLPHwjzPz2YrUabYNhrWrj5ktTkMLgrfH0o4T/tDK6nHX6+6/UInaGhh6BkUi
 v+D9Y7NdSLzwNyMPSoH0QdF6boPO3yIhHLsyDQyDNToUQx3/0flVoWAt4jWW0EsdMT
 XZiUXbnrE48RwKyGK3bu71pmNCivD0FIc2dIKBO/4GO0gbdHtWmcXJlPrJDaoIh6VP
 2f9DodRXexM5tJ5NDNGfVCTvxBn2aAiSg57RA+n1hIhe46IHWV8kCE0gJLZSoYD7yG
 IgWVzO4uDCh7jJC1nirgVo8svCUbu2KrbgiWeI+lYQJDiE/3tVEfss4gxK7UrJGcKy
 bz89sCO4Cun/Q==
Date: Tue, 20 May 2025 17:29:44 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 02/25] target/i386/emulate: allow instruction
 decoding from stream
Message-ID: <aCy8CNwp_aZ8xa-B@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-3-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-3-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 20, 2025 at 01:29:55PM +0200, Magnus Kulke wrote:
> Introduce a new helper function to decode x86 instructions from a
> raw instruction byte stream. MSHV delivers an instruction stream in a
> buffer of the vm_exit message. It can be used to speed up MMIO
> emulation, since instructions do not have to be fetched and translated.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/emulate/x86_decode.c | 32 +++++++++++++++++++++++++++-----
>  target/i386/emulate/x86_decode.h | 11 +++++++++++
>  target/i386/emulate/x86_emu.c    |  3 ++-
>  target/i386/emulate/x86_emu.h    |  1 +
>  4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 88be9479a8..7a862b976e 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -60,6 +60,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>                                      int size)
>  {
>      uint64_t val = 0;
> +    target_ulong va;
>  
>      switch (size) {
>      case 1:
> @@ -71,10 +72,16 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>          VM_PANIC_EX("%s invalid size %d\n", __func__, size);
>          break;
>      }
> -    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
> -    emul_ops->read_mem(env_cpu(env), &val, va, size);
> +
> +	/* copy the bytes from the instruction stream, if available */
> +	if (decode->stream && decode->len + size <= decode->stream->len) {
> +		memcpy(&val, decode->stream->bytes + decode->len, size);
> +	} else {
> +		va = linear_rip(env_cpu(env), env->eip) + decode->len;
> +		emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +	}

You're using tabs here.

>      decode->len += size;
> -    
> +

Unrelated whitespace change.

>      return val;
>  }
>  
> @@ -2076,9 +2083,8 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
>      }
>  }
>  
> -uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
> +static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
>  {
> -    memset(decode, 0, sizeof(*decode));

Why lift this out to its callers when in both cases they need to call
memset anyway?

>      decode_prefix(env, decode);
>      set_addressing_size(env, decode);
>      set_operand_size(env, decode);
> @@ -2088,6 +2094,22 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
>      return decode->len;
>  }
>  
> +uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
> +{
> +	memset(decode, 0, sizeof(*decode));
> +	return decode_opcode(env, decode);
> +}
> +
> +uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
> +		                           struct x86_insn_stream *stream)
> +{
> +	memset(decode, 0, sizeof(*decode));
> +	if (stream != NULL) {
> +		decode->stream = stream;
> +	}
> +	return decode_opcode(env, decode);
> +}
> +
>  void init_decoder(void)
>  {
>      int i;
> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
> index 87cc728598..9bc7d6cc49 100644
> --- a/target/i386/emulate/x86_decode.h
> +++ b/target/i386/emulate/x86_decode.h
> @@ -269,6 +269,11 @@ typedef struct x86_decode_op {
>      target_ulong ptr;
>  } x86_decode_op;
>  
> +typedef struct x86_insn_stream {
> +	const uint8_t *bytes;
> +	size_t len;
> +} x86_insn_stream;
> +
>  typedef struct x86_decode {
>      int len;
>      uint8_t opcode[4];
> @@ -295,12 +300,18 @@ typedef struct x86_decode {
>      struct x86_modrm modrm;
>      struct x86_decode_op op[4];
>      bool is_fpu;
> +
> +	x86_insn_stream *stream;

Tab here.

>  } x86_decode;
>  
>  uint64_t sign(uint64_t val, int size);
>  
>  uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
>  
> +uint32_t decode_instruction_stream(CPUX86State *env,
> +								   struct x86_decode *decode,

Tabs here again.

I suppose you will need to configure your editor correctly and change
from tabs to spaces.

Thanks,
Wei.

> +		                           struct x86_insn_stream *stream);
> +
>  target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
>                           int is_extended, int size);
>  target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
> diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
> index 7773b51b95..73c9eb41d1 100644
> --- a/target/i386/emulate/x86_emu.c
> +++ b/target/i386/emulate/x86_emu.c
> @@ -1241,7 +1241,8 @@ static void init_cmd_handler(void)
>  bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
>  {
>      if (!_cmd_handler[ins->cmd].handler) {
> -        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
> +        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n",
> +                env->eip,
>                  ins->cmd, ins->opcode[0],
>                  ins->opcode_len > 1 ? ins->opcode[1] : 0);
>          env->eip += ins->len;
> diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
> index 555b567e2c..761e83fd6b 100644
> --- a/target/i386/emulate/x86_emu.h
> +++ b/target/i386/emulate/x86_emu.h
> @@ -24,6 +24,7 @@
>  #include "cpu.h"
>  
>  struct x86_emul_ops {
> +    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>      void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>      void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>      void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
> -- 
> 2.34.1
> 

