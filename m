Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2AFC369AE
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 18:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3fI0-0001lQ-3X; Sat, 12 Apr 2025 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arthur.sengileyev@gmail.com>)
 id 1u3fHk-0001fU-AB; Sat, 12 Apr 2025 14:08:57 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arthur.sengileyev@gmail.com>)
 id 1u3fHg-0005Ic-O5; Sat, 12 Apr 2025 14:08:55 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30effbfaf4aso28651331fa.3; 
 Sat, 12 Apr 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744481328; x=1745086128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eTeQINHtOJdpGFDL7OobHFAVylbSYWG/0glbsWwisUc=;
 b=H2Lb9VlD3+JCZ4UXKsb/Ygvoqh1BRozWVXuqVMbhHhEbXjq2lPK5FxMv79LDdViSBr
 VrIZXExFA0RghXzKtoaT/jzvJf1P8o6IUEZeqgeSFxczWvscK0k2vGe3SBFSdacz7d1S
 qQL46zLpQxd6/4tEW3KxW4kAA6wTcWrJMEj07fPbToxSF2gBRLs/dZ1VuEsNpU0i8crr
 NioD+4OdUc0g+9nqnwmrbdaMYVjbdmD9ps4MgwAa+YfH5OZJYZ90gKPuczbWonPg7ca5
 ZgUBtWorx9LqWtpXUsFg2qCwRo9Mx3oweDfWJAbo38GbNPXuHdd3gtrph3cby7cNB7pl
 6y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744481328; x=1745086128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTeQINHtOJdpGFDL7OobHFAVylbSYWG/0glbsWwisUc=;
 b=nBLlJTAf2MmH8P0lcGEFm2FLugifCnSZ+wdz5HU7tBOB2C5GiaS6oJzoqD6ymgz642
 CeWIiKmU9xfFdT7rJ2W0OWbXWZp3y7TsHs6QhJVcmVaHyj9hjjmQt5nV/0UfHbO7rZ7/
 DeS9OzNv41HPlXzesXinW99DAkcJTDVFECNSnW8ttIslPaHH+dQMCZIOJEhEBIaYLSiY
 f6G+Hc0ANtEGA5IvVfjcnUO0qh89jfJK8IiLhvheyMm2rqnsPe+xOXSCeAW5FwBXaC4L
 xyn/mjZMay1l5ALXDMHxV8grOwSnH8cYKBlckqna+a4XttfbcTMrPcliSNKYEhTXNYwO
 r3fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzmZSgxoIGb8iR5l8pE1fUNW99+/NhMg0Xy7ug8mp1oIyEAwTvHeVioN1vhO9VOLb69DHgZuwZIZjZm0I=@nongnu.org
X-Gm-Message-State: AOJu0Yw5Xaim71WaiBv0eOuA9MvvexeoB3RS34UjUo0THtMP8oRT/7wk
 37nEXZqrAsDEBC5Iqftb/n5IeBBFMnsHm5vQ3GrU7yApOgAptbYXGJKcOrDh
X-Gm-Gg: ASbGncvu9ITnJ4DvBddvsTsCNLfdqiTUEj/DbMjbfssFV/DM1eru9n15K7UnFslcy7k
 BkWQyEnA83uDR1EJni/9KhPesQu3aM4kSxfmweRB8YwzyUqxnhfymMstaDzrfZP1j7gwFvvnMnH
 2dibg+s7zQWKB40UvFTgac9GgXEzj+Ayyyj3X0NMjxj7wTAinN+KpwdYMfXT5xqtYWnZwMgkj9z
 w/r6ynQ/UbB53u+CK2iFu2hrXmeRNzZkss9e5oQD9VPvgCsbTvjcOWCQwwuViunDOK2I2qKRbpk
 v/jwOMtcfYULTGQNNuszsEeamGIp/fISRt5CeHXs4Kk1qgXLdJmuP5C+sw4FbCqVBgMJ0XEybA=
 =
X-Google-Smtp-Source: AGHT+IHnBfEfKpo8B0ayRb+8SxcLJnq/r7hEFW/I5CXlnm0X9v5aeOde9bQYMpzW44w05WSTMiAO3g==
X-Received: by 2002:a2e:9a12:0:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-31049a80161mr27003581fa.32.1744481328170; 
 Sat, 12 Apr 2025 11:08:48 -0700 (PDT)
Received: from glider-mk2.mshome.net ([87.246.149.32])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30f465f83ffsm11486471fa.101.2025.04.12.11.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 11:08:47 -0700 (PDT)
From: Arthur Sengileyev <arthur.sengileyev@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Arthur Sengileyev <arthur.sengileyev@gmail.com>
Subject: [PATCH] Fix objdump output parser in "nsis.py"
Date: Sat, 12 Apr 2025 21:08:30 +0300
Message-ID: <20250412180830.52742-1-arthur.sengileyev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=arthur.sengileyev@gmail.com; helo=mail-lj1-x234.google.com
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

In msys2 distribution objdump from gcc is using single tab character
prefix, but objdump from clang is using 4 white space characters instead.
The script will not identify any dll dependencies for a QEMU build
generated with clang. This in turn will fail the build, because there
will be no files inside dlldir and no setup file will be created.
Instead of checking for whitespace in prefix use lstrip to accommodate
for differences in outputs.

Signed-off-by: Arthur Sengileyev <arthur.sengileyev@gmail.com>
---
 scripts/nsis.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index af4e064819..8f469634eb 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -23,7 +23,7 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
     output = subprocess.check_output(["objdump", "-p", exe_or_dll], text=True)
     output = output.split("\n")
     for line in output:
-        if not line.startswith("\tDLL Name: "):
+        if not line.lstrip().startswith("DLL Name: "):
             continue
 
         dep = line.split("DLL Name: ")[1].strip()
-- 
2.43.0


