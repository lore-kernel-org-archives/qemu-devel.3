Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9167C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuqi8-0003Xg-E0; Fri, 14 Aug 2026 08:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wuqi0-0003WK-LU
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 08:08:28 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wuqhy-000473-Pe
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 08:08:24 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836c590b61eso14381727b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786709301; cv=none;
 d=google.com; s=arc-20260327;
 b=ceP754fXscHdZ5PstqRUd87CIY/I9d84DG+bGKI1iqQAQj0RkqR2GjO+HVRrzD638d
 jBg/Us3yPqZ6ZvcgKZ8y/kj1IvGttTLaL/0J0Y7t5XR+pDX9++gBjrnl3CvfKd/r6bRM
 CQ9+GtPeXHU9pyNEnbEzIKGGqOupI8zlZGi9LfFOergvPhXqeaA9IIB8YDMLanRajhDm
 HGgxLr4qImRn7l/ZNMD/8ay2wVyv9/Lu3sPqrNmbhWSO97vCL66nRD8hrf1Xjl3jitUb
 SolRuWZFYWFOF0rOJkTOP5Vq9QGvMakBMvXiwtZD4hszrZPbvNtbUNgBxFMXWQAB281w
 96/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+aKHDmXyLoTYJ2f5FAdpr+11saZGBxcd09WIhmDvk7w=;
 fh=TWBYEUau0XqVCXPvBYqDOgwWH+zMbgRMG70MkxJkFFY=;
 b=Ri9F3GLcuGLj7BBwvS2Z7eFLtv2PiLb4FiN00I2xGkjmorYsKQnsf9osHVs9BHL1Gn
 QTgL4YdW2jAe1MG4vRQ7GB5ToTPI+86sSUZZeA/XNRsx57T+Lkvv0PK+6gp4hwrM9X67
 IHfjQfOCtLWGEGmY2Kv/dQyzpTjqzDzM27Gr1DMpe+aTkeQwZAT5Xxp03+SivERtXiiY
 KKucBMGdmzxftdlXDRL6Qipvx1MIknCbkWWNfkb/nHDvrFFHm6iTFJCywR/rx6AUBmVq
 BZEvNpaQG254tdsgV2+Bzw4cuAL61C5m4bauLELVaf+6awE9FzY983TxWEaWVbl7Vtax
 sKAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786709301; x=1787314101; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+aKHDmXyLoTYJ2f5FAdpr+11saZGBxcd09WIhmDvk7w=;
 b=gwsgdv15DvNXfWc4QleEgcu6t2lmV1s5gw7X2JHgFpclyNawkiHXNswYa7E0DYXZ6u
 HCodGMmGMfSMxS7yuko5yt6kQCj5GqfUP2JUr83H7OO1nTJDjAwwqFWz1E066q+YCLXG
 7MDwiJE0XMMryStG1y3fjJbLNZog0Mb873j8UK3ouiI+/bNz9pI3q7TkT5MOLnxfVvSm
 L3+fkVcb9IYjoDtLgGPd+1z0defZMkPp5fxdWVni4Y0EtUowx1yvAKunCrf3ffnzkjXa
 +hEnd2UVbKgk7LA1PyB5vW2+YuGV7jakNiIVI7/6hwA0N5N7x/PRx60KUDOnjz9HwKrV
 bFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786709301; x=1787314101;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+aKHDmXyLoTYJ2f5FAdpr+11saZGBxcd09WIhmDvk7w=;
 b=glucMN8BNGZFAZrFHRSx9CwepNqMTasiy3wT7ollApRKs3jwD1vBpAGL6dyWB9VNkB
 wr/SbGfLqngheE80XnU0fOCLefD3N3fvEpuYLnNddnd3YHIp3Gm0ax/eaVME8ErQWN4F
 6/nRThC3RqJVVZSvMnRUKUL5mCbQ/8SYei0LrxXtdqkawOIElx6EMYimg+KgYc4VPTIO
 lnLmXX37fJELbTjo0COxBo3IWai2Y+nuDfyL4xGU8swo/Kl5RtvpNjYP/scdw4XDOpmP
 PD7YlUXUprMftc10PPu1wjoNwqr4I/6RUycf5kDIBz+w2gfFkIJX98ESRvWNhv569gc9
 c6mw==
X-Gm-Message-State: AOJu0YzuZmktibZvh4MPUDMTxe6sPpUCuOJVUJ7WbwCXxtBUrBBNb3Hm
 Lxsjd4OsUMvQFl0nwvyWYW+6Vu68MV3GpsRUdB3orIe83wsS24RsI4BGL0bSZEGzrPgTgHGdR9L
 A0e29qqOOEQvL/jn2mggqRH4c5M32atI19OdEbPg0IA==
X-Gm-Gg: AR+sD13CdxVp1eXuQCvXhYWMF8JxqZmWC1Q6MyCZknLG5XryXfQ4tJom24bF9CI2qpT
 YxEiw+zjJqABvggu1bY05Mg8i2BCyy5ijY7NZcQgbni8q0IriFXWL+xPVTeOkMl36NCJFpyRNom
 Y7ypHcWbhHz9zxtcUD/lVxdFQ2/Scpc3WjLmKWeQrD97CrmIJwSnY4v5Md4/nvyQlhf4hQphHyN
 SpFaioWNnleIZ1zTAc1gEtk/T8o29HGQZfoRbqkFB7KI2sYJw7FXNIO1qBxr6VAS9M7X1hPRA1Y
 ORzcnGXaBC75DEDroU7mceGaOC13WXGmTgAtpLi9/I0nMZkfyoM8F/EnA90gKFEIR+l7bBLHcbY
 1ETyYJ61PVo4NT+4NvW7emBMt+fvDjBBCMQ==
X-Received: by 2002:a05:690c:39d:b0:833:968e:c236 with SMTP id
 00721157ae682-8370e1b7cb8mr22526867b3.13.1786709300973; Fri, 14 Aug 2026
 05:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Aug 2026 13:08:08 +0100
X-Gm-Features: AUfX_myr5QIMRQsEf9CpvioQGInYD0aGVEiDQ-mEL81YU508ex-erX7rh75Ycqc
Message-ID: <CAFEAcA8p3OvB8S+dY5nTZ1Hq7us239yPyOufKzmrAT1qszsXEA@mail.gmail.com>
Subject: Re: [PULL 0/6] qom-qdev queue 20260814
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 14 Aug 2026 at 12:32, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> [MCA: This PR is signed using a new, separate Nutanix key: please update your
>  gpg keys first before processing! ]

Which keyserver(s) did you upload it to? Unfortunately there's
no longer a single set of interconnected servers, so it's
helpful to specify here.

thanks
-- PMM

