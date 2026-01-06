Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1C0CE9D5B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Eu-0003jJ-D7; Tue, 06 Jan 2026 10:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vd9Ej-0003hF-8t
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:44:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vd9Eh-0003lS-Nk
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:44:45 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso9190735e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767714282; x=1768319082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4uN5uXdoTBE7EsXhGHtQaJDgdbOeDQnOa3KpE6/cks=;
 b=uqhBF84HndJ8ezPkUgg53FnxQ8C0swy/omPAfH7GruaLr1OPUeqQizP1VKFr1qiSSa
 mUQjtbSvKBhSEejBZj0o4KrMS8ywciEHOZqw1YUiGsenUUCiE4YC+wVEVD6q56cR/zRt
 ops2mPihnkCGx2xG+qx877js4SVFrL1VEvQWDd3L0+M2jBHvS9zQFtaAOYJGpJE+K4D6
 0mdo6ewiIoyD+Oim6TlkvMGHagSpR5rRMof/ugkv38LJpHZoYzFGJj4jES2n/shkQqIx
 0awq6IsMZEe2S8nrhF0T8eKhUTy6yL2IIb8Gp95IMkTW3oWF3nVxN8uwtBI0XAXxQfuK
 SUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767714282; x=1768319082;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C4uN5uXdoTBE7EsXhGHtQaJDgdbOeDQnOa3KpE6/cks=;
 b=oZioRBZRN1VvhvMttcoeMPqHKtfZrvM5EjCKI2LFhNVpjI5BLV6tKNC1Ys0l+24Pz9
 5dbejCvqzZXqmkPMZy9Q7GGrYZTAyRyVxddemdVCUdfF/ugwlzeqnNGw0NZAX1SmoyPR
 OpS1jqq68JaUVoU/D7TE879nWo0acvYHhI0OS5DTigZKhPQqXOvMXukm5ifSKR/cPykk
 nP3T38MP7xEo4ZkOEIKlbFHL9+KA8CC/ywErCTYEL0w7lZdvLEunhl2NDuE51qamMlLX
 jvWDpton/9sVkYUE44CGVgP3LAtm4yJOQkiFCNBM0jCCjEdztQ9WKqkXcssl2J+Ik2lN
 vRMA==
X-Gm-Message-State: AOJu0Yzn3GbyyyF6nRCq7hgf214zJ9HjTnzKQR9hXuy0Kp8fHx1Qr/Aw
 geHELuGboVDqdRm0NHlLdvgSNkmeYGRMhUF6Zn+g1k4Qo4Kx/7DrN8yWdUP3rWaKAF6KV2Aihp+
 xntBB
X-Gm-Gg: AY/fxX6489cukJ9WySsMqfcjce1zxLA4iBgEfzBgGSOnWxyyH5N808oAF6BKz3LZFi3
 lmXwcedjOV3IJbah75wOzMWwpGKj5A86qBYalkkwWgokpPrAmcsi9jN95uaqm/gGxKPBzO8GPOa
 0SIJbEg0df1r+TH/Hf3utBMOAyCF4KB2CPzq7SMFvnvmgq1zJ8dbkBh9/7fCDBrDSxQ5RqJUDmG
 tBMwXHozPa2wC59hSWqbkif8nq/HQu8uk7AJEjEcgw5idiHShKy/dq+8DT5/K5ASZ3RydgztuNt
 OMZUURi5LIRrMO941He3BtOGx6oKUYJNAEU+Whdz0OnmL6GZZ4ENMAbkl4Dg2U0Wbv2oqDBdKkm
 pNIbUSv/OuDCJQ1eX3xHRX3t3IplIEn+arO1IUYfk09srfvIlxHl0YEOQ3oOgNCfIY1QOWsSmPy
 WOr2L+ss6ztwQ=
X-Google-Smtp-Source: AGHT+IFALDbOY7xpNzg74Vwmldt6+UDHQH7oZiRymlJYNkZi673P3qGJPj6l0SHIcSPAo4aUJYfWKQ==
X-Received: by 2002:a05:6000:220e:b0:42b:39ee:2858 with SMTP id
 ffacd0b85a97d-432bc9fac71mr4683400f8f.42.1767714281992; 
 Tue, 06 Jan 2026 07:44:41 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm4890060f8f.28.2026.01.06.07.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:44:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0EFF5F87A;
 Tue, 06 Jan 2026 15:44:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Martin =?utf-8?Q?Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
In-Reply-To: <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 ("Martin =?utf-8?Q?Kr=C3=B6ning=22's?= message of "Tue, 6 Jan 2026 14:43:05
 +0100")
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Tue, 06 Jan 2026 15:44:40 +0000
Message-ID: <87y0maagpj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de> writes:

(adding Philippe to CC)

> These functions are needed for CPUs that support runtime-configurable end=
ianness.
> In those cases, components such as semihosting need to perform
> runtime-dependent byte swaps.
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de>
> ---
>  include/exec/tswap.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 72219e2c43..9aaafb12f3 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -10,6 +10,7 @@
>=20=20
>  #include "qemu/bswap.h"
>  #include "qemu/target-info.h"
> +#include "hw/core/cpu.h"
>=20=20
>  /*
>   * If we're in target-specific code, we can hard-code the swapping
> @@ -21,6 +22,8 @@
>  #define target_needs_bswap()  (HOST_BIG_ENDIAN !=3D target_big_endian())
>  #endif /* COMPILING_PER_TARGET */
>=20=20
> +#define cpu_needs_bswap(cpu)  (HOST_BIG_ENDIAN !=3D cpu_virtio_is_big_en=
dian(cpu))
> +

Hmm looking at the description:

    /**
     * @virtio_is_big_endian: Callback to return %true if a CPU which suppo=
rts
     * runtime configurable endianness is currently big-endian.
     * Non-configurable CPUs can use the default implementation of this met=
hod.
     * This method should not be used by any callers other than the pre-1.0
     * virtio devices.
     */
    bool (*virtio_is_big_endian)(CPUState *cpu);

I'm not sure if we want to expand the usage of this hack. I think
Philippe is hoping to get rid of these warts eventually. Of course we
could rename the method and just provide a way to get the current
systems endianess.


>  static inline uint16_t tswap16(uint16_t s)
>  {
>      if (target_needs_bswap()) {
> @@ -48,6 +51,33 @@ static inline uint64_t tswap64(uint64_t s)
>      }
>  }
>=20=20
> +static inline uint16_t cpu_tswap16(CPUState *cpu, uint16_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap16(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint32_t cpu_tswap32(CPUState *cpu, uint32_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap32(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint64_t cpu_tswap64(CPUState *cpu, uint64_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap64(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
>  static inline void tswap16s(uint16_t *s)
>  {
>      if (target_needs_bswap()) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

