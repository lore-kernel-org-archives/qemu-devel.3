Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E73CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmXz-0005bi-50; Thu, 10 Jul 2025 04:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmXx-0005Zm-HW
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:22:25 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmXv-0002QK-Mj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:22:25 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70a57a8ffc3so7725047b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752135742; x=1752740542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEqZz8BlLVx9r6HIZW52DsJTCiDLkyLpkLEUXH6sENg=;
 b=iF4J4jSwZA3uwoQ1a5agUKaxpJ/t81CNnnUPWhB7ZrkaYXpPyrZlKbDNgOgNxkgHXK
 CyVMmYHOhqAZ6rB7RM+h1nW6jEhYmVErvbYvRWjeR/ggpCPzdPpsCUyRF9r+0pd3j1Ac
 QmFb4ESBBFQ8lQ2vq+CCKNfZMCm7iHa+cb31ZZtIKLExxp3LtGWnZVdMn1X4vnoQDULG
 Jt8tA4YqBhrqf/n/PWls9oguhZsQxHQFDefdlAv7xgscKbpWQSdnYRKIz/KG4oJW+ZW9
 eCqtfWTq+MPkYzfSYVfor/qQvkA0Mo57pvFy35PEadOvRMaDwccR0xYC7ZqHYMUR3tA3
 Kx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752135742; x=1752740542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEqZz8BlLVx9r6HIZW52DsJTCiDLkyLpkLEUXH6sENg=;
 b=khyi7RE2NupG2WdcjqTYiOj6sGt6+C+KTy0Qjk1HPIFmcMUY1jFmoFD7avcNHqvIsh
 YJ7ZaF62xNZFkslWzzQsKWFcU/KOq6B1SeU2mqpyxq0Bh2Vib/ybmgB27/Rm4YoNXt30
 U73IpsZhTMvOinr8vfvyWyDcZEQ5lP5weC1I3Bbm52nuSM2ovs8IdL+CN0XfsCX9RalB
 Vn9hQYWRFVUn+oKHlahWETNbPbRmL6DxnyQnn7hSYyfRDhf3GWn4xwmhuNmu1mRCJtdZ
 OxBR8ujIlBWGJYUIvt3sPpp5N4mifPrsjbKBM/apnK22P2uO0n7N/mBBmY7aF3hFgvuY
 a5Xw==
X-Gm-Message-State: AOJu0Yw91f6DpFFZM6rrMkpL5sg30Ujc8anRsxZGKa7IcIorMbYiaXhw
 YDYFdLGCXP5F8gp5Av2ORaZWbtdRNPZgWym9/q+1HlNXCiIdVKaDXYSBjKmdP16V0N7/eaLlIlC
 jupRpYBCvCJB/iOafLxL0zOefcEe6b1K+duyL1p/WbA==
X-Gm-Gg: ASbGncs1I5uzrQQGlI3+A/OsM8mDEApcB39GhrVWez4mrQ6rwQCnMdb2z1G504L52pg
 a2cDQDnQK6oAhbMlLIBgVe53GHU9sWBfc0w5S615sCOadBUOmnCduOuw+kXyUq+AReLd87Og2XU
 9XLRQ9pbnx2cVtN4AW1Izu11Le0xYKJXeH4rZA0APki9jD
X-Google-Smtp-Source: AGHT+IEl5Wtsu+1Q0B0JDwucu5ZlYHlCbZGI0aO6uQ1gBg5KqSsEPQkhTp+/TtROZXcCwlXGRHhi1tvepX9o2hG0t84=
X-Received: by 2002:a05:690c:fc9:b0:710:ee42:5c37 with SMTP id
 00721157ae682-717c172bebcmr39198157b3.17.1752135741741; Thu, 10 Jul 2025
 01:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250707151547.196393-1-richard.henderson@linaro.org>
In-Reply-To: <20250707151547.196393-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 09:22:10 +0100
X-Gm-Features: Ac12FXx_2JwfJn6yJuQE3QALvAqMWwGhV689-MiggewaYC_KNbLYiuK1VOESiTk
Message-ID: <CAFEAcA9DZxDfO21cdDf4Sz1OhWSDbZ3gUNPAkiWQJEYQD6fTiA@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Split out AT and PMU cpregs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 7 Jul 2025 at 16:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than the wholesale movement of cpregs out of helper.c, split
> out two subsets: address translation and performance monitoring.
>
>
> r~
>
>
> Richard Henderson (3):
>   target/arm: Drop stub for define_tlb_insn_regs
>   target/arm: Split out AT insns to tcg/cpregs-at.c
>   target/arm: Split out performance monitor regs to cpregs-pmu.c
>



Applied to target-arm.next, thanks.

-- PMM

