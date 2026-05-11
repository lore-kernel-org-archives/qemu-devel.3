Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FEACD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMS3D-000149-Sx; Mon, 11 May 2026 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMS2x-0000y7-TA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:55:53 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMS2s-00053E-IF
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:55:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso8076060a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511345; cv=none;
 d=google.com; s=arc-20240605;
 b=Ju57+ZmJRhe6jXzM017d5yfD4c+Oqo7BKujJzvL+uxW8HBx+d1OHNFwLZ7peQF/tQS
 vfj4giUwlNelgM73K5XjPwTYpAbvyrQf2qqb3v33s3gGu8KOSzfZ1X8+oIUsvL41+WcH
 FGuoeQRLFG1z/3BkccFc1F+m/GJpZmXqVhAkmWT3xeJTd0gozhFNUXVrq4Bj94g70CC0
 w5o+DP79mg5f/ENs43vCn/vcBCzhZLgKgRj2Hgdpfg8yw8w4dKanEoxdLRtxTCQTT+x6
 NsitjYXkU+3qMre29gNxa3VIEuP7RWA7iS0memvyvHHwfz0pa2+MS943saE5XgKyZE+P
 XNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VNijOCZkE4OPNW65AVHwTEPv8tZ0Qv0gS7rrW1ZRJ2I=;
 fh=/zMnIkxI+kSNLKBt14e44HEh45ZrK0zx/wXFAZph4MQ=;
 b=aTdsj+BDCGS78lqAHonH5oprUTBeNFDOAc98tKbU88liZWd5r0fZzQ6h15lZzlRtna
 REbYoflgsDUd9rEGFKU8cOczWmZfFtbD+6C+Dy2s3xzmvCfS7IYgKWOp3QS6snLYrTXJ
 fzlfBFJzNjz5/Ls902zZkC2fNaES6jcdrk3lLrhwYYtQoBjcFCimxrEL2NZ1S6X8ttNt
 OskjrGx0PzmJ7t23bV4tGnJYjsElcnZcs5TQJ9fVIqHcgDCQ1rPwU5SpGT6Jx6UG3bvp
 RQoTpSCL1SuxeItH5WU+aL4wiIeMgzr72e5cYBODm0iWeGroO1yZFmDIGRiqXfwXqNSj
 iQKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778511345; x=1779116145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNijOCZkE4OPNW65AVHwTEPv8tZ0Qv0gS7rrW1ZRJ2I=;
 b=IzYlYsLRsjPN82lDVBSk5Ym8n9c+mgZxVS/xtesxxLlOCiCr/F8bBs9r7L0zqZZrj1
 M5AZhAYAEWLwH6bdOcdl9pf3fk935lhf9iMJOHP+QxXogWlsltTDyocy8wHFpZu6rtOW
 nxc56+XUfReHaKpC2X3AnvnNTFANeVZQqfQjUvY/WIPb4mxOU8WHC6eoTLirfBKHYEyM
 6BT2pzNOCEtIzu78e+bP/abOI3OkSvxsWDlCPlYXJSY++oWm/LiSbkarOoB95hgq5kTa
 YFairw/yihApxEKMj5qF3C2WSYTUDqHA5P84MyKpRQJ/HzwcB+j9JQsFMwcsSFsFClgC
 wAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511345; x=1779116145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNijOCZkE4OPNW65AVHwTEPv8tZ0Qv0gS7rrW1ZRJ2I=;
 b=GM4+TVGjguMUlbjD3Jh5I0TSY+r93kYZzezN86Lzh6f3oYpLnUDdzzShsRu94uGSZ7
 Qmz/KXfv+3UVbIFV6mazntFj43TxnA+WWNrpaqXlzIqOrmztFSii473nr19a8O7Kywpx
 Pp6DQcAIugIbPDRZu/fe1yeNSDPP0GaG2ltDPrJt6w47NWCB/b40kvj0HXsopJIMTmp8
 ZU1vcDv3Lb1Y6hSpUaAj1/MowJq3tSA2Nm0GkthJlxcEuihTNwLlfyjBkz+8fImkgThJ
 VyfYFgmFf7wMup/uzeG3n4izvmMIGubWfnLSLaoUiaOZ92+aIUhcWz0MEHa42AwBqyy/
 GpUw==
X-Gm-Message-State: AOJu0YyA/GjNRkt7deZM5AKz2z91Fc5vG08Z1cHiqp/h+c8PEwCVsSwH
 Syxv5dLyBSTJSBH7nSQ+wZaqAheEhJWVY/4ULK84JzB4wKS5n0hskNlv898mEUSl3mzWVBEaRIr
 UyToyIGgLYKMJqzsVqtziwasOqTDxDZgXfh+Wlp8y2A==
X-Gm-Gg: Acq92OFndchO5d1wbp3/8CXl9h2XEsKocJfYOz+nwWLWy0advHJgadoq/ak3eZ8g/+C
 SfrsII6j1iFGT1tIb76Gc7dHO7hgDK9JmYg4umVhpCtfO3qfaNKgynE2siRoMgdfXR1Jj6Nw4cy
 JOCCuyH6y1HGpXsZw/9J79ZmT+bfga5ZOwMjrxa3yDnCQgPypGrmzvQ8TRgpcv0zcANXXhOyNkL
 EKoHICPBULjsksMm940Z2D1AKsl7W1gqn/d5eYa5tSpRrzRN07BCyftZce0FOp840HIAH2BgtW4
 c6Ms7BguQGTm7Gna/T/hyAFQSjeAt9pgLBdiu4kALmvV549AXUtTYsK3Lfkc/sdqyFE=
X-Received: by 2002:a05:6402:358a:b0:67d:7e99:bf4e with SMTP id
 4fb4d7f45d1cf-67d7e99dbf8mr12904734a12.23.1778511344777; Mon, 11 May 2026
 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260507135816.71171-1-philmd@linaro.org>
In-Reply-To: <20260507135816.71171-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:55:32 +0100
X-Gm-Features: AVHnY4Ie-olQv5pFeO2VeMx-01TWBPN7at8OUMBeA8XwpiKIsGjEvNGjXwgvRis
Message-ID: <CAFEAcA-d2EspJcjyfbBNPX3x6GF0kbDCO1bnoDWb4pyEnFgRhw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Build ARM/HVF GICv3 stub once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 7 May 2026 at 14:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
> ("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
> the global stub_ss[] source set which holds stub files being
> built once for all binaries, instead of one time per system
> binary. This prevents symbol clash when trying to build a
> single QEMU system binary:
>
>   clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>   duplicate symbol '_vmstate_gicv3_hvf' in:
>       libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>       libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>   ld: 1 duplicate symbols
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

