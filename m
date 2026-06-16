Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F8ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQlE-0000iT-Av; Tue, 16 Jun 2026 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQl5-0000ZY-LK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:11:04 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQl3-0004c9-VQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:11:03 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6603246b66dso4621753d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781604660; cv=none;
 d=google.com; s=arc-20240605;
 b=GHpVg5NGKtyMSqSoTd9eQVSwQOTEBs/nvDle9mda+AzF3AFq5g/wP7NCiUNa/A8SQg
 +nEAVT5afaj4cZ6vSUxebPTdv03thbJpu9u0GeLDn5dhw4U6n/xGKSkbazLAyfmn9Of4
 x2wn+Yb31/eAQbddHXyVUIDlqb580tHGsLiNSh1te/beMYc/1nVGUrjvuyU2PBWizTUJ
 p9wl4uRBCt7rA1uM+swVgWyP/pSQcCCTneHueC8/QRq/oMQJ/qLV27/P+mSJnmYWs9GN
 vS7V7D70yszKial78gbUn6XS3tozSy9P/O9HCBqIaNt2EpdMHY0N2K8oevTsyukPlToK
 Ya6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HGgDdY6l643Rx8ZP1e8GqXoXTcmW8b2a6xoyCwC1PhU=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=X8VNE5VEbg89xNltaGr8CaLS6KLLBEkUBZLuI8pNkdgbz1ctIkr1q9LtSj/tYkAG90
 XbyKAvijPkug3I2W3d/KyL5LoAl7vjkmCgTaMQ0SgYMkkjUfpFkYv6MG2FSgpb9cXa2b
 T3BGPXNqtgj6gMJuWTP3cA0NBGMCq2NPznd+ksRAxoMKm3eVA1NiVp9MBrfhjKp32nHg
 +2fLzEZhBjk0cGX59vdW4AmC5yw8whXCWRfeia2gVEHSbyo4KnIQdHaHC3XLrqN5MG8P
 53ULSfTTB41jwPHdbqoAZDRDfkBp71UZvc8xpF2CEdSoV3C194q0Q1GneYwpexe4CN00
 ZxIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781604660; x=1782209460; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGgDdY6l643Rx8ZP1e8GqXoXTcmW8b2a6xoyCwC1PhU=;
 b=hch7LdEM1LoFFUsvG73czamuf3MM+ep6VdTHVmRb70tIPu59lSXuWCJKz33Xkas0Gm
 FMKC8DG8ZGSCY9XURrXltCf069tSO2BTZs/o4qAZvWn/zir3vadjhRO1oAU+sCeQf4tb
 L5uaody5GraKOQimvqgpKZDt7CsYAaOZhfvRkWrpK4NcNLHQBT9kj9IdTdbPQ8gwqDrm
 Uh9JUTzPl/iJ1VWKTursINzVXxAIhycb4c2Pd7QU5OofB1iDEVFaXZ9U9D8z90kCAWOH
 A9AHetvbeasnzJS2l4c7q8QA/vva3yjm3i72R3MOGEEtV/zRw42C82xf/SRvzftdUFs2
 bmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604660; x=1782209460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGgDdY6l643Rx8ZP1e8GqXoXTcmW8b2a6xoyCwC1PhU=;
 b=TbWj7k6QLvfNPTm9Lvp6q3unb1YsDVnvsbGUNPnDI/nNfsUUnBm7d3kHAwrmWinSne
 SgilteJ3WfTlT+dgDZWEfCLNpWAPZrY0JUM5iDAj213fhk2Liln0pq1yIgAH3AdS1aAh
 lpgI+1TfosR71No1ey6ne1KW3O117SHyvjVnVX3Bky4ajxW+0S75U66B4jNw06Dgrde+
 vkr6bktrJEdgw065D8bWWnu8+HDCsgOzMe2yAsHzrW4qgWWfRcVyFEA9/aOQw5UGelmm
 eadqpgiiL3xDWnD4bGmwRZxVLTl2+DDfnjrccIXt5wyl1WsL3PtbbRGODTxSp9+wC2E2
 jTaQ==
X-Gm-Message-State: AOJu0YwN1jpoBNzO66mvO7Vzd9GQp+dFMFyno7UCNHRYzfHcQRhSkqM0
 Re1EghqL9+7TrIDqx4Knpk8Vd2sQWQrf86Ru+A/8SpYCB7OrG5EfVNomNHxq2EehwfkA7So3yyC
 e+4I1yct9/FZqSW9vz97ULc3IAc913n/qFQC5G0VeqiLFyxiOnmNrHK8=
X-Gm-Gg: Acq92OFZiBTvRxZRrMUhm2ZxCmit6eiDl6dIuANXLbekQ/GVlk09wlj3Gkpg1l7yq8T
 kPgD38r0fiM+TvQ5W4HmoLypHdM7W3Lz/IaQsBhpdOx6zpzrAa+EoC61tv9HsJEsN/kKuwuaVUB
 oKeWuZkqLAdJOnKSSrG2FlwmqQJJT8Ksq3oON0cAdT0avntZKSK/Z1O1om3NV5EgsYCw3SBsDZ1
 Bpsb+60ZmYSaqeeWnBQSXqR0BHOgbrA7cseIo6oWbEbB+HuhmvUpvxmqSsrxPelrXfVE8ajdxXV
 DVXMFkJPoOdkiGCcpI7WVP+JSJArzn4/ImjE6QvvQh5+6UAT4sPaGYptGF4HogbCcig=
X-Received: by 2002:a53:a64d:0:b0:660:4538:232f with SMTP id
 956f58d0204a3-662b61b7b1emr1704257d50.62.1781604660330; Tue, 16 Jun 2026
 03:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-7-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-7-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:10:46 +0100
X-Gm-Features: AVVi8CfsXLHO3w91S8Nmz8Qh4yzvapP6Z9h713rS8Hj3cTpQ50ZaLwkB46SDrKY
Message-ID: <CAFEAcA8QBV9gXh2D_Uj5_z9PnXd6PP99Tya0zthoRmyY53efDw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>

I reviewed this patch last time, and it essentially hasn't changed.
Please carry across Reviewed-by: tags from previous patchsets
as per our process:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

