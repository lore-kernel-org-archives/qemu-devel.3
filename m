Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41BCC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcr0m-000552-Mi; Wed, 21 Feb 2024 13:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcr0l-0004wF-Au
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcr0i-0000hW-Jm
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708538878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5N9kQmsXi811xBmhKN5vWVkLXcdGsB/xJVwLIj9WQEE=;
 b=htBoiaX7P+50qbS9vv2Go80CduXPKer8Y+bRRgKWyXPxgIHO5gcyTZMcge9bYMunCF1ty+
 EsiitXjZdteLcAk5bpZs/tagcfAsqjZbI8gVTOqdV+tInu5MH4r6c3LGJBTmc7XTMjDcqK
 QeBMrsoybApqPRlsKZtznUmTVWqJcyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-XSKf2OcqMxCBTUQbG2h32g-1; Wed, 21 Feb 2024 13:07:54 -0500
X-MC-Unique: XSKf2OcqMxCBTUQbG2h32g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DAA0887E41;
 Wed, 21 Feb 2024 18:07:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D23D2166B32;
 Wed, 21 Feb 2024 18:07:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Date: Wed, 21 Feb 2024 19:07:51 +0100
Message-ID: <20240221180751.190489-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

leon3.c currently fails to compile with some compilers when the -Wvla
option has been enabled:

 ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
 ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length array
  ‘offset_must_be_zero’ [-Werror=vla]
   153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
       |     ^~~~~~~~~
 cc1: all warnings being treated as errors

Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
here: DO_UPCAST is supposed to check that the second parameter is the
first entry of the struct that the first parameter indicates, but since
we use and index into the info[] array, this of course cannot work.

The intention here was likely rather to use the container_of() macro
instead, so switch the code accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/sparc/leon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 4873b59b6c..6aaa04cb19 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -150,7 +150,7 @@ static void leon3_cpu_reset(void *opaque)
 {
     struct CPUResetData *info = (struct CPUResetData *) opaque;
     int id = info->id;
-    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    ResetData *s = container_of(info, ResetData, info[id]);
     CPUState *cpu = CPU(s->info[id].cpu);
     CPUSPARCState *env = cpu_env(cpu);
 
-- 
2.43.2


