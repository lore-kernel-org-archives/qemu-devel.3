Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA9E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Kx-000651-Bv; Sun, 12 Jan 2025 17:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kt-0005oS-VV
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kr-0006vU-5p
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:34 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1885574f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720491; x=1737325291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIJbA99zO6H6feDMStmcLuf9WLOoJAXMvP2ITp16sic=;
 b=ZkPnTU6XdWl/EA5RYiqZWadJTNyEA4qJw/5eD6KRsX2o/o9IS7KtTsh+G7hXo2I02N
 t1rwfr9hPTJF0oPi9RKsJzGhvnsCOj5PwFBgkoaBtleb9MrAmGDNOyvF/fFvV5Fy1OIc
 OAhG9kviuGIGhoEOw1Tnd0couaoXS905sPsls5QTFx8tNAHaM5kf20W7/hDe3RfQEId0
 VjHqPVpMi/40OCxnlt3ay0I2b7HFt+D5DnHfgqCHvVnI0L1qtB684RogC9ZSb8wjd4U0
 IxdDcnLkNp7XWnjaAvT+T1vkdXNpCXr5BCHF6NqHp4FOuuFtaoaYerxXA44wD+JtHRdG
 TkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720491; x=1737325291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIJbA99zO6H6feDMStmcLuf9WLOoJAXMvP2ITp16sic=;
 b=aZj6sFoKInuIzd8+pV8CqeMMcrFdGEP/srLjAANG3OHo8PKh7U9nbcCQ8I188u/m1E
 BrX/NOwCng2sZf8UrwW+s60Dqm6hBSPNUpTYP1aY3MDtWx5uZyGScZHOqa2FG9AqwMR1
 JhvRsoJaz1JZl4F88m8hN10KFgT+8+m/BGMPa56xlBiuPsmwesyU5TDH2aDOoRRby7ps
 AFp4HznqfqWYIcsYn9siO3Jm8PvXTdIdP1WMysfJgB4+cFygUlWDcKghOXa4y022VSx/
 5+hpIyrJI4aHQjtbVxNxGg0mBCTALJNUjb9vkmK6f1rdhblJLokOF7qsN8i7O6idQMxy
 9Lgw==
X-Gm-Message-State: AOJu0YwZUVO69Swsf9Jjudxi2DemSIIuTeoOBClqxsxnbe4S2prF7bTD
 6KWVT9X3dtBcvJ6GKMe4OsSlNFzuuI/piZiPo+66i1mt+TEvXTk//Hwa/wWlmFg9frvD2Pd3FTT
 Z0zM=
X-Gm-Gg: ASbGncsWFkpF9DnK0VVNhYtEfuTfgfyf2ln+ShTowcU3urMKtUh8sJNiUARKVDoG3mI
 KdEdzLQPw/Ui7NSKgrev+tpfyY3Wd1KLU0WpDri1Hh7CesTnjYaBOvPwVEXZp/g8R17MiQ9th79
 2c6CLB/ffNQFbsU+XMyvCtAZzSv3BxIVeOnZR78MFswElFQjLrzgJnCTqsCBY1ksoM/5NsNdlSh
 zJw7ajKOCTpzFJwMEzFKPuLgIjHH3iV4cBm1JfOkbPJg0YfLavKdu1yeRy+P1HihfB0CwYGWmQb
 VLnS7enrYnwCz/Ww4ihwM6JykDId7rI=
X-Google-Smtp-Source: AGHT+IFC7DtWGUW9zIEP+TfAbMC2zNpNdKQd/4idgtFr0bZkEeM+V+adtokguO9gB9+pQe6lIWYknQ==
X-Received: by 2002:a05:6000:4612:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38a872cb1e1mr15568909f8f.2.1736720491441; 
 Sun, 12 Jan 2025 14:21:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c990sm10655419f8f.56.2025.01.12.14.21.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Signed-off-by=3A=20Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PULL 49/49] Add a b4 configuration file
Date: Sun, 12 Jan 2025 23:17:25 +0100
Message-ID: <20250112221726.30206-50-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

b4 [1] is a convenient tool to manage patch series with mailing list
working flow.

Add a project default config file to match QEMU's mailing list conventions
as well as adopting differences on scripting.

Examples of b4:

    ```
    $ b4 prep --check
    Checking patches using:
      scripts/checkpatch.pl -q --terse --no-summary --mailback -

    ---
    Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
    ---
    Changes in v2:
    - Add lore masks (philmd) from:
      https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@linaro.org/
    - Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb30a4@flygoat.com
    ---
    ● cc5a4c890fed: Add a b4 configuration file
      ● checkpatch.pl: 27: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    ---
    Success: 0, Warning: 1, Error: 0
    ```

    ```
    $ b4 prep -c
    Will collect To: addresses using echo
    Will collect Cc: addresses using get_maintainer.pl
    Collecting To/Cc addresses
        + To: qemu-devel@nongnu.org
    ---
    You can trim/expand this list with: b4 prep --edit-cover
    Invoking git-filter-repo to update the cover letter.
    New history written in 0.02 seconds...
    Completely finished after 0.06 seconds
    ```

[1]: https://b4.docs.kernel.org/

Co-developed-by: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS |  6 ++++++
 .b4-config  | 14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 .b4-config

diff --git a/MAINTAINERS b/MAINTAINERS
index ec898a3cbc6..0c71eb3f925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4310,3 +4310,9 @@ Machine development tool
 M: Maksim Davydov <davydov-max@yandex-team.ru>
 S: Supported
 F: scripts/compare-machine-types.py
+
+b4 tool configuration
+M: Jiaxun Yang <jiaxun.yang@flygoat.com>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
+S: Odd Fixes
+F: .b4-config
diff --git a/.b4-config b/.b4-config
new file mode 100644
index 00000000000..4b9b2fe290f
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,14 @@
+#
+# Common b4 settings that can be used to send patches to QEMU upstream.
+# https://b4.docs.kernel.org/
+#
+
+[b4]
+    send-series-to = qemu-devel@nongnu.org
+    send-auto-to-cmd = echo
+    send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
+    am-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
+    linkmask = https://lore.kernel.org/qemu-devel/%s
+    linktrailermask = Message-ID: <%s>
-- 
2.47.1


