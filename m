Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EADC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXIA5-00057b-Dq; Fri, 26 Jul 2024 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sXIA1-00055q-3r
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sXI9z-00030P-MT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721989610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTtG5rF+133Rl4upwhryPbqEnaoY3xhSO1uldM+GCd4=;
 b=J+MeluHe1kHZjerAgvo+iix6L5wnEZy5XVMFq2hy7Xs4++1VDiGAL8P8apjhAk+pjLgxjo
 DbCm96le2JRT5M/JgO7jd1aiZ5CGItxbzzX4se+96b8NTnmkYtWjE2SfeZu03MQRGVsX78
 hJ3cte4+w5N2zSD07Fgqx9TfMe8uByE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-oXXP9o2KN9iqlEYa341nkg-1; Fri,
 26 Jul 2024 06:26:48 -0400
X-MC-Unique: oXXP9o2KN9iqlEYa341nkg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9754E1944B2B
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 10:26:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42E201955F23; Fri, 26 Jul 2024 10:26:45 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 2/2] target/i386: Clean output of vmsr_read_thread_stat()
Date: Fri, 26 Jul 2024 12:26:32 +0200
Message-ID: <20240726102632.1324432-3-aharivel@redhat.com>
In-Reply-To: <20240726102632.1324432-1-aharivel@redhat.com>
References: <20240726102632.1324432-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix leaking memory of file handle in case of error
Erase unused "pid = -1"
Add clearer error_report

Should fix: CID 1558557

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 target/i386/kvm/vmsr_energy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index a1d78f2f2aee..7e064c5aef30 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -270,7 +270,7 @@ void vmsr_read_thread_stat(pid_t pid,
 
     FILE *file = fopen(path, "r");
     if (file == NULL) {
-        pid = -1;
+        error_report("Error opening %s", path_name);
         return;
     }
 
@@ -279,7 +279,8 @@ void vmsr_read_thread_stat(pid_t pid,
         " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
            utime, stime, cpu_id) != 3)
     {
-        pid = -1;
+        fclose(file);
+        error_report("Error fscanf did not report the right amount of items");
         return;
     }
 
-- 
2.45.2


