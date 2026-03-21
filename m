Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3961094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w40MC-0004M3-CM; Sat, 21 Mar 2026 13:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w40MA-0004Ln-Ix
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:43:26 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w40M9-0007ym-6H
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:43:26 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ca423ad53so3180831d50.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 10:43:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774115003; cv=none;
 d=google.com; s=arc-20240605;
 b=LREGLYBnlxdR0m8s5hrRQgy959dNH+/Jjlvy9c+cy09LDsqvRFlJP2XBbYDK++RjoA
 nhv5juJbyVLOX3fl5rLgG8Z9AfnKthSPvzqcy+AeLTUKGVZ/6wj96cEazlz3ntxfWv8M
 0UMKOWpw4ZH9CeXzBLhRh9VK9VjV5AEaTh274SS4iXyM8s7CX2jDT+l70v1N6nJCCgZK
 s4jWC1xS/AioKUxVqN9//v8jYE6fj9qMlQoeTfPxJw7dGuq9j1GLgmXh00YlMvGzVCJH
 CyIt93parU9z56olbBPjK7/szlCtjKx/w8j/qH5xBz9o8UIM8x1xH5uw48XhF2P9zdQ1
 bUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qmXUe7LVSUldzbQOG31FdOGIYpvWSKMTVMcU3dYlpoY=;
 fh=LKm8SA9mUPlQVekpeFoPIxDgWCQ8iL0Atn5eXCmBJIY=;
 b=CKyp6KZ2RLiPobDkj69mPPtUXgQuZN5h+uMs+ALht0pUAQL2MoS95xbniSq8d/Ql7L
 gafLkTyZYN1Re/GRIc8vkmkpkdZRQON6zo51Dl4A2YLvwQRyff8q/PI/aH4sRZsSwvKF
 531FcxPer9EfFc8PCNk2mROK/OlqDEwDgzmQEtW+pGzdKnM7fTTySgrQYVk17qnhjby8
 rvoRKFKsdEVYcIbuOF6UhwEcK1x0FfgAM84oIofVZ47Ik6+e7QvTSeRMbAZG7I2gMht+
 JDaSA0YRUlhg//J1X23Ps1VHUr7iQEvCI+UGJMjXSfB8efkKTu3fSt/1VyRdQL60pqOO
 abpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774115003; x=1774719803; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qmXUe7LVSUldzbQOG31FdOGIYpvWSKMTVMcU3dYlpoY=;
 b=o+QNRwhqPP2uPgG/YxZFruxyJbuBXNoY5sZOwBG8em1h9XGto6FW/dtFnaLWhoaEX7
 S0TBhGxDWvMxNaFsQ/ngjOTgl5/XidXnmEc+jU8D7LhJ7HN/JMCTgM1LTBS5XPtyPsF2
 OiCYI7sFbdayHtHRtA4nOLfu2ZEu3RDGFl4ea5J1BP+ZbvutpK7bKLS9VrdResZz5ll4
 3VBVr9uakYkZ4K+dFdtyAylDv8lOTQPBCyjW6Cv5Kbd2YQoU8gjUWXic42XwntSPh215
 q5du648395rHo6UI25iHB6+TRz6mpPJiu7m2gQxCrfeReJCu2DGyh6JyIN90soNKSyYd
 q51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774115003; x=1774719803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmXUe7LVSUldzbQOG31FdOGIYpvWSKMTVMcU3dYlpoY=;
 b=grX2Zwmmk06TMzALfgmYFpmAqutTS9zIpYlh437dfsvPmbrLlSJqGRKKX/G5CTuNEi
 aEH7nSbKgN0YFUQmxvSIRfqIzk9cWJr6uVqx3RUfDNkvJfEd5U+oN5vI/rgAb2jnBm3U
 56bjRVngsVgIqPvVH/cM02zT31d+Xdcou/jOR1+TiOCD0V2ORqMFDmR6O1Uaru1Cos0C
 0TMl25GzqXEm8IW2OFGrLiYFcQZY3B3aDOmepE/OaGrttmcHqg1D5p055tMSgHFitIfO
 qNe60z9yHizp4UtL/q6bOi4DP/ueUOaaMRcBB48CdGw67c54Y9XCBIAoe2UY7d2o1it5
 P1VA==
X-Gm-Message-State: AOJu0YxNk6m6ILU2vZ494FUMJWma4nV0pko8VBmEDD7+zXe1urDk/wG2
 6K4DfAq4sPprevH250stNxWC18aNx6WiTffUzd5plgfGCY0K0H50DfEszTOwOQU2Z5PLDWSnpqd
 jEHF2UdLaBG9ajAZFphQB7Z0N55X1zo766pfoHkrlEg==
X-Gm-Gg: ATEYQzxOV3REbTfMLcH3XJUK6MO0nvTRXS16QROaZFRpKWUaBgm5YdeZph2o4QsseAW
 30uDGO1FHRXK4TTQsfxLRE1hfx14IU23732BKXuCP1J/1wCni3iBo7xzt79kXZH6hWr4dLr5IXV
 E6lk9jbRitIxShSr8I6JQJiBWKleT4B66HL2sVxMN/rTo4OjUQPtpGkyl9riX07g0igagE3mmrt
 GbDAAF4/tYKYITWgEQSr9YlLkG9ZEC27nuW9WtG+Bb1H9ukMJk2dZuu/FFUtkmVlBY5smy66LOf
 zp5p8LtlCtyrNS774eQE/Dfn5DQ42F5tFqtAft3lgTp2jd8jE5rDhNznYW2bD6fjVFY=
X-Received: by 2002:a05:690e:e25:b0:64e:a861:6111 with SMTP id
 956f58d0204a3-64eaa78b414mr5587507d50.51.1774115003540; Sat, 21 Mar 2026
 10:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260321000444.909451-1-qguanni@gmail.com>
In-Reply-To: <20260321000444.909451-1-qguanni@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2026 17:43:12 +0000
X-Gm-Features: AaiRm52jpBW6qCGqlV9MMZH4vqpkZvrwXgid5RUrf2gz6X4tbE6eDdgfAXJvX4I
Message-ID: <CAFEAcA-=2KeZHo+jWc9+U99QHdyM0z2YS0OZZCDGXY9jhXBtjA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mcascell@redhat.com, 
 qemu-security@nongnu.org
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

On Sat, 21 Mar 2026 at 00:04, Jenny Guanni Qu <qguanni@gmail.com> wrote:
>
> When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
> ohci_service_td() transfers 0 bytes per iteration. The Transfer
> Descriptor never completes because CBP never advances toward BE,
> causing ohci_service_ed_list() to loop indefinitely and hang QEMU.
>
> Add a check for MPS==0 after extracting the field from ED flags.
> If MPS is zero, call ohci_die() to reset the controller and return
> an error, preventing the infinite loop.
>
> Fixes: CVE-2026-3890
> Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

