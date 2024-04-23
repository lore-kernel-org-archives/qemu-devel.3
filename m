Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7BBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHna-0006uw-Af; Tue, 23 Apr 2024 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnO-0005k4-OG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnM-0000O5-Ro
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOg9KtNLxd3u1DXDqJr03F3rYuVq7N0n2StxlG1HCJo=;
 b=YQY/P44Bby+ClQsLSoXyObDIGdjqxGwKbrIcXiHEUCyvBLw1q/iLk5IjtvlTUejv5Q5/5e
 rDGrxISYiOKt21EFoSXjmuuyfhVL/iBF1oON6NsSrMRuuLEpuCwMOGhYXknwk3n4x/Xtpe
 mHUZyEvDpG/zKL2t0VXc+m6vmvySt90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-QaltHlzIO9W27Wk5eGIt8g-1; Tue, 23 Apr 2024 11:10:53 -0400
X-MC-Unique: QaltHlzIO9W27Wk5eGIt8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E86E981F317;
 Tue, 23 Apr 2024 15:10:52 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B37152026D0A;
 Tue, 23 Apr 2024 15:10:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 60/63] target/i386/cpu: Merge the warning and error messages
 for AMD HT check
Date: Tue, 23 Apr 2024 17:09:48 +0200
Message-ID: <20240423150951.41600-61-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, the difference between warn_report_once() and
error_report_once() is the former has the "warning:" prefix, while the
latter does not have a similar level prefix.

At the meantime, considering that there is no error handling logic here,
and the purpose of error_report_once() is only to prompt the user with
an abnormal message, there is no need to use an error-level message here,
and instead we can just use a warning.

Therefore, downgrade the message in error_report_once() to warning, and
merge it into the previous warn_report_once().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240327103951.3853425-4-zhao1.liu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 28452983786..fd6af0d7632 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7611,9 +7611,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
         cs->nr_threads > 1) {
             warn_report_once("This family of AMD CPU doesn't support "
-                             "hyperthreading(%d).", cs->nr_threads);
-            error_report_once("Please configure -smp options properly"
-                              " or try enabling topoext feature.");
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", cs->nr_threads);
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.44.0



