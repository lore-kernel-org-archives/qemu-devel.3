Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFA9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s6D-0000Zd-QS; Wed, 01 Oct 2025 04:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6C-0000ZF-69
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s5w-0005PE-CQ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e501a9034so21608645e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306906; x=1759911706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUDa5xnsT6LdBUx7EhioTD823LxktxWEacMY6wYwfL0=;
 b=wS6jbWkqK+orFiqUpEPvKIYf7Sbu8PlcNigg5guw/sycdxFiWmG7s10vuLq79yj6Pl
 9mxonH6YRH+37s8J15xtqeDSqeonG+xgN84jt9C6irhlkJMGPN2MgYRTGrhr7YArMuzm
 dUVOeb2bw9SjxNpnnOod90X24BKeAA9weYSHxyBnhrPFzSQSTGmw+ZlP4g2LhCWlripP
 ozkKHQc+3A5lN8rp+/dcJW2OKYiaGHYeyD7PGLSueo7utIAU8oWQmynyLjQTdpzwoCTi
 JR4glau7EEdbwh1f+iVzD0H6NlCnSZvg8QOxFX4tLnCKAYY6wnZgJJOx903vuL1d5zbK
 QSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306906; x=1759911706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUDa5xnsT6LdBUx7EhioTD823LxktxWEacMY6wYwfL0=;
 b=nE8l2usV4VrP1FkpS93fRlmi6kW0OJyJRZJ29cTD8XMpZDepi0l3id8Mai0A+EnNj/
 MnOyk3fOn0Tnhos1XZtQDpOE7GNyE1RVvUn+QFaPOHmb2ksQCh/Q65OCzi3jTtE+Seg0
 Ti117Dn30dzKb7bmfFM1Z4fou9lBRFtT7FGeKtIiCeUL2rveX6ICLHhAjbdVtO9RBdGQ
 M494CHCLc92/WYQr84L4G0cp+mbX9hSuvW4HddzwUy+s55PKCjzkXaNI8qIBBMN5q88e
 KSki6qIOc44bxZYpWGyuDOxqU2xppegoSS45xfkL1HR0987Cje0zUez2/OwFsfANsAgi
 UhLg==
X-Gm-Message-State: AOJu0YxBRlqoa7SJt1Fb5blRf/kW0Dl+AD/0/wfVu7kBLPwsQxpx376B
 qbotwSQeSfp7TuVeMALvAjX7sPEQJ7rB4DXUJPyGo7OVOWm51yK/EEf188MJ+02LmRracwMZolS
 XoRmR69sjLg==
X-Gm-Gg: ASbGncvP1xTqutkK8KgTP00QF36llh4DgwXowRqJ5O2WfyR9WF8bJonjSxJDuOOXAFu
 xB766BSnVhzlfck9I4ZwPWuhgIEijz2MmKeTxOfymPsqxyUAFbrwTbbwOfSq86rc/Udaqzb+roH
 bCTEX9oSmCb8jNUn+KH4RF7UaYY+OPJ4CZvpVayraKRMW2qfJ9LasZLGnxaGLDUBWkTwrwSTwAq
 IqoMwyvGo0bWh3M632NCMp2WDL1ijFw2YYVVOQ0FCmvysUHukIo7r3tAgK0aw82MBp5MtFUb0Fj
 e1uLsTr/0JC8hDe+9q5s/s7URWYlAqJeAE7BnxlxnWE7MutTfANl61FXwsulF11thq7GLIvfWd+
 cdiYyFzUr+pEWXbk2ARrAwwejiese3YrQpwGaVCQBit2Bv332Rri/vuDuuAi+j4kMAbDJQySM0F
 jJIfBCOhha7lC7Y3zWoGNG
X-Google-Smtp-Source: AGHT+IGupbg9/lAN7fK0YZ5iNSEbaJIxNUI7X13KRbrcfs3DgvFIGFl1v0k+/aPUDlPoG1Y+QWnAwA==
X-Received: by 2002:a05:600c:1f10:b0:46e:32f5:2d4b with SMTP id
 5b1f17b1804b1-46e6129588emr20005035e9.37.1759306905959; 
 Wed, 01 Oct 2025 01:21:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb1a3sm26551095f8f.10.2025.10.01.01.21.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:21:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 03/25] hw/s390x/s390-stattrib: Include missing
 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 10:21:03 +0200
Message-ID: <20251001082127.65741-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  hw/s390x/s390-stattrib-kvm.c: In function ‘kvm_s390_stattrib_set_stattr’:
  hw/s390x/s390-stattrib-kvm.c:89:57: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
     89 |     unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
        |                                                         ^~~~~~~~~~~~~~~~
        |                                                         TARGET_PAGE_BITS

Since "system/ram_addr.h" is actually not needed, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-stattrib-kvm.c | 2 +-
 hw/s390x/s390-stattrib.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index e1fee361dc3..73df1f600b9 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -10,13 +10,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/target_page.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory_mapping.h"
-#include "system/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 13a678a8037..aa185372914 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,12 +11,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "exec/target_page.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "cpu.h"
-- 
2.51.0


