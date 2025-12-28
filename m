Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69347E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 17:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZuN0-0000jt-TJ; Sun, 28 Dec 2025 12:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuMm-0000i2-Rf
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:15:44 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuMj-0002r4-Vl
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:15:39 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78ab039ddb4so80222557b3.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766942137; x=1767546937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YEpwVmAu1Z79AjcpVRXCEdgwbkqyKw4wnqKEoHnuMDI=;
 b=zn7tfcaETzTDVBWUfY2V/G9b6uLXFihojyyDQ4Hrl2BwcHU1rxasdOPs+PYSFGdo/S
 nmiED0+1xsoShEZXywPs9OodSxojwPwR7LePtIMP7IDJwbuHfA060EBHjJkb1Yk8moTd
 zeiBKfTtaUC7ejLgc+XVq1eVgxVCg12ni7Wn9hgrtWE5A/coePpwZpCEamlQXePR5s3D
 RFpyO5gemlIrzSziDDiSrxXKOu436JY8YAujsZZpVLjrY8QcEgYGoQrw7Q12aERcgeMx
 EjXke+w7JsLOx0Sgh7EL3weZnpCMkzps57+3JDE6Wzu2SiQRwt9WiD6kpWOSUfGJiJQy
 CdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942137; x=1767546937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEpwVmAu1Z79AjcpVRXCEdgwbkqyKw4wnqKEoHnuMDI=;
 b=rjQsgi16yvwwIdIBM/CauxGmlhOT4+V6xGzIVndSvx9gubC7K9ApBkp5/iSIIOOukF
 LiwOfOVqlfkOEvcOgVQaGdwu7Wkek4Rkgsu0VaqnTA+SL7eqQ0bFT++Sab1BACbCwCbl
 cnv3wg2+hRAzLvditEUT/5O8Pwo5PYIXOrjzg22JxkUYAms6QrFaNTTo++YxUp5cEEj+
 5Zt93tJ6Ukzlj4SlW7uZjcgFtK4Vxngio3AnZJOWTlgDFmqm4BASSL3BX0xEVgd9FF7x
 Mq9pMPoExMCeO3+z77rUQhnOGLumlCUAqK2Gmu3Tru8S+GwXVyRPsRiSmNJVTotJ98OT
 1+MQ==
X-Gm-Message-State: AOJu0YwpibhOA2PQrUrkKyMFuNvEWX93BQQBXvT8kamng9W/w8EoX637
 De6/OU7CAOOKvaVnEMT+nfTJz7MGWZvTY1vrpcNszR1WdtzQeOXPsGpZE8upRs7Hq5GF1ftJng5
 LwlUHzEJZby0IOIM//QRM3xHJh9BGyHHteVzJ6ky3Dw==
X-Gm-Gg: AY/fxX6k1X1mcHunoWsJ3En4cXeJLXneb2Hfbh7avxAO1ZToPTqFLaFvTx33u0JGYTL
 xkZy8L+mfwhzqb3Zv9hCx+PexXqfu/Qs60yEK0GwfAqeY0HYLCEI1iUz1mplnVWn/DhnjsarB4g
 uPsmXwClh/5oMZSkG88uLX1UrYROzA9Ct8vSU1L5pTG3Gn2F07SEzFLjeOeub3aEflessEiV5zQ
 QN0jAJ4LFcP1yFcIT14po1ed88Wo9lyk4NTvDlwGxWkjdQ+fNXzw1uN0gO1olGhVbV5yC7aR2xB
 vPwP5KOPAqbarNHGMtwtTSU=
X-Google-Smtp-Source: AGHT+IEWYVERgyCITqiRFvffkIZJE7u8Mdfp86yRdiY12ucFK2hvYZ1HHI+3Qc1Uc0lbQ2XQP1A1zWhiVDmeTWK04KA=
X-Received: by 2002:a05:690c:63c7:b0:78c:6a6a:123b with SMTP id
 00721157ae682-78fb40ab03amr244080717b3.63.1766942136672; Sun, 28 Dec 2025
 09:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
In-Reply-To: <20251226064225.791454-1-lihang.lin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Dec 2025 17:15:25 +0000
X-Gm-Features: AQt7F2pEI4IpmO02l3_PfwMOedgA54dgnhK-PKTWJY76daGUnvQtWvD6iU1Hoag
Message-ID: <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: Li-Hang Lin <lihang.lin@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 26 Dec 2025 at 06:43, Li-Hang Lin <lihang.lin@gmail.com> wrote:
>
> Fix an error in rsqrte_f64() where the sign bit was being
> placed incorrectly. Specifically, ensure f64_sign is deposited
> into bit 63.
>
> Additionally, update the comments regarding the exponent (exp) bit
> width to reflect the correct double-precision specifications.

This seems like it would produce incorrect results -- do you
have an example of an instruction plus input data values that p
produces a different output value to the hardware?

thanks
-- PMM

