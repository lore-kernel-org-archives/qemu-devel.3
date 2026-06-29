Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD6DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCBV-0000gR-Bn; Mon, 29 Jun 2026 09:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a1c0e5a73740566d4b9eac1f97f78b8ce470116a@kylie.crudebyte.com>)
 id 1weCBT-0000gC-Sm; Mon, 29 Jun 2026 09:37:59 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a1c0e5a73740566d4b9eac1f97f78b8ce470116a@kylie.crudebyte.com>)
 id 1weCBS-0003jN-HM; Mon, 29 Jun 2026 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=RAZvgYqnj+c9g6wWpQJSv+KlfG4CB8UOuw6DmsMXyJk=; b=G6+hK
 SdUJ2WkwpDNsVauxghpVQoQOZ5wMMbHkMUHUmexkBTijYOkE4Xh7JrECQWu/XWXG0YqRmFpG84S0I
 lK4LE8bGA7duy1s7gy+qOflLzaZJUNiXR6Y1bbUZF5iVjdbP+OSzZwWKGTxah0ww7vbL5acXRDvUJ
 QMEkOe20MAiF2fHS9TSUDL34MBCy/nCvPQd8t+gxqa1cRz1ReHeI9q5yczkmpXwKEE3ZbCif3zn7w
 4ZjaFxo5LUhZb+SR1PG3aA8IcW4/mTJ1d/ufEuGOkufoOOoFpDdQeYLc5R0a2roPwApUxiDUfDmKH
 /BoFSC85eMJlB50FUAVwPyTNupwEubmR6RI+lU+8pBTSUBCADTEqF+AkoyJOGIL6dE0oFCZIQyuFY
 rSZAAATNFFU+mQkqTVr7nx9Ngjw/1b9srNoHb1BafpFOmTXDEtWGwdek1tIvb7KfnkouxOmLM4uJd
 x6zodWkR/cFhUyCucYUddcwGS4kpL69pMQSyWBvVe83TpnOhqbQ/ePCsTMyyyMKgEO9kHoWipoHoT
 5w9CKmrU8mfzHN1/sodzyrwG1EyvAvgi4XPHhzvXqkR7m6wyAKUCtw1Ry0jM1AQJEdVP5NyJK1EwQ
 c9BnX+yJnzdHX3Og7ux78VvD1RJPWXdvTlJiocg8J0bZbsKLmIA2Pv58wp0Jck=;
Message-ID: <a1c0e5a73740566d4b9eac1f97f78b8ce470116a.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 01/23] hw/9pfs: add msize_limit transport callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a1c0e5a73740566d4b9eac1f97f78b8ce470116a@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new callback 'msize_limit' to the V9fsTransport structure.

This allows each transport implementation to provide its theoretical
maximum 'msize' value, which will be used to cap the negotiated
msize during Tversion handshake.

Link: https://lore.kernel.org/qemu-devel/7c4e53eb73c0580d7a321dbf3823ba5647652298.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b2df659b0e..d8f364fafd 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -481,6 +481,7 @@ struct V9fsTransport {
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
+    size_t      (*msize_limit)(V9fsState *s);
 };
 
 #endif
-- 
2.47.3


