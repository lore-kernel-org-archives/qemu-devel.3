Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E509CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmIW-0000h4-Ar; Sun, 17 May 2026 20:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmIT-0000gY-DT
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:57:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmIQ-0003n2-P5
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:57:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso4186250a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779065845; cv=none;
 d=google.com; s=arc-20240605;
 b=DVlbbQYNVfm57niGpJXP+4cS+1/hC3nCTTLN8lIVrxSCr7KDC7XDYhgae1OBaWZjQ5
 eNIK3blkdYz1NGRPb4h5JvXzeDnQM6U5nuqIW9x6OBOxQ8prtdZcdacdJPZC4CThIpel
 mfF2hz25t1f4PqYZEslKRX2KwxsSdo48DrA2Ca2SZAPeUvsofp/ShL7lgEM/JFXmDvtT
 zyQDkZ0HVARWNCbLbW2kYIYfhlDUdSfW4x2ACq4bfNg3uJCKQ0qnBS75VcxeEC9mEjH5
 UYVa7/4WEqxrkfKZeR4zOptf5/OWg0GgLkMhsL5cz2fp3nat36+0gQcegax4KzKLQH/L
 B9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CuyTzgMWIxLc+rIx+UwBQgr0YVyXEOFp2BPfxfzjD2s=;
 fh=tBPiY1XbgpgJ4iJ9QPImx1lepXitx/v6n9x4/AxihdQ=;
 b=MMWJATfxXBN6ZFxN2jP0E4r04l52imuQgo45WeUUcQGBMKZV44KanfzEQaaiGvfjdy
 iTBgdWxBeG1ZVmPAepUxEF/PL98Eusx3kV4DMOFicE95A6pmqPwPZNXfNg82ANq/jYVz
 nczqh53p1wYknAE+eTAt5uRGAqyQkzozK07GzpcpxV59Vpym6r2qSErIyt+6k1wjzSI8
 GxzzgLCJBB+zYSGSXrq07m/+ZOdTbvXtd4TYikDPqeb36PZ/TRNRGdhbwHb1LJPc++0V
 DnSE5j53cu+RNUSFcbAIS7CtgjXGRCJT35wmKE5+JiKkXFPTZguyxGMBZlCW/ny6tujF
 c2vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779065845; x=1779670645; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuyTzgMWIxLc+rIx+UwBQgr0YVyXEOFp2BPfxfzjD2s=;
 b=Cb3ZAbrgeWqN9RqvcHTxVg5mSfnaQjKt5wtrFfWQoHqkOvlNsYgrL4QDF7KP+Atj0K
 6tjtVWMPShQXGo+UER5EaqiOkaHJGErLYF8fKRjZK6mfLaaUg4rcLu0N8Kacvi39KunQ
 MN1GItNNxPBiqRR+FHfTIvxrHFy6JmzTCjTWG1Ui0C/3qZeK3mEuLs8SVYNh57Jq4VMw
 KiPvWY14dL51O4hjqe8sJFZ0D866lU6ZHaFXd3hjMxIudjlmrDSlt2b+CMBSgJxOmicp
 OD3WR+QHA2R0sjcccI0Z8NdSsurUKb1mTWeiJyH0/f61J1k9SUvuCo7K7osGgwX48pZE
 tYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779065845; x=1779670645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CuyTzgMWIxLc+rIx+UwBQgr0YVyXEOFp2BPfxfzjD2s=;
 b=YMxr2iOMjai4Fp4bdVXoWakvUIvb4rFIBU9vHOe7Q7BeNylpz/h4j8wtF63PLDvzz5
 sbN2kV0R6FqWVmVbzMY7tVSe7qvzUcRppEbgK6MYI9khr0v3eMg/GYGsA6galhqckUxj
 8lNLjX28LvQSzXvz6H+NrrH10d64nv/YeJn+x3ddq2zuMiz+Vtn0eF2XFoEfTCDyr5kF
 K8La+7gR9fBEU55vlrj7nhMHKkNHF4NeAik8cSysBzcWG83uKX+Cej1ue9o8W22QLyTa
 QuZLfoUccgMoadHGFt/Gq69/eO8nQFOgk/4r3Apq8ezoPXdkph+z3gsrOb1oz0mxI2l5
 y0Pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NfUnwM0PLhR3pzKQ7iaZzzqOxpuifuExnP1KlBNcCWWDg+JCoUMY+eLqLhbbxf84KwfXgeBmyTMO/@nongnu.org
X-Gm-Message-State: AOJu0YyAmaE+9773KR06fm0LgkwSMHN4Y5t7NUvyz0BY9064EgWYI3ew
 0ei6ghnOFTzQyg2X9szMnMJkW7RiQ66FIAoQjHegk9GiugZ/MFi2eHKi3T1SFsvDTPDcwJP2eHm
 /gb7p5fbIuP+8pPyYWlCAwAIY9cJExeU=
X-Gm-Gg: Acq92OG6MJ6nBgez14dqUZiyyxgi7unYXnp8aUbHEUQpdWeYSVtixkRVx9BkoTdE0uG
 CkrAvUinIcoZKv2CB4TbHq/GnKZzlUbtnrQ+0DJsBr7SflJ5S2L/x4R5ROTXqbb3k/QHcmVcSF1
 zXcqreLHMvZmT2V/acdE9yPpaOiv2/PMr55/ZDD2fYkLOEJrJpuNDazrvPQTqeJjz/ROjXq3PPy
 xFT2cbKfjdxZZrO19c1B8HeJYWtwmjoq15sBR07mX09QLXZ+aDfhHbjKx3ah1mqzY8cZqxa8P15
 vfLTMGMSR9V8x4miDwKRoN4d/brHpTW4vQuzbA==
X-Received: by 2002:a17:907:c986:b0:bd4:4593:33b9 with SMTP id
 a640c23a62f3a-bd517906724mr537217666b.29.1779065845045; Sun, 17 May 2026
 17:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260511080904.3049446-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511080904.3049446-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:56:58 +1000
X-Gm-Features: AVHnY4LNSviF3_C0oFg38I14qenydedmgMgnk9qaIkE1tG2xbWoTUE2Xzfrbp4w
Message-ID: <CAKmqyKNDDFVCMw-Opn8HO2qm7YHGOA2Taz1Au69BQhcrWkShsw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix FSC SV32 capability check
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 11, 2026 at 7:53=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> Fix a mode-to-capability comparison error in
> riscv_iommu_validate_device_ctx.  The code was comparing fsc_mode (a
> value) against a capability bitmask, making the SV32 support check
> ineffective.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-iom=
mu/pr-694/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 7ba32405522b..ba6090e1078c 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -777,7 +777,7 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMM=
UState *s,
>          }
>
>          if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
> -            if (fsc_mode =3D=3D RISCV_IOMMU_CAP_SV32 &&
> +            if (fsc_mode =3D=3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 &&
>                  !(s->cap & RISCV_IOMMU_CAP_SV32)) {
>                  return false;
>              }
> --
> 2.51.2
>
>

