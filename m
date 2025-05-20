Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3305FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMIc-0006vd-5x; Tue, 20 May 2025 08:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMIV-0006qc-Si
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMIR-0006N4-2r
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747744932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8sLKED9xztYpJL6Cputh/Gko7jNsGpx2HBNd47GILhs=;
 b=A12LpNiFuvt/sCnd4x/RuQ/hOpi0MsZcVHuE7ab+4QbGM0dJfsO4Z8GiD1YEmmLW29cg6e
 Yx2CBeIw8SbGywnma16uaXToPlv322HDk2dfmRUVWeWw0NSw0Saa5BC2ALw12UIicSz79j
 o/K+yd9rSXvOf1X5JLD9CqdVGjw+VhA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-VivQBm7FO9umj_-Fm_A04A-1; Tue, 20 May 2025 08:42:11 -0400
X-MC-Unique: VivQBm7FO9umj_-Fm_A04A-1
X-Mimecast-MFC-AGG-ID: VivQBm7FO9umj_-Fm_A04A_1747744930
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad5271a051eso449410266b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744930; x=1748349730;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sLKED9xztYpJL6Cputh/Gko7jNsGpx2HBNd47GILhs=;
 b=A78bCcS5QnVjnGSeU9iyMPQwp4bDTr5v/rXBAaRvbv44XCBU8/Hp5zBJnpURjz+gXO
 ksH7UAoIM7yKgJhdZfaJYyNsv047U7I1tVxez9EIMosGEyX2QoWZjH40DPaTazN6+Wqe
 UjWqu5KXXYPEo0ZQ0p7z68WNF+8hs7fl22v5vDvcPvnqlcNb6luNQ3eFclyuXN+sEQ9G
 RgkIQZa1P8jjNV1btRxrJHw1lg1bkS9rkQIJuZ3n+ze9+2bHEZoSICwsFtg/hWcbbnAd
 51X4mgI2ZczcK2HmjI2YP/bJ1Q5gcKrn0bH8l6vGCXc4qI+s9ZcHYAOQaaV1Cl01IxJb
 SQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl3rFoyBrZjME5lTWIzihohd1SbFhIHYLq8Bu/5cEC5t0pFFDvdHdtU+nTGOEl2MkiYwQbQo10m/pY@nongnu.org
X-Gm-Message-State: AOJu0YyEm8ALOjb4mZoCzp7HS51RaBvEsjQVfqPa7sG70DX88mP3jWwt
 vj6lT/Fi4ndof3c1xyFjb2sXK4NTQ3oYVoI0UXghf8i7uzatwua8mRVMOisM2dS/CqNLJ5l1ggw
 ojlLY1dtxdDjZdIWy2K+ZLRwH4bQ/0PHb0TEzX0TG4DSOE30nuQI3iJGG8bcMkyP7
X-Gm-Gg: ASbGncvdmFnBg2sKvx5/19affW9V1CYG5aR8AJ79zvwkWZYditihwDjklVE93CV4PSG
 kt5VGO7MgYGOLrSdFPZyYpjmhb2kJ+teZw9Ev/tdMqAkY0IGr+aZ7Bk9QrbWFL/3cnvpsFM1/Sk
 xAsgNv2Jo2BVhsfW9930a6E3mCsqu655snrA73tRAdXSUhvvJs4Na/PzMSmwM7NnotMHLLF/cnK
 5EtGX+i0Jjl+qn7gaMyfufZdiIN4JDADI8aQLYCXsuoO56mgsQKSWWoHrf2iWtXM0u6MNX4ruu/
 iD0Oc+348sod2w==
X-Received: by 2002:a17:906:3194:b0:ad5:32d8:1360 with SMTP id
 a640c23a62f3a-ad532d8161bmr1016754566b.34.1747744929781; 
 Tue, 20 May 2025 05:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvdkPsE8n/1QtNovIx4z7G3e+OOoSvj2ikflGUq2Q5fdFSXVO951J1Koqimmxiz35NbSSrPg==
