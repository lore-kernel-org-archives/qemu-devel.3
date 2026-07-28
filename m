Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E4EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojDr-0007ND-Az; Tue, 28 Jul 2026 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojDo-0007MT-J0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:55:56 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojDj-0003o7-3y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:55:53 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6681e7911b0so5488179d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250550; cv=none;
 d=google.com; s=arc-20260327;
 b=hCQLcgxq7YEysSDYKmXsQXRzHPVit7aTz7H1AWwU8vO9rqY7gr+AtZT7noy8ZfBWuq
 EhzvLCR6pSz1V8Yt2TJ1+JrYmj2VShignPYyDIo6It23smY/SR6XVm45OMKuh5SfNaA9
 FUmTyvwQvwRqBKCCp31hRjmV037mKrLhxOr+eQ8hrUXRNNqPXKk+3jT/CrwM9AaFkjBO
 VZZjacGuD47IwKOaoSHk8ELr0areMFXR25cLezD0TxQcYnfYr9GBHLv8Fiqt060EFygG
 GzJh/eqreyaKOqwLQmsisRxKHPa6upqOlrPwNBAUpRlSVwy3liNFvcoxAcAPO3Pira+G
 TwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GJQ1TGNrc26Y6TRupENn91JffWnGjrQT1m5IFKf5YG8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Varn4eAtagc09kTd65EWjwp0MSl3QqW/9mITp+7ZcE8S6HHqzfU1L2+GeArzrIznEd
 aoMAGfvXfV1gNmjwG41wr7kzSMCK2RLb1u47miwZDxbhtN4EPt2jX8sAXO88SD8i/CZy
 gdrK8MTfWZYkjQsUnlsbt3BOmULrQWRwz5pyQRTioZ8enJc8SCQyI9RjzFbrKOLy9V+j
 kV24K5hw4G2ZcEPmYLIR7ZavhplUtxZUzWmnzPJyNd4teqfzdkmXEBSJsM+WUy6FF7qJ
 bIV1qbY05AzFBHCKwM4acfZAg6L3L26O4F1EKwHspEVKG7lz01HrfpJZ+6bf3yXjwIqo
 Gg6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785250550; x=1785855350; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GJQ1TGNrc26Y6TRupENn91JffWnGjrQT1m5IFKf5YG8=;
 b=Vrq4kVWYRw7XldZz9bFflNrbkNU0VeWL4ZosTUWnemav2SZURAmuxuBqZnvphKgSGS
 ViC+BEZbvCepj49IgL0Vna48hqcGhSUhGAyXlZKneQL16FNpoySkLOf0RKHH1fWFRL8A
 GFhBdTB4Ikb1AI0LkUx1MjozkHf37ZV8oSVG0ao/C1hTh0aZz+OiVbqc3DB7wjWm06zT
 FdM7F6UbsEG+UKn6aMOiTXFQ7b9c8H6mGodHDSsZtd5I1l1b2+BiLbKOAfzhNn54omiA
 KnWziaWfyr+sF3QpFHm9huozP5Btt/P5Ed9PzVpMukMhDWVhsepCUY+6zHUvwk3wuNkc
 ivOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785250550; x=1785855350;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GJQ1TGNrc26Y6TRupENn91JffWnGjrQT1m5IFKf5YG8=;
 b=HKsAsxCsxNFlSozSmZT7moaEfMnZCJfaYKSQDAdaAVGMKbxKObuNxqRzrXU5fnbQfi
 9deEcPgBZLkOvVekxRbtU+XAwzuQKgiI7+K3Z0Yjw3u48O7o0JZ9lAOIqvHhDYf8hPMd
 sMJD1Fh/0BOOv9362Txjc6WPcAjAP48LptV9TGDHUewfsy2D6CL26pYrNgG0zehXiDqA
 PhrWqxT+rDAikK6ZKOXKeYqKzhYNHCLrXeGsFzbc/rSMv2+N/xx7E2HBSYoxuBY6gHkP
 Sj04KhEJmtGYYl3JqfInEk4UsnfAeXRWzb/Q8IAj72W2EuUZFUorgb2V+kPAcT+Mx2zm
 Qn9w==
