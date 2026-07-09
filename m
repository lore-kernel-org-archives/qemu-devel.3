Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B17C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmic-00005v-82; Thu, 09 Jul 2026 07:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmia-000053-9N
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:15:00 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmiY-0008NM-Mo
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:14:59 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667923d86a7so1476696d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783595697; cv=none;
 d=google.com; s=arc-20260327;
 b=P4HzI+rEJr5nc/kZUTXawWy2XNioCiqOnLTSnimwtHoEr3+O+kX0HbQi+29kp6x/ci
 73NGgJZTrxrSOU5lqKJCGQKov29DgHT3WT0UNO3QJGsmhMknuaovE5k1pZalqtIfUQEQ
 RlwwuhIqOo7MaXDF9mmwWVlUA6YzP/Wz17gMujcCx0qjxZ0L9ERt8iPJj/oRh45QuvFh
 VWZFqcKQn1e994USqtUu1O9pvdVRihRStCQiC3EJiBq6sGeUdhkpciaHw/csGT5Bp2C8
 cIbSIBU2Gd4hjjAtqTtnM38pFFiHzGDYWvhiotcpV/IKN/vyyK3vYVvtdvly2+8lK22I
 CaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0csda0jsAzoG1JAlcaVdEg3eavwvBUv+flzLXMAW0Wk=;
 fh=IY212RjEW+Y5rlKHsBgxvybhAznbtlwFROgeEQDIWNI=;
 b=S76kVa/Ofq8opybKv0ZfgKE5D3DxC7w60TYVezC8UMNPpDEKMV5upDsx5MPCW/P41+
 77EzmKsTWCha4rPaefraLZKzPADB3HRoM6Ik0qFThSsRGw25MhJdirrgYq7djv6BKjOP
 Nv1nqH2A6CrP5/lqM64/mMA/uuiq9LBor/7UWNGfwnsZcDbH0LUV5Y1SJ5dwLfIILm3B
 cqmUThjOEIY3fxnYeUNStQS7Tf1KfMN5EkQnEHaQbFExsrNkzGero6VfQ1gAWu1Pj2Tx
 b/WFZH5Vy5s+tSnU+7KlWU1JPPLLEh0bdooVN3VrLK7DTtJKAFvtcc3wkJ4/NMWiVhVE
 LwNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783595697; x=1784200497; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0csda0jsAzoG1JAlcaVdEg3eavwvBUv+flzLXMAW0Wk=;
 b=UN63cIR7G26X0A0FiMkcSRRKyVkWneZIWLC3WTqIaw14LdofeSKUFukj3em9FuseK8
 veI1VrAg3yFAT99i8bqfTMVZOBK5ASrMGuvu9gGZrwhgTDawH37ZCZwmd5Zj8rBenI84
 lkzKzsLDYWVV+6dA8Y+8jjoWnZac0JmNehdKKNLpMdhqH6rKwbaFJS7cMk3AKslUg2hP
 tTFHEKy1Hop1CJjMLUc9YLx5RmfbLcSJ2p4kPvkLyn+LkkW/w+O+wOFCWgTi5DiOmDy0
 oxfK470ioEuxl0PFXdYMnP3eaBUhGy/OG5jruvmGfaGnWdiyK0iAr2g8+bd1VS+31/27
 30OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783595697; x=1784200497;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0csda0jsAzoG1JAlcaVdEg3eavwvBUv+flzLXMAW0Wk=;
 b=oJ84gkLdiDf3Le71bvLI+edJqwxmougoB4Nbwfs3b2G3O1QftK/rm+7pUhe6pIC5hU
 /6b05+0XXsErgBfBTfdH/1qI1spLHfER+BZqFiDfFyei9LgTI4/1cqqdzvMpojsLcdee
 /03yusVYJIsNesGh8NCMiM7GxgPnfQucz2nIuYyldkBMNUc0e4Ib9AVZaduSizEMe1s6
 bV4WEiMe532zS/+4HWk0+ZxgniaCJ1foobs7gvzo93wO1S6x1FVwxUeB/auKNnOuhEcK
 JesSgNvk1QU3Xpbubx7YrJojJo0CKstPZcU6dUYyiSmcDyeYi8ps5NFplPfCkqQl4ULC
 HOuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxNt4MM9CGoHbxjh3HHoAyfZLnN+ngHnNH2ilX85DF8B6MPNeNCdozc4UCTd6WHQA47fKekvaPztMr@nongnu.org
X-Gm-Message-State: AOJu0YwWiwYkygUVeRs7o0RCVM12dzVyBy2PJkVT80d+6qodxqbkWlQ3
 DmeneCBU4nlQcuYK7lCaCse4iEnrXV4iexKJvcvy6DhjP2TGXje6/DT8k25Gy9tQx/vcBoIHs3p
 Kj0fqhl+rtiggpNZXjXMIxJteTS69Ahzy2+0ComfQew==
X-Gm-Gg: AfdE7cnNPvBe26vZreSVeNdnF03qIEA862YtNZE5DJdNfHeIaUuiyZGodG8y8WRNdQh
 h2twiCGaSqSBpyZUVxj/lciKWnlqpI5tFHVao04QCcj7KEZD0t6Xj3eFc0rs/9EqdTeBiotjOvF
 Trl2iNF0WG0fgYJiPeKq/Zi5VhkspvO4PYHdql37rY5s06VZWH/dO7gWoRUyRDma2iDK6j9K9tE
 OyMvibhnPKy0jwPSjkEPvo9cURhWNGfA6LgtYbnSOFraOWx/C/LpTwH8EIpved3MRc4V91mYrv+
 k7VRmo92gayt9tKwGbc2oWAf+tP2oHNjzrmatrY3gDmHhtmWrL5b8S5c
X-Received: by 2002:a05:690e:d4e:b0:666:4ba5:34be with SMTP id
 956f58d0204a3-667b8120bdamr1466206d50.4.1783595695560; Thu, 09 Jul 2026
 04:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-6-titusr@google.com>
In-Reply-To: <20260706230056.1888992-6-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:14:44 +0100
X-Gm-Features: AVVi8CfjCBmfJqwv0fn4NcGcmPMlTauUoW2ZCNchD8omWzDzQEYZfm1l7Vvf1bM
Message-ID: <CAFEAcA9YSeSy1rmu==REhuOfw4cWfGsWc5CFcuE3uqHjorYs3g@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/i2c: pmbus: add Linear11 format helpers
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FUZZY_MILLION=0.1,
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

On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/i2c/pmbus_device.c         | 12 +++++++++
>  include/hw/i2c/pmbus_device.h | 46 +++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)

> +uint16_t pmbus_data2linear11(uint16_t value, int exp)
> +{
> +    return (uint16_t)((exp & 0x1F) << 11 |
> +        (pmbus_data2linear_mode(value, exp) & 0x7FF));
> +}
> +
>  uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
>  {
>      uint32_t ret;
> @@ -58,6 +64,12 @@ uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
>      return ret;
>  }
>
> +uint16_t pmbus_milliunits2linear11(uint32_t value, int exp)
> +{
> +    return (uint16_t)((exp & 0x1F) << 11 |
> +        (pmbus_milliunits2linear_mode(value, exp) & 0x7FF));
> +}

Nothing calls these functions, and they are the only users of
the new functions added in patch 2. We should add these when
we have some actual callers, otherwise this is all dead code.

thanks
-- PMM

