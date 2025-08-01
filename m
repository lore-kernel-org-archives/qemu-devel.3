Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B06C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtwz-0005D2-Cb; Fri, 01 Aug 2025 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsOK-0001yf-Fu
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:14:02 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsOI-0005Wb-Vk
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:13:56 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71b4677044bso25645817b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754064833; x=1754669633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s2eMPv4bjefmAPx4xnBQU/9C1mT4bgVxWaDZhzFcywI=;
 b=E130QkHf4moKE4yMVd3OG9geX1vrRkK+3O3cHP98mYfQ5b8T+rV7a5MF/4bPE/bdBs
 vUE7lD4miHr72qZsVwjbCN0ij7qQowJteDU8FVgOCxVhxkcJZbadqEWL0hb1ZsNzRfQp
 wggQK0ekjKB24XebMOFZT5wZCMRxGzQI+SrrhZylmp5+Zr14QA6mPA+YtQ0DAfaHWsNc
 V/9hf03/zu/4DNfb6sh745sM6cmflHCIU9EBogSrfdqXM8X3usTRkM2M0880k3kkqrbv
 cVGKUaz0EjuiGU23m14tAtD7gBABE66LOp6ovJuUdzIZ3y90VpsqCEU8yaPlarrtCch0
 6pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754064833; x=1754669633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2eMPv4bjefmAPx4xnBQU/9C1mT4bgVxWaDZhzFcywI=;
 b=jTZU7NxckkjJ8hDyETrP2FLLcEXsGoggZevFbVzTKJM9f0KXNi8pgjQNphoCg2VYD+
 epVWUIy27NdqDsx1R2PZaa0cbgbBc8yYgSOXcCLtx7wGObBNoJpLJplEqeSYFe69seEq
 0hHZKIqgB0Bn3g5WPLPbw43w4gO7x4dgsmA1avN1Xl1dePRtOqIAHCDMF1XpeTiSokuH
 ng76vuXHj2KvR6ParRpOix9FaFPcoKC3sN/2PAjRugjruwTLkP0q4tYDQwVOuWSFyCJm
 bZPGRwcszUMXI/5tbSj+ksMUJFwXns0HXoD1otscQT/m931Vm6hcqLbNHuEK7I/hcc7R
 CXKQ==
X-Gm-Message-State: AOJu0YyIEs6o1dTcO8dotredm2Zr4vsr+zj/sWV71X+BDsaxzp4Zx2Vn
 RK7GRhP2MDOZR1ZcTN4O3wMuLlT1qbzkQs9XQ5LmU7Z7IzCfYwtgXEdcD9ebg6gRm/j8Y4PjM4I
 KzSfdUqYwq9dG9eV8sgqNp8KqljavJUOaHUqJB6L3SQ==
X-Gm-Gg: ASbGncswF0RZhiHSKB+u03WpgipSKEsImtBli7g/MdTjIQiMpwP8HwMnwpyESIwWId4
 eb/cBLmjCSdxZrIlwRW0MxbN2X3lH3SZrrugh/PV4OVF9rSwPOytQgSLt4blvUTrADtdHXZP+eW
 6YBUhyyIc3lq8T1RR/kCJxpuAcpVP2Fs1VFg36xAx6K1QziIO440UXZ3e/q6bVQa2xK7lv6twxZ
 p+jBrg+
X-Google-Smtp-Source: AGHT+IHlnbl7PtL4xinAj+dwDMMbEjvMUZpJD334kYs6txhQ2mDRl/s3o0lCSTp4viJgFzr4bVBwOSZla7XHF8ZR+zs=
X-Received: by 2002:a05:690c:f15:b0:710:e4c4:a92f with SMTP id
 00721157ae682-71b7ed12e19mr3339647b3.5.1754064833341; Fri, 01 Aug 2025
 09:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-23-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:13:41 +0100
X-Gm-Features: Ac12FXw9xgiShMDhMWnzZfeCse9-prdaLcgDAQ1A-hVu5kgwJHpSj9FEzdZggok
Message-ID: <CAFEAcA-5r9ha6MUgk5jAP7ggAGB+UZTpKj7X4Z4EtunBdJbHzQ@mail.gmail.com>
Subject: Re: [PATCH 22/89] linux-user: Create do_init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a unified function to initialize the main thread.
> Keep target_pt_regs isolated to this function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

