Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59ECF30951
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7RF-0006qN-Ap; Thu, 05 Mar 2026 07:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7R8-0006q3-Mi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:04:15 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7R7-0006U9-90
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:04:14 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9707fc11so5904076d50.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:04:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772712250; cv=none;
 d=google.com; s=arc-20240605;
 b=I1YsoRkTdxoqafElIaAjxbSwkXPRIpdInj1aYAl/Zf/j+aB+HU8FO6P8GJ9l8hm5J6
 nw1uPqmQoE3mGoAsUhjZ3QQiFxpqi9EFHF5Elv1vDEM8dnLkKFZi0AdtGxC1gkdv/zyM
 yKjFXQ7d/51rb092kSg/U2tcX5EtCAzZPBGFwOPRy6s3BTAEfwbnhAYbDhWNJ7hHvnKH
 1YfyyOngz8fXgyVCMIMgkhidSWMjl1BClx0TcmoA3EUZsuOTH485ak5GhXC/FeO4REmG
 vRqqHBImaY5YU8AuUm1MTsf2SdeZoCbM4PtZb5Z/0xl22cEgOHDEfLCuotRpH8RLaCzq
 WxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RQaSKueYeqWVHX53ImhdJEBXSS1FHdPnIHcHEfIW6fA=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=SdQpnYD8nyNhWX8J45YwsI7xsETGg5Hk/3rJ1tPMywYfIjBJA8+njXBMsFac5ksf5G
 xLJ8s5IQZEQU2yU2nTFEGJq+qBREctXbJH/xDc56YnniB1jAOgFUFyWiCbkzrnlPYZCd
 7yt6zhfU3iVwc8jVntpMxXaJKJfkq6GGPGh7FShYfmuLPg1dlxL/i8l1ajJJVSDDKf2g
 gyCCu9tFADvEWzM605IYCyKhRAyMKblgOX3o4qmju6kY+lKnSG7MS+H+fHeGkNhqTJng
 HeiOxn2mbQRbaI+nbn7ffk3UM5FVf650nY4XpFh2C71W8bz+RbgfoDeUYdXt9LGMkTk4
 z1Sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772712250; x=1773317050; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQaSKueYeqWVHX53ImhdJEBXSS1FHdPnIHcHEfIW6fA=;
 b=TGwWSE5ZamvEz0bnwsBM3Z2fvC2vtMKaQblfS29Q/XeSN584Mrt3cIK1/mOcmpD5FQ
 l5dFfjbyqm6ELxhgNe3IJitKklG1E4jB0ND10P9gNrM19HF+vK9GBEi+2sTCULIrogrZ
 4ohRyV7rhD95P8brWpoNa6JchC2Jg55FKBnLk6IZe0KJ6v4UYLNvuSU49j95DUpLc8BZ
 Nlwwc4+S3Y3hHy/yftMQ9brdeMAgcyNzZFT8SBl9LTuyVVA57u/o7O5LrBhpjYJ9NXyL
 TfnIsEyxJAJfdNPGZt843Iut+DductbD1W2BA/TDKuNnBJ2oxyxB9HJrxDWfoLJbO+26
 XIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772712250; x=1773317050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQaSKueYeqWVHX53ImhdJEBXSS1FHdPnIHcHEfIW6fA=;
 b=ip0URl6ilL1c5J4rSDFMJWA4jdJO5Kl8EunZgcUpageMrRaLtMlvGWZvOpd8T6xmmJ
 CWKaqOeE6ta7nWKgex2zVrduZjjhlNUUBCu78LQtZ+BcmwqTikjDJ1eWeWkxlf2+zO6S
 gxBpMgk6/aTPEikFeueb+ciGVrRTbg8TKBaaEeqqfKvcFollWE7U+SWI622erLB+zFDd
 +s00vZNpdDlaqtxzq8qp/jREnHAxRPHiDpbUsu/bjatxu1P4U74dFuVSjdTrrB+bXI0g
 XNZX1WAFk4PjoW/NcmrK108ZKWP0DADgkhibp69I66UL2aWLjlKtqt87odKKGHmPuZmY
 8cSw==
X-Gm-Message-State: AOJu0YwY+wy6LBUoHcZkWzIwtyu08prRn9ygbGwYi8lu1a+VGJbXLm7J
 9uWMYKjmBCCIRv85UWp13TEOUOgdXtwlN77cbR2fuH0Oi/wkQ2/6Wmz0RGYb8xinjfRNskj2E0x
 U1KoI4qQnLTNgmqzBEYEbf8uWyOZrzabNVLDj8r8is+wMFvOq02sY
X-Gm-Gg: ATEYQzyWC5TsRjs54jmdymBTe+Zqq2cdSqrApE9skzQP3VlIzz9Qjqq1qjFcRrAP15T
 tRChUAKTi1cf8bS5w0bqriiF+vRclaDT0g8iPL7zDF9GVxT78LOEdARXorI2eeaZZ7wiebSVYbP
 a9z7OujlxK7NQfdiq263P8o2tFga4AQfnWIf/4dLBWWwm9LwkK5QVOHu7RyuQDLH6uFMAQwFPGs
 +zNAFa5NR3GlBMbgLKoG5/VSHTncCJKSQs6YkEZiYqv4kCU2mPyvecuo12GKdLY0AzVj+C+9oSP
 X9Su6Wd00IaTIP4g7sNsj6/2d3FIQxx7GPb3dX8Wn+sk7sYKPC+LR32PWj661QpeU8Y=
X-Received: by 2002:a53:ac96:0:b0:64a:f2dc:286e with SMTP id
 956f58d0204a3-64cf9baa83emr4753026d50.41.1772712250005; Thu, 05 Mar 2026
 04:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20260305103400.1574217-1-kchiu@axiado.com>
 <CAFEAcA9hcr7sDHvv-o_YRkaBJLTt99Uh=DgLtTHw_=jA6A4j5w@mail.gmail.com>
 <460c0ea9-005c-4970-9cee-bffb7e9c0c11@axiado.com>
In-Reply-To: <460c0ea9-005c-4970-9cee-bffb7e9c0c11@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 12:03:58 +0000
X-Gm-Features: AaiRm51oVHLul5QiTubE1bSYnf1nWZpY4nB_hUdgzDo0kvp2LAKeZR-bEQHrx0A
Message-ID: <CAFEAcA_w6DDdBRnpYDNDPUOO5Quf_7J6ty8XNVCe=8N7KAy5Sg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Add new model for Cadence GPIO controller
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 5 Mar 2026 at 11:22, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Hi
>
> Understood.
> I verified this device model with our Axiado EVK machine which is still
> under development
> Does that mean I have to submit patch to add our EVK machine into QEMU
> first then add this device to it?

Yes, that's generally the way we would prefer. Or if this
device is used in some existing board we already model
(and we just haven't implemented it there) then that would
be the other option.

thanks
-- PMM

