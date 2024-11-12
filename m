Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0DD597A4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxec-0001If-Oq; Tue, 12 Nov 2024 15:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeY-0001Hb-9y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeQ-0008TL-9k
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:21 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7f3e30a43f1so4177870a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443889; x=1732048689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ytqfxtz/gze+FwFK7EX85c9S/fEjNCvGmfsL22P/YbA=;
 b=e8zmBcewnXKz2nTlDlJw5ToNxpIMby2rf31oxgdIQptD2p1s15/JjmgPK5C9H1tIth
 Wkvhnq/OJLbsMCHpoqZiWIOr/Aw0QGvLntnTJKtqJ99cBGU1hpKZuuxGiC7Ile0GOmbb
 SFJDiZVtOxuu1neiMaQQO5GBRlSeeQO/Fi3wlhiD9cv7lPQ5E4B+pxgtGp/ov5fr9Oyr
 QU51VmMvj1dqXJkfvG6RzcH421VIWQNT8FVbqzUees/atVE1iGcjQhcj6hWF2DDlxQY5
 jXhq0lSdtdecj7tPsz8HWGIYOp/+HYhvrKKHLGkjDuZw1wREMuC6dT55ksAH3d4IftVJ
 Blrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443889; x=1732048689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ytqfxtz/gze+FwFK7EX85c9S/fEjNCvGmfsL22P/YbA=;
 b=M5vzL94cqPQM4wpvAR5pAG4GunQAIYN23uM5k0J/8mklaQyVbwf8wtdOpNvZvgXh6Z
 3F9DWveUN2Rf9ISxqf1OxgJfcGkg34JbyWLfJRqJ5L0re7rKd3ziDBkWKQkMgguz8pEe
 oAUBc60CkKBMI5+jj13VEHFyMl7no1pBSj55e+VMWK+MzDv+cJn4YRhvn6Y+T4b9VCHa
 AeOs30bTsMdVIa8t+No5G9RrX9nUwJsUc25Yqxi0qUalegAOKyfiSX9H0ThMWuYH3pdq
 K06RqSEe//206oDg6CKkMHjPHH/ElRubfJEqwsvh9B1RFJumMqKi2kVsr5zB9nXCnvKC
 cvnQ==
X-Gm-Message-State: AOJu0YyEpgen5DctNxoIMrBfGAK3Au3sIpkpLIAOt/TMQxLTtbtBNY/E
 4cfm++sJ49Zh5YDVbwx9Il2Sy+WoBHEXp56uU40cLcM7UAxmnRW5CivJBupKiZtQHB1GlonfFOz
 m
X-Google-Smtp-Source: AGHT+IHyd0s5OgtOnlH14ilGdOWMRh+3wrunmqSCHRD7Jy7gOgyIyJbFnSO8Es1iZerCbagdiXWZJQ==
X-Received: by 2002:a17:90b:3b47:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2e9b16fc9d0mr23850605a91.9.1731443888602; 
 Tue, 12 Nov 2024 12:38:08 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] linux-user/ppc: Reduce vdso alignment to 4k
Date: Tue, 12 Nov 2024 12:37:57 -0800
Message-ID: <20241112203757.804320-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/Makefile.vdso |   6 ++++--
 linux-user/ppc/vdso-32.so    | Bin 3020 -> 3020 bytes
 linux-user/ppc/vdso-64.so    | Bin 3896 -> 3896 bytes
 linux-user/ppc/vdso-64le.so  | Bin 3896 -> 3896 bytes
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
index 3ca3c6b83e..e2b8facbb5 100644
--- a/linux-user/ppc/Makefile.vdso
+++ b/linux-user/ppc/Makefile.vdso
@@ -6,9 +6,11 @@ VPATH += $(SUBDIR)
 all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so $(SUBDIR)/vdso-64le.so
 
 LDFLAGS32 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-32.ld \
-            -Wl,-h,linux-vdso32.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+            -Wl,-h,linux-vdso32.so.1 -Wl,--hash-style=both \
+	    -Wl,--build-id=sha1 -Wl,-z,max-page-size=4096
 LDFLAGS64 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-64.ld \
-            -Wl,-h,linux-vdso64.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+            -Wl,-h,linux-vdso64.so.1 -Wl,--hash-style=both \
+	    -Wl,--build-id=sha1 -Wl,-z,max-page-size=4096
 
 $(SUBDIR)/vdso-32.so: vdso.S vdso-32.ld vdso-asmoffset.h
 	$(CC) -o $@ $(LDFLAGS32) -m32 $<
diff --git a/linux-user/ppc/vdso-32.so b/linux-user/ppc/vdso-32.so
index b19baafb0d38e15b4a24def5c44a6d684714be45..0dc55e0dddff618b954dbb939335e99956daf64a 100755
GIT binary patch
delta 42
zcmV+_0M-A@7t9xsCINtvCrSbU5Rr3n6lq1YQP%3b&XBjV4sl%JXqmbIL$UbO3Tx34
A(f|Me

delta 42
xcmX>jenxzP8Y9C*buT6$SzIX6c=(tjbAN``v6&a|RP{JtzgDQRW#f-4TmVmR5>WsE

diff --git a/linux-user/ppc/vdso-64.so b/linux-user/ppc/vdso-64.so
index 913c831b3819fc09912b9b31f7fbe9ee311ae12f..ac1ab2582e4675979ffca3ce90dce17df579ab2a 100755
GIT binary patch
delta 38
wcmV+>0NMYz9=INmtpWfLk*~QFqejR%tq=sGFts+qF9Cf{%e>^#vwQ)(4KYR#WB>pF

delta 38
wcmV+>0NMYz9=INmtpWi6k*~QF<@TF=qRS8+wHM`Qf0n_&>m=ZivwQ)(4PLhrs{jB1

diff --git a/linux-user/ppc/vdso-64le.so b/linux-user/ppc/vdso-64le.so
index 258a03b807c4eca23547d978c16d1ad5ebd08bc5..424abb4290b7d3100e9dede2f3059483608ba703 100755
GIT binary patch
delta 38
wcmV+>0NMYz9=INmsR9rHk*mEFj|Vri9^_Z(nV0Nw;)4VN>*aZovwQ)(4Mvj@kpKVy

delta 38
wcmV+>0NMYz9=INmsR952k*mEF`$9%&`;)~jB!C2C?=itIoQ(CfvwQ)(4MbHDMgRZ+

-- 
2.43.0


