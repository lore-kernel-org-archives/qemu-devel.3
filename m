Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171AEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgG0-0003RA-38; Thu, 28 Aug 2025 13:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureCl-0003zY-HE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:06:23 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureCj-0004ad-Fu
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:06:23 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d60110772so7964127b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393578; x=1756998378; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=auSyLxpNkMZNjhw9M79PZlAVbqhHcxne/FwcbExJYRkcIAIHe122A7/dqxLuR/7kOE
 YTikgcNNn8RLHSN0ljCcRPQKCMGypXyoS6hRG7nfnaAKfNJ41GClYAOrZ3nZ+P8jB13K
 32ZmjPL0ioWFz5s8oVhR2z/5LAZBdP3JbCLY3zJO7WglBD2nw4cHnzEBpbuNrDu4bH8c
 J+pveKlBFQYomf3nltlu86+lSqLBvPHKt5iK6sKF6fncdgqr1XsrzZqPQ67Lt2830NS8
 FAPQ4JLVaraQofv3U0iS3zhY8ct8n4sptxRb18zCp0iQMfu46D8sz0VVHxUP9YHMj0s+
 xAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393578; x=1756998378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=Q0FbNbVepEB4Wg3S+zp+R2cQa6qZbvVH79yzT+PDrB8+nFF43kAJW//SLJz3xoicrm
 Lh8bulDAy5DuXWkYgqM3ZNkrWLoM1xmKLh2qcInWWI20W80XwXL1V82pD+H8hcHN7b8a
 c/22q2P+xKZpCC+ewhv+uamKkHVRqXWMGgLwyEzFOXB7Vpg/M+K2GQCqUmqS5L4KKpq4
 +ZAiRz+rakty1XzVHo0wXKMr1WL9FYEohHLOn/bOoLeSfAnQX+2LA5SWFGYRXkQ75pRs
 wYtggaVXWdADbteU3d7jhM0B28f7gDcbH/pOQLUbxMKEa56Cwj8CvqCdm8DWeuYQJPuq
 0evQ==
X-Gm-Message-State: AOJu0YzEV4JR78Sg54HdoWWuWg5h7xcgruQsZRHujkOLdyo5ORhODhxO
 jx+eRJoG4rSw0v1m709mK4O0HX/2pMIzZt94Cztzi+cuhiDGXvhXG8YlNqETxeQ92wUKQ4kS6Yv
 Jq98bbgvfD3p06gQbpHVJ6RuvH5GmQF/zmKPCHTEVZQ==
X-Gm-Gg: ASbGnct8wJnuLWb/GadSINk8lRFpHJ3OgpNJXRfSH+Ph3qm3ajZ/ZaUF69tv0sFp994
 yKbsjIvnZn0yIklzqAjhoSQKlCs8Z4eA1AMJVQ+7r169rWnPGtVHSmULKRJacjyIwBBjoFUPnJT
 mD4AymPPNLAm6KRAko/MJvPimOm4Q4u1eEzGboLdkxRpw1K5HbUp1/cmhjd6x0VGqUE9QGR7Qse
 deeoI29682guIPrspc=
X-Google-Smtp-Source: AGHT+IEQU92ZZufOKf95F+A8YNAbYb+wU7v8f5hTFbNR1XvzmWhjZszyA43s7CvSfcWQ2iYtzWioneUgNyTzbhTbqqs=
X-Received: by 2002:a05:690c:fc2:b0:71f:ff0c:c95b with SMTP id
 00721157ae682-71fff0cf3b0mr222732717b3.14.1756393578498; Thu, 28 Aug 2025
 08:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-51-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:06:06 +0100
X-Gm-Features: Ac12FXxcUp9Ijpqb614-0GxWlnDVlq-3f3YksQ_gAX-hsZhuBa3kHdLFMogAE88
Message-ID: <CAFEAcA9J3U+D3n_VUx_NUjbhmzF=hVvtysxLa-YGq+Z73=LSKQ@mail.gmail.com>
Subject: Re: [PATCH v3 50/87] linux-user/ppc: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