X-Gm-Message-State: AOJu0YyXLduajReRtG0v4zIMhtv53RRsL68VzXAhv8HO5+PgzhF1v5ez
 alehjsRHNyPPpht67L0WuvJvh0Wk/8HveUN/uHCkyJKZ8j80KBefnrrVTdSOkAwYbMxLhqo1U0v
 XAAmeFUlCaTk6tp2/fpulO8J13iEkCHj65Y/lj/7Sfg==
X-Gm-Gg: AR+sD13+XyqBbyV668twccvl0qM8nP3l9uQJur3lAP6DrOz5qvUA1tQTeDAGWMhBvSS
 1qHGAu6BV7GzRo14tQzM+bUnP7MqkiTk5rUfockDeY28WgugcNAtJAIdgMi/C8q6uNuQUzXSUOA
 ak3q9t/8A0tQWs7LFK+8RbmJKTl8iG2KJgCfPoGcdtsYK529wcGWRueJYrl3x/SjmdoiaC9cq1S
 nka+WQ0pnP1MV855zs3xu6+q8dewP615/8JU0eX0PUqidqBzK6WEpABUvqtTlCC7KkRH3hDtCRb
 fYd2onZR2x8a5XZGIr+d+515JCrzCREtQo8lt/Am2U28Lw==
X-Received: by 2002:a05:690e:4005:b0:667:91ba:9bdc with SMTP id
 956f58d0204a3-6690545d1b7mr1186972d50.11.1785250548823; Tue, 28 Jul 2026
 07:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-2-richard.henderson@linaro.org>
 <CAFEAcA9DCByPPCL6fSnuMYmpBALNJaktyEB8ywAU2BU39GnaNA@mail.gmail.com>
 <151be7b4-3a86-44c6-83c3-31c01dd47654@linaro.org>
In-Reply-To: <151be7b4-3a86-44c6-83c3-31c01dd47654@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 15:55:37 +0100
X-Gm-Features: AUfX_mwhNThjJW91I13_jOgsShRbYMaOORCAwpS01-NW_WNv4LmH-7a9e-2-Dp8
Message-ID: <CAFEAcA-NonwGRDc7CpQyz9HwOn-1ZVyqDra3wg7ODRvfavUotA@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/arm: Implement FTMOPA (non-widening, FP32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Jul 2026 at 15:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/28/26 06:10, Peter Maydell wrote:
> > On Tue, 14 Jul 2026 at 00:04, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >
> >
> >> +static void sme_tmop(void *vza, void *vzn, void *vzm, uint64_t *zk,
> >> +                     void *fn_opaque, uint32_t desc, MemOp esz,
> >> +                     void (*fn)(void *, void *, void *, void *))
> >> +{
> >> +    intptr_t oprsz = simd_maxsz(desc);
> >> +    intptr_t index = simd_data(desc);
> >> +    intptr_t esize = 1 << esz;
> >> +    intptr_t host_adj = HOST_BIG_ENDIAN ? 8 - esize : 0;
> >> +    /* Base in bits for op3[index*:csize], csize = (VL * 2) / esize. */
> >> +    intptr_t ctrl_base = index * oprsz * 2;
> >> +    /* Create a zero for use with the largest esz. */
> >> +    uint32_t zero = 0;
> >> +
> >> +    for (intptr_t row = 0; row < oprsz; row += esize) {
> >> +        void *vza_row = vza + tile_vslice_offset(row);
> >> +
> >> +        for (intptr_t col = 0; col < oprsz; col += esize) {
> >> +            void *e2 = vzm + (col ^ host_adj);
> >> +            void *e3 = vza_row + (col ^ host_adj);
> >
> > Having just read patch 4, is it possible to do this with the H
> > macros rather than a manual host_adj, as we do in
> > sme_tmop_2way_sh() there ?
>
> Not without making copies of the function specializing on esz.  Of course, it turns out
> after the fact that only two esz are used, so perhaps it's not that bad.  But the element
> selection logic was confusing enough to suggest just one function.

Ah, yes, we have a variable esz here.

Since this was my only query on this series, I've added it to my
list to apply once 11.1 is out.

thanks
-- PMM

