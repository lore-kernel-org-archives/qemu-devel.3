Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99F4F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRG-00058q-5s; Fri, 10 Apr 2026 15:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRE-00058Y-0s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRC-0001zD-OU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxv00SmkigX0eFKKwcb6xmktHwJFPanppwAzp1Uwo0w=;
 b=Zq50lfsk1CfeV/3FK1oe65vhQF/GnN2BY4Cs0A4KKyNusQ15NLBXHcK/tc9keqW+v1cTab
 0DLYcvXvo8jKtQYj4J07amsPapZ4BueGneyePVzy5claCQGIGgcj1UNEFH5zFb+dfG0MvG
 Dji07wbk+ardgT3HBvouHkm45rQitWc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-A_fKgsjEPD2CrqG1DUV-Sw-1; Fri,
 10 Apr 2026 15:22:39 -0400
X-MC-Unique: A_fKgsjEPD2CrqG1DUV-Sw-1
X-Mimecast-MFC-AGG-ID: A_fKgsjEPD2CrqG1DUV-Sw_1775848959
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24CD019560AE
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:22:39 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBD97195608E; Fri, 10 Apr 2026 19:22:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:59 +0400
Subject: [PATCH v2 37/67] ui: make unregister_displaychangelistener() skip
 unregistered
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-37-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=709;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mKDJcefNbZvW1FtuWUfadq8onlX8URsT/PcKiCsR0qc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0V+9shZNMBKN7ZrtmVN/1t5oEfGqTN4NY9c
 VDC53PCISuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5YHvD/9bxBApzq5Mpp2hZX4ys26my3i1vMJAu52UPbbuJB7u8Ka1VLncnPylNkP+g4NV+VKXymr
 pbTRsZah0vS0StIPBOWdFI+coNW1nq7HOBZ0xXrGDf6BnXeZpZeebU2M+gS/WbWgwZicmC20y6B
 sfDZ8GTnMPb18VMmaC7WT2mAUEVJMm1kKWrbdHMIwCoM5ZgMMsJ1Z3vKirHOGr59wtzBqlDhbCT
 HC+R5mThman0B7caOzoOdMoq7bwP+2LTicfOwkO+rht8HQ1oyfxE22QmoddSK5x83EfgB1zMfW2
 YQvNUcx0VcCYLH3VtK2aaRsto3Q5A3U/hKHvoy5VimLhBdBjfdFAqgMbVUylTl0p1T4mnWIU0Pu
 8O16C+sYZ5AIVOHAA+OQih/q3u2aVorzEpQf7c7XE1PXxBG71j/5v0m7IEB6bCm8vApXiUdRn17
 HM9lInGnKFqLiEMJvHeqCtU8VrMJxTtQ/Azm02DfWezeAro3YFtg7Fktrla/77mURbR8C66lATI
 wqTHEAc8/XxP+ft9MoKsUzjQfP3Q9UBrz5GiAVGdk8FLJlJcQ/YjPvfN6RwUesPvnjYNECeaTdC
 xJZJOOLHKL5RnCtDb+3KXEoSIgy/O0R6X0nDdw0Ad7QI+q3v455v07GspnYOP0Me5fpLBctej4l
 P2GlD1RPaRUPfFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If the listener doesn't have associate ds / display state, it is already
unregistered.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 78b0ac27827..a9132e09eac 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -677,6 +677,9 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
 {
     DisplayState *ds = dcl->ds;
     trace_displaychangelistener_unregister(dcl, dcl->ops->dpy_name);
+    if (!ds) {
+        return;
+    }
     if (dcl->con) {
         dcl->con->dcls--;
     }

-- 
2.53.0


