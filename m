Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA8CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4dl-0003mJ-QA; Thu, 21 May 2026 10:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4df-0003la-4L
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:44:43 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4dd-0003CR-L5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:44:42 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso612056d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374680; cv=none;
 d=google.com; s=arc-20240605;
 b=ba7RRQb3U5vZRfSGiCAgk2Rz/bvtiKmX5aYMg6EcfJG4NFkze7OtU/rZO6iKYvtQd4
 U9+qCRwgKTym8IlwJLq0qUE0aTPOAYDhL+Fik/VR43/oA9GozqK0mHekTPk+0vZpGt5L
 oRBIHym2bi+6RjLGui/zuPkEy/fhaonXcc5QgERZtMbROu8bi6Q5cVSoNRPY7GfYVsZ3
 8kadLqSeIriW3biMpGzIhSLOrCfRix9W/w02iGfEzQ2hyFd2Lxbdj16EmCRPYEeQS8LJ
 OjrrGAucZsABkKSAESVRHOTrL6bzqqHD84nFgdWDTt4Xi2bcZCN99tEgM7JRUfHAnqF+
 uFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+MOrE8Bqp6huGpTQFTl7kQZjUCovhfvU+1H4MuVqdlE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=GvgwJEXeegyqkksKY4nat+nyaYSMrMqryiNw1en2f+gFA+4PGQBRRbTYv8kEAxo1AJ
 ROEgDnm/RsLkcLhQ9wokqh6tsy2VnUiXPj9y7lvCc9+8yf5j/KA65AJExnxNmxk2DWh7
 MombxCTMNub8JA6cF2Y7mjBMPFShA9pbeUp8oxGcywyVGwm80bNzzJav+9noQ4hZryFL
 kuFAxnM7PwF4nxEpCP9HHB7tiYNcW8+9yFQocRRnWIZtRHj+zvTcSNT0IJcj3hi+8EgY
 rw+3cEcuOm3VQ4OBW/yu0IcxOKQ19dnrUdPqS2zgy/ZG82dHf/0uLgt+Hlgq0Rb+6D6P
 n2gQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374680; x=1779979480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+MOrE8Bqp6huGpTQFTl7kQZjUCovhfvU+1H4MuVqdlE=;
 b=yNvIzqK//zWmlsy1Jg6HvLYp3HCRc1azzP4wXctIRn2gEwzX/KeAAMzqp4q7W1Hr4s
 QKFahfW26EbIlwVHDTgRwIaPUkvnsSJGbxokv7mBO7cO6W6BtK4ctxosxXn1xNEkEGLK
 XLFPx6QorkanuZRHJwJdn68JZhITV5jNbWT+qrfORZ+i21+kYvJHR6mceW+BPqFZ2ntN
 wxSGj82bpxlv/gK+k1eo+UPY+7CnT2XcUB4ZSZ+17/vDUrpgUnC+dGaxmNcIrVTnaepw
 icp7m1Oi8Wu80gpifE1WQIQjsvBfli0MvoRe7EtYG8z3MUWCZgUifmDLeXKdJ3y34qWz
 q2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374680; x=1779979480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MOrE8Bqp6huGpTQFTl7kQZjUCovhfvU+1H4MuVqdlE=;
 b=sw1ay/T1Rh5zPS425kDQqilYQEv1FisZp9p7+RzbIQ/4fcQ06ZmBtQONX1w2WEpp6n
 ws5v64G/CdZxD7JFhQW84NPxWKwelDKUn3X9g3D+rFOqGc4VW59QMGpxa7qi0VPOobGa
 3v7lObi2DGEGD/wBC8eJUvVMiJL1Szsva1UxnZs3c6pawRhSeGMKrIqgERlqb/LU6Wrl
 VaVgZ3HiH2r1goAPwvZIqXMcppm6St2ushCRBr7cAeIREVtANzYep752ycRxftL4EVPz
 EIpUZqYiHvG/D36zcnfHFozwc50IbAn4Z7MeQBTYNTUymv5uV7pGl+PaoTPceU8GiZ6F
 nyxg==
X-Gm-Message-State: AOJu0YyYLHWWYKmCkbfbuqFUOLVq1hnipixbdvJEa1CxLQ/fjHOqHOv8
 zlDL6rS/VByWZgIpc9TlI0/PbY8M9+DeVWUVaKBds4++a9sqBr8WqAajhnW/kqcoznp5KTT1I94
 WFzI3gFQ3RYqHByw5QkkO46UQFCWGATG++t1oUI81hA==
X-Gm-Gg: Acq92OEeBgN6gU32eGop/BDcO5P1K4hhfuPbm+81cTfDmbZNiA9MgOepuyX5cgn8utK
 IoAwR/Icmk6mODwMhOAynRgZeiAh15vfDpYyGSoblMFsSLz8wtYGb/ZqWy3VSFgo76jnwsUReMq
 udKwb/WesdZUl8MPD9r7K2sQz2V3T9zsktwYxhaR7lqHp8UuJJugHm8xBwOYH5G3gvsds1aNHvq
 X2qd31L0V9mqZffH+z3QjOwM/sHPe+lMUUuGp0rx69llw9jPPCYk9QHl8SXm+sDEkaKgXhW3IXV
 OJnpVxkzs4cFVUvO64CwoHDX1b/4liO1eyXMqS8pbfx/h8FIQQSPaBUGf5wUDIqyJSU=
X-Received: by 2002:a05:690e:14c8:b0:65c:2ac8:ec3b with SMTP id
 956f58d0204a3-65eae04a179mr2655818d50.17.1779374680132; Thu, 21 May 2026
 07:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-18-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:44:27 +0100
X-Gm-Features: AVHnY4IUp7TcyI20WMiYWdaiaQFPQ_JS7RSvRxiZUj_Jj5lnQdZuqFBGgGIxTEY
Message-ID: <CAFEAcA-+49gaO-BiDFs8oNBj12+0MaBAiT6Z5Rq-HgMRMPmcSA@mail.gmail.com>
Subject: Re: [PATCH v6 17/64] target/arm: Implement ID_AA64FPFR0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 20 May 2026 at 19:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h    |  9 +++++++++
>  target/arm/helper.c          | 13 +++++++++++--
>  target/arm/cpu-sysregs.h.inc |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

