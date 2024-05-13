Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD83C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WWk-0005Qp-VS; Mon, 13 May 2024 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WWi-0005QX-P1
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WWh-0000Ms-Ff
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715609978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxzpaTuDppEArVtObjCeOjVZ9ClwCDWv5x0F3/0rMHw=;
 b=NQ6BgW9Mgv/mCZvHpDUztBerqjk5PFtpxfJ/0YaBxlBDWvL6fY3LGXpUQk7b3IKo+ZHZ0Z
 Tm2KbY1sieXwAkns/uyusJOgAB/r4bd6jzg1YtY3RycJJnXFt51st+/+6V/aNfMLzXMNI0
 T4hedWMe7NBoZT/ijjV567DtvAPn4Bo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-9oTRpFoDP9qL_tfutDjMfw-1; Mon, 13 May 2024 10:18:14 -0400
X-MC-Unique: 9oTRpFoDP9qL_tfutDjMfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCF62101A52C;
 Mon, 13 May 2024 14:17:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ADFD491032;
 Mon, 13 May 2024 14:17:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6734F21E5E76; Mon, 13 May 2024 16:17:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
Subject: [PATCH 4/6] cpus: Improve error messages on memsave,
 pmemsave write error
Date: Mon, 13 May 2024 16:17:01 +0200
Message-ID: <20240513141703.549874-5-armbru@redhat.com>
In-Reply-To: <20240513141703.549874-1-armbru@redhat.com>
References: <20240513141703.549874-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qmp_memsave() and qmp_pmemsave() report fwrite() error as

    An IO error has occurred

Improve this to

    writing memory to '<filename>' failed

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 system/cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 68d161d96b..f8fa78f33d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -813,7 +813,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
             goto exit;
         }
         if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "writing memory to '%s' failed",
+                       filename);
             goto exit;
         }
         addr += l;
@@ -843,7 +844,8 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
             l = size;
         cpu_physical_memory_read(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "writing memory to '%s' failed",
+                       filename);
             goto exit;
         }
         addr += l;
-- 
2.45.0


