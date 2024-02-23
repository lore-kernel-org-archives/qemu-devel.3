Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B7C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxq-00068Z-JB; Fri, 23 Feb 2024 10:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhi-0004nP-Nz; Fri, 23 Feb 2024 10:43:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhd-00064z-Vm; Fri, 23 Feb 2024 10:43:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc75972f25so2907325ad.1; 
 Fri, 23 Feb 2024 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702988; x=1709307788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZINW/4P9SwnnIKpdjz8GObx2nHGX756vAFyLFtYVyw=;
 b=CYYouh54PmN9MRcZzJuaCQgscCzPN1mQ7w6TK+qbdRdE4Jgqy6DK2pCqHmSzxDSQkp
 /TJjA5pRd3K6Oyqf8T7Gbn7FEjQCaB/3HsGu4DYnQYLY8rj/wMA05vCcth+/HwXGoJ6o
 qU/0wHNmUG+xn92Owq+ECdsh0EpSHHyz/NkWQQvoLgfV5xbOLGA1MzMdjWOce5GQIJgY
 8CzLgAsYZs3LsUPOyzGfdamj3lzxKb3qasjJY3dfHbyHk+Ua9F82vv35pUQ37OX53Bwf
 gKEg/cuyFRlwsWfDEghuNH2cANRTwRyCMsldUD0LK+ER8Gh9i/9tlEsiGQijKUQWbn00
 YGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702988; x=1709307788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZINW/4P9SwnnIKpdjz8GObx2nHGX756vAFyLFtYVyw=;
 b=wQ30YLOJAuoO282HPuEJT/exhuhlxfNZ9M+ZSiiT/+mT2Qr7Lkf8sUBDE2J+JON9cS
 fsQpTRARTykzR0IquYEGA+07R/80lj1NOpiH4Scfvrkj1T8i7eQN1GpT7XcYoKnEg+Mp
 4irzYAHLzwWGN6+HjZCkMGF92Qq42m81lzCYy1vwwbatMBqeuEHt7vtyWUbN3sQCSI2w
 8k8j/oyAZbCejBB3R/XiqOzCD2GeFDOvoPcV+ZEQoICwCQK7uJtJ82kwb8InFYKQhuXJ
 vuO6q2bAC1gK6dIK3icTkRWKEmkU7/Xw4EFjLbzb5CM5PUjxuztwknOWzK2q8YwTEbp2
 wMnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe+WmkyXxAj3VpCggG/xfuh917PgWeBw/AOFX1fedkVPqXddXXmBBrtGclZHlV8q5B06eHXiHcnbH/kgdKKcAXmcTq
X-Gm-Message-State: AOJu0YxdtiRSnI3BaeqikryZ+lgP+YndTuZlcK5j8KA2g4Yamw6zzxTR
 KTgAREQyhjf2cjk2k3L7ODJlql9n7gWaZnmX7X5WgiYvXrDt6SesJXcOrcVP
X-Google-Smtp-Source: AGHT+IGVIPzLbs6Xaz2BWRww8t1tpSZBDldBjTugSttww54n2S7cstec4PbQENLOrg5mH5lyuJRR9A==
X-Received: by 2002:a17:902:c146:b0:1dc:5ae8:174c with SMTP id
 6-20020a170902c14600b001dc5ae8174cmr179747plj.17.1708702986642; 
 Fri, 23 Feb 2024 07:43:06 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 04/47] tests/avocado: improve flaky ppc/pnv
 boot_linux_console.py test
Date: Sat, 24 Feb 2024 01:41:23 +1000
Message-ID: <20240223154211.1001692-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The expected MTD partition detection output does not always appear on
the console, despite the test reaching the boot loader and the string
appearing in dmesg. Possibly due to an init script that quietens the
console output. Using an earlier log message improves reliability.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..af104fff1c 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1368,7 +1368,8 @@ def do_test_ppc64_powernv(self, proc):
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("zImage starting: loaded")
         self.wait_for_console_pattern("Run /init as init process")
-        self.wait_for_console_pattern("Creating 1 MTD partitions")
+        # Device detection output driven by udev probing is sometimes cut off
+        # from console output, suspect S14silence-console init script.
 
     def test_ppc_powernv8(self):
         """
-- 
2.42.0


