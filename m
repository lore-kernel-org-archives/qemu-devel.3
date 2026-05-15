Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D9CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxh-0002jb-DI; Fri, 15 May 2026 17:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxe-0002XF-1d
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxc-00035I-FN
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:45 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4de538f83so252584a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880043; x=1779484843;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=we2oIIQTPMntmYxBOpZLrJMRZTsa6cAka644OX43Zvw=;
 b=sv5Et9X6XS9z19Gk+Vo8n++MGP81NqqFffTTFpoNVTRXHj18OIX1tw9Jz5MfLIlOcI
 ckl1ZNvQzIF3EpCX4u8rWyqokx/T68om8XPCfR1RRJovkG81qJSLrxMemsmJJQ3/AwF4
 xEVHrjLqvO787/7FnF+tAtmyyxK2vZoKUTyXfvgiX4MmZr/QQB86irYZTQMmb00+QeFv
 x+t/6sXYYvaXmD346yJYSXiKLk/sA7TunZXYFdmoSoBXhvD40tSnEtm4SFmAwJfcsWyn
 TRcgCsHHsNFueb1wqPGdDUtUr5vnc0I+tFPmNV4GIV3HfQY6x5g0ZO0/vrqvv9V5vnmx
 Rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880043; x=1779484843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=we2oIIQTPMntmYxBOpZLrJMRZTsa6cAka644OX43Zvw=;
 b=fhfCieCMFiPHyEAB8IR9p08p2Yt8J7XqwhSnYBKD8/J8e0Mim9lUMxiPqvOHNiuHK5
 HQrjSiDtpZEmZaOFQ+fWpPXzDMSxL+wmVvUxH2uWJqJ3fVeep87ad4/eCRjzHn3Pp/re
 wLzbf9DA1oFrhmJutMqMv1+v0KdPGNcQxrDcqAmx6MXo3JoA45W9jty8YqVbMnWgtkWT
 LELIdoqzL5GW/UZsfGxl2Udyyg0Xrp00RdVYip6/RAFcZTHp5445FZ3Y+ScKdeqg6y82
 WtIMMMd37sUdyXGnjQSsnDw/rDiCn6UpKC48mSDzpckJv92lVnAVfQguG+M8JU5VpVzc
 QwpQ==
X-Gm-Message-State: AOJu0YwzfTBRyNE+WIeMBHLMt25iqW0UD4yojk7QaYc0Zo2K4cOTo39q
 lFbGL5atgzTKe3u0KiicbKy2YApq6H9jrTQi0Fmnz/rtv2b/incUUZuB6GlQfupOxvhMPuTzOQI
 vooiOpi4=
X-Gm-Gg: Acq92OG/oDPUYqq5aGzMJ/J2EzkqTmKkQaMN4bEzzYOwgg/JkOERJRAIHy/RuDLg49b
 Q+SX7xIoKjSCnSRvNjG/d/QlAUvCV6CvnmuafhUx3lNU94Eiqjp9UQvbzXbDSAsJns3VQRa7zCd
 zcyCVi4obyqgOr74YWlCZsXZ/GvuOD9MP027YqBzxLV0r/+BTrFHNGi3Bv61OqI8sQSVwH/IQXS
 5rY7UG4cHCLxL7uJULJAMkFaAL+muXj3210hwJozxBlDHULu7T6wsTOnAj67tTTfxYQAt9uTOkJ
 LuUtA8wxkCXEPgzZvDjfiykbRIPFTfnQjy0h+BNLkO9gBs/3UdGWnwUj9NMQ43ztCBAIGUc79fb
 1pehXiEDzn3Q6ZeEI356k8nr773IPYuWoBwG8f2eWjcbPET3XyLje9TadxBkVvEYpnjsOt6DE2Y
 rnyqqR4M3JlQ==
X-Received: by 2002:a05:6830:4704:b0:7d7:4ee9:c39a with SMTP id
 46e09a7af769-7e4ea031993mr3996876a34.4.1778880042828; 
 Fri, 15 May 2026 14:20:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:38 -0600
Subject: [PATCH 39/66] bsd-user: Fix cpu_copy to initialize new_cpu queues,
 not source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-39-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=zFG1nVMGVX8DcNWN3HmIzmpxd/HxOHBG0XiG4kbWLQs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43lnWGdW9vuxmFNKEotemhaDbSpVH+sxaZkn
 zmsywBdb/uJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AHVsD/42xjP/klfb6p2EJ7rVXsjad2HGw7KNi6v+RGzFPMtco2LaLPfCg08B1ntAONWxbF6r8vC
 OCm2gCKRH34DKKTltDiSI+HKtBd2o82GT1tq39cnWBBlMo0qXRNxX48cYNb3MT+wM0iZUO+7KCe
 qF03qLVzdCYYt9a/6Elp9+9ez1eUozi0E9Ul7512r9uRGFXT8EJEYroirhCqUNNCNlhLm76X82r
 RnbA83sga6YpKy0cHaZq0DIfI0qLvEZyHK/Voc2Fc8b3wpde8cQT0xhXR4rMKrAGk54u0446toM
 jtXIsL2OraVroJbOs3hTsWByN5EHS0tW+sO2fYHXYf6AsWh4NxEgzt4o0it9xzzOyS8L3Wd7BFJ
 SlSS5thpYdcy6vraESI4Sgny/AsHt8ruEnjiTYCdrKQZekNQ+A9q8qNFjFqeSE7KFkgJvogMAd+
 9LeAUXTQ5LbxlyaWvugfWEbT5jtod6FNpLNkwkfmN1zc+rRA9ahR63Lvm6JbIsJiQXmd00IV+BC
 LvGcgyIXzOa5mhepiyP3dgVxQaGdQ6IjxEJZdPVPs9l+LMGFGY/2PH4MpnfTSxEP2Vpu6VTVoP7
 H0I3BkIozcmw+0Gowonyre/zf7j532Uc3kWJ5p30+wtJEuhmB7QNaG9DosIjqYyfcA1FKcuYh+i
 7VH7vDoZIanP/rQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

QTAILQ_INIT was called on the source cpu's breakpoints and watchpoints
lists, destroying them before the QTAILQ_FOREACH loops could iterate
them. Fix to initialize new_cpu's lists instead, matching linux-user.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index a79ee52cc1..3c150b54cd 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -245,7 +245,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
      * Note: Once we support ptrace with hw-debug register access, make sure
      * BP_CPU break/watchpoints are handled correctly on clone.
      */
-    QTAILQ_INIT(&cpu->breakpoints);
+    QTAILQ_INIT(&new_cpu->breakpoints);
     QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
         cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
     }

-- 
2.52.0


