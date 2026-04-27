Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E18FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLU8-0006Kq-1A; Mon, 27 Apr 2026 08:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOA-0008Hh-Km
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0005n2-HN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ad135063so93529745e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294114; x=1777898914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2kPC1nSjy09rWvg26KQH5UE7UfFjCOQkaqBSnSpqoXk=;
 b=rEWBbd92M4oDRyAehhLIliJfAg6/ycTM7TeoEkLduaD9Qc65Ip53dzaBgJIZxk/0Vr
 UsPb1d/xaYEkcJr4uRjGijbYZizElgUSnP2gCn4zpN3gnj7KkijOjZbK5DiJfQHpPdmp
 ooJgFzWu1XxTHaXIZHdKbE1fZ+HsrV9VQb5zI8qHWIr2oOngdN1qdqE7E5iRKqz4CRJc
 57prs1zcU7rn/J5k+fDCYcpzJbI/1mK82t66jggfFWpb5/hsln7Lx3V1VBb/KkwI1scG
 MCwu5YrwHvO0t9ZhiK87xm++rent7ebkc1yHpJpEjPo/T/W4jcYahoUVD9OZ42nLNKLv
 KO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294114; x=1777898914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2kPC1nSjy09rWvg26KQH5UE7UfFjCOQkaqBSnSpqoXk=;
 b=QLBk4o01v4dzG4awkIlvAmdKWXoLzqD+I9hhMEt5tmlBCTdmIUUPLFskl4d8nJkJEl
 SxeOLg/b53NfE/EuRB0YaqTGE4nXqJyNJPuCxJyNsjQlfhJubuFP44td86eTyxtioM/7
 jJT+TsRU4jI7OkbMDw5NdIxG+0Gj6YycMXKmGQvi/l6ZlfFXO1g1b+YhTxqmfEN+6tXB
 pfkine5D6jyVJjdxsl2bXHrieoA0bVp2P6jRVrWSy5AEcRocvQCJfwjrD2ljFUlVXbP/
 ygx7wkWJKeP5Pj1SaeguapUeJqdmH70LON85XRfEbODtuasea8Q7v3yD84sj9rbCyq5W
 Acdg==
X-Gm-Message-State: AOJu0YxSgXntb9HH9FaX7JVoAogZT727h7/xVOaUgPPKtZwMIDIHE4pU
 0lZVHRt02Xg/W9Ep0Exl0j/GrWX61nDr5ao4vrbnUsyZYR4EQQk8kypbl0k+Ea4/Hl2cGiVS2DH
 6YYiX
X-Gm-Gg: AeBDieudKKJ/PweYJ5HxiNr/ok/cx++1MKwLQW7KDyFq+JOVdYqdcWJFh04jNbfAhe+
 HbPN0wFc8i6QqnnMCj23rpsZGnfKrZ6bUnkXRdup1bZ5xscFcGM5XNwngxc967UMTb7gbt5aP5g
 S32NZhV/DXJyB4slolI0qnCCzXUdia49pmj/2bLZnrPhi2kXGo0Rgpu06MSDv5doolk+/j7pFu8
 lABPdLy3JW13tSSGByyCH7eRADttfRKu+Og8TC6e34qXhtt6gS91FugOPOsrZmVNP2KMC+pGuTL
 O8S3Z2mp1gbltp95wNFovsUh+lIXGLl22yV1rlPyIW7ppa9RQlW2dABrtYQlbqY5equ1shjmdki
 Ggjmn2SmkZgdCmhQOlMMm1IYlekv37ulgquNkxt9i9USPz/fhdXJrMTFr421i4ZXXikH7mkmqG/
 xxGqgQv133SIPJlH26EnAKHb1RL7lWJokE4lR3acltFdfFKCLLfWPkDyqNayb9W0rz3yH4Dlfx4
 YRnpNFr5G/SmpTUFL0d0I1Jre6LLL+68X3xyPjZuw==
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id
 5b1f17b1804b1-488fb785901mr653773505e9.22.1777294113658; 
 Mon, 27 Apr 2026 05:48:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/63] target/arm: make hvf use syndrome helpers for decode
Date: Mon, 27 Apr 2026 13:47:33 +0100
Message-ID: <20260427124738.966578-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260422125250.1303100-20-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 678afe5c8e..ef4c3671e9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.43.0


