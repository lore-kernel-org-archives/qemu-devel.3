Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E15E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOT2J-0001w8-F7; Thu, 19 Dec 2024 21:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2I-0001vI-Kz; Thu, 19 Dec 2024 21:46:42 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2G-0000Is-Sj; Thu, 19 Dec 2024 21:46:42 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso1298444b3a.1; 
 Thu, 19 Dec 2024 18:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734662798; x=1735267598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX6+uBltyHiZ0BPxDZL7s7smm+LPm95s74gnZrKNeBI=;
 b=CzKEBwQqjWI8dPW0XKqFpl2osLNYeIGXj73LGSe/aJobd6h4aBz2D4VpIl3lTv4TM0
 +9qBWbpH0urevD2uJlW1R7Qtk5MxVvgPti4N/2qGDOo6w3zX//zmD/xWxCv57ewb/sv/
 lneIL9aRoEgdWSRd3mkz57JNe0ByVUUKH2VC2enH2xlNUW1mPMOQ9PEyE4mTuUDShZ0L
 OrCTkUh8dy3z/tBpUBomgtB8F4CFOW1cg8DxMzivOhb+mN2EbcTClXtooL5RlJhAaPS0
 39x6PNSvW2tfPfyV7tNh6z+xDpJdA5qsZCsk0E+ExVy9bJvSerPmBnYEARK+A1RaXL8k
 mAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734662798; x=1735267598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vX6+uBltyHiZ0BPxDZL7s7smm+LPm95s74gnZrKNeBI=;
 b=ggDkUlXxv+e/s9+pvzKHMqPBv4mHHLYRVbegViZf//QZQqEm2AMgT3XdEemQuQKm82
 AflnR2Jj3AH1zmaYiUKov3aft9jTyrNslaUuwPhZB9LohrAJYSHgrkDUsnAQjUjHHU8C
 wFHDJZ/sbvyvoLI0kxH61B0u+fDiXHHmX9pZxoGcRbDaT58l/bVzs6gYU83xCOVbpvGz
 4dzkkMygcvfU50JJ4uJ0/ddPSf7Xe+qWYzXVLqADzcbnDX1+Wzk4JbhqHWxu+Sb6p4RJ
 Gu8pota10zZQPfFBDekzBcRo4TXceKVonhAj3OegY/Q//l1jwJoDZVmVtOufnyEDPbv+
 1jRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcJYRbT7Pe3f5MUjCY34iOadNBTyCBFQpIASzFNRkINVbtComs+b0pY5bgZUut61AnPUxR5D6ZBQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzm5oFabeUH2hHQT9gcGBziI3ZwZsaCnGdPyEGVTqDBm8Sl1/uM
 tzuWAFb29QH75OkCIxZik9EYQHoKDRxk/FuSwPYF5tfCCxG5McRfGKymNw==
X-Gm-Gg: ASbGncs+BN8FFkn5eTIC8CQLCQuQjbErLq3alVxcRW6gqeWY1I1Siq+NE3+4skx9MPI
 RXcf0JrxlWRJPF9WMq/75gpRktZkX2lWX09ukxQendBPz6ZG+f7Vz1ag9VNRi6JfBBfNESuuyDS
 JmOOxZ1OSptzIG52CB9mPqdCjrL1FO/NSCJidQZt8NucWb+FabPGli9ZE5B+zkyRfXbK60rvthq
 WCYr34zvY6JBpezA5A7dpBz3ljDS19tyZJTLpwIoutFjNThTxcH1USCm9Gn5mjLblgCnY0rYpke
 cU/iAATlQg==
X-Google-Smtp-Source: AGHT+IF+WLq2t4DBQAqYqIzF12tvo6xGOmDessvLOJwgk0RcZ9U0Gjph46uUoQyvnDLbe3MmKloHpg==
X-Received: by 2002:a05:6a21:1505:b0:1e0:9cc2:84b1 with SMTP id
 adf61e73a8af0-1e5e0800447mr2488509637.30.1734662798509; 
 Thu, 19 Dec 2024 18:46:38 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba99sm2037830b3a.92.2024.12.19.18.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 18:46:38 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 3/4] tests/functional/test_ppc64_hv: Update repo management
Date: Fri, 20 Dec 2024 12:46:16 +1000
Message-ID: <20241220024617.1968556-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220024617.1968556-1-npiggin@gmail.com>
References: <20241220024617.1968556-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

`setup-apkrepos` can be used to set repos rather than open-coding URLs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/test_ppc64_hv.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index afc8b9a3106..62e1a0f3a2d 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -110,6 +110,10 @@ def do_start_alpine(self):
         exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
+        exec_command_and_wait_for_pattern(self, 'setup-apkrepos -c1', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
+        # Could upgrade here but it usually should not be necessary
+        # exec_command_and_wait_for_pattern(self, 'apk upgrade --available', ps1)
 
     def do_stop_alpine(self):
         exec_command(self, 'echo "TEST ME"')
@@ -120,9 +124,6 @@ def do_stop_alpine(self):
 
     def do_setup_kvm(self):
         ps1='alpine:~#'
-        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories', ps1)
-        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories', ps1)
-        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
         exec_command_and_wait_for_pattern(self, 'apk add qemu-system-ppc64', ps1)
         exec_command_and_wait_for_pattern(self, 'modprobe kvm-hv', ps1)
 
-- 
2.45.2


