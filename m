Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E067CF2593
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 18:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t03cz-0001IJ-Eq; Sun, 13 Oct 2024 14:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cx-0001Hi-9k
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cv-0002So-NL
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c805a0753so29309765ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728845256; x=1729450056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izfDyS+bmapVSfLYtSn4xLMYlKwDBm7aSJ/Y/fO7PVc=;
 b=xw+Aqhga1XmHQB4oBwwXzyZF+3mVHgEHq0KoZhlR5IcvF3ZJU5euEy1XmAUmLEjQ9J
 Yr6cvNyrtw/fczbLKyKUCdseJSkLbLERh6vu60Dh9XMSUvDog50XHo3U8NA9vpHTEexB
 To1aceN9agILl4ABYLU+P43CELDx7oHqWUiJZvQ17UnJXftVWhJ2lSkyFavsTs3/o9mE
 vKX1mGVP7Pd/UAIeoRcE3wB5KmpKe88mM/HMpv/ghXa+/5cjFXsgg9UnjFnP1D8eVX5+
 /4QKD6Ca9v/iKZQG2qdSEMDUTTJ+mjUYq/6aS+YHsTzOdaej1unZ4jjiJRAXPBD/T6lo
 Ss+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728845256; x=1729450056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izfDyS+bmapVSfLYtSn4xLMYlKwDBm7aSJ/Y/fO7PVc=;
 b=p4z18/bA+xvq+EHQtXmLyDJCh9ky4/jFRXAQZEYyaGCo8HRVSbTi4WRhHuRVpbDkjr
 LHj4I48DEX5mAjzR40j/OIycl57+nSIY9nIBMNKBQPHwUWDeqvyryFtRZzbD0nhSHAcQ
 MEaJiFllDyAFdaFVg4btYfgSRcJ4J1LdlPptCQxVRRhjDJvY3Kxx+Iu4oqA0WRGQB3hl
 Az8dEikY3jJkfLh+RJvuM0krrCP+Xn3/rMkcK8Zzjg3eknxIkPkX19dzyMEBvrcelx/3
 Q/u1mHuPVxSkkUepXoeijMqiCRZOEpTCrQGCwOVfyjlnBvUhOo5Ip7izQkkjnParV8Bj
 xbLQ==
X-Gm-Message-State: AOJu0YyypFsLx3Sa11E9ZOGkGpm5YjZ4KByjRY69NvtE2/QdfFI4jpJ5
 lhk7WldXLv2lvl+tGGj9jHRlAomMKN4pzdKHLJCpHTckYdOvpwbwv0JsnJgU1OEmRMyaT5lvJyC
 +
X-Google-Smtp-Source: AGHT+IGyUUNkT5YyYYHfSH0LiuRwYmDXbHX14viFmUjMqI3hlOf47FabMHo/AaQEn83bsci8kkjsmA==
X-Received: by 2002:a17:903:1d0:b0:20c:e262:2580 with SMTP id
 d9443c01a7336-20ce2622835mr28409195ad.44.1728845256268; 
 Sun, 13 Oct 2024 11:47:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c35522fsm52811805ad.296.2024.10.13.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 11:47:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/3] include/exec: Improve probe_access_full{,
 _mmu} documentation
Date: Sun, 13 Oct 2024 11:47:31 -0700
Message-ID: <20241013184733.1423747-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013184733.1423747-1-richard.henderson@linaro.org>
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 72240ef426..2e4c4cc4b4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -368,6 +368,13 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
  * The CPUTLBEntryFull structure returned via @pfull is transient
  * and must be consumed or copied immediately, before any further
  * access or changes to TLB @mmu_idx.
+ *
+ * This function will not fault if @nonfault is set, but will
+ * return TLB_INVALID_MASK if the page is not mapped, or is not
+ * accessible with @access_type.
+ *
+ * This function will return TLB_MMIO in order to force the access
+ * to be handled out-of-line if plugins wish to instrument the access.
  */
 int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
@@ -375,22 +382,14 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 
 /**
- * probe_access_mmu() - Like probe_access_full except cannot fault and
- * doesn't trigger instrumentation.
+ * probe_access_full_mmu:
+ * Like probe_access_full, except:
  *
- * @env: CPUArchState
- * @vaddr: virtual address to probe
- * @size: size of the probe
- * @access_type: read, write or execute permission
- * @mmu_idx: softmmu index
- * @phost: ptr to return value host address or NULL
- * @pfull: ptr to return value CPUTLBEntryFull structure or NULL
- *
- * The CPUTLBEntryFull structure returned via @pfull is transient
- * and must be consumed or copied immediately, before any further
- * access or changes to TLB @mmu_idx.
- *
- * Returns: TLB flags as per probe_access_flags()
+ * This function is intended to be used for page table accesses by
+ * the target mmu itself.  Since such page walking happens while
+ * handling another potential mmu fault, this function never raises
+ * exceptions (akin to @nonfault true for probe_access_full).
+ * Likewise this function does not trigger plugin instrumentation.
  */
 int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
-- 
2.43.0


