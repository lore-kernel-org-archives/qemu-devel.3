Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C51CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDO7H-00068H-1G; Sun, 04 Oct 2026 11:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO70-00060V-3m
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:26:50 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO6y-00060I-MI
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:26:49 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab445ac183so7653617b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791127607; cv=none;
 d=google.com; s=arc-20260327;
 b=k+oXpjeRNwBd8hWRZLXtMreaV3GY9dp5N0GwWokSppgGEyoYTMIWK6X1TuD8tk61x2
 ixVsRvkUdDru0K2/LBIpi7pP7qXBzCNHs6CcdmGeoammwxWcNe8GW1siORxWC0/3GhAq
 4vtD6lDOHujWTksBadm68iUaML2vvTFD75ntsYc8I1dsVMcDL2b3JQLhX4xRzMB9UfAL
 R3E1ggoS1egbSZFK6WhCFulCEHfoSdk5/wQPXVTVvLTcgaP6puJ76gYCWDNVKXowssYG
 i7bqHIv9e+R4C4SiZMGBKBKQr77EU+lLLGPLR+l/65RGrLZuCG+RoZqTdd+GhwBPYNyk
 ZvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g10pd3X1IgzZ/IO4Y3r2j2UA80f1HVdhL5FiOZhyBNw=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=rz8/XfneIs3txRi93UIi5UiXmMGvpMv9rW6ZvxGb/wLTZ7j1vkVpMwiwMJnpJi1WHc
 3CcfR6eT3BGX9GaOkCO75+jH+1a7HnEyc4Tx6KNJ7kuqQ9PMuucQZERGFraRweWj1Ccx
 cX3dAYetUafPaKIAPm4CaH9KofzWHSzrSgecs8Z45VZQ59m40ppwRyer6CP9qvEfJxS8
 o+y6meu19ZQQ5D2MzBcz00qS9+Y/1I/e6RCGVwlln51EQPh9C4xPX3AV88vQRiaRdyq2
 7RPhBqKo9UBduksV27Bf/cp1lN5EKm5Kiigk3WkkcpBpLPVmKDGSaqFfG7lIUNOxS1/F
 ZjoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127607; x=1791732407; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g10pd3X1IgzZ/IO4Y3r2j2UA80f1HVdhL5FiOZhyBNw=;
 b=g0frr2CAnbgPefFlpCpONvjhJY3OykawQD1LtNcTOPwcWKYWh/iawqVIRgWqfJiNGP
 y0nbscKCJesLLe5iO0cTme/J+3cfGc0vDV4+3L6goKOOcvpuRC0jiiXlcOwjvxXGOzFN
 necregcZMsFj3sm4BBnJAY4UmECuBDoHhZtribtdbGnXxT279igFryaA40DyJ8oJ3v4Z
 XuElYW32L4UTa9hZT7IwBQSXxvvMRgW2H5w3d8Aatnz4R+a5jn0nvDHzhQfAP4llvT7m
 rp184IK/Z00qmvl2VTLNgf8+cniNNogcag+Tmj6i7d497sUvaG/lZRQbJCLU9tF28hbw
 BcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127607; x=1791732407;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g10pd3X1IgzZ/IO4Y3r2j2UA80f1HVdhL5FiOZhyBNw=;
 b=J1pEiNEm1gb4aRrz5S6innAqeq1rQjE09Uhx7irh8AGwldEhSeUER58IY4UaUqn9/+
 RiZXahHOL/4G7cppXL1FIjfLZh6MoNC22HFlFZD/GXcSzinTI9i3lrAgd2kfG24MrV/6
 yoSIElvdd3PpglWefQNOxwyNZgOt7HQmSrMdItslTV7wXTbV1Gg5MmyB3Ntq3mn5aG/T
 S9J4R4dFxc5sprT7tUka/O1fn461HClp/MAd/d4/JM2G46jYRD/AnkqdthpLzgRkqn8Z
 cJdsKqFpndMA78GBbnaEgLV/f3ZZ3OM9wFfasS4/WGxWP+kmEqsHEaE30gfvghCrJUO9
 d2fA==
X-Gm-Message-State: AFq9FYLVGw5mTr9w9VRTOnlscDgOf0U04Du6EblcNIhlPO9iOroJlaAj
 UP8lD56I7uq+KAseIlVuT59QIjwNKvuqb9gk8SXf478dHq8NnuMgrCpC4LWpmEYwK4BrXXFzn2y
 bLX/nGbq4j05ZkhB7OiuY+tV89HNao9A=
X-Gm-Gg: AYBFou1R3clQA62Pv3L9shthyXSj3w/VWiCopOGFAAurPzhoWsZAkZijRBmSt0CXu6z
 +Ec9ns2wTp48AMqPMCz67ML5XIVB73Rn+OugI8InZEa0GvtRmaeBTfOrXvB45aff+ryWzIuRIuZ
 pIwAICqO77REEOLxK6FHrObkKrMhyw5OEuN2jwPzAFLq7WYFv3B7wRoMVEsCvTiZadwbd8qJAT+
 RfvfJbwLGdD2DYDtKWasEguadflFVrsa/d3KeHu5qHCAcch11GjcOFlB7s5Js2na21F/nXMtlIe
 UFwkaho43zgg8qUMv26Z3QX5CvnK2t7Ge44+2Y40e3EBuzgDMH4ZaB/GO7Z2qeCo7CZElF+tqxp
 /WWZMqxowMuQMwR7H
X-Received: by 2002:a05:690c:9990:b0:7db:ccda:a409 with SMTP id
 00721157ae682-8ae392b6973mr35221947b3.9.1791127606991; Sun, 04 Oct 2026
 08:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-5-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-5-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:26:35 +0800
X-Gm-Features: AclHuK8kOWrucEEovAZ35f7qWzs0b5o9-pcokpk5q9uQOeB-jKLKjKqBSPZfs1s
Message-ID: <CAEUhbmW0BcgxFLF6MMasng_dkQ93dG8-1D_RrcmyNYdSeXexfg@mail.gmail.com>
Subject: Re: [PATCH v2 04/30] hw/arm/imx8mm-evk: Fix reference count of SoC
 object
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Using sysbus_realize_and_unref() requires object_new() rather than
> object_new_with_props(), otherwise the initial reference count is
> subtracted twice, i.e. ends up being one too low.
>
> board")

corrupted commit message?

>
> Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit)
> cc: qemu-stable
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/imx8mm-evk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
> index c3215b11cb..6de0d9c4a2 100644
> --- a/hw/arm/imx8mm-evk.c
> +++ b/hw/arm/imx8mm-evk.c
> @@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
>      ims->bootinfo.psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;
>      ims->bootinfo.modify_dtb =3D imx8mm_evk_modify_dtb;
>
> -    s =3D FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machi=
ne),
> -                                         "soc", &error_fatal, NULL));
> +    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal)=
;
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>

Otherwise,
Reviewed-by: Bin Meng <bin.meng@processmission.com>

