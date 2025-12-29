Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF15D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBHg-0006SC-P8; Mon, 29 Dec 2025 06:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBHY-0006Rk-N4
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:19:24 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBHW-0005lJ-Vo
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:19:24 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so9496210a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007161; x=1767611961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mnzhgT6JbWmtkmzsQ5H2/1XM0EVhmpEMjeL8NjAdE4=;
 b=ERrkoizX7PkDzpu5SK+GXRAxJDYAugTiSHFORDXOGw9KXF/fmve9M0zllot20RnP1v
 ZAHvnrq6cLmUEnuJy/GWDQvOxdimUPGZZKWPqGnE0Qbl3ELALfhC5hgtbqosg8h+1dfG
 2x1FVR2c978rKTaBtsITpOfo0WPHLF5peZ3829p2qashAE/S7k7IEX2s18TT1txRuEAM
 JnBOkzLfEzBg+tRCjZ0Dcq2VvLyz+5RlJM3Sdcs4xpmIqXHsbs80VuAZlnvXE9YWTQHr
 ucRGkj6r3YazsBIt98Pg4sx8AEZEusRFvtK1b+uSpRKWj3vBN6qEgRYTODwMhfUXGo0m
 t0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007161; x=1767611961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7mnzhgT6JbWmtkmzsQ5H2/1XM0EVhmpEMjeL8NjAdE4=;
 b=beAVE+rmn0iGfimAUUlIqljoTaUIpZEtkKG97odYYzyKF/Coz3VQJf2v8WX5IrbdhY
 Ej0rsl057rz0IEe3MAQHHRkj+q03b+cCecXH6BLIHVEFkCAf6KSbHtuWXj7+x+Mgz8Ub
 axMrFXY0onLAy1W7Nvx74vsTYl1gVhIL9wH7qdIspExl2iomCoNureBXGN0CeZI/1POa
 P0Fsdsd/EceTkFqrrndonxLFJCnzvK2kgv4yWBYIeonMPnjZmKPD/ohS6PgB6NYjFGVM
 TOcp9dMW1aUHeIQER7WT2X1T+3cM/Nn952AX03KsHWleIX7NLCosske0MSHH+JXx1jOk
 m/Dg==
X-Gm-Message-State: AOJu0YxinBuHGzOfPtzvD4OqPyS6C4v1CsRPE3FVXbmFUcaX4XDXf9eC
 P9CcAVperLe5yKj8NkipDQleVOjeCV+IW+7nueQ4tqMBMdIVeYD8yUMATf8ZFx/SlQ2YvuexE/G
 9h8kdCoM4gyoKrMQDjHNyi9DWlDdvLagdO+XYgbR5FQ==
X-Gm-Gg: AY/fxX7NLuVQ9VqA50zuJNbQ+5cJc5nPoey7L/bTjoWfH8SSbU4izaRl5kaT8sTn8LK
 Xxz9GI1pljzTmAlTvhmna8+q6jdltDcvcR9bvFwhdOtWZVPKQYZc6qLkFdGInoZMoeeZ+QPhkIj
 9X0YAGqC/g9vSfqSuX8EbRjhNKUuYB5mjDLmfLTbl/7jvFFoiDYUuWI0UuGV9TAtjHgsfgBLdlu
 Hn8bavExSPx69N5qm6KptRGnz9pbNklOoHKmH2R7WihnVNMu7a787M3LVGAlzWyXTVNVsIJEbJc
 wmsIyXBcUH4fAzxtBAgOtNtyBvq9Ya0+RaEaxnQ=
X-Google-Smtp-Source: AGHT+IFrqydgHFi8CNJJ/JI/FDnEk/tEo+x58p2LwanF2d0ffs4GCF12qNPcogz9n2n2c1kbzKoEQDAwiFLrrzAUltc=
X-Received: by 2002:a17:907:7f21:b0:b79:a827:4d47 with SMTP id
 a640c23a62f3a-b8036a8d6e4mr2993461666b.0.1767007161035; Mon, 29 Dec 2025
 03:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-10-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-10-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:18:55 +0200
X-Gm-Features: AQt7F2omdwEslhBDH9na36MIuDOJhv3yFrLSei_wY8OpZXDL3cxyqw5BPy5tMAg
Message-ID: <CAAjaMXYgw=t9GNpN=Y9s-Vv7kmsiVxh2dsHNH7=vPo4XSo_oJw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, Dec 24, 2025 at 6:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All SPARC-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  configs/targets/sparc-linux-user.mak       | 1 +
>  configs/targets/sparc-softmmu.mak          | 1 +
>  configs/targets/sparc32plus-linux-user.mak | 1 +
>  configs/targets/sparc64-linux-user.mak     | 1 +
>  configs/targets/sparc64-softmmu.mak        | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc=
-linux-user.mak
> index 4ff4b7287d2..d3f0716ca2d 100644
> --- a/configs/targets/sparc-linux-user.mak
> +++ b/configs/targets/sparc-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=3Dcommon,32
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-so=
ftmmu.mak
> index 57801faf1fc..272fd46f6db 100644
> --- a/configs/targets/sparc-softmmu.mak
> +++ b/configs/targets/sparc-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dsparc
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets=
/sparc32plus-linux-user.mak
> index 7a16934fd17..3e6c72e793e 100644
> --- a/configs/targets/sparc32plus-linux-user.mak
> +++ b/configs/targets/sparc32plus-linux-user.mak
> @@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=3Dcommon,32
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/spa=
rc64-linux-user.mak
> index 7c2ecb7be06..3bbd8495210 100644
> --- a/configs/targets/sparc64-linux-user.mak
> +++ b/configs/targets/sparc64-linux-user.mak
> @@ -6,3 +6,4 @@ TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_XML_FILES=3Dgdb-xml/sparc64-core.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc6=
4-softmmu.mak
> index 8ee6d057682..8a0290c2093 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_XML_FILES=3Dgdb-xml/sparc64-core.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

