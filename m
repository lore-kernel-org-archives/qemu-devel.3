Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A13CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3sj-0002Ka-1j; Sat, 17 Oct 2026 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3sf-0002IC-HD
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:51:21 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3sd-0005Oi-Qe
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:51:21 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ab432273c5so5849567b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792241478; cv=none;
 d=google.com; s=arc-20260327;
 b=D6GovwX5CpppF2kzv9/vy5klNVK5Y8uSbbPgGjAsbv+XCgk/1AE+zvwu6V8oJ6xXu8
 rBXSPcLdrB533EhCMXqo/ZSFz2Dafd57GXczT/JPTCGCaeM6N7qKL1O2Og610o1Cqg5G
 LyXdQkmAdJuyYQYTojL1FhDNO3OGrVu1Bj+KL9hi+fXxafV5gH9gH+uLkrx7eoPOFkVC
 WTQ3QHdQhStUA7LbanErgyu76YvaAxawMW6z/ib/wcC/4yhZKCbznWgy9XiDJ5ihlPrA
 JjJ0hMBi6tdmwdsmor2kAFtx6bkP2SPg/+sL0IkbbTVyY9uQy/Qg4fqrEQnT1L9TiIZk
 LKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eXJF3tbfz+IBq6aBn5AYVC3J+Uli4/6ndluaMW70gIc=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=i9OU1XwAW2or7ESn8xwuTf9+hdcVSCv+Me/p9vTGPTQPypnd3eLwo/xJJEgnxhHZ+n
 92e6T/GCulekVblzBTlvcYpxhiy+paSxNp/gLxLfnaiprJQkqJqpAolU2bS7TePTaQ7D
 b4L2CFX01a1zjTj9UchTZXvr6aoJKHVt9KeJzJFGwQncurhTmS2lwq7FrzS/8JvmFvep
 453ILUJ7MVdLiPGeuIJgqt/0Ri4zbLTr2dMYxpgDEWoHmbKHy+MOvRIxBKRsf4w/DHHT
 J8Irho/2TbsUQEJLSJTsDtnCRgpzfKeRtdVxWWU59022n/VWzwWSx4/lMS9qe60J/G5i
 q28A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792241478; x=1792846278; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eXJF3tbfz+IBq6aBn5AYVC3J+Uli4/6ndluaMW70gIc=;
 b=vkJALNmY4Vd0LdDf08CkDlFaCa1/nQl2iP92Uf9XAmRCsfQ/pBqzzC9XDlmkFZ6Ke/
 AqBXB1A/ZZdpMM15AFrDb7Qq+hRRv1T/1PCChGBBJWgG2oD6SkoPdQZc5Fy0oFbtXM5J
 T3gAY9crpfpb3bFUM/QdraxCmRdxWU07+KdNTE/SdFkiAl9YO59LPhvYjMqXIX+GC2ZB
 sWkboWq5oi1GG9Lj8nBIbvnv4nUIe0KrY28BBo8dVdkmp7JPx7ToiBr0JQ5xlnWalBO1
 Qtl/3mCTI5R0LBvv2VwWGghIOGJjW/Bl6jlPE7IwEvuor1O+lRfqmQL+5QdVRXuUcmcT
 hFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792241478; x=1792846278;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eXJF3tbfz+IBq6aBn5AYVC3J+Uli4/6ndluaMW70gIc=;
 b=dySGoN5xwDW98NUb/KR7pNvo3ia2ZyV7OPUhGmLwhySMyQieGisTGAXnTWwp3ld3mO
 aWtn16fT3/HYSkisGBYZvoLzPPbOEC0XuLUqfZ6zD0D6+6c+OqMPKi8T0dcIGZKuqZiL
 XqV0j9x/UxumTEXrrWdg4s03iM024nwgsmuacesU37R1MXhpeVmHXdeLtKHkJcXE+ybY
 uwBUm9JQAufTfDPzDTO346GUBkgrUKgurvK5Qu9MiuA9gHAh/1Cw8jgHzcu+UeZsPO/w
 55qkhjVkU1H84tIgrceUSzTl5g8O/+Bd4wS0X/fk1AEh7bPzrsqMgAyHUzuWoTUXaI7e
 Hy4Q==
X-Gm-Message-State: AFq9FYIVH/7kkDIA8ApRoaP+flv/wXEn/RDdbM5WXdJXNDWuIMV2v+aU
 3Opiw1lkfISSQqNq2gh7hwkqylEqZrk1pY+clSrA269LxId55pAs3WonFuuNg4utnlmDg/snSoD
 Va3XICHIhqzY43B0MXI+GHmjMawvJpQAnNdkdSv5d8w==
X-Gm-Gg: AYBFou2arwPPag5p0jn50nVEHQszMHDtXYwSTGWppl8IFKuvkX4dPTUXRuQccJKI4Pn
 /KmlbRiK0sbm6Im3VsdLsRXu3A8t6HS20PdSiZmbQpNQyIHe9+8yXGUxDvTZwHwHYulfWU38NSz
 JPVVmmkj0xmdWneH53aDcrUbt8mnxR8qK8WnX5KS3HsqxKyJtd3ttmROEnwJbfZyBjU0sWmOF/9
 fwMkTWjSYlddVkJCE37VeWFcswQkYzJgkuDvoiKLk/KFObybGYdjWO3cwaUUvFdB62ZoPt8iKR9
 ZahdAOKoIIOtwpUmzNMn4cL0Vl+gus8jSlbvZtdTY1pxZC496ywrYlsVpvv8sEB0w0bUQKrf1Tj
 2YXYR8IWIL5et4hcqCaOr64K0pAi21c3k2e6skq8=
X-Received: by 2002:a05:690c:ec3:b0:8ae:dfee:cd12 with SMTP id
 00721157ae682-8b0f217b5abmr12668677b3.22.1792241477845; Sat, 17 Oct 2026
 05:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-4-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-4-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:51:06 +0100
X-Gm-Features: AclHuK_yK10GXt5RYq12rQwiAf5AKkLREftR2PO_LiVUm2RQSZCQp0sduHBFkPI
Message-ID: <CAFEAcA_Ac9NO8=kckPEVXa_J2Bj79YENVS+7zZcNDO2kCPe=zA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
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
> Wire the BCM2838 PCIe host bridge into the SoC's peripheral block:
> instantiate it, map its RC registers and MMIO window.
>
> Per Peter Maydell's review of a later follow-up series, fold in the
> remaining defect from what was originally a separate bugfix here,
> since this device isn't in upstream git yet: the PCI MMIO window was
> mapped at the ARM base address with no address translation, even
> though PCIE_MMIO_OFFSET was defined for exactly that purpose (and
> otherwise unused). The DTB declares CPU 0x600000000 as mapping to PCI
> 0xc0000000, so a guest would read PCI address 0 where it expected a
> device BAR. Map an alias at the correct PCI offset instead.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

