Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E8C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Oso-0002wj-11; Tue, 21 May 2024 08:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9Osm-0002w7-Eg
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:46:20 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9Osk-0004bs-NN
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:46:20 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52449b7aa2bso2381161e87.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295576; x=1716900376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wjD/zBnuMxSr/SgIy71Buwk14pUXAUQMnv20Cgg5NDU=;
 b=HQcTxIDQH51sWOyCgT2SYvt2rMVONTrZKsmMhIE31W73j9YAIVsBSRAhPO8+6poyGp
 xtja498ldKLdMBaT4NS/VsBPBIR8fqGcX7yIYu5dnhAwCBZne7qU78yx3AgUb20FjpSg
 4nV9oUR6NB49y9JcvK1MxLQNnl5Ujx6vWGwkxkMYKUpQ9tJT6aXpxYbI1aPpwXKPDaBQ
 xYMnc9iGiq8U/5mitN6zxECyN3ntgVxSY9dHSEJLGTE9s1nuxggM4WMblrJLu23DdNAK
 h4DU7K8ejP/q1xwb9E6szqPCzjtt3aQoK8k5Kp4POUEbOnGXYMh+/Wlro/7eHsepPcAQ
 4u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295576; x=1716900376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wjD/zBnuMxSr/SgIy71Buwk14pUXAUQMnv20Cgg5NDU=;
 b=HhZZ4L0Jc/s2zXnLwRlQkTYlIEjY+/hbH48eU0oKoBbnlBzGwjnezI9IjAFWt2EQSJ
 OFjlb90GrgqGKM0mArcZgrc+KP+7/4cWoe3it8XwZAHoC0PW9ncFZEgdCYC6Ll9O4xNF
 +v36FS3L/sht90qXH+z/nQ8xlkfTeQRkuUsWXxjZKAgkC7UM/+uHmaAyVmc4w3+pNt78
 AazSKUc3LZtP+SP8+Isg19QuXh/UjSIzd72RctEnWSgl6AmgeaaYm1fCEYAFS8SKxiGu
 wTf3/Sc2fQcQnzo1vOHkmR/W3ze1wB7UTbU+AIerg27wEhkzFO+OtbRb31tdKXh/oPHO
 5xNw==
X-Gm-Message-State: AOJu0YxQ//jmRK1MbRRyg13G83Eb0BDfsqFRSQeBSLmSeHLZJB3SztBq
 qi5LH3bzaemusa3AC8cBL9431fja2hkq1QNAlJjkpsN2DBhBh64OD22wHJQJZV2TAqm9xtcmDB9
 umQ6+wpFa7Z72JfveeXBiRn6fy6MInFqOWpJxqA==
X-Google-Smtp-Source: AGHT+IHYS1XUbRRp11id2/7v9zPhO8t01Y6TjFQiVqW5cII6KnPfI2MWtXr6juGLyMJ6uDQQRN3EGJHGgDBoGla+4hw=
X-Received: by 2002:ac2:43ca:0:b0:522:386:cea6 with SMTP id
 2adb3069b0e04-5220fc7ad54mr18160380e87.27.1716295576508; Tue, 21 May 2024
 05:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:46:05 +0100
Message-ID: <CAFEAcA9xjsmhA2uwSpwDqU_2Nmj6p33AqnM6iS_PN2dj0tmYUg@mail.gmail.com>
Subject: Re: [PATCH 00/17] RISU misc updates
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Some of these have been sitting on a branch for a couple of years.
> Except perhaps the first, which I assume to be some sort of odd
> build error from the time, they still seem reasonable.
>
> There are some updates for SME1, but not yet the ZT register for SME2.
> I'll get to that later after I've done the qemu linux-user work.
>
> Finally, let's start phasing out raw binary test cases.  We can
> make it much easier for ourselves if we package test cases in ELF,
> which "objdump -d" can parse directly, without having to be given
> all sorts of "-b binary -m some-arch-flags" etc.
>
> For future work, I plan to make changes to risugen so that it writes
> out asm files and invokes the assembler and linker to produce the
> final output file.

Commits 1-14 and 16 applied to the risu git repo (with the
commit message nits for patches 1 and 3 fixed).

(This isn't a "nope" for the elf related stuff, just to be clear:
I saw Philippe had a comment on patch 15 and figured it would be
best to take all the easy cleanup patches immediately so any
respin is just elf bits.)

thanks
-- PMM

