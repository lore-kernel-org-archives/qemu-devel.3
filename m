Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0A0E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB8n-00011X-VN; Mon, 29 Dec 2025 06:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB8J-0000sv-7N
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:09:57 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB8H-0004pU-0Y
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:09:50 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7ffa421f1bso1713664366b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006587; x=1767611387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elTFe/G9usLfzNSMna6O8+ASHmYYuTWruhWbYcwRyww=;
 b=zi2b3ZkON87WC4Q63h/4vYFJeRA8IC+p3spSf86945OgJt9klS2jtTuYxOytA6/XVf
 d3AmPthBiFENFtL99aqFBoJmGHHytDRRVATfGyT0OgymKB5buAO6oWnunzzaMST/SDRu
 IUv6GJQVOSAT++0aB79DW1svi6B9GRUxogIbz1SRvXVZCgLiE+cIA1XjpQCeMti28OB1
 d0UuXDwUiUJD6vrNkZQdpTutMOX7Fn0I91P0cnJC20csn4leoSU4nzwIHBn3q6hopaVK
 Y5X+FVt9KFjCx19e/kCQQL1wnBylfEC2v4DgqYCV6kZQi/AfaupDvYc4LXiU0VAryfRx
 j+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006587; x=1767611387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=elTFe/G9usLfzNSMna6O8+ASHmYYuTWruhWbYcwRyww=;
 b=UWkvaoM1iRsi36XqhWlV7pCGFlh6QajHC1hAgBrkYV2nkp/O7IkUBvFELj6yy3rM/j
 pUlS0ob5dX9xXKdsHdSvrSSc+M8B6vgOwmIUVIOE927FfQX2lfjSW636Et4IF00eD5Y+
 3i8s9bJVysBAqjfxGw2WmbtFa1T3kaMuj8TpXgAs1W9ciqD4XSWfE067j/2DwxvNBvb1
 iRSZ4Lk5ssiOB1AaYwh+LAP+mqhF1M0CqdJXoCBlx3q0zA3Kl/ihaKwwuG6J3ectcvTd
 Bnj5fpSngB05vtvnUxUU4dq5gn6CsHfynAd+gNk3brNVssrcZZh4hX11mieSVDBlA7HQ
 NcNQ==
X-Gm-Message-State: AOJu0YzU5747uYExwnPz2SHlYdTJZkqybXZ4AHsk9yPS/FKCmttrzcTG
 IuejfbxhROM6gl6vjlyELQI4k6IxYHUJiWersEQ3LJgIHLpuRkLB6+IyAcd4wk2LuDc17JuouPT
 zWOkS05eZ3L2rM9MezfUT8gPH0GvnoKylbPP1Merp7w==
X-Gm-Gg: AY/fxX5M2HzIalRYQZyYq3Dromz2lr1r+oedl4TA85ZPWPJvhmXXDK1IIu2s+rAxqg3
 PybFB8cQfgNpv6y67p0OBPTS/1M+1KAT04r0P1Dj/+OAeQjEnAtj+SGe9269h9NcR7wqLwGr50N
 m9lXw6EHg5QIDJLwI/Uv/kBCKKdv01VYiugyY6SvI8AwqrXeSNRK2Q3vZSjHPfH8dddgOq6qQIz
 zPFUzkm/6MTHq19qaEKTBM5HXXIsvEDt2cZ96212Men95CJGucHwWncCRK3peAZB8nFQCcP1x24
 oyx8hd/+6SCXjQxcaTY+knTnbNIBb/3h+VLlAA5/ZYsAinUUMA==
X-Google-Smtp-Source: AGHT+IEQ9Um1FWGWiRH+CPjXfZCY1bFuUetz3VOWIHjNkM/180kxTxuhWunbfgmJ6+lpUhHpId36AEPouk6qwSk3weA=
X-Received: by 2002:a17:907:3d8d:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b8035749d19mr3376108866b.16.1767006587178; Mon, 29 Dec 2025
 03:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-7-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:09:21 +0200
