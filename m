Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F027C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to2QB-00014T-Sh; Fri, 28 Feb 2025 10:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1to2Pn-000125-3e
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:36:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1to2Pl-0003cq-5p
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:36:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439950a45daso14975495e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740756994; x=1741361794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzbHdJ0kc8poD/614I044kk+bIlzVmagaqMJIqo59ks=;
 b=YRNE3PcC1KKWt2FUFB+2lgOtfrRRBfpJuMSk3anFDC9h4/YTB/AdHEhAW0pzp38fZ9
 MULC7jHMLmvCkttkTiyLQuHH9YstpS3lHpmfoqke8MvZSa1/y7NktOGsbvoXCRBiuH1b
 2BT9F6SKzrhlxYkzPx0VtBzxECuqFDWiX0zUZ8xdXq6ya/3QvFLx7Zjl7FhZGs84m/Mb
 dYb2B6F06QnYM2LSw9zNnutIzhkBCYFyQjdvhRfoIOHpPmZLinOlkQXxD2kCcnzj77GG
 TfdKPfNaRHHikknsWdGz60jd2/7SHU/WZTbOBwVQvHggqyQtRXncNHO+20OXRPR7HWGl
 nehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740756994; x=1741361794;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzbHdJ0kc8poD/614I044kk+bIlzVmagaqMJIqo59ks=;
 b=Qz5fFTr4Er4DTw2YXeeZQW4GFMcIxzApiB4jPFapnTa8lE5cV8pjyEU3xTA/SwzzSN
 7EgUI5nzmO4vR4C6zUySn+DcXfxvLZFiPbz+INea18YbLzI0VYLsTJJRqL4EE0v9mqBJ
 Xs3FcjmzJoERAvUKxW/9aiJYZ3E2HP9iKPTP28Hp2mnFZfONOOhp3Ddqy08a/AQWj6SG
 V5EiuotY91gXt1/dEttcKUQaY1aK7Twl1G3zpwrjNifwP6trse8ZKK8iJLsFsNdeyNmk
 ZfsirR8M6VQlzDelb1AJEAe0sQemMvu17YbP+vLNH8X8UUDyDuXKj8SGRnBNptRp4mZg
 eBDg==
X-Gm-Message-State: AOJu0Yyk/nUbcEBRhnrwAbrsDOd417BwMfzl8X6htQuDeJixvpjk6r+V
 K3ldh3Ci290Dxgl/vSORTRgiS/9LHzObJYAFtd3XDhPC/grBNu8KIyqpFN9r3xk=
X-Gm-Gg: ASbGnctuFAzGXkNKn8UFQPglE+0OIfCEZLnIruOV0v1EPuGQP+jLgLRVc2iTQftbKdC
 jVdfsFrfQxeS94TfZC8bfOLcxu/FxJAwAjvSA7ds54GQyYkAsE362UowQ+Kbz76t0YduUWNY59u
 HK7dSzrmJTBrjEOA6Z9n1jTD6tDptOtR1+CFjGhCdlpYKXrIyEAmJWPfPbZIaeKRlRfu1XnoO2Z
 An4Hbnit2gaiNbppZ75SW6OFn4j5H/3Qwksj4C+UD0m3tpIQkpx81FFJqzORlw/tMzDZ78gZPDJ
 6Fnf3tcjmWNu115VtZYxgBte6gQ+
X-Google-Smtp-Source: AGHT+IFMMWpzUqVcR6/mZyW6DGI7dwRcneFx++MM08+4SyvjYhNOGaXaY5vlI822DqwS/UHxt5hrpQ==
X-Received: by 2002:a05:6000:154b:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-390eca38144mr3658738f8f.54.1740756994668; 
 Fri, 28 Feb 2025 07:36:34 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm5424205f8f.88.2025.02.28.07.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 07:36:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 186C05F7DE;
 Fri, 28 Feb 2025 15:36:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] gitlab: use --refetch in check-patch/check-dco jobs
In-Reply-To: <20250225110525.2209854-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 25 Feb 2025 11:05:25
 +0000")
References: <20250225110525.2209854-1-berrange@redhat.com>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Fri, 28 Feb 2025 15:36:32 +0000
Message-ID: <87senyulmn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When gitlab initializes the repo checkout for a CI job, it will have
> done a shallow clone with only partial history. Periodically the objects
> that are omitted cause trouble with the check-patch/check-dco jobs. This
> is exhibited as reporting strange errors being unable to fetch certain
> objects that are known to exist.
>
> Passing the --refetch flag to 'git fetch' causes it to not assume the
> local checkout has all common objects and thus re-fetch everything that
> is needed. This appears to solve the check-patch/check-dco job failures.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to maintainer/for-10.0-softfreeze, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

