Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F72C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9wP-0005LM-Rr; Wed, 12 Aug 2026 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu9wD-0005HV-4p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:28:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu9w1-0008BL-Fh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:28:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so588808f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786544874; x=1787149674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Xysba4Cq8GaBibqF69gcG0wRXDAvYg1XdZ0u+2GvJI=;
 b=FgK1l9Juyad0icpHwQ0yw59uODRBWTp49+1r7qCx7FHZkahI7ms6yzxsVrrK0bFk/l
 BjKTPKOavlcm3illw/ofQ5rcS1OC06GqwQMEYLa47m0rddXCkhCwZT0cHGyv+I4RXvxr
 pMFeiPVIQ0oxHk4VdsG9RT6bFFqLyhEOtgPC8RQoZidE8zT7eI7F7PDgJMauX9Njy9Um
 /Qr8xfWX9BDWsofltfKadkEvucuxo4WkgpOIzY5JCP1sHWNWYZptJB2TguyyhwDVWzAg
 Jkp4ADSQji481L0jiK4r52qipzdR5w04P5ii5tc1O1VRj5dcwTQXDmg+SNVfLGNl6gQ1
 VOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786544874; x=1787149674;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Xysba4Cq8GaBibqF69gcG0wRXDAvYg1XdZ0u+2GvJI=;
 b=nd3R9qFM28rA102YPSKRJN1XvNyISvslIk4tbYw9oALNpiWFqlUjCf/t1UXqnmSEEt
 bTxPfJ/BcvlXJR4TxOFIIUZz9cO+X1blw0CUGk4FNsn/lQ5A5gz5h0a2ROj7frYeUp4V
 PpPJjR2f2YmgrEEo0yJfC10fDd0HxhhcIlMy6Am1h9/I9WPV6Byd7VwfZmslF9LGJ7XW
 n3JucAKTXoPXKN3KL0t/xbSJ+lK+M9jVrM33nt3R+2YDwQx9P+9pDzhe5AG3ViYfHq/s
 NIaKJcmH11Hp/WfNM1rE40PuE8EnEMA7bsiwgBbGF5Lz7fli8vkZnpU2SgzUaEe7OzeP
 0p0Q==
X-Gm-Message-State: AOJu0YwxBLXHlHxPktWPitxI8TfCrAzsE8FJzy8T6PbHUzQm+4Z66OkY
 E5k517EGSSMq9tpBCco4LXoVWqY/H1XmPEOnkp+mBXginirrsXsQ6s2/rmW1n2b/doc=
X-Gm-Gg: AR+sD10wfV7YTeRwHU7nhXghfJi8oq3w34o5OX+/Mq+8ro6LaEULzxUEXHGQF2dhJ0S
 dkDgFy83+v1ib5VKb+Wh0rsqWUAB9iYl0uEgcKkvn5fXE2GWzPmCK8LXkvBOlca03LcaIRooGE9
 bauq77hbOI3mnsnCiLDYC+0mheEZsWfzRf8ahtsOM437I6RuuPcB7qXXs7/1czWDR5ASS1SFnrI
 59QWWw5fvbdok3nFvhPP8i4vxZUT0EL3X5J6Z2j9pn05ifEwi/9gvmpNLnWOemXuwePFm/YlGno
 CDEuVsHOrjjGt5oKJqqFuctmfgyt1iBe7G01c4VwHab+IwS84eY+3kqAGPOjWCrrEQDuz/j1pOy
 4jxgi2H1PPnMHw/ghAcbSjhjm9YVWBc63Jaw9AamAxc2fNMD/uqMNmYOQs5gHFbus8BUQ8rm6vZ
 1yO8ZoZXp8mExbEFEeUH+m+OraBRn3/2EDkNQQFDb2697ez74s3o7zensCJ59peQsQcA==
X-Received: by 2002:a05:6000:4819:b0:47f:eb22:4d9a with SMTP id
 ffacd0b85a97d-481528ec648mr8153112f8f.22.1786544873698; 
 Wed, 12 Aug 2026 07:27:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f0esm7564858f8f.4.2026.08.12.07.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:27:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 249CB5F886;
 Wed, 12 Aug 2026 15:27:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
In-Reply-To: <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:41 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 15:27:52 +0100
Message-ID: <87ecg3za53.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> tests/tcg/mips/user/ has extra tests that are not currently run at the
> moment. Keep their Makefiles until they are implemented.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
<snip>
> -else
> -# For system targets we include a different Makefile fragment as the
> -# build options for bare programs are usually pretty different. They
> -# are expected to provide their own build recipes.
> -EXTRA_CFLAGS +=3D -ffreestanding -fno-stack-protector
> -

Ahh here is where -ffreestanding came in. We should also check why
-fno-stack-protector was added.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

