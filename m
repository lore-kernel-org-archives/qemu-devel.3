Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDC5CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkY-0007XT-JL; Fri, 05 Jun 2026 11:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkU-0007IS-PC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkS-0006eX-V9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzKJ/IpdkG01bM1txdqjhoLFTRAUk3+pG2IUFauAHiA=;
 b=Kw0CKeGmtHG7V8wTJ8Aomhv6sQRVcBRGbKrDDIv7Qq9k/uW82FZiMwb7tfO2eiCtDqAwCw
 12rYs4thrmTrH7eKD47KR/hg40Z/3ewUyvEBua6MmtsWM/cm03r7N2LpL4pfAVIF45z1Bt
 ktNewyVRCJ2+eQaN2WmxpvUy0as7nbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-kfrPdyUuPxOH0_SCBZ3Djg-1; Fri,
 05 Jun 2026 11:46:10 -0400
X-MC-Unique: kfrPdyUuPxOH0_SCBZ3Djg-1
X-Mimecast-MFC-AGG-ID: kfrPdyUuPxOH0_SCBZ3Djg_1780674370
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1301B19560BB
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:46:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC3743000233; Fri,  5 Jun 2026 15:46:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:39 +0400
Subject: [GIT PULL 19/23] hw/ppc/spapr: free host_model and host_serial on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-19-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EFDae8u7ennK5lGTEip5Z4TCCmPwbTBDCnezXm8A95s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VHf6B25R5xxY0+GkkSvLOUbAe5GeyT8/gz
 WWKsYaYacSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5SEyD/92yF+J88EJ3WpwGgllfMzVx/fK1TLKigXnT69tLFIJraqaX74SypCt48tC1lAnLwWC4ap
 65NNRSiAjEFzcQluxkz2Nr/9HPCEqqrDdNVhADT43piNmAG9bi5p6tL1oiobSNr1HT+/grheCw7
 WrTY1I71cR3FvDreHsD5BksvMrce/gMxdIsojCRgsq23c0QsFfCihvVJP4rdgkRJsRFomtWY1QC
 Zg4Gbytr5Lm6BXVscSDjF2PJGoYhBc5V7ozkh3frqRuIZ6Te5d8ZYISIZuCivxezD/HTkis/J+8
 bf9ysX46ki/lVFVyq8VLVVZcn40NIB5iA2x8wP1g9E75FljJEWDOpgZNYaT9T8wX1FKHVYVwmbn
 vST/KTY3gNabQE/AJ92A+sz8f8BPxAqjYCZTvR6PU5OJ5e47lqrMqCVz4Vh4Rq1+jHByhbl1qX2
 y+IyJAH9XMKLaxaBgX88gAqB28NGCYF7J/OPfYWwPb8qsOlm55hoSBIVNZvPeNjTdsx9jvq8a4s
 spAWaEzTzkQa9wFYly4mZRrijYSQCPnKqZigbWuBdzol18/nOTbmnUJH3jVdY9JMmYmwEX3asiE
 NodkqEBrpp9r3qjrwAi1Iw/Fxm4S1HU7mpRJdhGfMSBAqP23a30Un3X3gmEUdfTx27Xx6VgGTTk
 VGbUjyXxVfSklYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 191f7431bdf..f0e99bb5be7 100644
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


