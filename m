Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C6BD1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t811c-0004nE-Tu; Mon, 04 Nov 2024 12:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t811Z-0004mt-JR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:37:57 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t811P-0001Qt-KA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:37:51 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cb74434bc5so5331994a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730741863; x=1731346663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZP95KLMI48rhZOUoUvMSVVmJvJ3oOK9xxl4T505NMs=;
 b=zJHxTA7cfqMnfH8kl9vUWOeTrPtEdsTEonkJV0k9n3SgEWyHsbyvkZePptduline6w
 2fxkDhsT/KHHcr8oRSY64e2F7mitB7Tk0F0FsNFav77hZ/L3SVhL5/mFa57/ch/Z8zbd
 YzrdRW5zj4orI7YxPvw2zQTzFQqUpfOnlSdLmAsNV33Z0w6SFf7NQHWBnX04f1Ww6Xz3
 kyhohEZ3bD8v7PfIW/21gCx5kIefoApUSzIw+Kv92aq37mpft0LT6b5IVJyyVd0rEkXq
 4jjQQmqJzP6TCB7DP4vXIlTwGG0wCQaGq8NSC9kGGmOUC8ymmM2T7APQ5XuPV4YghO4h
 KuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741863; x=1731346663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZP95KLMI48rhZOUoUvMSVVmJvJ3oOK9xxl4T505NMs=;
 b=QTqufhSm52kpV8fmIc0jIh0Yru+7dhiVeYD1i+TBxQEPNnrGMq39UWUrg48XRwY+n2
 3PvBhKqNfmyECwnJhgRFJwa3cuT61+t3UI9bD+nfOOMzDv7Zebigp6l/hTcRUZiDBrjp
 eeYEOna80fkEx3n4goFMe9gCTlYPOBIIMfowGP5utt+Q8ukYvg1jl2tW1HtpmtULGTw+
 c6OPwrpX/ZspMBIKcZSMazoXSVqXaDRwUG2+Q8v1t8iixIWLyszo4AjojF5huC8MVXpr
 BSFCu8OC3/mN7NTqoqpUgldjnXFIdbAXL7xWlp5DJMAKqebitgx1H5kzztRa49goGQYg
 QoIw==
X-Gm-Message-State: AOJu0Yz0DXNAprQKiPQoF8H6GqoP3Ql45QagAtKhgfsj5fkvrvAr6690
 MnbiprHrixXFUCsWbFWCY4IHaphFuEu3SUf02/rAf8n938ucFz6XxT4QIF5YwfO6IwZyNxUEWEy
 GxBHyScRDzUsB1c16H6kcXvvh+WBM4EQ1iJPjmcnbne0XWLYy
X-Google-Smtp-Source: AGHT+IFdbnKuaZ3CRfQSYH29m83y+WF4Vc6w74E51GWUZqwkUVWDB4qIt2yX1tss7r95mMaHi0awdLPYcoqsDRuIaEY=
X-Received: by 2002:a05:6402:2812:b0:5c8:a01d:314f with SMTP id
 4fb4d7f45d1cf-5ceb925b750mr10158464a12.12.1730741862635; Mon, 04 Nov 2024
 09:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20241102074737.1394884-1-gaosong@loongson.cn>
In-Reply-To: <20241102074737.1394884-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 17:37:31 +0000
Message-ID: <CAFEAcA9gG-pNq0H1kOYR=H+YkzAKMLLYmLp=ZXKks8scx3Xuzg@mail.gmail.com>
Subject: Re: [PULL v2 0/8] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Sat, 2 Nov 2024 at 08:06, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:
>
>   Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241102
>
> for you to fetch changes up to 47b54e15bbe78722c62dfafc3e04deded820c05e:
>
>   target/loongarch: Add steal time support on migration (2024-11-02 15:45:45 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20241102
>
> V2: Fix no 'asm/unistd_64.h' build error.
>     Add a new patch (hw/loongarch/boot: Use warn_report when no kernel filename).
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

