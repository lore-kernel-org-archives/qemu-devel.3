Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5471C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYP8H-0002AX-Bc; Mon, 29 Jul 2024 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYP8F-0002A1-T0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:05:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYP8D-0005J3-JN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:05:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso14541935e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722254735; x=1722859535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v4OnXxLy+/uIGAva9okgt0HNd9KDzrdWo3Q0gkIoVtM=;
 b=l447vCDeIxIEwtFVEsTnswPIUH3gt//J4R1iGhoDi/PM8shLt3XwlXrWnYCbquvyjy
 V8lUOfpVeQAFoEJHFotQ2wgVrkHEHP+8hL1ndIYVKncLY7JrNf1ThhaLVif4U8Obj+RI
 c55ARpxs6SzSwdiTsMBgZuBj5jJwRA2wrewUqIQA4hDTbjHl3/knFFEUnlWPdW/zTbTr
 vOefjE/miDuyXZVV/PC7Xf/PeA2kfYhhsETvG6z/TnJXhZ+ujGKSwV75YnMymJb790vY
 9PWCLOufZqGZsqmPidHWz6lFbfi4F4w7HZDn51TV+2M4ZAvc/ziBjXFh2V/m4J35fjuv
 lvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254735; x=1722859535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4OnXxLy+/uIGAva9okgt0HNd9KDzrdWo3Q0gkIoVtM=;
 b=odgEjcDu5eJItpX6o6sv9X4cMuyZB9AucJ8m0SDTIMYi8wp7Cd/Cb05eF24aHMvj70
 4AEtmhpASNBZcFmtLWw6ROdAMLkVt120bsVdtNCc1rVPS3YlQ06SCPhsmFDwq5wNZpKT
 2v6jPiMWQHW+berSg2L51NMAJKwZHH89o+HMuRKVEDjY8YLJvA8rRqJ6VcBObhiMxoMz
 LUvOPk33KVq95Gc7nYd4RJWRjUeWAzuw12XOkbtHiUsZHZPfi8+Mbk7URsPsVl8VM5ox
 VBZ+eA+0wlLRCJwFW/71a9qszSD5ZtV3AMoDGcWptjlbNLB+QzWWaDJtss5unJfHsAfS
 WwDQ==
X-Gm-Message-State: AOJu0YzClKFw/dLLRY1gfLgGmhIv+YItgxL0bXIS2HYi0qDyCOnjY5GJ
 3tn/xlCHH1fWla+hBTY16ZO76EEGANtZecCTm6WydlDHk+tJukHGIlkGi0Xp8jLnmDfJRrg6OLm
 5
X-Google-Smtp-Source: AGHT+IEXiWrssHey1a3fwVGlM0oZXx1v6XHFkl0gEvRQWFBuvoc6CrD8tI1KS07kEQEevtqOzQ+mlA==
X-Received: by 2002:a05:600c:1f8f:b0:427:ffa4:32d0 with SMTP id
 5b1f17b1804b1-42811dd6ae7mr47189575e9.28.1722254735352; 
 Mon, 29 Jul 2024 05:05:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428197f2597sm52968245e9.24.2024.07.29.05.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 05:05:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] docs/sphinx/depfile.py: Handle env.doc2path() returning a
 Path not a str
Date: Mon, 29 Jul 2024 13:05:33 +0100
Message-Id: <20240729120533.2486427-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In newer versions of Sphinx the env.doc2path() API is going to change
to return a Path object rather than a str. This was originally visible
in Sphinx 8.0.0rc1, but has been rolled back for the final 8.0.0
release. However it will probably emit a deprecation warning and is
likely to change for good in 9.0:
  https://github.com/sphinx-doc/sphinx/issues/12686

Our use in depfile.py assumes a str, and if it is passed a Path
it will fall over:
 Handler <function write_depfile at 0x77a1775ff560> for event 'build-finished' threw an exception (exception: unsupported operand type(s) for +: 'PosixPath' and 'str')

Wrapping the env.doc2path() call in str() will coerce a Path object
to the str we expect, and have no effect in older Sphinx versions
that do return a str.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/depfile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index afdcbcec6e7..e74be6af98b 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -19,7 +19,7 @@
 
 def get_infiles(env):
     for x in env.found_docs:
-        yield env.doc2path(x)
+        yield str(env.doc2path(x))
         yield from ((os.path.join(env.srcdir, dep)
                     for dep in env.dependencies[x]))
     for mod in sys.modules.values():
-- 
2.34.1


