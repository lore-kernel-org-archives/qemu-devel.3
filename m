Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E02E7544F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 18:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYThT-0007t6-6T; Wed, 24 Dec 2025 13:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYThR-0007sG-J9
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:35:05 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYThO-0003kO-LK
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:35:05 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so899084066b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766601300; x=1767206100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j71f81UV4uha+pe8ssv3Ee5GmaM176fkQwsgoIxlcAs=;
 b=b1ti9TA5X5Tf9BerOIBcjAMeVlmenJtRW29naGRcynqKI1PPP4jb1T468eiE72bnTk
 jbCUmQzfDlB2EggVVFQXPKlzJMjyNVQoE9oXjGLGE3NLKcUfsMzzQB69upGqYR6JH5F4
 g4wyzmsqbPxhBTE3KO5f/FWo/s2kuec1TONskiw14V2wvw6guMPwmfaswZOWpsPeq9tD
 xQ1Uk2WCeKwmjb5mTAyskbP4MevN+CKQH+jquT2DZ4N5BEdmzwxAB+skMJykg3JMofcb
 kcsYm9nosR3SmMWHpc/pJ39zxb2Z62wdP4bNULnTuW/cTWCMq7hcGg/4JIqTlqaWaT+L
 gTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766601300; x=1767206100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j71f81UV4uha+pe8ssv3Ee5GmaM176fkQwsgoIxlcAs=;
 b=pyM5jfRhneYNMFoNnISAflDzMBs9UCynKjXTBTGodut5s5PGq4w1GWLGubHDvnYcII
 jKsOqiuKZPFTTwcGnz8VDjyHY0qVb0zmtNX9DWYRzfC4M4jQBMD7QJEn/Ce22YDaz/9j
 pS8VGYQaoMwt66u3VyLyNUptefHM746g+Tw7giEsvvZot57877GOZcMwPKOkP279ipND
 6yZ/UcgMmrWNH4SJLem/txFU2dibLIfozK7CkXP/KgqQqDnKL0ayrxrmtKGZYYafLd0X
 Vv/Pmo14HWObyZ7b7pGVrIQlhCpyhBEK06UEznlaAZ2XJWp61sT1qZT5lhGj0p8MIQZP
 cOvw==
X-Gm-Message-State: AOJu0Yz6yt6IRBdX+kBB6Zs0nFL5KXWUHZRipAE2r458vy11kmfQQrpN
 8JeA7VSmV0/CKEDsJqclza4jxKZj/Jf1vqZOuK3ZV18QAuHWyALVoZ8z6GY2SdylPGfMna1nM3f
 jQU8u4ECOXVBYQsyURVWmBgHBvt9andE0E+0x+bmmnw==
X-Gm-Gg: AY/fxX6BRkBZRBTdI2EyKSysWK4KyCaeeX6pVlPIh6yBWrKlti5w+zZ4Y2G147Rudx0
 GcJ26lS3IAQCzwpc6KcwALiKgLyU6NMqXIJJAiIA70NfUqbP85dm2uHMWERzkIY63LgIi+8/I35
 P0c37giz85ohr9A4EJ5MMFRsGRigXo01TFN7II740AEe2WdFizCQfFBD7UggiDvrypv/o9H/c0z
 5GSq+1Cd6zBJAycpJnrl/avkWviQcQsrDs2/Ib1IVmmMvv2zSoC64Ub25EMC2MjReNhi5X5nX6D
 B54Tuw==
X-Google-Smtp-Source: AGHT+IEtzqpKBxUerNDaGmgmCqeeyzrStGf6451TK7nCBqndXCD9+nqt49C+p3Qx7jPpFGdRAc/xeFsjoEZmAfgqj1g=
X-Received: by 2002:a17:907:1b2a:b0:b80:10c0:35d8 with SMTP id
 a640c23a62f3a-b803705123fmr1892709066b.39.1766601300181; Wed, 24 Dec 2025
 10:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-6-philmd@linaro.org>
In-Reply-To: <20251224151351.86733-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 20:34:34 +0200
X-Gm-Features: AQt7F2oUj5Wtajv4tK-JMklDQJy00a0Fxk2AmiVUYRKsdSs6jHIvrfPExsVAUBo
Message-ID: <CAAjaMXZXSBQx+tQOyg6PVr1Y5R0c0uFsMrC9TdWE4mcvvejKZA@mail.gmail.com>
Subject: Re: [PATCH 5/9] system/memory: Allow restricting legacy ldst_phys()
 API usage
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 David Hildenbrand <david@kernel.org>, qemu-riscv@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 24, 2025 at 5:14=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Commit 500131154d6 ("exec.c: Add new address_space_ld*/st*
> functions") added a new API to fix a shortcoming of the
> ld/st*_phys() API, which does blind bus access, not reporting
> failure (and it also allow to provide transaction attributes).
>
> Later commit 42874d3a8c6 ("Switch non-CPU callers from ld/st*_phys
> to address_space_ld/st*") automatically converted the legacy uses
> to the new API, not precising transaction attributes
> (MEMTXATTRS_UNSPECIFIED) and ignoring the transation result (passing
> NULL pointer as MemTxResult).
>
> While this is a faithful replacement, without any logical change,
> we later realized better is to not use MEMTXATTRS_UNSPECIFIED or
> NULL MemTxResult, and adapt each call site on a pair basis, looking
> at the device model datasheet to do the correct behavior (which is
> unlikely to ignore transaction failures).
>
> Since this is quite some work, we defer that to device model
> maintainers. Meanwhile we introduce a definition, to allow a
> target which removed all legacy API call to prohibit further
> legacy API uses, named "TARGET_NOT_USING_LEGACY_LDST_PHYS_API".
>

Personally the negation (i.e. TARGET_USING_LEGACY_LDST_PHYS_API) would
make more sense since you're opting-in an API but that must be more
complex to introduce I guess?

In any case:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> Since all targets should be able to check this definition, we
> take care to not poison it.
>
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/system/memory.h       | 2 ++
>  scripts/make-config-poison.sh | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/system/memory.h b/include/system/memory.h
> index e69171de05a..d5c248f1794 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2850,10 +2850,12 @@ MemTxResult address_space_write_rom(AddressSpace =
*as, hwaddr addr,
>  #define ARG1_DECL    AddressSpace *as
>  #include "exec/memory_ldst.h.inc"
>
> +#ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
>  #define SUFFIX
>  #define ARG1         as
>  #define ARG1_DECL    AddressSpace *as
>  #include "exec/memory_ldst_phys.h.inc"
> +#endif
>
>  struct MemoryRegionCache {
>      uint8_t *ptr;
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.s=
h
> index 2b36907e239..937357b3531 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -10,6 +10,7 @@ exec sed -n \
>    -e' /CONFIG_TCG/d' \
>    -e '/CONFIG_USER_ONLY/d' \
>    -e '/CONFIG_SOFTMMU/d' \
> +  -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
>    -e '/^#define / {' \
>    -e    's///' \
>    -e    's/ .*//' \
> --
> 2.52.0
>

