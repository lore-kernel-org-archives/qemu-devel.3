Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5472DD74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc9-0004P1-P5; Fri, 23 Jan 2026 09:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbz-0004IJ-Ke
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbx-0007oa-UU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so1443337f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180288; x=1769785088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHNWNw6bOL9uCXfJx/sXdBgGZyGqUJ5RbKAUe0K/1PU=;
 b=SbHhoe6NL0k5fkKeLvgNOlVx+jFthxJaKQCJVVltfjERlxZQDzFlJJ8AgMEqU1Vtyd
 ruzbmfqlp31ZTJ9I8u4MOcMMsV7zjvo9s6NLKWcbVThmdYJv1SIkQGIzF3xS8WniWd5d
 boe+rr63ooBgZielZ6n2QmM/F6jBhVc9a94wYwRPGZPyoPJCAzIe8ewbLJa/w9QSH0E2
 PNCNDsppPcGH1CrBZcZfh0jM6FZNAhME8sIOTBp4zqmtfMZQETMxqrabwAPmLUxDtwN2
 Wgir6p7no9/sfOwuISyIxXlovfA1CkRKOzj+sETc3VlwcwMPwXRJFzPe3dNlcg4DBfZ2
 UOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180288; x=1769785088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHNWNw6bOL9uCXfJx/sXdBgGZyGqUJ5RbKAUe0K/1PU=;
 b=X8YfAaRAiIFZwvPA6mQIsww0Fw6S998vtvlOZUqBDRuBmS6RApnNTle7Cm/cZjQGbl
 D2lxdEF95fLtyZZEfZNxuNikxZuWqIq/9wgKMnAgS25CcBZwny2/uYpsz9C50ium+3zS
 ougxkup/FlH+uqIkxl4GYMZYy7hQadVYnhbRvI0zXtqbarCThy7mEJRf7GCufyXuPcmV
 gTRCV/rf81Uu5c8d/+yxVtdRXuiAP5jxDBKyeOX/gsa33QUMcXT4yhzpoHYtLMzn/aPX
 BSb+lKTtL/8ZXrC4FuY6cjTb0ZAfcdNx4PPX3/m5LHYopUbZaB+0/F2Em4vFKXjKx/wN
 o7uw==
X-Gm-Message-State: AOJu0YxkpdFJJAByfTgnNw2RCMhM/9rmGDVIYIzAF+y4q4qioQhZrK4x
 katj58YapEGH4qARQDEak0t2LV7O9QZwtGx6PieDgOhboDSXZBuPs9gW5Z9yAqHCucg=
X-Gm-Gg: AZuq6aK6HdP7W0H9ZVAJzgQO+i4XbKOkIHjlFApsQr7bzXSF6nUHAOSgQ6+AT/MahBB
 KUedxrHxq1AUsQLSiMTwsuHxnQse+aF6o57Ruso/3TtZaXUBHgnhBMHKKi46oWTl1ht7PN31Dbr
 G+UZHFym9CcYE7D3Je7Jofwid941kgcQ48hCLN2cckDCqQr6vB2Bl5+KwyYA9lcZXn/48w5wmQ5
 KD2UGCQkA9FqEF/NNrEn5KjrgjWaHbL6oE9BHjio0nTcNkzVClF8BE6Vg2ksEtMkIV8V6CcMkKb
 vjLhA0atCRbrb/BHAvxyveDyzw3yeRaClcHE9gLcM9rCXfVb4VvxVEcXesNiD5VIrJsT6gYvuc+
 xFjjbFobqFhTUU7vL62ihPR8ZUyZCM7XMRHl25bhBu8Yb5zghKdG6s+NJz0e01owudcER3s0DEQ
 NjGbp4pUmjmEXM
X-Received: by 2002:a05:6000:402a:b0:435:9882:2342 with SMTP id
 ffacd0b85a97d-435b1604b2bmr5159948f8f.33.1769180288143; 
 Fri, 23 Jan 2026 06:58:08 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm7165060f8f.16.2026.01.23.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C55AC5FADA;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 15/16] scripts/get_maintainer.py: implement basic git
 fallback support
Date: Fri, 23 Jan 2026 14:57:48 +0000
Message-ID: <20260123145750.1200879-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Implement the basic --git fallback support which also needs
--git-since and the various knobs to control the minimum and maximum
signatures to look for.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 125 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index b41f5342876..de229a20bc2 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -11,12 +11,16 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
+from dataclasses import dataclass
 from os import path
 from pathlib import Path
 from enum import StrEnum, auto
 from re import compile as re_compile
 from re import sub as re_sub
