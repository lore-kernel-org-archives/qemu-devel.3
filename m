Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF8C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Phe-0004r5-R7; Tue, 01 Sep 2026 10:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Phb-0004qI-Da
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:43:08 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Pha-0006Pf-2d
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:43:07 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8200b55dc47so48348547b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273784; cv=none;
 d=google.com; s=arc-20260327;
 b=ONQlHd/UkXb0uFYjYELMKTFGTceoGB23C7tP/Q+tRtZ13+Sj2qO8RMolatL4EUyvXq
 iHZBBk+kQqLV9Dg6NzwyGr5tV+81aCEgoo9+1n2MKDdKlOyRVPp+kYIJ+GOR9JEW9e9f
 XltJijtF2SifMCxbQ6GNJcPKLxvnbm6shZdnLO1G/LM/BiKpHozkV4Fm0JX8zP9YvFCB
 v1GAPMrkokq6m9ZPmvKBrYAiCKBT0fFlxzTFzTvw2fC8AOFwQveqXBSa2kbS8iFCQn31
 xsVJUI/F7b1Ekctp6Ti80M4ZKUxu2bk+UUemjK6pmrlnSW0/n4G4AL/dC6hgVoTVUlVn
 4K4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QO2CmtSZJqRqK5aZrDGJlW/UwjtyZh866PfxdVIqIuQ=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=ij7Im0teqGn7qthUaCnS5yKUb0OoGtSIxVhr95K3527Qj0d/fJAnTyt8L92dM1Kx7Y
 Sqh3pK1SmYZRISxguMObkdNd0X/r8BI88lV9iojjG4dfli5X1D8mnmvaOllsMH0m86uG
 Co9sXIeBkHlJFyyyYs0ErFuKE1kYx3rUERFyOeZRVCQpPkfw4u0n4kYDI+uwEHdMk84Z
 qC6DL4I8pFbE7raDhQyrAriAhGjQd0F62Wq43Fgah1ZgtSZiTnwfA8kJwTe3TlFhoIi3
 vhIDKKJxsJtoZT0HZ7uWEQ26fdZJ5gViQNiM2Dd394BKLlEXO9+m9kKF9ZBL4RXwSV5I
 5OjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788273784; x=1788878584; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QO2CmtSZJqRqK5aZrDGJlW/UwjtyZh866PfxdVIqIuQ=;
 b=uXvD7SMGEXx6PRUaPe504z3NerunQGVMgPA0FaWdmzG5CiQM/SyCdQPuXUexcZ4P+c
 CfqeB/hIFQWRfSELcMjjqPYxFwXChbibJual5evgKhTHS1Uv4sso7DE+Sah2k7Nkqnqp
 cL5JADGyOvVNU0zkU7/sUI+l93ZER0QPDv72Lagncl6XPyxG8tFbFkFKUA03w1S/nieq
 jfjsK8/VwuIij9mYema0PA3DcRdqUoqb8qCnKeZEp0qqsWQVruxxxvlnw3ewybeqoOJN
 AcYoO7g2xU53kwa1nhgoGdU2hXv7P1dfrQqSu4D1/7AA0khfwc3bloi4M2CuB6oWJ8rt
 KR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273784; x=1788878584;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QO2CmtSZJqRqK5aZrDGJlW/UwjtyZh866PfxdVIqIuQ=;
 b=FZYKeQTb7horyeGDDSZF0NJhF944PoMklySJvJ3GmqZUmpFuwiNXj/2sl/1FLbttle
 Ebwe1lOy0Odj1laHYJf7ihXHvRC2yyitfNtlX6/DFREvhGOU2Jvlhy3J87jOtsnSwwJp
 RzsLPLPfojPMqcZQ7ZFpHLgmA6OgHP5MeLlwXFpYxJn6WscKdo9lGU0U5r66eI7+haCP
 +asYbT+4apd5xeAOLTCHJhJfWQLlcpVaR4PvvkpUFLBBBoa7qm7K8Zf3CJiqOp2wekoR
 YEU6W+fsIFQqkL2OtDCr/Bz7z/sAWVx/9ZC2hKCQqpn5huucTeH/zk8t0qH/LGCeNAVT
 +GTg==
X-Gm-Message-State: AFuF++mSToZuqQCYESNBpf5jVPSyZeJ4ZhSPgr0L/MQkGY2ryGXNf7+E
 AZTAGCKa7L0BiZcp6aRAccbFG5ee+Q7svyKzwA3zrKBT/xoLexTxyGAa6mm+ATkoB/TwjIUKib5
 plhHTLu8qK9cDVmESf0cEBFbxDLzIvpPGcbqro2xBbA==
X-Gm-Gg: AYBFou2vh1w2I1zrRbBaAPMHeQF4oAxsGB1ccP7uolao7fqwmX8XEkWPbSEQkhywkAN
 x9EbO/rMMFyoxLePrd5qqwMlRLntr3xbj711Z9OhmTft4M+E1kx/S1Ysv0PNFs2P5oKjZoFFL3+
 78wCVlNjvE933wpeZB70mfw9lnUgp34ptft1VtJyz/MuJIDlm6CSqqVHbz6rcXApFgg2T+EZaIH
 NwZma9IQp95RQpUSm3tP+6BJxwykY/dTyDZhsephb3vo8DsTBdLWjfe/hnecZBtLZWHT2wGCjKi
 zxhaJ8Lu9JvI0hk/UGuNjHGbErh1jVOg53cXvyqS70RJ74w3cGIUGQZ8LMxFTJ1qcYeB/YCmIdB
 N8dDpBnrmlwS/ocAovFdwG7dVIEci
X-Received: by 2002:a05:690c:7003:b0:85b:f1ba:b076 with SMTP id
 00721157ae682-85d6a7c5a18mr131247437b3.9.1788273784203; Tue, 01 Sep 2026
 07:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-6-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 15:42:51 +0100
X-Gm-Features: AcwNN1UoQR0KODSwrd0TZhPptNbegPArztbJECkLwRb1SLvhT8Z5ysKRnE0jX3U
Message-ID: <CAFEAcA-+AJwEE4MOw5WgA-RgD=8bkcjcMQc+_9wkGoDUXX8K=g@mail.gmail.com>
Subject: Re: [RFC PATCH 05/18] target/arm: Probe second page earlier in
 allocation_tag_mem_internal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sat, 15 Aug 2026 at 21:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Translation faults have priority over everything else in
> this function.  We were failing to trap for the second page
> entirely in the user-only case, and when tag access is disabled
> on the first page for the system case.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

