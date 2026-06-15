Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16840CD98E5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7c-0005EL-Tv; Mon, 15 Jun 2026 16:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7b-0005Dl-Cq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7a-00039A-2l
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bGigmdJZgyNOl3LkpIRvOYBbdXgYNU54ak2Hxfhna0=;
 b=Ww1JHy+gHFEUQLfUgEqR0VSixMfwD+RxmUg12/LL2h6hLmYTXec9sPpSg8LOUXVnl1T+Ya
 XeIt0cM2It/HULOcPrDpe+A56dQIop2YJGJctJLlg75qQlfnyqHY8rR3zXzeUI0NXQRzR8
 WeGgk21BflDiTlH3+InTPfjOp6tLMrg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-JdzPDkJmPA2GJQZFpJm7fQ-1; Mon,
 15 Jun 2026 16:41:21 -0400
X-MC-Unique: JdzPDkJmPA2GJQZFpJm7fQ-1
X-Mimecast-MFC-AGG-ID: JdzPDkJmPA2GJQZFpJm7fQ_1781556080
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 383A11955EA2; Mon, 15 Jun 2026 20:41:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E91AA19541B2; Mon, 15 Jun 2026 20:41:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:07 +0400
Subject: [PATCH v2 41/53] hw/pci: change the busnr type to uint8
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-41-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=602;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EYBqSG3xvEIb1ghvXPs3JqG5/u7tCYGIpzqM19FRqzQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPTvv93DhZTCZl+KZULhKPLB8k4zz0f8FGZ
 puDuYX+nfCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5fnoD/4vtwgc0TL3zbQYE8xdknja0VmZDxbxl6syGKArbO0YO75dlA1CfI2GEkruKm07W1ZL4Kl
 7A6Gbq+iHqpBX5qiRMIbnJwPrQMWI5OOal/BIgv/ppzJhlgy+r7DAXTcNtreJW0t4sie3BOGRb/
 HdHQxm304QkbgKuLsUZSRuR7zydFf4WSGlZy9UaKULCungSQIhxcHF4knnabpLGmcAe8TEurS/i
 QMtu3iY+KquG1ueu5e0njqzPB4LasmAX5m2ccc2qZzOf603ayT++7HdgoRp4m1Uc1kgbqn/B7/l
 hU1qqa8AUfVU7v8laAB38crM1ztHKo/JiPudTMjK1O67dGiYWuj+foxpcKZij+L2RfRyCK9UL/e
 Saehf7gb/YoiV6B1TDxA5b6d8f5KIXAdfxsnHhq2ct3IzTrVO3z8TKXZ+1ykPsjhKaq2LxZwzx0
 b5TRCbh8Lx51fuIBnssNFYjx6etbUWcwkxonBKbTwip36V7eTOodsbbu7QJ6b5iCs83WLJi9P1J
 m81PeheWLApnindJTjHOxtw5IRWjjM0XLRrViRdvvS8D4f7EbU2ferCImbozMg3JHfkszXsJL2U
 /OPz+bH+d4AjkP2tIS85/XQkkDhsIQIg5lKHOmldWAhI0i7plgRmhCFd+NkWkEnr9RsN+dHTBmv
 cGvQEolt60UO4Uw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

It is effectively a u8. The next changes are going to use the
uint8_type_info for it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cec065d108f..3bb7ab0cb86 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -79,7 +79,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "busnr",
+    .type = "uint8",
     .get = prop_pci_busnr_get,
 };
 

-- 
2.54.0


