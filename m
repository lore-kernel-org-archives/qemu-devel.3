Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7578EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NLi-0001lP-Rl; Tue, 07 May 2024 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4NLc-0001iX-9Z
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:07:20 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4NLa-0002iC-9e
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:07:20 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59ad12efe3so342253466b.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715098036; x=1715702836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TP1FgXBF3m9vYvYA4upsaTzKdZ5oJq8oEXgUEvRM7jU=;
 b=sMgQwPM8MdDVNgI4M3lCzQzBy4Ri9tZX0NbCTWNJHyW64C/SRVgrHlzbhplfdSMmeA
 1Nht0q/ddXvrT/hzV2XC5FGfZyLL8+dPNZcB1HFyAuuqyh3jeZInmx5WbWkmV64K33/T
 hzqVimiCZ/x3gNWK6JeWJM/xaKto6/BkMlqzF8UyLiH62yoipD3PMuL6UvLHl6k61GwL
 +kxbns5I0/SyY/yYSYsQPHsC7HzYjmv/cZTwbD7Jb1uR6PkuGY7dVB4HVaLyKB4l5pHo
 /UsltnsySjwuAyU4UpPHKU0qwKsAgGt30HZtHZjLyMgSGpcOHrYdPOBpYj4bTnRWK1LG
 4KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715098036; x=1715702836;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TP1FgXBF3m9vYvYA4upsaTzKdZ5oJq8oEXgUEvRM7jU=;
 b=xKA8QfhXra+M9HHtPcltZBqQBgTBrTP1MWvnPlhdURjgm7VIOa6v7rJo0ld/jYl6vd
 ON2wIq1EW+90C16lhDpPx4/wjRwweBiFZgkoVWBmeACIW+b6YaFNVfpWDErXluivqjX8
 ULMABTl0OX/efg/FdhAioLHgYbheQjGkuPeFMqFtt5Ac419oA8cTdvV72YE8sjOK3N1U
 Zhl8Ieu9qNwaSpIRQSW96ZTUTokHsJ+GLKXbsqeo/UW9HE4IDtBgDl1akPYZM8SdsfmV
 nM++f7feDSXmPnwUFTkZ3kqy72JWmH2TQGzfV5Xr/CiD+YPrrqpprk5wL7Mc0wGNBoBX
 JtHw==
X-Gm-Message-State: AOJu0YyMoTsYLgINgL+hwTQwygo61zFwi/nAs3n8S01WiwxmD/Xpba6i
 YRWMRm2NcFbEAvj/1Lq1V3pUv+7WN46CRBUWJS96fiTOQMZ/eSoH9YX8kOKeDK8=
X-Google-Smtp-Source: AGHT+IFMi7dZbYflyz/F5Trk4MRtXVug7mUKHWeLyiWey8S7EfAT44wLLyhSGmlkX3xjT9Yqo3xTLw==
X-Received: by 2002:a50:baa4:0:b0:572:325a:8515 with SMTP id
 4fb4d7f45d1cf-5731da69864mr154809a12.36.1715098036512; 
 Tue, 07 May 2024 09:07:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p8-20020aa7c888000000b00572aba0d8a0sm6468903eds.88.2024.05.07.09.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 09:07:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8093D5F87D;
 Tue,  7 May 2024 17:07:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/9] TCG plugins new inline operations
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 2 May 2024 14:15:13 -0700")
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
Date: Tue, 07 May 2024 17:07:14 +0100
Message-ID: <874jb9hah9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series implement two new operations for plugins:
> - Store inline allows to write a specific value to a scoreboard.
> - Conditional callback executes a callback only when a given condition is=
 true.
>   The condition is evaluated inline.
>
> It's possible to mix various inline operations (add, store) with conditio=
nal
> callbacks, allowing efficient "trap" based counters.
>
> It builds on top of new scoreboard API, introduced in the previous
> series.


Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

