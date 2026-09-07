Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509A5C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YWq-0007sM-PX; Mon, 07 Sep 2026 08:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YWo-0007ru-94
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:32:50 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YWm-00010k-HT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:32:49 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-861a2ae9c51so40328317b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 05:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788784367; cv=none;
 d=google.com; s=arc-20260327;
 b=raCbS866CDtrJtN6/2ik3KPzGBUpevLkr3tzzKdaYOdRh629UkYUSiYMcHctwYWSz6
 AW0o80KfCTiJWDRlJRdZ7HI1Jup8vyRwDhfoRDKBGfHRsDxhIjpKEzT6RoV1odMRxBVM
 brt4SACQcGlrPUEKKyxv6/kMTWrVoIDco2GcNeeaOueYco1Fy/bvoUBWElE0iqzzERsw
 k5N1Zl9QkU8YJdwUgGTIS3hB5wGUHzprbEAdiLm+F4p2MD8POOm2G1s+PO31odFTtqqX
 2uFPOkuKef4FDRrfbHNEZgOucuD+EueVjf4VKdL2GZrS9yupCHBV5vENmcoZnGQSR+rq
 Of0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ucueBujnhW9gMXFdp6JfTa7sZWvqgIpPio+3+x66+Fw=;
 fh=ZzaMS4VZBYRejrBhWKA4z2JNmaUFR/coaG9gyzV/AeE=;
 b=hsZghg1cwoHP0LZcJnqupWT1JxjhJklbE6JA1m+17eFCjwu2i0LtboI+3QIGntFMy0
 u2iJOzfm9t3pwguGlTAYeByh0UZ3yQ0HCXMrZOBLVXy7B/pCdsuwsN+IdDfp7SNd5lUY
 YIAKKc7FOm69JmZehOJBTTAUhDtgfKAiEY/MMlBNHF38jQDl92cFi6NWTVIZACcI99k+
 M2MQ/2GSZa2ArmHZvo6gSsitRuXaT145nDxMTpl3GcVRJisX8srD7gJ89TCvTdxpUvrO
 bK7ZKnIvny6zNGTo6yX+tWhmLY7P5NOt3Lhxe2dGtw4NhMYmVosbCeN0V+CalPUkBORg
 AC+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788784367; x=1789389167; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ucueBujnhW9gMXFdp6JfTa7sZWvqgIpPio+3+x66+Fw=;
 b=feY+GSKtlkpElgx9FT0k+PW00Vp1iocK2fRD/Cn7NiuhH7MA+fX9uw1+5mKvlk7XYU
 +KCg3cPXhSjjIaUF4tcTO9l/V3gfXxcrDFexKxvjfGTeS2p2LZW5uN2SffNnh6eniKIO
 sFZlct4Co7cUXMsurISYW5ARkDDcerVj8IJWElTdRylahyT0sd2GJAx9JYBaatHygRgk
 hP3NTHneydbKi1mgFbdhcXJqh6BkGypsWf1A/Hd3AfhLzb3OtBTL6T3O7FVAIBBk5Yv6
 KbL4QAbvSZtwM5otu8KgkADc1PrDSvx0al0qlLsp0mk6u8y9Ium/J3doUI24+hn+vjf/
 6FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784367; x=1789389167;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ucueBujnhW9gMXFdp6JfTa7sZWvqgIpPio+3+x66+Fw=;
 b=Amm3vpVBhihphWI3KYn1ltrBxTjGnoV53Zzq+HgDmBr5vDHwkcIGR483dnXn6KaM/3
 ssOLhklMZPnoJdyJMpLNBa6OypSVwniBo8yD/q0PyxwmXqV0+DwYiMBjtDYFonGZbRLK
 H+/D+63wDMRKxUugvSj+29DexSePepJvXqaJAAOrHwP3AC7e80H6IYUWS8fBk87AIsM5
 KxjU0Xrf03m77ocmkwj40HtPNxAql0sZeJFTWFTEoWnQaYHaEHBtWnXk6QEfs/a+KG6H
 z3qpqQoxEN+KFM9BgPykxsVfMw7268TW8TqzIo8uhEQkHe0gdfe6N1sSxMqdkJrg+mEf
 5ywA==
X-Gm-Message-State: AFuF++ld1vS1SNVIxlLQ3pbYZ8wy/bqjnfLM29/jJsWuGhagtjhgOCN8
 MuhWtmp2w57eZm4GRNB8NlA43ShhRPQsjYzIAFPmHl8JwSZXRF0xWA6txYWkup0h0fytHCCfYxV
 Y5NZoVMc8mqEVyODS8wmPIN4HW+SgHRc4pG6iZ9rJuQ==
X-Gm-Gg: AYBFou2/eTnkY7KTW0EiW4Uo3CdQUBu8nlfq5DAq+qmaRLi5N3Bg7ogHmJGRB04DjkX
 kiE2DxPG6suHQ9YT9phXU4bMBKIqKCedaqgYD+9kUp9MJ3gmk8xppnf+mLw8gw/t2zoI1/KZLR5
 WQwOmRAdlO2HYOZuslr7a1Z5I0ySiQ3cUKptXckb1LbG2iEF68Y+mam/74NYSbMPk5Vw8RcbRbm
 baIBIZmWAv6Kdyavbk1dXJhjCsoBV7+shatBBVJSGnvvKU0Priy12vT0kAnJTl+JCKcwxEu5qz2
 anHbWdt6pb5BeHu48wBhooIqE+jRKMWXjIZBrRvMp+QSIbA0MLq3jaJN4p8/If7S/iFRlgE9zRD
 +6UsN4676coMxDy79DPONabqopP1k
X-Received: by 2002:a05:690c:4b83:b0:873:5bb2:6c35 with SMTP id
 00721157ae682-8735bb27306mr49121527b3.60.1788784366576; Mon, 07 Sep 2026
 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260904201034.2811585-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260904201034.2811585-1-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 13:32:34 +0100
X-Gm-Features: AcwNN1UzaMOOg7Q6xlgHtJB6dUS27t1Pxj5YMlR6umFlX-20ONg2UJrXaxvSFZU
Message-ID: <CAFEAcA_11LHRxaFH8dGUXwzbG_HSaBe7KnCK2v1UGCkYEtsN3Q@mail.gmail.com>
Subject: Re: [PULL 0/1] TCG tests configure hotfix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 4 Sept 2026 at 21:10, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9bd:
>
>   Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/stsquad/qemu into staging (2026-09-04 16:52:58 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg-tests-20260904
>
> for you to fetch changes up to f7b7d7270eed9f22110f2a2c0d4bb74b92f991f8:
>
>   tests/tcg/meson.build: fix build_test_depends (2026-09-04 13:09:16 -0700)
>
> ----------------------------------------------------------------
> See link to series for details. It might impact anyone having
> docker/podman installed but no cross compilers.
>
> Changes:
> - [PATCH] tests/tcg/meson.build: fix build_test_depends (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com
>
> ----------------------------------------------------------------
> Pierrick Bouvier (1):
>       tests/tcg/meson.build: fix build_test_depends
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

