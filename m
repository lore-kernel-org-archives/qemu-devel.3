Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98470F5545A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7DB-0006yS-Jy; Wed, 25 Feb 2026 00:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DA-0006vy-6Z
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7D8-00046m-Kh
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4362197d174so3977885f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996401; x=1772601201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMzYp4SdJTMxtv4pWgjfW8jgSoBedAjoxT34KYE2b/k=;
 b=bvXmY0w/fG7tje+lJM5vRKVWIPWscRXydaj/34/wSvuiVRKuERnYtXOw07v0hvaraq
 gHwIVddL4fzDk+mx+qerCHr/aS7U1eN4HYwqCwzkZ6Lz5P4p+PO71kGThpdBRXJegGe3
 1xunbkvGf7cHzNhzWYlGkrkjqVkOjeUfrAEIoQyOjybSe49pMag6A5xj6eg/5TwngPd0
 wzPUmSP98P8e9BJmbxviuDNvT62k2p7h/1sIt6pPaTy89Lj+lFEiwBxZGsaTp6FJ8FqR
 uRFjL07fUEpnjvDiRjd7f2NUgFMriGdpGVLqNocJhAzxC3TVJRgzio1MVpASrsaFTlcw
 ARag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996401; x=1772601201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jMzYp4SdJTMxtv4pWgjfW8jgSoBedAjoxT34KYE2b/k=;
 b=D4Di/KNgDhV+3EEYpAEIbJPdINaGLGdeRIADtTMf2c8yep74DI1d/CM2eMtmFvoVaC
 65c/97F4B3FsSMp1NfxVn8E15AfeImtDSXS/0zY57ydH7H3f5tQLKGV92sehJkzUEPpP
 uqre6Dqst+qSQhYCwaFqfL4zNxf5dpLKHdAngnDKPHY34IGO6rggqxO26mMNgvRGmcyq
 SHK8XIgkMpf6LADlD1wnfmAqxCzPtXO9gUSYhy4QP1Usnvzpaljl/VOxcUqX4ODnzLGI
 62YiBGk+q2Hwz0zd9Uo2nMp6vd4TOIOEUlW4QJejOmqBpcRkHAJMuUwAu3LvPjWtzuUf
 z88Q==
X-Gm-Message-State: AOJu0Yxb3dz81zsaMg0qTe8kgC4w391luXDmBEUtHUr6X1YRMPoV5d7R
 vGBVTR9uoMsW2g2rcFHu+OnGiXR2EcOeoeTO7qZsCuSGXTd8p+/2oGw9cQq3123BVpqD3JYuyIy
 qQIDwObI=
X-Gm-Gg: ATEYQzyOtsKOhlGLIIOOGaF+iIoxbmB8AKk2I7fmHw+SPR7gPzIxvyvKbrFQ1uCVJyx
 5EB+ipCaNVNPPXQG0XIIeHexBfk2CWiAJd9TqWKZ4fLKj5W2KpWNTeOd7vUrD4roBWozTN7Xy0B
 hEWegI9V/1k1slcIofbGyZr9arOwiqdTc8b9DjRGh2Ry2l6eJD8bWJFlwQSFnqwAI1nIGbVl02u
 lI26OT/K/zs4ymWPWRfkgyG5jTjs+7qSkpfNaqnHFiCi8bVOReD7UxKvygjR+6+JHOzvOWjjK9l
 ZdA/7y6UkgJ2khjggtRPsm/8kZZBzzg8P2rY9Rr+8Pm0gTdmqGiN0+ds4foGhN12SiynDVvv1LF
 CmhYxdsnYtgIKVpvmk7y6GNaOfBnlEBgRIsU31j1HCKqJkTUQKEr4Sd6JL29SyN+lWpuzIM2Qhg
 9u1fObQ9e+SnZW5ImyLqkeIZge6enkbLq5bWfEm30w9JJFkeFA9mDckLvvgdb8UIZq0ZfKzeV14
 HnRiF3vqms=
X-Received: by 2002:a05:6000:604:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4396f181362mr27307810f8f.46.1771996400821; 
 Tue, 24 Feb 2026 21:13:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm30577525f8f.26.2026.02.24.21.13.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 2/5] accel/mshv: Forward-declare mshv_root_hvcall structure
Date: Wed, 25 Feb 2026 06:13:00 +0100
Message-ID: <20260225051303.91614-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
References: <20260225051303.91614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Forward-declare the target-specific mshv_root_hvcall structure
in order to keep 'system/mshv_int.h' target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/mshv_int.h | 5 ++---
 accel/mshv/mshv-all.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ad4d001c3cd..35386c422fa 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -96,9 +96,8 @@ void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
 
-#if defined COMPILING_PER_TARGET && defined CONFIG_MSHV_IS_POSSIBLE
-int mshv_hvcall(int fd, const struct mshv_root_hvcall *args);
-#endif
+typedef struct mshv_root_hvcall mshv_root_hvcall;
+int mshv_hvcall(int fd, const mshv_root_hvcall *args);
 
 /* memory */
 typedef struct MshvMemoryRegion {
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ddc4c18cba4..d4cc7f53715 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -381,7 +381,7 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
     }
 }
 
-int mshv_hvcall(int fd, const struct mshv_root_hvcall *args)
+int mshv_hvcall(int fd, const mshv_root_hvcall *args)
 {
     int ret = 0;
 
-- 
2.52.0


