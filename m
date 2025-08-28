Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E01C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJ7-0008IG-OB; Thu, 28 Aug 2025 13:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbR-00046G-65
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:27:49 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbP-0007Oc-0s
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:27:48 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d6083cc69so8609137b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391265; x=1756996065; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AAvsrS8s5w+sweSTMZdr3YzdEBPAZJJsGzx//Uyl0hc=;
 b=hOHqsHvb2Qa9LE5q4fkuqQb3qY+XSV2UOcmBTCv2/7d9Y6W+8lf0zf2N7L41eLQhpu
 4shYWPH6cKDXgQ4VUZbM3o13KDb/6x4rGRe40gFrRTULSKBd2OcIoa0n5MTjawpmo0l/
 +drK1AN18C1O0P3hd+KQiQxPQvCEhVdhikuP9RwLAnE/biBJ/Ly2RN8OqxFfRffSIQvj
 C9rq8IOpQlci08WOrzmEmNYWyeMw/oQns3wQUca5ozVXGlbkTf47AqDOCSdj55HXZ9Em
 yeADJYTa6pBeznUxOcICIms19s+5uWh2W5tOy964VRkQ8Uop2DUxBh6QXG+4SkKziEjN
 zMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391265; x=1756996065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AAvsrS8s5w+sweSTMZdr3YzdEBPAZJJsGzx//Uyl0hc=;
 b=IUHYk7UMI2T/m1mNQvyJAI/6Bkegm1zpOaW+tY4jRjFOs/R6df7iw9D6nvSgSj6+Tt
 SvbJbhd4Sf1LAgiM4ObGpYTxBSAQdAx6OWLYOxju09cwiaMfY/HSZ+p7o1C3cE1ehqVF
 k6AIOJNEPxfMzEntDhAUJ5Zzo1yhFjD9oFPuCbLSKxJzfZm1ZomwpNkcV/wiAi+ySvw8
 Qbvp87E9KZf5d4LrUi+VTbxdwiNgha0gX10odiMJps2JVB+XZ3lU5/Z3Y++S5MgQK2BI
 BqtH43Zf/Stxhvc9ykq4V1go0O0TFmgdNmkV+feA6DhO0iacQFVshc59MO+pEQw/ZXqk
 uYxA==
X-Gm-Message-State: AOJu0YxbuOZTE7qQD/E0E1JEepcWfMzbV1j19sJY7yZgHlz3/M21UBfB
 0eFjs7YuQ03xVFJ2PHcCUr1Qccv4LHUp4E8H3qGhEoVuawuPhcpKni0zM6ZUa1QFhYZZFqYqCQH
 aI7rOPVn1q+4obwcvhFfwvGoMzqdaq1okju88DKLyROD0qTWQgbix
X-Gm-Gg: ASbGncvHTNAsAhpC/96Kilxqdh+oii2GRG97fpkGBB3kRACasIh5KZVh8z6cdAgZ2Ap
 5JZNxQP2B/5ir8TzX7SjQR/JSftcM0SpdXSy7OqlXnK4Qqd+20CCIwyXJh1sRFgSOVr51ka8YlM
 erdsdsdtE8gHYi5kysnp6lUvxqCP3HY1bWhw/57X1kKk7FL857WUgbDxQ6AVAsAcpi+c29CmY+H
 h3g1HsaScEesPSCO6o5iOyEFZEvyg==
X-Google-Smtp-Source: AGHT+IFkX9YcRPhRE7gDQ/xloSBJGOEV5e2CVo1ZZ++YWqqu7crzqmq2N1qT4eEXNEEo/k2HWdjN32cjat/6KPRdbjM=
X-Received: by 2002:a05:690c:4889:b0:71f:f24f:ccd9 with SMTP id
 00721157ae682-71ff24fcd8amr258158787b3.36.1756391264876; Thu, 28 Aug 2025
 07:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-14-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:27:33 +0100
X-Gm-Features: Ac12FXyUbQnjoEeDS-J22eog1PQObrlMwE6LmLKdkNl7iPSyMxecwiZW6M9cjc4
Message-ID: <CAFEAcA8ayFoRspv0nyBd8-HyBwJuLjAKTpucBjmUmotwVa=CQg@mail.gmail.com>
Subject: Re: [PATCH v3 13/87] linux-user/xtensa: Convert target_elf_gregset_t
 to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

