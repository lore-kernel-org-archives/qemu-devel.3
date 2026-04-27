Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F94FF8871
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRuF-0002eY-TM; Mon, 27 Apr 2026 15:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuE-0002dt-8n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuC-0000CF-Rk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwyJtVk4gZDCf3olCQ+pCOZAHvZnX9kcneYgWVf/Mnc=;
 b=Fi94aOOnBPSaAX4CDUreYOPoPj8LyELCLRGRRuAQG5kAl69Sg4Dt+dMSLdBMG3fLtErHN3
 6v4OeJBXfrvpoOHzSKfPTXT1l8AgK2IHJmz0OD1lXT4kxBFYxhSYSy1DAH44Tegzur56RS
 SNEjblxA1mtYThyltyItXU+IQ/VY91M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-2pOS_qvENMalQJvoj-_60A-1; Mon,
 27 Apr 2026 15:46:05 -0400
X-MC-Unique: 2pOS_qvENMalQJvoj-_60A-1
X-Mimecast-MFC-AGG-ID: 2pOS_qvENMalQJvoj-_60A_1777319165
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC89E19560AA; Mon, 27 Apr 2026 19:46:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63FCB3000C22; Mon, 27 Apr 2026 19:46:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:35 +0400
Subject: [PATCH 36/41] hw/ppc/spapr: free host_model and host_serial on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-36-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=C/waKYfI9NUHCunT5MhxZ5oKPP6LJDlxOCNQ5Vxmebg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wWCZfUqyAh/HfDSL4bKHf5p6cB93FirPV3c
 5ZGERybEECJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5XLKEACX7zjn61OcRIA2H5/B8KUfdG5mrN5mx/IgtzE/otKDw4wA3PPYVwBJEkjVnBPAkIrRbG8
 ZJKoeGs5j7cXr2AqcYRATuNaFz/NcNRweBUWiFWbCgoPKUhCRV1NROTSTfe6oEhICeuaoruiCQs
 CdeXVfbtz6l7lYp9Ip4/1LSwJT0xuhiMWVFpqHJXt0Wd1JxvJiiQbCNTFn2iRUsoXeqRxsDD7YT
 2Pl7gSxDfEVEjLJWhTumIYG/E/ocdzlwgmgKWWABfNhTClYaewTIjrlDTNl6xkK8bMblk9VsqGZ
 32MstI1ARCq3dsrcGA6jptorwsRxBIAPwb0Nz9iBjGWs5lGyNzMg384gt0fh/jzVXM+Y567JzPk
 1pPGF2631sVx9M9bmzIFo7HgsKH7vQ/tuuadibc7yeEj4sqMCotgR9YqV3FGlE10dfCl7QcxgIT
 Ty1Cdj3HJHdJZs/OJZBdaczLIKK5hEfppjhKBd7Cc/Z7USZb21UYMAtqbVljMIsfJZNP4hwcxYA
 VG7suV0NnvkXOFWnqKenui+EmbaW/VVoAMGj0o+KTpSIm2qYopW0UlAufQtlT9lFbY2zu2ZHq7A
 3JvO/eXzetZXw4/r9VOiRBQ1at4BtUNF/xEn6fr5+ZBnROppLDj8si++0FQqwPXWAAk04qc3Zen
 VO6QNHyXkaetEYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 428b491a7df..5c673bbf0dd 100644
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
2.53.0


