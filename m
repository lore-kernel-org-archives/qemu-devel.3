Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82DCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEv-00031t-8J; Fri, 29 May 2026 06:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEr-00030H-U3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEp-00017O-Nl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so4077325e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049686; x=1780654486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phEUg5x0DXLsPnOC2onnRCPG/V+wsa5zkHJVzaJL+9g=;
 b=sg4PRRq8t94Snh8WW1nR5ludTgrhmv8Tn5fU0kDfBw5QcKmRObhGDT5ivHT4rTDtMs
 T8F6zr4JPe4y8gYl/qSTB8KCtWYO1VfBhSZuoFhUBzMiNd88RwwuLbwvSmNtz34M8daZ
 OBTh+pW9la29PUsEvVIde1DOowN+ADKCD2bvbZdU32xhqwu9Ch4H7mGlyuXigv5MXoZD
 sMl7bC7yHjJ8RZuAHZD0n+HLDTnk8+IoaIhMqdn4z3Xzt0SPg5Q/pSZdCYEkAZE5bXmq
 kTsY8kZP+6GAalktdxlyMGSVvkMeeX+L3qHGmNa4TygbO5++7z/lCVUlNmokyZef3RmK
 eDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049686; x=1780654486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=phEUg5x0DXLsPnOC2onnRCPG/V+wsa5zkHJVzaJL+9g=;
 b=KrH+Ej5M3ew1MgJLPj1m3f1YB3nwshOWkml99VxCvd5iJK9Dh4oYmC9zEL/iitGavm
 b+3dHMPDlLcITwG+zDwrB4WLEEkCpiurDhoOW/IscPKgXizDfaPocz1RuFR0PdAP3nGo
 DKUbVRDQOCdDveCSGu88SiSxPW3glsySrM4+eKO9/hijRMUN5VQm6mXSZOsLHddrpULJ
 4x9SN0qa2+JmimvMAjKW3UlOC8WPMZ5BuNrHjLeG7KVnWdpgqa41lw0MRuQivuPkk7oP
 et8G0Wx09s27Rc15CMUaXCVDB+eyLwU6mW8bq2HE4tBCKWyujgebE5jvX1S4LmDGak8R
 uf6A==
X-Gm-Message-State: AOJu0YwIK+B2y5qow5vWUrcZurIfGbA5Z/YRYauPICmpaCyTJqr6/9SA
 erBYJ4b9WPFJ27/5QG3l4cFevM4eM6A/a9S2auJ69oUYu1SMzlTC2eFAGt6mIv0S46w=
X-Gm-Gg: Acq92OGw1tpIPrO3PKWMnxUavfDRMmF6frZUBEWOpUu/BXjU0GK/UBw0M9p80snTlHZ
 w1X8PUdR1Tle1/rQt/RG9HE8OhhIKkQSx41HuKpdfEm/e+LfAEEhzdV5nbJJZRSlG8JSlmlnBhW
 HPEkeXS8x51CXLAJo8st24/WSni/QXvMToKli+mE3EK4btvkafsbqDZYQ0gLaYR3Mn7m+NKBHYg
 +IKqDS4j2mb+oRzNTQ+vjHj4sIEvoxQp/SN4aRqioszfgA0g3jaeNxW8DQjOZnt4iwd3/bXi2K5
 wRd7FzAOxnwhcuQm4kEfHoRG+VnF/n2Zn+GZpuItgSb+RA8glrgeofoN8qeqrgP45eTu9zcdGEJ
 ZbyvnWnvL2+ld6C3tJpV2jRcKljCZQ5a8A5eDCSriVdnQURTDwR/U80LNu/gytPvOOSjDIkSsSM
 QbLRLGc5V0dw/0uXPXjrBrDx80Pq1scQgLwQ==
X-Received: by 2002:a05:600c:b50:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-4909c089064mr27157125e9.10.1780049685781; 
 Fri, 29 May 2026 03:14:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6eb3adsm29053365e9.11.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 90B9360E87;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 09/12] .agents/skills: add qemu-mail-thread skill (caveman)
Date: Fri, 29 May 2026 11:14:34 +0100
Message-ID: <20260529101437.410181-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Teach agents how to fetch and deal with archives of mail threads.

Just YOLO'ing the entire mail thread into an LLM context is quite
expensive especially if reviewing a thread against your current tree
state. This skill allows the agent to extract just the comments and
tags saving tokens.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - add header.
v2
  - rename to qemu-mail-thread
  - add instructions on fetching threads via b4
  - refactor the metadata handling in the script
  - mention in AGENTS skill list
---
 .agents/skills/qemu-mail-thread/SKILL.md      | 37 +++++++
 .../scripts/qemu_mail_parser.py               | 98 +++++++++++++++++++
 AGENTS.md                                     |  1 +
 3 files changed, 136 insertions(+)
 create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
 create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py

