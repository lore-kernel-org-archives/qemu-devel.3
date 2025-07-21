Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8C4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoH7-0005vI-TH; Mon, 21 Jul 2025 07:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udoGi-0005R2-Vi
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:01:17 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udoGg-0003P8-JI
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:01:16 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so8907259a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753095671; x=1753700471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mNsr3nNXisLRdJ+nUNFO0seRIkM6zyOtDnst5gXhPk=;
 b=ngN2U2Ci/S5xDecQbNUk26X9mvTAYF9L87q2dpjUbXKM96FH15eTBAK/+fy5t473DP
 GfBRNCXGKLAb3PBK1QCC2yzXH6/NhmbjzYjzS8oMpFH/f9exoHDmBHCPsBiNqGj3f8dE
 Sofq9/ZmDV+N4MQz/gDgV/9kp32OqPs2NFj+cKS6l/RCh//y8GkSJIAC/ZBSke1xNr06
 Ibe+s9rhevgswrKBA4KzQw3zYt8l0M/9aub44CUPm/5opx5CJGMYRsCXs4VZ/6TtNszI
 o4/MkEwsPiNeUOH/eyeM+/6F7aoCA68Tmhbu7W0umCUUpk15foQgu0gyC8u9pdMprL13
 NkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753095671; x=1753700471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mNsr3nNXisLRdJ+nUNFO0seRIkM6zyOtDnst5gXhPk=;
 b=sujFb8WZy2BjJVT2B0CBQsO2JKJqjAFGEIRJd6RgyudaKfTM365PdnrEGiEj98Tkle
 DWgdkE505m8AZnFwMUgMQBrJgGwfP/QSL7KDp3YgM7vHrHIAIPq8bGa1/fhE9zV76JMK
 bfJWxgdTyB7NU60UEW8XpUoiICBdjmih7X3ss2wjDSNEgG4WZyRrldgLWDOmUu9eZrF1
 ltxmBXBjY+La+pMK4L5CPEfhjua11yoziBx8QOeYXRoXEopptr55VOr/F99u6egLnvEc
 PFPTgJmyiqYUJDTJPhwu7hmi5GOXERyh80HiXIsOhow1t9HLGzBaexi35d9bE9xuqcbo
 f6aQ==
X-Gm-Message-State: AOJu0YxsqF8EHPRkN7PI7Uh/tm8+eEdYT5GNldfcF6dG3oNhBRflrsRB
 ScU+GMWCINescrYkCU562921kPZDi7dZ8msx5dvF5o0GAtS8xLlasbpS4LVcUamIW2ho+3S/3bR
 BwSpnbPC6rO6Hng9MkWW15xQOMfkINJKpHKEYtcZikA==
X-Gm-Gg: ASbGncvsRPTX8nPB9ymx9w0UNcuyhzPLfnB0qkUyvRbbTpLDbf+hmFNIJwPnTRTrOUd
 0oipE31G9aFC+044UWq54QocnI1MdP25+QVPzj2Z0l9BsCqYXzO8dGePTk6F03O8ztkuzDR8kLi
 R0f9wzm7GrZQave6EqmZtXKRuIdJaRDVHeTFeURD79MdgEomFDxV+zW1VO0Cth0kSrcvX/Aefk3
 GJB4Q==
X-Google-Smtp-Source: AGHT+IEZVfhRNCMIakfJnCWYSc0DOhbFAYzyqdrBnIDVT3hsUBS4A8ChJyolMA381vWEfR45lawbY0oeffzK+CY2B5E=
X-Received: by 2002:a05:6402:2087:b0:60c:5853:5b54 with SMTP id
 4fb4d7f45d1cf-612c10143eamr10764522a12.14.1753095670434; Mon, 21 Jul 2025
 04:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250721105238.461477-1-pbonzini@redhat.com>
In-Reply-To: <20250721105238.461477-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 21 Jul 2025 14:00:42 +0300
X-Gm-Features: Ac12FXw4ifdXQz_mtl1x4Ky8M484xDkE2fhz6N5iHtzaBUrzCZJweInGWT9Lkko
Message-ID: <CAAjaMXY7aO18R+0S8fyB0ageb1D_8gd_HkFRsDE80Qa8ECWiBg@mail.gmail.com>
Subject: Re: [PATCH] rust: devices are not staticlibs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Hi Paolo,

On Mon, Jul 21, 2025 at 1:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This is only cosmetic for now, but hopefully later on Meson will parse mo=
re
> of Cargo.toml.  Devices are linked into a staticlib but are not staticlib=
s
> themselves.

Does meson compile them as rlibs instead of staticlibs?

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

