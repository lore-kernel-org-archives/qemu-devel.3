Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94049C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiar-000408-4E; Mon, 10 Jun 2024 13:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiap-0003zZ-UP
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiao-00018a-Ed
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNOCRkpdS1XFHEXBD7ZT+t7uBOs/1pBKKTW/85bpa0E=;
 b=E9syhoGuj+HTm1fJeDOvF0CyzYmy+3dVhLSiCNsaird6UMo0+6pObekHFtm6FQ8BoGy97d
 ktJ0LPTMEHy/fsTZDweJ/5gE8C9BRMpxqnVsHqgdrMXZqlOo29xOu4wVkiUpa+HydmxdbK
 SOkJhVRi1abNAeZEhnucjyEKv4e9pWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-Fwxw84NLMb6_dvAhtLIgiQ-1; Mon,
 10 Jun 2024 13:13:56 -0400
X-MC-Unique: Fwxw84NLMb6_dvAhtLIgiQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38CDE1955D8E; Mon, 10 Jun 2024 17:13:55 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB7861955E80; Mon, 10 Jun 2024 17:13:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alex Williamson <alex.williamson@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 2/6] backends/tpm: Remove newline character in trace event
Date: Mon, 10 Jun 2024 13:13:11 -0400
Message-ID: <20240610171315.346143-3-stefanha@redhat.com>
In-Reply-To: <20240610171315.346143-1-stefanha@redhat.com>
References: <20240610171315.346143-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Split the 'tpm_util_show_buffer' event in two to avoid
using a newline character.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20240606103943.79116-2-philmd@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 backends/tpm/tpm_util.c   | 5 +++--
 backends/tpm/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 1856589c3b..cf138551df 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -339,10 +339,11 @@ void tpm_util_show_buffer(const unsigned char *buffer,
     size_t len, i;
     char *line_buffer, *p;
 
-    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER_CONTENT)) {
         return;
     }
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
+    trace_tpm_util_show_buffer_header(string, len);
 
     /*
      * allocate enough room for 3 chars per buffer entry plus a
@@ -356,7 +357,7 @@ void tpm_util_show_buffer(const unsigned char *buffer,
         }
         p += sprintf(p, "%.2X ", buffer[i]);
     }
-    trace_tpm_util_show_buffer(string, len, line_buffer);
+    trace_tpm_util_show_buffer_content(line_buffer);
 
     g_free(line_buffer);
 }
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
index 1ecef42a07..cb5cfa6510 100644
--- a/backends/tpm/trace-events
+++ b/backends/tpm/trace-events
@@ -10,7 +10,8 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
-tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
+tpm_util_show_buffer_header(const char *direction, size_t len) "direction: %s len: %zu"
+tpm_util_show_buffer_content(const char *buf) "%s"
 
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
-- 
2.45.1


