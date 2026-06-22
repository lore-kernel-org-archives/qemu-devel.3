Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF390CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVnO-0007zv-Fi; Sun, 21 Jun 2026 23:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVnC-0007yP-Ie
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:57:51 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVnB-0006aR-1A
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:57:50 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bec450b950dso540483966b.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782100667; cv=none;
 d=google.com; s=arc-20240605;
 b=GZcLuuRuetjro4mj/syVFsBwKYWn6tzsJkZfFXe9lK4OeudZMcpx9mbOZ2geUSiHay
 UFqC3gpVToJePSvoGDScFn0TjBVTW1hagS03OFYyNcIpLvSvRZ5LxqEormWLYhyRKpEM
 cSddYMLCmIXnd3FQu1hEV4EQBSixLSB+WjjBnqMKJi5R/lVPPiPfXo+hD+Ih0nCUPH0m
 /QLilf+tvpad4nbMgVQskyCYyTCzR3SEhgErHWLoEg9K3pUYwDgHK9GI3b3/lkF3wwW3
 0NNM31FWeCINQJ+e4F+hmqAF7SDX7cMe5kw4VAjDq+MRMwqVtawHGXxXmAEAdEDdvaqb
 rvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BGujD/kdKMrLCJF41tGVPhLWtBdN2/9YXhZzjuo1kkc=;
 fh=KxuOr3nWkm6g2k1L0PKIWO/Y2QnL079d8A1i30z2gYo=;
 b=b5Ez8Mb93/j44PMjDVjrNKFgojZicmjiLA/ZNjflHXCWHb2epR458mYh/hdMGpePwi
 8lUmiuMq4mmsic6BaBoF+nbb1ZhAc6d9QUlaG+IwqhDz+N+TiRvxBacCCUlDtY2qLgSA
 FCoTIfmqT8Qq3qxQJtKoQl5Jyp51TvsUlugcGFOkZ6h7x7Fm4u5qSfzON5gXccW2mq8O
 a7Ro1IGw1+TPUu08/WbQ7W1fi9nDNQ1JU4oTvCbkqMJ2jafrtG+GXJRZyphRAs0884pm
 EQwrA2BHNvaNRuooVikWmqGxZ7WkZFp8cJ18YFey4Q9+62w6HTC6frtW+raMz9tDRI18
 StvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782100667; x=1782705467; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGujD/kdKMrLCJF41tGVPhLWtBdN2/9YXhZzjuo1kkc=;
 b=hVaUsOsQsPgq4EKsMEsE1F2cljSjV4bEtwSrnNzz0Bm/74SzZwMbH6m3ajn63ziyx9
 nWewUC9K4HCv0+pMA398IUNmm9JVlGpfbkU+lJ3EnmgPLeX+BvRVfYOFGjZZOmGKDgom
 F1lSxxnHphZ1gBINFzXgtRjgInEOegOfj+8987DTHfUML6TrjrOHtmrEAcmvs3SMUgXI
 jyRcXM4A8GwjWb0v7pZERwieun5LfP1SfvmzE8jWc/sx7mPKLr1TleKwCEDrFNVHd9dD
 kzrH/LYWLH+l9XK6OCqaD1qe4w72zQ5xcBOumnIuOxOqDV8YiSRCkPYHXB7Ia42fXMvK
 SKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782100667; x=1782705467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BGujD/kdKMrLCJF41tGVPhLWtBdN2/9YXhZzjuo1kkc=;
 b=TDQnq7wrJweggEotZBQTGX8Vs83Dq0TvoFCL7UIJTTzwqcVtb8r7FHkT7JaPFUpTZ4
 ouBDDnnBghtHpBOixrKKwnATafj9/2ddf/l7hasQi1frXQjH2f12+qqS6cknPQP+JEoO
 BOmk85jGBw4aEgco+7d3X2zHcLvnNA1ktYQyOfVA2JC71olZdGw1X8OCfMuXUX6yzM4K
 iEynpTjfz9cuCXymkKTw0zFTQjC86OQ0NTX+2VbeCN8GDWKufcpLKTr99vi0mHIrvrB/
 +gCFcqGF8GSbPm1CBqtHEVQPFDcgeJzthNJTGrpzy6ENdkFwVr0mTV86kGW3iikbRe3t
 aZzw==
X-Gm-Message-State: AOJu0YwvBwpQzOxcBpzxj3+w1s7WiYyN1nK35H4/VBEqAaNyluqbGIs3
 eSWce2F+kVAQQHNBZaqBo/orp0HPx1JMIC+xchiEWYfNUNv6G+AiZ0SF+cAcb2zww2lU5yVSL+f
 5TdMTWd/y98puiccVGaShTyoGSZ6ro/c=
X-Gm-Gg: AfdE7cmxLWSxQYJTIru1nepWbGLGNyeYKY/I21tpZaff8wIM/sNiDT+2c/Ee2yvCNpP
 YBWZ/W3fKay2FjbYYb3svIMxFcQEEIfJp/rlfg0HQGbMkocPC9IPTLFkGT9F+4qBSwnE+nGSJ7G
 NJxf/xYZNkOLb+qvgE2TalosoTrGA9pz6/bp8xy0Q4joBx3As+EddpZCehnxZjkeCgRoJS6WUKp
 07EVe6VYfpxsIwUrM92F1BruHBERWZWOUn2jvw0k1MaBD2ybbE7LH6AqRv6E2p+9XLdw2Dz6NiQ
 zk+lxydH1DBzdlkOYGKe74GM2k/Z448H8WHxjQ==
X-Received: by 2002:a17:907:a785:b0:c08:7c11:8dec with SMTP id
 a640c23a62f3a-c0b61547008mr502437966b.21.1782100667006; Sun, 21 Jun 2026
 20:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
 <20260615131925.3019370-2-qingwei.hu@bytedance.com>
In-Reply-To: <20260615131925.3019370-2-qingwei.hu@bytedance.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:57:16 +1000
X-Gm-Features: AVVi8CeEQOwLn8D_e97TdPaiHDuz_MZQwxz3LaqzJUGoaxqdFXgIzi5KEB8bGJs
Message-ID: <CAKmqyKNfsrTwHT2uAFS-cuR=PqqzAdhzUzAJjLSZ-2Uwqog-uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/intc: riscv_aplic: Skip reset for KVM irqchip
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jim.shu@sifive.com, nutty.liu@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Mon, Jun 15, 2026 at 11:20=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.c=
om> wrote:
>
> The emulated APLIC state arrays are only allocated when QEMU handles
> the interrupt controller state itself. With KVM AIA/APLIC-IMSIC, the
> interrupt controller state is owned by the KVM in-kernel irqchip, so
> these emulated state arrays are not allocated.
>
> The APLIC reset handler still clears those arrays unconditionally. This
> makes qemu_system_reset(), which runs during machine creation,
> dereference NULL pointers with -machine virt,aia=3Daplic-imsic and KVM.
>
> Skip the emulated APLIC reset path when the interrupt controller is
> handled by KVM. The emulated path is unchanged for TCG and for
> configurations that use QEMU emulation.
>
> Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index c2c67c29e6..84606e9f3d 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -910,6 +910,10 @@ static void riscv_aplic_reset_enter(Object *obj, Res=
etType type)
>      RISCVAPLICState *aplic =3D RISCV_APLIC(obj);
>      int i;
>
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        return;
> +    }
> +
>      aplic->domaincfg =3D 0;
>      memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
>      memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
> --
> 2.47.3
>
>

