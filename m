Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B32ECD4F26
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 13:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wawAv-0001OV-Hl; Sat, 20 Jun 2026 09:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wawAn-0001EN-EO
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:55:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wawAl-0000Hz-U5
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:55:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso42162005e9.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781963746; x=1782568546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwt3b/P70uRIbEUCyiTiXc2RdDQvL55U/TceROkjDVc=;
 b=Mb9omusXUVWDX3Hjks7+lD/VVdEPn5wAtiQkQ3TDFM9GgLhe3qNYbh8Ar2xKtV+5gL
 T4+FQANF5jydJ/7/7dqVvSdQiySNL86/9BJqJCBuCQ4InDT5KODX6WQNglvakH7AWSSM
 Cr6+fXyYjEWxwH3Cy64MfDPnHu9Q9K5Yd8I5glHoVCTNHAySf+WxdyIt/vUZZY06cpCc
 nBitjzz7U6RvfUQ4zOYplW4Qcvo1KVzxdkRm13SffVn/tnRwti8/UbcJkFO8lpoBmCK7
 UwstKJ7ERDo7Ppz5zSqkE2Xw1pLhCHb/sfRVzY6keYZ+NvxGV23ZOZgfbnL7tHn9wwqF
 3HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781963746; x=1782568546;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwt3b/P70uRIbEUCyiTiXc2RdDQvL55U/TceROkjDVc=;
 b=do7QnkyaH4wRoJntgc6og/B3TarRm6d7G2Ab5/SBZO382QiaFcOje5cLibdpGaGLDl
 zwEgEpUY4s145jUos5fSSZlXUyhnwsLXmlWebXH7GzhbGhvkQe+UGxwCrZiYI7/wzZAq
 A5gK2HOehyLoV/TkqgPrTu4497s5dcMurHNwDtrfYixiDIKqOvXh6smrNeevDxn7XTDy
 a7sKZjgQlP/oqJmYUnud+P6JwKJFgPKOQrzFz5Nzc7NIEoLsBNghCUaWSWIpp3MLgrTY
 IuWWvnOxjoSOAuuFVjgpPCUiuDKOxFHkFsESwNkeTduTI21vLTpacnILmrXm+ckP1mNo
 zGmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ922ONeZZl3NxSY16/3SwbiaBVbzDoCMhshQH85NkLEv2G2GLaRXf6EgaWNhkFUCqrZLMdL8Fgy9YAU@nongnu.org
X-Gm-Message-State: AOJu0YxX3dYoWjOQdsT/NooijzmYzp6JnB+w72rhfByqTQJf5RpmPU+C
 t9ncHJAUlBbfWqILMHQ/HAIy+0qBeybbPn06t4w1GE5Iww9Ho36mLXD5SaBHXQRqZWo=
X-Gm-Gg: AfdE7clif9f8kulmWAUE7RSakeNlr9SNrGLlUQkNBmkfCOpfzsaT3RHqPKz0u61UuA6
 AxgQkvlAUDlEdjUyWLiUMC3MtMo/N86kGAGLvW78r6/plz9xXUrECtNxnq7Y6W8J8V17EsLWATx
 j8ONWtYCsQXTauixoDsXH6Lv2s7Qb3u6kcTKFBRh2ptoNagwYLFKoIvidlEGaTOffn8XMEd6Y2x
 PuiQhGFJCpzrzn88+VyHEqH64ZGroDUDg3875hJN/N2vVppuDXUs5EvB3J0AZrRYr9oN6temPiB
 mf51C6p5A+xbl9FxP1JdkgDloPuBL4ZR+8Rmb1n3QEuXzTn4ySkUZJ5IbYbBmh0bxAuT0VwYbMQ
 M/BnlKupUSUSF0R79r6UMOeS0tTSKeCrgcKnQfJKA7AwcsyimjwcnXODmkOmIWQBE452XBpeRqe
 A5czI9+hB2o11c
X-Received: by 2002:a05:600c:a315:b0:490:b629:286c with SMTP id
 5b1f17b1804b1-4923f33cb1emr109243845e9.12.1781963745767; 
 Sat, 20 Jun 2026 06:55:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5de7sm8020663f8f.15.2026.06.20.06.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 06:55:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 222CA5F80A;
 Sat, 20 Jun 2026 14:55:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Zammit <damien@zamaudio.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 bug-hurd@gnu.org, qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v5 0/5 qemu] GNU/Hurd support
In-Reply-To: <a612eb6b-8e42-42e0-a6c8-4f09b33fdcab@zamaudio.com> (Damien
 Zammit's message of "Sat, 20 Jun 2026 08:34:31 +0000")
References: <20260208055858.2166524-1-damien@zamaudio.com>
 <977b7644-2511-4ded-9f7c-81dd610b6f04@oss.qualcomm.com>
 <a612eb6b-8e42-42e0-a6c8-4f09b33fdcab@zamaudio.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Sat, 20 Jun 2026 14:55:44 +0100
Message-ID: <87ldc9b9jz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Damien Zammit <damien@zamaudio.com> writes:

> Hi Phil,
>
> On 18/6/26 6:33 pm, Philippe Mathieu-Daud=C3=A9 wrote:=20
>
>  On 8/2/26 06:59, Damien Zammit wrote:
>
>  ...
> Executed qemu-system-{i386,x86_64} on GNU/Hurd x86_64 successfully.
>
>  Could we get this configuration integrated in our CI to be sure
> it won't bitrot?
>
> See how we test OpenBSD or Haiku for example:
>
> tests/vm/Makefile.include:28:X86_IMAGES :=3D freebsd netbsd openbsd
> haiku.x86_64
>
> I took a quick look, it appears virtio-blk and virtio-net are both requir=
ed
> to automate the building of the test vm, but GNU/Hurd does not have
> drivers for these yet.

What block and network devices does it understand. We do emulate some of
the more common ones and I think the old school IDE/ATAPI interfaces as
well.

>
> I can take another look at this when virtio is working in Hurd with rump =
framework.
>
> Thanks,
> Damien

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

