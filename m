Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8EC109E53D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aMT-0003qE-N1; Wed, 25 Mar 2026 22:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aMS-0003pQ-Jr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:22:16 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aMR-0001UU-1p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:22:16 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so734771a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491733; cv=none;
 d=google.com; s=arc-20240605;
 b=I7o+OeZLuw5AW7Fje/k88UvJ1OFrdadFMknA0212tGraMDvhfgu2TIGy7BzfZERSGy
 0fnsQnEN1mlc3fB1d8lKJPaxFyDHmPmIbPqtaRtc8L97rv9r+58ei8HYAf7+8Ec3Nga+
 6zrIqxuVJXoR5guquvxfntJ03TeVvdAqyE/PAAw0ZnXKDM1Qzvlz0Ewa+OentSgGwQbi
 9EO6/rRJK50+edX2hNsYBeCoD2XXdkFQkZkjTDBAjshghy05rnoW0P8LXsA4r5cRaRmL
 kMAK6ffT4tDFH4bAKq8FwjPi7BxGwxdVeFmcvE3gfOc8OlAaabA9YqfAGVCxb6PF7T18
 2zuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gc7k2niRX57O6P8a6ABCkGFtWJkfFT5g0OlBzxK2Glk=;
 fh=k5gHrRMGAaMlsU7LGqsh0wi5Q8Es9ss0BAxc5Yaemtg=;
 b=RDb+/DIxCiDPZ3n6TfqjcjKTcgIh9eYsheqdBXvRwLLCn7Ek4HWVPxGAmnpnngru2X
 lY7l9aOa3fcp7BpPhX37rqxVnzMgGFSLbCZRKroEH+R6F7jsMx0Kl58TaKEEdVRXIOLE
 VlmsYSuQhjNaGZ6VNj+oNPjq7qOJtIGkAE0w+4+Xzdi2+NLD1QkEg131N1vTtBFloW8I
 8sjC1OmCQYRhEGJPjaI9hal3tiNeIlQisoPh934+W3RvdV3IQ3ZfCfJ/3CXqBaz7WdFV
 1UtX+F6V8dOrjsTr8gWX6peLfz2rNzIAvtEBz9cXfMx6wW9lTBrh9pt9tfdk2PRd/OmP
 ajQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491733; x=1775096533; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gc7k2niRX57O6P8a6ABCkGFtWJkfFT5g0OlBzxK2Glk=;
 b=acNMCZyXfHq/sy09YTG9XlQXoYawErKz1hf7AYxkb4bYP4l+iyUvFpmhXl2kKc/rTB
 gA0HR0bM/vt7cehlDi3GKBI9ixH5EQBqVRWdwc8q6BrYyJZBbBvsMCn0vIv1fESHq15L
 s8ZIJgZQ6DdBdXbM1QImRy9x/M6oXaGQZFwgHnnUnNBGGtM2q3cJaCE0p6p2tZbdO2O1
 +S7Rzq3CUmLH9XNpI7UT5ygPhNaguoy9FeD5CVSb/vMYTWOKE3hgLOXQFg3fUVPQsA0Q
 EQrORNIM8mlx045XNCTAevPxmSeExQfS0ql1ZgnFHC8PgT2320qZi95SYOStWW1EsGLe
 CPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491733; x=1775096533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gc7k2niRX57O6P8a6ABCkGFtWJkfFT5g0OlBzxK2Glk=;
 b=p/QCm7vhQf5f8oNAVrSaki92YIVV/uy1CS6UhT0d25yK9ItFhSKO07SjO051Df4Rcq
 /gfOuMqPAdZa8e7nnTGaEEvW5jhxgeBOHoMuVaPyGRx4E03JhX9zPmGLg/q0O0/gwzqe
 YUark++4cRcw9HFGXOzerfmzzZAe2mRL2RpV7MWMuolYFjdX/vqAuppIZ+QgY9lBqJxt
 yNgILdrcXItyvppR21WggGZYKTaJf99mmINGOzFXld2578+xekAV034yh9pf1eq05meo
 53tWhfGahc1stP6hujXyubCaq5L4VAsewNMT2tsF9PV1ECb8LtN8TXU0dAm57MxObjIt
 6DhA==
