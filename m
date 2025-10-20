Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42800CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApGc-0006Nl-Cw; Mon, 20 Oct 2025 08:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApGI-0006J8-Df
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:45:20 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApGF-0001v0-Bv
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:45:17 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e1a326253so3187245d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964313; x=1761569113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qYy/XPD+8IsiYi6ooBDpYXvKasVoRHY/TiN0SEfPk7U=;
 b=i00b0b3eDIPvQ6mHkIG0amP/moGdXd+JszwZEWfmajwOHeHjcn7w5V9hoJflO9wRqY
 b2Blx+INOm9PlzpLa7qcynZRtcMpQFKtVg0a8JFump5LrLFlTQZVjExkgGdPYmQvu97J
 KaIPmRw/ENI3SMsu+35okkCCubPEPoJ+T11uwAbnhLAAnykai+5Y9Bc6Op4rHmxu6/Pt
 h2qHaAl1rhBOpKkYevn5XJ+MsdB/+eKRALo8+RBjXY+f6e517kelGKr0GhqgqK/FqlGd
 Gq3y+M4T7bY72upD+L3R9MZ6ui+CLGKTdFZR+qCExCkgnlbpXIZyDIXF577fUMMf1ixV
 7qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964313; x=1761569113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYy/XPD+8IsiYi6ooBDpYXvKasVoRHY/TiN0SEfPk7U=;
 b=HSKRZ2e9pY332vfFljnL7ReTrHVTOLJkN69vh3Lqryy2cXhkmS+nbPEXid6/fS0Wme
 vakBY9uDP9s1Cu+rdEeUIi6+EweIxzV/72nSoqWiYZ11sWF548T/HaRS5vi/+/V1XJB8
 HGmqTG/EpEkzE7UtT9ePEv3g56xFV9XEMbCvRRlp82IGWowzuIHrHeXBVLSgSTqu23rB
 SdGdslm4YzIxHhp1zp8yzn0KdSMTuwbfmJmWM4NNmACfVujR0BjgF1jnHd7cx+eH1KJ9
 V7sEGupFG+4IBDA4lRdoesZxMYNJy7G/NHpDKJxPmDzFMv2ZC5sIOLFS+9E3dk0ru3vx
 VkGg==
X-Gm-Message-State: AOJu0YxEyXB0PPfP4yybRAt2dBEdXjtfNIhc2OFKGdqvzgzSvIQxukBM
 GY4QKMpg3m4rQetHekbiR/qutCYgUiPmp8Ol18f8s32htK41bg6pBBtw4vF7ROPmsLDFhXp+prR
 jKBWmfrXpKhzPWRzra6RtihqZkDEqEXCaFn2r9eifpA==
X-Gm-Gg: ASbGnctbdkjZOlmK5dHy+5B/SLwSuMCrbU67SY7ceqW4QWbGsQDbciqWsQL7TqjpHH5
 TxbH+hmsTPv/iTL2TFaKNnZSOp/4H7MZjVoIF9EDbhf9GBura814zvpdLsdkGPFm+Z8V3rgAovw
 g7oBAyfk4v1GnyzX0lAjbNLhTWZXsWDe5XMM6+0M1Cs2wqri79BOvjqXgIwm9KwPweX7jjGK71Y
 aYRXNjrSMH7w8oHFan395N8McDAig7tOj0QSlsI1wQmwYA4YnKeHR6thYIhWr0BjQMUOBUy
X-Google-Smtp-Source: AGHT+IEsrnDyWDeZ/Yxlvawg2t9fFD9fRoZxpDVr5MgEnrsw+fMKACC7mNUOkYS8IvWhESkBa5r3CN0hyoNyUqbSmJw=
X-Received: by 2002:a05:690e:134f:b0:63e:4264:878b with SMTP id
 956f58d0204a3-63e42648febmr662921d50.58.1760964313134; Mon, 20 Oct 2025
 05:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-18-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:45:01 +0100
X-Gm-Features: AS18NWBSb9SbpFQn5OU4cNi8Rd6XuU7Uau9_IYheA-lVJyZRCKpOZnrEFa_gG10
Message-ID: <CAFEAcA-LS=ezQcqP5KLWe5AaCZmn-ZQvkbWM-NcMRDyUAj5fAQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/37] target/arm: Add syn_aa64_sysreg128trap
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

On Tue, 14 Oct 2025 at 21:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> System register access with MRRS/MSRR use a different
> exception class.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

