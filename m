Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FD6C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljql-00069h-3Y; Mon, 20 Jul 2026 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljqj-00069Q-WE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:59:46 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljqi-0005Cc-LA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:59:45 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81e9d8f3289so73033857b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784537983; cv=none;
 d=google.com; s=arc-20260327;
 b=s0cx1vh8bhSxlq+WnAdDv3Wedu1hfz2lLXIJLGtNf0X1ttYKrY2D0UQevf45VYTl8T
 cfa6x+mhyz4Ckr1Rvwx7EKo8xQqsWgMvWszFPPyou0UXLI18RLrGFldRQY20sppulUR1
 AoheZ/MS5F5Q1L2Qp9Mk+vm123sjUCMojjAmsMVKhAIrBEsZi9x/YnLmFmb4iK4wsnWD
 nCWt5Lm6aMswrDwP08dJ64IZgEexe7ymQDKPqjAnU0dbg/ZTS+n7ZHOV3ihxmlf/dImY
 Ym3VYV/Wms7wSqDSumc+NNUj0zkjre5+TNnT+3Wjq9wDTRMr4z0vTrvSbbar87SqTFRI
 0cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DDpyDvVAs5OPQkE4io3OJaVk90qZEK7aw6QVd7Ucsso=;
 fh=9rEtyBdtKd4dd7Ra7Ut8jbkHG/PzW0JYYUNXzZiuEvs=;
 b=swk2QP94jp7LP65tkdJrVB+GsOpM6cD6tDuIGbDqm6WaNOKJ/mq76ueJtqTLpNOSRN
 GX/W94Bp5czacSCGhEDx9fjQzs4cZwdc3EeQwDys+8sWv807bI+cpJ8GzL9we7QY+Bec
 Be6cGDpeGtXlLkkkqD1rFb35ElVHHo57Ffpjrb6rrahhrzPthep+v0xhEa0uetPna1WN
 RoxuYzisFRpi3afWs4GsZVKr+OTijcE2SKJSwxrfPLQFEjmEgiXIhaFKJN0GFtFWs9kZ
 eyLx1s3Vb2nkTxlpI4Ra2pRsKvIESljL0pmdiThfRlnEm2ks2hY2+2oJJxHZZmYgedlU
 r6lQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784537983; x=1785142783; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DDpyDvVAs5OPQkE4io3OJaVk90qZEK7aw6QVd7Ucsso=;
 b=L7PM49NNAjBpLIsrlFeir3XDMiewvVfJ3LqXBrFMwRbSocX8Yeu4BibVOmxKuTT+0R
 Za2odXBHQ4eCYCREMYVPzJT+8hEEWiUHvaKEw4jmsUeZeNSrBOksZs2hV0Koyc3KR4r3
 42zJ2NVYK/HwmM3P3PbQ3faspy4fbUlGHnvffyIz+4qSCuMwUiEGBBzzAiZI+H24SSBn
 rLlvOOHBR38ey8YSoPPPy3ROS+3RwKKpclMhotJx3YE0fgRb/bM7R8z4Z27twRq3aLtH
 u61JSfD5yWRH44gQ+SSFE9xxHnIGlFouTgetTqgITcumIRbRrYzB3dAq6HQ2+rALowst
 WdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537983; x=1785142783;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DDpyDvVAs5OPQkE4io3OJaVk90qZEK7aw6QVd7Ucsso=;
 b=PU1K7cekaEJlsuR7+SCj1cHiEZkp2DwQCgS4WU/o4CADSR+kJoGnnMvE+xo2fFgByN
 /Z0yGtWVVqkwWChANBNCwrFsKki5jcuBQikribeBoGprbeA0tWPTVf01xqUPisM/o6KC
 uvWaz5arTsWY/vDf8ntciIO4imjWGFskHTX/G4QWOhP19iU1QOIseSeZzVGLaoTiX7BF
 4WWJqxsliR0PidwHqu/DaXucHe9MM72GPoLjU76xIpVVjRce49srW4q+SZUPdIzUI/aG
 8OhPGufqr+SrIQmiUPVIaKUbvdWa06RWZTF+mcqgYI3RTFQi1QaOqmzUt+IUJPeoOMpm
 UH2A==
X-Gm-Message-State: AOJu0YzSgVHh0B63nIP6YvzznS2wJdcxAdinetrkFTPpVujxHs7mKSRm
 Fz9lAbmDjAHJQa9H+4qSCq0wD9+417Tg8c9pN+PnQTL9P0oWDKSTFqQlxCM7Wwk0SkOqO4Ly572
 BCaYV8oYR7fAtziCgNC5nnbx0b567dDL7+/TifS8YRQ==
X-Gm-Gg: AR+sD113wTSrvI5H5FRR9j14jyfVs09JxKKmmONBcQ1yQCfVn8b/6ZIfjo3nRYGXTWW
 PWdw6brGfONO+z2kReoWkn7keNiCf4IQ9B36/Vg8tF+wUfR0eSPZfnHQLuyRLDeGn32q330/SfH
 A6hMM6oLEugIJ6Xcz10ahU9SnA7IcLyN+ByE6iMI50ix20i5Q1R6QpFCNyK7nqlzhtR0k5Fjx4T
 OYV2R6GZCk6vyANzJRiWlm1uJ66eRTUVPPkQ8zb4m8RdbggAXwPdZwSpJnjaP6eeQ78lKpo52cj
 bXpIsqvPnqNnYwVE2Qi07sEcQZA+r0tmWK3bxtvnMcIbUg==
X-Received: by 2002:a05:690c:968b:b0:81e:45a6:bd52 with SMTP id
 00721157ae682-81ef2611184mr42838747b3.34.1784537983168; Mon, 20 Jul 2026
 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260709095056.1803725-1-peter.maydell@linaro.org>
 <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
 <CAFEAcA8__tL8Dh5XwAK_GifA2boh1uMfL_eZgMTFvyMq15hLwA@mail.gmail.com>
 <CAEuJdmrG_rRsivvfhEsVV+7y-q=NZ0L6hzxXPdgWGmX7OOLaHg@mail.gmail.com>
In-Reply-To: <CAEuJdmrG_rRsivvfhEsVV+7y-q=NZ0L6hzxXPdgWGmX7OOLaHg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:59:31 +0100
X-Gm-Features: AUfX_mwqKe2Go03Z75iNpP_HE16KAKy0LPbU1ZuXR6SvfVOQUT5lbOkTPDG4fug
Message-ID: <CAFEAcA-uotw_dqhV9zkgu8MkuQiPx9kYON4KjWgrnKBTojVbtQ@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Remove unused helper_lscbx()
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 20 Jul 2026 at 09:48, Harsh Prateek Bora
<harsh.prateek.bora@gmail.com> wrote:
>
> Hi Peter,
>
> I am travelling till July end.
> If it's urgent, Could you please take it via your next PR or I can take it via next PPC PR in August.

It's not super urgent, but I'm happy to pick it up via my tree
as it's a pretty small safe change.

thanks
-- PMM

