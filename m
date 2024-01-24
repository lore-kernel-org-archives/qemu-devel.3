Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5335DC47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShPc-0003SL-1Z; Wed, 24 Jan 2024 12:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rShPZ-0003Rf-Ej
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:51:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rShPX-0005Oi-SI
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:51:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ec34160baso14005915e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706118696; x=1706723496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hg2CaFeSRERPSRSpgWVp6h9hUCgu+AWuuixAe4CnUwg=;
 b=zBq2Pp9lWvF1s9tT5KIcuwOlv2RSiWY4K2smvGolMbSXTjCz9KKdbXjGyKiwQlDbPt
 vtaES+422oycBynYp7u/t05/jn//pBaDOmMi5aRsBaPVtL1zpkX/yl6RLVSr0I6E+YMf
 FC82e1j05WJ3IPvmLuH+FghE4Bwx8THJ4iYW5kP4oX3U5nzS8JiJbNhYbf4v4F7wMnSu
 jCaNViNRh1Erv/D9v5ErV37PRRpJKYtDGpXZ62oNsv7Tdh5V0O1u9yCjmTqwOip4GuJ/
 zahGptvf6eM7fw0Pk4Rx1kpkpQlSpQhrFIlIFOcX/ag2171GhRBKm7FTdDkSmWzukoO7
 EjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706118696; x=1706723496;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hg2CaFeSRERPSRSpgWVp6h9hUCgu+AWuuixAe4CnUwg=;
 b=i1Kbx3lIFLEhQA2gATK52+1eu+EGQs1tb3OPemtA4iBb7DNWeSl0af060ekQZA3O4c
 kk2jdNhLW+hD9bmTbk6pzJUBYMYpeiSojVSjPj9Dim1TQxhMI/G3/lmxjTnXFPitWcNL
 vWzKY30KFNNzbQ28w+mOLX3Yc5MCSuLG6b0Pq4/YddyYJ5KL7lF47fgnRkKCwD8mFabR
 tM8FVAgOhRreE8kYX0XtrgcA3qeBDQMC2+PcW0BHdg9j1fFu0fMJEo+8gFQlqBZWiKt9
 37WefrLfZMv+0BMIVS6o5PIkb2I+Cija2cjMARafLZp05Jj0fegkrGC8KznxrnkrAAPJ
 ZJNg==
X-Gm-Message-State: AOJu0YwBe3RC4urUMs9sOdgncb1ViqCi30oIe2MFqGb/f7RzE5dRERms
 jWQyk2Nv2/SCpZAOTb/HBCS0hBoZfM8wGOGeWCUhs7NZW87A93JJa8iaVA2qVepAFQO6szBn8fk
 e
X-Google-Smtp-Source: AGHT+IEKen4F4PaI3+xxKM6MZHw9nH+q3IsThSAO/BTdND7xqrFzpb8IYNoEDgdicenIAlBs1ywUTg==
X-Received: by 2002:a05:600c:19d0:b0:40e:ab32:28ba with SMTP id
 u16-20020a05600c19d000b0040eab3228bamr1895391wmq.72.1706118696285; 
 Wed, 24 Jan 2024 09:51:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d19-20020a05600c34d300b0040e48abec33sm352268wmq.45.2024.01.24.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 09:51:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84BE25F754;
 Wed, 24 Jan 2024 17:51:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] configure: run plugin TCG tests again
In-Reply-To: <20240124115332.612162-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 24 Jan 2024 12:53:32 +0100")
References: <20240124115332.612162-1-pbonzini@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 24 Jan 2024 17:51:35 +0000
Message-ID: <87wmry62mw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Commit 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10=
-18)
> dropped the CONFIG_PLUGIN line from tests/tcg/config-host.mak, due to con=
fusion
> caused by the shadowing of $config_host_mak.  However, TCG tests were sti=
ll
> expecting it.  Oops.
>
> Put it back, in the meanwhile the shadowing is gone so it's clear that it=
 goes
> in the tests/tcg configuration.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

