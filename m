Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877EAD49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCz4I-0003Y6-Jc; Mon, 18 Nov 2024 05:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCz4G-0003Xk-LO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:33:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCz4F-00022C-0w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:33:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso5126637a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731925992; x=1732530792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BAFVDjIyyDwFtkryaR/5RPMKJgYawY29Mh5S5LNz8I=;
 b=IHP8fpK0mX3Jq1YS3/kiTDkbGReVQKBZuP6uzD+fE10Itg+iB3UqRTsSFcD6U6oXRk
 RyRCkD1i4iMaK9Zx4/0fKhVPRomZrRRffmHvRVwhozHVtm7SYsh5WxATzQ3xPct8B1hV
 82ZxAxeubIfx3yg3N2SczBTXseW4+NOtYffM4Rcl9nSOplsw5SYFzCYg18HcBe1cuNt/
 fy3pw0KyfFBTJfAxFwbfRzGzbtlTH2cy68FN121Ig2o20bTtX2pEsaahBQgdwYVVkDuL
 sNxtPyIp5KySZYQNAkg30cLJvMJBwiyjzJENJHLhBL0tcu/LnrWqjxJkIDxM2fef0Vjf
 NyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731925992; x=1732530792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BAFVDjIyyDwFtkryaR/5RPMKJgYawY29Mh5S5LNz8I=;
 b=E+VtV+5jNi3ZwymKLCI+RL1pswptnZmKCAv6oFDx7XJfJ4hBpd+wf8ryzGEKVTspu+
 gCeza0G3d5hXAiJAdSlWntk2f0WKilpWQbOE7HB8O38OMTnT4dALndczBwKHQ3Vj6HLf
 IabJ8OM13bWZuraBmbHTQlrF6+cEDac+DmGS48we5gn7W6ZgnfFfLv4f3NbMJYeuqXkY
 J12uM7fS/0AO1eGkADXJGLm4yHsxQ6fJh09nr7xuESUzdtFpASE0KCiVmfMs5pgLW2qg
 QABpOGTiDzhyTUUyJzvW+ZufwMJlGjPKRprH/Otq0Sqbvm9yXxwMlbkGVBDB5v/D5QGg
 1HDA==
X-Gm-Message-State: AOJu0YxRNwmZ/wC6i/obOb0d2tIIZmHPnN3W4X/qC1Xd6FLvLAEyF+cA
 kQY6NHs+xZj6w7nY3qEipXk0cp5lRa9eCd2xmaobKu5ad83peQYfwBNBJiEBgZpX7qUXSv0ZdBE
 3EYsDbf47BjjQEXx+hSuMxGJiJGZ14AXXV/rkHf9L+ekyuUcS
X-Google-Smtp-Source: AGHT+IFW7s1jxEILSv/9lpWwCD0rfsMLVyJd3D3yyrkohaHj7IJH5ZKDxDhEVWAzpnbL6fjQvfX5D1iLxJd1dFphvg4=
X-Received: by 2002:a05:6402:2792:b0:5cf:ca7d:1745 with SMTP id
 4fb4d7f45d1cf-5cfca7d191fmr2033379a12.1.1731925992141; Mon, 18 Nov 2024
 02:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20241116053918.420404-1-richard.henderson@linaro.org>
In-Reply-To: <20241116053918.420404-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 10:33:01 +0000
Message-ID: <CAFEAcA9cRt-LpRWM2zEyKHqfwFaWO+TH2SBjgoLOfSfukP6Fkw@mail.gmail.com>
Subject: Re: [PATCH RISU] risugen/aarch64: SMULH and UMULH require ra == 31
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 16 Nov 2024 at 05:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not generate ra other than 31, as it is UNPREDICTABLE
> whether the instruction will trap as invalid.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to risu upstream, thanks.

-- PMM

