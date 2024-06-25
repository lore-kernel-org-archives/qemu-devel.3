Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3DBC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5VL-0006dx-4m; Tue, 25 Jun 2024 08:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5VB-0006Ip-OX
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5VA-0002ho-Ay
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so5726304a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319343; x=1719924143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PioTf4AvfeN3IDOrz8rSqaCnt0oQlJLiKekkHsZ9aU0=;
 b=UMJRRzotUld8xjFCyxcybImMi1WIjyk205x6TbEcaEz4GpuSOm9cVe7DYGkDVdTFqu
 XlGl2wkeUbC9xyh7PMWgoDfRxLqA/RW/ulI205bFop9cHulonf0qBT2/ixPAaoX60Rl8
 nFNahUnyLG1EwJ76pJ4JS956Dbq3pgGAkdU88TVC7UDBMsGIOcyzpKJ5Yp3+p7oYwtz6
 pP4bNsDoY5aIDbs7cQW49cSDKtrSL1HiY6ENXkrEbXNEpHH4yBPW+L6z9q93Vfp2kJtc
 QVcC3/QbssIEJa1k9Fpg7ymmK0bCa8VE5uAhjMv/7Y3uG9eNKjPwvL7cnG+A9qdPyydG
 pbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319343; x=1719924143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PioTf4AvfeN3IDOrz8rSqaCnt0oQlJLiKekkHsZ9aU0=;
 b=w8x/Hpg4A0P/VXuC1wQsetC9YAaIv90XdKqwgnT09f4k4H0h4pJ31F1W3L6r577zc7
 q1234KoeZpBKTQLy1974L/uyd5ArSxwOUJ+mLUqYfD4hKEC5Ku4W5M82txFMjaVxI9HT
 tEaboIeV0To00Z/PdKaquX5HuhJ8Vfhp320b8Otl4Yoh9WmOZ3d/pblVfGUNhpPsjVHG
 xUzQZh+P6qFvqilENQsz3W61O+f/HQC0txzhtIXNeISLKSZX+bJIs0QdSqe/T1rqCd/K
 fj1AGnIEgk9dXgqhdbVlU+zNHyPKyisvXp7DY/Tzw9A4pZcDVqix5ID/cBVK75XeYKf0
 IDJw==
X-Gm-Message-State: AOJu0YxkYoiLNV6rQo8h5dEm9LW2wLDOnHaP3Utu7LOcz3gtmh+VTEV6
 hsdpthVLQsYkUX4024irUQ6dbOyM7fDtO/efBu0DMRoAm9/81iQVmNj79KPXLfyztPNL1zvxoBK
 b7nkxgbt8DP1fHbq09Tr7gZE9jL9/HtaNdsFcEtB9pPlLy1Od
X-Google-Smtp-Source: AGHT+IGPIMr4vXN6fe0BVyDnmUtAw9nr7avU5mqOSUYgrB6Kxv8J4NjXphmPMcOvdG9+QGR+mqtU4XkEmRk4WEG6cxo=
X-Received: by 2002:a50:f61d:0:b0:57d:5c0:9dc0 with SMTP id
 4fb4d7f45d1cf-57d7007f509mr2064941a12.38.1719319342768; Tue, 25 Jun 2024
 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-8-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:42:12 +0100
Message-ID: <CAFEAcA82Oh7tDtho3Q2rNmRCp93gMo-eEbV34X00YGOuRX7uFA@mail.gmail.com>
Subject: Re: [PATCH 07/13] target/arm: Convert BFDOT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  2 ++
>  target/arm/tcg/translate-a64.c | 20 +++++---------------
>  2 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

