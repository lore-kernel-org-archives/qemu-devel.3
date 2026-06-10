Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E473CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGIe-0006Yn-Lt; Wed, 10 Jun 2026 06:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wXGId-0006Yf-BF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:36:43 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wXGIb-0003i7-Ut
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:36:43 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-91591f19716so807737485a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781087800; cv=none;
 d=google.com; s=arc-20240605;
 b=kGnpf3yJuaBYy49qhx6FyyBiIMCqXeR8el9Iuf0I+fUEM7uTDV9qfu9UJogehB1kGb
 rz8L3bDVjenBURT6qXZFwA5G55AbPcJSqoUruEH+QE4kzOaMiGpwD+Opj8cBMp4OyGpE
 NuD0nUnMMaEbl2uYPSnIefRelNKgMVkfBWvNlo06867QIfOTNEijgGuydYD+HyDRFu8z
 YoyKpXQhgFIxED4IKK2JOVI83VepR6A3GQE7voVmPNWzGQcCdPHBoK5u9IHyMZSLQxyZ
 QFaHmjtrMR/FVjjLqksDBkc4m4YgHRl2vLqifRyrtVjuNRJk6IcA+qUoYuS+gK0EFDXc
 ukMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DslrArWkKhE5Kb7Su0BolU+TTEBOXO1NMQ8RfMkneeU=;
 fh=ADSLpeCeGL6UetLW+mo6xhjXw22biRlGkCb4oP8/7/4=;
 b=IbA++R488pRxLVXqEkIE1YlGe2ehTM9/x0NWNxzq2uBWuo8IoMpjR8WrRw9z9oCKsH
 wlgn76TKU/N54bm4XQa1BYH23jcz9cPAG0zltSZ4TGIcYFVI2uugS0u9fumTQsh1Avlm
 f1yzIpAF0ltS9l8K3asrS3L8tQkrA3mRp7RUZ4w/mLoL4nbvPGLLT7K3R4de1fo9IJGY
 sastFU2qYPkevYL5Nwjw8O5wmXoZNN2nXgC889lwurXFz/zzJrre2bGeG+6XGpTloiVv
 LLrHENGd1kXKt8MIKrdJVhd3PbcdjImlv+orBqY7yuqIvP8Rkf9ZRYO374WVq1HFIbU1
 jzZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781087800; x=1781692600; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DslrArWkKhE5Kb7Su0BolU+TTEBOXO1NMQ8RfMkneeU=;
 b=qca76/R3wvXY5EfrWTGbY2JFWy8ReKeTW1P/VJOGauOoP1nQwfJP4lhyK1g4C30AiX
 xSyR8A6QOgljux4DLt8XkONZtvno7TM5ri8t4XdqxoPWmTlSyBnGB3cFs6luQA3EJ+eZ
 EX56mOaBQF37Q4mwkyxGTvHyiPk8+pK9cyYN4QagQdIwqrYn1kcePUJyXR3Nyz9DbDaa
 vonAYjdktUN4S6ZKKM9kfvYg33aeAOAXmV4uqaNE/Uo58P+gJNOmtlopYyTIPf2LCTRJ
 RyBD/Y0ZTnU2nq+rht4OtlhyIwkGqrQfSSHJgS+ebc1zOzUabYZ3QHMfN6edHwgguGte
 a4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781087800; x=1781692600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DslrArWkKhE5Kb7Su0BolU+TTEBOXO1NMQ8RfMkneeU=;
 b=DCVoJd3n9zss6cgBp5I5nWPcTymrfayHcsRL6bb0XnS6eSrw3P8OnRPQdW5VQ0RJ8p
 tRZ2s8xoQgJUypSiKMAWiOgLUMxTl1RQJGPUCrIq46+QeqI3WaNvY4/VIc5Qs4f6LQoy
 8su7aGGBOG978jKYh5+LA54l4jIc4M3QpnpCYJD9fTCalKn/cxXZ9aeSGytdqr3Mt125
 LTsF+TyO7gmxdUjIpv4poY3OiGdTA5cMBJpHk25IQQAfrCwO4iU9IuCOXvbfRe06fUuQ
 +gU4HCey+qCU7dUbQcDSlL/12KA5KOY6SDUsol+tck+Ib4Hd43SRzjg39ExZThfjEiI/
 b6wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bjmTBLGuzkm2+WpwnvhiAm342AilCs0xvKG0oP+QXzMo92No5Fo5vPzRRU3u159PSVaQxow5fmDA5@nongnu.org
X-Gm-Message-State: AOJu0YyXrueV3nMUdGsSXTfdl0i172v0nm71X7wj4XXfuutq6X1Qspuc
 KcdcydHxwuss90a0r1x+5X+c8BmcMaf2aFUUB1ldAmfi5vVZxssZ+GacF1N/ZJJmCnSuRoZ+6XV
 dMyKYsxK53rOee3HWze5BM1U21izdXyA=
X-Gm-Gg: Acq92OFfTneaU+xm+t3Prt0zQkpBCk0Lg5uvIaXGKaiB3BN+FQlvDxpMSZ6wlWpYcXX
 NPPYsLFqCJ/03ESUwRSRs18U+JHOfPyd+EMZRCpUu+qPMA5AqMJfJhF9/B+yAYmrrxRBEy8wWmf
 yFn9efX/0DpllbePqxWw4f1gRKWdzFpVmJI2ZJwnQrYYfwwsr9Qys5uvNoOBzMFAiiXTygewsWF
 vqAOkVylMNIwFEteb94wLKGtjlSlJWfiKU/LLJs85npVBp536lHQa88YGtUjls9PW0Fl0cxU9ec
 KC+l5+7HRM51blBmVJY=
X-Received: by 2002:a05:620a:454b:b0:915:a82b:3e9d with SMTP id
 af79cd13be357-915a9c4adc5mr3903823885a.12.1781087800420; Wed, 10 Jun 2026
 03:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com> <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
 <CANNYZj9X4bSFxOMapsL7fB=q-GEO6oJMtwz3oPkfcX1ww1oaMw@mail.gmail.com>
 <18B647EA2CFF57AA.61226@lists.openembedded.org>
In-Reply-To: <18B647EA2CFF57AA.61226@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 10 Jun 2026 12:36:29 +0200
X-Gm-Features: AVVi8Cef1JocTuTrHZhoo4E8pATI7oWELhFpyrB89BpwIwOWwU4AkTiLSKeqlYo
Message-ID: <CANNYZj_WWD6oaThQrtavQs+pi09UzDa8EpuMRNs87F2Dzp1NNQ@mail.gmail.com>
Subject: Re: [OE-core] ui: Regression calling eglInitialize() since v11.0.0
To: alex.kanavin@gmail.com
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=alex.kanavin@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 5 Jun 2026 at 22:02, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
>
> On Fri, 5 Jun 2026 at 17:17, Alexander Kanavin <alex.kanavin@gmail.com> wrote:
> > Please note the comment above about the environment - it is x11
> > without wayland, provided by xtigervnc.
>
> ...
>
> > To me it seems like forcing EGL triggers those wayland code paths
> > where the crash happens.
>
> I think I found a way to trigger this in a regular wayland desktop
> (with XWayland). You need to unset WAYLAND_DISPLAY:
>
> $ WAYLAND_DISPLAY= ../bin/qemu-system-x86_64 -display sdl,gl=on
> Segmentation fault         WAYLAND_DISPLAY= ../bin/qemu-system-x86_64
> -display sdl,gl=on

I filed a ticket for this with the most important findings:
https://gitlab.com/qemu-project/qemu/-/work_items/3540

Alex

