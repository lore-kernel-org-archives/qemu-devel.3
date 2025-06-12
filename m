Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94C5C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjfn-0002bB-EB; Thu, 12 Jun 2025 11:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjfk-0002aS-K0
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:16:56 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjfi-0006UW-Uy
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:16:56 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e3c6b88dbso7363267b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749741413; x=1750346213; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pynYP3g1x7bEvnpKVAJ2PfUrR08T2TE/exFWGnDSM3k=;
 b=qgfmQQvCWP0TGCgD5uHhnSuCPjaBBeje79fXHJtPmY40p4s8m96keTUTf/E1DsSRZn
 itSya/l/Z/HtyuzAU3Q1+a7zS5StxEHEPkZ5mVissX0epO4Gco8cKQwKvW477Ydc9/vp
 CjOZ56kyXHSrGfQKlgQOp6T+iIhYyZi3xQEW3A8w2DK8NaJYTFm1CpNNmSK/xdsUSyaI
 CTSxLLzAsOJUeGQbBzhz51uIBmHj9j6X7LRFVPRJx6lyRue1xkX5oSNYMZqd/tY9i997
 NkgPGBN8Amxxa+0BE3DJVNo5hmykQv7/hw474ZKkuGuwdXyJXFBESMa4s3/KLC1vxYGJ
 cr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749741413; x=1750346213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pynYP3g1x7bEvnpKVAJ2PfUrR08T2TE/exFWGnDSM3k=;
 b=aQ97EuBvLQM0pnUzea5saV2baoNanoAy0wWj8SqLzIzzL2A9GuwwN/0TcVvzdxnyFe
 4K3FXsVI0FdOHCiPBXFlHGhGnH0cVw3rRwqnFmDHkr6B/Id3+ltgewHpWF3FfSb975f9
 UmvTM6gza+rSMV+tv9+9u45IjXdzERqYOkgDMY0cgN6nkwl8NlBccLOmdoR3RbkXs0+2
 g+QTZIzvtc1HDS7tkKHst0LkriOvmy4/m0tF54fdDwBuqK0HfLdxa4dVXQkqu6rhItDv
 8BtolVWXDigI/39F80H6S1yTUT7XBNDEzdO5glcdRYB8LTDBV2rcIVN4Wy60L+VjXsuo
 YNWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbAzVnWfZRq790E+TpI4CBshyGufYqSEL0MXi9FcMb42GsxZBNNVFoAoQj+zeQg99beWjNFyZHXuIl@nongnu.org
X-Gm-Message-State: AOJu0YwR5sDwxHc5o9mnOFXTjVZlhv6Gni0AJv5ni07FXinpguiAod1B
 KuXkfQBT8AWv6Q4qH/c24ks08vQNvK7ebmqpcqIyM1iWP0fMYmyUQJGbcfGJeMbhIQ6fzKajlae
 G8R+8xqgpjdG1FJDza+C7UuwzA0A6lOy46NVhdMMbbQ==
X-Gm-Gg: ASbGncuAZvZtwse7F+9BytY7WzEpIb7EbjEYVsP6nFHRSIn4urhGXBwd+wGbTeqj2ZV
 HGqEFN3QRUNFmpSF7/eZTDLc7Wf5k6KWM3oBnVRgX+VIenzQBgCJ19u07w4HHUKs7tXyiWeHvvw
 58Oqr/OaV3h3nFLLiejUxSGv5LIlxffT2pV110fVwRGAfk
X-Google-Smtp-Source: AGHT+IGYiecPIEGI+SJaCfuiYeexAAl9RgvSgy2FQZTT1sSnvIQJSJ8BM7RWlCmuhu4n7BWqsMQg6VdmdcMZ9NIZDqM=
X-Received: by 2002:a05:690c:39b:b0:6fb:b37f:2072 with SMTP id
 00721157ae682-71140ab6714mr108064287b3.22.1749741413249; Thu, 12 Jun 2025
 08:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-9-cohuck@redhat.com>
In-Reply-To: <20250515153907.151174-9-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:16:41 +0100
X-Gm-Features: AX0GCFuBHrJGT1DhrRgfURJ0MalgsW4xYAj3mIR8h1lKcbEjMTHrKhv4wIVn_nY
Message-ID: <CAFEAcA-c=EaE-Y4DMVz_meVd2cbxuCyFGFOXET-COOgMWHXWWA@mail.gmail.com>
Subject: Re: [PATCH v7 08/14] arm/cpu: Store id_isar0-7 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/intc/armv7m_nvic.c     |  12 ++--
>  target/arm/cpu-features.h |  36 +++++-----
>  target/arm/cpu.c          |  24 +++----
>  target/arm/cpu.h          |   7 --
>  target/arm/cpu64.c        |  28 ++++----
>  target/arm/helper.c       |  14 ++--
>  target/arm/kvm.c          |  21 ++----
>  target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
>  target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
>  target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
>  10 files changed, 243 insertions(+), 241 deletions(-)

This doesn't compile:

../../target/arm/tcg/cpu-v7m.c:70:5: error: incompatible pointer types
initializing 'ARMISARe
gisters *' (aka 'struct ARMISARegisters *') with an expression of type
'uint64_t *' (aka 'unsigned long *')
[-Werror,-Wincompatible-pointer-types]
   70 |     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
  875 |         ARMISARegisters *i_ = (ISAR);
         \
      |                          ^    ~~~~~~
../../target/arm/tcg/cpu-v7m.c:71:5: error: incompatible pointer types
initializing 'ARMISARegisters *' (aka 'struct ARMISARegisters *') with
an expression of type 'uint64_t *' (aka 'unsigned long *')
[-Werror,-Wincompatible-pointer-types]
   71 |     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
  875 |         ARMISARegisters *i_ = (ISAR);
         \
      |                          ^    ~~~~~~

(and more similar errors until the compiler gives up).

-- PMM

