Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC5C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28Pj-0006SI-PC; Thu, 03 Sep 2026 10:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28Ph-0006Rv-3U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:27:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28Pf-0007Vc-0l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:27:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so2243553f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788445653; x=1789050453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kH0R/vlB14zVHtgArIapMfNMyNoyordtT7GRQXU/wbU=;
 b=YZp83DfT7EkmU9ZkXcnALsrVJd4FhDwVt1GAq3543DetWLhAySYZZHaDMSEkUSaZwz
 eTNpt2GJlsq7Ng2LJWiXEhOKnTvyvJlH6a4EfYJQzE68lZKv7bLZ0dCww42lfPeaCHps
 IKwYF7dr7caorgFNfNN+8RTNzrfGEnInDfS9KHWX41zrwNRRYyRLoNtU/9bTtETI5Ifi
 YEXlpy5TkSisfINU6iLgmjFtcH3L7OkX4umG0vSZJYS//b/QYSBglaUPTTF6Z3TEJRby
 QAfwyoq39/wictHaGRQOVylx2TyY8VPh15P1Xdtw4KLAI8iL4Ft/08Sl3z+QCc83UL0+
 tVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445653; x=1789050453;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kH0R/vlB14zVHtgArIapMfNMyNoyordtT7GRQXU/wbU=;
 b=fg4ApQRmfkw3l0Acv2COBrDqjvqZeGfI7thUZUFRoeZ8Pvn/hRdp9+5OycK+HB2C3a
 n9d9USHb20CWN7ovy4LjBn5s/dgJ0fuL2ehkqs6Vds3I59adJiZzRgdhhNOWNTe84Xrl
 VZTAsZ9UCXxQarGOYlIcyO7wfO5BSShUUEIhs+aJ2uyrcgnV2/JGlLtFCA0py9mvTHu1
 /lpROs6/eOAyijVhoMoxkT9sB+KyZJtmY28TlUluvAklHsgdrZ3Ie7UMbR5WsaBaXf6z
 tl+uqwptSVbnYAu0j1BaWZghpz1VHdax+Rii9r8nGbF7gzeGEzBbAjvYnCcqR79+3sAx
 mJOA==
X-Gm-Message-State: AFuF++kZ9Ds+hxZ6lVA+/MfTr7387bZylKtqGHNwgRR1Y1CCGZxLuNmq
 6cFnYkxWSvRo5W/RDS6wManWIy2iJ5+Hkk+zdxjNzPt4U+okazVKqOgD8eXJVLDU3nQ=
X-Gm-Gg: AYBFou0JxmSLNnA5HHBj+DtfWgSWwPsjMAlRw+FimI2hwFxVt+FIZxiVxRv438xj/zI
 Hxn2XwLya6fYCzlNS7xVIlbEV/qweaQHFo1cfhLhNVnSB8EqDHoAuL2g79x1c4hqRUdkBu3oUin
 11ii2nP/Tt0ANRFinTxtQrRLONFrzSQblVyJFpOf/tAEH4t7laN/FQy4MQPT6tqgqDaboo05X9t
 xGabvWehozGMKYRpzJP8aMmGrMABIBZAKa7VuGxl74DzW1TTvhvaaXGLiPBp5VrU8X0ERLK+rWW
 AzQ5o22UsXsBpdsyHaErUlO9F3j1gvU1K59YSikNiMsb3bNe2uS2Q59H0J/CxjClZaIwehy8GYG
 dCUwd0ppTPJkR/q9eh21vzrs1tubr1JoVnDr6v0HJH53LnpGmjL2OkVCxMFcU6J8JYD++CPJM0q
 VbqD+7NVn7si9tL0flckZw8FIHG+4INCsJUc5MiK6lTXVoH8nJhE3M7E7Xzq8n
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id
 ffacd0b85a97d-4847b6266a6mr25150324f8f.0.1788445652503; 
 Thu, 03 Sep 2026 07:27:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm14482768f8f.18.2026.09.03.07.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:27:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCE095F8FD;
 Thu, 03 Sep 2026 15:27:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] linux-user: madvise() on unmapped ranges should return
 ENOMEM
Date: Thu,  3 Sep 2026 15:27:20 +0100
Message-ID: <20260903142720.1467316-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas),
madvise() must validate that the requested range is currently mapped
and return -ENOMEM if any page in the range is unmapped.

Add a page_check_range(start, len, PAGE_VALID) check for valid advice
values before proceeding with the advice actions. In addition, extend the
tcg multiarch test linux-madvise.c to test this behaviour.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
AI-used-for: importing and validating test case
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
NOTE
  - again testing the minimal agents which did stop and say:

*(Note: Per user policy, git commits are never executed automatically by the agent. Please review the diff with `git diff` and commit the changes if you are satisfied.)*

  but non-the-less imported the test and wrote a crap patch which I
  have re-done dropping a load of unneeded verbosity.
---
 linux-user/mmap.c                         | 12 ++++++++++++
 tests/tcg/multiarch/linux/linux-madvise.c | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc0c2ee6c27..4066072ff45 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1307,6 +1307,16 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      * though.
      */
     mmap_lock();
+
+    /*
+     * Whatever advice if the pages are not currently mapped, or are
+     * outside the address space of the process.
+     */
+    if (!page_check_range(start, len, PAGE_VALID)) {
+        ret = -TARGET_ENOMEM;
+        goto unlock;
+    }
+
     switch (advice) {
     case MADV_NORMAL:
     case MADV_RANDOM:
@@ -1358,6 +1368,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
         ret = -EINVAL; /* not yet known advise */
         break;
     }
+
+ unlock:
     mmap_unlock();
 
     return ret;
diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiarch/linux/linux-madvise.c
index 539fb3b7726..ebb9666c919 100644
--- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <unistd.h>
@@ -63,10 +64,29 @@ static void test_file(void)
     assert(ret == 0);
 }
 
+static void test_unmapped(void)
+{
+    int pagesize = getpagesize();
+    void *page;
+    int ret;
+
+    page = mmap(NULL, pagesize, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+    assert(page != MAP_FAILED);
+
+    ret = munmap(page, pagesize);
+    assert(ret == 0);
+
+    errno = 0;
+    ret = madvise(page, pagesize, MADV_NORMAL);
+    assert(ret == -1);
+    assert(errno == ENOMEM);
+}
+
 int main(void)
 {
     test_anonymous();
     test_file();
+    test_unmapped();
 
     return EXIT_SUCCESS;
 }
-- 
2.47.3


