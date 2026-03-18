Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702FE103E173
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qxP-0001yJ-3o; Wed, 18 Mar 2026 09:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qvb-0000qB-6K
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:27:16 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qvV-0006G8-Dv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:27:11 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79800183233so12531497b3.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840428; cv=none;
 d=google.com; s=arc-20240605;
 b=RdhnDcR2/R2xo6CzQJSLdBXWLnF0KY65Y3kaNCc3HW8A2ohn7sIX0uWX6V+Aoi0ZKJ
 K95+6x2PHM8fWcXs+pdnF10ODe9MlYRT5juuA5aDTow347/GrqD4+083zePJlkDc+5UU
 3ZF13blOVyGDEtG7uby+CibgUdllZMcKcK/19vMNOLhr5gVlxGNE+XHiogopPhXERpc9
 OoUyRc2Qx5r6m0eOk5I6Lcwaa5iO9od/MANPrtROQPdAGPQe5yel+3yJkItl3oY4jFEC
 xYSngp7FAWU5v69EdhMnFXubMsxHCB8BLt4Nx+FWTzwG+Jrmv6UqvggFcpAUU4Xw9orv
 dXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HU2oSODkTilRKPEFDsflR/wtS1pqHAXHKF5lDwX0Gic=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=ahz1TnZOttGqI2epHN+f2J6WZzOylUzshajdVtZNn7zeTPB1A6kM+V9oPINccbk+3y
 OHwvpMz8xxIM0b/W88TmViIG0DhHToctdpDuWWZJ7tvpBtq3RNJSsVp3NOKZ0uGLrpYb
 Iu3ARkMQYpILdoN4rCo7njBjSa4Fo7on7ew6OYdFHSqie25hpWnqHH8TpTK8jujAAbta
 cWi8Yvw2Q9H49O9uCITdu6yjsnIbJsdWK+9G1VvPSt6mOe75Rv/PYtKhFhOGS2D7dq8k
 pECNHUzF0cae+3PdGQsRavHEh+EdR/mbEFaIhg0IOgHcEXnLWSxmxVItv+jDJ0xr8P93
 IJIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773840428; x=1774445228; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HU2oSODkTilRKPEFDsflR/wtS1pqHAXHKF5lDwX0Gic=;
 b=csR3umTiE45awGtxU4QYcSyvOXe2omeHGTBZdd9ojhTnpLItsgsUWPD+lSNSleD0hY
 M1sG8/bocgFp/fs+zqay5+n9ptIXLQ9LQ2QHt0N/nj5lQiRcvVg6IkjiMLfNFBMGWOL/
 xX2NmK3sremiOqNzEgYB8x7RMBScD79drPF7lFs+RDZlF7RbZTxxdT4aRpw7uBWeZWFh
 ILqo9zDxuLnYrVfyZ9pOBoXyOgiRZBjPiCsmKLotIOdgD4/4WxvA3QF2c990HH2i/66a
 6QBfc2kPlPi+9U8+zNjtHHK/61lDWfBKGP4N3TsE7RBKg13h+Rn0qoC7HuanPvmomvLc
 SDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840428; x=1774445228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU2oSODkTilRKPEFDsflR/wtS1pqHAXHKF5lDwX0Gic=;
 b=gPH3rD2N1HgDrKe2Dm2GukxkhYzS7yQwQIbcC7V/FqN0RnmXFQ3Wa3kJLKyO2U63AZ
 9qYmKT5TC9Cn1j7FCjqK2lrDicYgdeeaJrF7Ch1OOJZwSfqkRM0Bnf3aeKDbJ9dXWemJ
 NiaR+qP/Q//uedujT2LNwKJszDh7f9X4OdHLjcdzottUg6GUbyw+ZEANkikGAB+ZGHqw
 czz/azVQfpZGsf9dQpHeF1AoHBi90YRrspfWa0ZgvIXvUHuJfMQwRvQkaNfX2bWZuwAh
 D9uVgERzNxh3mFd7Fmqk8ygkqF/HgQ6raUq7iJtJTyAZj+spgtPWyhQ90iA6B2xDcsBH
 CwNw==
X-Gm-Message-State: AOJu0YyLMm+R7J4P+178jGCvt4Guee+G35iiBIZfWfsCEel+mtaf9wGR
 XHWz4E0ShTz3/MrrJ/CEbzYS3fNU1jprAm9Tw1RiV5SbVeeT4Qc/8SnovN5BmmAfMeyEzgTRUYf
 Ux2qH+Dmno0H6bVNpkvGhGRrn04XMqVQMJ3EjFsCbPg==
X-Gm-Gg: ATEYQzwH2didhICB/KLXAOyMs4U9oOK9FwTinkq61ChmfPtPCzdCQy0PRJrEn/iKTVH
 A08/Ws8/aKLvUSY1PcHIHg/8tElspdDZZ7CF0RXm0q0q8k4KxU6JFgVoaLzGu3x0NFZ7ISuDDQF
 nm9aCCF7tFVWelj1sSZe4qNS4EmIrqFQKbhQ5TdugGetR+8fjBrfDQqMDwb8mFbEEHgRJzduT4B
 cnQeY8HtrzOQtGGLbarjasN8AvwlUMpuiA3ybsfUA4HkYaASa6cr0Hn27KC+69CKOOg+l1pHlBx
 HEuFAdYg0T8j0kxm/jg8GOz70j/iD8cqKqhv6zJkp15hUMVip1zQpv3ElTYuaQlgvSo=
X-Received: by 2002:a05:690c:4b89:b0:799:164:a053 with SMTP id
 00721157ae682-79a619357fbmr68418177b3.33.1773840427637; Wed, 18 Mar 2026
 06:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260317191356.844712-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260317191356.844712-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 13:26:54 +0000
X-Gm-Features: AaiRm509Vi4-fEk7dcyMPmHvur5bVPXxaWEjyVwZCf7_r3Q36WODDVb7VXvKhDo
Message-ID: <CAFEAcA-z9WKmDr63VxZjvRQYL1QQFgb73Q9ujn=yiO0ptWTd5Q@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins update for 2026-03-17
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 17 Mar 2026 at 19:14, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:
>
>   Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260317
>
> for you to fetch changes up to db52193355cf75394a39ca9f70b1325d4bbe18d6:
>
>   plugins/api-system: Handle migrate_add_blocker() failure (2026-03-17 12:13:16 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 v2] plugins/api-system: Handle migrate_add_blocker() failure (Trieu Huynh <vikingtc4@gmail.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260317134733.126584-1-vikingtc4@gmail.com
>
> ----------------------------------------------------------------
> Trieu Huynh (1):
>       plugins/api-system: Handle migrate_add_blocker() failure



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

