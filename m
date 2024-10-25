Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4576BD0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4LEM-0004Rb-Ts; Fri, 25 Oct 2024 10:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4LEI-0004QY-GG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:23:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4LEG-0000xA-Le
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:23:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so2624147a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729866230; x=1730471030; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAeWCEof8nkpWkAB9886cDE4Dsl4LieSFD/MXl7iNq0=;
 b=zdUnVWxgJFVr/mkZTD5Khn6JjoH/t62I8q30DXNZPJbU+QDjO0EwO3rTsETRX1YFmA
 Cv/zX+CJFconfFLJYUZU5YYpuX05gFVdgAMFGjNIQ/SU3Vj6bUYrM36ajMrusqeMZVUt
 frEFmXxzAUKgr6IBHyua49Kq62qgRys9nMkPv92gk6TYXOMqqSR82UpvANXMorC1A/5T
 Mh7hRRzVUiuW+/uZ4hwKYLFLn8zR7s8Hu5yjnfFcRTew2M5YakO8NiEmNElJ1OrNd5v5
 R5qiBubF4JnbrO+uaqSpAj0xZT5aBLB57oIhxHE0JsgEKxdHoLvWUM6dqBwgs+yre5ux
 6aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729866230; x=1730471030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAeWCEof8nkpWkAB9886cDE4Dsl4LieSFD/MXl7iNq0=;
 b=FWncddUGRMMul1iYdVayZ9aNTkDjwLPLjcZuq5N8HYNjzypemLVpSqGgeD3Su6KOMg
 NlbmpFe99VeKOkxkD9goiPbsqWoX94ivFWCM0epP3NPPbQqpwqubgRrGuq4Q5dfl3SXJ
 0FrZnmta77VqZLX/g+XRPPIYund+VdMb59TvDbRMZPnoG8yTErE4CBkVulOlBHH5kwkU
 VudsFVfyJf+TK6ZUtFdC8plkHJ0DCOXfjX9ZKUJxSP8aKI8THLAkOsY7xjXSN54kdjeD
 JMbzEpXK876XAvcL10MShhRzW7eh1IEHAM5AKUfoLy3dpC2SaXXhaL7eniFx28Vpyvmb
 ENjQ==
X-Gm-Message-State: AOJu0Yy43iVwzdK4zGqLS9jiJW4SXfMK5W2n977JJKwvbBKSCHUy/5Yj
 GADn1BlKsxVmEU9DFcxY2GGcTbn6zGwTWlVkbia5jjZaOFlR8ofKmEww+VEPtUcfJ2AG5A0WKTb
 UE/dZExMH9XUbsOq/KxiND2jIAGIAFqIILNEcCg==
X-Google-Smtp-Source: AGHT+IHdsXWLFbWT0j9qxrP+PSqx9e/Qw7xMLkm4x3kIJCuK8iwVUuYi/6NqIZK4qvUcCXybt3k62wKsejMgojuxat8=
X-Received: by 2002:a05:6402:13cc:b0:5c5:b9bb:c65a with SMTP id
 4fb4d7f45d1cf-5cb8ac2d6fbmr7695847a12.1.1729866230076; Fri, 25 Oct 2024
 07:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241024053203.1559456-1-clg@redhat.com>
In-Reply-To: <20241024053203.1559456-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 15:23:39 +0100
Message-ID: <CAFEAcA87T0_Buwq0Ek9zH5kfr7rZaXwm3FSmmEuyzJKmShTOOQ@mail.gmail.com>
Subject: Re: [PULL 0/4] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 24 Oct 2024 at 06:33, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972=
d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu in=
to staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20241024
>
> for you to fetch changes up to 00b519c0bca0e933ed22e2e6f8bca6b23f41f950:
>
>   vfio/helpers: Align mmaps (2024-10-23 14:46:24 +0200)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Fixed size reported in vfio_state_pending_exact()
> * Added support for PMD or PUD aligned mappings
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

