Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC4CFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmj-00061u-US; Wed, 22 Apr 2026 16:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmV-0004q7-Nr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmU-0003cM-9P
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so35770305e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888160; x=1777492960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=syv59dGc7uaXA2qNUSVza02efIGQ1JTml0069Q16s2Q=;
 b=evUPoRv6kpsSl2Bkqra8wo/SA1YLu8KpYDRoYqOBH7+kV2Q1HWsEG42PPOKYmAYy/6
 fcMxVug+qcnwukJ3nrVeFurH8fDv2SqLTZYj+B/L9NXmeyHTGUNI7gPb2Drh51ea2SO/
 iulcUv8RozCJPnlp7BUGAhfb3hBARe5YsHUcy0um+AdvKWJBQJM1JOmhv6lzw9ca0OMc
 pH2H0KzCUnoD22Tf35OmURsBz9fdekki/0Z8nODUPumtdUeiAscUsQJtYYpDy0nMCAPi
 bGLdOI6/O9V2KBBlxZaXTB5OYbL1PVD7pXgC7Q+JbeqG7Ns2T289VgBs/Z14y1BG2tTM
 ZEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888160; x=1777492960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=syv59dGc7uaXA2qNUSVza02efIGQ1JTml0069Q16s2Q=;
 b=REaXtCGSjVPVprlXW3gFNCx1WT5Nzr5yyL648GqAwxVaLGCfWQQr7eE61LuY4kZ/AV
 eCuJegt6H/3nZaBV/1JWyLRbDT+JNahXOmiRXF3yoDHAm1AWNPStqov3Szm42fpooe2d
 3/pDuv2EhlmmTktZuE1w7FusaFbCaqzU09YBro52toXisqSKCbvenipY0R/avEBbjOZB
 5AdmKjC2KQFqeN3rieXPRlzEh5P+nexC1WDL6Rw6XP7DQBTjkaQyN0BBe98DHv/EAFSR
 4VVUwWRUkvr45dX6/QkU5LvKcFUasLei29ZKir8YEbFObBwIoWOk61U3iO5784tAX2TJ
 qEQg==
X-Gm-Message-State: AOJu0YzbKymZj2yrS5eX7ibqt2Xrx0zRB+1AtpG43EtEnFLWOV9eFU1O
 /DUwVoi6Dqe3ewAbeeGPIG6wg0XBrZNyqTzihjW4T6cJcXy3+NzFUYXbCZAbRBKYCW/rW0hJOsN
 1Q97A/vg=
X-Gm-Gg: AeBDieuI/GEEO7oFSkAW0D76qMwJpJ8fCVozSWSQBwLnFA2S3cLVdYBPYbwDtHL2kxH
 rSxkos/P4JnhcIcxnmDJLSU/YXydkK5IkPT6/yrsqubqba/XsrOtlBKfuDYkCkimHn+wvfFb9KH
 JMlyjxgYw4tfKZydwuUEtFt03x12zNZpBeubCjg3Ie1JTqjyZBvxf8YFWJg/ZcdKIALYWUjjTet
 5F6DMuwaDgk8gpVftyHRKsiEf5CsiRCtWMyT+qdb1J7CnKV7awKOFgqVC5JkKc59e3tJIrEIX0I
 zybjAxGwOr4XJ4/wJUzk6kEZfgURpQlZ+5CdGve20g/a9GMxvfuWu5WuKRnQTgfv8K9uS/db/m+
 oPmzH1eJQIELlggzlM08M46/fsBkPRgz0jCVotHQdZOjNxy6rqVPumJzwST5fL2Vwj9Kjg2d+jm
 C+A+TNBjqyrha0CW+/NTr/RLaErkC5FghiGUo3D/i9l0ZRws5ERrfIVaKhiyfNbKQlZSHXae5SU
 mUlZtLYUSE=
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-488fb74a431mr389259195e9.8.1776888160295; 
 Wed, 22 Apr 2026 13:02:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm572576755e9.4.2026.04.22.13.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/48] hw/hyperv: remove duplicate include
Date: Wed, 22 Apr 2026 21:57:39 +0200
Message-ID: <20260422195746.88865-42-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

exec/target_page.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260420163452.327350-2-osama.abdelkader@gmail.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260420163844.332663-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/hyperv.c | 1 -
 hw/hyperv/vmbus.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a19f330e192..a854a4927a0 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -26,7 +26,6 @@
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
-#include "exec/target_page.h"
 
 struct SynICState {
     DeviceState parent_obj;
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 5388f4277f3..dcfce700052 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -21,7 +21,6 @@
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
 #include "system/kvm.h"
-#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
-- 
2.53.0


