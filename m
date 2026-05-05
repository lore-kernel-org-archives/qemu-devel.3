Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877FCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJab-0001vc-3a; Tue, 05 May 2026 13:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJaZ-0001vE-BK
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJaX-0002TK-Q5
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso45019195e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778002179; x=1778606979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hoSOi7ycLlP/xlUg9Cx6ztjnzMetX3ekEZi2wmcfu2Q=;
 b=JMvxGLWRITmH1//v8aiIO0fYsu84IlMt5Ihje4F5AVn+wNjztoDhleP4AjF/fLTF+Z
 rK860zeayHzdlQLb3Jg4HdCU4jAufmf8S4SNth305evCxMNO9aa3MTUzl/5JGgjHH8tj
 NCdELCUVLROLOSsywUtzNeM7YuczQbfpArppVIAH9PmnL0yRwD1RlLWRXUuWlHp8JsIR
 X+omtoNcn3j+flT6RLOaXB67xGw+0NsIb+BwcYi3C9scd+QaGR9c7e1RYpPpV75x/04+
 fE9G0AXzD5B33u7Jb5eIWrIVJGg33Wbeo34tDDlvqYtyjZcyScuYemNL0yT++Ob/Ti8l
 vMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778002179; x=1778606979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoSOi7ycLlP/xlUg9Cx6ztjnzMetX3ekEZi2wmcfu2Q=;
 b=AWJQtp4WWdoMZNxcClYD1Edf3bEeefz8c3mEbGAigE9r34WYKuYd0DA+RkHyAL3Wdf
 Tv0W2dTZ7kznZFC5fjJHOBncbdCjbo7f54EI0I6jVFN+HzVBPSUDxYjQu1+vKDvVVUUA
 R11Yr1pevEyeSdBS4ncl1F/qP47JTQYwYsuw6zFqZTHqXNG2/OOhniq4kbDc1BRt/ug5
 Z0sa2nscgcg2+MnGs3mdnLvjn9JoppNaWoIUwK9BhWnV2DHco+654omRDtG8oJ7X/K/k
 9UUR/tPL53myQZJhhTRP9IR+tMo15gig4fEiEANXdA9Tk711Xdo5kji5RVfji1Sqffi4
 qUwg==
X-Gm-Message-State: AOJu0Yz5EjjjGIPlBwP4lmsqBInpeH7gVuty2WUwL3vyjqA2b6FtOsJF
 x/ojz0/Ny+oqcGyMjJ7xQ3myAV7ce7evDpQDFmZrKMP3Pny647Mew1fU0WwkPw==
X-Gm-Gg: AeBDieucUZIzn6jwpsn7C4lBJdkJpBrND1ccBBHsGSgXgURyWkw3WXU2vh27TtHcjbe
 ymS3ysDrr7F80CZk3mhJ0Y0Vpk2eszD8c8Hm9CrO6DJ4e90xixpHIa12TqX+nj1uVrReFnB6BTw
 4BIR7n9IXEprMeSxQkkdtYOle0vvEJmzXfrg5Da8o9QZVMLLJAZrRy8RbdZF9rnEk0LIEBp3avy
 CdzpVs3uIYw+whRzBBMn2aUQDx5YLEno11u0ht9jCAPFufvuaS4pWm/oCvZw6u6zWEivbIVx2lG
 z17vFBX0PUyAGmbctmim75Og7B4IVXhLOZURt5vAsmOYruoWyHq6qhdQqlERuY/RqLPu6rA0ZuB
 8IrXjwsA1BbpB6ldzbZUR2kgRKbC/T08fSDiai6JzV5KTM6RPWR6FKlx7ehdvY0JXzur1+kDP7z
 qX0nqQp15YaJMZXawFiASRk021hTGQDeQ0MtJ863TvXuRpjoAxdQu0ehwVy0aR7h+vo81RwE2Eh
 6tPj8KEHfdIrXCt
X-Received: by 2002:a05:600c:c4a7:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-48e51e22043mr3705325e9.11.1778002178805; 
 Tue, 05 May 2026 10:29:38 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e51f766f4sm703785e9.3.2026.05.05.10.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:29:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, stefanha@redhat.com,
 Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/2] OpenRISC board maintainer updates for 2026-05-05
Date: Tue,  5 May 2026 18:29:24 +0100
Message-ID: <20260505172926.2235826-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello,

Please consider for pull,

Note: I haven't done a PR for a while, please let me know if there are any
issues.

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-maint-20260505

for you to fetch changes up to 7d20f4ff1d0550ebcd918993ecf04733a353246b:

  MAINTAINERS: Add myself as the OpenRISC virt maintainer (2026-05-05 17:56:18 +0100)

----------------------------------------------------------------
OpenRISC board maintainer updates for 2026-05-05

----------------------------------------------------------------
Stafford Horne (2):
      MAINTAINERS: Add myself as maintainer for or1k-sim
      MAINTAINERS: Add myself as the OpenRISC virt maintainer

 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


