Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB8CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 09:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxMhy-00006o-J7; Sat, 13 Sep 2025 05:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uxMhu-00006S-4P
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 05:38:10 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uxMhs-000799-8V
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 05:38:09 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-72e565bf2feso18540577b3.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757756286; x=1758361086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YjNpsb27vlwkqD6z6Ug03Vx4JXahpIRVAOEtgwUFbo=;
 b=nrh5gQT1uq9S5zIAlEvEEaoCb3CT3yX5caXL3P03A4whfdXnpA2J23weunpERVkwCt
 ehPNRmbQtrwLlZ0dUZyWUEOhHXriUf9TTNf4/i1hFbHp377WYOwfqJ2Xmt7qNLWYlUYx
 W88mRjoJlF9+zVHyMZi787hdlq0rCbn/ygvuXDCn3t8ZcrAiC+CZuK9AnkbBMp7HGpUH
 /JVFQG9E1p6l7hPsI+Lty3EQlypv1Hvowo8zSjSYsGichbIToO6mBjJe9Cd6nF4xvpr3
 HkA6lm4d2HrXvSoxZeygiDiwEilXu3eXAekfKg3+8TPuOEx46DkTQ0s8hh+gQ6dWFcbP
 c+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757756286; x=1758361086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YjNpsb27vlwkqD6z6Ug03Vx4JXahpIRVAOEtgwUFbo=;
 b=uYO9jCTlv/X2ZctRuE64A6F8j8IVTo9Qqh/7jjwBQS2ZhA+7PU0YwERpbuFlAQXDyw
 Cc5frPmOuLnpDVOzb3NQvZc1MzNJNySl5arbNYURfSZLqrOlmjZOnwrs2mi5+xhranvD
 BzWlSPVzJ6UQxMB0ByOrOpPUJJXKVQh/4QPxcGTp9CJ3azbNVD+baXElf8aohGD2rGxn
 6mkmZLJsJE5dfyvPD7BZRiXgiW6rPZCbhcE4qz4a6HA+mQRb8N87fAFi5GWHjB8bwgi3
 Iadv+4jzYna4X1cF6GEpnAUfmR38mtmfAfRgROoGk+N/5yzAf346pBaU0060F6aS0dqa
 udwQ==
X-Gm-Message-State: AOJu0YxOHHa3uDH7y3elZTWYRooAPObjGRGw5+dGf+rLb+8QztyRFwPP
 9qq8QBUzEJVl+ZzxYimuZx6/A6elBCJ+mvKVIzadtJAMIu8YjpGbRpw+p95PlXZN/qtz91hkCyg
 GBgaLBOKVTcyGuLvIJ1o5sE94OiTuJgbI70qRIjih3g==
X-Gm-Gg: ASbGncs7gjdz3QRZZykAmaOkG1BFgKAUkR6eAt7GaUfjTEm3SjtSxQ5aFgsGz4V7bDf
 A/TJFODrl8OebIa1hkhMRHN2pYSrSJuHHZywsgcXGS9Qas54AgDjOmNtPacNBeT0mDcyZehQGXE
 Fl319LaYgwrekU3OKQip+/yQgTy4z2x361cJPj72FUwdcWtB67TOQqh1eKOSgVZGlhFwn8Peq8P
 pG3KcWGb5FWwGQCup8=
X-Google-Smtp-Source: AGHT+IFKtmuaXhpKBE/+oxuV+j88nsPZAcX17c9N8vw9iNp5IL2f34+aAh7c9Qd9hgMmUnJeMLA+QNvcsSc6ms4Ejlg=
X-Received: by 2002:a05:690c:dd5:b0:721:10a3:6584 with SMTP id
 00721157ae682-73062ab418emr61376257b3.11.1757756286519; Sat, 13 Sep 2025
 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250913080943.11710-1-pbonzini@redhat.com>
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Sep 2025 10:37:55 +0100
X-Gm-Features: Ac12FXwOu-udXj5_a8Evw5w6LcA9FBFobd3saC-nt2mUHqMaGjEWKEz_lnsgwZc
Message-ID: <CAFEAcA8nFU1fRFMQ_jLcDzKPoPKeV789L5iTgq-kqoa0zULmaQ@mail.gmail.com>
Subject: Re: [PULL 00/61] CPU, Rust, x86 changes for 2025-09-13
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sat, 13 Sept 2025 at 09:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
>
>   Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8733ddc08165d901eb2c87f364f814f58ab9fd19:
>
>   accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid (2025-09-13 07:52:55 +0200)
>
> ----------------------------------------------------------------
> * cpu-exec: more cleanups to CPU loop exits
> * python: bump bundled Meson to 1.9.0
> * rust: require Rust 1.83.0

I still have an unanswered question about moving our Rust
minimum version forwards which I'd like to get clarity
on before we commit to this, please.

https://lore.kernel.org/qemu-devel/CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com/

thanks
-- PMM

