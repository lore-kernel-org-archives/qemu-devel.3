Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDECFFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIW0-0002mG-3g; Mon, 27 Apr 2026 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIVw-0002lL-EY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:44:29 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIVu-0003i2-LH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:44:28 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6530287803cso9527468d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777283065; cv=none;
 d=google.com; s=arc-20240605;
 b=ddUs99bWKPbvHvpwwsHaTIA5KytldkxDEDvo2aXa9vd6KIQ7u71nDWNxZmPxXVEv32
 jSJdOT7Kf9q6ftivV9eCFVeEkOdam1RMQrscOTF6VGHRrinrS31VBtAXf8iWARa52sKv
 QiHIV2rOcnTkoYpffCtrM/mqNOCZpZXdwplYo1uA8GGas15cMvzl3Vhjmzt/CZaC3EPq
 F/hYPbtJPML/0VnhOmsSpZqA6LFeUz4nTEdFfVjgcQwE+17iiNw3RWoJL76OiqZdFIJt
 vJRU75D/y8c5EJsJgqbhJFq1pHV3hYlwYqdEnGdxSH6WCsgxF2JKRpDZR7RowOnpw4HE
 tXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LbSEVQmL+Gy+XI6Lng+xGxFyxMrWeFFBBTACeEpD4cQ=;
 fh=sH8tFGrGYtu9PiY4IRsB8c/6tlMskTvLeVYzTqFRvBk=;
 b=dUJYQddgXrL1l6KEvXqMzJUVWdoOWtKtKGIE5Yinu15fh5JIC+yK/x/oByxtOvQvxS
 fAd3TXRye83cIxHtjWTdjyGJLDBZf4jUs3ESYjbvr8yhI8DrQu02j+v5mGILlfu8Ivje
 DBdVglw5H878auhxbGt49rT+lPAOXUphp8O0TnDtDWZmfNiKVPzU18fzLFX1QhYUyrLZ
 0JnqY8269m18gg0uW5hR9ikHyicbtJRvhcSErIx0BHAyR9/VbPAWSdM+povUdv2Gi7V2
 edSkrZmz2yLVMKElZy7r8Rh1/YltSLPg2L8oE1cbRnSF4TS6CdMti9BCCrKF/NLyTRYy
 BexA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777283065; x=1777887865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LbSEVQmL+Gy+XI6Lng+xGxFyxMrWeFFBBTACeEpD4cQ=;
 b=WkwipVgwyda4IVSRMVqzwlDZkvtPISheQOJOwXJlDEP4L2adhjJIKtRFTjRCD8YHsI
 tH6YYJERxVulz2i9+o5CBmeug/wKqyRwvhvGId+AzDJvPTA3vUuwETZAdFccb89pkDwr
 UUk61/a5EiTAitydwhqjqnGoqPfIB21+rm18Adgc8sbx2WAxze0ovYkOuUaSY0srFauH
 VAebt6NrsuAVXgRFnsAU3m0ueMGC7gHVeYivpZZqSpW/3z7saTnq9cBNq3rhWN+rhvh0
 F7XvoTzYpn3q0XclV9UvTpETAP+MiDeoNaBqRE5GBbIOtku6Nev21arrpPTuy3QTN1vC
 cPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777283065; x=1777887865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbSEVQmL+Gy+XI6Lng+xGxFyxMrWeFFBBTACeEpD4cQ=;
 b=WeS9SE59295sIko9fTadOvXWLpzp6wDgeYTc0DV3Ys78QsjMp3qTa0aQoRQGhG/Ce7
 /clvYHLuLgd5gIIG+P8N9Eq6VdSEwtUn3+Zu13V/MjaBPKXjVk6/oLSxi944oeUtwzwI
 w1d2Ei6RWPw+Pmq2OeSAkT/q5GWAC+ryLu6wPuW0A1q6PG6BsyIVC4HQYMTFygsC+vGI
 aVP9N5IOX+4nD+Ma0kwzQuu1knKwn9yxd4yuaVQMNJbvj2sEplZCoHjTwzXD/p+7wSKD
 6+MY0M07Lkgt4jr1c5AMPW5vwbwX9KlQOTZBHJ+FeD2YC2Ke6lp31c9V8Be4Y4/8lu+N
 m3GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jc+yMlv+dPX0oNYqZepfz+1vw+t+H4hcFOkqIsaPAIejnQuz9C0j0KUYZybiGOQ/7y6rsX9QubdfK@nongnu.org
X-Gm-Message-State: AOJu0Yybk6rphWOPT/YOo/KE+SBxdTHQNVQYhVT11cKEBp1qlZcXkhou
 R5pncu4KlVVugm0MCwXhHxLxDW/cHW8I1MJ1FlgDg5T8sfPBrI8eDVLoMIwQFqUnQIOk/E6CX9y
 VEg2Utu59+WzTXR0Tgr1clkIEdwHmIVFoWv7o8uYiQQ==
X-Gm-Gg: AeBDieuvNxO9mAcO4RKFWa4QG9wtSSJqo5rE2vHUknBw9BBWqWAt0oWkFinqdf4MlCp
 /PgVbvKh8dbEph7+QKDixE1ZKBoKZ40utHcUmRM8B+tEXtbhkqchOXnyOitmNfep1rOIAsZU7qf
 Jg596WLvLTFl4iJwxB2Q52BxRsslVaHbQSCA8WUZikc/UjEPJfeY35/sUkYQaGiOOxaCHyDL+EO
 t25Ryvf7d9ruocLavLdmSFoamWixNq5IOK2TXIxEkN9+4wQBh/1imm2kUcFrgFnONMlWyJvlPeW
 VIfB2p4W0I1T5q7GGP+KMl6ISQatGxyki1aOisQotN5cvlZtOfAVV2KNbAyoqKM3YBm92s7dyiE
 X0g==
X-Received: by 2002:a05:690e:b4e:b0:654:1dfe:ca8e with SMTP id
 956f58d0204a3-6541e0e2555mr32048946d50.65.1777283065245; Mon, 27 Apr 2026
 02:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260420140552.104369-1-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:44:14 +0100
X-Gm-Features: AQROBzBAUWwqNcOx-xJGaI6CwdG5Oz5BpCKABJY_zB_5mL_6g9cVohmqvFNmY9E
Message-ID: <CAFEAcA_uLzLjqdr5LyLQ3EK2zy-ZoS8FfeDq9VcaobOozO3e2Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series introduces an infrastructure to explicitly tolerate
> some mismatches between cpu cpreg indexes/values on migration.
>
> We especially handle failures due to an attempt to migrate
> more registers than exposed on the destination.
>
> Once the infrastructure is in place we can handle the following
> known issues:
> KVM:
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>   from v6.13 onwards. Causes forward migration failure.
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>   register from v6.16 onwards. Causes backward migration failure.
> TCG:
> - We can eventually remove AArch32 DBGDTRTX register which was
>   erroneously defined.
>

Applied to target-arm.next, thanks (with an edit to the
comment in patch 6).

-- PMM

