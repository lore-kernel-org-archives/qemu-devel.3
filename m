Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BECC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvKM-0002cA-VV; Fri, 01 Aug 2025 15:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtev-0004EP-Id
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:35:09 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtet-0004kB-Es
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:35:09 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8bbb02b887so1815316276.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069705; x=1754674505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xN6SY+xvpXsoQ6MdX1hY+CBhfL4GAxO8nRn0cEVUtqo=;
 b=rre6+zQse/uO74A12LiNKVVzl0CHWBFuXM2XbAtm2sdMHNXYIQ12/6PM+ZfifTGodZ
 7xHH9ePvTFHvumwaS22gJI1VmZhd/GA4pTNkiD+4r5oGzENkjzZ9lsLnWnq8GTOXHkbU
 MPwu5EQsVS1+AlP3PMLDo+c39jilpCdOvwweyoLSIyMWlmZOjWuAgum8aP9Wi2h5/AhW
 kQ6XFQ5FkzSfO8yjNhqyYQPVQ8yLEft7t5gUJK/h+fTSdfV4QoOXep3lbMzFIV0210zu
 3DOvRAjCaS72yN0V/c7A+cNNW6y8N+/BdIDo8QrBUUFl86shb2Embbgh4m6qwrSVaPgo
 GPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069705; x=1754674505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xN6SY+xvpXsoQ6MdX1hY+CBhfL4GAxO8nRn0cEVUtqo=;
 b=iPvr9HVx8lzKiFrI8rBPZ3kU7GLHTv4PRSfFYgCBW/HFXoLhlrt7DEMNOW3lbAgD2I
 VWWqixeSYncQC3foculpyWZE4B5RCsidWUjbRWQ5LOfTgMRP8iK5gpVCDHJhbcO1TJx+
 csvborq8602i7iOraNEA52pwRcNwS9E5oKp1rxMfcLZYI1JAiSAXXNdE0/v1VCr08ufA
 ghvdPnD5NVZzhz1J42GaDiaf+eTPz9vpRPeMa2CQHfzNoaYRuCTjUaAmkInT4HxOaoAm
 vNfdIHIeYfZYxMx9YS2Ufo8VwI1o5Jge25SaRNV+ftRmGvxNof5ylXtTHDN2805MydJe
 Fp7w==
X-Gm-Message-State: AOJu0YzzMbalPd4pt+r9NiHuRKDSLorY9BdGC6ia0EW39nkzKb3J4dfq
 V0HZhvWCNQfSOgOSmd0tfeag9oRc3mNAuVRsJMEmBCNX+FC93bdJO5ktc4J0a8YQWDvT/vfjlZw
 ocVSU8fBw7iSATBA8PpLTnUjsw9pD6rEboYAu9wq5aKB0VbGicIYG
X-Gm-Gg: ASbGncs7PSzDuBY7vy8cguRiYR0ypAIl6udWiu0bXtvkbHtXdInfD6QT0ScklBv7oY/
 ALRzjV9cPkTWmyjiI8bhbzMGc7wYCbNaUNzWXE0s5tIpIbnBEeBKdQVwcm7n05wdZsDlCWHraOm
 LEPJ/Ced35BRo9cWmfWEBwElu+LtXunwjGP5ErN7tqYnEDZf5z3XYXqiBHXXNKasXJ5JGPG+npO
 kbp7bQ0
X-Google-Smtp-Source: AGHT+IFLOijDbCdPt53mGYGfVAkIfmkSLc/3LB0O0290UpXQYeg7o/4up2LsDQpfXB/UNzcu7nq6CtcA+4mbXHQGD7g=
X-Received: by 2002:a05:690c:7108:b0:719:fcb7:1a79 with SMTP id
 00721157ae682-71b7f852037mr5938837b3.36.1754069705553; Fri, 01 Aug 2025
 10:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-39-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:34:54 +0100
X-Gm-Features: Ac12FXymGVB6xB0fKCs41ifgGco6oEAHzgZMBFNwZA3U8Vj_CK4O8hYxwRd4eHI
Message-ID: <CAFEAcA-h6SGsaEwEdH9KOkSJ2UtjDSmbweVfjPWAEV17dmJwxA@mail.gmail.com>
Subject: Re: [PATCH 38/89] linux-user/xtensa: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 30 Jul 2025 at 01:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

