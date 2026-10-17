Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4482CCA46C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 00:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHsju-0001Ec-2v; Fri, 16 Oct 2026 20:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHsjq-0001EI-8s
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:57:31 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHsjo-0000zs-Ma
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:57:29 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3a75f960be3so3933941fa.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792198646; cv=none;
 d=google.com; s=arc-20260327;
 b=G0eqiP8peeV1d9WuwoUrhnkFS+nem4vHRjo0TtGxF6Lr0PTth4CBBzSJdQh4ttH6I6
 DPLLQRDUccFy2c4MCvL/xk4gOIpxwF1X5sDL+IBOUUsag0F3bUmT60kkYU/2oBd0NL/N
 F5zsZDZ3MUGlrE7UQ+udimqpac2JtG0g9UON2hv4UAWlmLL8oziXbFi3RO5Ao+jXDOPW
 mCycZb94bdusl8QPGD5R8UMvlW/vlUBsTJGIeCXHtEyGsOSgZVEVeEABfaubgFKMMEad
 OsPaSSSfnPyfKnxR2zOO5iWlDd0AuFI0Vz73GoD0ZAY5QYbuEGB9zT7FBgpxg8ad2dww
 WaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y5WRVr40BDq1Ac3NQ1PQ6paEJ5adn+F0Af2VizxE+ac=;
 fh=Sj54uRK3vR5eKIpARMpfvWRgunEvQard6MaYBiOoS8A=;
 b=rDGwwt42hnvWKmOZMgZyzMX3fM1XWd3c34hHYCOKrdjCXCBlCYbDL/okgWH6dkr4EX
 1UgI1dBXi0BZCbPnO696KUO6dbiZQuOManxtYgg3Nd0kodYBmCf4R3sf2o6zz7I2tE0H
 lGCmiG1iRR89ii18YN2v0uc0MwQFA7cWWgDM1vEaTGarNHg2P5bpBBg9y53AL9DAFbcK
 Ay22cetLoGOojO5fLgmJMTUGzHLM+Kt2uUVIlGt8tRtvzEKqHLVhcljfQq8aUmPeaiqg
 aTaJuhWQT/yV4H7tAsAuu5fgCO+lybgIxUHUtgrfTftA9I2ingNTRX3fzYXd58uywiGo
 Mdxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792198646; x=1792803446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5WRVr40BDq1Ac3NQ1PQ6paEJ5adn+F0Af2VizxE+ac=;
 b=Af36J+9bo3O/esvf8LXBkYJZPbLldkHM4BVB0c+ll9Qocd/b1wqBe8y7ouyGvv+mUr
 IQvAvGG2wZywI9GW4lTyN9l3AqzyKthtg38Vs2fGFZkN7j9UHH89DLyKwUyhhkRsrDep
 uyd5WDEn0zvhQwtsS/ZOhhKcHVSEaxv162SKzTGw+IDmPvd14SbY/ad21xQJQDEeCVyj
 uVaikW4qqKwaavXl7ErELuyvsr9hpc4Mg/mWtoiQuL6YnQAqVpFtOtYkXHpdMB2RyAgg
 c7x2xX3CDxYoqqDSsybQhTuVOG6CMO+iY3ntvnEJyQxAz5Tk+roFsLqur+V/Vk11c9BP
 ul4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792198646; x=1792803446;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5WRVr40BDq1Ac3NQ1PQ6paEJ5adn+F0Af2VizxE+ac=;
 b=zOYtsqePf5/ljGg132rDdbk9xpaXhPT0mOhxh9vPqt7gCXU1wldqIBhHjJPiLz771x
 OdtSdZiWWBPV42WUAszOiXIpVi3isWjgNh5FSMoxALmKSYFhKUEXROHgJXoUhDSZIF2c
 3UzkQfMc+nNWUI5pCZQmbZdGni7iQvICKnof2uD9WsxY342/SK9DxrbdatTJdtZHrDkK
 jgnM4bzQnEL1aS7gI5bbfBjzDo0dp5dZ1so+Ogm19NmJ0QcGqHvfRwcfZ4kduaymdR3d
 y4G08FqzIA97FlvuNuXNMLthQw0yj8jBNy+kjqX+kz3Vrmb6kFC8XylyvRnB4deNayGQ
 fRSA==
X-Gm-Message-State: AFq9FYKGggNp6ieDjv0lKB59Yo/hlPJPHI8k7H3dSlnjIfAQ2wM1AIe3
 BBiWYxJeo7EG+TIy5/82Wj5QZPo+J/gFQhkESLzkm3RV3Am41B4hyWB9NyrXx6kaukehk3hcSTw
 GOLoIedJmupd6Evi6O8DKXcoX0Cei4HY=
X-Gm-Gg: AYBFou3Sq+iHSKKE4FVxIOTvbHJwSdUaiJIlEZ3SnAxwxsUh8FHVubzlqFuo/AxmkYn
 pjrcC7CiWs8ngIO0YzRcWvydHZQloY5tkRSYfvlBn5TwXxYxwwG8KzPo7gD8x+UnXTaPGcbCSfI
 pu0vSHSjG2cMhafnTCVUhTDxQoDazzH2Hos9qYGpRXbBpfQt7tACoKUdH9tZfN3iCkplUOv/dkW
 osCIrhxzj8SxIfLddw1n++YDQ8+HyRjMdP6nlwQztCwEPXsP7a8q2kM5PbjX3Hmtyp9bkZ2YQW8
 N77Ghoa6HsFWoJJI2XfqZd3GGjlhscuQr2f1ilcVoD0NjrMzgQWMnXraNvi1AFTX2rTzxy7QW4n
 PyWX1BUelnV6DGt7j8bvL+cua6FNzJ+7L7oZzDg==
X-Received: by 2002:a05:651c:19a4:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3ab29121df4mr3018291fa.9.1792198646122; Fri, 16 Oct 2026
 17:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
 <20261012-alpha-fpcr-status-s-v1-2-bc7efa6d5609@gmail.com>
 <5abb88a7-ae1d-4a3c-80f2-90cbcefe2d25@linaro.org>
In-Reply-To: <5abb88a7-ae1d-4a3c-80f2-90cbcefe2d25@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 20:57:11 -0400
X-Gm-Features: AclHuK_1PEn9aDHd1d-qwW3BDCEtrTSOrZ0Uo0mUbhY6JsWVfoQhAD1OteIfRCE
Message-ID: <CAEdQ38ENSZKPcOorWZO8p8bxs6B3xWdjc4tADthn-umDNjgjSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/alpha: Determine tininess from the delivered
 result
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Oct 15, 2026 at 2:45=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> You can't talk about what the kernel does without testing
> CONFIG_USER_ONLY in there somewhere.

Right. In v2 the float_flag_input_denormal_used check is under
CONFIG_USER_ONLY. In system mode gen_ieee_input traps before the helper
runs, and with DNZ set the operand is flushed rather than used, so the
check wouldn't do anything there anyway.

> swc doesn't need to be computed early -- ideally neither would normal,
> but that would require two helpers.

Fixed. The denormal check is only made once underflow is known to be
set. I left normal as an argument, since the alternative is the second
helper.

> Is it possible to merge this with soft_to_fpcr_exc proper?  I see that
> the comparison results wouldn't have a result value to reference for
> normality, but they never raise underflow either, so you could just pass =
0.

Done. soft_to_fpcr_exc now takes the normal flag. The S and T format
add, sub, mul, div and cvtts helpers pass float{32,64}_is_normal(fr),
and everything else passes false.

Thanks for the review.

Matt

