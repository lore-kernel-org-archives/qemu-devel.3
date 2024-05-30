Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0B2C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfuH-0005wf-NM; Thu, 30 May 2024 09:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfuG-0005wO-J8
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:33:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfuE-0002mH-SX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:33:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-354dfe54738so531004f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075999; x=1717680799; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sHQcHcTfrqAXq+7Flj0AiZY10B2igqvVhyJFVA7mYJ0=;
 b=y/yPIr4fKnI+MpzpOIatSO6UmqDEQ5TxeMe5qKU5EEA1sT2teBkY35f/T74tkb+NHa
 53VqYsUsV6DF0yB1oZMp8iHQM2jF4p6LDcdcIGpZlVDMTs6NZ+EsmfqYkf4uc7YUPcxm
 tmh4AN6oPlHCgYTGtFOiJnffSmhdWiRLm0P1y6PFztoYojjHVbY9ZbrgPzOEQQ8p1DY7
 mli6ztVlpsb/1o3sxkuCDCVqdngJh9lWNGxOi23GCmlC/qLexVloKLZdRaTunaLXgtvG
 1IYnOPf9LlpLpLcnEeXX8vrqN+eFGd3seAiQCt5PHZBA2dRYxbStgouKrsDKKXBeCvo4
 Jd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075999; x=1717680799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHQcHcTfrqAXq+7Flj0AiZY10B2igqvVhyJFVA7mYJ0=;
 b=Li1i4it3LKkrVs54C9wwb4aV7iFdfrhVP3KXDifVpcEiU98/qs+8njgWGM84hjWvvA
 s3FB0qi1r1wjY/Bjiy43LcPYZ34PcpPEUgJtjPAQ672/56YANfNsKNhOmtCbCD1pbJmI
 mjpdtnSm8xY6r42bp9sheRvhqVsCbCptIGPDU73MMh+MtRn7s10SqIzYAIqhPPA8A2QF
 yJmrnN4wWXaywBQmwz1/gPqGYqtoWCNJDYaJ7Vb8BKluHW0I4GJPcxKxnykqAg8JWOiW
 LZie2ugVmn1LZyYe4PudEzz97YLBgNI5p9wbJgf0aLTePAC7dbkSftxUA8F479oqv5jB
 mhpQ==
X-Gm-Message-State: AOJu0YzDrhI7yQ0HH/ipP65LQeoR+SCfwJO+PKitU/cGSEwoEGHv4UqZ
 y1sC6lGA4+hzSMz1P17JQZ0aEEn1BhU62DEEItova0hDfotz+cbsrsmT9e5nxMSUlqN82QTiYfG
 0KrKaMXK9c1AP4WbezR2U8eYluO6PpCPGrQmW/n8t/pHBD/I6
X-Google-Smtp-Source: AGHT+IGpkm11BYAHn/w8S4e4QR35RBRPvozRrUG6wPN0PMB/je6nuxPnFYgtL/pINJhfq6PsPAExpYzLM/EjEnEl57c=
X-Received: by 2002:adf:f145:0:b0:359:6f2a:3912 with SMTP id
 ffacd0b85a97d-35dc0090d06mr1328019f8f.18.1717075998875; Thu, 30 May 2024
 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240529173625.800102-1-richard.henderson@linaro.org>
In-Reply-To: <20240529173625.800102-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:33:07 +0100
Message-ID: <CAFEAcA-eB2YA2ecyyb7GHJuc+xDxnpwzxQ+HMYhCSQx5n5KPbg@mail.gmail.com>
Subject: Re: [PATCH RISU] risugen/arm: Refine prefetch and memory hintspace
 patterns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 at 18:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Avoid prefetch patterns that are UNPREDICTABLE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Applied to risu git, thanks.

-- PMM

