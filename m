Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B548C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqoS-0002qd-HJ; Mon, 20 Jul 2026 12:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlqoK-0002go-GC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:25:44 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlqoJ-0001av-16
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:25:44 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80cebd41372so94855517b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784564742; cv=none;
 d=google.com; s=arc-20260327;
 b=meVENbN7gCaKsP/d9A3scO491db1k1DXR2qeAKTyrSBE1sEwoAfY9glIKjXh9BYqdl
 OuSNox/oAUkmkCg+YLpXbAsYMOTDnVaIkSRMgOOxfnagRx50FHrQmWW3UN0cK0wSnIYe
 T2Ke3oUCiaYasUHg+XYMVVoqWGk15IQXEu8BMc1bsDYkcSv5C70C2UQ75BeZ2QmeoQ7t
 HyzYOCOEZlwItbKngqgi2P9vRVkK4ffnxdFgMKwZx2i8IyOnzjPxqxsZq/A4/TpLieRN
 XsI7EbYTaYN+MZFgGbk+a0PcIO6g5WH0RK4d1wlXU4IBTqbEp/K1zgvK8AX5Rnh/M8M/
 tTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4stJnlufFrYX2bqL3aW+PyOpKqwq+AN0KLFnOp2Kpbw=;
 fh=bla0GT4Wgl/YV3cpfi/sDaupRRgolRjCjbnbUIbf7zw=;
 b=kkEMacx+MvYwkw9YLPA+/gcGXm8Ok1DG5Axp4+Zx4+fGmlp2sudE++V/2OnTK+WmE8
 fa3KRsryzA5K3KiE6iYevqZC3dU+2PToBO4oDSQrDUhXWqfpTgjFjPUHcz9nmk8Dk107
 bKjHXSPR4yexaqrlchq0pWZuqEhDeWgbmZcVZjjcNSVXLr8AoRYSjANrNdQGQB+nyJY2
 amFnyx930u4vTWfvYL/YksyMbg/ogreWDyQ2tHOzRDyjd43Q+buOssUfoMGtQaydYhGh
 RQj1aUqi3SMN8LosOe+Y0lRtLv0bBtPLGL/4ff1bzU06FqiAj2ZqHhsCt2xd7LZ7nOlx
 0xkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784564742; x=1785169542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4stJnlufFrYX2bqL3aW+PyOpKqwq+AN0KLFnOp2Kpbw=;
 b=Bx4VKQwsttmi/1LkIJ5XTOaOQyrpjLJj4K0jz04L47m9ukG9KY+XkDy8chYx9FtXL0
 tgL6e+eJszbssG/iZ3bs37tI3YtUbNYmaiWZ3j7JpP4q4EEF4rKp8+NwpcuKtN/NC0/m
 DU1UgSPyF/yjefkOxA6/00eCVLq7NYVsAYs5w0symMHLjzWISVLPs8kAjhng3iA/MpU6
 yymhc+a5OClx/ZkCqsPIDV+tuwTx301nLkptlk9BsgCwrXeySixxNRkfvIY0Jg+HUkAF
 cinZC3qq3T9SivMBSEB9edQLRvddGRmU1cfp8frEmAc/QBEWZkFDA5mLdR1RyQEddOXq
 DuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784564742; x=1785169542;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4stJnlufFrYX2bqL3aW+PyOpKqwq+AN0KLFnOp2Kpbw=;
 b=Ni+sijmz84wSlL/lLIxApFe7POBJz9FMg4PuGEtCyQ3fncIgqFPLP3jD+8sClXaobR
 MqkZgrdVIvs9RZetN9xWmNT2OgoD9AyQlJMqQMwBah7S/oINs6LGmUYAQmWhq5LAe71a
 J3QA/toZjGlYa/+jXu3cKFWgMpW0Y3ck7eyCHj0x70kBLoGy+Yb9iOs0YM8c859LjUi9
 b8sIOOTdWhgSKJo8GSkTWlydXcADvHeWiIJBslV6QYDz2jKXhVIcznCl03tmE9iMP2MA
 F6xWgG8jIc8KvZYF7FEiK9reYFdNYCEJMfrV+F9UeOshGRMU8kuMGb5AfbKEoSSrT4K1
 4MAg==
X-Gm-Message-State: AOJu0YyV+/uVCy9xovqS/0HnebbDkD9XzwzXrGaHfSTGyBIXhM5B+tzR
 J5dWMYZwWgj7bGti14xwSg5Ck/hnR4PbLbqFVTkWScWbNaE4PAGNil4j1s3beOhNFnARMwv/ILT
 +LlKVKNAjuiFZzvjBCTeTkUKFHExHIZSCgN7k40kXAQ==
X-Gm-Gg: AR+sD11vJQrhxO8KDuqMHrQlHgmaBZ24GSdyPkt626wpfduYRk3otzVDs41KiBU+tu7
 AAMeKKx6m3Fr1clWrvrpoRi57qypoOOBayA+hLGIRZsV5AhA6JO56LA+cGAXbau4D8TmNA4r30H
 ngqcVLRLAJZ+hV11y0PR8rhU/+TidqIqJ4/1Y+KisLV90J6YpCi/ZHunob4mqBAXxjpY17fz9YC
 GqBlLWtwB9Z2yjnIEoYyylwE4YkQph2Q2RI1UlM3SCLqkahw1i7mswIIhcVjjGMlI1mKnJJIAHo
 2FJuxsa/hXHgRK5Qe3kdOr+Kf/tumZqTyWWJ1sIU1dZ9Dw==
X-Received: by 2002:a05:690c:64c6:b0:81f:2401:8017 with SMTP id
 00721157ae682-81f24018066mr1204527b3.51.1784564741883; Mon, 20 Jul 2026
 09:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260720162321.3497633-1-clg@redhat.com>
In-Reply-To: <20260720162321.3497633-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 17:25:30 +0100
X-Gm-Features: AUfX_mwVEx_D4OhUv4vto-foAMLrcSBGAb1GrKbSvUhqjEttupHuI7cJxqLOZTU
Message-ID: <CAFEAcA_bRH+YW7u4oF_7ccC8GqYZuhonBCgHMcX0N25P8MxfLQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/aspeed: Fix remaining hostname-specific
 login prompts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 20 Jul 2026 at 17:23, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Commit b04746bd0d7c unified boot completion detection on the generic
> 'login:' prompt but missed several SDK test files that still matched
> on hostname-prefixed patterns. Apply the same fix.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4059
> Fixes: b04746bd0d7c ("tests/functional/aspeed: unify boot completion dete=
ction on 'login:' prompt")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

