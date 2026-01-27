Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931DED2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCS-0003hP-5O; Tue, 27 Jan 2026 13:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBU-0002oB-Q9
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBS-0000ff-Pv
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9iG6ODV3fpVVvI/5k1Znn+pIB2Q05y7+ne9IRde4a4=;
 b=V47KiprH6RdbCiRCxGPisq2HDvMIt95Gp8hLO0/oygjU2483KgeiCV8DxYtNRR3gqZN/Tj
 k5op1jTEeNjMSRY1UZ8YiNvFh13Y+05lIfe2UhcZnLpnZxuGNWA1UBgN//j2FdY/CDxn2Q
 iRJRY7CglHJLSVTEgCfvwTHIDNK1WXU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-EUH2Tg8XN2ukH49Y-oHS2Q-1; Tue, 27 Jan 2026 13:53:00 -0500
X-MC-Unique: EUH2Tg8XN2ukH49Y-oHS2Q-1
X-Mimecast-MFC-AGG-ID: EUH2Tg8XN2ukH49Y-oHS2Q_1769539980
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2e9e09e6so281716096d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539980; x=1770144780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9iG6ODV3fpVVvI/5k1Znn+pIB2Q05y7+ne9IRde4a4=;
 b=uFPHpqPBmc1pgbGlE2OHcgif9hh3rgM6MER2dshlThkwyScH61CJZP6raxiVqCAKgt
 5249NZj5vFSOtESMpJiRmWvOiC1MFx6KWoLa+V0zBBtlVrUHoQ7B9TSXRLotw81/JfE1
 vOtg4vfklD2I4zR+ZWsHNaonLejgddHeVXf95+7eEFaVYflZPZZv8Z1qW5rvnmjussCx
 2moBgru+YWXzrBirwWjZMUOOcRzakoVd2ofH5vP7ur6+Gvnm8flfhp2z9fiSagu24ZUK
 oJnVOlBJPFzHWUo6XcbLYN2f0AGmYdHSZhjNj8sljxlSJhjwHWFdqz8WJNXY8hQFDXfZ
 KqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539980; x=1770144780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k9iG6ODV3fpVVvI/5k1Znn+pIB2Q05y7+ne9IRde4a4=;
 b=h7ooeCjej6q5ueZbt6rWOAWuRKLrF2bS1AJ9mYj7JRBNtgU05n8FYg1axn1DI22MNo
 o8b+N6YiS5ifL6Ae+r1nzkWk+svDH7BLPJ/q0fJm/aqoSfZalAEujBAx3WCLXUWQeZj/
 3kyD4RccJBBExUUmF0XV68vgR+yiFmCnScLibn5O9tQ/lkKTSfQW8ZlvT515REqsCAYV
 uSv0E9quAZithnLBLGD2mKxyCbr1J0XjYwB8O/lH58ATinWuslvYmtkeDIz4iivay7aO
 qAKguW35mtrnFNGzmyfFFsyIhAbDbTgyyIXAd7FvhXQS9hVlae8d/WBxBq2CBi+5t6ES
 4KKg==
X-Gm-Message-State: AOJu0YzvgzY2OBUkihd3aDtrSTOa3sxLA5s09pFJgxmS0r5uN3UAsdBt
 M40Pe0PwkMerqvWyT81EWDsXHDTgJ2aC1JgzeCTx9FydKGtzLwtexVMJW1V6VdZJkQVi8wAdykk
 xsweJ42GCNyyRz8Dx4ZT6Qw0Bk6LJ4wqDBgFXBjQAyqyB8+c9oV38v2o9eLll5Sh3/8UAlkhkM+
 5RY3JHQoZV5gi4h+nwleT61XHxgHpnqFOgtihBUg==
X-Gm-Gg: AZuq6aJZTbaUK7kX8BbQVQp3e1tYsg+67hKQ3cGUI5Qn+9rgR8NocnC+fnovlb/JnoU
 k6QTDxIbOh/N4RKCeKPCSlx49B+kZAop9y9zGmGSsresuZsXc4tgETsA88JPPBDcAZnOqZWw4W0
 n09pRvm8U1cr+SHZFfGCqd/svuNLzlgd6nZR/7cw5qjCbw+0IDfCF8W4wDTD8iJKUTfVKxD3BzD
 rKm9+VYtTTSh67R5TpqH9JYeHE72mDTAyhXB8YJEjtRTA3vm4W8Lx7rur9U7C6vzw8UEF7voa7f
 iFDQ1KiJsjDBhFeRN9ga9EK5BQL7MrQE9eFufXLd4d7lZsYtpEcxkOJJQN0+gtZH2PhBy32/N1X
 C
X-Received: by 2002:a05:6214:20ea:b0:894:6f51:fc2f with SMTP id
 6a1803df08f44-894cc8fe2dcmr39806016d6.47.1769539979932; 
 Tue, 27 Jan 2026 10:52:59 -0800 (PST)
X-Received: by 2002:a05:6214:20ea:b0:894:6f51:fc2f with SMTP id
 6a1803df08f44-894cc8fe2dcmr39805516d6.47.1769539979342; 
 Tue, 27 Jan 2026 10:52:59 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:52:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 02/24] migration: Use qemu_savevm_send_header() in
 qemu_save_device_state()
Date: Tue, 27 Jan 2026 13:52:32 -0500
Message-ID: <20260127185254.3954634-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reduces duplication of the other path where we also send the same header.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e26656cca3..64bf445c98 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1872,8 +1872,7 @@ int qemu_save_device_state(QEMUFile *f)
     SaveStateEntry *se;
 
     if (!migration_in_colo_state()) {
-        qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
-        qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+        qemu_savevm_send_header(f);
     }
     cpu_synchronize_all_states();
 
-- 
2.50.1


