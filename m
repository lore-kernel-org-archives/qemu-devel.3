Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCC6EC1436
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOeA-00022y-3i; Tue, 03 Mar 2026 07:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOe5-00022f-FQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:14:39 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOe2-0001ld-NZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:14:36 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so4813976d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 04:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772540073; cv=none;
 d=google.com; s=arc-20240605;
 b=NPhTgF++acV2Ar/BhJoscynLPl6vz60mZ4Y3QmIDuBtWY32UZ8Zwa7Lw6BkmlTaz9c
 S5jHpI7zmOkomkp5Y1appLam/62yqqFAFp7gBxrgMFEhjAXRYTBnha8jbMpR7qbeDXID
 gvRNhQdwCM+L1kCmje7yl2rXQsGEcudFvnFRgJlcIfF3nGqskKWqFUBPbkA7derV+yJg
 b030p8PaLS6p2/nTEoSthJFhZHc7n2Bc3rO6NqwDI5Rgx83JQbBoz2PY2c0pZ5l4becR
 EXiaZ1IEduEpx42M3NJ/By26fua2ONlshHXwMI6oaFZmZm9NVFwzLL3HsZDaBIIUHqsf
 FP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8j4B77RCTjsP24E8genRF4omtD1oIbKt8Ak/VzrPPiE=;
 fh=B0vEhQQnA8vpcsAH6t/FR05iS3nEAIEL6+di4cC9q5I=;
 b=gxV+JSeCyBtv2U8d3wtfUC4cDzjB9YFuYLc8+1zpwK0/bKiZAcJHLV7BGdXgqMJKWR
 dV4YpQ2BC4LkpWOw3KeIO52jqAg78YkWY+GmnLRv2lIeX7yhGdojcHiFQWxKOJ1rVJMi
 0daHpRQ20lOOtaDecb9oCZ1vcchZzDOTUg0Xx7cB2eYaG+sjVm4yGdjTH3RDKpBYdVkC
 t+unjmvEEZB0wFBnEFw/2GoBx9ZnlPS8XXk7mDNe6iNzugIW+QBJ2oj4/43YhZI/MFRY
 zXMYpeb16S4anXnM1srtiCbJaH6M+15A6C9Unr3f7d5Sq/K6lnHINQb3LWbgzAwE1Acl
 20Sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772540073; x=1773144873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8j4B77RCTjsP24E8genRF4omtD1oIbKt8Ak/VzrPPiE=;
 b=f5JyNcKYOqnNlvKxfnk9cW22Ag3+7TCfiPIFUMFZKm/sicrcesseSbJ4Ks6JJPHyvC
 vhbdxLVT+3AnwrSMdwUA1cA70Ne61UyBJHWUbBlYLu74lbPM3JMEQjsWH6M5tlyqubHf
 YuqEiwaD0C0Kl1GNWk7r5UM3youHJwzG21bzkqU4kJCG0HZ98pMj9fiz/j1Cpl2MBuYZ
 uhkcSWWmgjxBFJKugqiLIO1KeN9yujfOgGsd/LDhn87XTf3DSedYperQcls9MRYzKM4O
 QBVc/lj1i/i8oovs/bPLQ6bGusVrRj6ji+ziaXMGBb7pmoXubNzXWf3shCBZOH3sJ0xB
 bdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772540073; x=1773144873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8j4B77RCTjsP24E8genRF4omtD1oIbKt8Ak/VzrPPiE=;
 b=PmFNlNhuzZdb099/jfR9vpPv43w6cCU9MBd5L/HhzsTrJedEx/tJqPvYbh+DRJGoVX
 u7MUzz7MGYyIcDHM1nkzGBHhucP3DrwCS1uERa5qrmezdJahaQu+DG2TTx72HHEmcf6K
 RgiPlGpp7vBPxe8z8Irc24p5zUEnZCoYMpqYcAc/0R10xYFT7RKxBW36F0D2TeR8jOxA
 UDeoQP8eq+3tzQr9QexdDOgoOyYBfuiLIE9934SLaa5MEIE1DDiUP9qgIW2jJbsbfkyH
 G9lHUVe3lug+dRbl4NVA0nD4sN02l3xvy+u3vhLY58NibHbeOgoSS7PF5wqiCqzo2N/f
 d+AA==
X-Gm-Message-State: AOJu0YzbvbNXCiSpVijwQ2EZHJKJvNALYTfmXcOtDirsZ3D9w0CddX9i
 ZM1NJ4OnfhEx2WFVBDPPfQ6GOUm58CKVc3zp77R/4IWoNM1SsooKkeUJgY9aRfukoEkNC9PA5np
 YeZASltrQaqt7Hb/LnUZbfVaN7kJW3O7Lelp/mo7yGA==
X-Gm-Gg: ATEYQzxv+ZfO/tvehwzI1MIlin55gyIXrpvVJvzaIYCfSykgxehAJ4i/Bu68pgOTh33
 m3LSsNFeQWvOzFM8GGHmk6odg6/ku3VuMfMLKOSCOTjxt9IbEltxixyIKsYOw7rcHIsC1o19c9u
 gQUWzd48YBxFfyneSJ25IyvJeGGF63qCgEak35l8cQ3HpvIFdmmzCc7JBI0Kbhd4NOHFSO0jM8p
 HfBCismgaGcTslsFbTi0WlBZvFnS5aEijV7BzpHUunXJp1NsCJ9aC/moxsZDwRQY4FNlxMv7whz
 Cv1+HLib5el8JYQddbEPb0/JvyZu0hIkqUL5ftDopJXofeg7lJ8ppBuc7UaLLr5ngsmAYp1RVaQ
 kbQ==
X-Received: by 2002:a05:690e:14c6:b0:64c:9cc5:573d with SMTP id
 956f58d0204a3-64cc2141711mr13681514d50.32.1772540072786; Tue, 03 Mar 2026
 04:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-2-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260211155410.203883-2-magnuskulke@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 12:14:21 +0000
X-Gm-Features: AaiRm5365mXVEvn0BYsyySzb56aV03qNEAVdc7qVt3yLyVkaITFjFIt_cuqi5Os
Message-ID: <CAFEAcA8HNBgd-u3mtpPYq=UhEdu6WvSJ0+yHZTsd3i8KRRF2Vw@mail.gmail.com>
Subject: Re: [PATCH 01/10] MAINTAINERS: fix magnuskulke email-address
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Magnus Kulke <magnuskulke@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 11 Feb 2026 at 16:09, Magnus Kulke
<magnuskulke@linux.microsoft.com> wrote:
>
> Consolidating email aliases.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29f88d48f3..6272d32ed4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -569,7 +569,7 @@ F: accel/stubs/whpx-stub.c
>  F: include/system/whpx.h
>
>  MSHV
> -M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
> +M: Magnus Kulke <magnuskulke@linux.microsoft.com>
>  R: Wei Liu <wei.liu@kernel.org>
>  S: Supported
>  F: accel/mshv/
> @@ -578,7 +578,7 @@ F: include/hw/hyperv/hvgdk*.h
>  F: include/hw/hyperv/hvhdk*.h
>
>  X86 MSHV CPUs
> -M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
> +M: Magnus Kulke <magnuskulke@linux.microsoft.com>
>  R: Wei Liu <wei.liu@kernel.org>
>  S: Supported
>  F: target/i386/mshv/

Hi; I'm going to pull this MAINTAINERS patch out of this series
and apply it via target-arm.next, since the incorrect email
we currently have listed in the file bounces ("550 5.1.1 :
Recipient address rejected: User unknown in local recipient table").

thanks
-- PMM

