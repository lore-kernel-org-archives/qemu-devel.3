Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702E0E83849
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEfq-0006Xx-Qq; Tue, 17 Feb 2026 01:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfo-0006W7-Qc
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:04 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfm-0004Sl-JH
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:04 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61H6Yfkg030238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Feb 2026 15:34:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bSiHTuQCrICDzXSIA/krahPmLWFzhEDHvBr6f5FOrak=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1771310083; v=1;
 b=oCEiATBViI/wGGLKoTHQi6p2usLaTNqTaK6DZGH9/M4f1iOTKkq8TUuz+D8RQkUB
 IDnmLnH5foHcwjYAV8VB3btq7kttyXoeOvt8kmIsCYZU8CH8ruyP7Lwf/U6C4LEd
 R1RFmb24tc82iB5BT3pPFPBKBMBbncbI6igZ6G3Khc2NeDpDAyEI62KClM9JDL2e
 2mM498CKyvsEWST94NQMYssOWkrE6Y+wJMcPYZDEi+X4JehFv2AxcM1TBK3Etk3q
 aI8mOoRnckFnSM6Zpf315yKH1UDmgvQwX/XK589LQC0qzcgfHWqfoSs88lOSs/A1
 +YWob0P6Spt2BvAs26O4+w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 17 Feb 2026 15:34:29 +0900
Subject: [PATCH 1/2] target/alpha: Reset CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-67ece
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

alpha_cpu_realizefn() did not properly call cpu_reset(), which
corrupted icount. Add the missing function call to fix icount.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/alpha/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1780db7d1e29..74281ebdb367 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
 }

-- 
2.53.0


