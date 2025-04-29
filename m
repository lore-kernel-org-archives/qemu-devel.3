Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FC1C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nsk-0004Mv-Kt; Tue, 29 Apr 2025 12:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsa-0004Dy-Af
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsX-0004ep-TE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso4129532f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745944335; x=1746549135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UaBqPwU8v0bxHExIzn1AypHbV/LUoB1l5R7CUYyKSz0=;
 b=AeupGfTevFAgxKw5j7rLzkdZ+akiZj0cpBAXGeso3pHlRCCa1Fw3Oe3t1+w62ofgqT
 bZRCt3MMO5ET3aPauxZi/mKrtNZfKSyQBKuQHeDApXg5eXA34k5dukilrJJTc+DRQPwg
 wFwpuJkVDXrIhOpsH/PgKz4GpnncN2hSeUbtFIzG23ZC+ZTqQs4AisYmZYqor8h/CeJp
 ZunCXO5cLZOkTeRyIBdGjmq0wqm4oy7jYz8ugs3cv0AViMimoGhTxnLWk4tTC/96epdT
 j6AYE44LMsuGwIJGxTFIpoSxRX/lrFjP6CO5wpesrtd4aRAyvc3sdo5FwcjiZZDsyWNX
 MSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745944335; x=1746549135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UaBqPwU8v0bxHExIzn1AypHbV/LUoB1l5R7CUYyKSz0=;
 b=kDtktWRRDbpetM23F15usIP5TLAUejxHIsPE/XBXaTHGffLPqP/Jg0L5aa9hnzxMLs
 N2XTgSBnTov51q/UwUR6Minn3c/BI53lHXZ/DEDsQZV9Pv0nmH46MwGHKb7skhE5bVi6
 d/ImCB/UeJH9WqeO8p3+G9f8q4LBPnqYPd7eX7Ly6hEfCUy90HK6FTtAXYs5E/0gTrTu
 hYSU0Gz+9B2giMI0p2SUxrv/09Gs4vxfAuqBT0d49YiJ7Tdeo/CO2XrS2vRWBOZXhrC/
 Qld/LkVHYkX66f2ILtK8DOnMaFiTkwQJGAiaYxURrP3ChFXHn7QqwVJ10pow58bZg3EP
 8pDw==
X-Gm-Message-State: AOJu0Yxe7SadpSmddR7g9Pip+xK4jokkNETfiDKM7ML0mvudBePG+l5U
 4P5UASKIZLssJpaaRoSeT8TWahWqDK0ffHyjOWKNhOlNTRzVIQbBx3D+pP89Yt67pre06lJvFG4
 Z
X-Gm-Gg: ASbGnctKu3bagMlF0J8xgh3MDMeO4C/tu2WsUWEDpdVLmGM0ODcgkXFb/Tq0lHSJlf/
 lzJDz8mtyclju3KpmqECC86AC63Yz0aMSxdmkeHcrib142amXgjzwC1T9TGxCYQpwA9fbgIjejO
 gViw787rWIea/lYt+e/qwb+jhyAg8u92T1tVTDQuVyeg4jnbuc08Q9aKo/ED3g7xvVgFgvRVGSG
 utqPaht3VKsZzUdmZa/1tjfahZeEgXgQunZPlM1c84Sx+Vwirizb9Ee39we+BQlbDoDRb6zBRbq
 n3B2J0TyrhtJW9gcIEU5LM4Ps8lTeCjBGO/+JZdQop9mrXg=
X-Google-Smtp-Source: AGHT+IGKMYVW2Eqn/ecIuO8bJLhGT77wSlS5j4yB2A/+FVp5LJZbHtRxjggADKA3pVvZyff8ZJ/5bw==
X-Received: by 2002:a05:6000:4201:b0:3a0:8826:d9df with SMTP id
 ffacd0b85a97d-3a08f7b8472mr10499f8f.49.1745944334505; 
 Tue, 29 Apr 2025 09:32:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm14176326f8f.25.2025.04.29.09.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:32:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] docs: Avoid duplicate labels with a sphinx extn
Date: Tue, 29 Apr 2025 17:32:10 +0100
Message-ID: <20250429163212.618953-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Sphinx requires that labels within documents are unique across the
whole manual.  This is because the "create a hyperlink" directive
specifies only the name of the label, not a filename+label.  Some
Sphinx versions will warn about duplicate labels, but even if there
is no warning there is still an ambiguity and no guarantee that the
hyperlink will be created to the intended target.

For QEMU this is awkward, because we have various .rst.inc fragments
which we include into multiple .rst files.  If you define a label in
the .rst.inc file then it will be a duplicate label.  We have mostly
worked around this by not putting labels into those .rst.inc files,
or by adding "insert a label" functionality into the hxtool extension
(see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
argument to SRST directive"). However, we let one into the codebase
without initially noticing, in commit 7f6314427e ("docs/devel: add a
codebase section"), because not all versions of Sphinx warn about
the duplicate labels.

This patchset resolves the problem by implementing a small Sphinx
extension. The extension lets you write in a .rst.inc:

  .. uniquelabel:: mylabel

and it will be as if you had written:

  .. _foo/bar-mylabel

where foo/bar.rst is the top level document that includes the
.rst.inc file.

Patch 1 is the extension; patch 2 is the use of it to fix the
problem in qemu-block-drivers.rst.inc. (Concretely, the result is
that instead of an ambiguous "nbd" label, we now have separate
"system/images-nbd" and "system/qemu-block-drivers-nbd" labels.
We want to link to the former, because the latter is in the
manpage, not the proper HTML manual.)

This patchset is a bit RFC quality -- I have not tested it
super thoroughly, and the extension itself is written based on
our existing ones, because I'm neither a Python nor a Sphinx
expert. I figured I'd send it out to see if people agreed that
it was the right way to solve this problem.

(In theory we could remove the SRST(label) functionality from
the hxtool extension and have the .hx files use uniquelabel.
Not sure that's worthwhile at this point.)

PS: I find that our extensions are confused about whether they
should set "required_arguments = 1" or "required_argument = 1";
probably the latter are all bugs that happen to have no bad
side effects...

thanks
-- PMM

Peter Maydell (2):
  docs: Create a uniquelabel Sphinx extension
  docs: Use uniquelabel in qemu-block-drivers.rst.inc

 docs/conf.py                           |  1 +
 docs/devel/codebase.rst                |  2 +-
 docs/sphinx/uniquelabel.py             | 74 ++++++++++++++++++++++++++
 docs/system/qemu-block-drivers.rst.inc |  2 +-
 4 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 docs/sphinx/uniquelabel.py

-- 
2.43.0


