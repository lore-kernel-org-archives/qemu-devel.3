Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905B0C83F22
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGJ1-00086T-UG; Mon, 14 Jul 2025 06:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGDe-0005hv-38
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:15:34 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGDa-0002Ax-QO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:15:33 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e87c86845d9so2866186276.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752488129; x=1753092929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2JbDO2Ykn57qFTinhgtRZ1xHeP1DPG1IsHNxdLLzZw=;
 b=Ev+klRjmUiJHp7DMWasyb4RqLH+jEbiXb0kJOas6gIaU3TSMaYWdK/ydO+Xm+LYOoX
 /31eBqYfBU+EJrplUFAwQTZFLtgA6uDeMmX+U1jVRG6SD4RuuHgIBaCea0JsHoqrNVP8
 sn5xlqmt5ZI7D/7fhMLm8AMTLS/cspyIbLv5Ki4gUQrxeeEDQXvn0FzOohvk/yy64ToS
 lEuYbUdVjNKTxQuuuWQWwHuAM+mD268XPWgsUBOWGoqW7PJFobmbRg82rcIBAX1Dv5Ks
 3mfKEs2QIHiYvliH6JSIj3OWVzUwDSUt7uEBgo8r8q793MT9PDl5cwILTw5nGC6DQCc+
 1gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488129; x=1753092929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2JbDO2Ykn57qFTinhgtRZ1xHeP1DPG1IsHNxdLLzZw=;
 b=J1WecZ0ruoa7av2ne2iY2gWE/3TxbRBep+RvAhQWgnsZpBi3d3/zB8SASYDcvNJOhF
 /GRuTA7HPy/7HbxEDQin9JJivut61EMNkpGnroHj+hmsy5qRA1Igo6hFUYfqPvuyif0l
 JiW8Mxinf4AVARShs4kfwkdwDx4zHhe32bKOwdVhNOFbruD1I1NyGo/+ANtsMoi7L1Hn
 P0IytnAKMHGBR2reBq5lS3ERLbA+R9W0BMVTkhWnBKSa8C4kx1XTuVCNC0dPib6eTJhT
 6WDIyrAhZY5naGg3AMdBHY7fMn7tZBp6uD0oXawmEmwRHzh7k97PO83c49Xq/MrLoH1g
 gq5g==
X-Gm-Message-State: AOJu0YyLoMdmv74EPSNjxc8F0A1dzZELiEG8EDVXV1rWAdi4qDLHxtpt
 Xwst0tEVoqlMXTZQM1OFKZ+sbNK7FVXWUpp2wgFDTAq7SQg+1yK0gjl9Ip0q1ghSg90N8t8F/Rq
 TW40A5iJOzjmemRfdVa9am/pHkXMbjxtZx+DClZBhVOnjhYvVnmYU
X-Gm-Gg: ASbGncsx1XAqKW/PxE2Q6jjhXhmvq2+bqgFLrGaB1QIuYCmSk4P1pkHLyde/vbDBGCR
 RZ7OuyF1ZEjxjfmzdw6QfyKd37WdZq2VK82H/KPOzeeF/8H+NLyR+XKUJ4qHCnGA0+q8enNm8WW
 D+WIulztuRFwzDcfQhTnrU/rpLy0fwJXWOgN0NcnEJ9NsF/pLe0t/1EHBhPJGRpdp1QahQBHxuP
 qW4PoOB
X-Google-Smtp-Source: AGHT+IHlyjoQ0Hnk6X/btx9qO7gR7gyPo1R+jl+qG/fGa2Agr16apG4timMBNrffqvjRm61o7xFPkd2O9WyNlwczJnQ=
X-Received: by 2002:a05:690c:4b01:b0:703:afd6:42e3 with SMTP id
 00721157ae682-717db2e0cf9mr152892417b3.37.1752488128788; Mon, 14 Jul 2025
 03:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <AEsAbwBKJLTgnqrz7OpDUKry.1.1752336287467.Hmail.fanyihao@rt-thread.org>
In-Reply-To: <AEsAbwBKJLTgnqrz7OpDUKry.1.1752336287467.Hmail.fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 11:15:17 +0100
X-Gm-Features: Ac12FXy2bk1FwXV6gSrxeL80Ozebf9B5IVXwiVF0nLIJo8dAbGoR8OmIBM8AcDc
Message-ID: <CAFEAcA-8_UvqD2kP=9MaGmkde187J_nZzP4p=Sp80nB4-KRPNA@mail.gmail.com>
Subject: Re: Add the stm32f407 SoC
To: =?UTF-8?B?6IyD6Im66LGq?= <fanyihao@rt-thread.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 12 Jul 2025 at 17:04, =E8=8C=83=E8=89=BA=E8=B1=AA <fanyihao@rt-thre=
ad.org> wrote:
>
> This will be used by the RT-Spark to create a machine.
> Subject: [PATCH v1] Add the stm32f407 SoC
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
> ---
>  MAINTAINERS                    |   7 ++
>  hw/arm/Kconfig                 |   6 ++
>  hw/arm/meson.build             |   1 +
>  hw/arm/stm32f407_soc.c         | 130 +++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f407_soc.h |  32 +++++++++++
>  5 files changed, 217 insertions(+)
>  create mode 100644 hw/arm/stm32f407_soc.c
>  create mode 100644 include/hw/arm/stm32f407_soc.h

Hi; thanks for this patch. As this is a patch for a new
SoC, you should submit it as part of the patch series
which adds also the board model that uses it.

You also seem to have sent this patch as an HTML format
email; please use plain text for sending mails to the
mailing list, and especially for patch mails. You may
find that using tooling like git send-email gives better
results than using a normal mail client for sending patches.

https://www.qemu.org/docs/master/devel/submitting-a-patch.html
has some information and resources on this kind of
admin detail.

thanks
-- PMM

