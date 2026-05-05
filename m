Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E4FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9E-0007zM-P3; Tue, 05 May 2026 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ98-0007xh-FV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0003UB-Pt
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so14312685e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000475; x=1778605275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yuj1wCqPfzb6QgRsDxN2Y1D9IqsqgMMhFjFqQNSMWYw=;
 b=NxQ7/bbxZ9G/cBApkR6GYZoy5n1Mz4VPBO1Wa/gkg/o3S0ciKO66XdRQKU6kpRNpSV
 7ZQ/mWM9/rbStDRRdNaziLEeGgziplRr+NWkLMmcsDI7JeCp8TupbZvJ7OLhKd51nRpY
 7gQnFbbiumEQICfXIKXBSBjQrGipSsJaKE/YWhhMy9/KJL0SXan2hQuY1ZALRc9Hp+bn
 JEd71Pv1iba0I1dpA5jhlPNFhm1n6AyJEzHiffYPBuGCDP158u+3GWeYFycWkCySoLjw
 LpCYJvsjBsuLv8Ve4Zvd6um7jWSBEv+INDHSsYgadxFkFbgqZ3xBsVChe4Bk+ixqiNpp
 Ht5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000475; x=1778605275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yuj1wCqPfzb6QgRsDxN2Y1D9IqsqgMMhFjFqQNSMWYw=;
 b=mr6VB4Ct5t0bGMEopEJT26eYhJ0IWg+y4YzFpyLClMJVq1JGswcCdC24f2sN5VsAKl
 +acFwrsNDvKWDlJrOPAiHUFWglCP0nvIFRbkE9iVqrc0flDWA43/MEDvDN3JcWISKGvU
 P5RF2Nqyu5jNeHLWZhFa874a6dohCuQBJhpHihYp4FujHgzeLhA5V9zMxz0wxhaOOoGj
 YS2aAM/bXYoFGJhYLC9waJvALS2ov2+HY63cS4o20CPFGu1QGtKHmL8HQUQs7oxqqu5N
 8zcH/JXrGkcUxY/Zj8KLA1ePASldp3MP4FOSK1w21noCrxFsQiAjxJtrUVOpuA+1KCpy
 UcBQ==
X-Gm-Message-State: AOJu0YzF7fBWwCq0Hz7lntPo/f5kDVftv9X2q7LGfPfZ7eHt6jQn52zD
 /vcHZ+nJ3tR4VMMRWP9zFql+MLsh1fBYVrq4guW3Jtb0wLh1wtc7Vl8+bIT6W4VCx2Hg69Q32tk
 bfRCGkvk=
X-Gm-Gg: AeBDiescGuLQewiuGbXFrALT5RE7NicgvDjyFWkDqj2X2/RmDlHyqZXWNYHKJZ8a36T
 MZiGL1NH8yxsm79Ei/FViML3TyuJQZqgppmKBArcuvaQT7HGOklP7L8LGgcQ+12sIpF3dSTaTYp
 Aa8/8DyN4p5ipzUZopXbfnp9EH8yvwKuPWZkVxB9gPydyoADHFnlEZm9E7L3plIcVTV+bDZ+7VI
 YiSoL6WKkEbgZeHzatx/MGC1/2Y78aKj0xLlPrCPe8wIy7YPkStG1VlFjWr9thmQcC4ULnbJAj/
 ofQ6wNorykUvYrg+/yF/DrYnG0gyFrAUPB7DoQ0gCKw9TB7rzmOERBrxSotBdzsgshY7OvH+p6e
 dOZ+gpXscX9EHyfyzF/3P1sJ/mHl3zamAXk5jG0KBfb1m+kTs0B6rKDErAnAfimP6218Bun6f+h
 3mn5ZSdmSxc70KpxzhD9mRFCST8JPKbG/TMYK4AxLaa2YU
X-Received: by 2002:a05:600c:8906:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-48e51f46d7bmr450455e9.19.1778000474701; 
 Tue, 05 May 2026 10:01:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e51f34779sm421315e9.5.2026.05.05.10.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A143D604F0;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 07/10] .agents/skills: add skill to distil mail threads
