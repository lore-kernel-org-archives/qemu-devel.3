Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A1BEE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXyB-0001W2-Tu; Thu, 12 Feb 2026 09:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXxt-00019D-6Q
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:46:45 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXxG-00072S-0S
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:46:07 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1233b953bebso152050c88.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770907564; cv=none;
 d=google.com; s=arc-20240605;
 b=eo1fOC+30hgpup45lB7FUSQjIoKt4bB0yeyDKFMcs4QiGzO0tcEGpQk8x6Ryw8Lr8J
 mqL7TTG+suI6NRSTV98E1yK3gQ6f54kWlfjZwUVsePog8oauyaJnWe83rjZkHLto1JIx
 IHJy0Y/uM4Ji11cVIqx8bPseHxhsM/28Py7Y8oDzb9tTMd5d+FfpvCq5q3E5Mf+NfO7V
 KJ5mzgBuaz2cb04FXRowHsYwaPsr4gBfuCJO4fWBEN0dVWkh5PWocJ7NKPV1yCwAv8ZC
 lt6jhLjBzKO3HSAiTtgRwKg0Y1J5vyy+TEpgL9cTiTOi8RiXRUQ2Gs9sE0oWk0zhuAhP
 WUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=49yGY8Kvw3pmX0Y1mSe2Sq8qMs8/xpjDPD6EpkNjRkc=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=H2uFoPQwx71PftVFefBYUlmmWlBQx3C1DusfktT2WPwHgrgtaJNT2JE68d9y7x14VT
 oWGS/GvkOfq3bg/U4aUiUvFDJIzX8RHl7rMhOVJlLxLhOaNfyzIzfTVCn0qJimwVsYxh
 zEIA0DCcZvZIPyfSZZDIWf5qYXPB+t5Ej0HYMEFDZxTRdLGw8mic0YOG2/66VpCPvT4n
 q3yeMtA9Xe8oGXi10AHVIfwEPBBs3THVN9cNg/bk683LrEIwdIXRX8/p3ETjwEy41L8Q
 IzTglvNxnKnIeVlKuc5qtyuay/k1xIx8J5mw5R8eiCSdXLdWITh2TkZpq0Jv05i4E5ba
 O2JQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770907564; x=1771512364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=49yGY8Kvw3pmX0Y1mSe2Sq8qMs8/xpjDPD6EpkNjRkc=;
 b=fYE3Krd92hY4JWJX6N3zxO3bB/YL4XEVVJWtHs5wHEQjpH3ujnHiF0Xe7YCwc2Cmjk
 kSVpIHsaitXv1K8w4ZBj8GItqdPloT5NvPx6CtuHyioeADlYbf3rgNzQtk1mfB+ltQ+Q
 1uGd0LpHJlNZgPURYhXDAuRfhThj/3jFwU4YbLndWO33aYEn/1ZfGuwM59tTnwjZ1s7u
 7HHbO16e+BX+3ukr4Pxqp+kZZRDr/pJWBxy5HmTzNXmQN6BZdtZ2EKCoqjp5IfpJbsIF
 ZacnGPzX3TiUbYOyPakya1jLLowziCWEmzdD4t6SXJyhjhshHQbnCsyVIFGucUjKpIJZ
 IpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907564; x=1771512364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49yGY8Kvw3pmX0Y1mSe2Sq8qMs8/xpjDPD6EpkNjRkc=;
 b=XLxFpmGHHp+NRdrmpWzfKr/VDaLy/uBOjf6rL8PgivptrOXMAvzEoaIrWfLa4M2qP1
 ZljcI4beHX0728MR1AQMF+0aKfKFajrL/c2aBDgvNNUSw1Jt7KjtCSga8QzMlSqfhOeF
 3eznK+sHUaJicREGrTSh1its88sjA6G7IB2PJgOpfZPPOTOo4p5Y4CRMSRHtjAjNHSko
 M05LJzrjRRGuy2dNeqbqdDXZUxUviTgXhIyjKCCTeZINTEutVJFHKa3IY2tdK1m3p9Vb
 iTWdPukUZBuehkxOzlsuvryq987r2is0uIXH8jADjE5bFF1GC2YuayIk5DUIF34t4bM8
 WugQ==
X-Gm-Message-State: AOJu0Yzbzzry+dYlBLAHQbxjL9UgR2vSM9x1DTcYBEzNN4E6g3CBHWY6
 /UlCU/fk6CNM93KdkiDlKqn6On6i/WyuJjzTo97I5wNf018cpU6KRZWtjxKLDfhQI4z4+lNXZjb
 VR3x0n2lyvn8FBb1xJCUFxW9mFoBOrKRZh12LCAF37X00R4jNe3jz
X-Gm-Gg: AZuq6aLe/3+pbxu2Q5VpWsf/TsqGy2zueXJvhLHtJMFjutiRWI/3dvbbZl57/jKUXDs
 AssDBlY02s+PsjzE8kRKrOnBITrMnmoCWZnUqt6/hZ54JBVlyU2O+YnZbnwCMSxd4OO3+Wh8/BA
 B0h+vHchXKpM6uf0euCT2WvaYswO8ga35EGs6vmZ9YwY3lHLwKJqMuzhCfxF2bhADmGhKmun0mv
 nrjObqxbZKCoEAjyReOBCAF8zenG7jnlnTxbX0cdjfkZvjJkWucx/A7D4eL0zpR8OwNa2d39Jpe
 u7JBvQ3mtM4kdTxpSMRK1Yjve+bvLJ+g/pxojSkz6iHfyQ5ZmNlrhfNARJrQnuIRIezzXvXUw5A
 31Q==
X-Received: by 2002:a05:690c:6610:b0:794:ed66:86a8 with SMTP id
 00721157ae682-797931989femr43665947b3.35.1770906853595; Thu, 12 Feb 2026
 06:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20260212114034.265498-1-thuth@redhat.com>
In-Reply-To: <20260212114034.265498-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 14:33:59 +0000
X-Gm-Features: AZwV_QiuN4dCCS579aW6JSRI9jvlT4AeQKotxgf-MYQmqcdB_iJsRv4e9IyXzCQ
Message-ID: <CAFEAcA-v1yWyzW5fTw_ypo7XfvOur=tLuAJ_-=cbru=8Ukhqbw@mail.gmail.com>
Subject: Re: [PULL v2 00/14] Misc patches (s390x, tests, python, docs, ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=peter.maydell@linaro.org; helo=mail-dl1-x1232.google.com
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

On Thu, 12 Feb 2026 at 11:40, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-02-12v2
>
> for you to fetch changes up to e44a26ba940214824b61976324058e73d9f41658:
>
>   python: drop uses of pkg_resources (2026-02-12 12:34:00 +0100)
>
> ----------------------------------------------------------------
> * Updates to MAINTAINERS file
> * Fix CI (broken pkg_resources in python, revert RCU change to fix alpha test)
> * Fix endianness issue in PCI code on s390x
> * Implement DIVIDE TO INTEGER instruction for s390x TCG emulation
> * Bitesized documentation updates (run-tcg-tests target and fd-bootchk property)
>


Applied, thanks (and this does indeed bring our CI back to all green!)

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

