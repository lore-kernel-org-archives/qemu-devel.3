Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BD5CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZyK-0002bt-2k; Thu, 28 May 2026 08:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZyH-0002Zs-Qg
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:36:21 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZyG-0003Ty-B0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:36:21 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso13261644d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971779; cv=none;
 d=google.com; s=arc-20240605;
 b=TzpkIXJ1fZRmFA7WnsTZqyYslYO9xV/i+dkUinuy5WINa2HJIMZlmtZkazeWb97EB8
 OlygJu7LKivPEod/umuHdmikIlf6qeT+l5aRSgKqbfNQAgdpbPGrtOSz01MhR63LHwSP
 gWZDOUjDFxCTLEwLtQ1Cc2ZjgsfkgiiU35qTYYfsueopTA3hB+XoxwHW6CILumhxlv5t
 2+5po0oeF3E3lnh1KEiOhfdm02JLJwYwqDaIKU6UbF4gMGbiD0ZdrvRL0dGfStEelJop
 sqHRNMTiMXcJSGVBuNDw9M1qin8inpuEB51fQ1xq2z5eRqvJPYKsAl5/WwtEQlDFWZ/W
 feLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ektGrxW2dF9YmfpqRLqpny3BO+8C4wfKPTZVBiCxCh8=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=ct1kYdn/uVUTPWSAxyWqLT1VpSekMK4/RToH52c3E5d2G24jQraErTf3JQ72hVCb0n
 8zicxHCSTplF7yhcIj34rjSb+l4Iiav0GfaUBaumFsGYI0vqXz0+5X3tKVXPnOBsCzPM
 jhoSO2N29U13YQiYMbkFRjrZpgCNW0MzkAA6Zrq8IKdx0sewpgbZgy3TB+BKMkBbutbw
 weO6qU4boT80j3k8JGS1EWmMG2AwrhWNc0PW3qEzwD41fikfYlD3mP5pih0Wi+Npt4Pt
 cZ7lIkloVHZoAWDTuvTFtX0Z4h5jIUd5Kl/bytQvuvIgE7wP7OxVSKaTq1Op1qOkGdJK
 /pvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779971779; x=1780576579; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ektGrxW2dF9YmfpqRLqpny3BO+8C4wfKPTZVBiCxCh8=;
 b=E88Pt8yC+WFFdLb3Mxx/jIpzq0frY9o66JDiqDVAkRG+4DdShN9z0OizxXzNPPCTGj
 kNijvXE+tx4MlRYdKHJUIHHoByO0lUYWiBaJRvNXR3ayvbV5bQr5y0y3awKtwGQLhrsR
 zB7xsfGPrJYzeIAvwRhrfkxK/ab+XxCV2rob98XCLqIMPrdG4rhPeIQV+plkusozQsW3
 TrsNhHIkAnPP3MwwXWMyup717m6osftUuwfcva8d0b28MWDhYoeXx6yzqPwmlYU5Iwpr
 QLKIod4y89MMkeCd7tqoi77KVWV08iXuM0qQ5FADOk0cnT4+Sn00LaxKSu/j8Ih4sLlB
 RqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779971779; x=1780576579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ektGrxW2dF9YmfpqRLqpny3BO+8C4wfKPTZVBiCxCh8=;
 b=ZA6Fr3gM6LwjfQWHUeSB1LxAm/pTpDdauhzswMupiB+ZvfwCOrwmCuJvxEnyoQmszU
 +Xw2j2Kz+fKnXjfQ58ZCkWeJw+cBT1r54lccPN2NvNb15Y0/wUxuMivzafO4WjTebZEV
 Xiel09A+jBRlGjfJFg5AF2l5gVQbugBnB+f5sbA9iStKHfFXwlWlIz9Nqx65CTr8U/te
 D7RM+3Banz7bz6bpsgaAs/JgSVU9YHk02B/o2HalgdgAmjfOpAW+wmE5bU6GyoneY722
 +8i6f9YmKLi3Wlnj3psJhMWCrlIUtcTzS1qKu4VqLfcyWK2y4d2E3yeT9crywsQisbls
 9w2w==
X-Gm-Message-State: AOJu0YxeoqDgr412E/ybdIRRfKtbKmUURbvEiWgwE+R/vbGSkyuYTG57
 UuMT78uak3a0Qm96xpU+1zBm8fWlIt5J9lQBgZY/dgLmHpTOcyCioj/3ONT/w6B6k/Uynu2qszR
 wACaohQLFX+Ua9+oz4ty27JUq9yFyTkpgXFpfoyQxCQ==
X-Gm-Gg: Acq92OFhlYl2NSH2l4rrMpuA8oHNvD9jvyNv6jwv0tgL6PhaKLbzTnx26UXQOeZefUb
 LZ38+A4qrABcKaWFd3cHOzRm5++/+jN+8nwPdNr9u0ud1ZKvV2A6FtzilSzas+JuDJf+oZgbWex
 DGLs2DfGv567P5ACYgi/zbuRgP2cFLb+fzGeOEJLf0keUk6NE9CxW9ZZ8HujqieGRMLaQnC+p3W
 8qB/3igbfHC8KNZsXwCBri4aSaw05PPefD5/DUblaPiLgjaRUp/F2jwR30ZvEpCGCxavpEl+G+J
 5o+LchqppWloqeVpRVpMEOfD39cKe+eViAjnkVGMKj5wHBhNQN5ahXMDOlV8rOSWMhwkzpVdKvl
 y2LDf+1xDDSPf
X-Received: by 2002:a05:690e:4401:b0:65d:81d3:c1c8 with SMTP id
 956f58d0204a3-65ec994db8bmr18486706d50.45.1779971779068; Thu, 28 May 2026
 05:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-15-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-15-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:36:07 +0100
X-Gm-Features: AVHnY4JgCYlfefFg2nL2FpbRiZAcf7rj8vVOkfMIZ4DzNwZ7OML0HD91d0n-RYo
Message-ID: <CAFEAcA9S+xCcV8Kk+RBMsGWPD=BNzYHe6mWW_hGqLrRgCXD1Vg@mail.gmail.com>
Subject: Re: [PATCH v7 14/16] hw/arm/xilinx_zynq: Make PS frequency
 configurable
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add ps_clk_freq to ZynqMachineClass so derived machine types can set
> their own PS clock frequency instead of using the hardcoded default.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

>  static const TypeInfo zynq_machine_type =3D {
> diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
> index 662b390431..bf411f1cc2 100644
> --- a/include/hw/arm/xilinx_zynq.h
> +++ b/include/hw/arm/xilinx_zynq.h
> @@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(ZynqMachineState, ZynqMachineClass,=
 ZYNQ_MACHINE)
>  struct ZynqMachineState {
>      MachineState parent;
>      Clock *ps_clk;
> +    Clock *mpcore_clk;
>      ARMCPU *cpu[ZYNQ_MAX_CPUS];
>      uint8_t boot_mode;
>  };

This part looks like it should have been in some other patch.

thanks
-- PMM

