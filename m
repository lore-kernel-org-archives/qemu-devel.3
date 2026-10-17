Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A80FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 13:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI4BY-0005OG-1y; Sat, 17 Oct 2026 09:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4B7-0005Mj-Tg
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:10:29 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4B6-0006rJ-Cj
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:10:25 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ab43af5e97so8518697b3.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 06:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792242622; cv=none;
 d=google.com; s=arc-20260327;
 b=XwG9atmUIjly57ap6eZj0YiWtZxk/faL9XGhJkL/TFhF3FEgfrbjoPs7rZOpWTom8j
 w7ryXKLWNPGx2JyK6Yows5sZ46eQXDc5ysdPGbCURa+YWU6q/V+jhr5/a59006j9vUYa
 fiqW6Cig7tz/Hz43y1wyuDm1cil8KzzC8yoFIhouOPeeDxzSANRAW/4pPUAEt04KQjOO
 Zr4aQyN35CzPiHG2PRPYTzlMrvoTskbQgKRC/UHN4gPCSU1nchxvoj3+zuh1SUSct0pv
 PBLfbCLJYag0dopsG1crHz3pnTi02Ng40XVazLvfsT07pDOSvvXypfetswzeUWErPq6e
 aRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4YEOEaIg+6YWob5GLr0qy49JuPDedZ0wQXlgzSvjW5M=;
 fh=JkZPAhVTYXqF8jYhYuWqSuVoAL+y6zrTGlkY26D8fgM=;
 b=hHU2vXTWfR2HiAlxINLMFY/Rd62tA56vliDC2Ifj1ZLqHaPeM5uQ8bP79gsUIdUSpj
 McFoYbF2SbYhUWY9T9hBTNPRv9uTZSb8cItvrpUFaCILM60VFpSupMtg5A5yKmgL+B/b
 u2PC8N32Ct2dMSImvOZ5ourEZR4TpqKT+te+iHg+4qOBYIsfyekH7K6TqKuyqhlwhnY+
 Bm2XCzHrkjngOQSHoST/CvDHEY2CZLUA1w+e779KzEq92NgxlUgmHUPyl+u+DEmiwk39
 OdmQZwsiO3AY9/XVjjj5icQpeOlcLp1QzUm82KmSUwqk4IvcD70UsawVeTK+1poOxa6R
 DCrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792242622; x=1792847422; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4YEOEaIg+6YWob5GLr0qy49JuPDedZ0wQXlgzSvjW5M=;
 b=qMl1CXBUgtyhRCDLieZ32leQkOMO4BW9ec1noIHybVyU+Qj6L8BmsliJQZf7kxXeik
 8DDy3kCE/s8K99z7p+g/myL8sWhrPWWIWtYJCl9zxNI/wYY32Eqg4tqFa0uh/DDOPOLl
 SW0PiPN5FRMk8UMliHnsxfXQbck3JALOUuKiyfhnxkIaEtJJX8Uaeul3eWpqoucggqNy
 NfZ74SlKqESBH/iR+gOJaGDfjSgIS6oD8xXHVbtrWJ60N+9gu8aFRJ/Em/RBXdf+Ej8D
 UAEBixoUTDwftVzH8w6mSlPiqt//RDMc6m9y/ITeRDPCpNCuD2bXhBcUga3UvzZ4hwza
 rcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792242622; x=1792847422;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4YEOEaIg+6YWob5GLr0qy49JuPDedZ0wQXlgzSvjW5M=;
 b=KlO+SXqMB18cylFoD6stQ9mzHfYegpO6dRd7OiDFESi/eWQsaXS2WBhdcEiWfHGQ4b
 EuWRaYHtrfgEI680cOq5YGcta+eZBC8d4G/hAW0n3BV60cxr3QsuupKzGMBE4Dkz0OWb
 Ano6LoKUwfUMKATx906jQw0hlDfffciKUeFvqBpdxdn3IlckytiV1HAbPiAMu924Tu0W
 LFlkjODuzR59DhnHNOzlAng4NQsp7J19GR9vjeDre5OacabVbkfUOU6sgsuoi9/tg8RH
 PN0oyBvlV/rWLLTLBwRjyjMnEVado2JWQAjl2puFHQ8/5s/t9d9tseNxvjsoZ4vaVVLW
 MUCw==
X-Gm-Message-State: AFq9FYJeVJHpshsqOuX2f0Ndu5yykS4AKxfLVuNUbfhWp4pWxfPue32P
 5dvwwr72Bh732uvxMp0Gmsd5njQYuNO5r9Rj9URUQzsEJrYTEP4pxcxWuqPL30NhKbEnu7Mmsw6
 dzfZD8Rlsdd0atbYYD25HhwoaonLyJ19VnbTrMoQl9A==
X-Gm-Gg: AYBFou0IibiWRGm0Icd+F5nOip3rzPdQ4jdFTkvYl96qhj24Pq0UbACjdyCKaTr4zis
 ReBQwusoIcWD2fY3k5UXK30kMD8J/PLcwocpjV84blmaRxigeVS5np2SdvZhJuUXp0CDKMQ/+3G
 nEhwEzIQzsXUBSCNfwCkUKAWBykoenJovR5IGPk5Z50snSB09i3crM2EgRhoHi8qfHo9aUsxdZo
 3YqRK2QSMaQosfa5OceQdNJA4No0fWp78WRnXTr11V6w2Dxsa1bh1qwMi4zGCfYRhH9Int5TRTK
 Ei1mZjoVdFag+DVMvQnI0JSt60YDbomhpIbR6m7YJJxKhmIjvyMEvfoxtGB2DsAEJ+4HEUVdCfP
 maIfcRnVvHog4WeutoXCgW+1JAziLHPJq9LvKSfg=
X-Received: by 2002:a05:690c:6c04:b0:80e:dc2:873b with SMTP id
 00721157ae682-8b0f2133876mr9195377b3.16.1792242622332; Sat, 17 Oct 2026
 06:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-16-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-16-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 14:10:10 +0100
X-Gm-Features: AclHuK9X7BXBy4vJ-DPzeeOcZT7eN_PHvOGYdnbRlKLbFyfZMyq1n9-1uOgdPtM
Message-ID: <CAFEAcA8qQ-ORtpoD4xsytbqFBOi0+cqE5Bkbv3m6mi+ZXwxm5Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] docs/system/arm/raspi: move PCIe/GENET from
 missing to implemented
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> raspi4b now has a working PCIe Root Complex and GENET Ethernet
> controller (added in the preceding patches); move them out of the
> "Missing devices" list and into "Implemented devices".
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  docs/system/arm/raspi.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
> index 44eec3f1c3..a8fc37e920 100644
> --- a/docs/system/arm/raspi.rst
> +++ b/docs/system/arm/raspi.rst
> @@ -36,10 +36,12 @@ Implemented devices
>   * VideoCore firmware (property)
>   * Peripheral SPI controller (SPI)
>   * Broadcom Serial Controller (I2C)
> + * PCIe Root Complex (raspi4b)
> + * GENET Ethernet Controller (raspi4b)
>
>  Missing devices
>  ---------------
>
>   * Pulse Width Modulation (PWM)
> - * PCIE Root Port (raspi4b)
> - * GENET Ethernet Controller (raspi4b)
> + * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
> +   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``

Do you know what's missing for the MSI support to work?

thanks
-- PMM

