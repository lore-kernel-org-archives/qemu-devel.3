Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FBDCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjIJ-0001yb-RT; Mon, 08 Sep 2025 17:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjII-0001xs-85
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjIG-0004H1-DS
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45de64f89a9so11469615e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757366454; x=1757971254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1SjMSKszHBBJ+unyScEswrP5z9oHSKbf/GNNmBPHI8=;
 b=sMrI3tcMcUVTxex6KfhzgFTZLyHSOcJQKXuu8hgKwO5AZ4HpxF8jq8vWBTyL9JtZIN
 4eWR01M6YrnMvhsuzRiYcekPuK90l82J8+nmjeJb75bUoTT8+mezWDhbdi5XDXU4Ftvj
 3vUt2c+1OB3QX4NQ0FUVQiR0xEFMNf43L+7FH/FfgJlwBbLa3bcezN5cnQFicUG9mMZm
 b1nQNU9I+LCKw7mLA1PcschqPKlLrQ3bk/7GPEHSsO9XxUw97q4iqUiIrkJMPck/qwC/
 05XDsHCiex7beFXWRYYLtdwWhoYv46Lwqh3mbCYy/htG/S05ANpHIDlCq+O64Hn4xW+5
 2NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757366454; x=1757971254;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1SjMSKszHBBJ+unyScEswrP5z9oHSKbf/GNNmBPHI8=;
 b=mNCx/DTgESvS2ylilrUUCj6kGaQZhBFYavSC1FHjLQNt0ppq0TWxBgnntSmMVVxlOs
 FItP/UPZB3KIgMCm2R5ms2lOBMcgqvlh6A4cMFVKaBeJEsO/KRKKDdpRNe89ekrkJJDk
 T68+mVeAebjxku7+IBJKelKGMVaZFkr25JqUy0o8vqA4/Jv/btAedRkd1iDgGMDXVnjU
 MuJbhVm1IJD6arUo4rKVYAo82OmbO8eVZPGr7ugwlQxWYfQmsGFc6Z8Nn+VExkhEbokY
 YpGpV8MBRlEEXIJMCPxGTkFUyNridTPYa70uh44nBY3Q7PwhuzvqhGwy00TJSIr8gKzS
 TxHQ==
X-Gm-Message-State: AOJu0Yy3TBjNfL72oz9WvpeA0YV+fdaiOC1ZkNGtpmlVjlgtCcYv0s8O
 A1rfYQtcayenydJ6CzVyT9GeDlUztKdgG7ZL/PC/2fyVWHQhYu02XfYtCblUIAt0BqY=
X-Gm-Gg: ASbGncsPiyr+H7bC3fzpAlCb62qFgO9TxYvXpqxKA1Ueee4QvPrbu1mCcbHzcEBkXbU
 G+fl8uzlJMWDzQZ53loGa7SXZFf+PMLRcVkq9xj1fXy0YAOY8WFCDj6GByNvd5VA/5dj0Bob9gB
 Babi0Hwft1U92oR+APmGq1h3RztcXB5fQ4ZqHngXyIHxkDKeyUdWXA4wLAlWMGtK/TvI2zTywgP
 MClee7p0UWCx3vpu907uFjer+dnWT08k3dsdcE407v+7p7WQN3N+dTGWI36nm0R+tf+/1xC1WFh
 Tu6rNzEtng7qThBJUsNN7ixlXJ8TMqET9D8ohT9Ht8ol30FSHt70LbHzFInACwN94hJ4BzIfE0h
 zUG4w6IdIvwCKsKfbF4euETk=
X-Google-Smtp-Source: AGHT+IHLEkDnKz6hYb14CkXN5lnh1BVHDZkAz4Rf0AWoFUmeBbg3PiDF7cvwq8OQauL/i423C8smEA==
X-Received: by 2002:a05:600c:4f81:b0:45b:47e1:ef7b with SMTP id
 5b1f17b1804b1-45dde21d020mr85893365e9.17.1757366454013; 
 Mon, 08 Sep 2025 14:20:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dec3e2fd6sm15622725e9.19.2025.09.08.14.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:20:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 868DC5F7C1;
 Mon, 08 Sep 2025 22:20:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH 3/4] gitlab: include all junit XML files from meson
In-Reply-To: <20250908190901.3571859-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 20:09:00 +0100")
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-4-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 08 Sep 2025 22:20:52 +0100
Message-ID: <871pog8wuj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The junit XML file produced by meson does not always have the
> name 'testlog.junit.xml' - in the case of 'make check-functional'
> there is a 'testlog-thorough.junit.xml' file too.
>
> Improve CI debugging robustness by capturing all junit files that
> meson produces.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

