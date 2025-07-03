Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8049C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXK1h-0005Ud-1j; Thu, 03 Jul 2025 09:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXK1U-0005RO-La
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:30:44 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXK1O-00084F-5g
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:30:44 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-70f94fe1e40so11532097b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751549435; x=1752154235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m6ZRNcbpmPTdg4qBCLOqhMjI3q2CvUugVQV3teZrbT8=;
 b=jvRn3zVWZRdFMUFJT+4Q0Cs/afToi+mfkcFBKMub7X1J82BlXTHJMFaw+KWSn/maFI
 lROpsn0xKzjWDgv/UCYZfeIYpX0Ui5BPN0Xk+9coIJtZwQ0gusKKBx6H7FQ5VIbs8Dhv
 A4qEJzoFlJgX24NPeSYVCPRfwOiVrOEMMZTgJnEpx+QAuompbVoCn+SK7cxOY3QR6KtS
 WODjvCbtmQ/bmW45HxHrsbQy99E63TSWW+ZJ4sQtAVwVK7R0VM1HLFjIc+4vZZjhj5yl
 eZ81MhhEcXY6iyUa7QaNPcVRL12IkwiqjCgajq4IEh3J5QtU7tZ9qcq7cdHRNiXlKtD8
 NFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751549435; x=1752154235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6ZRNcbpmPTdg4qBCLOqhMjI3q2CvUugVQV3teZrbT8=;
 b=rVc0+Se+PEmH8djsiWgLhje/2ja+O1ld8pWK4XYdqmeUo0OPOGazHeH3Qz/+UaB/1u
 WUCzpnI9HdLQN/LtRBHv65kwsEl6R4h+KsVTMCgReFCoSlB9gfNUBI5ib4V+zSrGzwcO
 AYtUcN+8zgEoSUnwhOqo9L7+D2pz6FS0RAzcfULrlVh+w6g75JstlKvpXNNbxjbuQiy4
 Yb5/1xWmbB+DnjBoMHF1Nhx7UC79088UKFtw6a6nIFbaorli0sxBD5NoRagp+WLjtjeN
 opxmMpwoUvK9yAAGPn8g9Oc0PeHIiL5EKDxZ0lMxfLntHpeSN4fYg9+2GfPNIVM+PtXX
 9rAA==
X-Gm-Message-State: AOJu0Yy7+LQk3WWunqHFGF4EfLv22q/iLhevEYf8sax4H2faRcQz9Xzu
 NTQkeZ/kQCzF9N2Yfxop+n8lPy2AyFgG/NrWWzNZF1fXfQo4YmHBrRTKvXMbdh3NvGXF3jvCBIk
 oL5qtAJ5dQQUL486Wu8x/BZ7k6JQQkXEfwcfjRmIjZP+kcFfPO/17
X-Gm-Gg: ASbGnct8sbNfsS9X4EFVkudGPfsJgZIZX7lHBSItDNL0D7TQqOHr+V1HnPZEAD2jcKK
 mw7cODJUiS3E/fGpJxKmgWHRpeiAjQ5zA9q76v4sbYo13CvTSCBEN+yB4tMubvprCoYyGCFSBJX
 TWbuBDpp6Y8p+XgH20fc4/TRYWUR6onxnapxZhO/pQqRUirqAru/h7IZ0=
X-Google-Smtp-Source: AGHT+IGXhHV2YYK+s1w44L5ZczhLP32zqeg4xtu8WvgYl1y8Nbxes/5alqkkkDGuXQ24UYeN+qiOpztPIGjh/1DaSlg=
X-Received: by 2002:a05:690c:358a:b0:715:966:f67b with SMTP id
 00721157ae682-7165ca5df21mr28523497b3.5.1751549435351; Thu, 03 Jul 2025
 06:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-83-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-83-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 14:30:22 +0100
X-Gm-Features: Ac12FXwDt9XmpScOUEC5t1hS1b5pRq_XATdjmTfRndjlOQRfKg5cXOc4aBSn73w
Message-ID: <CAFEAcA8MXPx-LazyhKjKbCSK18VLc0aLXAYr=Y2fDK8YymtzSg@mail.gmail.com>
Subject: Re: [PATCH v3 82/97] target/arm: Implement SME2 counted predicate
 register load/store
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement the SVE2p1 consecutive register LD1/ST1,
> and the SME2 strided register LD1/ST1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |  16 ++
>  target/arm/tcg/sve_helper.c    | 493 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c | 103 +++++++
>  target/arm/tcg/sve.decode      |  50 ++++
>  4 files changed, 662 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

