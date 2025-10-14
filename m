Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EFACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ctf-0006ME-Rz; Tue, 14 Oct 2025 07:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8ctG-0006Gr-QY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:08:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8ctE-00079P-Qi
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:08:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so47835115e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440102; x=1761044902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcZTql3elf5pX0dYEuIgbCia8QbAI6X151BBcGtRlLk=;
 b=t1dyN4jPrgKZcjPneynXEBH2auO5v4NcxgOZhdpkhp3fDphkDHc7A3nzIvzpUsxcUp
 qMssADUPTXx77dY9gihsxKRTfqH2uTgx0j8fBmlI9+2w6PYvUdHCJpGTMzO3Q4f03i9x
 JKYPyGPfVCv+e5dLgyZwRlQtJAKTFi44ELt7EXYvFZ/1NAq5pUakNf5ejSmoA85Wtqs0
 9wlBxWxA9gKRAe8Vv9bqJDsgGgOz8Smu4DrihLMgunPiOU0D8xwb4zZA6TcfISQ58b3y
 j2l3WGu33SK6/Axpy6Cvm8FoyX6tV2+2ao4wcNfdFdV5FG6bfhabUkDrKvOTcjRdFxFt
 L3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440102; x=1761044902;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TcZTql3elf5pX0dYEuIgbCia8QbAI6X151BBcGtRlLk=;
 b=tIb4F+pf5CPLQI/TN46UbhmVWDYI43nnCSWIRzNPny9aO+Qp5sFOnwYVxX9eTS3wAH
 26sJtadnTUAPWS3AN46atJ/uXK46s12V/430jXtRFIvWxCDd4zIAo4G0POWwLCkghMps
 pDbSOCHm0r7B6JHd1uJznrH2AUYDAwrr4eGX26BIclb+lsdQTYK/DIeUCR/lURI8kyPA
 /cdgojzjR6/y2jquKAAqd4PKMKuEDA1pH8VY1HwfZccf80GxCJdZh+W0M/NK83OrmrH2
 3IVVbywWZssxzStap0RJ91lGcZ6oIhYO/smkK3uJuoLyYoMM4tg8og2RdSfo94embKf/
 nUAw==
X-Gm-Message-State: AOJu0Yz7GHDRxMZazwRM+dM1CNo3IzGPY4+//yWZyxQ3ZhSiDXokkMtt
 Tt7BooqUxyCluSwGde3RGsnr+Khy/P88Fi/cjLGE+NynKzJYdaEJqjqxi/Wea0o9j9K2BR6vdQ/
 juDR4
X-Gm-Gg: ASbGncsUkpS/Ak6qqHJVVciPq8OsoReY6SzATFy4k5ukQoaaOKYEsGLEzemEvFtDS0w
 Dbn9xdTdgT+yt87T8xp7KIcRJztBQ8sVpkCV1AocxdRRk7WtNJrVAg/4O9TEcXql3Ipfpbba17e
 zHNq4pNvb8FfBmUMPCg9idg9n5yJsvjLp4mWofUksDTa5uPBZX30XGgp7b8993bhg9R/ipRLEOP
 D/JXlGUkO1IeJJ921vvrIVdMTTapf+S2Iu+EecgqhXyKLsNJ+r8GSwjc+9HaqJ0RHm35TuZWBat
 FoHV4i2/jV2SngmyLF6Xsv7X4qjlPVm/iycTxAgxR7QvJU95IwY5AZ7JKE2u7aWjTGp7nN49Cp6
 eAFgiMDWfbEq8uRyctHzgirRkX3a9WegpXALvGQbdnoQw+A==
X-Google-Smtp-Source: AGHT+IETsP06vYBb5ol+KrnVxQU7Wr6HlQf5JgrUQmgdWt8SjKsulFtyLOIoyzivwmTVtgDBSC5Xuw==
X-Received: by 2002:a05:600c:4586:b0:46e:45d3:82fd with SMTP id
 5b1f17b1804b1-46fa9b086e1mr185404945e9.31.1760440101767; 
 Tue, 14 Oct 2025 04:08:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb483c7e0sm236095235e9.7.2025.10.14.04.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:08:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53F0B5F812;
 Tue, 14 Oct 2025 12:08:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH v7 04/25] contrib/plugins: add plugin showcasing new
 dicontinuity related API
In-Reply-To: <9ada544f3b3c1840f75d6e2bda8bc23783cd0b2b.1759744337.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 6 Oct 2025 11:56:59 +0200")
References: <cover.1759744337.git.neither@nut.email>
 <9ada544f3b3c1840f75d6e2bda8bc23783cd0b2b.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 12:08:20 +0100
Message-ID: <87ldldlp0b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced new plugin API for registration of discontinuity
> related callbacks. This change introduces a minimal plugin showcasing
> the new API. It simply counts the occurances of interrupts, exceptions
> and host calls per CPU and reports the counts when exitting.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

