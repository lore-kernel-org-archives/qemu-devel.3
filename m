Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F91067045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hr4-0000Zp-N6; Thu, 12 Mar 2026 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hr2-0000Vm-N0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:21:40 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hr1-0004Ua-6X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:21:40 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so1509010d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773328898; cv=none;
 d=google.com; s=arc-20240605;
 b=GqI1BZllZvsrWJCKTtxQ8EQsQCXLF+oQ0MqWJ1F5M+CB7mo5KM1uycNam8OsAqWBVZ
 kz+H+3zqsyjn4m2LwWN2a6VfQBUXWIAdMUH8QXLtmajSmzRvjl9Qv21KiUC0YulriTlm
 2WFxVI1bELy4/NW0RZJHG4sDprbzJH0gMZh8mm+ZKiJeoEYh8EJ2/WxSWozNlmh7COHk
 oTl6g/l+/AWyXXdn7HQJbZJoEijF8uQ1wx3Y8ZVfDA9tb/uQEWiiewaQ6NB5lWTrtoJF
 1z6YIHraKtpYMUJxKtE67hExjHamvewaT3LQLtbnQa+xwdpxII2beTzedRVLyaQ/8Q5w
 YbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wGbARm4POYPAl8IATWt05+VJtXuGW8IGU0yB5ay9H0k=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=R5TAoTOag1l25ifLFxomv/oMGi2B5IC5ZbGu7sZvxGkKC0BYYj/PA6zeFvg2kyMI+K
 eIzO3vphass0c8eDozvVticmHyZjzOA8o7lmVe8RVMNBgLvdasqeNrGa5C7JYNk69Iyd
 J08sAp67OQYqaX220rnQuC7cz3PaUx9xlQmHsdrczU3KAy7HLVdLtKOgjfn8viLcjjvH
 0UW6wiP0GAFPiFi9bJycWJJ2aHxcxLHd9UYRYO9epxWLLi6s6kW9vvF4vfZeUNQi5n0L
 ptblG67HpCerwUcuqZWotIPHJCULJqLV1v6W4OBVPhxppjPeszVW7pJOIV3Qz2UMv6t9
 Qivg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773328898; x=1773933698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGbARm4POYPAl8IATWt05+VJtXuGW8IGU0yB5ay9H0k=;
 b=eR3urLJP8Uy31IvWZLKRb8onEq+ECjDYdRGJVnjiJTzyb5apgNmTfKIxhUJQqdv9Xv
 sV++vHVlc9CCp2qZN5jQs5O3EWMBFP7Uvn97QpZGzwuh9y1hFUYJZuQK0fu4fiWRuHHD
 l53ZD2g71YhJQF3mkeohZ6VTAmPO1F4bvkmmnEC1XBv85tkaaDiXVUu5c856/Qzerqyr
 Rg5B6nmU+QRTVKEMUpSDL0TVVbRrDliayZuSkclN68LZHKuwXPnQvgTxfjPq5rasV9te
 FeCgrKQZjmmcVfc0//pDXh+dVufHpRezEXNoWmsNdnBArdt5IFnfBGksOHBJgkyRC+ri
 EVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773328898; x=1773933698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGbARm4POYPAl8IATWt05+VJtXuGW8IGU0yB5ay9H0k=;
 b=NhiC9eG87uwp5dyMmHh7YihxaPS+gpTgNpMfAy6ZBE0F0+JqDTN4aIQDStGP441DGy
 1TyDk5fGmRhjLysVeDPo7zALQ9assdyxmKTVkMybDQGq/5NqIRDB8KhqHCrfowtGynCL
 KIzZ5FdgzH3Mh067xWG0z5js8Hmu9QQi6thU09uNX98nsLqsuNMAx8z4l5vurI0W1BiU
 GzaA0UxGzhkKBJwHk0H7h6pOpCF1VVDEUJ/w7x+8QMCNeV0OriTE1FgbinoL9J59oPc0
 QEud+6rFEhgSzzHh+Q+PM0BP0JsbveMKznpaFXelstsiWyRRF0rZ1xfFxWdoHcAPNBXi
 Xaag==
X-Gm-Message-State: AOJu0YxXp4Jik/8/vuS26c08K5J6yHsCJGgdTTCJBiEqI86ydsLmIPj9
 Ig9pVTZtSSrlDYnUDX1Vbx67TuekbNAcshTHvULM8N1bNhEMUHgJ3oe5DQBu/5xaXAc0ypzSFzJ
 EG5XVcSSoKoaAQmqSlfuPOXgbzhjavDTmvC4ixxfRcA==
X-Gm-Gg: ATEYQzwNAHUwFX5ra749RZXaYaSgNPDU21VU+ZCEIXHOpZMEF/HwfHqvIwysdrkZsfG
 XAtUthgQTf7uB848Xar7s9ePBwq/+mL+UFjCQXrq8CzzDjBjsb9KRkZ3fZtXcl3IfBQfIem9tmY
 dekTntsaxTFkC1POeVGK+67Htqw8LYOJ4UK0VWrS8YsbW36+mffyM3BVn8nbXnYdqMuU5PSD/Ek
 /h4FK4WafaM8l3ih9jeK/lGPYc0+314OPXXpvkKc1ZuyBSLzI3Eyl9aG+ac8cwIHuwsZgIT+Acd
 ipgvIfeAWgNh8lig7iK4y1UrULgbxPIy63Axf/uThYarrTvfsYeaKAeKMXiEkC/1U5Sr6QWwtFQ
 8JQ==
X-Received: by 2002:a05:690e:1aa7:b0:649:d79c:1608 with SMTP id
 956f58d0204a3-64d65686a3emr5045220d50.18.1773328897886; Thu, 12 Mar 2026
 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
 <CAFEAcA8aJRZBjwDVuoq+tPQOoaSw1tDzPVLPHCRVwFPR=c7stQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8aJRZBjwDVuoq+tPQOoaSw1tDzPVLPHCRVwFPR=c7stQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 15:21:26 +0000
X-Gm-Features: AaiRm51OvPH1vuI3V2164h97Ry60LrSHaASmAGy2sNZ6adb_Pa-uVBUJEUj-AFA
Message-ID: <CAFEAcA8TQ79CcArLKO9_ijqLjQe0MZoiWK_gGUaM4b3jKw4Fkg@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins doc update for 2026-03-11
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 12 Mar 2026 at 15:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 11 Mar 2026 at 19:31, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260311
> >
> > for you to fetch changes up to 71b424ca7644e2546da3f07fce3c33980d85602e:
> >
> >   plugins: add missing docstrings to qemu-plugin.h (2026-03-11 12:30:17 -0700)
> >
> > ----------------------------------------------------------------
> > Changes:
> > - [PATCH trivial v3] plugins: add missing docstrings to qemu-plugin.h (Florian Hofhammer <florian.hofhammer@epfl.ch>)
> >   Link: https://lore.kernel.org/qemu-devel/20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch
> >
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Whoops, wrong mail template. I meant:



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

