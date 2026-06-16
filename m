Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F546CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTg0-000231-W9; Tue, 16 Jun 2026 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTg0-00022d-5Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:18:00 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTfy-0003Je-NC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:17:59 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-662bb8b1f93so566569d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781615877; cv=none;
 d=google.com; s=arc-20240605;
 b=UyQmCPR2vvBcid6imjc298uOtIVJuty+9KqnKmLktVHHxoeAdNHJ4m3XZbkntvFB/w
 3thDiR9J1ZCCiteoUZKYbO9IzRiEH7NpptJxCl4WsZzZwPwTfdTrx466cjaRutSyvrof
 nEB8i9Ag2nH349vQ4GtTp7ZWlbs7lKrUgsMmIzYMPIS+wOPSEQYaXcUWn3Q6ILrWDayv
 7idXILf+sAlTHUSMowiscyn05Smjdf9ZTZ1A2jh81a+Z0OlB2sV8ndSM0WB27JoWTOMS
 YvSZ7i7s4dytP5eC5HLdZOJ/mZkT1BRDyBViO3tsBHu0Enhyo4vHmPxLpIhVzS+yPl/r
 CLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xgln+4eZtdOVW8GLr2c4M7v5K66yf/zJeHmKKqaT2NI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=hKvAbOFhasadv6Yf9feGPCkDdaStWvOh0HI8sHSKUc5rrKT7+CVnZNS1Od+tDC+38b
 R47uohTdjIUnPTtErJJcYt4C//Rw1utjEc7Q1qYdZlWO0y18vQHi8S4IkZO4Ydhznv6A
 KiantZnEwKhNtMOeKvDE3nWjZh53Sw9TCsF8yNUI4xeLHbaXFdVbCVjrK0GrpQeRdVhG
 FJ+nlpl6aeofEqwo/HPVsfbChFspkL9XUFtZPZf/q79VNXWFE034UsRYJXrD7Jn6qLmK
 a4PyXPOw1drtHP50gXX4EJjGbIImT0h5lDYszu2W2kcxBwfCxb00lCv+iDZHz7LyRSbH
 SbyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781615877; x=1782220677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xgln+4eZtdOVW8GLr2c4M7v5K66yf/zJeHmKKqaT2NI=;
 b=jXda83GBEnAxxlUURM3L0jszcNgBxwJzUo7PZIwvpv7Fa0WT66/d1UMuCtgwSFt1RP
 GwSZXvL3A0IYTLkA5vXc4PPpheHMAwgpRX2wZngUNS4wQuqavHZjFYZhYwbfMVn6muh4
 rCSV/IlYRNjYmJ8MWdDhR+Ca+X4jdsfDiAgKIhAKoMBUYbT260/mbFm1649VR1vdO8T5
 ChMQBvUh2M4ErodAm91I2O8/v2/PiifYDoAkxNwqOskDL0JxYJlVuFr5m9hbqi6i6s6q
 Lurn4ICPgrQGGIqXLed9/QQds1Nw5XUlroHWChHVmurlSeWAinQfB06nn9WMZzn1mlUR
 mMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781615877; x=1782220677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xgln+4eZtdOVW8GLr2c4M7v5K66yf/zJeHmKKqaT2NI=;
 b=lUeJaUHKbvyVS1SVWr7MC8R8timrSfzfQ1tOQMlJ5q6coW8+dMQdOF7S1SpskhYse8
 PrCs/8DbGXTo/g+b0TGJ2y92zZ5GFnRhh2KhK+LwugHcVL3jkhO0sRFPBZPEccX/YoEv
 eqe5Ff6SbNm7ZkMMgzMOzTEOdGe3jPtRu9018jtf3/kxfDJLCIJWlc20QRGi0/IaayuC
 ksmbJJneDRnf/fAckXSTmFL6KpJ2Kq8DG2b651QkCCWNc48ffBVjlhpOxfVPcpDQ8M/+
 Bn5hhHs042oSgshe3vJhf3OYJgA1ZpBa8l8sa6Y89tLlgoS9lM/rMDV2kpkYBLlT0Kvr
 a/Uw==
X-Gm-Message-State: AOJu0YwXNrAYpTQM1E5aBu132pyWvDfOEJBt46yp7ZJaVfLs8OvLccAL
 0a+gR5ckWmVmLmHhvaek74B4mPqn+skRkIZv88WUEI9tTsnmf2n+V6V/i8m4hGBys6sUJVuNT6g
 QScdXtGGpWExRy8WjlQ1uNuOKGkfBjlRNfpw4OP57ig==
X-Gm-Gg: Acq92OFC63X2eBm4r6j9/gG/mHS1nCJPlUx+lOO0VY0smjrEfbzNJYRv1enx99B+Wqz
 wsdOzwFgIRwBbh8v47fQZ+44jR6oRTjVetJOU2cogN10/EtF+/KvkuSbSumLfGWf/Cx1ulwjp38
 11HCxyii2UetWpNS5hCh5Qo3MGlJegh+Q7AtPKqV2QbNQOc6e40msChPYNVdx9hjVw9KH2VEtYe
 hvwePDxnanYdJg571J+u1jyRUaB3VQ4Gd6J+cNJdkdffwVejQOBZJy1f/m5rbWXQ752DKS831Bu
 vZKd2OspPB3f1HuJNTrD5riNxEYs+f9+NlgQLApbRwgiztNTH/Q/yCnP2bnaBr76bCA=
X-Received: by 2002:a05:690e:d09:b0:661:75a5:3b5 with SMTP id
 956f58d0204a3-66277f19a0emr15892349d50.4.1781615877389; Tue, 16 Jun 2026
 06:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-18-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:17:46 +0100
X-Gm-Features: AVVi8CeT2BeVspAfT1y84eoumA3QpGcNNi6z7V-UNY1ea22-X-1BeC65-18FOsc
Message-ID: <CAFEAcA8Z6fRx7PdGgZ1rELAFsryQHnVY9TdDZPWAj00EgBjedg@mail.gmail.com>
Subject: Re: [PATCH 17/25] target/arm: Implement SVE floating-point convert
 (top, predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 5 Jun 2026 at 00:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes FCVTXNT, BFCVTNT, FCVTNT, FCVTLT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

