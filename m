Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD35F3C9AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvfV-0001TE-Tf; Tue, 24 Feb 2026 11:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvfV-0001S6-79
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:53:53 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvfT-0003Hv-Tz
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:53:52 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ada2c30a1so4951795d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952031; cv=none;
 d=google.com; s=arc-20240605;
 b=bxeZLSHe8t8b19virPAuBirZLIGC4M9MQ7oFVaj+5dlKAB0ALomwC7xuaIylXPf0zP
 85rP9L1onJ11HOsRldxDHKqMop9GIjlkKecsfVY3jJFPuzvxJIuzYonpEkEUaulE++Cx
 Pon158dMmflAWDdUiUnJiq06+EgDyv1Z7gF8aGG7rYvPy4uqYZrq7W7k1BLPwltzp5+Q
 V6korCd+cieKVS/iK8OLgkYVRNaHZHXPKPAUBvhSxusNTsFsBbFGzhMTvIIxmW9jSVNE
 PJi9M6D/VNYFLZLnyWgv1AzFjUdF841sy6qsOuHJEEAzxVjSzIHmymQf1VWf4bQnqGbz
 PboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aPOykGTE5Ha5nYzLfR5Q8IwVEp75sHBjcqiZSuhKhrE=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=bnEoGcceIquehApO4UqmArHlqjiv0Ovl4Fkze78Tpe6ikggxlYnIUDvIvQ9ZAAw4va
 7eD+If0i94eTJjgdw6hh+ZYwOhFOsZEvelp6SUq/vbnaUIyoxACrcZs4n/c2MxJXLMDs
 NMMnjNtlwdQaAIZBROpPVhJvuHpBwb6G6yxKf61cwAjGUpZYWUIk3wX3WRZcdII3MUCi
 Otkh90faz7rcGlhZYK+1rhc94iGOCjk50GWAS1QpBZrPSt3FcyOudNcnzprzHv1gYuPa
 xADD+mcajKCoNltz6fMRbkr8R3tGHWPkmA3QmzCLkvw4GoswsYoSGjbqTD4gCE6Mwf7p
 zRwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771952031; x=1772556831; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aPOykGTE5Ha5nYzLfR5Q8IwVEp75sHBjcqiZSuhKhrE=;
 b=YN/ciSyn+ogQCfcM8XYx+1ZhxTO57BD00RLoNJCNR0wCOsHmMqLXpMEBncGkerwM0f
 FC3wbupZl0IovCcsM9esweuQ88fFwMNIYeuimmHTDt2G2GssaMMuV+aiLzaNP9jJTsiu
 hkHFOTom6dfgqvk4Gx+MsUE/imy3HGpRrglZqw5DH5/LETKg46uXqgGWQLzLBE6ikqqb
 pic/FbJi+cJMGuxJGgdEX8fuIl7fnA+1ZIJ0VPpJXFcZWuVPYgDSpcG2VvE9uh9MUit8
 XHRPEjrIep0Mi9Lcigh9Jibknw+0cq5B0ixqGGL6q3/6dfvHmuZWYdWRFxyCJi5O6nwc
 yYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952031; x=1772556831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPOykGTE5Ha5nYzLfR5Q8IwVEp75sHBjcqiZSuhKhrE=;
 b=IDoIk/LRtVZoFd7YG0orafUQiHfHCXwFwJmmcG9RLGrnPjZwg11EqPIdzLojWsoUzH
 ykfhGyhgnAmGWK2UofXgqOk7VKGrpaNBg0VqkvG6apq0Zf0U7DwcFa7PSzaGapxgVg7K
 /NEOFcOhpks+ifakJNf6/vLdp+eEWVAINvdw83oqtN/SHbU/vCEgsxRGOMu8CdGgLLrS
 zn2zthUIlTwEvyRUwnHHEhIA/3iwpMYaD6tUv6Y1I7XBLHGBor4nRrzZAOY7x3VbTGfx
 Ln1rrx5EdrWuWVXYjJXDOdUkZy1Po/e+47BpV8FZHJJoufIbdX7xorrpCa3pOTc0t5lO
 xHFA==
X-Gm-Message-State: AOJu0YzUyXKt33992cq3uOwJFbaALyEj94BhWHiBSAPTHBoPVJmjpTHa
 ZWdS/tN4wpACWV09fvsQcCHgPlIP9NbgjdX+fWssQqDxclVbg/JPhMToXM/dNEKjtW7EjWLLDZw
 7hIg77AP9BVWvnml2QhZpkFL7mGcVEVM8TIdFIlDdCxaywx6vyqDM
X-Gm-Gg: ATEYQzwftuno2MFyfvBL218Xkhj5Cb5TLipY9urj5VkQZ/ZGtxsZGeIxEBZX2Mz7Kgm
 9cs7gxqob06aErr7HRWZ9lkhNBkn7Km5Jmao8b+Hpm2tcIHSA7DFO2ypoZyhnlrhcG6cBz4ei0P
 bcbBXgeaPmSjFIQfF+WTPXQg2+WtBo6JQ/FhxfP0skQHIYF8S6LUxe1Pqmo5EUP5dSDyFmQ37Mg
 1X/zoZ709NV0ah9TwJlRgoek1t7hOAvvgp/i+rqO8UQml07xukt+CXf0/uW0pozyGAbjFNKhpYJ
 FezYo+MuW2jmHmKbj7kCuktprg9qBWqWKFMx4XtTSFPlmctPSNmv91RxIetm6B41bQM=
X-Received: by 2002:a05:690e:140d:b0:64c:a37b:53cf with SMTP id
 956f58d0204a3-64ca37b551dmr1195675d50.77.1771952030621; Tue, 24 Feb 2026
 08:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-12-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:53:39 +0000
X-Gm-Features: AaiRm507lf37kI1MDomHH95cfbjz-aPojLU_H_zJHmUpyPQsHs_3R1dtp9EP1aE
Message-ID: <CAFEAcA8bDw57hc30bHH9hDpL_sXfE3XQ6Ob4AOjo9WzW5U3ubA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] target/arm: Add have_ffr argument to
 kvm_arch_{get, put}_sve
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

