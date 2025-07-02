Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD00C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 04:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWpI1-0006Pj-2y; Wed, 02 Jul 2025 00:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpHy-0006Oy-6L
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:41:42 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpHr-0001Ll-Re
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:41:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 565116000A;
 Wed,  2 Jul 2025 04:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0309C4CEEF;
 Wed,  2 Jul 2025 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751431293;
 bh=P5mSNb/GYxN5q9kpvE4ItjxJ8SksKynXc4n/EiLo61I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BT/YKWah3jYKtdgdQgWtEGRPv6Vsbful0xTKFb8zcdk2Oy8xixUWPZhvV7fJxHhDU
 YnH3nqmnzYa1l7B4yaB1nBkW1wISLlaM/T7b1xXAbhFTMfZEfC7oMLZOKUoF6yeKwC
 KBQtqa8yZ/PQ6UdU1Wy2nkt5hYP7UWltRzfkrERel/tVVi9OpIsf0vaQgOiAmSrYGu
 u2IecDvsIxX33V/C3BUFavcKofCQFhVUYQ4ncz/3guEHVWuygqkDjbzXs3GTGGMem+
 vVoVHiKpEEfyNoqXF16ZX8EqtOYolXXMXuI2Ef1Fxz5rv9kTP7tlKgOuU9UkvLfZu1
 F759L6g6ogKpw==
Date: Wed, 2 Jul 2025 04:41:31 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 02/27] target/i386/emulate: Allow instruction decoding
 from stream
Message-ID: <aGS4e45DuKE26uS6@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-3-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701172834.44849-3-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jul 01, 2025 at 07:28:09PM +0200, Magnus Kulke wrote:
> Introduce a new helper function to decode x86 instructions from a
> raw instruction byte stream. MSHV delivers an instruction stream in a
> buffer of the vm_exit message. It can be used to speed up MMIO
> emulation, since instructions do not have to be fetched and translated.
> 
> Added "fetch_instruction()" op to x86_emul_ops() to improve
> traceability.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/emulate/x86_decode.c | 31 +++++++++++++++++++++++++++----
>  target/i386/emulate/x86_decode.h | 10 ++++++++++
>  target/i386/emulate/x86_emu.c    |  3 ++-
>  target/i386/emulate/x86_emu.h    |  1 +
>  4 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 2eca39802e..133065b50a 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -60,6 +60,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>                                      int size)
>  {
>      uint64_t val = 0;
> +    target_ulong va;

This can be moved inside the else branch to limit the scope of the
variable.

>  
>      switch (size) {
>      case 1:
> @@ -71,10 +72,17 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>          VM_PANIC_EX("%s invalid size %d\n", __func__, size);
>          break;
>      }
> -    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
> -    emul_ops->read_mem(env_cpu(env), &val, va, size);
> +
> +    /* copy the bytes from the instruction stream, if available */
> +    if (decode->stream && decode->len + size <= decode->stream->len) {
> +        memcpy(&val, decode->stream->bytes + decode->len, size);
> +    } else {
> +        va = linear_rip(env_cpu(env), env->eip) + decode->len;

           target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;

> +        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +    }
>      decode->len += size;
> -    
> +
> +

Extraneous blank line here.

>      return val;
>  }
>  
> @@ -2076,9 +2084,10 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
>      }
>  }
>  
> -uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
> +static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
>  {
>      memset(decode, 0, sizeof(*decode));
> +
>      decode_prefix(env, decode);
>      set_addressing_size(env, decode);
>      set_operand_size(env, decode);
> @@ -2088,6 +2097,20 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
>      return decode->len;
>  }
>  
> +uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
> +{
> +    return decode_opcode(env, decode);
> +}
> +
> +uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
> +                                   struct x86_insn_stream *stream)
> +{
> +    if (stream != NULL) {
> +        decode->stream = stream;
> +    }

This can be simplified as

       decode->stream = stream;

> +    return decode_opcode(env, decode);
> +}
> +
>  void init_decoder(void)
>  {
>      int i;
> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
> index 927645af1a..f5e9738914 100644
> --- a/target/i386/emulate/x86_decode.h
> +++ b/target/i386/emulate/x86_decode.h
> @@ -272,6 +272,11 @@ typedef struct x86_decode_op {
>      };
>  } x86_decode_op;
>  
> +typedef struct x86_insn_stream {
> +    const uint8_t *bytes;
> +    size_t len;
> +} x86_insn_stream;
> +
>  typedef struct x86_decode {
>      int len;
>      uint8_t opcode[4];
> @@ -298,11 +303,16 @@ typedef struct x86_decode {
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
> +uint32_t decode_instruction_stream(CPUX86State *env,
> +								   struct x86_decode *decode,
> +		                           struct x86_insn_stream *stream);

Mixing spaces and tabs.

Wei

