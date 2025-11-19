Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5CACF58C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmqp-0000y3-4L; Wed, 19 Nov 2025 13:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@gmail.com>)
 id 1vLlyf-0002S5-5f
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:28:22 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@gmail.com>)
 id 1vLlyd-0004JT-Mq
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:28:20 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-4332381ba9bso101695ab.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763573298; x=1764178098; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gtPbqc+AMCqouNpafbfHY6FEx0CZ0+IPs9jgeWbmnW0=;
 b=i2sgw+kLyd1FtZVYwJU9Di2Gsc/KQp0OiQsNJtIWIRisPvClNt807s8f9EdxU5dIdz
 LmbVrpGOw241MXaAjR6IpyeBkrgzhHupxaQludDk3OdCDQw9sPz7qOrtLGQLPPo8lMi1
 qlicREOAkyCFqHR3wfA50vp4zmtMMLvbY7P6iPtPZbyasa3Y0ZwHwScBqJmdKOqHi7Ey
 nsL8hcmgRy1fkkv+8b5+oIUxNFOdji0+ekqwkRFp/hvWaRee6DpBhwYOtvA1zGry1GAJ
 a/pp7lyY2oh2B7coB9Aoyomq2eSiKqXKdTjWYo+ifU8AdXdPu3mVmerVlkb0l3tCTswE
 0/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573298; x=1764178098;
 h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtPbqc+AMCqouNpafbfHY6FEx0CZ0+IPs9jgeWbmnW0=;
 b=BuskUgC0uYHhhCrgLVjJq3K/klmVi1f7e7Gh66EdsAG9IFhCv1e5jN+xLBp7uLj7lR
 pNx6wqFJHZcMGLvUu4/aX6uYqWzSlJqbZkNnutTK0p2jr0ETQP/72WJerzW/6PT12P9J
 bj+UtBCzP5dxzd1eh85KzhNpn6B9lB2verGvSHhs1DsWUHeclISBR84/gXV50KO+KhUf
 XYhM9ZtbwwwC6d12lSUA9xtwJgSChg2IT/JAAUX94ysW2yWu08EZJ2BFHglpL9bnTa/5
 Wh7XcCLtAOnNF/3dhA29yMTFMw+1nWB490yJ2pbUOweWluj0qXmNt0EoF82WvGEYUYqS
 zGaA==
X-Gm-Message-State: AOJu0YwoBqUVUIAwtT4ywK0WtUB9Cnj4acjf+a1I0ylKiBsy9cPgLXnf
 Nfji3cdmQeFQ4EXQusPzNyccDNPibaWq0bHvyIwQ+YSh8s/I3kPwAAW8KkEfQXDmEGseMvTdInF
 c85nuO9+/DD+QPT4NuUIuLIo5YWZtv65/P42o
X-Gm-Gg: ASbGncs+tc/m97PC4oiAiQat/dbNmmf2W23eMUZnnymbNLo12AEVlJpd38msvXLsh9D
 VrCEuCT1qlzoQM73dO9dUf2UTbq4oP6IMj2TKGpHiq0UNqVJONFrPKTL0ulykcjWnCHBnQ2jYuP
 ZZjfP2SS/ENPjwJ59EwyT50Oj3yHufTGRN7doIYs4eGAurV8FK7tm4N6eDsoZg3ZnCi6b16j0BS
 URGDHSl3JZM5tUt9gy/eErcj4MWl5JHKSjk2N8ay5ZfvqiLAUX0timfQ68u4cFAcLD1w/kQS3FB
 fYQPKQ==
X-Google-Smtp-Source: AGHT+IGseESW3+TiyVtUnh2rZyg+uK4cev1+1hkrm4TZ4XrmLI6ulCRgJHyF+Y1pce/ktftxg4muswV4qK6Ggaa1raY=
X-Received: by 2002:a05:6e02:1fc1:b0:433:80d9:708a with SMTP id
 e9e14a558f8ab-435a90397f9mr2949175ab.17.1763573297778; Wed, 19 Nov 2025
 09:28:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 12:28:16 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 12:28:16 -0500
From: konrad.schwarz@gmail.com
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 12:28:16 -0500
X-Gm-Features: AWmQ_bmxDrPqQHqirOr4JNKV_MvO3XAJ0Poygr60YQE1UpKWXZL8xMrGgdNAAQg
Message-ID: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
Subject: [PATCH 1/1] scripts: Changed potential O(n) file size calculation to
 O(1)
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Konrad Schwarz <konrad.schwarz@siemens.com>,
 jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=konrad.schwarz@gmail.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Nov 2025 13:24:16 -0500
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

The mkemmc.sh script calculates file sizes via `wc -c'.  `wc'
normally works by reading the entire file, resulting in O(n) performance.

Unix file systems obviously know a file's size and POSIX `ls' reports this
information unambiguously, so replacing `wc' with `ls' ensures O(1)
performance.  The files in question tend to be large making this change
worthwhile.

Signed-off-by: Konrad Schwarz <konrad.schwarz@siemens.com>
---
 scripts/mkemmc.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
index 45dc3f08fa..d2c4e84b16 100755
--- a/scripts/mkemmc.sh
+++ b/scripts/mkemmc.sh
@@ -37,13 +37,19 @@ usage() {
     exit "$1"
 }

+file_size() {
+	ls_line=$(ls -Hdog "$1") || return
+	printf %s\\n "$ls_line" | cut -d\  -f3
+	unset ls_line
+}
+
 process_size() {
     name=$1
     image_file=$2
     alignment=$3
     image_arg=$4
     if [ "${image_arg#*:}" = "$image_arg"  ]; then
-        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
+        if ! size=$(file_size "$image_file"); then
             echo "Missing $name image '$image_file'." >&2
             exit 1
         fi
@@ -105,7 +111,7 @@ check_truncation() {
     if [ "$image_file" = "/dev/zero" ]; then
         return
     fi
-    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
+    if ! actual_size=$(file_size "$image_file"); then
         echo "Missing image '$image_file'." >&2
         exit 1
     fi
-- 
2.39.5

