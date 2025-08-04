Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D4C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivXG-00050E-Bn; Mon, 04 Aug 2025 09:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengnici@gmail.com>)
 id 1uipuM-0005B8-6a
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:46:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhengnici@gmail.com>)
 id 1uipuH-0006w3-Ci
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:46:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-240763b322fso36655845ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754293610; x=1754898410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8ETRsH2VJrmaVIIPCd6kg0gglEIjtgLpalOzB+/ZMHs=;
 b=Le602lBUZCTUNt/UzuhjxeN26HdYsn/v4Kzb9Qd3B2RT6MNatUawcTGloIkCimqRr8
 eahEOyl7AX6XqCpArlCqUhD2kCWoZ8EooXt7WTe957gymI1IzH9MVqZ7onvpOZ2PqXLo
 nDCG/gNglJiFDuHVtdm0R3xOK3TXPOq9AEk4dajr2nrjxOXYwVRatTsBH7uXqUEkub2J
 /OnRZY9ppDc7548YM80p4GOTVcpw02M1Ohd0eK+0/yxU/4nmZXUSP9RKZqeEN/1AXp4b
 O25ddgRtx9cVD56AeDeLeXNtdZS3Dg9Yqey0a8GFk9KqzOXMPLBvrv0C+uo3UhTmdGlX
 gLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754293610; x=1754898410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ETRsH2VJrmaVIIPCd6kg0gglEIjtgLpalOzB+/ZMHs=;
 b=P3Er4Vws0+sszdTh7N926NN0h4o854WJgGRJm76YCCf/OtQm/dN/3sqKAzbb4HVh9G
 P+TqQx6gqkP8J0xndCdPxyYCZdD1Qxmdm5lo2L+Y+ISP7QO/QmN+XlukZGCc8skZ6JSN
 +INeMt7p2o7QPE/JVpX3aUNM70U0CPohSFxS4yEKHFoh9kIkYyZD7pdOfXrtxFHg6jEU
 zy58EDNVjSD7xbSt8PPejV6Lf/zA+wYUxmLHXs8zWRQObAQmXL7nclou7nyPVZ1+S9YH
 nIvrm4a7uG0bcBYa9CWibXvoaCXToIzdXV81gknIrJx5EEINwaAyIN0jfPou2dOxQxEP
 sPBw==
X-Gm-Message-State: AOJu0Yw78CHaDppMBJwlj1m+cpkiUW3EIKvp+szi5ERXujkxqid7jR8J
 fvchANzd8q45eQb1VnOLiOMAxDKs3oEY4FMqBkbUQ76RJw2JD/5I8Sj7hYWHEPBg4b0=
X-Gm-Gg: ASbGnctGhx4vBcKjYnhEa9e7C9PfJoH36THv/BXvvm5FQw5kC8jIBYOr2zawla0dTZG
 riTrF4VmkaU4KU/yJBItBG8ii57oad0oDHcgvmDHF68anplP/hztpisrSoMhQDJ39mdjnu5GzsG
 +o5Vn+g+qwhQkxba6FW7Rwi+r6w8pPFn5O+pY5lE8V/XoJtK8QxO1Fri9j9s/5ARXI4ahpM2Dn8
 e0UiKj4SeG32Z3biZOWIoYS+NOCM47TxuZKiMa6DVq4qI+O/nuGH+YT7vRz8wdKdPr2qYcY+P7F
 v6pGlHIN+bVPRvx3raO7gmhAWxWLMcoui8ijdOVFj3kZQnKcbnepU3o4sowSB4IY65yEamQuzIO
 /91yMXL3NzifbBLY58pFMaksUimIzm8a6
X-Google-Smtp-Source: AGHT+IHW18zdbcCeVJNqYeNqxfwrLn+tnaIhXa9rJ1Jk3yS+/nOABLzKkMPkq6YGiTvy/Gn1j3qaDg==
X-Received: by 2002:a17:903:230c:b0:23f:df55:cf7b with SMTP id
 d9443c01a7336-24246f1fc36mr141885635ad.4.1754293610023; 
 Mon, 04 Aug 2025 00:46:50 -0700 (PDT)
Received: from localhost.localdomain ([129.226.77.50])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef5fbdsm101871805ad.27.2025.08.04.00.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 00:46:49 -0700 (PDT)
From: zhengnici@gmail.com
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com,
 panzerzheng <panzerzheng@tencent.com>
Subject: [PATCH] qga: Fix error handling in system suspend mode causing
 libvirt to hold lock indefinitely
Date: Mon,  4 Aug 2025 15:46:41 +0800
Message-ID: <20250804074641.6021-1-zhengnici@gmail.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhengnici@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Aug 2025 09:13:39 -0400
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

From: panzerzheng <panzerzheng@tencent.com>

When "/sys/power/state" does not contain "disk", the operating system
does not support hibernation. Executing "sudo systemctl hibernate" will
return an exit code of 1 with the stderr output: "Call to Hibernate failed:
Sleep verb 'hibernate' is not configured or configuration is not supported by kernel".

This patch adds handling for exit code 1 in the systemd_suspend function,
setting appropriate error messages when the kernel does not support standby.
It also adds local_err handling in the guest_suspend function to set
mode_supported to false.

Without these fixes, libvirt would hold the lock indefinitely.

Signed-off-by: panzerzheng <panzerzheng@tencent.com>
---
 qga/commands-linux.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9e8a934b9a..26229396c3 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1300,6 +1300,12 @@ static void systemd_suspend(SuspendMode mode, Error **errp)
         return;
     }
 
+    if ((status == 1) && !local_err) {
+        error_setg(errp, "'systemctl %s' not suspend",
+                   systemctl_args[mode]);
+        return;
+    }
+
     if (local_err) {
         error_propagate(errp, local_err);
     } else {
@@ -1428,6 +1434,8 @@ static void guest_suspend(SuspendMode mode, Error **errp)
 
         if (!local_err) {
             return;
+        } else {
+            mode_supported = false;
         }
     }
 
-- 
2.43.7


