Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21C7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uht9e-0007Gq-3a; Fri, 01 Aug 2025 13:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhriO-0007HU-VD
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:30:38 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhriN-0005tq-5I
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:30:36 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8da1fd7b6bso1641651276.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062234; x=1754667034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAdEfnGWvikpJ+Ej1cXUL9pX49IQaIn6uHG4acVpYnI=;
 b=fIrY793WUCX7hCzsERESd6MaalVJ05W3/6es7b6uIj/yDRkCH0kHTAkqBlY103Zk4r
 enxQVxJY952SXSshLGPKLzOY/fs/ndC2n60rnrJDng9BH92a7VI0T6iOx0Qj981c7pPC
 i0O496uZSaDSXFviqJe0pqsozqsU/0ku7vdjcfs1zCLvHS9gaBUbp8P02UYWXaGa3/RI
 g/zACpUimSmZcDZN1CCdd5QTNNlMCTITyZlpgvM7Rh8Pd8w0B9rYg+uXu2xw1lcGtgx+
 CRXp82a+aRv95KpPT7YSdc1IeRax1tcpJnhOKCKUp7vy5ubbzmM1r0Q9w0ufv4HjhbLt
 OkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062234; x=1754667034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAdEfnGWvikpJ+Ej1cXUL9pX49IQaIn6uHG4acVpYnI=;
 b=YAS64Vqg2DUJcmTF2p/ZfagbQ33Kqnj3KHp7u1BUhQN3RidFcsj5QWw9HAXUyrz3Ad
 yzXAdDcBhOZxDVVTaTVyflJAGmW8Rbbhv5JrY5DEzSO43jOeh4BdjxCOyR/2oFzucZbG
 m7jLO3hlxjYq/DupnMHrNFqHaXpvNbO3dcIRW7GV2/rVfnlf9Lq+McP2hYKuRjezfcWQ
 lNbe4C+1a1pvV9+ZU79kDEhKJ/ntMczB40sbveSsjw17cggaNI+815dkpFgeGMefvDSz
 oddtLdk5ukfp0ZvEUUVlpHCvTYo2doTffiI1K21BuI47EflL7PPh49t9sOebwM/1agBl
 YXVg==
X-Gm-Message-State: AOJu0YzA32O8IG9+uWaMuhmoGZ57jpwkiPqxy9OQS9FJbX8Q7vosV9yV
 V4wuV889UAnUiNrQcTZKt4oWyyzTCg9dyfYPiL4aitMrWX2przXYtASyRFHuVhQkFJRfhgd10MS
 ycvbdm6g5dkCcMGby7RQNt5GvETeKRkdi4u6iPyIl8/dmJ1jFPyUb
X-Gm-Gg: ASbGncvNBqgL3woH6xCLdPGXNv06OpITWehBdCP22IbdO+h0cES6Crxe6Pb657YQl8c
 iaK2vG8ZGpHhnitWNunFeffeF+RwXCqDSV7v4QkegVkk3VfTuAjeodOeaBKGQJ2JjHdp/wcp4l/
 6JSA0bpJVQwYOHkU81XqSnzzX0RqVjhcIQE3DQeLYqlQqOj20TbWLEuYwd0rd9Z3xXzC3Cb+yRm
 bkJvISM
X-Google-Smtp-Source: AGHT+IEogbuPr5mev2mV6wDFRsrVVeDrDNHJMxBAcwpMzXtTq3ljXWZDH9xmuqhU9BOg+azapYWUaibS1Z52gIFDpZc=
X-Received: by 2002:a05:690c:3343:b0:71a:38ee:1ff with SMTP id
 00721157ae682-71b7ef4db59mr789317b3.25.1754062233694; Fri, 01 Aug 2025
 08:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-16-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:30:21 +0100
X-Gm-Features: Ac12FXxgfSoHDJs384Mlk-jQKfs-Oszec4VXmr93-V9Ubl5XsLN7xaUSDd4u61c
Message-ID: <CAFEAcA81usgqk40rDEnpA4MwKsC2A7XLBmR=2Z_k0QYJxnrQDA@mail.gmail.com>
Subject: Re: [PATCH 15/89] linux-user: Move get_elf_platform to arm/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 30 Jul 2025 at 01:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the aarch32 get_elf_platform to arm/elfload.c; pass in CPUState.
> Create a simple version in aarch64/elfload.c, which we must do at the
> same time because of the ifdef dependency between TARGET_AARCH64
> and TARGET_ARM.
>
> Since all versions of get_elf_platform now have the same
> signature, remove the ifdef from the declaration in loader.h
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

