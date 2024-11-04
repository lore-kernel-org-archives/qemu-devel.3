Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264FD132AC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ucl-0000S8-Rt; Mon, 04 Nov 2024 05:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7uck-0000S0-DP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:47:54 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7uci-00031A-Ob
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:47:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so5921896a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717271; x=1731322071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRKQQXox9Ke1QCTDTkRuhIZfFkDM9QAczvSd/69A4Mc=;
 b=LUiNtiy9HMmx+0ei740IN1iqWBDTyYa2M04w7jhxM5q/XrWXi7i+JOtXsnQm9XReNk
 ljGX0NrpL1lLm8dtcsaX0ex5SyB4HvZdOBiMJ40FbKYnnTEgKRFqZ+ebOnIFNghSjpm7
 Vt9drFIZHhBm5QfSN7ptULHShFaRzJSHgaQZCvt2IVlb/4Mabh3Pj4W3UqYCvG7LaH1F
 bxvo8Xmh/8FzEsUDWVspUOpIUwn8WhPYVLg1+M8fMPid3Kxh7WIsAXnr9W2FtzrgkhqZ
 T85Tq5r60Mr36xD1eNxh+GoZfvIam+YKpaeDinRRYTwEgXI7TmZ7J0U8Tw7aye9oq1rM
 kA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717271; x=1731322071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRKQQXox9Ke1QCTDTkRuhIZfFkDM9QAczvSd/69A4Mc=;
 b=aB22wCdXEWvep3HmRpV/wzac2N9kvYxADm72pDoksz/EDHF36bymtiEAY6iWceBNW+
 /+eZU9457TpV4VX2T0F2rPlq1jod4eulOCL5IwxXpkUs1CQio5rnYYFKX6p1R3LYWs65
 LNHtdDEpmxlu2rZsFxo7VuhE5uN4c7IQf2FeUXxpGBIyn0dheBCidmaEeBAZsfZiphxQ
 3O9xCSa6LIIPzf4ajdwhLucG26+qMOfLl3WleTfYGKr3VaFGkgx/r+weVzGuh5Cc/XDW
 +reDTUnjvKyW/oGUrxwB9HB+RiDRz5NjFqeHixqz6TOav7CSL2uE8bBB6xmpH4ykeRb3
 a+Fw==
X-Gm-Message-State: AOJu0YzlUrNMWs/hSLYy+DPrCMT6jMlQVFlYZ1NZxYs7uZzRhS1ThgxN
 x/i2iGBCgpXl00zF3aO0tJk7gayt23ya4Up55BmbAeu26gjvSJO5xG9/Hppe7r1fqigz++JsSpb
 2cLFR9Cg96P6WumuZnvPxKfnYQ9Y6TsMwp/1clw==
X-Google-Smtp-Source: AGHT+IETme64jOAXjT9PLQkvhMzUVJMfZLhmh5llGRnqpJy47vdL6JJ865ryGrhCuxMWWY/L2Y1W6oBOx++/WDP9hmc=
X-Received: by 2002:a05:6402:4305:b0:5ce:dead:2fb with SMTP id
 4fb4d7f45d1cf-5cedead0483mr923217a12.15.1730717270751; Mon, 04 Nov 2024
 02:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 10:47:39 +0000
Message-ID: <CAFEAcA-DSYZZy-xXYZuvVq_vSinZgL+iWkgf5aozpmXjmZpyFg@mail.gmail.com>
Subject: Re: [PULL 00/49] i386, qom, build changes for 2024-10-31
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 31 Oct 2024 at 17:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream-i386
>
> for you to fetch changes up to 1a519388a882fbb352e49cbebb0ed8f62d05842d:
>
>   target/i386: Introduce GraniteRapids-v2 model (2024-10-31 18:28:33 +0100)
>
> ----------------------------------------------------------------
> * target/i386: new feature bits for AMD processors
> * target/i386/tcg: improvements around flag handling
> * target/i386: add AVX10 support
> * target/i386: add GraniteRapids-v2 model
> * dockerfiles: add libcbor
> * New nitro-enclave machine type
> * qom: cleanups to object_new
> * configure: detect 64-bit MIPS for rust
> * configure: deprecate 32-bit MIPS


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

