Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB679C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0AA-0000M0-3z; Mon, 17 Aug 2026 12:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0A8-0000LX-In
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:26:12 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0A7-0003gQ-5x
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:26:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso502104366b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786983969; cv=none;
 d=google.com; s=arc-20260327;
 b=NXNUrO/py0tp6sM6rQGnzcbdjgO+mvoYgMKVRdZJzlZSnkegdPQKaiHzfwatd2lcY0
 qn6XsGY3caujEh47b/tvIdfes6+8a4ykhtTPNfSR/AAzSAQamhXawni5rk875U1N2AtZ
 Dz4l/J8j2lLvqdT4RgpmCBywj23YD6R9yt2nrtYRf4cGsYbFbSToVVDfjTTi1obLg4dY
 XTc0RjTzg29aHEUfzeqB+ARQoB+6PoVJCrYPuTe4VIShshxd1fVwWf2AFoxLqtGuQuJ1
 1UYrsFa24IhhxAZYPebhDcZOLSWlDvIOZa8SNGuwV17vl7GrUSaJej79cB6C67wIZUgN
 wFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9LnMnLZVxuzwQuaLmrxGTRJckzsfF9pcE6iEShuCdLM=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=SBS+X91OHHu154Ww5+jSMa5KC4L2DY4k6wlmACJzH5cCZBbXanZZ03ZhxyfhqRjGl3
 InmRWyKt5wMsll6h5+ZM/Z3t9TK0PNoWk2jcCSPVS8almpnpbxcFjRLtCLI/L5YIg78B
 aLd2UhTn2/cl33pX3v5s/0sYXBK2xb45hppbMWYnZSs/IqF28He5G/M3P/fOhT4Fe3Ao
 WoErPMzJsfoHuh10fDMmzBVPZRZfsTjGNQSkTMrB8+5fLgQoFtqMCDaDXKDd4eQSdDvL
 iEVwPkeQwJ3+YcNGOXGGQPMFz0QOvZaJVexDhjxlbAEAtXolQqY+5RDs3/igAOl+9eSd
 NFHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786983969; x=1787588769; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9LnMnLZVxuzwQuaLmrxGTRJckzsfF9pcE6iEShuCdLM=;
 b=CyQtNHgzlUMJiAlBh5hgHbWhL8HswmcTzK8JwqGAEaqzsMmlRcgGwxFbx+TrNymrTl
 hBSPvAPUzfcmd61On6Em/XkDTNwJhCpuTIeM2vzrUPjn2cUO7aSZzB28sMvPtRg/Ui6O
 0xY/LR6R3+/QFFgU4SC6sNkCIuHh4w31tafi4MpbvtyuPCOn0ivBmj5K3lR9d2bdbUCK
 40dcl3tetxrsOtA+ni7JLKfaUeZpvoKqZI87UvLtU2/SGmAX6V8PzLl+ymd5QSNETYFp
 xZNqmAFCMJPVaIk0k9sYHm4xKkmWDKD5WVImHWohuPcIbfLOrAte9cRaRJkpae9DM88d
 VM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786983969; x=1787588769;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9LnMnLZVxuzwQuaLmrxGTRJckzsfF9pcE6iEShuCdLM=;
 b=tFuDEAhnZwHQQfiBcLLKWcYnEhkbNDY6CI5PxEmoiURp3oFgIKCQyeFW68Xc5nXLJJ
 /OXykDn6/Yea10nOD1IZPK23c16kp2k7zcBfb5pmJepvec7nr/sadisLh1GRvncgsA5z
 yA8Eu+WffYQ25aju2oahvtfoEykRiAS/JZcnuhZKy5HjsOUXSZ5IfUH7FsQbNHNcMpl1
 Y0TkSgZcY6lBnOA0tdztGA59WAB3XdXqCCSm3oTf4wQBWIBwphl20Y/v8hk79tBwMaiF
 evE46hR01QTJ2T9k9mcxYPzAnbm7lQ1la3WJ17Mc4e1vO6pIHPVKqF847dw5NaynMz6U
 gpag==
X-Gm-Message-State: AOJu0YyjODXD+B+iEIrISahmN9+2u94Wq0wiTvKH3mQ/BElQpB6sUtcm
 eBXyW3FcF7MYNdwY2lWh5PsLBGJ/WJ4ZxWOKbmJ/r8M9U4U0cBYqHvTEUq37gVtHQINXRNWmSmg
 Gv0jaSLik0y7zrwY1GKq1JqeTVr86iByS9hMGh1Bihg==
X-Gm-Gg: AR+sD111qkLMehyyVkb4Y5fZj21OndaTclUUxivEdMgTc0xTSquzGN/YpjsxRg/YNhC
 OxADMtivVsf35tgt4hlrmY3Y8nU+QoKcfh48Aqo8uR5MUewJQuTFW+UivDrDD3wdWti3WDzIbtY
 hwagkNcmC6EYhzB+SZGhgtPmKAHjjGVNTPt2idJEgDyaBYXO0JN2mmAArgofHKoo1CevCZPv/Bp
 DjlSj7wsmsPf+qP36VrpcTHoBKDT2QZyW/TwLkn77rOGrRxZUwZfBfPaEKvfTZ3P7TCjNjy6ra0
 7phe//msenu7hjynukzIRE9zTEbGwoSS2t7OOEfEFAAl4XtJpId8JhZsR1DBI/w2Qhsdn6Ys07k
 /5tk4Z98Tzdf4rQ==
X-Received: by 2002:a17:907:8993:b0:c16:831c:427d with SMTP id
 a640c23a62f3a-c212a26f3f0mr1107299766b.21.1786983969417; Mon, 17 Aug 2026
 09:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-2-richard.henderson@linaro.org>
In-Reply-To: <20260811191540.79882-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:25:56 +0100
X-Gm-Features: AcwNN1UbXgxSDTDFNVjvZ2NTeB1-I1dTWFIKkzOlNlMl8s4A7tTha8-gfRNvPWU
Message-ID: <CAFEAcA9Gm7mrJTx9gYCD_1m2f2SbVAexMM-c346WrtasnJiPKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tcg: Export tcg_gen_ussub_i{32,64,tl}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Tue, 11 Aug 2026 at 20:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move from tcg-op-gvec.c to tcg-op.c.
> Use a temporary, to cover the possibility of operand overlap.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

