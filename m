Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15024EC1421
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOH9-0002FC-Sw; Tue, 03 Mar 2026 06:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOH6-0002Ay-9d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:50:53 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOH3-0003n0-I3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:50:52 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so3963942d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772538646; cv=none;
 d=google.com; s=arc-20240605;
 b=D2JX9qkW2B2KKHV24qHQjyctvCl30WHGhpbx+zmxYmfw/R32lQ5amkhfosaHnZSU6U
 NE7VSto311yYRKdzUkO2qzAVzpe+8RYYRarF6Lf+2YjuC78acE9Z4VkawkdilIqA6vjg
 7fXgHsWs78gtubmJAb4ApZXV5O/HLgEkUHaB+SKmaysLPYkKy22ZLUDG1DIZFcVe1K2Z
 KkroBFwRg8AUEjS4FVTu3HTCl6QJdjS5rj2V94LPwRGgvLO/BnB93SaDfOhJYW061ROX
 d1HANo68zv4yB4+qMB3PnJuOQ1QlihkMqAjVcdEr2jp5mA2JFAfcrf7FXtKikFJC7GRQ
 cxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YA2wwIXIKz4S4wEPRT37VhbRcqwqzKwNh/Huohjczzk=;
 fh=T88ARnbVmkuqJ2M09/aa7xboX1eRlwPm3/ZZ3hIkeuE=;
 b=gvQ8oN5xhYPjaQ9vomnQUNyKVhXyCMPTdz+v2lr2xg5jInCrCgHqDm7UhwjvJN2fjT
 QckvIIkLUOP40rnVp2j0mp4ncqvSO57whlVof2L9rVjmb//id8ToL51bJMlZZOyyOf2p
 NWlLeLSL4N63qGJBRL7KdmmJofoSQLsY4QU/tT4AQSUNTLmf+Ojsnoq/R3VY2IaM7Sy/
 6wVbkmvhNlwRX96I4GCjPwU8S+12LeQVM8ePyy5M2OnK4EHkflzInzGiAlMuT7mb20Yd
 FEja2HrG6foNDGDm0iVZZtRpxhYznuucVvvEzayyuWoby2UPCpbfR5EWZYWFLvaC8Xg8
 5oDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772538646; x=1773143446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YA2wwIXIKz4S4wEPRT37VhbRcqwqzKwNh/Huohjczzk=;
 b=fzy7/lql0Jmi1mzTg93KZAyXxxtFnqFJdnyDwa/IceycwDYuhN/43/e2Mcz22Odrzv
 MdgbXXCca9uqOYw28y7uqEjJiJCh5Ne3XyQd/lgMIVXNlRhYJjd9GzZcLG9WMpKRcEOr
 seFEY/ZtQK/7womVnF/4wvt09SXuMpS/G8WPCzIx0uMp+oKUxRgI6kIKyziuowlNukt3
 oGjE7utfhc7/y6hGiMDE+Nb0O6fLB2wvPs7e300a4SyZB4da44qAjH70N2+ckN5miiEc
 9AM5punWrZvXX+ILolcd5jA49vZBGZshDkv3jZkkRKDwRXhjcCdRbEZbnz531bFHXbWi
 mHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772538646; x=1773143446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YA2wwIXIKz4S4wEPRT37VhbRcqwqzKwNh/Huohjczzk=;
 b=QCCFwS/baehcHRvm7Co0UmpmgV8QRqNBajTTsmxCgCnmxU4sb869ejRQo3b0Ls8H4j
 59h7U/bZoEZ1YFFmPuEMYfM8N+KkXVO4/bKk1xrH6D1m/38KDEzGFKXoWL7NmkcGafza
 aUNHf8hCul5kWIg4ytDpEjKOOFgqRFgCKHV32dnIoftZ7LISIG5F5SyEGYLPfuh94Ksv
 SFQRykdP93RoMumTa7l3tvCaNZtBp/WCj8It2VX0BT0FcdgAKj575Tp1LCheNzHQjan+
 AvduKm/bPchsoQXTNgLLcyoxS+ETZQRPhUcPsLspyf9a7sOsmozkxFcpjd5+JNO6qDRq
 ZgjQ==
X-Gm-Message-State: AOJu0Yw5Xs7AR8q3WPZ4CfJZjSyHgOk70RJDIwA+7g0XzjVYsEC2Lt6h
 Qp6ogdWzayYb+YNvSKquMlja49bDWB6anI4ddik/M9Aq9NjJZ2lmNzAicO999LRQatvyhRKNZKx
 bBC0wr49x/NKNgOSgmZ3mOoHJBpV8jjnOr0IxBW4yrA==
X-Gm-Gg: ATEYQzyDd1F4EW9q53zo3/rA24QgWiGjfHxo+5jUcc2+vQ4veLnoeFAPImOsZCLthS4
 xvkfrAN+FP5UqX1sxfDCtJVjtG++gKGFjmIXgDgmxoTLMmiIFG29L3N9y2eqhNbPiLHKz5v/dGR
 dGHO7LMNder1Nlj6qNYuE4v7w/AGv/wxrj4AloNsyDt8srwnT7+YwDc7a07cF1IS7UacbMv4KzT
 3OJn/06Q2pMLbjylfbSInvQbLAW7u86nbWfWem6XWtkFDkdOS22/N2rApRyyBRltut8Dd64IAB+
 r/CLsNwbt0uhzoh2+XeAnbXTcRw3CvE/GfdGF5wxFoQEUFTbXFKwXQESMVtBSH86q/Q=
X-Received: by 2002:a05:690e:4194:b0:64c:ed24:13cf with SMTP id
 956f58d0204a3-64ced241874mr1495451d50.78.1772538646107; Tue, 03 Mar 2026
 03:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20260302143403.1778326-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260302143403.1778326-1-clement.mathieu--drif@bull.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:50:34 +0000
X-Gm-Features: AaiRm51E16ePe4li1J3g9CtF88ApNhPgtwn5btfKkOa-r27-JoBO3etfqph6uJI
Message-ID: <CAFEAcA-D7bBaSF62v4rR3WUQBtwiK+fivoTiRg4u722DNTx3xQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Clement Mathieu--Drif's email address
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>, 
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 2 Mar 2026 at 15:18, CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@bull.com> wrote:
>
> Switch to bull.com email address following a company split.
> The previous eviden.com address will remain active for a few months.
>
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8317fab31..af2de2b274 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4013,7 +4013,7 @@ VT-d Emulation
>  M: Michael S. Tsirkin <mst@redhat.com>
>  R: Jason Wang <jasowang@redhat.com>
>  R: Yi Liu <yi.l.liu@intel.com>
> -R: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
> +R: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@bull.com>
>  S: Supported
>  F: hw/i386/intel_iommu.c
>  F: hw/i386/intel_iommu_internal.h

Thanks for sending in this patch -- I'll take it via target-arm.next.

-- PMM