X-Gm-Features: AQt7F2o4t88YA9jzRYooKnjqiolsalHxxM4SIQT6JAIozhXYhAB_zG078g1rEAI
Message-ID: <CAAjaMXa_Ui3u1LmFeDvBULXbG2T4XQMBG5nU9fcEHSO1z=_ZKQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] target/s390x: Use big-endian variant of
 cpu_ld/st_data*()
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
> We only build the S390x target using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the
> big endian declarations. Use the explicit big-endian variants.
>
> Mechanical change running:
>
>   $ tgt=3Ds390x; \
>     end=3Dbe; \
>     for op in data mmuidx_ra; do \
>       for ac in uw sw l q; do \
>         sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>       for ac in w l q; do \
>         sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/s390x/tcg/mem_helper.c | 48 +++++++++++++++++------------------
>  target/s390x/tcg/vec_helper.c |  8 +++---
>  2 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.=
c
> index ce9ced8275f..8a7d78f9108 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -101,7 +101,7 @@ static inline uint64_t cpu_ldusize_data_ra(CPUS390XSt=
ate *env, uint64_t addr,
>      case 1:
>          return cpu_ldub_data_ra(env, addr, ra);
>      case 2:
> -        return cpu_lduw_data_ra(env, addr, ra);
> +        return cpu_lduw_be_data_ra(env, addr, ra);
>      default:
>          abort();
>      }
> @@ -117,7 +117,7 @@ static inline void cpu_stsize_data_ra(CPUS390XState *=
env, uint64_t addr,
>          cpu_stb_data_ra(env, addr, value, ra);
>          break;
>      case 2:
> -        cpu_stw_data_ra(env, addr, value, ra);
> +        cpu_stw_be_data_ra(env, addr, value, ra);
>          break;
>      default:
>          abort();
> @@ -865,7 +865,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, u=
int32_t r2)
>              env->cc_op =3D 2;
>              return;
>          }
> -        v =3D cpu_lduw_data_ra(env, str + len, ra);
> +        v =3D cpu_lduw_be_data_ra(env, str + len, ra);
>          if (v =3D=3D c) {
>              /* Character found.  Set R1 to the location; R2 is unmodifie=
d.  */
>              env->cc_op =3D 1;
> @@ -1023,7 +1023,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, u=
int64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        env->aregs[i] =3D cpu_ldl_data_ra(env, a2, ra);
> +        env->aregs[i] =3D cpu_ldl_be_data_ra(env, a2, ra);
>          a2 +=3D 4;
>
>          if (i =3D=3D r3) {
> @@ -1043,7 +1043,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, =
uint64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        cpu_stl_data_ra(env, a2, env->aregs[i], ra);
> +        cpu_stl_be_data_ra(env, a2, env->aregs[i], ra);
>          a2 +=3D 4;
>
>          if (i =3D=3D r3) {
> @@ -1364,7 +1364,7 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t r1=
,
>
>      /* Process full words as available.  */
>      for (len =3D 0; len + 4 <=3D max_len; len +=3D 4, src +=3D 4) {
> -        cksm +=3D (uint32_t)cpu_ldl_data_ra(env, src, ra);
> +        cksm +=3D (uint32_t)cpu_ldl_be_data_ra(env, src, ra);
>      }
>
>      switch (max_len - len) {
> @@ -1373,11 +1373,11 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t =
r1,
>          len +=3D 1;
>          break;
>      case 2:
> -        cksm +=3D cpu_lduw_data_ra(env, src, ra) << 16;
> +        cksm +=3D cpu_lduw_be_data_ra(env, src, ra) << 16;
>          len +=3D 2;
>          break;
>      case 3:
> -        cksm +=3D cpu_lduw_data_ra(env, src, ra) << 16;
> +        cksm +=3D cpu_lduw_be_data_ra(env, src, ra) << 16;
>          cksm +=3D cpu_ldub_data_ra(env, src + 2, ra) << 8;
>          len +=3D 3;
>          break;
> @@ -1956,7 +1956,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        uint64_t val =3D cpu_ldq_data_ra(env, src, ra);
> +        uint64_t val =3D cpu_ldq_be_data_ra(env, src, ra);
>          if (env->cregs[i] !=3D val && i >=3D 9 && i <=3D 11) {
>              PERchanged =3D true;
>          }
> @@ -1993,7 +1993,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, =
uint64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        uint32_t val =3D cpu_ldl_data_ra(env, src, ra);
> +        uint32_t val =3D cpu_ldl_be_data_ra(env, src, ra);
>          uint64_t val64 =3D deposit64(env->cregs[i], 0, 32, val);
>          if ((uint32_t)env->cregs[i] !=3D val && i >=3D 9 && i <=3D 11) {
>              PERchanged =3D true;
> @@ -2029,7 +2029,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        cpu_stq_data_ra(env, dest, env->cregs[i], ra);
> +        cpu_stq_be_data_ra(env, dest, env->cregs[i], ra);
>          dest +=3D sizeof(uint64_t);
>
>          if (i =3D=3D r3) {
> @@ -2049,7 +2049,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
>      }
>
>      for (i =3D r1;; i =3D (i + 1) % 16) {
> -        cpu_stl_data_ra(env, dest, env->cregs[i], ra);
> +        cpu_stl_be_data_ra(env, dest, env->cregs[i], ra);
>          dest +=3D sizeof(uint32_t);
>
>          if (i =3D=3D r3) {
> @@ -2066,7 +2066,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint=
64_t real_addr)
>      real_addr =3D wrap_address(env, real_addr) & TARGET_PAGE_MASK;
>
>      for (i =3D 0; i < TARGET_PAGE_SIZE; i +=3D 8) {
> -        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
> +        cpu_stq_be_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
>      }
>
>      return 0;
> @@ -2325,11 +2325,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1=
, uint64_t r2, uint32_t m4)
>          for (i =3D 0; i < entries; i++) {
>              /* addresses are not wrapped in 24/31bit mode but table inde=
x is */
>              raddr =3D table + ((index + i) & 0x7ff) * sizeof(entry);
> -            entry =3D cpu_ldq_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
> +            entry =3D cpu_ldq_be_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra)=
;
>              if (!(entry & REGION_ENTRY_I)) {
>                  /* we are allowed to not store if already invalid */
>                  entry |=3D REGION_ENTRY_I;
> -                cpu_stq_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
> +                cpu_stq_be_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra=
);
>              }
>          }
>      }
> @@ -2356,9 +2356,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto,=
 uint64_t vaddr,
>      pte_addr +=3D VADDR_PAGE_TX(vaddr) * 8;
>
>      /* Mark the page table entry as invalid */
> -    pte =3D cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
> +    pte =3D cpu_ldq_be_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
>      pte |=3D PAGE_ENTRY_I;
> -    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
> +    cpu_stq_be_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
>
>      /* XXX we exploit the fact that Linux passes the exact virtual
>         address here - it's not obliged to! */
> @@ -2700,7 +2700,7 @@ static int decode_utf16(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>      if (ilen < 2) {
>          return 0;
>      }
> -    s0 =3D cpu_lduw_data_ra(env, addr, ra);
> +    s0 =3D cpu_lduw_be_data_ra(env, addr, ra);
>      if ((s0 & 0xfc00) !=3D 0xd800) {
>          /* one word character */
>          l =3D 2;
> @@ -2711,7 +2711,7 @@ static int decode_utf16(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>          if (ilen < 4) {
>              return 0;
>          }
> -        s1 =3D cpu_lduw_data_ra(env, addr + 2, ra);
> +        s1 =3D cpu_lduw_be_data_ra(env, addr + 2, ra);
>          c =3D extract32(s0, 6, 4) + 1;
>          c =3D (c << 6) | (s0 & 0x3f);
>          c =3D (c << 10) | (s1 & 0x3ff);
> @@ -2735,7 +2735,7 @@ static int decode_utf32(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>      if (ilen < 4) {
>          return 0;
>      }
> -    c =3D cpu_ldl_data_ra(env, addr, ra);
> +    c =3D cpu_ldl_be_data_ra(env, addr, ra);
>      if ((c >=3D 0xd800 && c <=3D 0xdbff) || c > 0x10ffff) {
>          /* invalid unicode character */
>          return 2;
> @@ -2797,7 +2797,7 @@ static int encode_utf16(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>          if (ilen < 2) {
>              return 1;
>          }
> -        cpu_stw_data_ra(env, addr, c, ra);
> +        cpu_stw_be_data_ra(env, addr, c, ra);
>          *olen =3D 2;
>      } else {
>          /* two word character */
> @@ -2807,8 +2807,8 @@ static int encode_utf16(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>          d1 =3D 0xdc00 | extract32(c, 0, 10);
>          d0 =3D 0xd800 | extract32(c, 10, 6);
>          d0 =3D deposit32(d0, 6, 4, extract32(c, 16, 5) - 1);
> -        cpu_stw_data_ra(env, addr + 0, d0, ra);
> -        cpu_stw_data_ra(env, addr + 2, d1, ra);
> +        cpu_stw_be_data_ra(env, addr + 0, d0, ra);
> +        cpu_stw_be_data_ra(env, addr + 2, d1, ra);
>          *olen =3D 4;
>      }
>
> @@ -2821,7 +2821,7 @@ static int encode_utf32(CPUS390XState *env, uint64_=
t addr, uint64_t ilen,
>      if (ilen < 4) {
>          return 1;
>      }
> -    cpu_stl_data_ra(env, addr, c, ra);
> +    cpu_stl_be_data_ra(env, addr, c, ra);
>      *olen =3D 4;
>      return -1;
>  }
> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.=
c
> index 46ec4a947dd..304745c971b 100644
> --- a/target/s390x/tcg/vec_helper.c
> +++ b/target/s390x/tcg/vec_helper.c
> @@ -45,9 +45,9 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t=
 addr, uint64_t bytes)
>      if (likely(bytes >=3D 16)) {
>          uint64_t t0, t1;
>
> -        t0 =3D cpu_ldq_data_ra(env, addr, GETPC());
> +        t0 =3D cpu_ldq_be_data_ra(env, addr, GETPC());
>          addr =3D wrap_address(env, addr + 8);
> -        t1 =3D cpu_ldq_data_ra(env, addr, GETPC());
> +        t1 =3D cpu_ldq_be_data_ra(env, addr, GETPC());
>          s390_vec_write_element64(v1, 0, t0);
>          s390_vec_write_element64(v1, 1, t1);
>      } else {
> @@ -195,9 +195,9 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1,=
 uint64_t addr,
>      probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>
>      if (likely(bytes >=3D 16)) {
> -        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC=
());
> +        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 0), GE=
TPC());
>          addr =3D wrap_address(env, addr + 8);
> -        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC=
());
> +        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 1), GE=
TPC());
>      } else {
>          int i;
>
> --
> 2.52.0
>

