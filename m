Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21127C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Ay-0003gb-QM; Fri, 11 Sep 2026 10:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AX-0003UM-5m
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AT-00056F-SX
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so8302675e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789136632; x=1789741432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U1mIQLiwrkCzh5A8cu6QdkDKni7h+rt/7QFQQbiOtwE=;
 b=IkKHhXZCdb7IfxrbGls/5GbeYd+zlpvKF+hqTRsHhNvc2gOGqDgLeUiyc4j4cQYDGm
 htMD9aSOKzm0csdZpF98bktHDkw9c5z0s9JUDfh7cQxtlZNLJYZYxB22CjahoXDQpYKl
 2QqvQsOD9M5OoN2934fl3KEvKJzTxGrl3W77mbc6jIFWhFO1/9Jik3XppSvveQea6MM4
 yyhXcfOpS41JtY3CiOXMr/rzPLecsg8x1ZPqJW+sb7YsA6Ph6oBPjqHOnLRVfMMBhP4Q
 kOM88ZicKhcs7L9z6UapBMUD5Rr9fj79MePLmfy882BEii5eyvXaFvDrYlseotX03WUn
 nRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136632; x=1789741432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U1mIQLiwrkCzh5A8cu6QdkDKni7h+rt/7QFQQbiOtwE=;
 b=HvVXg66Haiv1Sj9E37HICNr9P4sbLSPex9nGoOZG3eN9nILZKRlD07c8ROr0EpslVM
 WvBMkr1EFzV+K5epUa/V8BOZ7f0joMFlhx98W+YAhKi0o+zgb/L7l+H/F9fVBkjUfPaY
 Ytx73ngoimqIo6PQx238jb1dHg9dlTvnFzK9LkdrKoNbVsFCvSbyUp/FrrECmRHUrkxe
 cs0omIbY5RM6r05KT0EFZAYqwTIcxpfZi3LuUf+vwEO/fahePAkfmxkH1qZN+9xhrMTR
 ViTrQBCdj4szl91MVOJ1EczTMc5DgSAqi310ALw0km+ip67PJfTmEzjfFpBmA3nJjhfv
 EjBg==
X-Gm-Message-State: AFuF++kVP/6tMTOhyLBkP6Q/4j1GzqUR79VyvfvmE2qPqHGSW9kYowF2
 eCq9ABnk2M+i3Ug2xwp/ru91vLyamprOADw7wF4Sov88dougJxz60ANZtRcdarie7iHH9dLSahZ
 348+z
X-Gm-Gg: AYBFou0TQNOol1kpq08kUPkBQpw1nMY7lMtyw46IZ3W4vSoZmrI+eV5UQuYmgXPxpVK
 lrZ4RLUbZvTP2VNKyt4+8tIaA+xtQ0y9OwSXoyBYUfQQ5BjknE9B/saAYMwxZ53W3S65bm6tOnJ
 a314zROT8/XcVKZM9w8jX7j5c+uz7dsYICVxtgT8u5ygBI4UzmxcVWJBNhHQTX0RBxuzN54TOUf
 EOcPsq7avcDBgraNCF+RkpkrRjjLchOmQEbT1dmQHHJuNYznUNjVVE4gAFNx7NSdJ0u6bHMMlOl
 D2ae7cLAgS7/OOGnWDrpb0fNg1QYo0xfNbTJSWXP+lUYSQCMql7NVqVk2eKSZGeOCVVG5eHhx85
 S7eBwYVmFDVe6KUy9YLW2Adm+0M04LEhKi+FYlAMcpz+qrdK0jp8UWbjOiXyBT+hQN/CD8gBb61
 PyubZNw0Pywaj1uydjZXVnW1H005NHpZUEvQTLd8Mkqr3g/8Qybly/mebH0H+CfsX6AEc=
X-Received: by 2002:a05:600c:a016:b0:49c:ffe3:2b3f with SMTP id
 5b1f17b1804b1-49e619a0458mr53983135e9.3.1789136632358; 
 Fri, 11 Sep 2026 07:23:52 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a007:bd26:918e:c58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm6398448f8f.20.2026.09.11.07.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:23:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 2/2] target/i386: defer the Hyper-V SynIC post_load
Date: Fri, 11 Sep 2026 16:23:45 +0200
Message-ID: <20260911142345.3999518-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

From: Denis V. Lunev <den@openvz.org>

hyperv_synic_post_load() maps the SynIC message and event pages, and a
guest which has programmed the SynIC carries the subsection on every
vCPU, so restoring one rebuilds the flatview per vCPU rather than once.

The hook cannot fail and does not read guest memory, so it can run with
the rest of the deferred hooks once the stream has been consumed. The
saving scales with vCPU count.

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 target/i386/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8d69d7e25e..eae74e33de 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -873,6 +873,7 @@ static const VMStateDescription vmstate_msr_hyperv_synic = {
     .minimum_version_id = 1,
     .needed = hyperv_synic_enable_needed,
     .post_load = hyperv_synic_post_load,
+    .post_load_deferrable = true,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
-- 
2.53.0


