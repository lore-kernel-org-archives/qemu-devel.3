Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF55108B905
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3YMI-0000p6-Im; Fri, 20 Mar 2026 07:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YM3-0000oC-1y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:29 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YLz-0001CD-5i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:25 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64e9d72d5f4so1659649d50.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774007360; cv=none;
 d=google.com; s=arc-20240605;
 b=dCFVBbkLEyxFDc0J6WHDhPcL2nzie3+kTiDcRBGUNfF1qTxN0C7BCxKIw/em436VYV
 dv6uEIajcaZTvEch3M6bKwUiQ9n+CQBankH5KV3hD6AjeSmn3ijH38pw5UudONrtRTlE
 k+JILGGXrLpB/U0RBv4NngdqxrXNbm7VjDHXfU7E649rLk+BflefACb5TkTBU+FZ8wwi
 mQRLwC6CQBcC9lPeY/KrGk3pEa//6NEJeJD0MZOVdAbCoWpQXQbDZRYAZ2V3JE2B4o0+
 N5mg1HadqjIi/7LZBp6ROAiLAM9WxgN1IOrDWGwSoMvju2+DshNhczoTOeFH5AcEMjaU
 lP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WoD23aMY8yLYoPRqaQ+zxl/fswtroeRofKoF1+gSYrc=;
 fh=3uaDs9RIz7/N+8ChHQRMTPrWroDK9BK0lWFR0d5AptM=;
 b=FasR7kGCZZSe3HzQaCqHMkQwfe3Y2YcdKA0UHltS8vvsJVxEsgip0yWYlp0/+j1sca
 BLPGN2pAA/EcoUpgOsB+qr7os/v+BLyynX9sZTj0X6Orzt4kNkIjmxuiWbKALNOrwdXQ
 2BJlkVNTz8QDg7WON/hfsKT0HEfRtcbf6OzB7gN1fhjixcHjyJoqaGd+t0/KZvf9cza8
 tHxQldO82KRzIJaDeBeG1HOKqmlHj8zOydvhdK6uXCdi4cptfNLzu0cU2eIfD05fEFDi
 yWAxz4pndAYMjbmxPQhxVrmm9YgO/2yufvvF0lOpIwq8OkmArc2qrgOTycWCyoSV1guE
 BO8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774007360; x=1774612160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WoD23aMY8yLYoPRqaQ+zxl/fswtroeRofKoF1+gSYrc=;
 b=Y6SbPR5ePEBJSU62RqdU2YnCxaLBLLlZRqxg4kfFxvMp43A7t0spq0oXEZHPApzo7E
 CW1Nuh0PDFjYCLhPPVpr9+m4+K+w6I2NKVyaQHBK1dNvUlxYCwbm1u4RNweZe6yztaQu
 0Q0F0DRC3jwVk6VRC9x52xcd5T5sqYGCgZ3k4X14eBlWYrUUP/ayniYB4Zknzom0thCM
 d6vzrppJFROD3CB5l5khpTANf8hOb/kMHHKw+zb90ja8DD4E79cHiluHxCZ5gNI4suIi
 IWFuJW1IoqRWmMwGC2dDN/l+k+tTJ8FOuAYPvhZXJ5MMM1WzDbdraLVTcVA5RVuCDgNE
 lsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774007360; x=1774612160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoD23aMY8yLYoPRqaQ+zxl/fswtroeRofKoF1+gSYrc=;
 b=Ul50mz7pS8BoE0NsxYQSRpsuCWEtQ2uabX4EEIfK0Ok499X7nKf3iiXqUI82/kYnG4
 +oXBhuUvwY5QEnILBeyFkKl7JmUFrSC2m339E9zeP8DU2zfprysOCrLnh99H0+t3GdMF
 Ed6mt7WpWX6jkO8j7azLQTtNkLE+pI+M2guYSqZT22I8l7ufi9nhGYpHRVxtegy0XsbW
 WAWx9n+v01m68sUHzII4aMH8w7cyXmgLkkGcZUOrR/6jZssEDuu1t1k0tewKNOyuJC3g
 Bx7i49SWSp2luMzyUNXiNAWjBawWBx0GlXYLetf1KnanqgSq2gIF4CyxLNrAnq4PPSnB
 gXPg==
X-Gm-Message-State: AOJu0Yyf21/a+fTfxEV5G+6cUc6pezCB/3vJb3Z4+YTeXu2As7H2FBZ5
 bVGAEpzkDRwpam4n2WALesKPyJxRKIwOpS6kCzrWTp0bWJfQQGnefA6ED8NSOWj4Femy1d74wxL
 FYX7o+PZsPi5m5brNDegYHO6vxxZfoLVUuQvaf37NAg==
X-Gm-Gg: ATEYQzybEGC0MSylMvY5y0kzX1vu6ESEP93xiF0FtTK8MVthvZWn18FJuh7RzpT3fXo
 EUkXxkwS76qkSvitJGkFp9bUvtSW+5/Y9dAyQnC1y/lhcfdbIIMgTl/XETnep1510j9JNqPSk/M
 zZn03N36+zKG4QyvD7u6l0puH+op5pC2bO52JAnGVbgMf9VMsJ+hRGiQWiWNWAPFif6oldkJG53
 VDZeNXq4gqLNLSrLt41c0OCdvZNz+9+kYSwrzjR/zNok7LLkIkNUNBXNLeb49zOMYLcFLNjLBbB
 F+UExJKupDIkKNOmDnVkprE3s0i33K7roTte00096m70LbRJheYI95DEV2gE+8o9/UA=
X-Received: by 2002:a05:690e:1a48:b0:64e:a90b:b3cc with SMTP id
 956f58d0204a3-64eaa847e4amr2049715d50.73.1774007359852; Fri, 20 Mar 2026
 04:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260319140636.74007-1-peterx@redhat.com>
In-Reply-To: <20260319140636.74007-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 11:49:08 +0000
X-Gm-Features: AaiRm51BvMSSxU0AMG3hxgLqHf_8IZgMof0Zg3c3ygl80iBttWZUOgZ_Hv5EIQU
Message-ID: <CAFEAcA_czE=AXhMLyo+q=r6ZnNzbrUMtDatEJtCTdS1RjUpHMA@mail.gmail.com>
Subject: Re: [PULL 0/2] Staging patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 19 Mar 2026 at 14:07, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 5a68a3add61208aad34d47134fdcfd3f407d2ce4:
>
>   Update version for v11.0.0-rc0 release (2026-03-18 15:56:51 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to 2a13e310732154f75a02be54e2b32524cc869417:
>
>   hw/display/tcx: Init memory regions in realize (2026-03-19 10:05:18 -0400)
>
> ----------------------------------------------------------------
> mem pull for 11.0-rc1
>
> Two fixes included:
>
> - Xiaoyao's fix on recent coco guest boot failure
> - BALATON's fix on recent sparce device-introspect-test failure
>
> ----------------------------------------------------------------
>
> BALATON Zoltan (1):
>   hw/display/tcx: Init memory regions in realize
>
> Xiaoyao Li (1):
>   memory: Set mr->ram before RAM Block allocation



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

