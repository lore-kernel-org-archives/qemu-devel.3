Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C8CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umu6B-0004TB-67; Fri, 15 Aug 2025 09:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umu69-0004SQ-LO
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:03:57 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umu68-0002Ek-18
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:03:57 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e933a69651dso185226276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755263034; x=1755867834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3PDrFiW1JgqJriyjH0NT1Rxeu4jC8cieQEXmK47arI=;
 b=qwyZnYMsZwPhxurgAE8f3clUVhmPHRZ8uoRdx8qim1ACR8mYVnr7chtNP3T4PY7xu2
 QOvo96kmA2n9wpOKHtqi95/ttUVoyCckYuSrVZnVSIVb9zGtEtwzdxAxPbtilRewgVnR
 X59TVuskRoj+MdRBQ1c8LFp0nljoaAbCsEA/Yhs6/t8XpDcEdufUdMJhkV9w0hfOuiLW
 BjfXmei5cNZ56bASPk4/7HxM5iJmRbVm0o2fE0IVd6tCxwRDov3R7kFHKZ2mYWD6LbFn
 ezPaVWOOGxeL0fAeswMmN1r2ragCDkMnGT2a7Fphq1IBSH/Ri82eTLqgWfmPnqqAHXnT
 r9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755263034; x=1755867834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3PDrFiW1JgqJriyjH0NT1Rxeu4jC8cieQEXmK47arI=;
 b=eeDWVL7smSn2Ww8oUWdHV9Yy5cKWN+ACINTWWanZqR4EPBjvUJV6bqONmJpXD1sQV9
 6aoHV+AvnzfYexzYgg0T8ulNkjTIE4Qk8+IPzByk1o50/TZUWrm2zQW5vg5oguIjSfqA
 LnKGWz4h2NzWAH6bh+yfGGI7fw/ExbqkniUqDDSrYgVLsz5Jvwl/18Tfaa2Qpcf0fvgl
 HSNMDIsUkLFxe73AuFPxwmOUts5qGgd0xJcdeO3kscwTO0JvmUwuPXOVtNjKLwOjePox
 nbMfo50i+0PX9WuaR8jVVhVgWvWB4BpYu9G4vA61ct5X6UicTgCvIgkCb/PCwl8GvykR
 yjVQ==
X-Gm-Message-State: AOJu0YwpfX6F4eh0AJ+3dRKcN3iNXTXLW5KiCWJRrswMk5aBaJpG1F6e
 hJwS9/l8y4rrVy/1Z48gjfi84opuPnfJ/KT0EwnHkjSErmJ2g4QsXNLrJIihfEEnr3U+b/I4Wj/
 KS3BfQNXeD/YWcoBUv1CkCFpNzL9n0l9rINQ8QCZccKx+I4hnfjHR
X-Gm-Gg: ASbGncskBHZZIYuwr4zEINmDs1/1qYBZoA83PvVDC3Rag76aEn1MCxEpTi2ASNkrpSK
 5oD22IPcKUpUMNOm1wPNUbsdKHCmmbmcEL2+rEpAJQI8D5zSQnUvt9E+bUephxP04VHh7Ptf+zY
 2ypmav7x6ylMZ1tauFlSa6lBb+Da/LVWx+gUrA1fyU5HJtbuRPeSbDcfORZ8e0dFl70EPBz0Yn7
 2RuD2udS55hwSzTHY4=
X-Google-Smtp-Source: AGHT+IFkfUve/8Ek/sb7rVwDY6v1lOCZH6hXV8OdVO6hY6o8lFFHqu7WMaqhBoeV+cMg2KMhBeagwPj5TMh19t5LQTY=
X-Received: by 2002:a05:6902:4787:b0:e93:1c73:d1d6 with SMTP id
 3f1490d57ef6-e933239e5admr2009955276.18.1755263034356; Fri, 15 Aug 2025
 06:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
In-Reply-To: <20250727074202.83141-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:03:42 +0100
X-Gm-Features: Ac12FXzlDwud-WX1t6DqHakMyIpFU2bEluhwmcOJ8BGfqljPRrBAGw7siKrpQbE
Message-ID: <CAFEAcA-Cm6rn6N+H=v1aaeDZBeJVUQQ2v3XDVsTu=PeLpc76QQ@mail.gmail.com>
Subject: Re: [PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Sun, 27 Jul 2025 at 08:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v9:
>   - Set bits in arm_hcrx_el2_eff has bits whose effective value
>     is 1 when EL2 is disabled.
>   - Include Pierrick's firmware updates.
>

Applied to target-arm.next for 10.2, thanks.

-- PMM

