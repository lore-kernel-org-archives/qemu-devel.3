Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5F9C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjdx-00074f-1T; Tue, 30 Jul 2024 05:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjdw-00071d-6R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:59:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjdu-0003ch-Ii
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:59:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so2302965f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722333581; x=1722938381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1gxlSql/jvVtYT0aRUJJ4TNUP3dRmkRFYomfT7w2uNg=;
 b=hOEk35TYr/S71hWKLhloROXb9KJ4yMFEib5OiIdwqIh5vi51SYAG++0CDyRW8ntiLf
 ik18gsojF09zTFMrYZsH3F0ZKi5R0Px2KcGST9wgUlBUCiEYKl1QvBdsWinkrg29pZJE
 sO0LRtTt7lvT7DWNlkDt33AwVe/SqnDMvo+8/nEgHtsDMz1pTsz156rUalJLj3+QmJme
 OSDuxAsM+qF5Z2JOfSosl8lCYFkG8G6E9XjEuK0HXbdAEvQ33D9PKyT1hlHJ1b3QQwaW
 6b92rQIQHK08PUQ5ZfhKeF2Maq9c+iDov8+hmQWerxkRXr39u+gv9PLzuDmSDjpa/PcI
 n++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722333581; x=1722938381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gxlSql/jvVtYT0aRUJJ4TNUP3dRmkRFYomfT7w2uNg=;
 b=d7eotLaSYt64DcDub7qaSjoqL2XpNEpcRbQ60NiunrCSH3C22p3WS9Q+hSltRjpRel
 k96gJkeU3WtEASEVb3ljJvKAsvgYSebHrPuSoDtJuLjfXc0qSpUJAFBNrHHZCUwXhlCU
 gp83Q2CGP9UUbZnWHJbfmh1F8Z/Lj336yir0jnW3tO5e6AxH7kg+aggm9hpjDCSD0OWZ
 Jrs1jTmsDw/AmOD9kcQjOpIW8sVdd899HGlSmmznClBEAwyIUv3W1TbMwSCK+UPUYJmV
 gTOqrtFkKIaAspe46Rs2iiJWY4O3wAYodL0lDeAtRE7hdLF53U9RGz5T7K1ev6ZFZ995
 5NSg==
X-Gm-Message-State: AOJu0YyE4tjWCczfRi7lSCoaxPqpmM/eYA20WwwFz5RhaslJljsKKKVa
 j32aLob8N8C0jcwIs8omGXW6BQUgvjENNfDkqlYkzG9lRS50Yy0YnERSw9MQ5MmgKkpmfTsbOQe
 j
X-Google-Smtp-Source: AGHT+IF24LWWhXZ7QjjDCPI4ChXMw7KuebQTyK/nVxlqOO2l/b/3u+zRZYu6sU+2FVdPgV05QN8Q7A==
X-Received: by 2002:a5d:6891:0:b0:368:6f19:cbf5 with SMTP id
 ffacd0b85a97d-36b5d03cb72mr6353539f8f.31.1722333580788; 
 Tue, 30 Jul 2024 02:59:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730d92sm209679985e9.3.2024.07.30.02.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:59:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] osdep.h: Clean up no-longer-needed back-compat for macOS 10
Date: Tue, 30 Jul 2024 10:59:39 +0100
Message-Id: <20240730095939.2781172-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Our official support policy only supports the most recent two
versions of macOS (currently macOS 13 Ventura and macOS 14 Sonoma),
and we already have code that assumes at least macOS 12 Monterey or
better.  In commit 2d27c91e2b72ac7 we dropped some of the back-compat
code for older macOS versions, but missed the guard in osdep.h that
is providing a fallback for macOS 10 and earlier.

Simplify the ifdef to the "ifdef __APPLE__" that we use elsewhere for
"is this macOS?".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 191916f38e6..720ed21a7e4 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -786,8 +786,7 @@ size_t qemu_get_host_physmem(void);
  * Toggle write/execute on the pages marked MAP_JIT
  * for the current thread.
  */
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+#ifdef __APPLE__
 static inline void qemu_thread_jit_execute(void)
 {
     pthread_jit_write_protect_np(true);
-- 
2.34.1


