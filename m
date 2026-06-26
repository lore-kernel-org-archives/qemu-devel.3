Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992F3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6cj-0001Rm-AY; Fri, 26 Jun 2026 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6ci-0001RN-8A
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:29:36 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6ch-0004vr-1s
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:29:35 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6642887c602so1343153d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480574; cv=none;
 d=google.com; s=arc-20260327;
 b=f8nRQNIEexW0mHDx+ZV+l/WQL7QbH4rmlzA493PnGC45scCwFpbBIdhnCXkpoRu5n7
 wnKs45YDHR2A1EsRodDUnZSucayXwSO2ewwoeZp4r1S06aX9nZbSQ1VFhlscnfoEblYO
 FPKadx4hsU24XSqJDoJ6Q5Bh3s5nfiDDjMOhGk29KyNnXieNOumQsxQA2R+LDx6KszS9
 WoNnG3wWUjVxJwTtNVMHRpC+06HewAKXYicGrOjwZlZ7S1wZx7mcQ0u/YMAXzWplwTSf
 jH8BcajxrF13ag7+P+Kb/XN2Vd741QIJIhSkgVT4LhquZW3EnrF2XcTk1FemQn1a53ea
 U9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=lyQCkpp59VQl7ycURQ5wiABfgq/uYHktfzEBI1p1ON+duWsHyCpRQsItdJckb2KKUF
 BDfgvF4ay/8aOudiDDx4FQA6DmthJ7kTSTHrz7Y9shVni9VejMfipFkvlcj/HuSMnXWH
 E0d7g9M7Iwlr/BbX2oHwAY2GJ3bYtWrPpI+lT9bsrtlmFJwFcSq411oUn2k6EjBNU4LJ
 41J6rZj7uKzT6SSuCusgfXb05CVjhSPOOPYcrt8H6zhD8qTavbaX1uhUeakE1evtuNfs
 o44sdI/5pvWStq6yiixL2LfFqh3yjUScNZ9X/mMU7s/nZm5Cuw+Ax8S85+K5qC/tQ3RM
 cVIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480574; x=1783085374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=SbkcaE///D2Ei/RAP8gMvEYZtXgSoMtWoQKPnJGzivpgtAvRGbW4N6JLQN0BDN962e
 ZNt/THedHEMcB1X/aWwUh/EsGy9VkjPUQ3dvrDwDZzaoQZd9Eo0DsvkDVV/+twodfsQd
 H3LLKrxnTVIHFg5g28wvzP9WBuUlsSEcn4oP5EsgNXfckiEsdMtKaIHnCxjyo72A6eTH
 J+/IlUU9Kq6/9x2hTxRiYiz86Rog4J8MaECUWMoYr8xYXioKjQ/n9Fov1Ab/2Ll8Mf4/
 QYW4fJqLVG3NRemSAXeU8nWBD478aV45Xw9+Tq0FHugY0yoMIIXvDfu4PQ3Njjl909GG
 4nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480574; x=1783085374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=RurNWGfm4aIE0Emitvn8+ZC8c3gWF9lb0L2fyMPQjK3IC6e/gFqqQoUrsfRWmBIv3j
 k3bZ60YbAg86zo4Eb+/yzXBvZ2uNFTbSpA4T5cW3hiCuS4x5YJz0+wkKSzpzvo2RKcnf
 frrcHefVvue4io3w86RU9Ilfc8lqiG5/jYYti+9u4DPozZC4ceEm8IRdORVWrxH9Psgl
 yhYEAVnUF25ljpt1MMSjA7ktPyndREpgKC6psjscdtn5jYkgqj9537xnf5xIsLPK+mgg
 Z581wzT5or+iMWG1dmSnj+xOHQa4qdSPVr8EafBS7Ux8IBiJydhClZzQ2FCPmTvrmNBv
 3eCA==
X-Gm-Message-State: AOJu0YzLXRI/ccoJJQ77qW3wm+fE+P1UJ1iLJbD3cxH5roc1czSu54h9
 +CUy5zjhrRXjphJxH7BR/GAO/q0Igg4Y24q5MqrIvqE9lE0B0iw2EG2GbyP77AzdaySLo2TDwag
 iIGu3eiQ98u0qJr88AuC9VmWXGq9JZPiqvy+2aC8YJA==
X-Gm-Gg: AfdE7clkIY2vT4xD2FEiHOTGS9EQ93t4zPiDVvYD/IT6TVz2LBskY46qMyFFyzzabQz
 TBN3M3XENXDd7Bb0HecFvQy3T/SANITrkqyVjn9QTrkSgg+eYNniW/K1MQeAe+PXI+E83WcqmuP
 Ah4T8HgAH/+MELxZUN/6mNoJiee7qMQ0IGw1uMpXTD3CB1mu5urKJ9Bj462BYzTe1b51h4uC3pt
 AOQV0l1R747iECZQkZUt1sWOUKbXR34kUvpYJy3P2zpgcVmAQrQSdZWy3mF9pxCiXNV1wza1uB7
 xVfXIbzvbY9MXQEpiJ33fho8vVRBxDjiBJZWdleXpcdnKlSDNWKDYZ+O+lwRTaeRU2E=
X-Received: by 2002:a05:690e:12c6:b0:65c:6dbc:39c4 with SMTP id
 956f58d0204a3-664883cf072mr5358982d50.51.1782480573708; Fri, 26 Jun 2026
 06:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-11-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:29:20 +0100
X-Gm-Features: AVVi8CcEDdxnJVKZvTi54xjK599LlQA7ZpEv7PeXMj_X04riMJs9vcOcLzRq4dM
Message-ID: <CAFEAcA9kqK0TGxO-FFqAi3nvkpj12zLneXRdKS7mvpr2U+ckQQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] target/arm: Implement SMOP4[AS] (4-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 25 Jun 2026 at 23:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

