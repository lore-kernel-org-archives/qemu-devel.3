Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF2AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6B8-00029N-V9; Fri, 26 Jun 2026 09:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd69a-00019P-MH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:59:33 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd69Y-0000xa-3q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:59:29 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-662dc387b7aso1127851d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478767; cv=none;
 d=google.com; s=arc-20260327;
 b=scG3Te1eoiS55aDqRggYhNT56VfhMbxWqo/6b3bpFpFS2hcoC/P3PgIJvOfYir6xZb
 SOgo2ZaEQcMprU9QzK6k3bFsbvJvMPrODRwpOsYzCSbLsbO34qG4nT6g0WNnhMmE8d5D
 NziB32T3eemAPTygZffuVbGJcGXwEgMV8duDK1SHbHuJsEDbK/DT8TWRvhgyP1WUN5ak
 k+7TAuWZZ+iOMcr1LpFn6u6N3qAPRTre3592XBAlLtlACp9NcpvcxWge9D/gQYJ8uwHi
 bBfleyX0n/nFfsrkfbn/HADdy0GmJraEmMZh6XQZiEv35anBYxd+/8KFkMLUVWIM4yg3
 eE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=n8N2DHMQYdaR9zpg4AS9+0JJ2Ev3dE2+zP7zGvQFS9LodlYlKlgDnXWl17FIMSArYn
 V4Au5H2KrQDMfMVnIeWjJU5J6OaN0d4Kk+kddIApftkRSe+l2CExDA0/l5A7jB7rGIav
 NOIDA8AqKxqQAWg6MsfXo1gIuiiiuIDB8WM1F70SUpVk99b27Qqqi3hoxd+X2YMSnYaJ
 CMxQQGiYdS8PZuHsFtUTF4+HSzjfLfVbyZvf7b17s7r8F3/cn6xnEO8U02dc7hvPnfy/
 GGqhdu9S/NYEyrwa09DxddI++J0opFA5edDGKT2WSM/Feo/z4vHv8KksfCvu/g/wy+v4
 lBVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478767; x=1783083567; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=hz8yJyqgtIg0wQlJ6zHEplek1ZdVZ4pHn1Knx57aBabxKsCo6oZN8OANheq0akynWs
 dBAVjZW5lmwSC1Xn0CanUdN624qm6ixhqeBqqm+52ns5OL1BlXI5Ul6ZD10lw9M4jowA
 Uxbr/PI/ci7pzSMwgqqv6S9ukZ8fIKmOdSzigtGFG4GVMFsfgKa1jq27HAG9QIrpN37H
 X/UO8f/TXEvpA1zuzlXeMUCUfy0zcv0fRatRgyfm9PoqniaBHFreX70B1Uu9huNU96Ha
 BgaJjY63pUSAfuMKpqo4foGJMU+alSHsf7sjnBkSa8b3TbYbJWL1g8b+s1uEiFpeMiFT
 Zw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478767; x=1783083567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=hcr0FJVLsiq25cH5pinynFuSPV3P9SnRV2cSxN2SQqynM2f0kV36k7o84eH2wugTAk
 YjM15aLKjNXVYP4sV1oXk9OQPjErMfkUn/gH9Buc1oluuT4zxdVjNVSyHo1FMEg0t2hX
 /Dt14QmwwLYr/Zet6SYLCBhRDGUciWBiaYdXapnyDp6RB9OHgQF6NhuUub8LgwowOfXS
 hJvL3+l7PvibvTsdZ6Cxu/XcBs/BSOtWnC8uYIWB06SgrsRE3quh1+IO0s3csPo5ijbh
 LS6bKJn/QBp/9z54uY56tdGeQVSj4jDR1nVsR8lycWxWbAoyl0aHhjFEZhworYW6+5Vw
 fXuw==
X-Gm-Message-State: AOJu0YzhuQGC2tNHxM3i8NDMRDhGSpfUds1I0xbm5cTxTYYBgiFCt288
 iaKbHxd6geF38B3DBSJbLQ9o8bAPgCHZCbfYhhewluzQM7IJkW6FQkR/X+kIfYKiQfhYpgA3YFt
 tmaBPA6B56n7vFbuQ8GDeY07k9btI+k5hSMeCZ2juolavyq6Pj/IDsKsuwd2k
X-Gm-Gg: AfdE7cmgyHJGe/kuBXx3aEcXidDt/WDFtbbWZCTGUymCBJIblXiUAsEgeSmA9nQuhZu
 SEZ3DWHVzYe2+D2a0vlg+xoqTS5jQcu5CThxxzAGTHM+6s1Z/YGdgwzLsmVNcpz8Yf43iVngDEV
 RMX6yUx5UzwBLFim+cKtG0+QWcbMIvhgAUqBNrFIgyfwlTLND3TfBHvFHxjAnOgB7K4+MQt2ovk
 koe/m1vBxljRrb1s13TZVz68Cn687VpH1PBlaP64OepEIBtE1hOMdTDoPwl94N7TPCXzM5F3VZu
 /Sei545Y7ACVUsvAbA4KBqpgMLIbAo8+VTT1d+TTn8OK/b5XI4hWsoGT
X-Received: by 2002:a53:ac9c:0:b0:660:36a3:b23 with SMTP id
 956f58d0204a3-66487cb1a7emr5369635d50.21.1782478767090; Fri, 26 Jun 2026
 05:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-2-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:59:15 +0100
X-Gm-Features: AVVi8CfrDJphaSmvzZ0eHXt4XtBQ6fwnjslSQcdVgNO7YKMJv7m-hBsF9c3OQGI
Message-ID: <CAFEAcA8rCUy3S7AtqRHh5BkqeFAWai1odN-VMfLOLJ=rsb9hAQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] target/arm: Implement FMOP4 (non-widening) for
 float32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 25 Jun 2026 at 23:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

