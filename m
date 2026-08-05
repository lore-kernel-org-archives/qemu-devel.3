Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6EAC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraE3-00050k-GM; Wed, 05 Aug 2026 07:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraE1-0004up-Cr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDz-0007io-Tv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQpDyNbU/tG46EiuRbnYkqx7KUBqvimmPNcTnvK0MRE=;
 b=NfwfvckUYJiiZk5ga63s9kM8rNHixNp7GFqfYDWb+46Jb9ePeXO3g0RaYANNchgvNUfH2i
 eltUOyzTdKqiIWLcmpgof0j1XQYMc+RU8JfYQK/mahcy5QnpXxajeiIpFwPSXjoTspuIYl
 GU1aBYHLkD3amLa+CeCvmS0cHOdzn7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-jJh9S8KVMOi4xwYtHzRZHQ-1; Wed,
 05 Aug 2026 07:55:39 -0400
X-MC-Unique: jJh9S8KVMOi4xwYtHzRZHQ-1
X-Mimecast-MFC-AGG-ID: jJh9S8KVMOi4xwYtHzRZHQ_1785930938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 665B118002C4
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:55:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51BC01956041; Wed,  5 Aug 2026 11:55:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:16 +0400
Subject: [PATCH 26/27] hw/usb/dev-smartcard-reader: correct
 CCID_IccPowerOff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-26-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=720;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zuU7sGv4XRn83fvDoUSbqUQUBz6wo6doi5L28VfpSJ8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOvHOUZp6RniE5Gqwmnk7RZj2siGg6YMt+Yl
 S83dxcLc/iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrwAKCRDa6OEJdZac
 5ZWuD/9QiP3W3Dx2udLZTMwyK5a29P/46Erx9QgYyfZs1HXgIhxhqkHXUs3tVzQXnzLzKPdJn4S
 EhMUIwV463v+JIHnsYkSjekByLEPCnvqrJ30/zrkQODvNrN5Z5QIZbye1gsIE8catunsOxrxRMw
 RBTuNZcbf6QsOXdX9TfeTYB3tYCTqsQId5+iZ5sgGeXOI6Q6h7H+fAmBthFUliqABuQEUNjtmyd
 cWCMWCZPUa8SLidY0Kt8O/pKtm/MsKdwYt5SxY24pv1Cam00YeQivqpzP7xTzoNq9taebX5ZEHe
 xxzB4BxgxvEKwRRQ5fSyY5FQhGRME8073A83VEGdVF9KPHvZybYv2AFbwhz++kkqDqqrfg7dRaE
 3VeHsD2nsEskPRU54PLjvufV87IejAHNBgUb/oCyZEtHunpSHeuJiA73fLhQnqhfkKLpwI27XUy
 AM1d1YBEZNAFC4APGl0+dw+GpYNIV3wMujTM6gOzXn/XlH2+7Lpe0KZBXi4iLsvDvCKE8AQvL8y
 o2aTlh1IAxOEzDHnb0dHvWPkB/yY3BE21TX497zQbUq4PmQNG4C0wSLhK2jAliGhn5bR8/W2nyJ
 /e802/cN/mSS2KKlFPrLnKidu7e5MjRluinYFs3qt6I6EDuR4JdFsfR2ySnWxDe3KPkPMrbj/eB
 HBNGYso+rqU4Qlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The struct has 3 bytes reserved according to spec. Fortunately, it's not
used yet.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 99086befe0b8..752571043ee6 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -264,7 +264,7 @@ typedef struct QEMU_PACKED CCID_IccPowerOn {
 
 typedef struct QEMU_PACKED CCID_IccPowerOff {
     CCID_Header hdr;
-    uint16_t    abRFU;
+    uint8_t     abRFU[3];
 } CCID_IccPowerOff;
 
 typedef struct QEMU_PACKED CCID_SetParameters {

-- 
2.55.0


