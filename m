Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85771CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kbr-0004Qj-6x; Fri, 17 Oct 2025 09:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kbV-0004Iz-Q8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:34:50 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kbO-000090-Sm
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:34:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63b710f276fso2280241d50.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760708072; x=1761312872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zU23yWGtSetwuWLS5SAyqN+GewwgZYsp4hXqLSA2xTQ=;
 b=MGMHqj0JoftpTZ5BhBKoiJFLv47A2ffNJfJsANoljYtTFCLmE1KBVIKDt/rHKH6BQo
 z6vtamKtZKN7wUEY3XRCNNKy6x4gvdar7Z4Qvx97+1T+4ThsHKbY0J64kqVxDaWL3bYe
 MuQAlD5g6KcxZ/S4lm9j/cCiUZHCmxdN8YbTtLQQ/s+X30qGB7tlko3BycTlaj3ikC2v
 FVBPolYNNc5JdmO1Ozv7j+C4NiL0INNjdTcMJSoXD9CTB4w+xLJDkwd+ChPVgfH+adPI
 Sy0mVxuZCQc30B9RH1mqeKBPn2PCPo7lnY5h1OPKZN5Iy70IIKaDFfnixW8VE7w8uWYR
 /j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760708072; x=1761312872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zU23yWGtSetwuWLS5SAyqN+GewwgZYsp4hXqLSA2xTQ=;
 b=FWc7Wbdq3IkueANysQq7Svj4E0+A48iLU8TWbTPRCml3KSX2GzltE6nww93NQeXO8n
 ZczoUEwNZnwW51EiqmUZsj9YyMuSuen452wPpalRsLj4I43MhnHfb3L0Dt/kzhc52lwD
 PE6RbF5KOJMbYu98fnr14kBmIVSBCpZSvV8LBR+VjG/1BBQu63WQLTK78QnvKehNO1/2
 BR4IABqvlj7IL4T1zMQSkVWy8XIklMIRnCaGU6xCtoNDG47YbzfnNVT5VkiBSHTi0pev
 3c1MAmiDyVLNPuTQgi9RM81ZjD1Lxk/XY6qJm+odPF7wXUKHLZvUSh3F0TRZFLTz6vFE
 m6hQ==
X-Gm-Message-State: AOJu0YyNKedPILQ57nPR6QCXV7S43dQE8cH09SjB289ysQfGCNwgWt4X
 gWJPVtDqEsuluhWlBGXef4TmbxeEc+pRMkHTHIBnb/JINK7Fp8z/tR8C2eZu7olKDKhqbW/1KNl
 EXIgdns5H8uPsFqA8lHaJksAhgf2cdwSJzOvm3qZyRg==
X-Gm-Gg: ASbGncvkXRqYMeUKPIPyjmhmd6YZ+kimjeHyXe5FeqIrfD5NDKM1wal02CB23OawNgw
 wSQvSqBOM4u6cC8Xp3CpcLpEMNtVXb6peKSUdmKbm4yBOZV2QjU7fDsYNsG5zSAEeJ+GeYuK/JT
 mtLMmRxlD17XMBlcLwTP8yz0xZSyJd99ykpH3KFhX32IYC8gVjyGU1me/0tyPOP7DfjIZeC4Iyc
 lFP2hItAzvgoRg4VesA6v14tdcvgv/SC7RWO1ETd4wDNHEQBXDAiuKcsJWIWg==
X-Google-Smtp-Source: AGHT+IHNj6Hn16xb/wtZGMMzSy61F2WVi+0rR/OZMYChgRQ/dXTByA1NI4KKESVUjB6oxsMM2gb+Qq5FMeHXntmGGsE=
X-Received: by 2002:a05:690e:4182:b0:632:5ba8:1bb5 with SMTP id
 956f58d0204a3-63e161395c5mr3448885d50.21.1760708072371; Fri, 17 Oct 2025
 06:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-12-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:34:20 +0100
X-Gm-Features: AS18NWBs8X9ldjDYHkAX24-dX5s7TD8iVpA1kJ2Ohte3MQtLfk26shTo3wJHFec
Message-ID: <CAFEAcA9VbjnWPV+WmtHPc+H46aW96Yq3VQEBwzKzOzqA5M1xrg@mail.gmail.com>
Subject: Re: [PATCH v2 11/37] target/arm: Handle ARM_CP_128BIT in cpu reset
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

