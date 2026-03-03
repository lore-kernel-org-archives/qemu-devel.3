Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE8EC0480
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMRH-00033e-Vp; Tue, 03 Mar 2026 04:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMRG-00033W-Sx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:53:14 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMRE-0001D6-5u
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:53:13 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so3893939d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:53:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531591; cv=none;
 d=google.com; s=arc-20240605;
 b=AU0h/tpJNJ0jdmMAnr01IyCD8gUsTLq2zaHclP2WENATJWbh+8YNLqW/0DjK8wGs3n
 p2hzSyXdkbb+eqCUShGklmwNf6km3a7mOWZhA2jbvDNFku5sPmHdlcR3L4NTxeeBj4A2
 CSDSWBsRwYpM5dEH1F9DZXSaWYsa6us0qmDz/AJnxYbzmhEkmUlYEefxZdkKULtzClw+
 0bQsSERh1dSxBKeSlLsJNtkl29Oz6xfZ747TWYs5Pv0wDxBGwD71aE8XyuFk/0UVvDvY
 ADGdWG9Bt0/TkhPcD1AKV5wxzAXO6eX86kBxbLiO/N09ANPPmY+ov9V+JUS1qFzv14sF
 AkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rNHbt+YfeBtPLriqD5NILhZWEKeHFTSTkA74JVdvc54=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=YBGbqSzoXdlXiVQs7Azk32SoELqT3Zx/QNU0/z2mtEMKJoxBLOhAFkt3etqOa/1d0x
 tcenaa5Y9hWyLNNhKG1HMHYTW14JtPJS5UlEB8F7fkL7mCu/O1Tmg4o3QMMUhvxkzM28
 gf2KyJtha7UewfUxewltQeJ+bg9AJm1BS2/4AkbtASl0vlmWLeg02UBPnKnvOrHtQS1u
 8t/qccrMwChLBicMVMlHIyXPjd9AuEfYH+1dSuuaEuCL3xidP3XRGH8ELuj4/ut2x3Ak
 Jc8UriTt0BasYlzum7ll/Kcos6VbwG6HMjhL9imF4awec3N9MARrb0wMA+CcN6EF7uKa
 6fvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531591; x=1773136391; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rNHbt+YfeBtPLriqD5NILhZWEKeHFTSTkA74JVdvc54=;
 b=BDjHn2whRMdeMv1we2KzeFrqp+dxGCNKv/JH0U4FQV7prcOjxCifXlZ/d7aBcIoltw
 Bg8NYMH6cwRs3Vi9XSNmln08k7cdlh9c9Z3QUQhXwFULVSP9J4hhrAfa3C+uA2EV4SGk
 chksME0hTxvVRFoWU78Ei4JhwWFUm5ys6tLJKqEUdzyOsnSUhtemS7ZH7pp9+/e43hK2
 1i1w+Dj4DnKRHeU/ViKd3puZNVlBat79a7ij54ArN+Q7cpjvK9N7S9dJ0DKfzt9ukjLD
 JblnwWWfCDgnn1N6YdNp7unbpnYgckS6D3X6MBHvJj9Y8IK5E7rvL16VzyobyXgkGrUL
 gCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531591; x=1773136391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNHbt+YfeBtPLriqD5NILhZWEKeHFTSTkA74JVdvc54=;
 b=DHatMRnLCI166iF7ORJM3cA1H3RT76n/YzioCLCCOsOB7MuceWVtRS6fxN4sUnVQKo
 8YwqTiEbLhJtHsWCelv/AVdD8IbyGXTVxSJGNbwUwBHOmTcXeoymd9F865k38bzUfcpu
 sWAkmeh6Nhy6dJm+2af5n4HK89LbECy7/f1m1ph1nx51lO966Ze5aDjG8fmpQkUZY68v
 caRTZZYCFO7RbcLhbVKWJmAJikS0TUu8GdyKgmdt7wneUtIBYHyZp7HNuTAjJ+6lUFEg
 CISiJY4gII5y52hwkAH8VGI4eQFoUgNrw49AjsETIxzHJsW2W7MqiaNMTt5WhzNQi7ng
 I+Cw==
X-Gm-Message-State: AOJu0YyNclim09PcB6tQyq8rQBtZm7TcmwhGNyFYMXV/dpLbXrXp5p4S
 IMZBhIqmFoKzTseejOVjfusF0u+WR2TDrzCFjSRYqxMmtmZgs27/TXyRi2JYwl9AwCyAL7h3khz
 6XhQuW0CLMxSiWqWPEzrMhmbREJv5ZYozlpT138D19g==
X-Gm-Gg: ATEYQzzFQh4Z4tDxNt/gYJCMPNA/b4J7bQUm15tnYV7lXif/abmGqvBe9papwfb80NS
 SB3uXmK+sssaqG0sarTQVWSfIaAC7PuCYfsAVuAPdJSliFRDWzVNGbgpJByH1r97Zj0sD3GBmtm
 +CxM+v+l8VIjaMYQbonVJ/IqA7KuOYH5JLSCykv68+hFuIHpK3lHeWH7lRLc5tsz5EDBiDF7+e+
 OOu/3XZv08z23Rmd5Eh3ZAfEMLD3enV7tx4YFwNvJZrpEU/cbKqy6TmKpIDDw2z8jDUs+3Y2m6f
 NrzgP75oSDkcCzCE2mRuP4kOCeugr5cBvDE48Eilc5XGKC47GGNe1BidngvXq66o6E8=
X-Received: by 2002:a05:690e:ca:b0:64a:f2dc:2849 with SMTP id
 956f58d0204a3-64cc2180898mr9604281d50.34.1772531590902; Tue, 03 Mar 2026
 01:53:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <07a4aa13d7822e0d4b93433f65d781b2384d3d2c.1772397447.git.balaton@eik.bme.hu>
In-Reply-To: <07a4aa13d7822e0d4b93433f65d781b2384d3d2c.1772397447.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:52:59 +0000
X-Gm-Features: AaiRm51MqEGXVSFx8iZHCFaEn8MkwV6qxsTpjh0mf0evlWj7rMbn17W9IWpcX7s
Message-ID: <CAFEAcA-p-WYNOFN2fpEAc_RHNRaG2Mnuzjijf9RQhPjeT90pxA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] memory: Remove memory_region_init_rom_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
> All users were converted so no longer needed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  docs/devel/memory.rst                         |  1 -
>  include/system/memory.h                       | 26 -----------------
>  .../memory-region-housekeeping.cocci          | 28 -------------------
>  system/memory.c                               | 19 ++-----------
>  4 files changed, 3 insertions(+), 71 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