+from re import IGNORECASE
 from regex import compile as prec_compile
+from git import Repo
+from collections import Counter
 
 #
 # Subsystem MAINTAINER entries
@@ -230,6 +234,96 @@ def process_patch_file(patchfile):
 
     return (msg, file_list)
 
+#
+# Helpers for querying git
+#
+
+
+@dataclass
+class GitOptions:
+    repo: Repo
+    singers: bool
+    since: str
+    min_sig: int
+    max_maint: int
+    min_percent: int
+
+
+def rank_signers(git_opts, all_signers, total_commits):
+    """
+    Counts signer occurrences and returns a list of (Person, count, percent).
+    """
+    if total_commits == 0:
+        return []
+
+    # Count by email to handle duplicates/mailmap issues
+    counts = Counter(s.email for s in all_signers)
+
+    # Keep a map of email -> Person object for the most recent name used
+    email_to_person = {p.email: p for p in all_signers}
+
+    ranked_results = []
+
+    # Sort by count descending, then take the top N
+    for email, count in counts.most_common(git_opts.max_maint):
+        percent = min(100.0, (count / total_commits) * 100)
+        if percent >= git_opts.min_percent:
+            person = email_to_person[email]
+            ranked_results.append((person, count, percent))
+
+    return ranked_results
+
+
+# regex to extract name/email from *-by: tags
+sig_line_re = re_compile(r"^\s*[\w-]+-by:\s*(?P<person_info>.*)", IGNORECASE)
+
+
+def extract_signers(commit_message):
+    """
+    Return a list of Persons found in commit.
+    """
+    signers = []
+    for line in commit_message.splitlines():
+        match = sig_line_re.match(line)
+        if match:
+            try:
+                p = Person(match.group('person_info'))
+                signers.append(p)
+            except BadPerson:
+                continue
+    return signers
+
+
+def extract_from_git(git_opts, src_file):
+    """
+    Extract 'maintainers' from examining the git history of a file.
+    Return an array of Person/role tuples.
+    """
+    repo = git_opts.repo
+
+    # use the porcelain to fetch the log
+    hashes = repo.git.log('--follow', f"--since={git_opts.since}",
+                          "--format=%H", '--', src_file).splitlines()
+
+    if len(hashes) <= 0:
+        return []
+
+    commits = [repo.commit(h) for h in hashes]
+
+    all_signers = []
+
+    for c in commits:
+        all_signers.extend(extract_signers(f"{c.message}"))
+
+    ranked = rank_signers(git_opts, all_signers, len(commits))
+    results = []
+
+    for person, count, percent in ranked:
+        role = f"commit_signer: {count}/{len(commits)}={percent:.0f}%"
+        results.append((person, role))
+
+    return results
+
 #
 # Helper functions for dealing with the source path
 #
@@ -331,6 +425,22 @@ def main():
     parser.add_argument('--src', type=valid_src_root, default=src,
                         help=f'Root of QEMU source tree{" (default: " + src + ")" if src else ""}')
 
+    # Git Options
+    parser.add_argument('--git', action=BooleanOptionalAction,
+                        default=False,
+                        help="Include recent git *-by: signers (default: don't)")
+    parser.add_argument('--git-since', default="1-year-ago",
+                        help='git history to use when falling back (default: 1-year-ago)')
+    parser.add_argument('--git-fallback',
+                        action=BooleanOptionalAction, default=True,
+                        help='use git when no exact MAINTAINERS pattern (default: fallback)')
+    parser.add_argument('--git-min-signatures', default=1,
+                        help='number of signatures required (default: 1)')
+    parser.add_argument('--git-max-maintainers', default=5,
+                        help='maximum number of git derived maintainers to add (default: 5)')
+    parser.add_argument('--git-min-percent', default=5,
+                        help='minimum percentage of commits to tagged as a maintainer (default: 5)')
+
     args = parser.parse_args()
 
     try:
@@ -369,6 +479,21 @@ def main():
     for rm in maintained:
         print(str(rm))
 
+    # Git fallback
+    if args.git or (args.git_fallback and len(maintained) == 0):
+        repo = Repo(src)
+        git_opts = GitOptions(repo=repo, singers=args.git,
+                              since=args.git_since,
+                              min_sig=args.git_min_signatures,
+                              max_maint=args.git_max_maintainers,
+                              min_percent=args.git_min_percent)
+
+        for f in files:
+            gmaint = extract_from_git(git_opts, f)
+
+            for (person, role) in gmaint:
+                print(f"{person} ({role})")
+
 
 if __name__ == '__main__':
     main()
-- 
2.47.3


