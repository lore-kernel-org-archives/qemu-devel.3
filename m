Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1BECD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKD9T-0001OF-FB; Tue, 05 May 2026 06:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD99-0001KO-6S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD93-0007w9-UO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:36:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ad135063so48066985e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977411; x=1778582211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5UXBDY8yrjs3dkgDO4K02KeOZmUzFqyOiL74/iE0JSc=;
 b=cCYscRQVAHVu+Ec2QXOyB9Q6kZutw4CRFpDjapNpMDDOX2aeRwLpbxnFyVgRAWwxo6
 MgW0bfWNd/cnIOOXJflQo6EkScziBGh8eLVjS5ALEd4ezZiKx0xeRBNf2p3ad3LLrVuE
 CsYUR9/lQOqmeYwTcvY8p9RoohwhPxMddrghjLXGV2OGI2QSwd7SWkqklbiNPFZiC7i3
 8xC1my9WWwlRkL0Qm/StuucP7qoJEYPmlGfImvyfnu/GdsTRVxiMD2OwDbBTLseYAPQH
 nAFKmIElPF1LlWzbScWeItSVZW1EnOUI95OGt++7m4XTd4JROa1VYS71329xTdNXPBTy
 1IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977411; x=1778582211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UXBDY8yrjs3dkgDO4K02KeOZmUzFqyOiL74/iE0JSc=;
 b=lwuUw1cA3WcKetKWD9zg80gq9c8i20Uo9QOShmPpD/+vBdgFoPTyOhyoU4t+CfYEU3
 Y43/gq9iepIaNBAZtwPsHsZEQZx1jJHVAipZPhSpNc5gvmdZlFw/JaKcB7y1/EqVUtyM
 y42kcfQOMLX/Jrk6hUCi52xQ6VaEt0AQrtq2MyOPWul6hFYX0lxD0pEFyd+/VY1Qq9mu
 OM38O4XFrBL/FcVEp9azswZWkqtb2ZYkrnv7irlxUcd8h2sve3+mIYYF7dcs9IErImuR
 O4dLeT+5DsmHBm7eMqMAQ9e1BIbfBlhW/CT0bRmtKXezuUNQJV0nXXWa1ecwB1QceQPB
 Jw/w==
X-Gm-Message-State: AOJu0YwmbksCVVmX9nqtFhBAcQ/SZ4Rb+eNnoq5uCYlR3YdX+0koIg8I
 DCgEmtMku9gUUC9RoWjZ5p4+67mAwtapOEw2o9BjXwOImK+dboD+FdosW6gBMKn/0ZM=
X-Gm-Gg: AeBDieu06A+mfXV/jDNTOdfV9J0ILRSxPymgCxWYwu+9Ifipx7Xe4q4We0Bcj6p/2AV
 /tgwqNSeTAszqv7+OICRSvF7pFcfP9hLDtn2AqGQPgjtUKvSskOTK5OKTdk+IIF/EKHVUMN18cB
 nwzgZyF4uTJJnR9ZH/TFuDx9QkZmWEd3ns4Gp/1kPEJGQvhN3kC9DFH51hYHxcsof5snWFTF6WZ
 vVRvDrxmIg0/GLTw1SkhVpdBAHPTlUWiraFr5Hj53GZMTkZqKKdUXq4psYE9Q33h2Cs9vVbDCku
 VOWQlxs1t9iqJlJQo0+S9+oqlf4Cx5+6gv2KZXlAOTsr+okBDsf6TtZRQKlYYJyYNbZHhlkHwHS
 7NzyDQWl9diU3mNSf1v4gDIXDD0HMr/zwkSzUDx/MwxvZv1Zejd7mwpQHdmAglDv2KH98uVOYmu
 mcxFwU+1tX5zE+HRHmefZKP9PuRAlzRjT5rmA8mI0DJJB5
X-Received: by 2002:a05:600c:4f48:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48a988ccc94mr246836815e9.27.1777977411509; 
 Tue, 05 May 2026 03:36:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba865fsm307426235e9.10.2026.05.05.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:36:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0B715F8E7;
 Tue, 05 May 2026 11:36:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] testing/next: macos updates
Date: Tue,  5 May 2026 11:36:44 +0100
Message-ID: <20260505103649.68361-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

These patches are mostly dealing with the loss of the CirrusCI MacOS
images by porting to gitlab. So far only one of the images works but I
thought it was worth posting in case anyone else has any ideas.

There is also a fix for getting watchpoints working so we can have the
basic TCG gdb tests.

Alex.

Alex Bennée (5):
  configure: report unsigned qemu binaries for check-tcg
  accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
  ci: drop cirrus MacOS build
  gitlab: add initial MacOS 15 on gitlab runner
  gitlab: add MacOS 26 job on gitlab runner (!broken)

 configure                               |  6 ++-
 accel/tcg/tb-maint.c                    |  5 +-
 .gitlab-ci.d/cirrus.yml                 | 14 ------
 .gitlab-ci.d/{cirrus => }/macos-14.vars |  0
 .gitlab-ci.d/macos.yml                  | 65 +++++++++++++++++++++++++
 .gitlab-ci.d/qemu-project.yml           |  1 +
 tests/lcitool/refresh                   | 12 ++++-
 7 files changed, 85 insertions(+), 18 deletions(-)
 rename .gitlab-ci.d/{cirrus => }/macos-14.vars (100%)
 create mode 100644 .gitlab-ci.d/macos.yml

-- 
2.47.3