X-Gm-Message-State: AOJu0YzEaIvC/rNTQJqAHFDO5JNQkUnlq/YTGemGof+kbXgH0Q1D4UIX
 S6kyMn/AIQEtVUYDwXuvk3lXaAVvHqxpVrXrbCDF9WdoT3bntHFT03yXgfxBy1A1+0B76b/e4K2
 qT62Ss8mWSDEMLiF6flwv6cm9Ku2Muxg=
X-Gm-Gg: ATEYQzy7qD8nB8rcCNNYauSm/ujbbDKzEP9KFFL9bRLF3P0OAHvbYm6DEjjtA2+uZ1J
 MxI9JhSO117OseQn+uowEtfEU+ywfWjVB6bOb7qzZ+/TQV2V20Fd+Y0pFv1aibLLCYyM5S7Hfmn
 /fnBr222ckltcZOuYyfVZcwUPODxUJkyiwwuwePkjCYyBnh20nlLVMGL0Q3az4Sch4acWiLHmyt
 RVumMf8OEDwAXuFFFSe5Vl/4pz0nZLzVgtaAEXsVNgC3shrs0gG2RD26GBU+JmY3xqtadw+2yN9
 YYl8J3spAfFoBcXlNzG/6B43SFsrGjuewCEU+A==
X-Received: by 2002:a17:907:806:b0:b96:dec7:5209 with SMTP id
 a640c23a62f3a-b9a3f1a00b7mr419866966b.17.1774491733326; Wed, 25 Mar 2026
 19:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-17-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-17-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:21:47 +1000
X-Gm-Features: AQROBzAoRxF4IJM_jId5CACiej5xKt0p_jn8cJsipDijiHtR6fzkXrm5Rth0thc
Message-ID: <CAKmqyKMmTmts3HSciGciAc3UFMW=a_Zu=2uV+GhMmvrLR3HV4A@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 16/16] configs/targets: Forbid RISC-V to use
 legacy native endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All RISC-V related binaries are buildable without a single
> use of the legacy "native endian" API. Set the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/targets/riscv32-linux-user.mak | 1 +
>  configs/targets/riscv32-softmmu.mak    | 1 +
>  configs/targets/riscv64-bsd-user.mak   | 1 +
>  configs/targets/riscv64-linux-user.mak | 1 +
>  configs/targets/riscv64-softmmu.mak    | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/ris=
cv32-linux-user.mak
> index f069ab9a0f9..d88fdf5e1b2 100644
> --- a/configs/targets/riscv32-linux-user.mak
> +++ b/configs/targets/riscv32-linux-user.mak
> @@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=3D32
>  TARGET_SYSTBL_ABI=3Dcommon,32,riscv,memfd_secret
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv3=
2-softmmu.mak
> index 26080599be7..5d5016d0083 100644
> --- a/configs/targets/riscv32-softmmu.mak
> +++ b/configs/targets/riscv32-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=3D riscv-32bit-cpu.xml riscv-32bit-fpu.x=
ml riscv-64bit-fpu.xml ri
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv=
64-bsd-user.mak
> index bc85d9ed04e..5b4e138099f 100644
> --- a/configs/targets/riscv64-bsd-user.mak
> +++ b/configs/targets/riscv64-bsd-user.mak
> @@ -3,3 +3,4 @@ TARGET_BASE_ARCH=3Driscv
>  TARGET_ABI_DIR=3Driscv
>  TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/ris=
cv64-linux-user.mak
> index bca08645124..35621520c56 100644
> --- a/configs/targets/riscv64-linux-user.mak
> +++ b/configs/targets/riscv64-linux-user.mak
> @@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=3D64
>  TARGET_SYSTBL_ABI=3Dcommon,64,riscv,rlimit,memfd_secret
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index 5059c550480..a10dc03c04c 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -6,3 +6,4 @@ TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.x=
ml riscv-64bit-fpu.xml ri
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.53.0
>
>

