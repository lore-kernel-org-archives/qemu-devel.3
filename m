Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1F2C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 12:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt3tC-0000hb-1w; Fri, 14 Mar 2025 08:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1tt3t8-0000gZ-00
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:11:42 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1tt3t3-000386-CL
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:11:40 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e535e6739bso3013198a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741954294; x=1742559094;
 darn=nongnu.org; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyaScwE4ezKsvqVE7a3jqsaz1NZ3zGyf/GD2oetk2Kg=;
 b=X8+w4nDv3O0EEbcuQRpJtU5XrD/nOiEC9Ab9+iCzn3rerFsvRQjh4mThb/voQF3DJH
 wKs0jmRcrpuFtUxdzMoKZYKMjIOaIIKWMVf/wlWXB7nwXJrNdrCTjsIRu9PYsD0zFDxz
 TFG0mhPnoaL7m3Hp3+iY/mmYPv9WsJ5Q/1qx9M1KzXoN3YQ74DDpBc2EEpdWGIf5XHJV
 tULE9NP6nR3kslYZkqxiYDtepEhBJKlvHgEyzoUEdICE3QNzcuAN1dRmF2slQc/nkScF
 hBWENFsXhHK8luuJ+vlweAcptLFkAdeyHvmXHTJlMX/2VHcXfk56IivAHMEVyyi+7/eH
 pfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741954294; x=1742559094;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyaScwE4ezKsvqVE7a3jqsaz1NZ3zGyf/GD2oetk2Kg=;
 b=Uh5O1YDenvOJDEUNtQV8/wE9/oOq+KhMKWxRtjUi8GFffmZ8gCTWCyaXTDO97nIaQe
 SdxTAaUucu16Jn+jLw9P1ScH9IHZ2xqxKuPLehHkRkZlyP1NZMLJgbg4CvAd71FL4Swl
 kS9xaYAK5cpUK1/e0OywP17ZYxpu804ldx5fOuL3ODZosspN4/bQi0yUi0r3650VFAVn
 2Y6WxRhSv2FbKwmytSl5IRW3mK406ci0jPI5T5tkfyRwIEIOluKZueginOFOjlwfQLaq
 9HBk2x/QyE0Hcgdm/Lh3guWz696SahORFqvnPrBeaAoP7az7DWnldtP5OrQqLVVUVU/R
 EUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH51FPDcgF25dGaciGJ30BP571LssKEW9xWc+q4BeFuAlkCDX3GdLVXqee7r9gBALxcbUCKNmWUS9c@nongnu.org
X-Gm-Message-State: AOJu0YyIQ7VkB+yAVPk9JvTkCEmG7kJzI2OAvK0suVjnIB1KqSS72y8Y
 nYKtQGi74YJQfeYDuppTbYUZZsYwjHHthMyzZBhr9rDjA/CMF30nvk22joQhK5trApt/3gGjgJA
 f1cuBXnDr2zaXaG/adBqu81cv5Y0dMPuzF1u1mA==
X-Gm-Gg: ASbGnctuW31a0F+bp5LJmo02tcHk8Dvui6IwIq+K008Qu+cbC0FTZqiPG3PaGuAeBdn
 mCKRV+nZrusRrVXhR02Q4g5REaqMiySW69f/75+n+zByqV2YxpKaF9yHi8AR47Dd/KuxbOWvqko
 KSBvFJOXuHNUnGTTZO1q5tQWlZdFkOOx6YRaKq6TC6XPK4qFeAijB+7VuMUer87uo0n84Zfw==
X-Google-Smtp-Source: AGHT+IGGCalMljZRshzHtgXNK6qFKjwrBkZW35SgBSaRCa6MEP2D+rlj+gNqj7ZjtKxfaxF1wGIi02fRtXQ8lPW7Ji0=
X-Received: by 2002:a05:6402:524f:b0:5e6:17df:118 with SMTP id
 4fb4d7f45d1cf-5e8a0809334mr2058316a12.31.1741954294469; Fri, 14 Mar 2025
 05:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250314104833.369365-1-alexghiti@rivosinc.com>
In-Reply-To: <20250314104833.369365-1-alexghiti@rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 14 Mar 2025 13:11:23 +0100
X-Gm-Features: AQ5f1JrPbyWecKn4x-ot_JvGVC25I8RVdhywR-g9R40NK6B1tP7U3JnIxqjACsk
Message-ID: <CAHVXubjJ_oCKqjYBFRjn-BM-cB4JUsFJ-dX3Dqs6j=6vTh+yHA@mail.gmail.com>
Subject: Re: [PATCH RFC] target: riscv: Add Svrsw60b59b extension support
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alexghiti@rivosinc.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Mar 14, 2025 at 11:48=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> The Svrsw60b59b extension allows to free the PTE reserved bits 60 and 59
> for software to use.

I missed that the extension had been renamed to Svrsw60*t*59b, I'll
fix that in v2 later after I collect some feedback.

Thanks,

Alex

>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>
> I tested it by always setting the bits 60 and 59 in Linux which booted
> fine.
>
>  target/riscv/cpu.c        | 2 ++
>  target/riscv/cpu_bits.h   | 3 ++-
>  target/riscv/cpu_cfg.h    | 1 +
>  target/riscv/cpu_helper.c | 3 ++-
>  4 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2..ee89cdef46 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -219,6 +219,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svrsw60b59b, PRIV_VERSION_1_13_0, ext_svrsw60b59b=
),
>      ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> @@ -1644,6 +1645,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svrsw60b59b", ext_svrsw60b59b, false),
>      MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f97c48a394..71f9e603c5 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -663,7 +663,8 @@ typedef enum {
>  #define PTE_SOFT            0x300 /* Reserved for Software */
>  #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory t=
ypes */
>  #define PTE_N               0x8000000000000000ULL /* NAPOT translation *=
/
> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
> +#define PTE_RESERVED(svrsw60b59b)              \
> +               (svrsw60b59b ? 0x07C0000000000000ULL : 0x1FC0000000000000=
ULL) /* Reserved bits */
>  #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>
>  /* Page table PPN shift amount */
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b410b1e603..f6e4b0068a 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -89,6 +89,7 @@ struct RISCVCPUConfig {
>      bool ext_svinval;
>      bool ext_svnapot;
>      bool ext_svpbmt;
> +    bool ext_svrsw60b59b;
>      bool ext_svvptc;
>      bool ext_svukte;
>      bool ext_zdinx;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..6546cea403 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1156,6 +1156,7 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>      bool svade =3D riscv_cpu_cfg(env)->ext_svade;
>      bool svadu =3D riscv_cpu_cfg(env)->ext_svadu;
>      bool adue =3D svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
> +    bool svrsw60b59b =3D riscv_cpu_cfg(env)->ext_svrsw60b59b;
>
>      if (first_stage && two_stage && env->virt_enabled) {
>          pbmte =3D pbmte && (env->henvcfg & HENVCFG_PBMTE);
> @@ -1225,7 +1226,7 @@ restart:
>          if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>              ppn =3D pte >> PTE_PPN_SHIFT;
>          } else {
> -            if (pte & PTE_RESERVED) {
> +            if (pte & PTE_RESERVED(svrsw60b59b)) {
>                  return TRANSLATE_FAIL;
>              }
>
> --
> 2.39.2
>

