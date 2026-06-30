Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452EDC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaBa-0002pn-0L; Tue, 30 Jun 2026 11:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBW-0002kp-TO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBV-0000DZ-Kb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Js0Gz5Z/33k/ANDJ3L6b1mCuHgq6vQpeGmYXZx9RY/Q=;
 b=WYe+4be4iHlqtlq2NZuOdT4pEy7lz05eK8mzz5QA7NQMTsIyzqw9wJeHC+wmaB2FWeXxMi
 oGyANCjUaj9g96fNErKwdw81VZUXE43iSLDm5JHJ7CowI7J2XfDHBuaf2BPkqSFD2dfYmi
 TCJ2iR8lJQQdPiL3IsboQZ+ncAwjggQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-7xeP0w61MHW8QGuHqKuJoQ-1; Tue,
 30 Jun 2026 11:15:34 -0400
X-MC-Unique: 7xeP0w61MHW8QGuHqKuJoQ-1
X-Mimecast-MFC-AGG-ID: 7xeP0w61MHW8QGuHqKuJoQ_1782832533
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370631955F76
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1ECC1955F76; Tue, 30 Jun 2026 15:15:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:23 +0400
Subject: [GIT PULL 8/8] dump: fix misleading VMCOREINFO phys_base parse error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-8-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zcMisxcoNdoz9UHmtNVxTvT1WgNY1i5pj5kDCpWZlUM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91ngXoqRlY489fvaOAyhVHoXggKG3IQNrtpG
 kO43NtIoe2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5dMXD/9B11UtyKKdmc0OAPevUEo8pQ4q5/gGe26aLxZVbCkDOQfsl0u0JI0Kl2tbXYYaFY2Z7hY
 v5TTJ3XqLclgo+BroZL4Tc/0n4nkHj41wvu7tWFdLApGkpoOVBLG7y4j7n5aRVRu9yroD1sbclL
 c4kCFsxciE2TECRvXOMB5kD8IjYChN7EX55UAqbVgX2Ag9HLAcNzx9XIZ09lnn3Gyv1gJ1UDxhz
 OPgF3m3gB2c6xElBojBej/Q8uM7+6fuiK0rsXQe/MxVajN2RRcmpjRNSfboQQRTecgqfyLnb0gy
 wnLgHf5DT7Azhakc9BJcoK4emDpOL3hUONgDI6YiNN//VjNrBOjvHFWuEgDMK1kOQP42TOAwCrE
 yP4FNL6ZpYTRn1Ge2wR/WfyRHERLZdt3En7z6rF4Nj5uEn3K/L8Tm+IcaZSjWFGdfCV6Q2DHruQ
 PPwKhQmg+S9VQy2oSusJtT25ZAg06LYUsUOTM+JT90ZZTqUC2Y5u/zY9J5hpb7pjsorJDRxhMCR
 ftpTdNuL8VTRa8PsmkzkEL5WfiZKbkyyJMwcfGRXMPoK/Bnm6cZ1hH/M4qrloBjviMjgGYQQmmr
 DMpoWxCicvlHWIO24stv0376nSq8bdR4xxPeWAn0uzjSG8uMmifRSAq8y/caXnrFp6I188TczJk
 ppj3v00biHl9oGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: yujun <yujun@kylinos.cn>

When qemu_strtou64() fails on the value after NUMBER(phys_base)= or
NUMBER(PHYS_OFFSET)=, report a parse failure and include the malformed
value.  The previous message suggested the field name itself could not
be read.

Fixes: d9feb51772 ("dump: update phys_base header field based on VMCOREINFO content")
Signed-off-by: yujun <yujun@kylinos.cn>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260629114646.288664-1-yujun@kylinos.cn>
---
 dump/dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index 7fa2d6f788c..52be7258a5d 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1772,7 +1772,8 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
         if (prefix && g_str_has_prefix(lines[i], prefix)) {
             if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
                               &phys_base) < 0) {
-                warn_report("Failed to read %s", prefix);
+                warn_report("failed to parse %s in VMCOREINFO: '%s'",
+                            prefix, lines[i] + strlen(prefix));
             } else {
                 s->dump_info.phys_base = phys_base;
             }

-- 
2.54.0