Date: Tue,  5 May 2026 18:01:02 +0100
Message-ID: <20260505170105.228162-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Just YOLO'ing the entire mail thread into an LLM context is quite
expensive especially if reviewing a thread against your current tree
state. This skill allows the agent to extract just the comments and
tags saving tokens.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/distil-mail-thread/SKILL.md    | 33 ++++++++++
 .../distil-mail-thread/scripts/parse_mail.py  | 64 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 .agents/skills/distil-mail-thread/SKILL.md
 create mode 100644 .agents/skills/distil-mail-thread/scripts/parse_mail.py

diff --git a/.agents/skills/distil-mail-thread/SKILL.md b/.agents/skills/distil-mail-thread/SKILL.md
new file mode 100644
index 00000000000..3c083ec5aa1
--- /dev/null
+++ b/.agents/skills/distil-mail-thread/SKILL.md
@@ -0,0 +1,33 @@
+---
+name: distil-mail-thread
+description: Extract and summarize reviewer comments from a QEMU or kernel mailing list thread dump (like a b4 mbox or text export). Use this when the user asks to "distil", "parse", or "extract feedback" from a mail thread file.
+license: GPL-2.0-or-later
+---
+
+# Distil Mail Thread
+
+This skill helps you extract reviewer comments and feedback from a long mailing list thread file, filtering out quoted text, patch diffs, and headers. It relies on a Python script included in this skill's `scripts/` directory.
+
+## How to use this skill
+
+1. **Locate the target file**: Identify the mail thread file the user wants to parse (e.g., `wxft-rfc-mail-thread.txt`).
+2. **Execute the script**: Run the included Python script against the file. The script is located in the `scripts/` directory of this skill.
+
+   ```bash
+   python /path/to/distil-mail-thread/scripts/parse_mail.py <path_to_mail_thread_file.txt>
+   ```
+   *(Note: Adjust the path to the script based on where this skill is installed. You can use your filesystem tools to locate `distil-mail-thread/scripts/parse_mail.py`.)*
+
+3. **Read the output**: The script will generate a file named `parsed_comments.txt` in the current working directory. Use your file reading tools to examine its contents.
+4. **Analyze and Summarize**: Read through the extracted comments and provide a structured summary to the user, correlating feedback to specific patches if necessary.
+
+## Expected Output
+The `parsed_comments.txt` will look like this:
+```
+--- REPLY FROM Reviewer Name <email@example.com> ---
+Subject: Re: [PATCH 01/10] ...
+Comment text here...
+============================================================
+```
+
+Use this structured text to efficiently analyze the feedback.
diff --git a/.agents/skills/distil-mail-thread/scripts/parse_mail.py b/.agents/skills/distil-mail-thread/scripts/parse_mail.py
new file mode 100644
index 00000000000..2924d07dc56
--- /dev/null
+++ b/.agents/skills/distil-mail-thread/scripts/parse_mail.py
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+import sys
+import os
+
+if len(sys.argv) < 2:
+    print("Usage: python parse_mail.py <mail_thread_file.txt>")
+    sys.exit(1)
+
+input_file = sys.argv[1]
+output_file = "parsed_comments.txt"
+
+try:
+    with open(input_file, "r", encoding="utf-8") as f:
+        text = f.read()
+except FileNotFoundError:
+    print(f"Error: File not found - {input_file}")
+    sys.exit(1)
+
+# Split by the separator used in lore.kernel.org / b4 dumps
+messages = text.split("----------------------------------------")
+
+with open(output_file, "w", encoding="utf-8") as f:
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
+        # Filter out the original patch author (assuming they are Alex
+        # Bennée in this specific context, but for a general tool, we
+        # should probably just look for non-patch emails or specific
+        # reviewers).
+        # We will keep it general: exclude the main author if we can guess it,
+        # or just extract everything that doesn't look like code or a patch
+        # description.
+        # Actually, let's keep all comments that are replies (indicated by >
+        # quoting or Re: in subject).
+
+        is_reply = "Re: " in subject or subject.startswith("Re:")
+
+        if is_reply and author != "" and not author.startswith("qemu-devel"):
+            f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
+
+            # extract comments
+            comments_extracted = False
+            for line in lines[body_start:]:
+                is_metadata = (line.startswith(">") or
+                               line.startswith("---") or
+                               line.startswith("diff "))
+                if not is_metadata:
+                    if line.strip():
+                        comments_extracted = True
+                    f.write(line + "\n")
+            f.write("="*60 + "\n\n")
+
+print(f"Done. Extracted comments saved to {output_file}")
-- 
2.47.3


