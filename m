Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3573ACCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbyq-0006Fe-FM; Wed, 05 Nov 2025 06:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyM-0005qQ-9V
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyI-0003Gp-DL
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaAaP1W1mqUaZG5PCtjNhroyXMv30+g98uX5rmpOrV0=;
 b=F1QyWidMdqqKRvz2BGdNxuEUDzT6VFB1rK90CCdMpbboY2doR0UoAnLO6TQQYnCk89wsO/
 NaRW2YehfO/kWecvXOgmN8LinWIofK0vAttlRO8a7b8p8HLTVqYNoIjIkz1HJUQfsyjlQy
 v9iNa7Pxa4W9pTF7E+Yi1/D1YVcptuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-5zXy3BC_N_qrfwirtoMu5Q-1; Wed,
 05 Nov 2025 06:46:33 -0500
X-MC-Unique: 5zXy3BC_N_qrfwirtoMu5Q-1
X-Mimecast-MFC-AGG-ID: 5zXy3BC_N_qrfwirtoMu5Q_1762343192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35D0F1800343; Wed,  5 Nov 2025 11:46:32 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BFB11800451; Wed,  5 Nov 2025 11:46:27 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 5/8] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Date: Wed,  5 Nov 2025 21:44:50 +1000
Message-ID: <20251105114453.2164073-6-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For one particular error (Error), we can't call error_setg() for twice.
Otherwise, the assert(*errp == NULL) will be triggered unexpectedly in
error_setv(). In ghes_record_cper_errors(), get_ghes_source_offsets()
can return a error initialized by error_setg(). Without bailing on
this error, it can call into the second error_setg() due to the
unexpected value from the read acknowledgement register.

Bail early in ghes_record_cper_errors() when error is received from
get_ghes_source_offsets() to avoid the exception.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 527b85c8d8..055e5d719a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -513,6 +513,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     } else {
         get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
                                 &cper_addr, &read_ack_register_addr, errp);
+        if (*errp) {
+            return;
+        }
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
-- 
2.51.0


