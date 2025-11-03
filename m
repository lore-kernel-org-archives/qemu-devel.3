Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF329CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lc-00010a-HL; Mon, 03 Nov 2025 16:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lZ-0000zl-Fb
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lT-0005LV-HT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyG0wI0bDY1vvGlQuW62v1fRhYJS5Ll4JtOuqJX+Vkk=;
 b=D2ZAsZjmoYGQgXUrWsHvZ1BL8m0N/xTCZkwrSaBZynxKqKccuz0hVuzHEhpCB25KIMh5UF
 oN/6+8UngLGNRd1A7apyIkMYTp9dQ5+V5gKxCTn095krE+PVte0S3K4O/8mym2GLDn85dv
 uBLz9FMB44Hbrp0YuOruq4A4xDzFgHY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-hrhdRvgWP3WPuCZeHCBc1Q-1; Mon, 03 Nov 2025 16:06:54 -0500
X-MC-Unique: hrhdRvgWP3WPuCZeHCBc1Q-1
X-Mimecast-MFC-AGG-ID: hrhdRvgWP3WPuCZeHCBc1Q_1762204014
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-89eb8ee2a79so2526684485a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204013; x=1762808813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyG0wI0bDY1vvGlQuW62v1fRhYJS5Ll4JtOuqJX+Vkk=;
 b=ATPj/8y/zPVMmyHqSFoBh98IyO0p0a2ofBClaW8Ed5FrU+eUphcTq7nU5v5bmnjVD6
 hxFk1nQWhE5wsuWdKP+iuu2+tMU2oplHxmCKQ4JXcSarsQAZBB/Z9W1eJBpv0wAStZuW
 Ebw2z8W1uzNIHACBwBem6kfTXA0JuGGS5WeS2PE8/eSAKlPkNYl52mIsYDDntZi4Lslk
 7u++mf0za17s3Ej1NaRtagezPYi55NPb/d4CByZGnYon7Rj0vBlMxvDNeH8Y14hCp9+7
 rVtV3F3Tedk17sv/kqQUAcn/rHux4LYtybv/+KE81qQXLJh0gILekgJzsEC13z3QDn4U
 TAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204013; x=1762808813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyG0wI0bDY1vvGlQuW62v1fRhYJS5Ll4JtOuqJX+Vkk=;
 b=kqvE/3XWTnl9GeyVPho3pq/1X/3s9OVoQErJzB75MEVRC8JoVDs99nTwlLGufo0V5q
 OPkr4VioKggXdXwd6OteUixoKrnjDpgjxq+1vJHZHp4XeKSAO1Z+fEcLfmad0RSlrfen
 7+2aPlvXIm/BpOkIjJI+pLlbj5J6HF+COKSV+F0811Muas7OjWXJfi+kulxMMwu191cZ
 13tozryBLsB/Jb3sWg99632pw0wj4yp4GmrnJldTni69WCYZIRen/cVn1oHZYFjbZONW
 sdwofTL5NsxB4ZcodUi1K6rdJQOLWzCbpZuHhWYpl26aZhJ6Sxe69MpGD/l80ifvNiGe
 CzqA==
X-Gm-Message-State: AOJu0YzFvzxqGy1QfPk+h+8ULrB4XObZptIaztK9IE2Zpd/8YUXD5iT+
 U+2QLtVBLWyzXI3qwJk/Gina9y/cqN9NcMLJ8vDeb6GuCj4xLqM7MMVuxqMj/2Z6NGh5qDTfSHY
 WutcGN+sYxBkh6ySyPJYtZtm3XuLv3vIAXkYCTx/GQAX2RjE8YBdojKMfWcKj2UEXY+FX9xHiHv
 lFylPF3Hx0LGVBjAyuT3bngR2uAhpaxRVrZNAAuw==
X-Gm-Gg: ASbGncsY4p8byrAhQiNshZTJysm/BNH5UbPSzdXeWl+u66PLgFQib6TUd7zhv5HgKEN
 s2YhszylrOPklAuIEO5X+CpIgRsh28qpd3VlNVovDCDE77LL0fa5/F70ejuWfzs7Zo2vzdVvOpe
 X7HQqhNlmCm508gskv+eFvI4jjizXqFslJpn80cAyXatxllqM8E7LDQWENJ6nP0YBjp10BnUi8Y
 0lj2hKWPyOLbf0Wnww/TMPIDYrI5inpKdLLHoM1tX+IqQQ09dFVOhQvKcKzpWkDRJ0HOPhLcXuX
 hcVT2ySvvy3dd9zAXaHVXiLWUVExYYtL2nEZOg/u2AsD/UjYf8NNxsNF35de1G73
X-Received: by 2002:a05:620a:46a6:b0:89f:3bd5:cacd with SMTP id
 af79cd13be357-8ab9b3ac9e6mr1818198585a.74.1762204013372; 
 Mon, 03 Nov 2025 13:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEiJMKk2DepZah4I4g36y3jZr18Njsb1TY6CA8K0z01wNoCrtwL4oR7o5IHobS7CDKrECrnw==
X-Received: by 2002:a05:620a:46a6:b0:89f:3bd5:cacd with SMTP id
 af79cd13be357-8ab9b3ac9e6mr1818192485a.74.1762204012840; 
 Mon, 03 Nov 2025 13:06:52 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:52 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 17/36] migration: Don't free the reason after calling
 migrate_add_blocker
Date: Mon,  3 Nov 2025 16:06:06 -0500
Message-ID: <20251103210625.3689448-18-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

Function migrate_add_blocker will free the reason and set it to NULL
if failure is returned.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251024205532.19883-1-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/arm_gicv3_kvm.c | 1 -
 target/i386/sev.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 66b0dddfd4..6f311e37ef 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         error_setg(&kvm_nv_migration_blocker,
                    "Live migration disabled because KVM nested virt is enabled");
         if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
-            error_free(kvm_nv_migration_blocker);
             return;
         }
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1057b8ab2c..fd2dada013 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
     if (local_err) {
         error_report_err(local_err);
-        error_free(sev_mig_blocker);
         exit(1);
     }
 }
-- 
2.50.1


