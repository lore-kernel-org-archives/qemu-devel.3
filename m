Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C092D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB8X-0000so-3d; Mon, 29 Dec 2025 06:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB7u-0000rj-0o
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:09:34 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB7q-0004oJ-MD
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:09:24 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so1147316866b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006561; x=1767611361; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHohQCWdOmxLuHOlfgCt3ZRfqd+cnOvBtxJfUeUsvMc=;
 b=oldhGVpghzJPgCcSjsNKJzNkjXKrZfcdks2BJYu2LxHZZwm+mKjoBAY8o9EQdqkPW3
 ZP9WBnWVvZFvSED4r/0SQ+fsD6VQ9pg6ieKYVEXIqCjNbAJiVLBT990tSx4XXIdvJfV6
 FAYkeTn/WGIB1ZQQAaK7z1QVJR3Z7pVz42GIhYgnyeOO4QMv+NbprZi/QHCjaFIRe089
 23MQcR5HYPRSrM1BAL8kdobPlLBf6IOffQuJVSawqsMOi5vff9ji2ncq6ahUrGK7LMDw
 xcmoEjuIBJNCqGUNzYp0NXdaLTwIQCXCT+VJVTYS8DiJmVRxS+oDYOT7z2eCFwJesizy
 c6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006561; x=1767611361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FHohQCWdOmxLuHOlfgCt3ZRfqd+cnOvBtxJfUeUsvMc=;
 b=W4TbGCaiYnvOUrETGLcUo0uoJ5mvA6u4xE2FykyNgB46h0gL7Oey7AU8pF2zZ+nSp5
 HU9VxgerigXkVqprZjUQKmaPU5emUhKwqtbpNT03WhnPD1nBWSfqLuitmX4ODNb7qM1Y
 OZEyDWUAAS3YKdbDidaaU/g0MsN9+lP2Px5Pb6/Roxxa90O4x03AQf7GAVum1FI34/Bj
 Wz++DPVTZTp0vQM5NdU7NYh9lM86F779G5fLR4/Tb1MHlW6s1jTReNVm3nC+Ssz6Kqss
 vM8VZk+z/eZK61sI1ggwpCLrX3NqBf66AG+RuPJV33cpFs9NLg+F2ZGCwu4wicaiZSrs
 W52g==
X-Gm-Message-State: AOJu0Yy5sPYcaIPN1fsQeliGsR7z0MBWUxx2iG2Q4byGlYU+6W+uQpP9
 RLCFppzXtb68HgWh743LFSjg6NS+D648B52gdMdKdwT6uJfhr4YAUBJiVUCq/5QQBge00v4l6rA
 djAuES2AYaBEvh4ALueqIg9dY2NO/DqV3KxWWwsYP2A==
X-Gm-Gg: AY/fxX6dARzm+v5IhJcsKSXIV2eyhu8s63LWh607L6BdhpHEGDemttsLuhsnpG5RnH2
 d+i2jqFhq7bhvmbHZHarmHdXX9XT6LoVjiEJOJhFo1h4lt3b/HxWqEHKQ/TkOIYgUkadc3Knu0j
 nF0i4ROxMLJm1672ohYnNhYSeQs2ncUqY9G0lz+ve0zjgPxV/H80JpsXWhTmvvAoaO+iGqW1ssa
 JZ6IeiYbNAnhxD3X6NbGZG2ikrBCM6bOFvd9LKUKOuoBy8dPFA1OqKgV6iRAMSJ1kgc6KspTbak
 8s4JGhTKT+wylLmibQ3y+gxtzC8dpAC3wAkjKUQ=
X-Google-Smtp-Source: AGHT+IHHZzGigouLwu1Exj2Ubo1STQbO2ebJJSqqDUf9txBe4p4tDI4HEY4OIzD0xBtsRL0NrJDBOYattLi0miWvFDs=
X-Received: by 2002:a17:907:868e:b0:b76:4c8f:2cd8 with SMTP id
 a640c23a62f3a-b8037233e75mr3023579066b.55.1767006560762; Mon, 29 Dec 2025
 03:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-6-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:08:54 +0200
X-Gm-Features: AQt7F2qAVJS_yTg-o8ZwYNeyWuSeHAoZmMWgFJRBKzMZPdKPy_woi4GND7VOYjQ
Message-ID: <CAAjaMXZ1oS6AaOqDkJBu2y-omuC2YAdD2OtXgBNknjwE_h0ySw@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/s390x: Inline cpu_ld{uw, l}_code() calls in EX
 opcode helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, Dec 24, 2025 at 6:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In preparation of removing the cpu_lduw_code() and cpu_ldl_code()
> wrappers, inline them.
>
> Since S390x instructions are always stored in big-endian order,
> replace MO_TE -> MO_BE.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/s390x/tcg/mem_helper.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.=
c
> index 507eb7feac7..ce9ced8275f 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -2430,15 +2430,18 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t=
 r1, uint64_t addr)
>  */
>  void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t=
 addr)
>  {
> +    CPUState *cs =3D env_cpu(env);
>      uint64_t insn;
>      uint8_t opc;
> +    MemOpIdx oi;
>
>      /* EXECUTE targets must be at even addresses.  */
>      if (addr & 1) {
>          tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>
> -    insn =3D cpu_lduw_code(env, addr);
> +    oi =3D make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
> +    insn =3D cpu_ldw_code_mmu(env, addr, oi, 0);
>      opc =3D insn >> 8;
>
>      /* Or in the contents of R1[56:63].  */
> @@ -2450,10 +2453,11 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen=
, uint64_t r1, uint64_t addr)
>      case 2:
>          break;
>      case 4:
> -        insn |=3D (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
> +        insn |=3D (uint64_t)cpu_ldw_code_mmu(env, addr + 2, oi, 0) << 32=
;
>          break;
>      case 6:
> -        insn |=3D (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
> +        oi =3D make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
> +        insn |=3D (uint64_t)(uint32_t)cpu_ldl_code_mmu(env, addr + 2, oi=
, 0) << 16;
>          break;
>      default:
>          g_assert_not_reached();
> --
> 2.52.0
>

