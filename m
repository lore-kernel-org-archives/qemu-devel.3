Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771BECF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDZV-0007xi-Qs; Mon, 30 Sep 2024 06:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svDZU-0007x4-37
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:24:04 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svDZS-0004Ng-A1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:24:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso33501211fa.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727691840; x=1728296640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6/vjQWlAGiGQd2+R8HVMaGeS1XMT9cBcxHup0qkjBE=;
 b=HpS8+CCme8mTHY0fONiWbZc6rh5966UVkg611Of40Xodj32N03QSyC+14TT0uCIgin
 7OT4IrVDeBlFHYOXo5Egm0rmcqUxDND4n2WkyXk/0x49jqpVnmcfqeXOMdOL07HJYuz9
 44BU2xGEhJSjqpc5n0+Cq6sS8Z72CxXuOfE2RmLktS1TBm/pm2q/kmT/rblTyz159CQi
 hso6PZ9RzlqNTINhfZJmF363Wbtbl5S23SXzmkLEaeJFXNpT8uoQxSehKDMHEBlxa8Ax
 XSuOXjOhqCXTiDifS2xoMsKvNh9kYD3HQaLVWDfj23hUxxx5GR6PSwcotcvxD2pBMvtk
 suQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727691840; x=1728296640;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y6/vjQWlAGiGQd2+R8HVMaGeS1XMT9cBcxHup0qkjBE=;
 b=PKy3UUQM+2OJOskfOAmASsgSuO7kF/xqwoinVMTY4Dnh+ql9kpDqNX2VFz5CDudhRw
 745X+fthRW7Vcz44sg13KlM6yWCpYGR/cjsyLdds4Y0CJgE9sMMsGfvwFav47AzYnTHe
 vvIityn73azr+jshRWWY6CyzHi4wcN1l3YdF/aa+trJLFT0sJWGjlFJg6G5CiU6GuWBg
 uuGQKAdP1lYhUZ3Yq80Lf58ZKZwX8lUITvR2I3W1ReltJ0VsSnyOQxlLdmHCzH5JS/+B
 uEboFJtaaeI1XROEfgmd5rdoz3/dNL7diqbNeqrUg7m3M1l3ZXsZulggwKMHdo8KzKWy
 jJUg==
X-Gm-Message-State: AOJu0YxnYgAOZ6Q3wUiyrtLqPe6mFkw3nFz1JSg0fWt5dyX3j4rKWQrp
 HT8kszw7ShY/E/yYyvMk/ltaSI+Nhjp7YLrGcAGeXgzaKwaUVRiibCktnkbkJMM=
X-Google-Smtp-Source: AGHT+IF2dV+mnvIVh/UYqrMW2OxHYyElgZ46gLxfQDBCRxW4D2brDgQpoaYLtmfZotr5n4RWQnKLOA==
X-Received: by 2002:a2e:bc1c:0:b0:2fa:bd56:98c5 with SMTP id
 38308e7fff4ca-2fabd569ad2mr54342421fa.33.1727691839881; 
 Mon, 30 Sep 2024 03:23:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c299aca5sm512957766b.224.2024.09.30.03.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 03:23:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24F295F7CB;
 Mon, 30 Sep 2024 11:23:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  ncopa@alpinelinux.org,  bofh@freebsd.org,
 emulation@freebsd.org,  virtualization@gentoo.org,  dilfridge@gentoo.org,
 hi@alyssa.is,  edolstra+nixpkgs@gmail.com,  brad@comstyle.com,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  dvzrv@archlinux.org,
 anatol.pomozov@gmail.com,  Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
In-Reply-To: <CAJSP0QVB+e1JSyQ3iMRivyh=ufyDkz12AESvJhoPnYJEnt9eug@mail.gmail.com>
 (Stefan Hajnoczi's message of "Thu, 26 Sep 2024 11:03:40 -0400")
References: <871q16fq9c.fsf@draig.linaro.org>
 <CAJSP0QVB+e1JSyQ3iMRivyh=ufyDkz12AESvJhoPnYJEnt9eug@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 30 Sep 2024 11:23:58 +0100
Message-ID: <87y139o2wx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, 26 Sept 2024 at 10:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
<snip>
>> Another potential area for conversion was the VirtIO device and
>> vhost-user code which could expect to re-use a lot of the crates from
>> the rust-vmm project. However this did bring up the point of maintainer
>> buy in. Stefan brought up the example of the simpletrace rewrite which
>> while it may have brought some advantages he felt he was unable to take
>> as a maintainer as he was not familiar with Rust at that point.
>
> Familiarity with Rust was not the issue with simpletrace. I had
> already worked on libblkio in Rust and was able to understand the Rust
> simpletrace patches.

Apologies for misrepresenting the issue there. My notes obviously didn't
capture that nuance.=20

> It was a question of when rewriting in Rust is appropriate. Surprising
> maintainers with a rewrite is risky because they may not be convinced
> by the rewrite after all the work to write it has been done.
>
> In the case of simpletrace there wasn't a clear benefit to a rewrite:
> performance was potentially better in Rust (performance hadn't been a
> problem for users though) but usability was impacted by converting a
> scriptable Python module to Rust (requiring users to rewrite their
> scripts). The rewrite was dropped.
>
> What I tried to express at the Rust BoF was: talk to maintainers
> before embarking on a rewrite.

Yes this is the I think the key takeaway because the project would not
be able to absorb a bunch of drive-by rust rewrites from well meaning
contributors.

>> With relative inexperience there was a concern we could inadvertently
>> introduce technical debt in the code base (C-like Rust vs Rusty rust).
>> What can we do to mitigate that issue?
>
> My suggestion is that every `unsafe` needs a comment explaining why it
> is safe. That increases the cost of using `unsafe` and encourages safe
> abstractions.
>
> There are plenty of unidiomatic ways of using Rust, but none are as
> bad as sprinkling `unsafe` everywhere (i.e. writing C in Rust) since
> that's how undefined behavior is introduced.
>
> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

