Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1903CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6Qt-00011d-W2; Thu, 21 May 2026 12:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Qq-000118-Qg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:39:36 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Qp-0001qJ-Av
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:39:36 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c7ddf514so5987231d50.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779381574; cv=none;
 d=google.com; s=arc-20240605;
 b=BKHKRmFPg/jR9+uyaN0KQHR0KDsn7VlnfeSj5pc6IeyXwamDrShpkRt1ylDfNNbwAN
 vwJClRzYeYAIKf6asc1+MrHYtclYIKeSDxBWlIA/Y+Jmx49OUgX6wAwE/Irxao58dz6X
 oyqLKev/z5/ozWVn0yYfcHX4QbX9vJ5aMkmgByyjRE9IM6XxF03VDTAIPcjzHb+UQUrX
 fkBGO7uRaaN6INFVz+vzAiFkFplNY45KofNS6gJRn//L9wIK+vCmXUAuM5OposfAY1jV
 cvT6s1i7t0aWa7H9DJudGxk9qyYF+JU37dHoaotmplHA2HRSu0TwkX/gxCbZz6wUiTFz
 3q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q6DedJq+Vq2REZyXEucN3PDFSSI/GYTuM1EzoART2O4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WtiZ5ta2Ebh2XepmwLkv9LlEb5zoNj2yFTgtEq3nyj0rIWqdbNIXbg+RdvLz1OEY3K
 +6vGpGh3lGKujxLCSRA8rJMAnmcmmHTCbt7o4YAm8rq3ae6OF08584YKSB0sU7mM12Ob
 AtDZo2HG7HA5kd/29022UT2LqtYyA7vTkgp78kdXMBxWVVP4IE+cdKXd2cu+hkyNAThA
 pq3rDqcE/qZjl96WwQuv9guPDh1d1Ng9t2738kVFRktNkCjZtTeXV1Ik8y21m3iWxGlM
 4JwGbwvPR+kt02nqTeLHa954hxZLzOTXNY/1Ph+fgXboYwy1bTjQ2GzylaCwN3/xqLH7
 AsWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779381574; x=1779986374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q6DedJq+Vq2REZyXEucN3PDFSSI/GYTuM1EzoART2O4=;
 b=DLiWfdzY/aQj9uVS1maYHU1NW7IFnWXWT5zpZJp/SeyxlxBnFRyoIXyfB2cKVddCfN
 UyP9Av9dtNOCJGEGUhjNsNQCwPsOS6wO/fEwK9a/4KxweGt0jMkmmqJbfY7CEkbJXlmL
 DhgxhD6j/owacuhel+6lhTb22UliWdi0cSh0L/LN/PCkfMyyO5nkmYIrUcaK0C95kNpL
 tgy7urCRELZLR29Y+6jVcEU/AAQyxf2EONY2F8y9yvejsE8anCL/DF294kqZ4t6sSSHD
 cpqCzGN1uE2kp0q/bmVx1hpCS1nJOn3EsUoohIG8/s9rRbxXYOoRfHxl6zb0u+31L5M5
 rUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779381574; x=1779986374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6DedJq+Vq2REZyXEucN3PDFSSI/GYTuM1EzoART2O4=;
 b=CmY/sWGjqthqR4iZPKg3F2l+RBIZW9tsqDkMV5YPkPk9HtsnpF7imX7olBkebftbDD
 ic6ymAt1lYHG1yTiamf9wTAtxtZAdmuFGPDctCfinPvlF9DeuJR4t7YYFf+IlRjV4Y4W
 6+YC94xX5bnYvW8MfhfVP6p7t16P+mt0HXv/5caU2IzazPQGidFpVyBRNG90VUuJXkPA
 4qdt/geNa8H6Zh5Ks0JzBhhFswPh0z+x2ynQE+fMqq4qlOzicMWKEszFvSnAFTXjqFq8
 xQYINK7+xmTpb1cVbR1EraieGe7upQDi7LEOlnfiSO8IkVX7Z9Uh0ynxUQtdgFERLPUA
 t8jw==
X-Gm-Message-State: AOJu0YzwSmO1Ostfjnt2/e/IAiCvT6Jh53fOkalaXy+hC6bcFigL2quz
 c8xXUfGDIn0ofJkwbmf3KowJ57ZNtMAbpdBi7VyP7SiLRpIU6UWzyMe71VrlmkoTikccgMX02Pm
 dHP6SdpB8oAqsiYbkbKTFtqbKNcW3jNCtDx1JgBTjww==
X-Gm-Gg: Acq92OGMhgHSeMjOQld51vTe2lLAFJQ7UQPZRWBsNi3KDwvkicH14FJ/5eSP4AhRRA9
 LFlNrGuP1PR/rF6yEgW8ZRxUbeEEsXU+qn46/VqRv42W5Ff+n762mH/+vsn+PcBeHScagwfY7gc
 x4wiDZn+QHXkEi7CUt1nsWHWSFvlynsafVVWtgXjxOt7sjBzN24cRh1h3StJDCU/nyx1pUvHgSx
 4FkNMQrfbanplLePPZrVrSMmlXCWZpyCVpzIIhRUCdl+ztNgyurkj+DWHE1ULq4IKNnUQGPhrGK
 lnxEkwQvmFa1dC6UoomL/NOc8BWrXW1SBbNCgc2F9lLZeAYOf1pni83q2TflpF3rn/o7knXu90m
 qOg==
X-Received: by 2002:a05:690e:dc5:b0:652:f16e:952e with SMTP id
 956f58d0204a3-65eadfa6aa8mr3375708d50.14.1779381574152; Thu, 21 May 2026
 09:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-27-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 17:39:22 +0100
X-Gm-Features: AVHnY4IK3RqcEZBDglJPDxpf1LDrBco05vxsMSELj9YkVtoReUSDs_id5qlCtHQ
Message-ID: <CAFEAcA8LHourEkC9QCD5SJFrfrqB4bbrH_dUW3dOXZZ0et8CXw@mail.gmail.com>
Subject: Re: [PATCH v6 26/64] target/arm: Rename SME BFCVT patterns to BFCVT_hs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 20 May 2026 at 19:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The existing pattern is BFCVT (single-precision to BFloat16).
> In preparation for introducing more insns of the same name,
> append the operand sizes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

