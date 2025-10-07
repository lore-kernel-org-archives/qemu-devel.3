Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39644CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64RT-0001Ec-9H; Tue, 07 Oct 2025 05:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64RR-0001Db-5b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:57:09 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64RO-0003xF-Az
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:57:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-635355713d9so6471839d50.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759831024; x=1760435824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QCv/b3d8k5MXLi2MYer4Dl7hAiDFoTI0dqQOpJ+CSSk=;
 b=rvVQyfryib/DxdsVhrlvAoUdSYgA78KKSky7pj0aV/9GtQ6CVcQKEnilXPU2dvhdxE
 742Cuv363k/K6t49XZ1/k8/tcUG+IbwWm5M8Qq3at+qQH2n+iXhRLH0OWLDliax1/X2F
 NzFZoLH5l0jKkawWS8h92TKbdiptOc8iyCbAAgFOH9c+mv5+pxUA1Ua55E5uGuX2SK8g
 ee8xw+L8rHXjYQ3B17+RLmtZxCWs10Rkz470UPN72aZKVZ9X3Phtri2o1G8BdfIH9PoL
 7SyHEKJc9DKqgcnbakhRFeud2IDPN4S4edthk2LodlX5qeZxh/IAwogRQMdA3TLPMi1k
 jTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759831024; x=1760435824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QCv/b3d8k5MXLi2MYer4Dl7hAiDFoTI0dqQOpJ+CSSk=;
 b=jV4mSowwts/vWuL7IkKi7KJsGvIf9xBH8BU3xTD8apw9SW9DqRzcE0/cIenBR7OaMt
 umuhCLCPekX7ee76V865YtkPvpQPdmCd0LaB/VkZ+b5tSVl06lSjppecye9vYptU5xKb
 E2g9iGE98pdN7K3lOCd5V40xo/1+INCHejGv7uvrIUNlrnJvTdr1tp6z/AlvntSPc5Yu
 qta+seeULoVZhulqMQ7HOH+Im5ZWBegXg02u8tbC3nktfPZDlgJ5dwO2FaBwVRxO7OdI
 IZGtK8OTQsCYUs6NI37BoryTdY3l2NG/0hLZer54ywUDtDVwQY6JpGFFT9vR3nXPMA2R
 MLMQ==
X-Gm-Message-State: AOJu0YwhqNkQViH9rkMOTy7n8STVv4McLzwgxoAGQy650rqSYa/JeuBV
 EhHwN8rF/8X+yepAWSEIR9XdbeK43k8pPQmi5V+ZiSaTeHSHqG9cI9zhRygbh5NK/dxYX0iVY/g
 UWGw7rgtZsFHyYGJMQdicmbHpbtkdM/wEDYF4gDmBUQ==
X-Gm-Gg: ASbGncsVdufyZ40VJi/I4mie2TUBBR7rz/ApVy0V9vszt8dMuISTSLTLF7rfNyBIFNI
 l9BNI4wz6OZhpM83T1mbU/XUwX+eKiiR8oriBzR4JjxOmN+H++9H57g74H+usUIM13GpxdzD6mn
 SDVwqWL64NYCU0XwTEZcbEv0XOOI5Y6hfjPAsPMWYRwW3j00MrmZooR1OUwDhyQvkad4eaFMYbo
 a2aFv07RHnimpWCulF9p2YsnBxY34AU/zkSxhbisB+qhQo=
X-Google-Smtp-Source: AGHT+IG9AAPM/O0uZO0ds74baGvZNzJfpqew/1d5uWlSlBo9YncfX+qHJs9IZhNju8S57Pec59LeUhEPho30ENWgvCA=
X-Received: by 2002:a05:690e:2441:b0:635:4ecd:75a6 with SMTP id
 956f58d0204a3-63b9a107d98mr11647329d50.52.1759831024317; Tue, 07 Oct 2025
 02:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-36-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 10:56:52 +0100
X-Gm-Features: AS18NWABbsEqf0IIUCQPZeBGa3W9vevYnQLUFs_sB9Xrke9HY5-cGzFEcQR-W-c
Message-ID: <CAFEAcA8cz6nuaswjqAcHTA88NTjc38qwQdf=ipyN0xA=crE2mQ@mail.gmail.com>
Subject: Re: [PATCH v6 35/73] target/arm: Export cpsr_{read_for,
 write_from}_spsr_elx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 3 Oct 2025 at 18:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move cpsr_write_from_spsr_elx from tcg/helper-a64.c to
> helper.c, so that it's present with --disable-tcg.
> Declare both in internals.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

