Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF259D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nuK-0003xl-GE; Tue, 29 Oct 2024 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns8-0000o5-LA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:07 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns2-0007ho-Fb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:04 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so6906034e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214654; x=1730819454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8e1aymOVILrgw7W2xEL/OiCjMGpomvllpnPzHFIUe8Q=;
 b=Q+uhP822wY6j/2OBE1UFo1lAZMKykhjOlk99R3Qhx5Cp0L6s6e9NHQHQ4YV/r9V+mF
 1oMK+swtLxZUfOWzVdERvc8Wp09vchH9dBsXcSmB72gw7EVPvK7gzj/4tzAhR2rwdARd
 xGysPczgnYoLzYjGjeVCx2mV+h5LJdEA8yJ+RNdlRgmcGQ9VMYti4zQwp9vof6jZX2qj
 4lwObM7eQcUPWuR7NlOwsvq6rnbtySLF3oJDHRyyEd1YN7Dy3FDg953hLErwuOSOYCGX
 hw23IlegJ1blTbOClb48Kcb0LCbuAMSVqV0EdvQeBsTq7aWQoUCurbLKbyUG9hfmjGAS
 FWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214654; x=1730819454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8e1aymOVILrgw7W2xEL/OiCjMGpomvllpnPzHFIUe8Q=;
 b=DmQSFpOkF3tDltipc/EtSjP9nQqFbbrNCXzEUMGg3oxUrdMegHDRfCs6Ie0bIBLZhV
 mLRiZgG1i7YR2edo0cEQiNxCLBh/UsEWcdMlH3mADMLn5E53VxaDR6mXh2ZkokJeT3ID
 B5P14A5TUMTdwQj6m+6mvmhC+Gps9shpsvxfoHlmVcjQjYTKqj1F0OAeED9Yg6U4xaCC
 FekcD4DjduAOXsSEzCD/tkwfmE4O5v2aQeVLly48rvk9JQwtZxTikfrb4fxaWid6tDW8
 uSUngGyB0H+QFOIKVgaV75/DrBl0gcYIKnjLeMdtda6l7d1VtWZAmuwm5P9PUYqXOZmJ
 el3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZptH/4dR92OxUSpPxh2EX1X+rDZ36je8uJcq6OwJk0z4jsxrw9Ddkb3dVkoWMu/G2FXtQDwAjZIU3@nongnu.org
X-Gm-Message-State: AOJu0YyQ6erRQssKJvTHl84NI/vBov2roWIfBLqBGagI4RO537wZBSS4
 q3rYppOae+z6L+NqHHFNf1cMUTkwm0KGJ8ZUpJgGpiB0KX+Y4fZsLDgAnC4oq8A=
X-Google-Smtp-Source: AGHT+IE0TmVRwKjR6vccZ6UsBJL1woKDhnZKHRJO5Edvjzh2eHwlbk5pi7p4O+9VEzAJvMCZiVlHQw==
X-Received: by 2002:a05:6512:1392:b0:539:e0ee:4f5f with SMTP id
 2adb3069b0e04-53b7ecdeed7mr35054e87.18.1730214654213; 
 Tue, 29 Oct 2024 08:10:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/18] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
Date: Tue, 29 Oct 2024 15:10:38 +0000
Message-Id: <20241029151048.1047247-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().  Otherwise the script will fail if
the build directory has a character like "~" in it.

Note: this fix cannot be backported directly to any stable branch
that doesn't require Meson version 1.4.0 or better; otherwise it will
work OK on Linux but will break on Windows hosts.

(Unfortunately, Meson prior to version 1.4.0 was inconsistent between
host OSes about how it quoted arguments, and used a different quoting
process on Windows hosts.  Our current git trunk already requires
1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
the stable branches are still on older Meson.)

Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241018130852.931509-1-peter.maydell@linaro.org
[PMM: Updated commit message to give all the detail about the
Meson version compability requirements.]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/symlink-install-tree.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
index 8ed97e3c943..b72563895c5 100644
--- a/scripts/symlink-install-tree.py
+++ b/scripts/symlink-install-tree.py
@@ -4,6 +4,7 @@
 import errno
 import json
 import os
+import shlex
 import subprocess
 import sys
 
@@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
     return str(PurePath(d1, *PurePath(d2).parts[1:]))
 
 introspect = os.environ.get('MESONINTROSPECT')
-out = subprocess.run([*introspect.split(' '), '--installed'],
+out = subprocess.run([*shlex.split(introspect), '--installed'],
                      stdout=subprocess.PIPE, check=True).stdout
 for source, dest in json.loads(out).items():
     bundle_dest = destdir_join('qemu-bundle', dest)
-- 
2.34.1


