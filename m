Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905E2C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCjV-0003hH-N1; Mon, 04 Mar 2024 13:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCjF-0003WZ-DK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:08:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCjB-0007U7-KI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:07:56 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33dcad9e3a2so2514449f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575672; x=1710180472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKpNF33rWE8UxbbM8s3gF28HdZDXNJG7A4/e3MVt6Jo=;
 b=YfWTqtYq6cUnRIZJtVkOrJX5/CAkt1UipHC2qEU4uad7J5mM70vzyd95BfZBynLVOy
 HttqkpQk2F3IEH2zjuVfKaiVd204N/5KEZ2BK+PitmbbR84sxDimXCDQ8CqLHeWdrRAc
 wqa9AQ3UnLN6rkrlKvlmz/fnHqcjkWu9oUq675b2KU317e3QTm65C1ke1AV7kBDzrlSz
 qcl05l6VKqLat6IUzld0AKPqvFvEI9CGt7jctxQq/gixzLgSA9EZvKC++n2Vzqj9JC1/
 QMXUKRh+kDXRc0Q0o9bkGaE2mURw1T59dDzCGI2XeHEfzNp9rurCwAvLGAn7aEJyx9XS
 3IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575672; x=1710180472;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKpNF33rWE8UxbbM8s3gF28HdZDXNJG7A4/e3MVt6Jo=;
 b=KhcEZAdskr7PQxd310glgGFrN2S2JRmuVWquLM2gXZ4WGUyMFS4X3CKKqGrvhRbt0K
 iZ1fEac1vuT27mCFOLruWPoHgZaLz7VzbKRvNnhqy8R4BA+9N3bUaqt3NrFoOpXKN2Ob
 s2pHJjGUo73nWkz1iYItof1KWnbMrSf22sETpUhJU1qHeAn8uETzo8MDbG5CohLmwP3N
 JTWQnK76Ev0qdeubBTQkp4ffo7gxySmryPYFqkC+hqUtFlfcGOjLzg9e2Xp+jdyZjLpO
 QxIKKokJiiiOuufIBKX0o7Gyk8zDFh2cnJyRxjXx6moU0KaYKwXBVPbMmusO1hj1BXG8
 Zpbw==
X-Gm-Message-State: AOJu0YyrZouPbKfKqPJqCK0DOelzEGoAgqQVn2HkZtr6pNObw7+KsguV
 J0CgNABrS5T2krGjDTyb9RDuxwaIcDauKKSUUQePeoADn1DOBdVdZGKYO+KjVhw=
X-Google-Smtp-Source: AGHT+IGNdhC8eMwfjDV4M4qH1U18GtMan8gp5Rb0sODlUZZrZC/wOKNKtZC2ystt+1o6trFhIpAptQ==
X-Received: by 2002:a05:6000:88c:b0:33e:2fd:b8ca with SMTP id
 cs12-20020a056000088c00b0033e02fdb8camr6908925wrb.9.1709575671746; 
 Mon, 04 Mar 2024 10:07:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j12-20020adfea4c000000b0033e11bd9febsm12338773wrn.90.2024.03.04.10.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 10:07:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E03DA5F796;
 Mon,  4 Mar 2024 18:07:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Yanan Wang <wangyanan55@huawei.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 00/12] TCG Plugin inline operation enhancement
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 4 Mar 2024 17:00:24 +0400")
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 18:07:50 +0000
Message-ID: <877cihyio9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series adds a new thread-safe API to declare inline operation
> inside plugins. As well, it removes the existing non thread-safe API,
> and migrates all existing plugins to use it.
>
> Tested on Linux (user, system) for i386, x86_64 and aarch64.
>
> To give some context, this a long term series of work around plugins,
> with the goal to be able to do basic operations in a more performant and
> accurate way. This will mean to add more inline operations and
> conditional callbacks.
>
> One final target of this work is to implement a plugin that implements
> the icount=3Dauto feature, and allow QEMU to run at a given "frequency"
> based on number of instructions executed, without QEMU needing to keep
> track of this.
>
> Another final target is to be able to detect control flow changes in an
> efficient and elegant way, by combining inline operation and conditional
> callbacks.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

