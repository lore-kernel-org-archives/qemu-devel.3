Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1607CC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG8k-0006ox-Dn; Tue, 18 Aug 2026 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwG8j-0006od-BE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:29:49 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwG8h-0002r9-TR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:29:49 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-81ed2a06b9eso38115007b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787045386; cv=none;
 d=google.com; s=arc-20260327;
 b=B87PW3ClpESKi0UIVlOZhe2p+MBhTssPI9HUbCHGmz/xplANWIq+1vgiMJJD288PvP
 uoO/Rk7Mr/Czx+POBz55AT9l7S7lMkuASeeSNptNPKl1Z/Mf3Eb60eH77iBPUS5j2w2m
 8HdpUGlQzLWQkm2cuGbEQC3YtC0MdHJA05tgWEu3Va96UW2jirTVUJNQW66WeLqEHSy3
 OJrsxLubdRbMBiHiQyTJ3ROp8ekQzDAd8Le+Pmi/D5XOZQDVJpZPyiaoqrqIghyqf5xC
 lEQWmVWlqeiracdUb8sfyZuH0nyqnSr1Utscyo+I29ikS4BpoOF3oyIVyAiE6jRVSYKT
 3big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=acpsmQo5GOEW/WZX3jGf4E13w1binadjxOjYSct83PI=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=Lcer331ArOxLE2qqQ/TGzkjOU39iqCQDWscBeTliUHwPb5Eqg7/cQ0jq9ZaOpBS1wy
 EJoAfmvBcrTMLM0LLsIYifuhH7WgGElGfWCbPMLqr99xhk48D45eFqqzg4VY6/jHvhAT
 1WacfW67rmS46NKGffoT89UDdMERCj4mGHKpA94TximkHfLlVRwDofR2HkRrKwN6vEvt
 dsRen4vXZhNI6oTPoIRPssJA9HAJtTpJLgBJqCO8BNt76ItjGIzZ36UrNiAAd4+uMIfN
 YAuhouGqOxbfTfTv5LWuhrUs8+8ewjwGvsyzn/CKcv8eagUXRtHfg4RQMzE6LNB22fGT
 w8qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787045386; x=1787650186; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=acpsmQo5GOEW/WZX3jGf4E13w1binadjxOjYSct83PI=;
 b=qf29ZRLJla3X1674naviNUF4LVoPcOm7THuXjQbgJsVIk3heZO42aCohkrfPPXeu2l
 n1odSLGMx6exniZdoj9nGADEx2ObDJ35gMVlUN+Cxscy5z6IslsAvTa3X55qZn6n/f2O
 za5nBaOuarmzKctdXTLZHjgBtg06P6XW/gasSIVNjohFMnXEFylBi3tMAy4HXkF6wKri
 FOYStrI0f01SNBNLZG19hsd2LCpv+nPpoGBTG0linObQYV9Sv49yvBDUS1tye0Mm8r6E
 Oo+OP/kcA1CjEKYMmIwiWOXt9/QODIQReJY3tpL9++lug6UBUE41ggkI1KES3VJhSZJN
 FusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045386; x=1787650186;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=acpsmQo5GOEW/WZX3jGf4E13w1binadjxOjYSct83PI=;
 b=qD9y2aC5eYSNLd40ovk/vIIBqck1mZHarVZQIOMT3dtzQkh3N5tuacYv2+AnpUSo4V
 svF4jmLMg9YRGPvOT1X41W2Kh1O+OP4PiHSTy0hWgQ/BLoFrGYr7HWzYsmQmtFhtOzPM
 fbEblVFpCj9UGZRFhF21mPlnSr7JHN4UpmjQg+IG1Wy9iLBB2SrGGRxhvSR0ScUeI+Q3
 lc7mnrstBWW627dI4KnojvTj/QbOVNTR1oLATp1CEHiF74VqBa6tJTiehHlEDFD6PceR
 JY4moPPVK6BbwiOe3PArL15J3JzzlcLhOjdOETs6vYNtE8YmWDT9cZO7GUv/S9/m4h3r
 Jn6g==
X-Gm-Message-State: AOJu0Yz+YEphrZEpoiM9nlY8rA971FAGrJAyGxQr0+uvj/4zZH9zqper
 kJeV/WUr+Mjl72Yx8HjfrKQGTl3ZJpXJkZkbfVzB3BGByTkPFa5PYwq7XW6StFgr/T2KT4wB8Yt
 fY3LsSs3MGr7H7P0kbKKv1tQLQMzr637duJ6vlUQlcA==
X-Gm-Gg: AR+sD11KGyd3PkZrI0XAzj3UDCHwE4gzDTk9COgk7Z7wA1/bUT3w7PPuf6V5697qzdd
 XyFO9f+irQd/kSGD8IVY1x0keIkCl64tQqaAd63WjQrDqBYtWEj3IzBbIUTmwKmaaVZC9usCp4q
 e4Ty3P3sjEb+H3oBl6ORSgcWOieTQvGJf9jv0TMKX6TxsE0LzwlFM5cjfC1W3JBw3zsA4pnjyh6
 BbbFXIKvjtteFvDui1Smc/T1kj3m4gXvlRWPjbHaaq063B56lKMVeBzYO57kDumAXBzBlhRk1vK
 t60PTHfYy7WYxROLEKHVPvEvszWgui0UbZ0qXVFMyetTBJNhg0tPHjAzEbda8eQxIgQel2+cGQi
 AYoa/IJmjBPviADc7pxGy/BHJYJ+Fl/62sKH1fj4=
X-Received: by 2002:a05:690c:a647:b0:821:133e:569c with SMTP id
 00721157ae682-8370ee56bc8mr73341087b3.15.1787045386163; Tue, 18 Aug 2026
 02:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-3-richard.henderson@linaro.org>
 <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
 <c931ce6c-1146-4bd7-8769-02e98ede0f82@linaro.org>
In-Reply-To: <c931ce6c-1146-4bd7-8769-02e98ede0f82@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2026 10:29:34 +0100
X-Gm-Features: AcwNN1V8AyuTKCsIhsj_dmipidSbA9EqxoTRAzihnDxe6PsaJbTM0RBWClP7Wmc
Message-ID: <CAFEAcA91Gc7-n2SBvA-+vF2PemB6gqWFKKsoS9EPZ4Ks+N7awg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
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

On Mon, 17 Aug 2026 at 23:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/17/26 09:37, Peter Maydell wrote:
> >> +    tcg_gen_addi_i64(diff, diff, -1);
> >> +    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
> >> +
> >> +    /*
> >> +     * Since we're bounded, pass as a 32-bit type.
> >> +     * Sink the diff += 1 from above into the 32-bit type.
> >
> > Is it worth doing that? Hosts are all 64-bits now, and surely there's
> > not going to be a perf or codesize difference between "add 1"
> > on a 32-bit type vs a 64-bit type ?
> Technically one byte difference on x86_64.
> But we could drop the whole truncation thing it you like.

I think mostly my feeling was that since the rearrangement of the
umin() expressions above was already quite complicated, moving
the last part of that down into the truncate-to-32-bits was
adding extra complexity on top. Just doing the subtract-one in
64 bits and keeping the truncate would be fine, as then the
two steps aren't interleaved with each other.

-- PMM

