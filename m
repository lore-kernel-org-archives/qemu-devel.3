Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B45C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuT-0005dR-Ir; Fri, 16 Aug 2024 09:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuN-0005Gv-8u
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuK-0007ki-TR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso14950045e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814539; x=1724419339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vFh0taXho/PjkpHjQyE36dh+SvBwU6eZKgiDGqrkEc=;
 b=UEv4R0fK1fD2+IcqqzEhOY+HRTxO/MHpZp7CFHeXHtkVG2Inwc2FNTzDDUrSDV2rCp
 yBLqLYIqr0P1p76qzhEHme0U4bk+7jpcJqtMkzlnLPqfAJ7SEMPg4Fzs1FjHofVZmAB6
 LWsQphDDhHiX0VLHBBfPTxhW2KKqUEyTaGGaHe0r9445Fmmha2nPpooVyoJr42dMAHSq
 I7/UUVZVPdG++fvlRzYB8BrFsDOSbgM77eQVqgcHbUwKdXTQd9zdHRt7TBHTKIkP0HTr
 CPWEVX66dvboqAK/aV9mOzQgRJQfI1d6pr5xal1Uk4ByWNYOvN9/Es3hcWUf+70dmOWX
 7lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814539; x=1724419339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vFh0taXho/PjkpHjQyE36dh+SvBwU6eZKgiDGqrkEc=;
 b=NMPsmi0Rg1EsUwfelgOEvxUZimaGrK0q4l7G1x+tHmPhNsjlIAP3/u1nBOciZ1N2bl
 rGGyda6xvZzBxPXTHJ926VKQCzn7/VDBYAyeauKGiNEUCh1MYGyAgwj+bkVPO2taXcje
 boTQ0Kua6ZKEsgwaBCd4cRUtVt1Oi81xK62tcO4SVMQIv+ArRlo8YWZXZ46bQIs3fKth
 QwMOGcudVRj0i12wpYFeLePo7IuzWud/P47+nO1CFW7Y/1Ox2wvD1yiyLMVRwYUeTFo2
 /7/d0Jy9wZcws8e58Ji39L3UTxDeU6CZ5T+Ho7t9AW9FPEBB2ipQBnhFK0moT0Y2/ahX
 QYkQ==
X-Gm-Message-State: AOJu0YygDE58M4ahfg6RxumB3SmLqW+QBf+SXsgVaJhepw82JLoBFj6e
 ZGhzIRfWFWa+ZsuW2CP9S6/fnOEb3Uol9UTX2er3pDLQpxAwuroMblpAL1Q0io/Q2qWNj906GNw
 t
X-Google-Smtp-Source: AGHT+IHaaNIIpIuBbwgzlYn/WAMs06Fi2U1MnoQxNqE7h9aMHTYqMtvzIeghzT/x/aWWqudAlx59tg==
X-Received: by 2002:adf:fa50:0:b0:371:72a8:15e with SMTP id
 ffacd0b85a97d-371943292ecmr1600973f8f.16.1723814539070; 
 Fri, 16 Aug 2024 06:22:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 7/7] docs/devel/lockcnt: Include kernel-doc API documentation
Date: Fri, 16 Aug 2024 14:22:12 +0100
Message-Id: <20240816132212.3602106-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pull in the kernel-doc API documentation into the lockcnt docs.
This requires us to fix one rST markup syntax error in the
header file comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/lockcnt.rst | 2 +-
 include/qemu/lockcnt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/lockcnt.rst b/docs/devel/lockcnt.rst
index 728594bcea3..8b43578f6c7 100644
--- a/docs/devel/lockcnt.rst
+++ b/docs/devel/lockcnt.rst
@@ -175,7 +175,7 @@ three instructions in the critical path, two assignments and a ``smp_wmb()``.
 ``QemuLockCnt`` API
 -------------------
 
-The ``QemuLockCnt`` API is described in ``include/qemu/lockcnt.h``.
+.. kernel-doc:: include/qemu/lockcnt.h
 
 
 ``QemuLockCnt`` usage
diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index 2c92ae17c9e..f4b62a3f701 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -51,7 +51,7 @@ void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
  * Because this function can wait on the mutex, it must not be
  * called while the lockcnt's mutex is held by the current thread.
  * For the same reason, qemu_lockcnt_inc can also contribute to
- * AB-BA deadlocks.  This is a sample deadlock scenario:
+ * AB-BA deadlocks.  This is a sample deadlock scenario::
  *
  *            thread 1                      thread 2
  *            -------------------------------------------------------
-- 
2.34.1


