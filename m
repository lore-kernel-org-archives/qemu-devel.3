Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4038C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohok-0005Y6-1Q; Tue, 28 Jul 2026 09:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohog-0005Wf-Is
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:25:56 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohof-0004vm-57
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:25:54 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6689402c7bfso4123369d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785245152; cv=none;
 d=google.com; s=arc-20260327;
 b=PsnNMdAbAhRfHdQgjiRDM5qTZcWcTspnKOsyqvUBgPO736v9BIYoWOZlXqHHIbwRXa
 YHwaRnnZ5CJLnk/PpXyYbJn8T+ZGX6mJu1JhY2L0oIjsTg7tVGwTpE/rkqvDYf+1P5r5
 59u0NKpeGsZf0Vzbnvmy+upjE+L2b7oqu9N7543tRc7kM+In9jIke5+QfPc7SBFa0DTo
 J2TmD1vi7aijAVtVJUbz/30yw10Kjcqw3Xqww/gvO5e0y+mW8JBG7t35Rcof5s2Zkpn4
 uajHfbOcqEZYwXvLDgzV54V4Rbda9ngMfEsmwH7Hn3NMLSF98obvFpe4/m0gcArbMDt1
 2H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wQJQabbDqUzdwuQzBKj6QZFRwVeMmnQGEAoBsN5k8iw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q2eyVdPhuyD2lqTRVGawVk9L8B8JajcDK/HdClGZaRMXEB6Vl2UDITtXJ4DtWYfz1x
 7QSckpwLRJ60tN2VUGmyuyaTIKFbWwe3xSc+lgdYuQnZ6+YuoxbmMr76SRBPEXaZ4GAU
 R0z8rc02+pe96iujraS/rxMnzELL8kB+kpNfUI0ahTV8KPHVb4TwzpedndPvODYBRWx0
 N1SQf9+uE+XHfQ+11ZNIQ6wBHCNCfECtF1F5wMkP/Hz7modxCfFVE0xcov5RZV/QFih4
 XC+yCpyv5h8NeYYcx7hrZtsU3+4TWvE5QjEI/A5KYbVP5sA4pi/iwdtA13+GsaTrEVKW
 wTGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785245152; x=1785849952; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQJQabbDqUzdwuQzBKj6QZFRwVeMmnQGEAoBsN5k8iw=;
 b=Y4nA1cMwJBVM1jweIl4Y8bTvk3ktfiddyajUooxo6BzfrEz2wK0/uqsv2qPSATuDaf
 uoY48ZqeTRL+sumUz8nDvgAD1IgKQqnWLvOljX/927cgbp26jHt7FIQkU4FiHI/4TQRh
 bcQA8MSPfLhNym25CcCK/qDnz9BV7lPpQEssmALB1c0TfTbSTD7qj4Yc3fk61bXOGbJr
 rxKduCF0RSlmAGBiaHF94BptWy9YRfPiSx4GRJVtczVKa+jXWveyhW8WudKHN+RoamjV
 oBWITkzlhTXaOlyZ9uf2rOOb5o1rsXW33rePrUcO2KKDBbJ7H/g6aFJPmylCUIkUFvBt
 naiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245152; x=1785849952;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wQJQabbDqUzdwuQzBKj6QZFRwVeMmnQGEAoBsN5k8iw=;
 b=KdQup6Kpynz+XGo8Gv53MqGCwrDsHKEmSdUeKmQbQzSkffSyVEum7Edpn8tR+uZe9q
 Mc7yfK2fypbJGRxBILB+SLZXR3LRr4CM7TTYNRj+2s1X/otHuuPsL5MjfO5yKDNPNNUo
 4tm/wpBNY5d6npHGdudXXOBR57ychwwgxeHO67XBAzgwlx5UevOjjpxYbYgtaFecRgG2
 ZUWxGEl4xIWoXwbyQe6ZBlERoP/xgGLQt5/l5mZEOfl8F0MQvgDneHJHWM/oEu1fKPJs
 nQzBvcsIf9YUJNMfNeVWks/F2YloXDk1j8XL3L4Uw/P5lE4P7rxC5FnLW/TLe6yv16dm
 +LYg==
X-Gm-Message-State: AOJu0YzaLW4TBBS/LBD8/rYz847L2/8PWWGNtXhqS95Jv+CZCuekTR7q
 jyEBVQPAEIZ2ggnncLO6SurNpR1y/LalXW1Tg8wMy8ByqsfqahRJc7CkI8ATo8G930ulgLxzijF
 WB7Bg4sxrn9Ul1IISmwg6rMaJoWiuj3E99wq5dAvIqQ==
X-Gm-Gg: AR+sD13s3QgHncMvLozO4NrZLlq2Y9QDAifkpMz78z6Sdp4UGtrdfaxIhK8blJc4EDu
 4V9Ru+Inon/n8jqtmURFwkUvG57y++AzhGEh5onwpjgZ0nI2h4aQlBeO+LCrLpuKObT5ga5aAM0
 eO4BVUjVJPRaXxkfMZ5wxqv09nMtSAKWpcBchn9VyUq7cuEeiT+s1g5KsZKz1Pgl3n/kDyUo1D7
 gwN7GmHOT2wD4OwyDl4VaWa9HcLcYufM8XpNrugWt3j2ng0KN23vewiRgRRQTaiLkFdUy5utdlR
 +t3LOvBDo9+jEC8Pwlu6MW/a1hqiMwp6Z5jB+yvP4gNW8w==
X-Received: by 2002:a05:690e:108a:20b0:665:31c:90a0 with SMTP id
 956f58d0204a3-6690549079cmr684948d50.14.1785245151731; Tue, 28 Jul 2026
 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-11-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:25:37 +0100
X-Gm-Features: AUfX_mynhzXFLl4e53lGaLokcsgMtCqn0gW0wpZMIyjFJZ4e2I_A9hUCa8s8Cj8
Message-ID: <CAFEAcA8Ss9FmUS9BmixLmBn28u1VAY8dHruDDT+UqZ+CREKXcA@mail.gmail.com>
Subject: Re: [PATCH 10/10] target/arm: Enable FEAT_SME_TMOP for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 14 Jul 2026 at 00:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 3 ++-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