diff --git a/.agents/skills/qemu-mail-thread/SKILL.md b/.agents/skills/qemu-mail-thread/SKILL.md
new file mode 100644
index 00000000000..6e76829e36f
--- /dev/null
+++ b/.agents/skills/qemu-mail-thread/SKILL.md
@@ -0,0 +1,37 @@
+---
+name: qemu-mail-thread
+description: Fetch and extract reviewer comments from QEMU mailing list threads. Handles mbox files or raw text dumps.
+license: GPL-2.0-or-later
+---
+
+# QEMU Mail Thread
+
+Fetch and extract reviewer comments from QEMU mailing list threads (mbox files or raw text).
+
+## Fetch Mail Thread
+
+If Message-ID exists, use `b4` to fetch thread:
+
+```bash
+b4 mbox <message-id>
+```
+Saves `.mbx` file.
+
+## Parse Comments
+
+Run script to extract feedback, filtering out quotes and diffs.
+
+```bash
+python .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py <path_to_mail_thread_file>
+```
+Detects standard mbox or raw text dump automatically.
+
+## Output Format
+Generates `parsed_comments.txt` in current dir:
+```
+--- REPLY FROM Reviewer Name <email@example.com> ---
+Subject: Re: [PATCH 01/10] ...
+Comment text here...
+============================================================
+```
+Use output to analyze feedback and outstanding suggestions.
diff --git a/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
new file mode 100644
index 00000000000..fdaac57ac15
--- /dev/null
+++ b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+import sys
+import os
+import mailbox
+
+
+def is_metadata_line(line):
+    """Check if a line is metadata (quotes, diff, etc.)"""
+    return (line.startswith(">") or
+            line.startswith("---") or
+            line.startswith("diff "))
+
+
+def parse_raw_text(text, output_f):
+    # Split by the separator used in lore.kernel.org / b4 dumps
+    messages = text.split("----------------------------------------")
+    for msg in messages:
+        if not msg.strip(): continue
+
+        lines = msg.strip().split('\n')
+        author = ""
+        subject = ""
+        body_start = 0
+        for i, line in enumerate(lines):
+            if line.startswith("From: "): author = line[6:]
+            if line.startswith("Subject: "): subject = line[9:]
+            if not line.strip() and body_start == 0:
+                body_start = i + 1
+                break
+
+        is_reply = subject and ("Re: " in subject or subject.startswith("Re:"))
+
+        if is_reply and author != "" and not author.startswith("qemu-devel"):
+            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
+
+            for line in lines[body_start:]:
+                if not is_metadata_line(line):
+                    output_f.write(line + "\n")
+            output_f.write("="*60 + "\n\n")
+
+
+def parse_mbox(mbox_path, output_f):
+    mbox = mailbox.mbox(mbox_path)
+    for message in mbox:
+        subject = message['subject']
+        if subject and 'Re: ' in subject:
+            author = message['from']
+            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
+
+            payload = message.get_payload()
+            body = ""
+            if isinstance(payload, list):
+                # Handle multipart
+                for part in payload:
+                    if part.get_content_type() == 'text/plain':
+                        body = part.get_payload(decode=True).decode('utf-8', errors='ignore')
+                        break
+            else:
+                body = message.get_payload(decode=True).decode('utf-8', errors='ignore')
+
+            # Simple heuristic to extract comments
+            for line in body.split('\n'):
+                if line.strip() and not is_metadata_line(line.strip()):
+                    output_f.write(line + "\n")
+            output_f.write("="*60 + "\n\n")
+
+
+def main():
+    if len(sys.argv) < 2:
+        print("Usage: python qemu_mail_parser.py <mail_thread_file>")
+        sys.exit(1)
+
+    input_file = sys.argv[1]
+    output_file = "parsed_comments.txt"
+
+    if not os.path.exists(input_file):
+        print(f"Error: File not found - {input_file}")
+        sys.exit(1)
+
+    with open(output_file, "w", encoding="utf-8") as out_f:
+        # Detect if it's an mbox or raw text
+        with open(input_file, 'rb') as f:
+            header = f.read(15)
+            is_mbox = header.startswith(b'From mboxrd@z ')
+
+        if is_mbox:
+            print(f"Parsing {input_file} as mbox...")
+            parse_mbox(input_file, out_f)
+        else:
+            print(f"Parsing {input_file} as raw text dump...")
+            with open(input_file, "r", encoding="utf-8", errors='ignore') as f:
+                text = f.read()
+            parse_raw_text(text, out_f)
+
+    print(f"Done. Extracted comments saved to {output_file}")
+
+if __name__ == "__main__":
+    main()
diff --git a/AGENTS.md b/AGENTS.md
index 9fb9515871f..9e373c98573 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -50,6 +50,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
+- `qemu-mail-thread`: For analyzing and parsing mailing list threads.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


