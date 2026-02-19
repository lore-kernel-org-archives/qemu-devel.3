Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111BDE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4nj-0000hJ-9p; Thu, 19 Feb 2026 09:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4nf-0000gs-GG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:14:39 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4nd-0003XJ-VY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:14:39 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-649df393c04so831311d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:14:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771510477; cv=none;
 d=google.com; s=arc-20240605;
 b=a+9wrhZInGIuEm0oHPOEVzqhFZriCdRZsyOCXT/Fd25YHqC94WmpC/kDX1LiNjdcw/
 yzyq2VHiQiBFmFycL09FBt3lbBlz2wA9gby266ICkQFT73lkTdTroFcZ2UGMg5pMdx3P
 Qel+HfzW9+aMNY70mbadL1ll4IK5RnV5lXvfOTEB6Ofom9EF4gOUTHhCTaSFHsDJfW+l
 pluiTXD8xs38rWkMxIIIu8R/HP6SMV6ceDQIJFP4sQUrh7pNjP3xBEDMElnoWovv23vR
 Q3Aw9dWodJtmjLVDObgb5IgR8YgbOSDCLrrwyPhyJjZzCy3Acb9ODnegslyDpVMFnoGI
 I2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=5gQYMFQhZ4N1Crffa8uzKSmHuvVt9aWe1ubXfuYXJ40=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=eu3DsBERiksUHK9TCZGjgi3tOfVoyL5eehyhmhbLvvjqbI5dniyhbdrDDJR5mwITmh
 bbQhxIVJfeGUqUwOscfd0eQoVIhJSaB4woSYnuC/xzzcNCm6W03vXwUd0+Mvakfeb6hI
 4DsbZwA8/++7QXeXIgFedM0/ffAEhFT7+wpp9/vGT32RAtYqv43wW6ZHmhOHmzF1pjWy
 Nlnb2HweYI3A3TetdgdyDLtVK76I83JtR2+g6yG89x2Ez0mHuS720bkd23PscJazA1bq
 GYkoAtrsodyX1/Vhd9XB03OrkLkXhfF34xmHcAsE/HsDuCTegCnEteNCg8XjvsKAiQkc
 EIeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771510477; x=1772115277; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gQYMFQhZ4N1Crffa8uzKSmHuvVt9aWe1ubXfuYXJ40=;
 b=jTLOPoywPh8UfE4hzzIFcbgMzfgBWSViitsMx2cxOkCTUzXWQ9LKeELFucDsy0AReT
 StaiuKX3yE6bsuPoHBEkaRvSf79936batwZ8scECoYGlkplt2bzX2HarcuPX0P0sr9IS
 N/T9YMjD1QxCmGKtDkZiWn2nUwOM58bxWA765Ns+mhaXen+yyquR+qBFdOJqIVoOZGQJ
 twRDn9UvrpjMdiUPz3bQigziMw1LXwKqzCDMM3500Co/gWgpNmfLftK2bKcuJ6TLz2TL
 wd67XotDQq4Hk/wgyy0isgpXazKROpQmXSLI9S26nMtzMsUAANBELDZAYRZPkOxu4Wui
 ikWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771510477; x=1772115277;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gQYMFQhZ4N1Crffa8uzKSmHuvVt9aWe1ubXfuYXJ40=;
 b=lN8QVN6GX55PxP5b67fpMY8YsstBUPTQP4dK0JzG2QBx8Cj17JkFpX0AcAGSMET9kU
 ueo84pPph+f459Bf7XnX13KvbcwVzorOBJp5eMPdt2vtmQWVkDIz3do51rBaIA3wkol0
 jINLXQ77QnQWk45Vmgx4mzU/Qw06pIooVeU5k8oWe5SwkUA7kKDxB/fj4EnWCSu9Kyrp
 gUI3sSoRZFSseWa5zTvX1vfFFWYTLPO34P3KA33KVbEPJ7Q0u1pXNooaY81RCq/6r2fH
 oYxMhO64caKD27nB+3oXNKT5hP7OShi3jui0c6sS7M6nBL8ZD7P1Jyo5riCk2D9RQ58O
 PPGw==
X-Gm-Message-State: AOJu0YxO8ag4HXIBvBljr0KMDJcia9mr8My2NYIuvyhtE6M+NCQJkvf2
 jqJLZGsxsciEl0q2wIU/QxQr0gx7xVJ70rXLFNg3pid3EluouP9E4nkCYz0DcQ7izojFdWJXArJ
 ItBGg2xidTyvZD3IfrBq2isAOlRrMomkoGQ+xoHGfBkhVlHKmMwvp
X-Gm-Gg: AZuq6aJWBAWzZwjnaDjJLZV0xKNZYOx1iuN9eEItFfSWKJbDFrK8C4kQio28c2VjjCa
 PfmS3NIT3NS9XCdwm/AgWqLuD5OVinkAUmyiV/jkg/sCKJvPY+z9mUffiWk667RAHJ+c9QeTafl
 J4xaajFNLuxlRxfwU902OxvpXWrk0QtG35JEbBZgs8QbtoqXvI7gXuRd6t9kWfXGireWxag1e5g
 bAqTEiGfduFSDPtJbfGiZkun55MC8J/V0pZDqSp9UYgPwx/RP4bnDmwi9wioM1FYGu/9q6oPKxA
 svFv42O7Z6eWVJt2F7DCzymH7t91n7hS8sgk19jAI5ckOabGDE4ReCQa98DraRBbsbs=
X-Received: by 2002:a05:690e:4005:b0:64a:f163:1554 with SMTP id
 956f58d0204a3-64c55562576mr3967426d50.14.1771510476904; Thu, 19 Feb 2026
 06:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 14:14:25 +0000
X-Gm-Features: AZwV_Qg8l_VpbXyvcyGWyvzs79fppsFHaAl0O45H1N7mI9NnwQUIzWtqPTjzjIc
Message-ID: <CAFEAcA-gJQdCNfAuXHgPPmcz2qYQ8sJLSVbFyDBSEj_xyDnBcg@mail.gmail.com>
Subject: Re: [PULL 00/32] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 19 Feb 2026 at 10:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 314f2d7fe601b8dba2a88ac4870469e9f6bb8464:
>
>   Merge tag 'qtest-20260217-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-02-17 16:46:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260219
>
> for you to fetch changes up to 10059583c7bfea50c1596310b0639669e93ce1ee:
>
>   include/tcg/tcg-op.h: eradicate TARGET_INSN_START_EXTRA_WORDS (2026-02-19 10:12:25 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Allow TCG to emulate CPUs with SME but not SVE
>  * Refactorings for single-binary
>  * whpx: minor fixes
>  * hw/usb/hcd-ohci: Implement frame number overflow event
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

