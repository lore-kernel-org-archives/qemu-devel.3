Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D89C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdANl-0001Zl-VB; Thu, 22 Feb 2024 09:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdANk-0001ZF-Ff
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:49:04 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdANi-0001zk-KG
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:49:04 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so2498353a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708613341; x=1709218141; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SBVxAd1xw+R421Krq2oc+p5N+ClgNjuUthb5mJzQT5U=;
 b=zDmnbyHDRUzO+NQJLCVCGGlI/ylzPZPNcDRKFc2wrn1VvJpHe3Uf/TQJGXqpItJeKe
 OOPBPDGsnWS5QuPK2XMgAW6TcOoIrDExZRUyftMCAH9HM4OE/9IWZBPBaYtc17D14wSe
 rQpP/IFB7RHUeRG8qbABJsSVgKzlt0mocEN03fm7pAx8YYJjwSc9DlafYw2lWRvw/658
 +VpfIEjYGJ+x8ZK9PJKyEHJNjw/gd9Snsxp0EyuamVjezycfP9qB2JA36/75YF9jnF3j
 sKUcSMnyKsE8ckceQa1J2FEqom886sIYR7rNQh25hADVJwx+37o27F0UngSUJixsE9ap
 ctiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708613341; x=1709218141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBVxAd1xw+R421Krq2oc+p5N+ClgNjuUthb5mJzQT5U=;
 b=TswaqlCG0kgK7mG0OMGgqZYEZhRt9YxAA+4N00U+lPBF+ov8JbzegSJz/y3vmUHEkW
 AcCa45NPolQs2u4RG1GsPPUOKChMFxFcgP+acWDarg/u1YoWlBeYtWl9h3X9y1HXDgPz
 166VSRs262E7IWy5qKYdZO6J/8r0gjFhMXFV+reET9RdpLnebBY38kU4Lv0mmEDeUvxZ
 GgQNO5HSRF2FgKRzUKKKPgTjeG8vVxcAnqFRvqlRCfR5VwQk9/5yjUr3JCa2LDsvOyVM
 MFAocWeV7qyz9xkcJWpB/h7zZtvgka0ZpaYWA0Zt0sOTjNXthVTkWNhFwfKwvGf3q1XF
 /edQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkQbjS+e8RGTSIdEauAEnLUoZxKPhjvR+fmM8WZJTEdYuVLzvTIUcm9ItScQBDv/vQyGhIzEDEMtNUeotLlLvYHstU0no=
X-Gm-Message-State: AOJu0YydioVatLyYAaE6iYq5+wGtv1k7W38lphrejGK8DQxIljhTMSs/
 mkJyoIou2oiNIrFD7uG0+Sh1SukvKtpykbIydb9H3tbFO7e7s2qU8O2s0QxIyFIBsViAAog2Y2D
 1UQzNgq11Pi+SUEYaKN2P6wnJwOX0mN4aRZLbrQ==
X-Google-Smtp-Source: AGHT+IEnIAco88m4IVgBZ9vL4YlGK0Z7m/1VfbIDBu905gqxa8DJZc1wLYVfKVPplQTbRJU3i8eA0x+OGJo5gxSlCCE=
X-Received: by 2002:aa7:cf11:0:b0:565:21a8:1e35 with SMTP id
 a17-20020aa7cf11000000b0056521a81e35mr2059824edy.3.1708613341070; Thu, 22 Feb
 2024 06:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20240115101643.2165387-1-daniel@0x0f.com>
 <30980866-7fe8-4900-a75b-01fe735e14e1@redhat.com>
 <5388387b-f7aa-4fa2-a65b-d3a3b52e23d9@ilande.co.uk>
 <CAFEAcA_RorzeXwHkBiq1Vjsxsh-u3ymGnJ-xY-4aBj7ivS-rtw@mail.gmail.com>
 <04785ac8-eaad-4acf-9ef0-236b3b29135d@ilande.co.uk>
In-Reply-To: <04785ac8-eaad-4acf-9ef0-236b3b29135d@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:48:50 +0000
Message-ID: <CAFEAcA_mZkCZv+2iNaC3MPOsTWU=cV8i0bn2wFLF+Rb3JyvMuA@mail.gmail.com>
Subject: Re: [PATCH] target/m68k: Fix exception frame format for 68010
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>, Daniel Palmer <daniel@0x0f.com>,
 laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Feb 2024 at 13:50, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 22/02/2024 13:37, Peter Maydell wrote:
>
> > On Thu, 22 Feb 2024 at 13:34, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >
> >> This is also:
> >> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2164
> >
> > "Resolves:" for gitlab bug URLs; "Fixes:" is for git commits.
>
> I think GitLab will happily accept either form (see
> https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
> which appears to be supported by the git history? But I can certainly make a note of
> this convention for the future.

Yes, gitlab's regex for detecting this is quite wide; the
intention is to try to keep the semantic uses "note which
git commit this change is correcting" and "note the bug
which this change is resolving" distinct.

-- PMM

