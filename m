Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F64ECD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOs-0002Ju-PS; Sat, 06 Jun 2026 01:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOk-0002J4-Fm
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOj-0008F5-68
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKv7uKXevO2mwOyC4qHpjh1F8G+LrZIXjRyqb5hTmN0=;
 b=NYfO3oWu4iOK8XfB09SRQB6ZlHSOJgnk3+BGAQvojrLmrBRY9kN8UteY/kIalg0CdRabqx
 SXBZSH7zdzoE81yBHP6v5lHtxfFb0Ofajp+WRUOgQhH5w0AgryO2eqViBVc+r2qkHlrLo0
 Vt8tetnP2YUR2B5BYVU6u0uLg45liKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-CpXiwxtAMkCbxi90cuXC_A-1; Sat,
 06 Jun 2026 01:16:38 -0400
X-MC-Unique: CpXiwxtAMkCbxi90cuXC_A-1
X-Mimecast-MFC-AGG-ID: CpXiwxtAMkCbxi90cuXC_A_1780722998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1718119560AA
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06742180049F; Sat,  6 Jun 2026 05:16:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:43 +0400
Subject: [GIT PULL v2 11/23] hw/core/machine: free shim_filename on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-11-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K+iwOApmpEnOaMk0KH5HYUgH1BE9LXcBH+NmGOZb1Go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0NrShnHLZg9ECTFbd6p6p95YrU0ZBUS0ml
 rgzyaE+/w+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5R51EACj8bxSuCSoTYvo/3FA8syGYoJd9u/J+uS+ebQF/lFmz6SBszMx60bBVcpxGfcJlX9bLv+
 riEZipk2IUKW+d06FfV5QG3xXpCP0+y6z5poHx/0zltonN4pDHQrT9iWlFWKCCwGQHdgYuQFRMo
 X2TgLbuUvmtJahMl6B85QflNVRwkeIymrScw0qLyNSCclkYdxfrgiM0Hjjk+kfuHB5fz0RVbeRL
 VvPdTUSV1nxq77JsGrtY4Y1bGhUzaOupHUdIBR1L0vsFmes8l7c5kH+Amm3Xx5Ot/XJyNQa2Nz6
 VfWkAwa1PcfAY/rcGEoO6ZxirYSOWuhwpWvXxBSqBpGAH5KNbGPJxav36FcamuFwdtksvJ78ALe
 747nlp6Jy4XDfJlQhDqT4ZI0kICvMPpZwo0HMqJa02hI2sU5yOJgOaElkLgKi3GVO5VwbISwC04
 zleR1nadaiF2gPhP90FP3L6Qyt1NFGGHg+M48kzRkN4bqERnTmHzasC+5mDVUJviq/AtVzcaJEY
 a28GN33o4VNLVWVvXxdWoQ0p8bnd8lXbkpkhzXqNcyngutP7Bu0vBRyY1gFKY846UoYuPFqWoZ1
 7oFgG3VYNybFiU8qu9LmVGWeWsiPkeEnT2wHOOufRiSqyZtUQ1+KzNLMe9TVcMZA+SqCZafjTIJ
 vSet+4JsdMsM17Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

machine_set_shim allocates shim_filename via g_strdup, but
machine_finalize did not free it.

Fixes: a5bd044b1579 ("x86/loader: add -shim option")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 17970b78b65..4d8b15d99e9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1286,6 +1286,7 @@ static void machine_finalize(Object *obj)
     MachineState *ms = MACHINE(obj);
 
     machine_free_boot_config(ms);
+    g_free(ms->shim_filename);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);

-- 
2.54.0


