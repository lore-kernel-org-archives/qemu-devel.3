Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D532C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wu8-0000kt-PA; Tue, 08 Sep 2026 10:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wu7-0000ke-P7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:34:31 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wu6-0003FW-8q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:34:31 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66d25d77713so2180178d50.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788878069; cv=none;
 d=google.com; s=arc-20260327;
 b=Ud6R/XCGLYGnrUSgcE9rR/Jw+wGcEh5LBcBj76CbXVhdotCfVhlXPlar2MbOVoIEt7
 CsMOyjae5dDkc+TY+OUUINsDmsYIQbYvi14L9eBjRdhg7IPEjQnyK5xBxRQA0xRs7s+7
 OGqPpNnh2MtuwVxgXRVcH4GV32O7nFWmPlg9rM/wRxmCHMyKsHVPDE6nMHp+IPGHwqHW
 QgNw8A87HSEnszDPlTPK7OAmRPIhhoDvQgjCAvqCfots1IAPWm3dqXg2X+pzOu+b6z1B
 z1kNHxMpLsAA7ZVa/9+pt2GucRNpk0s8E21+skOF2dgWyqyfAXyw65eWMxDT32eCgHDQ
 QMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ylaE6R2If8UKh2267DgBiM444yzMojHEwR/c8n71kEg=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=nVgsgMuR0MEND6V7GC837jEdDg+BRAuyyV/1HyNBocyZfjfMuC2s92oV5zkpEi+ccT
 euMfHaDZAcljFJowqk3C90Z8yuI7IWbCgzbmbC8rfHJybERNZvCYw8bLfP5FV/Y82fLb
 yGU24wo4K7X6DQfN66u8Ex/K6glGz4qfhGmPi07rtnBqWn4rDnQiDxo10toORpH2EasQ
 peaSg0uuuUdhNENFLSgMPGS7LCzB5cgmjtDU0UMGyFe44hHlA1rrPkSnS7fugxCWrXDB
 3ABVGxz6AVriG/rd/RHHh5xehOV0PTdvJUslAsnUHBxdVOkrYBST9of4pofWTjCiXPHj
 dixg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788878069; x=1789482869; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ylaE6R2If8UKh2267DgBiM444yzMojHEwR/c8n71kEg=;
 b=EG2kWSQS7unwyO/q5ZnN7/GNawwZYcDOoohTMVt7Je1LGl/zX+soxbX4v1KHWoOltj
 OsGo6jCWJ/1gA6kgHZrzrj7j9WriU3tNNfRIfDP6rR9Dzp0XoqmCTZfBMF2qgWXW5w84
 tIXZLWUXX7G+5/w1s9eLeJyrTNERHAW+qd1k85WQYRQd1LvNws3B2wyYcYg1PacpLkp/
 aV1lZGWNw68d47HiqSG3jOwvZ6lOLKrJFjNzk8Rn/wU03fb5cqY8TvAuccFdvRpN0aKm
 elbKkFTz5HSYREBfS+u1CsoUeugYZ+e31ikJCP/Ub9l13lKgosTVhf8/yRAreg/xJgA/
 N2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788878069; x=1789482869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ylaE6R2If8UKh2267DgBiM444yzMojHEwR/c8n71kEg=;
 b=e92DBZS5HuA5ISV7s+2qphXhL6/m0PrQJhl8jJSXY8sQhSmiw7YSJdBWgMm5fShzv5
 XgXzSJNPC7w97YHrkGG4FvfbHmGLUY7QVpGQV8bX3MDMCYPQAO3GopoePzup7HK5SYAF
 0ifUaJXBweGOJYEDQZmfQgxGq5KC7pw9yvMUkhLYrPvciGtKNieHllPvgTaMsFLXz5j/
 hDh5F6ILAIvHeSPG6G/LjRG3+Po8ackrr4t0LG+mpCOy2bJFPonBDXGZTDNRVlDVMDmf
 54pTELwo00ksZ9TGt8kT63oYjHX5eL4EzzQnMASnBf2/D90Hs2W9OtdPq+LZUpKUVvPl
 KSpg==
X-Gm-Message-State: AFuF++nMLJGBcBb1lGPK5KrSJK4IE0Xn030JjoqAtpcXnd6sHCvBfiGv
 YqPT6SmCYSU1QlnKI3EdwHnsDedo0vKg67TgS3RV9MKNmLzKmPQW3BXFYQRWNdh0I9c/t0QI1v2
 9sasdvCaDREuDOyDkbJSkaJyAYWIkvjEIFi8wB3YtKA==
X-Gm-Gg: AYBFou0LdEyC+81TwJVJ9M1/alRsTVAoh0r7sElr2KRlJBdCtqJfHCZV0MM0rAja0cA
 Iv7s+TtWLkwUX0V72OrLCsls1Zf/X3rU49orE1xdNSiDvAolkdDon/jBB8Dq2xTsATwSN0FduYE
 TUxESPla1cp7Ok6wb0z+fA/NepDPj0hvrV2LuINn+cfjnFvssZ+j9wBZbMFVSmwXuqVDXMCeHKS
 MHHjEtp6RSJOvNH/eMQgOWn6SZUfnrxvnZaKH6ji/wVyMoTqAsmqsZJLs+sMAj5cbviyHfYgqdA
 6KJaAkq10f1kMI9Dv09IZQfmy9AnG4BqVMalnOYuzkyrc47L36dY1TjomRmiyWDWSf8TMjndWFe
 hI6MMxZ8poKFuXBBu7XmXIBApCaIX
X-Received: by 2002:a05:690e:1a59:b0:66c:6167:92b5 with SMTP id
 956f58d0204a3-66fc1bf8d47mr5713510d50.49.1788878068554; Tue, 08 Sep 2026
 07:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-3-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-3-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:34:16 +0100
X-Gm-Features: AcwNN1U0AKuoRLZVtjUPTU2usLd0O84kAJfAJ1jgzferdNFgusLY1zYUu1hdIfg
Message-ID: <CAFEAcA-F_rYtmBpHrTmd3j6gyQv0httz4DTM_50t14sNf2J+Kw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm: gwdt: consolidate clear WS0 and WS1 on explicit
 refresh
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 2 Sept 2026 at 13:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Current impl had logic scattered all over the place and WCS was implicitly
> cleared on WCS write.
>
> Consolidate clear action in one place under EXPLICIT_REFRESH condition.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Yes, this better matches the specification, which states that
WS0/WS1 remain asserted until an explicit refresh occurs,
and that writes to these 3 registers are all explicit refreshes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

