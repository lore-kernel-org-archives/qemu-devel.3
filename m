Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B07FCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuCJ-0006g4-Jj; Fri, 15 Aug 2025 09:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuCH-0006aR-Gb
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:10:17 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuCG-00035e-3n
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:10:17 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e931c85710aso2010056276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755263415; x=1755868215; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5u0lCipA4X+GACjgF7Ot4lRwzxPciMAuQVdFOtkb0Nk=;
 b=MuxfAe7V8GjqVyIcjiz7rJKkztooDXThHUAcIgO57lMlNjXr5l363xv/RQQnRxA+F4
 UCuX/9oYpNkcr8OCsj1PLEASFlM0oqKtKPtR17ISkepf0cG5tkWdJwfjjgh7qMYOV0CG
 +Fq3MD/CHlnjEpR+zMRvgH8HxU3Gt5Yt0OeWeOMJcUxuc+t8oKNtIXVEuiIL5WaiKEi5
 qQlbIlFRyOEbS6H/CUUQa+HDFPVxf7q6mGqn83INGMjYFmByVwgyvgv9JkcAjNX55e0q
 58utb3RUg2YGPRg+3gCIEXc5H3RC+ko75QURw6wZ/m0W1Eta1tTwemtYjbHwDTlpq8Zl
 quMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755263415; x=1755868215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5u0lCipA4X+GACjgF7Ot4lRwzxPciMAuQVdFOtkb0Nk=;
 b=Nu7V3K7jf+CmYqDzQ3Lh+bsTMoZlc+IK5DUbpqpeMGXjBuotsukGzDMj1WNIedff65
 aZvR5SZ8HA2zQSLZU1Xe94LhFeFTAzrWbCPQcO4/1QQjA2yoPmBuVOUc3U42/WLQn4PC
 3XsB2YNOQdA4oXGuI46RVPuZ6t9ae3CXxvLTqE+eIoP7TIAllZvd13Mb6Nh7DV7NRs6j
 8EpfUFuNTNkzlL7XznLfQRMG65LxVT3HneKcIlW7NGqhj+KlAGtluttW9SiaA1yYYzWn
 BKYPmpNuJS0QwWU+IVEihOTTGYAIch190Jah2XMbtD6jGSnVVMjiiCHbBH4Hdj9/l4fI
 3v1w==
X-Gm-Message-State: AOJu0Yy2139eSaVjpctVu3xgdZ9OQ3LAxJIBz4P3oTz9k8pEhzKprFdv
 GHepXoxVRskSMbCe4dPkwCW0PZL4btr0XGS4jX1sxIYLDMSwhKa8vfvjJyQdGpOd/RXJhhXE58r
 YM6fKSdR5WTkhEDKYNg6ILkb+EHA/xOaYBT445wvqliOq/gP1f4HL
X-Gm-Gg: ASbGncurWpYXZ0HMlaGQMkkWHN+ptmxBc7Ry3i71bRVvAixTAbu9+oJ8n55muOqXeP6
 dkYEKW4ihdcvnQ86Khy35Rp5nZJA+FOKS/w+c73cOAt2gptx/GSj9Ki8/GOpQrGp4p7L5EYUQdm
 tKnyOPIez7JDdVJZhYz3808uqn1JudKXNgY1bpJ58pjh9ErsVRWGn1PD6g+69PgkScpSppPb+Aw
 Cc1354E
X-Google-Smtp-Source: AGHT+IFGOjnGrQjo9yDoRhI8Vswbe/TGu1kpN2dSYRSeUdFrMzqa3gYfcNivclhFP3Fp2y5t/ph6Sc0ecmROjxLk0yo=
X-Received: by 2002:a05:6902:161d:b0:e90:5bf0:12bc with SMTP id
 3f1490d57ef6-e9332502088mr2624587276.41.1755263414659; Fri, 15 Aug 2025
 06:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-7-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:10:03 +0100
X-Gm-Features: Ac12FXy4mweU9aRbT7i8qM0Ol7pmx-VAU6gaBMz_GR76JK-8nEAst9LJrqH6D3c
Message-ID: <CAFEAcA8dpPXVWib-0v-tn8QL7QXfyiGJqhvbykcp1YWOgUE=2g@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Enable FEAT_CSSC for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Sun, 3 Aug 2025 at 02:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

