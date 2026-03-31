Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107FFF60FB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7WIu-0006Tn-5E; Tue, 31 Mar 2026 06:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WIf-0006M8-Jv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:26:24 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WId-0003xe-LA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:26:20 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-650152687c8so4931622d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 03:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952778; cv=none;
 d=google.com; s=arc-20240605;
 b=ADYkJsR3n1969RrNJaVPqImNmuwT6ilWMOZG4N3SgKadHHTWkRhM33HzQhwc/PiXN9
 W5UaSD3/qqSE1IAOdwUm9PiRaNWIPqKtc5gROU3YI5y4SOTZlPzYJH8xP/ehuc1c8NhO
 xQHLpD4V04Tu4/rhFXfn5kbjJ/8FtXskFfUH/wKmjYJ+CoNwSoQ6AHoqJEMPwZTltJav
 gGAqCW7J+I5O2N5YJxPQIpRy1+HXglzMb3+RwHdyXageil6CyXtvDoaiu7NKyhxUHTS+
 4ZcNjqW6GrDI8FIfer75X2HtpfxhOEcZErKLMuUXQbvpo0TITQIL7xV/yI3afL3CXKOH
 qgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OGJakI5/s4cFR4SR+pv32nqtOZb2B8bhCrtZ7SmTN6s=;
 fh=ZXBY2hz9BZFcpidjQnPvf6P9lMbU38E2sjgurQl2KSw=;
 b=COhX0Nq5zh8YNQCoP84whbhclKCAH2BqBGoCa9oeoBSbWMTGx0+tJbHSsOYNYOpYph
 Ddk+ayh92OY8H+dvBzUejolu9pMJkucfSvpdJPE0fn92EJBI45q/ixeTQt59m3LxTm+E
 yAYQc6wuIr+xlq7UzFrOlebZbFnDZKKncv3AwOn2DHzSPh7dLDwUJVWdpZyDXULbjaE7
 15G/sAuewQjgQ5dZ9Ja4/NaoksEFzyNVnUsZCqnGfMjI2lhP9IMHbtc3l7R+93Yh/tkO
 9/fhK3KS+z/nLeMBrj+cE/SnogGUA/b4rysQOGDXCiDcd9TsoQ5gR4VVvc8OGIZj6RqB
 1jvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774952778; x=1775557578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OGJakI5/s4cFR4SR+pv32nqtOZb2B8bhCrtZ7SmTN6s=;
 b=HzXQrk+KgscWNPHhVwt/PlO6CFzXBCpC9VxMwrNrMEPXtgjBNjAHQ/Tc/v1Iqb0VxO
 LaW+Sm3VI/vJkkWhzhrdcMe7XPWilqH0s2dnMwLYymzs9UrAc349+iA+o3Jlupem0OmY
 hqaLcn3W62vx0ED/k1uWCLlOdDJYxTk451hkhfeGNQKyZdvE8ijbsv6BlEuP2zQrHZT8
 GfFBd8No6tOy9SEB+WSZByZFTpmH5mK4TMDvSJBCL2peivvP2EBasoGgMPtwzbaWDESi
 2BPkehW52cM4iS0eDoyCFMd7cxre1Ll9E4yq35nCzdc6DekJ3p2JsYXQ5UZZ3Z+VFWrG
 2H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774952778; x=1775557578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGJakI5/s4cFR4SR+pv32nqtOZb2B8bhCrtZ7SmTN6s=;
 b=rIJc/i2xS+sqCQANiUXpvlZZMH1AZnh/CQHgay4GAjA/Z9pEjM3ePVcAA4nhsH4nCw
 REKVntlyMwcTVDJ87sthhJ1eI5zPfe3JbpZ/WWLDCznoL1Iz13g98KIsGu0SxgT0GOG/
 uRVV/lKy/eUjK83tnql6eLxygBaEHaK03bH3GEhgcUyfmYmIspVFjtMDbrce3sZoWQs/
 ZuwhEpst0zj/jIhDq7wCaZ9honYGVATcDmUEN2D/zZn3qpRKyI9ig7Uv/HgTm6Gzj/Ue
 PB+xNiEgaNkKQP4wQTh+zUE24CimYC69gtnMeN1JdYHMwX9R3I5Z0IcvvuZ8QHcJ4Ws6
 tv6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GvPd5qZa4msfjrilxK5gRC5ompyxLmg32WPGO6fC/9IjMnQeG8IdUhjms1XT/ZUKPpXLk0547YLN@nongnu.org
X-Gm-Message-State: AOJu0YwNJHLEViaxrZ/ly7j+eOejzTNPPvHED0KQx99cZ5U9ncPrHqms
 XqBahbrfRefutPcERnS43DgVqy3j/a/2QbFdwAJ5xH0jkEUQgxhGyJYgB7LGLdpWBWL4cWYzWiI
 z1TM9LE4KdwuT1SxfVQ4i2mwdGDmPcQdN287bFSMC2Q==
X-Gm-Gg: ATEYQzx+WB82/2itasvo2BFe4+4dn/wdR5n8y6Y8UHnej0J6rGzHh0v7peVbmmO1s05
 UGHnhAMvLMfS9RLhkhkQyt6I+pRdtqIG7tJ+yeuSqwtfileug8Ez9DVmRhyPKGiNcov/fxZw2VG
 6Kkr6ZB++L/3KntcM/YEEroIe7eKnYZwJAMFb5/8WRG11hb+Eq53t/fwg2zVLTeghrVhe45n0eJ
 RU1FIxF0ETw/tr4rcLZvoVhbrRAAeFIfMDqHK0wDOGqMFcEAF126o1SYxxyue5qs5ps3sF77jh7
 supS/u4zeHI3inuE3xunenMnuq/7ByymClydQZ+fX4frFGizY8c7JV/D41cYXbmB11E=
X-Received: by 2002:a53:c1cb:0:b0:64e:a1d0:1140 with SMTP id
 956f58d0204a3-64ff7417a45mr12048245d50.61.1774952778436; Tue, 31 Mar 2026
 03:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-3-tangtao1634@phytium.com.cn>
In-Reply-To: <20260331040659.401397-3-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 11:26:05 +0100
X-Gm-Features: AQROBzB6Gq1PMrYoBpiPk_DUeRVKsPx7U8027JPTsJNNntCxqNxqNp_-3j_RT4o
Message-ID: <CAFEAcA9-=VKiGYMxYMTPhnKovWxYyEcTGp3+Yw3Cy0H1pDTv=g@mail.gmail.com>
Subject: Re: [PATCH 2/4] tests/qtest: Add libqtest attrs helpers for memory
 accesses
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
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

On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Expose libqtest APIs for qtest memory commands with optional attrs:
> - qtest_{read,write}{b,w,l,q}_attrs()
> - qtest_mem{read,write,set}_attrs()
> - qtest_buf{read,write}_attrs()
>
> Keep the existing libqtest memory access helpers as wrappers passing
> NULL attrs, so current users remain unchanged.
>
> Also add matching libqtest-single shortcut wrappers for the *_attrs
> helpers.

This part is fine.

> Refactor libqtest response parsing by splitting qtest_rsp_args() into a
> raw tokenizing helper, qtest_rsp_words(), and the existing OK-checking
> wrapper. Add qtest_raw_cmd() on top of qtest_rsp_words() so tests can
> send raw qtest protocol commands and inspect non-OK responses such as
> ERR and FAIL.

This is a separate thing and shouldn't be in the same patch.

thanks
-- PMM

