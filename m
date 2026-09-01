Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D73C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qem-00033K-S4; Tue, 01 Sep 2026 11:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1Qem-00033B-2v
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:44:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1Qek-0005Dv-7j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:44:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so11917705e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788277452; x=1788882252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tUuFcuwCiDqLK5Uu2wbBGdYRvvB2DBW43PoOnMoSYtg=;
 b=NJ53aRTJ6lotDJxJ75X7qLC/hgxM+tWvFy5Io7iMMCb+l1IxICdaqeArG4QorpR+kq
 pBhXAe/dKZK57hVWZJBjt/4s16mPFZNZ9TYYnWI6Hb3aZ/Ao1jrnlud2JZyy0xmInE33
 nE0n+hxNbUP3s3AMOJ1YfzJUIQ5N2HSGEBPzOx2GD+lnr/u6HFOEWiaRoW7K/ax4sFpX
 pCe9xJQUjzANnFwdcuXo0NG8mBnYWUwhNcObRd5tEpBobJ4eeAB2DfxruQmFeL5hby5b
 5TXaZqUaNoQPIZMAwQMR5nEDwq/bQIYTSO7EPudh3wm5GZR8G9YA0+tT5HFQRzPj46j/
 Xhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788277452; x=1788882252;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tUuFcuwCiDqLK5Uu2wbBGdYRvvB2DBW43PoOnMoSYtg=;
 b=L9Im7wliy6iMSFnftkbrOzx+f64J7E2n8znTnkkOp1G5b1mxm++MElRRO4MmlQ92QF
 jBtLtqFsN1uCVLiZ8sUbWIeXPcwgd98/7r+8F8pe2vor1y69sqTLrknqbCl4UjEvIwBO
 e+idVnRHQy74JyWmYiOldJyjpbqlJ4VhtCOnPtIQjypBkZZjY/BPv1jp+vgW493m98oH
 d8aRjl69www6luB0/9oPlUEZ/5wkJcPYwm/oOxVjD9wJFo6l8jnP6a9/IWhWyjtQdcD0
 GsPCt/kZDZQp/jgK8OsHqg6WAhyUha0HDd/W9ruuhF2yoUTe6ZJayGKYJNY0JKGRsj43
 daHw==
X-Gm-Message-State: AFuF++lVV5NNVUpd10RNjs/+oCayLuHvXm6QAaNjoXoqLciRr0+Ha75M
 QwcAMIT0zZYnTmKgc5O6/jRAO9qlxh9sWvwmSrxIcdEiB3PKeEJj25dEzC6o28D1cG4=
X-Gm-Gg: AR+sD12/DhTe//7N8LxgSiLd8RneAFPYu+rJS6m7hQnA+p3ZgAAiq6VqV5Xhrawi/w8
 9IiHZoj8+d1dls76mT5jqT1ANWFNyK7cFZiCRYC9NgBy6Kvie9s4NUgeIYSihrGNWhQAEeANMGK
 sNH06Zfs2bUFqbHyIwHHC7g6gTl9xBjW3fOwNnmQsoyNccSYneS15Amzt34fiIPB+o8wqas2pzg
 hBUZVTtJ3CS3+0D0ImC/nXVRSHMDUb7PAzFTeo3TmnARnYSQrpeYMhxIjldJaGbUhA/+OX7e9Zm
 J7CJKQQDpYscby/cNjrWuZ00+Q+l73HXeEfKG+G6m/keZJGdVJ3A92SoLK85XPbii1zrvbpUeBc
 ZATBzoguVqW5/yPSl0miBxvFIjnrrsjhBD5Uer11PdEJeAstZynZUodr0V/6ud8m4GIFdwTYpH+
 o9F8U7sKr4gMpim7yw/o4W+YXO/o8Y3hjqiMQBOVezDv49AykrBnB/YKv9A8py
X-Received: by 2002:a05:600c:3511:b0:499:adb4:a922 with SMTP id
 5b1f17b1804b1-49b91c4bab5mr405696345e9.12.1788277452306; 
 Tue, 01 Sep 2026 08:44:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d78444sm6424888f8f.25.2026.09.01.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:44:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AD3B5F829;
 Tue, 01 Sep 2026 16:44:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stafford Horne <shorne@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Palmer
 Dabbelt
 <palmer@dabbelt.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,  Helge Deller <deller@gmx.de>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,  Yoshinori
 Sato <yoshinori.sato@nifty.com>,  Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson - last
 chance to review
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 27 Aug 2026 22:13:21 +0000")
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 16:44:10 +0100
Message-ID: <878q5lugc5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by inte=
grating
> them with meson directly.
>
> It covers all existing tests for all architectures, including
> user/system/multiarch-user/multiarch-system. It implements all requiremen=
ts
> listed on original thread [1].
>
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>
<snip>

I think this series is ready to merge so consider this a final chance to
review any architecture related bits. I shall generate the PR on Friday.

>
> For reviews, this is the list of maintainers per target:
> alpha: Richard Henderson <richard.henderson@linaro.org>
> arm: Peter Maydell <peter.maydell@linaro.org>
> hexagon: Brian Cain <brian.cain@oss.qualcomm.com>
> hppa: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.=
de>
> loongarch: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>
> m68k: Laurent Vivier <laurent@vivier.eu>
> mips: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> or1k: Stafford Horne <shorne@gmail.com>
> ppc: Nicholas Piggin <npiggin@gmail.com>
> riscv: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.fr=
ancis@wdc.com>
> s390x: Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich=
 <iii@linux.ibm.com>
> sh4: Yoshinori Sato <yoshinori.sato@nifty.com>
> x86: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.hend=
erson@linaro.org>
> xtensa: Max Filippov <jcmvbkbc@gmail.com>
> tricore: orphan
> multiarch: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

