Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A6CC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEvE-0007U3-2y; Wed, 30 Jul 2025 18:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEup-0007IH-1y
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEun-00020P-8z
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23ffa7b3b30so3926485ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913087; x=1754517887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdL6k55SoWveZonLf24zRcrVCA47JiVVO5GLV1IfSFg=;
 b=F/56mBx4yGM1reWzr0I1aX1OPx0p4O/VmKRXW+/1Zp9Al1FprAG17T44b9nb6mNwEt
 GcpQecI338n1Kun6arlhKw1Z4/wQryp8lnsPaxv/FhFwIumw4z15beoRED0F3bX+/WIp
 qPUqc6KdOwgsJGdfDvt0H2i/TaL7XAW4KAczrOgqhFoL2j2c91P8AZGjNanxJ2ZBsfRt
 fCEgFFMTgaD7rHOZmxPLHddJegwZOexTSXGx9lWPK2ZLsmPSyUzzOLv6vyt/U6HkuMnD
 0Ya1frgh0FwhZ1snzcus88ZRTBERKYRrgBRzOtIO1hrkAhuYwo+uTGx3sruqqsmXHoCM
 DG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913087; x=1754517887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdL6k55SoWveZonLf24zRcrVCA47JiVVO5GLV1IfSFg=;
 b=Auy91M31/ftieR6e9qZihA44ilPM3K8V2lY4hseT6o56L8EYr6jW5pUzmHd8QHtlgu
 Ai2RRnFWrqLfD6brRpTRgzy1xKdmXMpfR28j28jDbHbEdbnjVvYFCeEmJVylT+DZAq9C
 40fLUwttExAySAySIa6hMZGJB1xjpXCqpGpr7YzYM5W5VkYLXwAmqguxaAOYlgjfl3Kz
 pvaVjylGM8jYm8OkEU+Jb4Ti6RVeuAJ7reV+6t8ePnWl4fWA3oeBSbA7gnRDzsJbUKnt
 S+nPf2gGhmgCARS12L1dOYmvD98m69VrewxCfxo7Bdz6WsmuivBC2ZbeXnO5Z7cZaKZl
 Ai4w==
X-Gm-Message-State: AOJu0YzdvZeaKYleqmNPoKRJBpchWSd5LhIsOzNYUHhR0K1N+CPb9ncV
 rcfmnKBNgpMLcDwOmXsqi+JUps82jwO+7VoYs3k7DA3TdWmHlN+ZAyIoFaURkmrVpJeojN/998a
 eRwpF
X-Gm-Gg: ASbGncsJ3b8O6Sigy++JIm2w7fEPlRt+479QcdJfGx36UUKAS0F8FK5yXHxpz7kqWJt
 WazRsF/lvtbjCO7YRmEGq63r/cU6ii/bD6fJot2+CUEc6iJT3dmyalSaEekxdfF4kVAXvqN/9zO
 gGH737xlioBOVQlOOPvmXyZACgsA26zHnkrNg+fnR+1lTmYN6rFEfTHvF5lv5/SbxV2jGu0erdg
 MajETEd2lNoxThZ3Ai0IgXehv3RmBpLgJ945D/HTOKyUKMXHnujJ63lBnvO17J0nngey3ku/EaA
 oBu+88ShSAsMtMY/Kep8aQRqNy2EwFWC4cb9hElaC/HQwhsozhecmcIfoaemS8onEwn5eJDU2KF
 lEJFStd2Lxdej927bn+ARUodeteC+qoPJ
X-Google-Smtp-Source: AGHT+IHaO2zchrNrjLawYAfnAt+w3/KvHgsmhkNd0gOoFQHzYRdaoagOyknHv8x8g4kLjwQ4nrTxYw==
X-Received: by 2002:a17:903:228b:b0:240:7753:3bff with SMTP id
 d9443c01a7336-24096afe547mr72641595ad.30.1753913087372; 
 Wed, 30 Jul 2025 15:04:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e757sm1095645ad.55.2025.07.30.15.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:04:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] migration: compile migration/ram.c once
Date: Wed, 30 Jul 2025 15:04:34 -0700
Message-ID: <20250730220435.1139101-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index 276da3be5a3..45e9445f97d 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -31,6 +31,7 @@ system_ss.add(files(
   'multifd-zero-page.c',
   'options.c',
   'postcopy-ram.c',
+  'ram.c',
   'savevm.c',
   'socket.c',
   'tls.c',
@@ -50,5 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('ram.c',
-                               'vfio.c'))
+                if_true: files('vfio.c'))
-- 
2.47.2


