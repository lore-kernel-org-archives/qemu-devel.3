Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A11D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB1y-00077O-C7; Mon, 29 Dec 2025 06:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB1t-000775-3s
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:03:13 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB1r-00039x-Ef
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:03:12 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so489910366b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006189; x=1767610989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uu6vunQXCjF8xJqzsTm9DS0i8fjdoizrbY78MtCfq4M=;
 b=iYiel73PaXSaHfm8pO9YmhOybRQ126jr2GfdBOgjlc5EKpHY9ccfGiqpCOrhERnpn3
 h5h5Zv7AbCFoKCP5Vr1AQY1QGVlc3PY4X7n8PAzfOBNb6P/Fl66q/2ehM8p2UvM6x+Q7
 CbzaOQsbUo4n7/tM4p6iaKsdTan57nmG/0JlVej9iCOLledxG7inKGV2DcgYD4dCTo1s
 tTSLO+q7dcgPpvFIeb+XstzGbBuEwMXwZokuvPKQt05+moFJC8cHpxJCUArBVgjoNefo
 XlWM+Nw6ldYHEOO4I3mV5UbGgdSAMokMz49DOZzV6cCZttLmVU4yFHdaoBf/8Be3MEQw
 Q54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006189; x=1767610989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uu6vunQXCjF8xJqzsTm9DS0i8fjdoizrbY78MtCfq4M=;
 b=aAzXMYd1p+FgCOec9Om59GQ0xe9SW8dO3HCHofXKQbLEON7J2kzeFBgvxzpRiGK9iB
 R57GcA49ToBjFye3K1W9IgGj062A95SAhdldLDiu98434DZKlJgUR5ReCF7iLacyjmSU
 DKn2TwEQbTMmu38YTlfuqv/TXpIRayKQXzgDVxQIusMPIg+M7La+E5q3jf/mWpy3e/Hd
 43IXNdIAUOUpPoIJ1SnHoJkGKYHukAcsIHAUnAZPMszzn53bMwO+9Yb3bBZIHgjjfSbr
 rrcJL+sOWsIscYiWXusoLlmsYVXGHHej9X6kaXHJKhTniz/40ndIGT8GCj/JP0bpN1LA
 vfnw==
X-Gm-Message-State: AOJu0Yx5iyjZ/vCsYlP/kNpaZPdrLS8zkrgpsSU6armVjF0mMwsiqI6J
 IyF4GdyebnYAaB8555sV3ISII21snokgU7iVL1cCh7BwYzRCk7WKIAabt+XNJQYOyAqi3El3HD0
 1VRHmyFhPQt9UISI+3/V6Z6ZXBjc1HR/dGZ7o+G2PVQ==
X-Gm-Gg: AY/fxX7kbNfd8NLKjQcJFwsk3w4KH/87aljyMfOw5xvkattJcXrlJkoaRJWhap0BkU0
 mU+9H4gqVLXMYl6V/pDItewYKKEW3Uz2sxfgvSXoJe5+hoYvqwxxJkD791+F5MBRP8+FtZESRPS
 J8xZiNJfzLZJxJUcFjJSCYqkVgjpR1GYIaaXE/OqUEEmjoGc6pfAAWGBfJrjCZUH9IXcJTsSD/4
 DfUdjVrFxcHr7Mnb5NMIgDX8xBdMtICWkdBgrcMadPVfh65JFhWS2gdCfyh2Ac8KY83Js8x3vbp
 aVF0YcIFvfUkNFeSn4yhwAxLPeunj3RHV4LylXo=
X-Google-Smtp-Source: AGHT+IExy0xsy9hzw+Idtj7KOTo0J87qyqDwy2yJ9r18tcL+VPraY8vNnD949E5oV82q9fPiOaZoYSeUeAs7CvH5iBg=
X-Received: by 2002:a17:907:608c:b0:b73:7ac4:a5f with SMTP id
 a640c23a62f3a-b8036f0f1c1mr2898923366b.21.1767006189382; Mon, 29 Dec 2025
 03:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-5-philmd@linaro.org>
In-Reply-To: <20251224161804.90064-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:02:43 +0200
X-Gm-Features: AQt7F2peo4CeEpnzGohK-yL8lzodCzACVRnEdqJRbh3JOzGGJAXX8wZjHlEr3UU
Message-ID: <CAAjaMXYAw=HNDzf351+-Qy3gzgu4wyWfBCgkJm0nS6acs44--g@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs/targets: Forbid OpenRISC to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, Dec 24, 2025 at 6:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All OpenRISC-related binaries are buildable without a single
> use of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Preliminary commits allowing this final change:
>
>  . 5b67dbf1dc3 target/openrisc: Replace target_ulong -> uint32_t
>  . 500708331e3 target/openrisc: Inline tcg_gen_trunc_i64_tl()
>  . 4f6c60683f2 target/openrisc: Replace MO_TE -> MO_BE
>  . 73cd283e58d target/openrisc: Introduce mo_endian() helper
>  . 2f737e19a4d target/openrisc: Conceal MO_TE within do_store()
>  . 22c36c0a20c target/openrisc: Conceal MO_TE within do_load()
>  . ef797ac0025 target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
>  . 81e2fb236b7 target/openrisc: Remove 'TARGET_LONG_BITS !=3D 32' dead co=
de
>  . 9dc4862dc4a target/openrisc: Use vaddr type for $pc jumps
>  . 2367c94cbb1 target/openrisc: Remove target_ulong use in raise_mmu_exce=
ption()
>  . 1843e89bec5 target/openrisc: Remove unused cpu_openrisc_map_address_*(=
) handlers
>  . a3c4facd395 target/openrisc: Do not use target_ulong for @mr in MTSPR =
helper
>  . 2795bc52af4 target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT3=
2()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/or1k-linux-user.mak | 1 +
>  configs/targets/or1k-softmmu.mak    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-l=
inux-user.mak
> index 810567a98f9..97d7cb10465 100644
> --- a/configs/targets/or1k-linux-user.mak
> +++ b/configs/targets/or1k-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_SYSTBL_ABI=3Dcommon,32,or1k,time32,stat64,rlimit,renameat
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-soft=
mmu.mak
> index 89f81b75bf7..c53408a2bf5 100644
> --- a/configs/targets/or1k-softmmu.mak
> +++ b/configs/targets/or1k-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

