Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974B5FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdw-0001Kd-IR; Mon, 04 May 2026 07:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdm-0001Ag-WB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdl-0001Tq-MP
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V93smpOYjPMFE/CXbcn7oVoksJ5mZfm+za0KRUBYHRo=;
 b=EGgOEaQ9UQ0ZBUGWbcNkEUImFEjzLnJVFGZsFeU+M+p/3orVNJogWXhVWlBe1E7Igr842s
 4W5ju4jSJpp/cvh7W7f4mLUVnsJ5GRzsr4wpE5jn+thg2ip/OXK7OeYZ1EQwh9SDJp/RgW
 G6l091FG+M3ntt67KJfL7DD/+lzMjwM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-4O1IajnlN4CIb2kBpj64_Q-1; Mon,
 04 May 2026 07:39:07 -0400
X-MC-Unique: 4O1IajnlN4CIb2kBpj64_Q-1
X-Mimecast-MFC-AGG-ID: 4O1IajnlN4CIb2kBpj64_Q_1777894747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFA1219560BD
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A295330001A1; Mon,  4 May 2026 11:39:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:28 +0400
Subject: [PATCH v2 40/46] hw/ppc/spapr: free host_model and host_serial on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-40-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+InROhAu3uVVe3JZYaKX/PVJJdZL4PD8YW4nWEaRCIQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuNisafQD+IpMgPq/5zWIjKRuNnT4+lMIyv
 bcbFpFQXPSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5bflD/9QsCN8C/EJbDSqqXDfo9Qq65YylgF+W73UuDLEonDYXC90J+0fN3+Efclya/v79HrpICq
 5FY/LcFHLFl3uaomfi5/PNddOZa//E7iSr0UmU6FfPLA28zEDbtxMipVd9u7zds+CA6bJa/WYsg
 AOP51jk0KwL4EJbv8/3AR/5S7NAlEVULXEXOss1f7NkMkzXzdd1JXtX761iEDAjeV7/LIcqEExS
 RJ0s+uyK5IAIdk6V3BxUHFj/BXNnEwx40gVwBfvmYD1Jg4on8xZqnRKismm5DFrLc4z2yxOVPnJ
 kEChtNt0HDeCFIsy9/7ZLKFYf9MzXZcTO6urMXX/r197t1eS+k8jLRz0Rn5Cw/nqiVYX1wzLpUL
 pTClf6lpw4dn34/VPyVcLAGFR/12pdbAp1rg9z+43mWID4qk7b/oAxCdTf2ezududh4/Qi5+j+9
 dAiJnDum9sWPxfcfghxO+lSVTuNQHdPKKmepxt0fBdCVHUFewyLtG2ra3Jq+ThNunz66dAjMeoR
 TphTfplGnTvdSmZMoeNrzPMItR31iSN9N9BfX5eIS2Hcd7zWd79MGtFjJQnMSfxwAlDhPkvjKSz
 RhbNTPv/mcuxHEk7MZNqHmIziOJ/wCCRXNIn20auVzFl5qPVMdaGwfjugvtQsSVjQc0gFDrMQvD
 fVTZS4yIocn5P/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
2.54.0


