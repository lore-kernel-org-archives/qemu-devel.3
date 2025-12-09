Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B641DD3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3z1-0002KF-NR; Tue, 09 Dec 2025 15:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yt-000224-0y
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yr-0001LE-Co
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:42 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2cf93f7dso4330260f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310799; x=1765915599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KT0sNA3i3Q26pmMDca66O2amoVWltnvDxFfPQCtL5KU=;
 b=T/NfGPnuibKHuINnDFQs2IAzG7ArFsCqJFI14mlKXvluNmUVwlt4MRjlod0ouRbeSN
 YO6IGs9SapwCnj1AkIkTINbWGY7oDlDUSA2R/tCvj64k8TMZr1zWOHIQwOlgB0HPm968
 25m/nh1ZbOkmIg1BuqxyvANSvxoE/+i7IeptcScPsO2/z+aY5bcImXkRk3lJjX6EHdz/
 E1Wjk3uWucKDZSlTbjUOhwFr8aaY2xmmx3WXCoHqwqqc9AVvPtHCsp6+t0BVhu+Ed5hz
 Ce0syltOIz6MExNKRU7k2jAMiChvyEI1WnKxUiX2To5H07puWqVyn+s15OejKUYK975a
 yG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310799; x=1765915599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KT0sNA3i3Q26pmMDca66O2amoVWltnvDxFfPQCtL5KU=;
 b=U98315XMJm8lGeuKm4CeKGgsXBM46SWuxLO8vqWXCzn0+T/4ieyh+J38osdEgtMPPy
 xTwu6Hn8IH9owVUAyA5r/yn7mr+eSQxeNekpiWaDuUCDvSj/eyOTc9K78E/pyz7aThTy
 UdEfg+p3LQGGez5UANup20kad11Zjk5TU6mPqtmWu1IBhSzuPiVdr3P13m2gPt/em9xW
 0P77xkkoqQ2YIIl/6z9Lju0vOMV00ddcV8gQLPCQGo5wkf//2iN+UFII3GQ569HEEC6j
 dS1H+5LV7zzPmbErd8JXKGEsnYSsef+HGjC5OEkfafMhvgKZUP5cYMrmTxsAzkXzAFZm
 o6lA==
X-Gm-Message-State: AOJu0YyFnR+8hZBdpSkk9QuAAY0AXm55Zslqh278k4xaD5apvAIU0UHj
 /WtAaJ4bgQyXvjIfc6ta76hOHhEV3hQS84ygVrlE1M5BoLdg2pbwZB+iOF342slOeNWkKYbDyfW
 TqJbE7ZQ=
X-Gm-Gg: AY/fxX7PY2k1bfH0DZDumLocfXr0RsmlBvxWFpbFizJ7GYAraOUXVND1F1vVIcn/sJJ
 vg1lZcmudhE0QD5CE8RMgIILWc4Un1tmIRvbnr9882+5nJqgEWTBrf2qQP+8ZueCw0wsukALoUI
 Z+T5N9/h/rmpO+rip0VoA/1fCtWzpmh/GTs8BvJ04xrIEnnxJ11UoUAaPVqrlegxAr7I5qSIT3D
 Pi9FTMwVrwI0fGf/4E/L2tVyw/vGBryW2tRbT1UgYKGHnSnBHpKm+zB/NKTGS+pOc6tNHsW9UFv
 BH9/CAjSTXHnyAKF4RgA3Jpn2M1csgpWLzlPUkumzUWtWfzneGv2d+9+amakfev6Q6W/aOZvyGj
 gOLX4uxzXzAfn3qIPQBXGtAOkzSoH3B71X39Xdn8EFsqgzzLwb5eFvT4qNGjrePlFCtyJkj7juU
 2Re/Vc2UgUGY7zlb9FA0+ZG3De2KP95O4PD7wFxtJTMRMZVgl06h+64dwaQ189
X-Google-Smtp-Source: AGHT+IEof+RYVppOWSf7jziJ6Rimy190nZZU5gIrmIFsC1Bg1yGyNXYFl1h/H6HlUso0OvPdvlFYHw==
X-Received: by 2002:a5d:5887:0:b0:42f:8817:7f0 with SMTP id
 ffacd0b85a97d-42f89f64a95mr13259523f8f.61.1765310799209; 
 Tue, 09 Dec 2025 12:06:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353f80sm33018715f8f.41.2025.12.09.12.06.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] Revert "migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro"
Date: Tue,  9 Dec 2025 21:05:36 +0100
Message-ID: <20251209200537.84097-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Next commit will re-use VMSTATE_BUFFER_POINTER_UNSAFE().

This reverts commit 58341158d022823234d25fd337654a82fa6d157b.

Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/vmstate.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df57e6550a2..a87a5efa428 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -727,6 +727,15 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = offsetof(_state, _field),                          \
 }
 
+#define VMSTATE_BUFFER_POINTER_UNSAFE(_field, _state, _version, _size) { \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .size       = (_size),                                           \
+    .info       = &vmstate_info_buffer,                              \
+    .flags      = VMS_BUFFER | VMS_POINTER,                          \
+    .offset     = offsetof(_state, _field),                          \
+}
+
 /* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
  * and execute the vmsd on the temporary.  Note that we're working with
  * the whole of _state here, not a field within it.
-- 
2.51.0


