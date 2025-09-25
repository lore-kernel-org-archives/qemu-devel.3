Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5798CAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 14:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1mxB-0006Ki-PP; Thu, 25 Sep 2025 10:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mx5-0006K3-Tq
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:28:08 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mwv-0008RS-SO
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:28:07 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6353f2937f3so689664d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758810471; x=1759415271; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GewQR7/+Qt/2Fj0Kd/4s+T4SM+9lkrhGhGb1igAvpsc=;
 b=kL2xXMoQyoJnQuFKWzwYnhUARqWulo8NGW+fzuFIytxDDp6qnvmlVhJmvt9E1VJbum
 P4CBZFu9F/jG+LfXly0a0bruW6ouhXuuHoeQzloZL1VPrZ4DAK2k623oPg5vFBjq1f20
 CAe94XKs2W8ijnXprUUXbyAcEE/1MOLzjC90nzK0h53I/knLUG+SdUVy+wJpRXho3ro1
 5XPRmif1xdS3e/gcuTqrHuyLh6Q6s4+WIUPo1jj8Pdq1Wmw6CUNWWEQaoJGP7BJdPv6M
 Xc1O5z5xN5M/xcDAZvr3AN1Gs0SbprnkDv075ZV7HR7Spl9mggp5aOQXSfGjoZDjjRhP
 +OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758810471; x=1759415271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GewQR7/+Qt/2Fj0Kd/4s+T4SM+9lkrhGhGb1igAvpsc=;
 b=k7xjShdXvIcFfQHC6U8sIQmw6jxrR+R26meo4tBkHHy1HF6KKiOKu5h40DwGtvH4BU
 Mr2Gl2B1DSExmCbE0+qzlrLSO8JUYRUZuRk+qL7hT8Nl9ID70cLbOC3euB/siRCyCNVv
 ezEWONVOiDmnGZCxdyjkVLpuWXYrwp2cv7AUQylCzyMr+vxaDMHL93mYsT+YQUdUj4jN
 AuwTBEfgbeSbQ7jo7Bs/DKZ/YARLKLRUoBcjQ0j07NkwyJLQ7fonERk8UFTbJcGswuOG
 q7RX45XeeXMqRI8/80wmM8NfyRZY7jXNUCIPN93W7+vAR9JSxhrWkL+6lzjDry1IdYQe
 eUxw==
X-Gm-Message-State: AOJu0Yyrp6AgFuoA6UvitoYdQMYxe9ebQ96xEmYgl1TEg9KTkotLR4/p
 8XxBDWu5s+RcB8iCPBzad9zeCzBB/91smTPepT2HfY2HjqAEzLhKhVUsZ+FaKPa5Jthc1M6lxhm
 /CwfWHL/eMarVG6x/kd//o90jLQSEMqsD8RTXdJGljOIAG8qSmsG8
X-Gm-Gg: ASbGnctXwfaC0zgHXZjO0hkCdvggQROZjpkUq6IkBAInb2ThuWe39OCRNaDw7Z2ffkw
 h2A6xv4tE6t4CKdKUU8RK82hUB2Vqmfr3QWzMtR8LX2ahYZqK17cZRALLcPiwlpU8dUXIYyjGRE
 XlzSGTlbSfiHd0NU7E8HvjoPlyALBNOKZlzZrOQPbjA0JIsSpO7svs//MsH4dqkB4+ZgM8d2Qks
 4YegdeS
X-Google-Smtp-Source: AGHT+IEtDa03kTBNWN1qbKm7H0pK7B1omoYSyf/BEkRo4ogpueQS824cCrcO8iMamw5w3L9NdAynw6zMcLeh7j2kkkw=
X-Received: by 2002:a05:6902:2b0a:b0:eb0:c05f:7ca7 with SMTP id
 3f1490d57ef6-eb37fcc1204mr3390411276.47.1758810470846; Thu, 25 Sep 2025
 07:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-35-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 15:27:39 +0100
X-Gm-Features: AS18NWDaIYrRPbfP6xx-xqOqU_RFHpattoExbljP6doEicNeqznLXmhTXddF8_k
Message-ID: <CAFEAcA-PecdR1EgOTubMK3hZ3GY=Javw3Fo4eHnhhjbtXZpyYw@mail.gmail.com>
Subject: Re: [PATCH v2 34/36] target/arm: Redirect VHE FOO_EL12 to FOO_EL1
 during translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 16 Sept 2025 at 15:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> +    } else if (ri->vhe_redir_to_el01 && s->current_el >= 2) {
> +        /*
> +         * This is one of the FOO_EL12 registers.

I think we could usefully say FOO_EL12/FOO_EL02 here too.

> +         * With !E2H, they all UNDEF.
> +         * With E2H, from EL2 or EL3, they redirect to FOO_EL1.
> +         */
> +        if (!s->e2h) {
> +            gen_sysreg_undef(s, isread, op0, op1, op2, crn, crm, rt);
> +            return;
> +        }
> +        key = ri->vhe_redir_to_el01;
> +        ri = redirect_cpreg(s, key, isread);
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

