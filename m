Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3453EEC047E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMS1-0003MP-6F; Tue, 03 Mar 2026 04:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMRx-0003Km-4h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:53:57 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMRu-0001jN-SD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:53:56 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9707fc11so3947054d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:53:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531634; cv=none;
 d=google.com; s=arc-20240605;
 b=A+c55NvXMVma9XRslDdlqw7rLGvm6oH9387grL7aihj4bMn1dTMvbfY2P39dnm5Gqv
 v+qUu+T9et5wRWtLFc1TdEl3CNzYGUBfHmUfpHNqnmIkMs+wu5dVhieNaybn6B9/rnX4
 AqrJUw+o//VyTzPO4jpGMDMlsHdi3efMa0n5/6MkH/cG+dsCp/3sHF7U4lkdeGfMt2+o
 JJSvgEHHGFhJ3x07XGhn/TwljyZSPD24OF2p5Syw0F/CzCkBaXuoxWBGdHJbCDLJ+N/v
 a4c1WjhPG4NVpyUZD41XKUCxssLzcCLK6PZN/TvD9E1lh4huG9Ba5rbpWiPmnCrCWT/L
 OU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=227gKOawlsnm7tDK5ih4KYObk5GmfJFuWAIKKyDwh9I=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=cRowr53187sqT3nlq0oSoq8WrYlCEd74rtTKOo1w1oqbdGWppeNeTMEB+E0gk8f+6P
 stkz7zWZKVRI+ym5kXvFhuqFXrhgX08Vo40N35QgPmCOPwxASDHYGELKA2TKMOKyBnoR
 HBxZC2MZLaeUyxKy6gbpda7/IOZq9hUPQHIK4LIJCA5zv/l9L3LJ5nrtjMs0Mae4/fsz
 I/pt+Rr7H0Jr1JmUDw1poabRkK4cZU/DTNrqMB82ImcnTMWEPCwMDZCvlCEbRQiftUzs
 lDRxBPlyPAcV+GfSmrUIvGZSgWyggJrRunvXtUoM5zfhjYa+6U70FkIuaYPPDSyWEEjG
 7Okg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531634; x=1773136434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=227gKOawlsnm7tDK5ih4KYObk5GmfJFuWAIKKyDwh9I=;
 b=h3FfjeKvusa7Nn/uHBvJtwzMX03qiMhKBiGYmMdL2MQc4EQWrujs2ehLJ3BfeUUn+d
 PpFULD+Z9XFW81StsytvUrmf6L7U4AdRdqj9Nvu4aUfvUieei6CsSs6ehhFWpssMezYE
 7fILKeExc8qZSlHyLK2BsIw+3D57QhlG4T1vCh2Vhx0K39cyfdvMgaeQyfM0pHQAYFJx
 h+Nf5K+g6YexSDsAV+ziSMtkmSEWKqcW4oLVfJaDt4REiMXRuzyZUt9wFdWu108ti2Lh
 XH+MnlyjJ1614OqOu1H1K5UuQIirXZGkYQiSOa3t4+XEczmgZctGSRgA0+JpvP1wVZpb
 Qjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531634; x=1773136434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=227gKOawlsnm7tDK5ih4KYObk5GmfJFuWAIKKyDwh9I=;
 b=WPKw8cjFJac3q2QXllDFupi/7/WMWp3vIY631t//Vt5V/dVnJ6x55D3937NT54sSpC
 LrUVF0BsCEKHJ4Jc2dvFAJsSH0GMfWz5jJJXuNa11OCan0yQjEm92f9IFuuSi0ACFc0q
 5AAPMGDoJJCOZl8sxsHLlPeewlH4/G50jSRL9JwWIVSB+vhFYC7J0rSMmeBOwpVyuwCs
 /rlZgmXchZXERMMLIyyDEzXPinpM+QEwckYHjM8YGBR1NKyVDEO3YPm6s1baqwER3TiO
 oo1i4MwVl/62UHFUVKcJPaxnTFtOedUTPe1zBc9+X3rzLBABtkesF1toJU/msJIYN0wJ
 PQwA==
X-Gm-Message-State: AOJu0YyP7FHd0msRczX5gyi6b3IxhfilxzTkpzLpEw4+Nem95x7hvgr3
 fgYqcVxFdu127A5qXrFinBQHiyEvfRCuVNORwHMlyQS3ul27P8p+UZLLqnDnhuD2leJB5nkELb1
 5y0EIu4mFPgdC0TXEtyu9SGmZnAHjjoMIUG2sU9rVTbZjuyAvLGX2
X-Gm-Gg: ATEYQzzZx+Vt8Ws1lCy8Gp8Cy8OrTaXbgxrHLc6TmPAryK0uzbXot6Ky+wvEcOtTiQ7
 e/yo+H6pRAhLMGOzf5byjFNnhwXPfnvIhTnxi4QpMKQrSD1298z47ZsyKMJJbqhZIvjWvpu82tO
 RzKo0dfsrQ3GVM7WTBDx98U3fSMv+fMCT5U37bnNOVJuXSg5xTdELDJLH+Ijdbuy4MKfmSX3zd8
 /urWTAO0wPFswd8VloOJeyfp5X/TjN/zMtgURIKre3fC/xaE6LZ4huvNt/fHzurxnQKeYIBMCkT
 SMzdZYa6Jfcd6TAJoGJXX9t18fTBfE156ke682HvwDW5eZNB0j8kXw7iUuvFEM/sx7uN/2IgRdc
 TIQ==
X-Received: by 2002:a05:690e:1449:b0:64c:b401:f52 with SMTP id
 956f58d0204a3-64cc23701b2mr12127500d50.79.1772531633683; Tue, 03 Mar 2026
 01:53:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <8959f94344869a59d57a35b4abefabd0dcb6746d.1772397447.git.balaton@eik.bme.hu>
In-Reply-To: <8959f94344869a59d57a35b4abefabd0dcb6746d.1772397447.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:53:42 +0000
X-Gm-Features: AaiRm532wlAWR54q4te2hYzpmnUT1zmlnVkl2g54i4fzL-lqtbe5NHNQjpYLP_c
Message-ID: <CAFEAcA8i4Y=3U2HQO6jDWUBRZvvgvKpX76jn_TxYbtHFuNzk=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] sun4m, sun4u,
 tcx: Do not use memory_region_init_ram_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Convert to use memory_region_init_{ram,rom} instead. This breaks
> migration but these machines have no migration compatibility guarantee
> and this removes most remaining usages of this nomigrate variant.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/tcx.c   |  3 +--
>  hw/sparc/sun4m.c   | 19 +++++--------------
>  hw/sparc64/sun4u.c | 10 +++-------
>  3 files changed, 9 insertions(+), 23 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

