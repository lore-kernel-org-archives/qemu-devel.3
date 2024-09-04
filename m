Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174BECD4F24
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slwCu-0006zr-65; Wed, 04 Sep 2024 16:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slwCs-0006zN-SK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:02:22 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slwCr-0000y2-5A
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:02:22 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5343617fdddso12118421e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725480138; x=1726084938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SJ4H/7ZpP9KlLxBtXH4dKpopY73KLAo2L1tAMTkFKU=;
 b=VLDh3K/a6KtAliIMr0AY0/tLVaDBZ5RSn15FCR0rZ6u7DjJUupKi4301Oc3Yv1JpWW
 k3C6sCtyUBThCIXZOhI/AsN9YJVUyss1tZ2ZIIEFSPNHizsIIUKFtPWCAGypVZ/qs59X
 PKCpo9mqtqjuXZkW0b/wGe1Dwwi+Q0DeEnHwapBfEn3whhE/1BYivOawygW1qpiFwtdk
 Bv1CO75+o2pZhuaS8Y09RwnGchQ3WDKJd0LJHR02D4P8yT0aVRpTkTS7hQdR/xpipwIK
 jkWJsZ7PcXCL9KFHTILQkvzWLGQxRr97DZYd626BSjJapF/8hks0LPoI3pKFWsTdrBO5
 ygHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725480138; x=1726084938;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7SJ4H/7ZpP9KlLxBtXH4dKpopY73KLAo2L1tAMTkFKU=;
 b=i1mEHIwlHTeRfoRyBKzglhdL4ImERx3mmOJdDRw2G1+N65efxYAX05vl7KPmlW4jZE
 tWfH2wxVPB10feTIhcDWWtA5diyPGshKmVxZhvVq9ITrNwJtJM6DIAwLtC0LA/6/RJR9
 Osuj5g9nH9xPJEeFjFsqqfHNbC7uhbwwjLkjFvHNYe3ktwZxmEs9bnKmxyzYrT4OEpxv
 0Kujx5JFmDzQ8rFI0XnWdWKNiYuQ1a/itdqdzMF+8bu05Vlern+ymBRJf9cRU/PE0NQz
 UhjyZ80Lz7uHbKmZ6JF70SJCZuN210NkuV+kzvqg5/hvQFkbCIcWOlpBPNWB8MKySR6H
 bfJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOBSWsBaQcVE4DYPM4okT4K8YNWVz6BPY3WAyvucAtvzxZlzCgHTxC6reT0p314XwjjnUylJlnQ4q8@nongnu.org
X-Gm-Message-State: AOJu0YxtYbmrc9Rtiacx1xcBa5JIi1QT3FL+r7IGs9h6pS8i1ULo+2LL
 H4yQdT7wTBbfcGl7t3U2/PpfnafEht3nsFbBgiff9tb23WVaZGhimYWrcnV733w=
X-Google-Smtp-Source: AGHT+IG8QOdR8GA46pYNWtiLPKAJdpaH2SmbNqJ2B4Xmnw9ypHBVyfxUJt7QA4sKjvORqZfh+dj/7g==
X-Received: by 2002:a05:651c:4ca:b0:2f6:4f5f:96d7 with SMTP id
 38308e7fff4ca-2f64f5f9b5fmr45157501fa.37.1725480137284; 
 Wed, 04 Sep 2024 13:02:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc4a4f40sm292466a12.0.2024.09.04.13.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 13:02:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EB745FA1C;
 Wed,  4 Sep 2024 21:02:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org,  Yotaro Nada <yotaro.nada@gmail.com>
Subject: Re: [PATCH v3] contrib/plugins: Add a plugin to generate basic
 block vectors
In-Reply-To: <20240816-bb-v3-1-b9aa4a5c75c5@daynix.com> (Akihiko Odaki's
 message of "Fri, 16 Aug 2024 15:05:35 +0900")
References: <20240816-bb-v3-1-b9aa4a5c75c5@daynix.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 04 Sep 2024 21:02:15 +0100
Message-ID: <87bk13tcfs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=2 autolearn=no autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> SimPoint is a widely used tool to find the ideal microarchitecture
> simulation points so Valgrind[2] and Pin[3] support generating basic
> block vectors for use with them. Let's add a corresponding plugin to
> QEMU too.
>
> Note that this plugin has a different goal with tests/plugin/bb.c.
>
> This plugin creates a vector for each constant interval instead of
> counting the execution of basic blocks for the entire run and able to
> describe the change of execution behavior. Its output is also
> syntactically simple and better suited for parsing, while the output of
> tests/plugin/bb.c is more human-readable.
>
> [1] https://cseweb.ucsd.edu/~calder/simpoint/
> [2] https://valgrind.org/docs/manual/bbv-manual.html
> [3] https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a=
-dynamic-binary-instrumentation-tool.html
>
> Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

