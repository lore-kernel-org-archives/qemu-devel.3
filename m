Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FECFCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL4-0007b3-Ip; Mon, 20 Oct 2025 06:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnL0-0007Zi-8O
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKy-0000hY-Gr
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso8333935a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956919; x=1761561719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lbXHfdqzd9K7rxlxVWnZ4xn8X5nG89zlTwjXtIzJDk=;
 b=XkLDa3OykhBAGTgP50yZRcKjU/dvQNrtAm6zt8AHLN1TUE3sYeQIFxN7w1ZO213Pfs
 s66kZVxJ52KJYYR1Nv7v2JHEoG2rXq5ehojKVUJT/Yt2nuOyHXcYxdMepl4YLcXLPvMB
 4ydXDM0IQ1fYw4hkfnZa+CF4bd6wHTgxF1rKFJPHAia05sOFDruJWAdUsiY0dljsaSY+
 EdwfXR908DiC7QtWUqeSWiLQqmxagLOOhFG0nnLFbNzLYnl68UQthvdqzKN//UiTEsGJ
 WOHVsQEJW/nXztimw8VHwkjjJGRunukwtil2sZXOp6qxAh31yyl/Hqbm9/XKwHycl6qN
 dJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956919; x=1761561719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lbXHfdqzd9K7rxlxVWnZ4xn8X5nG89zlTwjXtIzJDk=;
 b=TTdYDSUoyNxGPHpdh5zGJiuyhYpm1goeT/1WdIIF8sxntstEr3yOYP+lUPXLpclIDe
 EZph3UOB626hpWfQYnIhLh8Q59hC2y/g2zwwXDk+tKAXJx72dVWP1ryq39OPPYUQmQka
 MtIEzdUSvIcwzcIgWJ8cMF6rXZ9IpedbKhdVoT44TWwRxUTen9HstXTcRW/2pWGIxaMo
 fYLplHZSPx/IfeKor1jgX9r9oJwOB5gPDAPM1fE5doJVxrD+b3WPQLzNlpcd3BwHfL20
 G3R3iXQ7BWEkhEDQtyCR9dsnX4JucDX2BDOMkUWdDrRjAjXIoK+8Jpxqz/xv1lfa03hP
 7DFg==
X-Gm-Message-State: AOJu0YyV2jH3yEeF1mM1RSyWtxoP/TnojyfYt4QVm/2BT0PAJLTitJdP
 /oF2Uer64VBMEJBwyeYGwTrUkyC6uZiRKcLfGmp5oEttfmi8WRliZXf0UW4TK+DCsIQ=
X-Gm-Gg: ASbGncv7q0gMlJTawBzjmrjUpPBIbrpRfhse/M7T26N5fF6xI8LFu41Ras4GPjEphkQ
 IHLdBE+uktyGEG3HJTCsY6/grvVkhaAN3l4g53KAoMH0uaN53W4XnG1jRjP44CkYfmKg9UiwsxM
 EKhSKB2uRs+wf7QWhfQQ2wQwNnARbiMyjPOCf+7hnEPi0NXHYBM0kqQYlPgbe2nXNTKdQchTClM
 UnV2ZHrsfh10pvI32ZcIYPI4kY6zdx93KsDZKExzICsps8EJvAkM0vlRue7bkfMyB6v7abYHPnP
 dq9rjyQ8EP659yk02wMYG/krJzStRlnTDUZXZGFO1oay6idJfkY0DVSGtWbPAXFA5jU9VExE47M
 3jVTsAXmwKNuK+f8m9zyVy6f1msSLHbAq246Sp0BiDL+AWXd5a3aurCA5kx8N3ERY5M3G1W8Mdk
 52
X-Google-Smtp-Source: AGHT+IHQGr4kuBjL3pC/m7hWbqT79ZQqUVVX4ZUoJWJpMSPg/qqKGhBDgWmmiEO9PcWNSZtlntvlGA==
X-Received: by 2002:a05:6402:5c8:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-63c1e1f21c4mr12906999a12.7.1760956918861; 
 Mon, 20 Oct 2025 03:41:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4949beedsm6274158a12.40.2025.10.20.03.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 74FBC60E36;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 09/11] docs/system: unify the naming style for VirtIO devices
Date: Mon, 20 Oct 2025 11:41:47 +0100
Message-ID: <20251020104149.4034124-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

This makes the index look a little neater.

Reviewed-by: John Levon <john.levon@nutanix.com>
Message-ID: <20251016150357.876415-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index b7eb0fc0e72..39d2fd2d21c 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -1,7 +1,7 @@
 ..
    SPDX-License-Identifier: GPL-2.0-or-later
 
-virtio-gpu
+VirtIO GPU
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
diff --git a/docs/system/devices/virtio/virtio-pmem.rst b/docs/system/devices/virtio/virtio-pmem.rst
index c82ac067315..0c24de83ec7 100644
--- a/docs/system/devices/virtio/virtio-pmem.rst
+++ b/docs/system/devices/virtio/virtio-pmem.rst
@@ -1,7 +1,5 @@
-
-===========
-virtio pmem
-===========
+VirtIO Persistent Memory
+========================
 
 This document explains the setup and usage of the virtio pmem device.
 The virtio pmem device is a paravirtualized persistent memory device
diff --git a/docs/system/devices/virtio/virtio-snd.rst b/docs/system/devices/virtio/virtio-snd.rst
index 2a9187fd701..3c797f66e03 100644
--- a/docs/system/devices/virtio/virtio-snd.rst
+++ b/docs/system/devices/virtio/virtio-snd.rst
@@ -1,4 +1,4 @@
-virtio sound
+VirtIO Sound
 ============
 
 This document explains the setup and usage of the Virtio sound device.
-- 
2.47.3


