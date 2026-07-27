Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E7C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHnL-0003wQ-Sp; Mon, 27 Jul 2026 05:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHnK-0003wE-HX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:38:46 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHnI-0003fX-VR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:38:46 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664a09bc459so2986694d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145124; cv=none;
 d=google.com; s=arc-20260327;
 b=nx0ru4FLheCf5nw/3Txsc4WjoaVvWeKBbSO7phyA+jUwiKIs98xo60GMpZAfZNe0cR
 M9LR905d8c0oy6kjsaAB41aP7YAKdaqqRtn/5wYmjBv29bmS4s0pa2Y/yOKjmHXm1Ky7
 4LttmnpU83KsH+Q05OXceVe2v83RPN0qiZSuBF3fuX82fA8MkePro3QGFfDBVXMJfO6G
 LcaDwotiazU7G5SGMx9Gm5SfQnsfohjog85+eSu97zF6QpMQiRF7rKDLwh1mAGeJPcWc
 gtv3KMTDASn0epJ1D9Hu0p5apZWHdtLQAJZIx1mtw/Rcc+ckizewoNRMP6rBJyieGXdZ
 l81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jcyPDsA3/Jpo6SS8INy0z3VSGqWL3xEGS3/QtqDFLqQ=;
 fh=ns1eua24zC30J2klOKMkH/VZ1UXy0fV6hkSq8hW1g9k=;
 b=M0zfEehZ5TQM3M9HaihMd1/+CmHmWq1ZQq4VXLDnyAzF646EAinLqIkRLT3AFRHQDe
 1kwc0C8H0SXWX2tDRzzetkyjQuzOW6visM/HUH6R3bcJSAPeRRKcOU0zSNxMXKWHi263
 ll5eRAU43uItuSljlvhy3n+j7W3TCJ9VwPrx2dObiyBSyxyawOvMj3PorRnAQ25Rgr0H
 GnAjMby9WLBjRM7Fj9IeuyAMm8nlocv9GzLKbJbjnEQEuOjE2wxKrqaRBxfjCE7btLB1
 VkYhe4zCPFczfuG3ElfdjgYdRqa9w3W+0oI2pu9QjbcWqBS4WHeEqpAkmZzoKjkXyZOv
 yo1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785145124; x=1785749924; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jcyPDsA3/Jpo6SS8INy0z3VSGqWL3xEGS3/QtqDFLqQ=;
 b=McBkTmkLRSa30iMKTPBHLKrfQEcrR8A9TO0BXpQoPnYRrVuSO6SBIc3OeX++RLMuGD
 BwseY1Aj46GJjQR3YE4V2DcjGkces4kEoU8iHzOttGHWj2bx5n+vJuixkr7wZjtJywjI
 wZsCeScUBgGNVy7XzGOxt/T1v4zqIyylpcPIIqHlgLMxuGVW5G6kjwT+Mvib52X666XF
 HFlriemVSTT+ZEIICx93LI0KTSXFB/Hx5f7D1IRfQCBSUpHKtX0wxX7IT163hqcsW7C1
 DQYwYdsiPDHqx/V6k/oGlLZBW6zTGEFSmHc1CDJQRnB/e8+5PTy8pN9oGKyEvtpX/PqP
 m23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785145124; x=1785749924;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jcyPDsA3/Jpo6SS8INy0z3VSGqWL3xEGS3/QtqDFLqQ=;
 b=cmcdP/BEjSXvHL/YVe6p/7ka1ZSO7Xc2NsbL/g5x0avAhEuj53XDBPrdiCJ8ENbBaU
 hNC+gZuQhOXw9H+nrtoM8W+Ph7Y7mY1c5vAmNspkDr6JQbxRxBsiwbaGtBog4+rahCCo
 YCSDFmXHA8T/vPOwvL7YBLvg+q8GS+v1F2piFaXLlxX72yMr7eDJjJyijjqiGO1n4E5n
 WrHEKuQPK7jVU9duUrjx8/yZnTQdh6aK2YEVWAFH86b+x+lJ9IG85tyPAqezs4+7l9jg
 zJ2wNn4a6Dx8/m3QeXrDf+ZRq8FB4JLl5wwUqSR1Od4rxQsB9shQSZY7xH4NdlnmcpsT
 1Wpg==
X-Gm-Message-State: AOJu0YxanNfUkCmc0qJILXs2ao3dl+ZVhIsA8xG7MI5D5rVuKMEbC7h0
 DvjylgJ8h8YavZzSDLOwZV3rqSQf1NCX8nFQS/82qtaq6h0bVYBdfgZ0WfDXSVX2kWEYchqnX3o
 zg7O6eiFv5VwTcw9IMSymFNT6FLfNTz07i7lha4G0aw==
X-Gm-Gg: AR+sD10l2rR6mLQ0sAzo1NdhCiXzo2C2RRhtWLPw4X7b6ORVHMT/c2P9iC0m8I2IRVU
 NWfYOSNx31BZ4INBvSe0ejZKowD35/Y7t7dy2bXww7CSze7JTSo/5Td/qZCRPSfVrs/t7ULReQH
 5HItU6Q8K8GyX0K+Uf7SoDFyFXtdbVS0HWoFwqzR5mgy7Zl8DRED2ppJ7/CsyMbBAJaKyqpOqGH
 BwbGNR64nJOYkQMebon4LCPbG7GbQ0+Xtt2TsvwFZWWZ4Vzm7Vfw8/tQKDUlu56pelsReWdzDIf
 BIf5Hwltyzn/aRs2k1H6QIzjk+EQTJTYlx+Q0ZyG5VCHDw==
X-Received: by 2002:a05:690e:812:10b0:667:b4e5:2ea6 with SMTP id
 956f58d0204a3-668c78db2e6mr1587889d50.36.1785145123752; Mon, 27 Jul 2026
 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260723070059.6332-1-shentey@gmail.com>
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:38:30 +0100
X-Gm-Features: AUfX_mwMzf4Hau-O8A_cHL5OC5AiMtuM18RWaKQIR6UgmXdlR065vA-1LLQUHDU
Message-ID: <CAFEAcA8wqECZpAieijGu4bwNv_B+uObT4-NCy9q1HmmPFmr=+g@mail.gmail.com>
Subject: Re: [PATCH 0/9] FlexCAN fixes for-11.1
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 23 Jul 2026 at 08:27, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series attempts to fix the Coveriy issues pointed out by Peter in the
> FlexCAN emulation [1]. In addition, it fixes some reset masks to preserve
> register contents across resets as intended. It also fixes some register
> offsets due to a union being inadvertantly too large; this would affect
> migration if addressed after the release. Last but not least it eliminates an
> unneeded union.
>
> Testing done:
> * `make check`
> * Run `cangen` and `candump` on the host and guest in both directions
>
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7Eqg1CzyKTfaA@mail.gmail.com/
>

Thanks for fixing these; applied to target-arm.next.

-- PMM

