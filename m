Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD22C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YX2-0007vi-79; Mon, 07 Sep 2026 08:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YX0-0007uh-DR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:33:02 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YWy-00012E-HU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:33:02 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-855c26cf490so22309347b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 05:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788784379; cv=none;
 d=google.com; s=arc-20260327;
 b=ggUEFnHz8ab/bTftekg/olBWnOf5WLPYMxKanEfWoPS2adz17iS8jpHK15smSpiz6K
 LcWpl1BmD/ZB2U/PtbBPMuNzgiRvAFJ95meZXHhNDWkiVfR4YV/YY3QRVyfs6Ys1GVne
 /D4PhbDq3gN6GP/sD6bz5FMconVQMfKpT/B37dkA2ujxlX8co5sOEsa2Gh1aUZvRTQnh
 Awz2pfV5EkTpLZvVfh+TS3VRWJeblvMrvqk2UWMa0D6tGF4HvVyJaZfrQwLjdLSkzA59
 l/6DoAzLqtlR6JDFVFcE6xinrDwPvawdlUrX46F5cL+R1ucKbaQQ5cQnX5nE1wmgBK78
 fGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2n5/YrLGfR5MtlLz7jyKDpuLwVb1DlbVb3aAI30cDPo=;
 fh=+kPQWmgEukF6QZvs3aayszUXLlusYwtp+QfkPgeNqAY=;
 b=puatCib8jZpoZGeFUjYiO4GZE0UlRhs5WwUPszHS1w+GQXgZWxHrozRHXl77boVkoO
 bw0IF83BxdKe/zQIb34j+zYNBXbJTJLkWEdoLbJIeNKQpBGKBe2A9mPLEbnWXodJr37w
 f/EbPAWYHEmpOxQmVjfX2efnMfpyDidgHRCLlXWQYR+wvREeXj/4s8dYPExbLmwgLt/I
 l13+jxTMvIKsQHRfBIbGoDj4J+aFBaacb4GX+u4yHvFOq54h4UwpRGB7Kj9W4vNfQBuf
 phl7qEt66nVova5CFbWT2zRvfqZt/UEugHcAoM+NMIyLeCqD6jJ/xxckEc7ZSGJ6Csnf
 /x1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788784379; x=1789389179; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2n5/YrLGfR5MtlLz7jyKDpuLwVb1DlbVb3aAI30cDPo=;
 b=Voh3XIvFhTXctLyY4WqwcSSHsS7i/1UKnyHaM7uoQEDFcsuSjybFm3BORTcJUW8eka
 T1Y8r7qpm7BqdmcIn2GW3o8Rg8Uk2gKMN4wpJew1Tywf6KT4Dt2BMZ/zRSPg6cUQH6aS
 UpdbJiN1ot/+81NltJd1oHpWPO79vdlXW/AqtjNlDartC0aUSOPha1e5hr4Kg0DEoi01
 TH826VoFdiLRm4L9/+PQP2vtXxVzOxS4hHJ0xUT805ezv1MgNCLOEy4RS9Syx0VObjxa
 ze4N4UmFcKbG71DTPVKaUabk9F5+6Dh62+mwBkWTN4HDgqE8cD1wX+bnEMWGQ/Oaq/g8
 NVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784379; x=1789389179;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2n5/YrLGfR5MtlLz7jyKDpuLwVb1DlbVb3aAI30cDPo=;
 b=JbBU4/2hSR7PgkYVaFNpVwogp5qNtcyyxiQgMf+uE1lUvp1bxa+UVZfB27/7akwwH8
 Y0HJJBfS5p63PD/Ox1/Zk2bbCgJ3+A+DP4S8UhIhSRVQ0S0YtfCK0ebYyJEzcEKHlUNA
 PF+DDsVpZGTbxP1uk6zleYXdjQsiTz9Rz+jIyts04Y3yokxvhZox+lyQROmvgYrRaHf5
 NUl/KAwmQryfQrLoZAD4Q3iPeZ3jFJUk6NVQKQkRk7iLcpQ38McaOXwjjsUS7MI3PAX8
 sKURI5EYP9Y71gmuO1T41IciT2JqkENyRIJmXtZa/RkuJmehBQPWNlmg0TW3b6nrmdWM
 mQ0g==
X-Gm-Message-State: AFuF++l7c1+AUiNCYsyfU95B49JdvAhObeMRQZHdXf5dUy4kM7OqM5sX
 LDLzzxoCYZOJqMt4tQWKlFSMzBTpu2SseZsLf8AsBunGo6kZqnt73XLmInSqMm82PO11t9/UJgx
 57F1Dc6t2QHte5q2WGEAVSpC+tP3n+MaVBs8js1PMPVCY58q2iaZYJKc=
X-Gm-Gg: AYBFou3kMplyQsYIruxEq5m97MP4llkMlXu40nKGr8Qm3fNGXKTenK3owg4c7Adv1jy
 seUlSjQvW9drGZmE6CMhgbWMGbeZe0bersrLhRWhmXA7xz5JTuLmVpVph/CA17yUHFQi441Yoxd
 HSe3rNHusJCdKvYE8zp6l9E/2nVHY3+G5AD4Qf5RN39dJHo4wAiQ9glFMS7fbAYsa7F1ITlKr7i
 2x1dpLyVASWymiIF9AIBC5L9biPu3Iec6loAW8sOUFLGWNRyPT+qWLBM7I546MRbWTiheNHdD7B
 NFoc0ABNo1gxbpoW4dxNoIe4sQcNAm/9Vb/8tTZFGlLfE5lLGtr7kBN2TJHz/TwJ1kY/GL1EeTe
 tgyOPiVDQguGxWxfC9mgD8QI8+pey
X-Received: by 2002:a05:690c:e29b:20b0:873:5ddf:d86e with SMTP id
 00721157ae682-8735ddfdaeemr36688437b3.57.1788784378806; Mon, 07 Sep 2026
 05:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 13:32:46 +0100
X-Gm-Features: AcwNN1VP021-kGOvU2K6_zDXzNNohjezFzUUfjRM5vMhL2aK_VOhyZFsBvS_LuI
Message-ID: <CAFEAcA8r7pGv+xaC6SOnfPsT4i9N+HAhRjOCHW_+PpkrBx+mFA@mail.gmail.com>
Subject: Re: [PULL 0/9] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 5 Sept 2026 at 21:05, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9bd:
>
>   Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/stsquad/qemu into staging (2026-09-04 16:52:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/qualcomm/qemu tags/pull-hex-20260905
>
> for you to fetch changes up to dfad6f9ff1a4600893ef6b3c21382225e604535e:
>
>   target/hexagon: decode the DMA insts as unimp (2026-09-05 12:04:01 -0700)
>
> ----------------------------------------------------------------
> hexagon: TLB, badva fixes + DMA
>
> Add fixes for TLB, badva behavior and an unimp placeholder for the
> DMA instruction set.
>
> ----------------------------------------------------------------
> Brian Cain (9):
>       hw/hexagon: register the V68N_1024 machine
>       target/hexagon: read BADVA as an alias of BADVA0/1
>       target/hexagon: kick vCPU when re-asserting interrupts
>       hw/intc: name the L2VIC edge trigger check
>       target/hexagon: assert guest register pair alignment
>       hexagon: raise imprecise exception for multi-TLB matches
>       tests/functional/hexagon: add tests, update to v0.2.14
>       tests/functional/hexagon: update arch tests to v0.2.14
>       target/hexagon: decode the DMA insts as unimp



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

