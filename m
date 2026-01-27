Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E27D2D8FA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgmc-0006yd-GB; Tue, 27 Jan 2026 05:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgmL-0006sK-Nt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:58:39 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgmK-0005IQ-2o
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:58:37 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79274e0e56bso54247577b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 02:58:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511515; cv=none;
 d=google.com; s=arc-20240605;
 b=Ayy0lQG7kTzGRKXhCkIxcmEDTfJe6m6FVCjXVgeiLLEosMyhPaKv6M8Zwkrj2MZvze
 Fm5l2BELj0M+rbodWg8O09I8iL566UQ1awbb909G3LFA0mrpYlQIewmywe+cCngrOHW3
 F5q/l3abFnNpDmrV74TLHGjq+jgGyuqXYHNBBOx2L7RA9dbeqo5709eVFtJrwSPfriiA
 Y4UQ5EAN5L7IVNykCWfO15FMpyZf2PVYZfAfRX2JX86uki9TFv5dL6eWldeoXE2zQUtH
 B6/FJ/JpUiaQZxylKCzRky3QeU5WmUa/wQxkVabdU/NbMM5EmXO+LLK/WUddlz6g1HWH
 UTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w7oYcbs0IosFoZ5vJnqh58adK6OR900dLunCz09q/KU=;
 fh=dXHoilmhhxY5vg21Ss6PZGFufhldebBfEzqm3qMG63M=;
 b=CzKP13zDQaxLy8QrqmUXt7C/lAQGy4H9hOE7pgCbhGczd18pMd/WICLRvdqa2/I3U0
 aCyMld5JhhTVt0LpOXfzlZG5mfmAzXy5h8Ds0H/LR9hBjAx44J6NhNhx1pVGc/BPVIWY
 paUUtS9H4kqUVcFm9xWTczT+eCvYI1oCQWBEhsqeYYRzgPK0moVpSfyeEZa2icVz6jlH
 qZSA+qkpfBXEAPDIQUybOXfUqtTvunRB14ZIwPCNeXiG0QuNDluvvy+39ERvDfmvg4+2
 nZQBoO1WJDyEjgZVh95Ns51caUvREFXLsuXReWApPNu1YHdjtdu8ngzjZInP4rp7bKov
 0Bmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769511515; x=1770116315; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w7oYcbs0IosFoZ5vJnqh58adK6OR900dLunCz09q/KU=;
 b=laxt4uaJEwZlKy25atM3k3MWJZlhZRP7Ow6dD0ZMK0QCxgRaaMGAxb7f6nmvNAuHgK
 0SdDwJt0TaoNATT0X5zR7gKE8aesCno87lSrpC7mIyzB/etmmoAXToaPQWwQLzNUVEP3
 IwE18tgIftTaiI/6DwEKS6vHkWjf9UBFWhNII4YZGnNq8B7TE5qKKcECgbLBH04+HB9V
 tWxpBCYtCm1UbHCwoLXyJh6hXLZal3VxE1WjofeaSvy3j7MlHVORoi4SWY0ZfDP4OqRv
 xrD6HAu6rez4dbCqsdcIDXa+j1xuhDgnWGfic9lDYecnnKaOgW+KUZuskOaaAD7edjD0
 HnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511515; x=1770116315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7oYcbs0IosFoZ5vJnqh58adK6OR900dLunCz09q/KU=;
 b=vu+cM9VXAEkig5SMDRHnkftbJ3eAl+jct/Uj221G8piaZ5l/Orc3IHg8GY9AqNrYNc
 W7T12b2a1WYhJ8kLa3ZvnNJm4BoJsUoS3FEtkB1GqhmSa8aAn8mr7nTVkakOBNT2jhEy
 s5iG5x9ALlyjm3ENxz1BSG5hJy1PQ/HsUDJLJ/VGkthI/vAzgFwPXZkuQ0uixzjiR+ZR
 nciwKCjDXfomw/Zd2kmSil5rJ1CSyjJsvxL8N/vsUe1mSNkRXt0LzucZTPVH9ruxnUDB
 GYfFmGkCE+W/sgkws1+diFNXslEN3sTvKeTuKCf/2vcxUWKHZIC8XX6ail0qCxIBT1bZ
 V53A==
X-Gm-Message-State: AOJu0YynM+9GilLNDZjoVVqrvInG3tfuhzsTjwvOAId/iIdMRYV+y5uR
 x6CDL6Oh91K88+cQNtgoCRbHXQVjFbmNLewnWJkWLhvqNu3MiPozqj5pD1VH2XiGmBUdPbgJp0N
 HPLEwYiH2Js+mgC9vdsA39gg4rdSCPYQMMTpzgHxCDg==
X-Gm-Gg: AZuq6aLmVXkiMEfJi3ArUl6gt0P8TRKaoz0ajZeFBdAJlbXOtcpH+pG/8fnDHFYb7n4
 0X+p9AQAKfZbWAM9mIx1HMhoKovj2B4xrHyKNMqNOZzIHw1kx1x6OhNWEN/wm7y1Yr3kJEkarHF
 JbZ32rwwImHVkrEMc7DSNzabbDYJ+VtSW1fgfR8OPEFg7t/iimdzTm72YLJx+yCz7klY7eIGcgc
 rhqD58Pf5pgoZoZjMvS4AyHNPvlJJD4i49vZcqek415x3CD57m8+/tsmoPuCpzUrc7nig==
X-Received: by 2002:a05:690c:95:b0:794:7e7e:95ac with SMTP id
 00721157ae682-7947e7e9a95mr1549457b3.67.1769511514832; Tue, 27 Jan 2026
 02:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-12-mohamed@unpredictable.fr>
In-Reply-To: <20260121134114.9781-12-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 10:58:23 +0000
X-Gm-Features: AZwV_QiXSUqIQikPEVPkAo4a2t43paFFAvtXjE1qY_a-T4kF28Lz4j5kXWMoYEs
Message-ID: <CAFEAcA__gAtae+y8t2j+nsLgGs1cv+jt9auvLwYn+QvjzZDtWA@mail.gmail.com>
Subject: Re: [PATCH v17 11/21] whpx: interrupt controller support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

