Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C86C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weurp-0007cN-Io; Wed, 01 Jul 2026 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weurn-0007bo-SM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:20:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weurm-0007m7-8p
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:20:39 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664ce3000e6so576762d50.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912036; cv=none;
 d=google.com; s=arc-20260327;
 b=m7A+8A6WhsDS/EpqDp8tJg8MLVk9N1YmjXlWTfKQZ5jufZ4G5Grz/CAueqFVzFCb4x
 KNfBd6C9Hd86tOOlfCtoXkEoZ3Ilf/fdKGb8a6SfVipnDjUS6sQEWcIiwQtmTmDfQ9ip
 /OCKsuM5RG7FFIV3b3VCy/zBxNZH9cvMIrZ4b4cTlwoczDD2yMeJhAnUDwqzA2A10Zqn
 bT07Vy3yk65bE2McWKZuecQEGb6nBO+05HV7nNkE1c2sax4xMlHi0L1hihbkEeLVIWVB
 KKsI8EYD6yxj6tT7hQhNWdbNJoUuRZr8zbyQ40BjJOhZG/oMXfaUp6/k/zQy27r2VC+k
 YjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rUlAdOWsnYmTrfyGQJN7b2DnGhI5x+okJIndRHXB9Po=;
 fh=9zmgqPs7+9j4OpCFTlQlEGyHZ1YCXJ0BQ/zYFXu3ZQM=;
 b=PVpuO8jE22rUjnE9Ap7fBFj5c8lq3TRE/Scz0q6RfXbPWswGGqiCNUnx7vBmn3UyWW
 AK8u9RtKb20hQwSCWLiExHfuutF88DxSzjLrnGbzTRKOU5vx6zzsmxdVN8QkAr3+t6Ag
 wMs+R3vxYZcex15WSeTSAxRuDtv6KP7YUvf45xY55BxEooIIHjlPbQs1MgaVPkJkA+Wa
 BEqpf2FOueOb2mUwT0/0fu8gZOMjvu4A6hHQRkkfFnHAnNVnWDikLIpAghqP54+/kd6v
 2l2cES/0Jv73cW2vqoNEghxCPKyFJAiPyZ5WkePLdu1kMLsjD1DTdRWGs6QpllslN6w+
 goYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782912036; x=1783516836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rUlAdOWsnYmTrfyGQJN7b2DnGhI5x+okJIndRHXB9Po=;
 b=pOS+txuuCuTAgJwsskYORFzYsKlWrWJ53WjE0gz0FAGRafsalZQ5gUGTuO/xuaDvPr
 CEwSVstrWAXVxRXqPWRNR+U67WKCsiLs7a5kclosZJsk3gXErWU+Dbi4t6YLtwYMf5Gm
 qWgvPWdhlGfaxPlYKpN+lnGcZn9cHAc0ZZK5Lb7V0Ms39e9YFNcV69d3wy3tGfwXyOj1
 iY9O8bF8TeJaFNck9ecV7AMgbKpuBkB8YeSp0XJ974tsRda8+R+I5MzCxCUr+hD+PIst
 rKsbM2J8/KeSn/97OiJ38IRbDOVlzXIJZju0LLUx8y8mclL6e81auWU1+4QSd9tAIWHz
 WYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782912036; x=1783516836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUlAdOWsnYmTrfyGQJN7b2DnGhI5x+okJIndRHXB9Po=;
 b=aapl+ia4DCr/YFZHqt5x9JIlo13KLEeIqpmftPwvPXdb8t6LLFV8NfNoQamDIHG6Gz
 iCTzOJ4dgmQj5KHmxx3jAzNUcEOlMBpRtRFVSDe+6tY39xyZ7eAFtF/5z9w12ozU3MTL
 UU4I57hrSCn/oqJRMVybZohPTgjeNvL2oURzwWjjrXby6/he0HhZaodBjVvPgjgyKPp2
 TLB77Lh/mRzW0UES5iRQE2vKv5vqOFy++YZ85+HaBpXCJ5GHEqIywmoN2O9FGv2FmMit
 +BrX76W24qJxd/2w47B/fzHyTXh8i3gzYWYA9Sxh4DFiSIrB63HNczwb4RbNLCeujTlF
 5UqA==
X-Gm-Message-State: AOJu0YxuPxwj3rE+R39DS2ayGKoGQhcFsRoLxDyvN9LwQpKye6f0Qo0c
 U6XMB+YflNLDv4ZsMkci/jUXQto5G9Fb3hcHzHn7G8Xpwd4nAauo5TmQQIH2bGLs36whtI4F9gY
 bon3QFdu+lFNrGkYzczMiSICXm7hTfZqAYuReptdRpg==
X-Gm-Gg: AfdE7cml/DY0MZk7oKAxEgVabPLIojXRaFA/mHIiORoGJX9dzO7F+tbXdyW8BfHb/Mc
 wp/RStxNeYLV/t6JJOjidvERChjBXsLhwLGyU0o1EF1lpBrMMIciYpGawmdpEp2pt2tHdq5amki
 2Rkc2EiJ3uae91XQglJAgvZFUPKNqoSCkksgu4lH2FUByzZ1yeGCqvxv2M8bLZy23fLT6UWLi5Q
 1GjZBLcEkUC6SJ1MN2ULOQKO7MhsWkAuRCa/NBdgiDeDSLneKcZ+IQo/s8SLrBJDc3iMUnfkXs8
 tz7ZGvda5PgviHC59rpoehY5mHZRQ8sgEUrSoC+6BE93WvQiyQCVJ/pZ
X-Received: by 2002:a05:690e:484a:b0:664:a341:4534 with SMTP id
 956f58d0204a3-665915ae955mr612658d50.16.1782912036556; Wed, 01 Jul 2026
 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2026 14:20:24 +0100
X-Gm-Features: AVVi8CclsKwsqnDvFRBXHKF53zHTHRseRoXeDX27yb-DeNSxjkkbbSmoFKRjxKE
Message-ID: <CAFEAcA9YQW82f9Aeaa30ybJw8iSPSzq_XYQfcq-ELBYO1LQY+w@mail.gmail.com>
Subject: Re: [PATCH] accel/mshv: Fix pointer to proc feature bitfield
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>, 
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>, 
 Magnus Kulke <magnuskulke@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 1 Jul 2026 at 14:03, Magnus Kulke
<magnuskulke@linux.microsoft.com> wrote:
>
> Processor features are stored in a union containing two "banks":
>
> union hv_partition_processor_features {
>     uint64_t as_uint[2];
>     struct {
>         uint64_t sse3_support:1;
>         ...
>     }
> }
>
> get_proc_features() to retrieve the 2nd bank was passing a pointer that
> steps over the whole union (+16B) instead of picking the 2nd bank _in_
> the union. This manifests in mismatching feature bits for the 2nd bank
> and possibly other side-effects caused by writing beyond the union.
>
> We need to step over the first bank (+8B) by using as_uint64[0/1] to
> correct this behaviour.
>
> Fixes: 2f6da91e8a ("accel/mshv: store partition proc features")
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

