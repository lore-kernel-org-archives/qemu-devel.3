Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E0D41D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz2-0000ek-RN; Thu, 11 Dec 2025 13:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyz-0000dN-5m
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyw-00060B-Ay
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso4185345e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476097; x=1766080897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5/LEDQ2J4PNTA0UX9lXA+cIuf5h+pN8+iwPIJao3NM=;
 b=dyGmq6e+SWyqEm+Ekd+Oad0U9DioN2t5n6jxpkEBFgpgDT0FzvgCFbgq7B1ZX9CzP/
 tIYL7luSc+YusB83PdMYxzHth/wDqEiYs4RXJFUsNcbNkhPl0rb9bBly4L0rApEMG5eI
 /irWs4wbTkhJsfQocGvxXG6XwSlZ/T4QDSbCk3iDgGGWx3zGkvzZ5qRCBc44LI5pj5fK
 eLSkFL0fBx121kcYD4E7gE3Rmck3V1bwTCfPffeRmmyqG3PMg7DHtanWbVsEFKmY133z
 bi3VKZIod7NJWIkDDjbzugBkx6ciYRK6MXFyX9jMVAVBZwIrwJIeOBMYLbkblfVhP1yW
 hsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476097; x=1766080897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5/LEDQ2J4PNTA0UX9lXA+cIuf5h+pN8+iwPIJao3NM=;
 b=osDSYYFOvwfVUMFw9P8e3rI8Wj9D4qW8TlF+i9k3/eFz/tQffLI5cGaTKuJdf46puo
 XkQPVwfY/Lq6JZS/GQFaY0rPCgOx85Mrgtwwd43kglWD33x3/Hqxrob/diYvnyltMRju
 y8r4rNXh1ceX36r/L5EXc50h3ewCHDONAdHQUto3ory9eTad/eFYuuYL5oyr6g94LUpe
 WQXEi04eOAF5wXJMpxbwNu+uEbLX1SV+ZhJjer4AY+yxiJSpKjEpqeXcznawDXSE/IrU
 lAlPoxXFoya1MulM1pNJ+Wljg+2Fm94gN6BSYdize7iDFlJy4LtnlL6Rq/FuCpPvVDcV
 lB4g==
X-Gm-Message-State: AOJu0YycWf4uoKV/1hmcOP4ViDm1CtWnaHFuduZoXxmWt/jrdFN+vBnx
 BPTHXA101P4p5zbR9O70zDYjAPl9NkqeNA2Bn6AQQ4EZ66oNXn98r7WK5Vgwl7hYqSM=
X-Gm-Gg: AY/fxX7R29dJ9XMfoRI6294LQxplyuYm0qm2eEVqsIJoQXd76CMmULrLQehzGxBxJNU
 nnsGnXuUpQ2mLaBYuFJM5bHwo6S87RH3rouNrFiixfPVooW52YwZaFNvQc15XrB9OKRBVi+9J/J
 Y6dO7lVD5Z6Mki43VmZgIGmOknSaUy7dySEnIRiQgqOQsiGEN+xsgo9c2JfTrlZN+f5TngOsVuy
 0197Nv0WsOEwePVs86VsLmERYn/T1jT7l9WFM7I/ZAWDyyMgqXVOFWCLjfMFhtAVlFnCZJvkfpm
 tzKYqinFCrgV5022P07Rb1+QstQmNldzv/m1VfdXFeNrw6NJEmAmCpslou+pNjEgZOPZQj8lIES
 Wj5BV/IVr0fDk18/DUlm2xMG5KKH7pAoDWDR+jWDIAWJllOBfoWy7+yZs8/0jjGYK1l8JtJD1Uk
 vDx9kSNW/rZoLEPrCn806KQg==
X-Google-Smtp-Source: AGHT+IG+weZzcvJ4FnEmy75b3MPqFmsU673Z9xM8DEucTzBce+TnkkH1sFIMiR4mmeGOcN2WSBNBgA==
X-Received: by 2002:a05:600c:45d2:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-47a89f8547fmr32859545e9.4.1765476096725; 
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89d04393sm48241545e9.0.2025.12.11.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9733A5F83C;
 Thu, 11 Dec 2025 18:01:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to python
Date: Thu, 11 Dec 2025 18:01:23 +0000
Message-ID: <20251211180132.3186564-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

*incomplete

I wanted to look at adding gitlab tags to MAINTAINERS and baulked
slightly at figuring out what I would need to change in the perl
script to cleanly handle it.

While we imported the perl script from the kernel I'm fairly sure we
don't use half the features it has and as us grey beards age out less
people will be willing to tweak it. Consider this a proof-of-concept
for discussion about if it is worth perusing this path.

It only supports the two main forms:

  ./scripts/get_maintainer.py -f path/to/file
  ./scripts/get_maintainer.py path/to/patch1 path/to/patch2 ...

But who needs more?

Future improvements could include some more detailed analysis in
conjugation with the repo to analysis:

  - missing areas of coverage
  - maintainer stats

Who knows maybe the kernel guys will want to import our script one day
;-)

Alex.

Alex Bennée (9):
  MAINTAINERS: fix missing names
  MAINTAINERS: fix libvirt entry
  MAINTAINERS: regularise the status fields
  scripts/get_maintainer.py: minimal argument parsing
  scripts/get_maintainer.py: resolve the source path
  scripts/get_maintainer.py: initial parsing of MAINTAINERS
  scripts/get_maintainer.py: add support for -f
  scripts/get_maintainer.py: add support reading patch files
  gitlab: add a check-maintainers task

 MAINTAINERS                    |  10 +-
 .gitlab-ci.d/static_checks.yml |   9 +
 scripts/get_maintainer.py      | 356 +++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+), 5 deletions(-)
 create mode 100755 scripts/get_maintainer.py

-- 
2.47.3


