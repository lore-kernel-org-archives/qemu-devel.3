Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB9CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBqK-00047j-HV; Mon, 15 Sep 2025 12:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBqB-0003yO-Cx
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:14:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBps-0003b6-C2
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:14:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45dec1ae562so40025085e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757952821; x=1758557621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO/ldWjErKpfl976r4mFLe5HyjWQ1Qm8Aiwr3AGIXXw=;
 b=qW2dFHOCsduvxIWNt/4kC5wnkdbNWtK1qlFhA/SL2M5oLWy12bjKfLTRmIAX5A4AUK
 JJWzW6tq+WJ5Yku2EMQ7wFMQpaIwovRzyhfBjdjJhZ1zr7VV5aOSLZgfk95FBIkai9sc
 2NGF8qYkBlyO2cScN1RoJd7rPVXCFtHa9JfR3Stgt5l4BlH7qRh7Li3Z58PZaN5UPT+w
 2suYOtouF2sn+abkYMQv0zrrKzxPCUvLbu3dcSPMgxkj/UBwsFNJGKRvlTEsXcseIHBC
 8FoBGqCRsszXA2/Uifdov/zoy6SdS2RrytIp39+JcUjTvWSCJD45hHWSuu6PzN5tWpbW
 aOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952821; x=1758557621;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eO/ldWjErKpfl976r4mFLe5HyjWQ1Qm8Aiwr3AGIXXw=;
 b=EWKcArhuo5Q+av9JCOVSKBsD2w+jn7XuvQUf5prBaCEzCSuqf5CZgd0eVw8RnBjl6N
 kRfIbM2uflQZyt6204niyhiWHyd//F7Sgq5njtpwayGdAEHSUZLHtJTILVTYW0JWouvd
 FpPDFH6kbF3i/iWjldoBBAUE0Ri31KhB5BVDleMZR81tO1qW4QZ2YgTA1t29eGcATiPB
 WcNFhuY2KblsG2VOLX2Qpa5ssbREUpBWREMNjthhwIYXJzhE00dX6W7xuK3p786jqS1S
 B5Q/R3bth23K7JaQ+mHFeyGyA7aR3mc4FIGWvEj4KzX2Sq6MAu8OR+Jm+8/KXzuO6wUE
 I0cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUQ/E2I7vn2Wm9OKdZTbymhfI0JFY3CIAPIEkHoRw5MhDabU7E/wXxW26xmMxEUsSDLk8NFJdtyE08@nongnu.org
X-Gm-Message-State: AOJu0Yys0RnbxlArH7tT/GO4+fdYBeTjEbWXOqHJXGIubp83BEiFmmwb
 Q2LrJ8dAm/hZU2yjMUnV5JX+ZHjj1hQYosYluZEZW2Ka4b2zTkEvjIbB3Ov6/47gVlc=
X-Gm-Gg: ASbGncuDEQkQfM2Ib1WcpMoHKMtL1/Foc95nBHaLs3/cFqE34LAGl0ewXJ4egwaayR8
 ib0gV8U0Tpq5pzCHQCnLFTWWpAxwTZgHNW7UM1h7v349+PCycyd/w51aMzYAnl1wmhtf635qvVv
 xtWPBbL9VZ6dPxI+/BNgdZF2+Hw6hEMoVYxliXipcaT4n26tviwCO7l4y1ZdZE4zkFLd1626mCO
 c9Abswut+DhRBXtMtcjygIAM95ASjJ+b7gRyOP8kAGQ8B6z/sKTd/KYv9fOcuYnB5ASfFQNouNg
 tLbBcE50ebLzJ2aC0MSCrFZiIEafGX/jhHd+97FR9RVBrr8iaY4F5Ln7BDetpn167zdewnwWtLw
 B5XE90dImrxVVkdUdMUjOwCIQ/hZgVCdT/Q==
X-Google-Smtp-Source: AGHT+IHJemgtGHz0vInWrPJBlhVWvOOYwIcRhwDG46HEyOvN5sz+DvlNL67V6g/7iKYNvfya7NPi/g==
X-Received: by 2002:a05:600c:4fd6:b0:45b:76c6:cfb8 with SMTP id
 5b1f17b1804b1-45f211d5d7bmr113392055e9.9.1757952820854; 
 Mon, 15 Sep 2025 09:13:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f2a13bdefsm87276125e9.14.2025.09.15.09.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:13:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1506C5F867;
 Mon, 15 Sep 2025 17:13:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to
 run w/o Avocado (yet another try)
In-Reply-To: <20250915124207.42053-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 15 Sep 2025 14:42:05 +0200")
References: <20250915124207.42053-1-thuth@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 17:13:38 +0100
Message-ID: <875xdjpubx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> Here's yet another attempt to remove the avocado dependency from the
> reverse debugging tests: I basically took Gustavo's patches to rework
> tests/functional/reverse_debugging.py, but instead of calling that
> through tests/guest-debug/run-test.py and adding the cumbersome code
> to support additional test execution logic, I kept our normal way of
> running tests via pycotap.

Hmm I was getting:

  2025-09-15 17:10:50,798 - INFO: GDB CMD: /home/alex/src/tools/binutils-gd=
b.git/builds/all/install/bin/gdb -q -n -batch -ex 'set pagination off' -ex =
'set confirm off' -ex "py sys.argv=3D['/home/alex/lsrc/qemu.git/tests/funct=
ional/reverse_debugging.py']" -x /home/alex/lsrc/qemu.git/tests/functional/=
reverse_debugging.py
  2025-09-15 17:10:50,803 - DEBUG: Using cached asset /home/alex/.cache/qem=
u/download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7=
 for https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/2=
9/Everything/aarch64/os/images/pxeboot/vmlinuz
  2025-09-15 17:10:50,891 - INFO: gdb output:
   Python Exception <class 'ModuleNotFoundError'>: No module named 'pycotap'
  Error occurred in Python: No module named 'pycotap'

which asserted. Should gdb be seeing the pyenv PYTHONPATH or should we
add a check for python3-pycotap in configure?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

