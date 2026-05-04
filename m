Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D366FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraj-0007lJ-Aj; Mon, 04 May 2026 07:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrai-0007h2-2l
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrag-0000qJ-Km
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk6EPK8YN6D3adylJlyTRAZVvpCyDA9Qp3WjzVTfNyY=;
 b=DB7IM9bdQdWZAZCEUDrgSqUviHsXKUBGuVKswUUkUP9mL9AapUyJsAOpnJOOeGT4q1049i
 7RDbOUp9+U1aNk8t4fFtCLVUETo857U8WXljypZ37ARcUKHD0cx13FGlQSoTjd2EhKm1NC
 k/uIwq3GsuAM2Ws4LS2hz02fvAk7s1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-tRbopzuzN3enjrmC0QXifA-1; Mon,
 04 May 2026 07:35:56 -0400
X-MC-Unique: tRbopzuzN3enjrmC0QXifA-1
X-Mimecast-MFC-AGG-ID: tRbopzuzN3enjrmC0QXifA_1777894555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 591851956071
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:55 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3B741800480; Mon,  4 May 2026 11:35:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:55 +0400
Subject: [PATCH v2 07/46] hw/ipmi: reject NULL 'bmc' property rather than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-7-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IaYWXas6d6Tx+GiU2CWhWCCTpxN6xrywSSwek/zs5Bg=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGn4hGyiWY+f0R5WzkO9IDcoS0Rg+wsAzRMdGV8Wy3/uM+JED
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJp+IRsAAoJENro4Ql1lpzlUFAQAJDz
 Arx42qH/TZri8CDSArjgwM6MsZuAEG4p1MKyOqTlGJINSGl3FGKPH1D7mFB1OsZLX4Ng0631L09
 pXZnEOkjPgsAaA2UnjDzkdJlPItsvnUEBiqNqKnOEdNilz1A0WIdBI0EiRH7X6qsf6B25tnT3v1
 kW3yoJ4TIcdFjjfqd/juGta7jtySvCbo8DUtmzhvP37OrAnrXcsPALrn9bpQdg4uy0z0GlRBs5T
 WrF57NrV/axijvDMUjA4WQ/nQ+saSEsvgQ7IxtXnMzVGsydnc44j1QOCdQcjCVbhQEVQLkKSJnm
 TtI8KQk6CXbv2052hdYhwHUuexqpiQlTTW4Kp722C8mhbZWW3JxbbAekFqhcA1aoICvrzKF32hJ
 5LMpkeVYYlcomtAPZlvaNLvq0wfKL8zU6NpB2eVebtu2gl8bJozmRCbfsXAkcHQNtN2/OghJMhP
 FV3rvXukv2W61KrXAl3oSJrlrw4H8/8chKke+Vl4Hlxvhu6Vik2O4wGCjH5aueAPTniz3J1/jCw
 Ac1EcZgr4ny79azUwvKajn07sdmD9bvVnfmejGo1R3mMsNMqhAZjrXtAMtgOj2qubOaP7eqJobn
 /xLlef6JW3EY0bII+4FGs6yd8XHpxCZHedxc7SyNq1Ply5WUaQl1jeG5RR84RZs9E9Vnn9x4x35
 gbuNw
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The type-checking macros (IPMI_BMC(val)) which crash on NULL.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ipmi/ipmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b49affaccec..d532d38e556 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -95,7 +95,14 @@ static const TypeInfo ipmi_interface_type_info = {
 static void isa_ipmi_bmc_check(const Object *obj, const char *name,
                                Object *val, Error **errp)
 {
-    IPMIBmc *bmc = IPMI_BMC(val);
+    IPMIBmc *bmc;
+
+    if (!val) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
+    bmc = IPMI_BMC(val);
 
     if (bmc->intf)
         error_setg(errp, "BMC object is already in use");

-- 
2.54.0


