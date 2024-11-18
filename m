Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5341AD4922A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 14:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2ot-0004gd-Qd; Mon, 18 Nov 2024 09:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD2oh-0004gD-7A
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:33:28 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD2oe-000564-Ig
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:33:26 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cfbaf3d88dso1075621a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940402; x=1732545202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqoysXGXqWPZP3TqtzIfCBLOET9Mwkb7OGrsM9AglmU=;
 b=EKXHv6Vtr4TgYnk1zTiJ/CRVZ427fRjkXZHGcuK5SGQ07Im6bke4SVuslKGrc4ewLH
 rfXytVJ0pLkDzAbif6+vTghI3cZVttrb9PU3q71jhGkrIbDi5BM/uULCJIVke0AZHFJm
 AeuoB9z2htbjD2IxQAQ0ziWVEEZUYhj1sYmiYDYXeXErGqt0lvFpZnJgQlgis3koR3mG
 XBFv1a3G1UWlUjouwHzOszPdPNgvqbEpUn6a28RwxE2+23n8xZpnpWPwzu0ltBPreBqX
 vtsHP40TU18AWKH3tOAVYRXcrROIlQFFLM4S+vgpAoQhQLIhVIHfBIOJeo2IT/zJsw3o
 aBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940402; x=1732545202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqoysXGXqWPZP3TqtzIfCBLOET9Mwkb7OGrsM9AglmU=;
 b=VTPnvoldSv7TGlyRtSiN8lpdMMFGj6KEGPlUuOVjCR8lyyzqWXG2MMnO9tiNvP+rOj
 7+GT+UqDMfL9FEFz2+lz2DCwdxLRJ0325/mL1xUpudcdz4mbMEXFFaTwmyMfPth6GhRd
 aISe7zONvEdKJA8xf71MFCAUrr6bM8laiEA2kTbvouFMEAdRQCYFSVwEJDprm7aj7VgJ
 ZbS6pIZcvf2ZleRysse7dbbfhaoS1GTvaF5CEMoF3tOicXPb+CsWViC9MjDoNoYwh+yX
 TP3ba0+RyJdgpSlNbQMihUT04rqezvbjH4onG16IWjiUiZsruuSHvceKV88yrnuWYusM
 luHQ==
X-Gm-Message-State: AOJu0YyiMFqPOzJHdCGI2fbrRruyqMe+ZuXhqlYOgkakjJyWCA31usrf
 9Za37qGtBhgQfi5ajZhOgqlHKUgAmuODLl/GjrUpMl/JE4FNtsbCBpNrY6WqIeMRqSyQYsd9Nnl
 QgQzLZJ64Gyvw0YuCZqsoW3KE5kzwp2uxo6Y16Q==
X-Google-Smtp-Source: AGHT+IFHVh8zdc4QfDgl+dgxh4biz9AdUTxjA+9Jsl5htUIKcCdFz3fj9RIv9qcJosZwTMGnunOGOEbbOZhy18gk9i0=
X-Received: by 2002:a05:6402:1d50:b0:5cf:11cc:91d3 with SMTP id
 4fb4d7f45d1cf-5cf8fca1c0cmr13538138a12.9.1731940401958; Mon, 18 Nov 2024
 06:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20241118083737.174219-1-clg@redhat.com>
In-Reply-To: <20241118083737.174219-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 14:33:11 +0000
Message-ID: <CAFEAcA-KjMBp+au+P-GXUGQshPsrKkM3njTr1vxYqn81rktE2A@mail.gmail.com>
Subject: Re: [PULL 0/3] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 18 Nov 2024 at 08:38, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8cc=
db:
>
>   Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into s=
taging (2024-11-16 18:16:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20241118
>
> for you to fetch changes up to ebbf7c60bbd1ceedf9faf962e428ceda2388c248:
>
>   vfio/container: Fix container object destruction (2024-11-18 08:40:06 +=
0100)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Fixed IGD support
> * Fixed QEMU crash when passing through devices in SEV-SNP guests
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

