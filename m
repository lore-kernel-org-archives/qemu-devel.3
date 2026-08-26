Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535B8C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8QT-00015s-IH; Wed, 26 Aug 2026 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wz8QS-00015j-5O
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 03:52:00 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wz8QQ-0002Nn-8P
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 03:51:59 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a3efa2b38aso1162891a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787730716; x=1788335516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3O42mUmn9pj1h2jh0OfYTzRJ7bah3Nd046rH+gq4DaI=;
 b=duw0tu5TravdVt9nK8yl2TBqpsxc9bQXM8fmH721/dmYr33H4LO2DIY/T5zZnaqUzK
 31+zct0MZUAkeEdcTxeRdTn/sA6pXMSjE6FVtysXjTFlvAFSpUUNX+Hr8QBhmxETCwqh
 Nm//x/mZQwCJM6avj7b+2pIiqIMMTj0iNX3kjyA6pdbL+qibkqnfGHWU72RC5zv4HzsJ
 d5s8Rfvw3y1RkkqwjvxMCB3YZ9eafRwYzPi0ctZCYpf0plGHZ4uHLvbndHalu6CXI+YI
 nK+uKFSF1zkIEXiPkOQMXgyN+RPUPUFcz2h3MRgj68lakR7Qq5+qA/LukvOBRH9phWFF
 Qe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730716; x=1788335516;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3O42mUmn9pj1h2jh0OfYTzRJ7bah3Nd046rH+gq4DaI=;
 b=oIzdccf0Pg6LqoL+5CPsWj1bf6FWY1JcJ/xrp6NI1YjbVymYIEKJJeGFFWpHOEtyS5
 6ytaSQIFmDOQsFlp7nYos+Cdr11KFL1LS4teD9QrZRGgUDIZxf793wjO8Oi55GEle/TL
 hYstVb3AxGdQl1Fz24XOLkjEZa93KTTk+AwBaNNIf6fmkZpNfGj9bbw3gSyj5xG5Ybvj
 MSGRTjv6bS4v6FCAt1euS6EKh7mLodYkvG+G6UP/drHlcWl6bFDy3oFa0/E5HEGYxt9L
 j3tNuce7Sr4+0f50aADrb6RjKQHBsO0hM/9KGdgQslMP9e61z/m3q153LEZpjrslVYRW
 xt1g==
X-Gm-Message-State: AFuF++lszAZmGgBHz9NHMYPPypEvmQOdIru/gJA1GLQfKBe09LY5OwNq
 gorkMaRrYkIj8pbAYqK8mqosFtvoOlojhgg5l40CXyMwD9Gy8BEEiP/ptMvyBkVGngA=
X-Gm-Gg: AR+sD10SAMi2Wym8bfMWVJDRbJUmxSFSJE37N3YhQYb2OxGnuTy+2ZyP0Sa4eI0rbXz
 f/jLJQBx2ExXHeOs7YZmWjHq/ti7xeSGF+ZqS1K1jb+VqjlczyseriHpj2BJ/AD5hEKHysfpQhp
 z7ctjPZHg+b8+J5Dq2RRAtycveWYqK3f1FuXXVPdgKqd/AHHwLSJeF0AbVIA8BrPHb2X4DIoGzE
 kD3fUIxtpUdZIn4wNsZney3WYc17pHLOwlukWoCHyUSsKpHO4J0G4KPQqbg4RKFsPaEhqGY3fkn
 FYYs5brZ3p65GaFDuZUPPmDqJqYkjHDDNK8g/hiIjZMUCv1Kpu+/csnOlSkLFGQ5XX1iVD7VfVI
 1iws/wWoA9egXGbGmMTQpShx5OwlFZPzNdMk9+NsxSseqckGIevBnz0BhbKHAXdiIC3unRuws/3
 2MtQMT5PJTv4+H/egTaaeK/mFMS0qbxZzwa1UPGO5KTw++tn5UIm5i7PjNzbNL
X-Received: by 2002:a05:6402:2742:b0:6a1:4fc7:94b3 with SMTP id
 4fb4d7f45d1cf-6a5df5b04b8mr6125617a12.1.1787730716150; 
 Wed, 26 Aug 2026 00:51:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm3938380a12.21.2026.08.26.00.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:51:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E34635F877;
 Wed, 26 Aug 2026 08:51:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  philmd@oss.qualcomm.com,  zhao1.liu@intel.com
Subject: Re: [PATCH v3 5/7] RFC: accel/tcg: allow cross-page goto_tb
 chaining in user-only builds
In-Reply-To: <20260822190818.1829249-6-mattst88@gmail.com> (Matt Turner's
 message of "Sat, 22 Aug 2026 15:08:16 -0400")
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-6-mattst88@gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 08:51:53 +0100
Message-ID: <87wltdpbdy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Matt Turner <mattst88@gmail.com> writes:

> translator_use_goto_tb() refuses to chain unless the destination is on the
> same page as the start of the TB. For guests whose text is much larger th=
an
> a page this is expensive: an emulated alpha gcc compiling a 255k line
> translation unit takes the indirect dispatch path for 8.4 billion of its
> 34.2 billion TB exits, and a large share of those are ordinary direct
> branches that simply crossed an 8 KiB page boundary.
>
> The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
> Introduce translator_use_goto_tb"), whose rationale was:
>
>     Various targets avoid the page crossing test for CONFIG_USER_ONLY,
>     but that is wrong: mmap and mprotect can change page permissions.
>
> That is true, but in user-only builds the invalidation path already covers
> it. There are no page tables: every mmap, mprotect and munmap reaches
> page_set_flags(), which calls tb_invalidate_phys_range() whenever the fla=
gs
> actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
> incoming jumps. A chained cross-page jump is therefore broken whenever the
> destination page's permissions change. This is not true in system mode,
> where TBs are keyed by physical address and a page table change invalidat=
es
> nothing, so the restriction is kept there.
>  tests/tcg/alpha/Makefile.target     |  17 +++-
>  tests/tcg/alpha/gdbstub/xpage-bp.py |  34 +++++++
>  tests/tcg/alpha/test-xpage-chain.c  | 144 ++++++++++++++++++++++++++++
<snip>

Given alpha linux-user isn't widely built or used it would be better if
we could make the xpage chaining tests multiarch so they are exercised
on all *-user targets.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

