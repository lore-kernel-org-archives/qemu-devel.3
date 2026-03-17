Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67438FD877F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VOJ-0004kR-3p; Tue, 17 Mar 2026 10:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2VOC-0004gi-77
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:27:21 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2VO5-0004Y2-21
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:27:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-662fc12ac5bso10874020a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773757629; x=1774362429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iyvqv2oeZF1JtrNEpiMY3HnJkSD10YJO054iHA654sQ=;
 b=B8QjSaTCpZ9hfysE7v8gjQAyyjkJ+qqsubBLflTBgB9+GgwwHny8aM0/j6MQ9fVIxS
 6/XbzLhaky5BC4ovAIvrel1+ceRqtBAJg4OZVygulTMuXQXMegSR4PvfGlxXD+TPJ5Uu
 JSbixnTCKgAEuXtB4xcWy2Q4vMrHiO+/24suwFXr3Qgvc6V0rFo1RS/a3qHpMS6D5+wA
 6Tma4hS+ppY3YGSzpkQp/8kbPSJjACli0Pd/IHEihspC3YAR4dYE8lKlGx7YVar/12YW
 KvV7BLBaR4ukKB7GbSSZerJU1EmOt1o6ZPT5nTkz8KBWUFQ9jHCsP3+Q439D3xyBaSHU
 z2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757629; x=1774362429;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iyvqv2oeZF1JtrNEpiMY3HnJkSD10YJO054iHA654sQ=;
 b=pUFDGZ0HuPKzLUhqnhvVHtjR4CcvlI+MvesAGm/rzJIK1u3BLgj4e4K6CsqCFb5fT6
 QfqITeGHxOXucd/+fTvW673emHcBC7Zj1+XZZKI1oylwlrPQQRqWxp4i4p2dIF1SopdS
 lf7ftcqGJrVCFYWdQf0VfOY021ZIMgBRbx24NerdvLooqzEiqpfzfWVvOjxQtSA9cTPz
 UKrybnaUVata80UFhRykSRt3IMwJ9365WLFqjya5m5PpxsmGbw2XLM2VY5/2YVQqvMn+
 4y+EKq5I/xookbto6qbrGF4xnHBbh/OvE/sZi4QEdBz+DwKB8Sy/hrtJtuFB/HF0maZi
 eTqA==
X-Gm-Message-State: AOJu0YyuF7fMcg45QhOk9QMfMa4SrWQ5B+KT9QLMNfwZ/Y9sCFnSlie/
 +oPI+uRoH0LjCFLFHnpl+nS2dMJ5zKgIFydWiFnTOWzfq8PVxjWQpYTEhe2hF4dUYik=
X-Gm-Gg: ATEYQzylYKwwhcWAxopJhLS112E8sDPwENPb6CEIKNcIu+pb1J/kN0LgwPl8oufngIe
 yycqRCTZUPfTaB3WRl0Ex4VZWsZdr9kClFN7/JyjHKfh41G8Ckfa7WZoQapaC9XGWc0pSwmkpr7
 qjIcDseoZRAovDKaSh1HtO6/R7AMQ+VqyH7hFLqHFzkHhAGxloTz90zjLJFwdjR4+nFAwHmOL0b
 E0cU2FFkLKSPlhujj5hZqguQnvGavXbqFm+fu6c8pi4WlLff2/EoKe3+je+O9qAxet4YMf5Q22r
 VeF0t+JcqFOw26rq43Cwqpc6QTFc1GX1/KNG90eSkc6uPS4hTr+n85ZUAehJRjKY24ukk00pgMf
 lV9yJ+GuVsTIg5IE/0NHLE2hQ8AfmCqFJOMd/5Y523+/zH779drt9vSXVBRCd208OSrGS+m6V8C
 yoma1AsHpYoUq1vqBYQzk0dyw=
X-Received: by 2002:a05:6402:1d49:b0:663:4315:7274 with SMTP id
 4fb4d7f45d1cf-663bac03524mr9294711a12.20.1773757629237; 
 Tue, 17 Mar 2026 07:27:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667812202adsm424322a12.2.2026.03.17.07.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:27:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DB305F79F;
 Tue, 17 Mar 2026 14:27:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  agraf@csgraf.de,
 peter.maydell@linaro.org,  mohamed@unpredictable.fr
Subject: Re: [PATCH v4 0/6] target/arm: ISV=0 data abort emulation library
In-Reply-To: <20260316025034.85611-1-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Sun, 15 Mar 2026 23:50:28 -0300")
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
 <20260316025034.85611-1-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 17 Mar 2026 14:27:07 +0000
Message-ID: <87pl52cz0k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Add a shared emulation library for AArch64 load/store instructions that
> cause ISV=3D0 data aborts under hardware virtualization, and wire it into
> HVF (macOS) and WHPX (Windows).

FYI posting follow-up versions as reply to existing threads is likely to
hide your series from the patchew tooling and possibly the maintainers
as it hides in the old threads.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

