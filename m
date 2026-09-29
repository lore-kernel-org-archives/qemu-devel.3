Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D720CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBaCk-0002on-Qp; Tue, 29 Sep 2026 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaCh-0002nC-1r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:57:15 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaCf-0002EI-Ig
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:57:14 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so3075476a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790697432; x=1791302232; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y9tcVJpFK1qR+1asG6t2u45tWjX95He5nPj8hdKilZQ=;
 b=KHZOREHzb+IRj59EVf6bM1Rd/J1f1UMXo6KI65w/150hT62KU6Hpb77GEObArb9U3Z
 VHLjNAf0MSJGfaXpPg14I3iK0NsfcWIzO5oZ4bLkT5TZ8KUwKVhEU9ZmQG9mT+pyXhND
 urMy90wmfiJhoFgWFrI05x1TxWXqaZ4qoUZ2uUcdZ3FGR1e7sDCGVhwgpAHVWuU7PQNd
 qoIM4lZ4t/7khUUfEi+7xuQZfNobOl9IIN23prCHAHUBs3hXIQ13ny4gm+w2eI0QSLfL
 K0mfXx6pJhyPpk9gcm7yBdAe+tlfkvmylW0oVmN9v9d7KjQ8ucS1BX46HWd+LW5uFySA
 Byyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697432; x=1791302232;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y9tcVJpFK1qR+1asG6t2u45tWjX95He5nPj8hdKilZQ=;
 b=eFwk0RSAPxeKUYKE05pbmJKoT80PF5PYcIlgooriZuuq+Ztt2qGbfKQEJhuUfBSOa4
 +D0w8WIRS/tsWjcOeiEKkokpy1HVTI8GKEG42RXXAntQz0voJC3H5Xgha7PxS0dQs3N3
 4wTq/47mFv+xIY7ihcDuK+KsMkvsblDT+ivgxo4EX/L0GP0+LiU+PCmlozIgveYYY/Zl
 xUJKlJZ4TckdnYbWGPBfMLItKisD5lBfm/pULLUn2rdjSL4/vVyTcvA7XzP4ggb1RGuX
 rI+kt55ycd/HqlJ+PjPUoq4KVQfklpYU5Q8V1Mlfk5TW0d5GMLyuNX1cVasc2EKjrvVb
 wdzQ==
X-Gm-Message-State: AFq9FYLB6nHSq9dAq2bnuBX3ser2DbkmHb+HVx/e5FoXIK7askc/GsOl
 ONbaxRsWT5fwf/jsg7um1fbaY0/UntJCMBchp5D+9piBzWyHuJHOJZxR4uYEYxQ7hU8=
X-Gm-Gg: AYBFou0aQaBHB1bYg8IbR5FORkvyWeeUMBiI6PxPa8pS2fuzKsAtFYm9umo/e5KmDjf
 AU0ugepW0iIYx/h3PNIFoc1DSg5eSyUWq+zxFtvYCUIsldhV8XVg7nlWQ2j5Y2lV0qPV6dB7yz2
 G8WJ2XDg5lNG+QGvUv6BQYdv0jzM7cWSJOyy+trvZw1SKqBwQM5mLF28vmdF25eLP7AbXVc/hf/
 MgfzttIvdG2gKRlrYpCkfmstDKj4PAIDUG0B5E50xfDTPk8r7gfo5WdjN2sUIT9wd+PwnO7z0At
 fYKGZwOuW4IO1DVT7qSjmZepJSjbdlJ5S1qAXEWV+2jftaNR7jHW67Ynp/SRX+iAqTAV3Zt00Le
 ixvU/UxCfchyybpUaya3RcFX9INBYcRwsmD4Zf71PX9/GpRypxBgtz6+XWKD520MGZgi9Zq2OIv
 +HQwTJfHAodnuGil83YQniDwtuNaF6J+FX5XJIPudBxW6grFoMhD0UiWz8qJkhlId43xb1orLoQ
 xWn4VywpTGlMOVd7n+9NnU=
X-Received: by 2002:a17:90b:224f:b0:3a4:6f87:c0cf with SMTP id
 98e67ed59e1d1-3a46f87cf70mr4873476a91.53.1790697431967; 
 Tue, 29 Sep 2026 08:57:11 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4b7b754adsm669072a91.2.2026.09.29.08.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:57:11 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:57:08 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 06/11] tcg/riscv64: Assert immediate in range for
 [isu]-type insns
Message-ID: <arvfw81XMxk4ohrR@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-13 14:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