X-Received: by 2002:a17:906:3194:b0:ad5:32d8:1360 with SMTP id
 a640c23a62f3a-ad532d8161bmr1016751366b.34.1747744929330; 
 Tue, 20 May 2025 05:42:09 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d4f8e40sm713645866b.183.2025.05.20.05.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:42:08 -0700 (PDT)
Message-ID: <c8a8971e-5cf6-4a13-a01b-1d3cd25fd0fb@redhat.com>
Date: Tue, 20 May 2025 14:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/25] target/i386/emulate: allow instruction decoding
 from stream
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-3-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20250520113018.49569-3-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/25 13:29, Magnus Kulke wrote:
> Introduce a new helper function to decode x86 instructions from a
> raw instruction byte stream. MSHV delivers an instruction stream in a
> buffer of the vm_exit message. It can be used to speed up MMIO
> emulation, since instructions do not have to be fetched and translated.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Missing update of hvf_x86_emul_ops.

Paolo

> ---
>   target/i386/emulate/x86_decode.c | 32 +++++++++++++++++++++++++++-----
>   target/i386/emulate/x86_decode.h | 11 +++++++++++
>   target/i386/emulate/x86_emu.c    |  3 ++-
>   target/i386/emulate/x86_emu.h    |  1 +
>   4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 88be9479a8..7a862b976e 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -60,6 +60,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>                                       int size)
>   {
>       uint64_t val = 0;
> +    target_ulong va;
>   
>       switch (size) {
>       case 1:
> @@ -71,10 +72,16 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>           VM_PANIC_EX("%s invalid size %d\n", __func__, size);
>           break;
>       }
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
>       decode->len += size;
> -
> +
>       return val;
>   }
>   
> @@ -2076,9 +2083,8 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
>       }
>   }
>   
> -uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
> +static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
>   {
> -    memset(decode, 0, sizeof(*decode));
>       decode_prefix(env, decode);
>       set_addressing_size(env, decode);
>       set_operand_size(env, decode);
> @@ -2088,6 +2094,22 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
>       return decode->len;
>   }
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
>   void init_decoder(void)
>   {
>       int i;
> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
> index 87cc728598..9bc7d6cc49 100644
> --- a/target/i386/emulate/x86_decode.h
> +++ b/target/i386/emulate/x86_decode.h
> @@ -269,6 +269,11 @@ typedef struct x86_decode_op {
>       target_ulong ptr;
>   } x86_decode_op;
>   
> +typedef struct x86_insn_stream {
> +	const uint8_t *bytes;
> +	size_t len;
> +} x86_insn_stream;
> +
>   typedef struct x86_decode {
>       int len;
>       uint8_t opcode[4];
> @@ -295,12 +300,18 @@ typedef struct x86_decode {
>       struct x86_modrm modrm;
>       struct x86_decode_op op[4];
>       bool is_fpu;
> +
> +	x86_insn_stream *stream;
>   } x86_decode;
>   
>   uint64_t sign(uint64_t val, int size);
>   
>   uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
>   
> +uint32_t decode_instruction_stream(CPUX86State *env,
> +								   struct x86_decode *decode,
> +		                           struct x86_insn_stream *stream);
> +
>   target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
>                            int is_extended, int size);
>   target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
> diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
> index 7773b51b95..73c9eb41d1 100644
> --- a/target/i386/emulate/x86_emu.c
> +++ b/target/i386/emulate/x86_emu.c
> @@ -1241,7 +1241,8 @@ static void init_cmd_handler(void)
>   bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
>   {
>       if (!_cmd_handler[ins->cmd].handler) {
> -        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
> +        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n",
> +                env->eip,
>                   ins->cmd, ins->opcode[0],
>                   ins->opcode_len > 1 ? ins->opcode[1] : 0);
>           env->eip += ins->len;
> diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
> index 555b567e2c..761e83fd6b 100644
> --- a/target/i386/emulate/x86_emu.h
> +++ b/target/i386/emulate/x86_emu.h
> @@ -24,6 +24,7 @@
>   #include "cpu.h"
>   
>   struct x86_emul_ops {
> +    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>       void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>       void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
>       void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,


