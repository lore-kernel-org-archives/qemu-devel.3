Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F155C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjp-0001mS-18; Fri, 21 Mar 2025 10:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjS-0001TX-1s
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjK-0006t9-V1
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9v4xYv83/93huhw+1qdL6JfkGNmvx9FEyH6ioWHB57M=;
 b=N/9aMO7R53oRS7Mtd0KOupyy6Q1IAAKInT7gwhj4FdWLqnQZrtGmqxWSuu25v6rTftZqw5
 MaQwvjAmdGurjKAIzrwCCgTsVW/eEsAw7FAC+dtdrIVu6+ZLVBxezNi7GaXjcDAkF0LEU6
 JhBA44rDST6/+4bAnTd2SznsTsuIGq0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-Sl3gc_EyNsKO4Nw1fe_3vg-1; Fri,
 21 Mar 2025 10:52:11 -0400
X-MC-Unique: Sl3gc_EyNsKO4Nw1fe_3vg-1
X-Mimecast-MFC-AGG-ID: Sl3gc_EyNsKO4Nw1fe_3vg_1742568730
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EABC81800257; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2126619373C4; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD00E21E65DA; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/8] target/loongarch: Remove unnecessary temporary variable
 assignment
Date: Fri, 21 Mar 2025 15:51:57 +0100
Message-ID: <20250321145158.3896812-8-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Temporary variable ret is assigned at last line and return, it can
be removed and return directly.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250320032158.1762751-6-maobibo@loongson.cn>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/loongarch/tcg/tlb_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 646dbf59de..182881a237 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -543,7 +543,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           target_ulong level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong badvaddr, index, phys, ret;
+    target_ulong badvaddr, index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -571,8 +571,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
-    return ret;
+    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
-- 
2.48.1


