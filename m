Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D8CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xZ-0001Pq-0J; Sat, 16 May 2026 04:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xW-0001CS-HD
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xU-0007rw-LV
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtjRG2uOcioJaCs6Yzten5VTU1iCUoC5q9GYq6iXtUY=;
 b=YKjHdjNC3KQNJgiTvv94heD6ZZkIV5mJwC45PSUJi/L7uIH4UsieNpRyTx46Mo35h8l/gL
 XT0OA/A42iBLHiE3gByon5NrfBrwcRpMGBeQsyHOyq+ot30mbp3MAgmE16Ncas933JHjkj
 COA82y4gxMG80qx3gjGSa2nSW3vTzMQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-dsSEk6yvNDOvUQ-fhZOUDA-1; Sat,
 16 May 2026 04:01:13 -0400
X-MC-Unique: dsSEk6yvNDOvUQ-fhZOUDA-1
X-Mimecast-MFC-AGG-ID: dsSEk6yvNDOvUQ-fhZOUDA_1778918473
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6D619560B1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5F1730002DC; Sat, 16 May 2026 08:01:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:19 +0400
Subject: [PATCH v3 20/24] hw/ppc/spapr: free host_model and host_serial on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-20-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q1VoyFbeNpTCUOW8T79Mb82LIAro7PYvZcbi1R2YJPk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPBBV/pW20MitgvNVtoQhgN/w/3jvG7yq3U
 nnQnyDVYhGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5YV0D/4nEdR6kqSTLK+kXS5Jz9RhAXeKbXVie9TDEao6WY2Z+VdftNKYa6b/aJ9fQqIRjv4OE8N
 mwlMeUdzYNiHyWZgbl1fFAl7daZf7jfo0Ml3MbDe/SCoNrcXXONdYV3nDBNCzEMapHRdDMonGss
 pLB/OBxxxt3c1SNDB5mUaQUIBxhai07IfoESQkRldRoL4/Izfwy3CTOHavhYfUDJNYWS0gqI2le
 ZzuVCC2fChNvMNqHvpOJUiT9YB30maDqDeSv8w+6fCA2ci0cwqcm4avzbgEugX78SwZ3F9CO4J4
 TW+GjXv6LFsS3GMYQhrtU8RzF/CpPu6mh7SvqTRv3wwR7mcW7mrYqtKg367+26qYP/aSsQuKNiJ
 foATeoY7Uc2l7AWQkhSDciumM0miCU/a+4hnI7TYvtqj+ztO4ycY1wtyW5tnGdZuo9bd0ZjUlBv
 y6bheZQ9rhoUL/5mBEFcPlfjUFDGqoqmcu+XrLUyRSS/mNn+JADs0vNshY+qUT57i6Xip5hA/PY
 GOrKNPRMYxW2sDJts1GhkyuhKwuUpgBFDMsXod5T5Gf7wOQ4gzab+OO+er2myPnP6ZlHnKW5qNN
 mfi7RzBOLjw0Si+mFZhPR2ClriMkGsPuXRzy8Vrk+VlSgheUby7GSo1eYlU3ybNGPgLFOUHMIJn
 cmF0q+IknZmPSyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The host_model and host_serial strings are allocated via g_strdup in
property setters but never freed when the machine is destroyed.

Fixes: 27461d69a0f ("ppc: add host-serial and host-model machine attributes (CVE-2019-8934)")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d40af312fae..4ec0a7d20b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3517,6 +3517,8 @@ static void spapr_machine_finalizefn(Object *obj)
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
     g_free(spapr->kvm_type);
+    g_free(spapr->host_model);
+    g_free(spapr->host_serial);
 }
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)

-- 
2.54.0


