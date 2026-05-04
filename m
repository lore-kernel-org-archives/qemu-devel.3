Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D550FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrb6-0007qO-1f; Mon, 04 May 2026 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrao-0007o5-Rr
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJram-0000tS-Tk
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpiJsQbA6N4lVaGQnZSXpb0IqEmM+X+KurXrRNwGnJc=;
 b=KSDjufmyX983zfuvcCBkpOjptT0D4M0AczKQx16oOlk8+Dki9wxgSVjbXhbj7BmDXM8nKO
 Jk0RIbKZwFFq0qV2rhsj8yBM4QNw2Qn5Cds7cYbIK0sBL/UV3lTV4AEu4VSPYEpGtK3nQy
 Y+7DbHEr7s9EPgXAqGV7ExxPjCwa6D8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-Oh4z6cupP7Wo2GmZbvOeVQ-1; Mon,
 04 May 2026 07:36:02 -0400
X-MC-Unique: Oh4z6cupP7Wo2GmZbvOeVQ-1
X-Mimecast-MFC-AGG-ID: Oh4z6cupP7Wo2GmZbvOeVQ_1777894561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B531956095
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 100861955D84; Mon,  4 May 2026 11:35:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:56 +0400
Subject: [PATCH v2 08/46] hw/xlnx_dp: reject NULL 'dpdma' property rather
 than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-8-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=819;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ust1ZuWfSfSA7Ib1bldNFkkVSryiOB6BQFu7ci9K6O4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRs3Jb7MzUVjAZgRkGU611y5HPz03rcxztzK
 2AZkNtYcy2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5Wy2D/9g9uRtQ/LxB9wNV5i/PjAmI0Sc+zFik27774askZDfN88v58vcudoq+neG5lMt6sfkD1U
 +K2TK7l06ODi4Bl0s2eutAwnG3rO9h5eW3hSiIHxhynPcK7Ew9F6v39Huuy7Mi7yC00YjUX1AuH
 lrtkOcptq+E9arfJ8v9bBS7+6Es8xQ7/zKdh7ybWI0kTu5glGXJLZpJzvfHVb1N15lJ5K0KHLEL
 CgrgomikhRxWFeUWG/G4X6dCe1SPYkbxEPXhAFQ8dE6T50wdxODxLeMZZu9mya3nqkKCTYxFWr4
 RHKZPVEKTcSOMLSWrbvznDbj5B02xJtefPeEgde9UobjS4GngrJr8/EjpXdmP1TnUzLUVqHjVuW
 ghL9/IrYkCSSsfz7C+2Fl8O1S2WQs8cCHT2x2hJU+iWfTpUQbNSpIPICUFL9ahcdg6BOS7B/ZH2
 mIjnDmhR1mAIH0JAzu7r5C6V2GtNsUJPVyHpus8+V6Xha+M4lEzwa5cgaRO5Wk4Oj+fzsr59L2n
 JiHxWTdM5IITjBnfSxlrZQchG7Mh4Kg1we+fjjvkb7AVIt6IM5j3fhjjYh3yhQuqc5LmGlJNt6e
 y491eX8YtJZuglanjF41coPvjfUyomAUSIYOJikKQ2wO/rC0K4fB7r9SuB5e1HMjBrjoScLi0GJ
 8EyGjdE2cMjAE6A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The type-checking macros (XLNX_DPDMA(val)) which crash on NULL.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 50e6ef10984..876cb3d6642 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
     XlnxDPState *s = XLNX_DP(obj);
+
+    if (!val) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
     if (s->console) {
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);

-- 
2.54.0


