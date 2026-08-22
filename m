Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406AAC5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 04:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxdRf-0003Mf-Fg; Sat, 22 Aug 2026 00:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wxdRb-0003MI-4C
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 00:34:59 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wxdRZ-0002xu-HB
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 00:34:58 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-669944f60b3so2084877d50.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 21:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787373295; cv=none;
 d=google.com; s=arc-20260327;
 b=LiiFRj4UfeIz4UTJV1tzFSjESYPnqpaVZuP4wZnXTzVomzUcjYkvl+69VDJ0E+cGbp
 Jc+Yt418FrRbyWgEI5j/ulevDSUwHhjuOhbBwVHFoBidTBoK+dhOLYwXtgeLEbx8SAoE
 lFnJnYQcuOlnVepdmGwRdAzpo2LdrNp9+0ArCi0SVOzDnMjY2klxyKGPuTXAMgLTxarQ
 foSJO+vM7RBGOo2RI2maX0Pc0kEUxg0ao1zThBEqB+hjI+GEkDxzgaT6fNnAarJbhoVE
 PHbMpugy9Oa8ue12PS/fk8fj93k+oP1RtOBq1dpyX5bFxYSUmNDKhyzi+YaCnevUWKeX
 QKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dIYWD+jOaVQKToLb7c8rAi2S6acjawlHa0+He8a3o8E=;
 fh=meCdqdnBwef74SS/dMqL6Iv/29k0mUTK4Lk1BzFlxZY=;
 b=X2coDKv2X8JrwTMbaTSSVRaQ4hd/LtbgYPMCb1OzzEBZcv6cXPJUjiGylXuFEJIXSn
 K5Pf7w9o1T/Fz5WCd17OhYkNGSfQB5VRnmoWElodVZfZak3fVlPHemcH+kdVhrSOssK5
 bNZ03iUA5rM8qEmKJmSpXgbR0yZP4CRJMVJZV2oMH5bjt9rcjxZ/W24DEY8nd7HqCFwW
 1O76TrtFGRXzIO/SxCNHFkq8MKJlqGxlalmRzoEbaewxMgnTC37JJswq7cpsOj+487xI
 ZBuIRNMsSvVFqDa1bb6w5siPZNFpJUOOkTkfI2sDyvIqaeNQfWRL5dKf2NdETzEvBOdN
 OqXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787373295; x=1787978095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dIYWD+jOaVQKToLb7c8rAi2S6acjawlHa0+He8a3o8E=;
 b=fQrIRj6R4e7tV2zSdORa6XFGUtEzfT052CCeftdtODQf6DI9r88ggy6/GPVCQdPEkB
 T00b9fuerVVz2OoP3pOr+CO5mdNBEb2JhrvIKfdVYsTpQ4zR1JTHQAbhrx4bxwFfCYOH
 qNXhKvuDnQ+BESZwDoGwRb/DVrAxyF/v6ZfVAXSraMHJuegAmq5vekwnO2puAeQdY7tq
 BQ2+LjolluZZTTPZagnAucgJOeQzFzeZ2DpPhO42K918iY5p/IKPmpqVQ8uv1BXt2DC7
 OnlBoQ+tmAPWieC98ToMdV2M0sOTx+uzxoJ/RiDDtEuSX8gNbrYgKlkcOUA+GBSalWvD
 Vg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787373295; x=1787978095;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIYWD+jOaVQKToLb7c8rAi2S6acjawlHa0+He8a3o8E=;
 b=ZqXIMQ+Ayg8GglyZ0HO4Zin8HVp7h0OPTrfQoOWK7cv5rTVdXfGSNM7k26y4KRZ/1Z
 w/sf+i4RM02KdOKO1OGP8WB6dxsIimiH6P0HG+b8dgRJ+B8GFfGKY1Nc1hlNQc3xp8Ir
 HIF4J+G59/J1TZLeVL/06rW/dO+HqVftrpMRbg5K68ulwF656nVALN6hnFyyuLn1BZ3B
 WApuZsmQygbtzvIUOkHhms9L/6Y01u1jd+YcFynNYiA3e3669GuJONnKFtB6tPnBdyuX
 uOg97vj0E32cGupyxhJI4+06Tixu5K/dYqDoPej1MOiNUWGn+Z47DdXuvJU9v7IkmKJP
 vvUA==
X-Gm-Message-State: AFuF++mjJz25Uce74cWIpljmuXXdWB+Ls2WwX92QlRNg304I8e8AQAip
 Xf65ua3X09SNQZZ0e+bcMozhYt3YIOHUJqJtQN1BptJ9Ov7OAe6sWoC+6N7M6GpI7S121lKbWe/
 BVjW4f6UWpVkSbVFtRN7nuHXjJ75nUsQ=
X-Gm-Gg: AR+sD12Y0RaA5ZMo3vVBS9QysTZYZ+28jblduBMtNC/LnB7EI4fOVhpJe8lN51r+n3o
 6b9XLFcTCYtzbNX2SeevBk534Qq5L7K3yBdpDOuIjtKUPEfZ0XDDYBnRMJKJxHLZl7ZS0zBg37P
 auw2zWil/Bg1pWoUPxMrckA8VThLchgMmDLTGYjJvfP3z8/fefNvhRU8qC1B1bLpFTyIsJgO7uJ
 s4SKyeEbKguSCWcFunxgU0zKS1h8tE6rcVpykfzvvyFswJJJdLWoldn3CZaL5LiTE8wMHOgNdGw
 MtC7pCLjeByhO8tol7v2fVahrJEgEinW7TDHN7w1VZLLHx+mbQkCaGePF2wvs/lGQIS/1qLROJ4
 4mA==
X-Received: by 2002:a05:690e:2241:b0:668:15aa:4f79 with SMTP id
 956f58d0204a3-66ce498b854mr3308426d50.2.1787373295286; Fri, 21 Aug 2026
 21:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260715160731.29969-1-dingtao0430@163.com>
In-Reply-To: <20260715160731.29969-1-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 22 Aug 2026 12:34:43 +0800
X-Gm-Features: AcwNN1WwOyadlIeeFEGzFk2MRByjWXnlhnuWorMhAs0k_ov3nbrzGH54w17o7y0
Message-ID: <CAEUhbmXiFwpKv9tpBMGeX6mWw2CBisibt5JkM4S-CAVf0dDqYA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] sdhci: fix SDMA boundary bug
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Philippe,

On Thu, Jul 16, 2026 at 12:08=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
te:
>
> Hi all,
>
> This series fixes an SDMA multi-block transfer bug in the generic SDHCI
> controller.
>
> The previous series was posted here:
> https://lore.kernel.org/qemu-devel/20260713161647.20211-1-dingtao0430@163=
.com/
>
> Thanks
>
> Changes in v6->v7:
> * patch 1/2. The addition of pre_load and post_load methods to
>   handling of migration from older versions.
> * patch 2/2 is unchanged. keep Reviewed-by Bin Meng.
>
> Tao Ding (2):
>   hw/sd: sdhci: Fix SDMA boundary bug
>   qtest: add xilinx-zynq SDHCI sdma test
>
>  hw/sd/sdhci.c                        |  54 +++++++-
>  include/hw/sd/sdhci.h                |   2 +
>  tests/qtest/meson.build              |   1 +
>  tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
>  4 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c
>
>
> base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
> --

To make things easier, would you apply this series to your local tree?
Some patches in the ML are depending on this series.

Regards,
Bin

