Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B84BCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnDA-0006km-8X; Wed, 17 Jun 2026 06:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnD7-0006kG-Ps
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnD6-0000Ur-CM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781690966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/90ixfnl8wIZ3LWZu/M7JTJ4C9O2Yr0AMWhPtzx12o=;
 b=HKIDTDm3qpQTx5h5o6BDfnkZZiNJLbEZFLjxNy13RZEsOY2Ft/cHIHMJBGQcTH2jQP3Duo
 dxExQxEM2/4nbNsaPHQyv/oOdo80n9zfaxWLoIiAHbNmfxJjU+Uwj0eQojneZOzWk/V893
 VbWco0SRVbXfiYHpo4VDsRyQibw2g8k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-0g0V1KYXN5KPjWxWr0y3NA-1; Wed,
 17 Jun 2026 06:09:25 -0400
X-MC-Unique: 0g0V1KYXN5KPjWxWr0y3NA-1
X-Mimecast-MFC-AGG-ID: 0g0V1KYXN5KPjWxWr0y3NA_1781690964
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FAD81805A0D; Wed, 17 Jun 2026 10:09:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E56641800599; Wed, 17 Jun 2026 10:09:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DB0C31801A82; Wed, 17 Jun 2026 12:09:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/3] hw/uefi: fix parse_hexstr
Date: Wed, 17 Jun 2026 12:09:20 +0200
Message-ID: <20260617100922.1302000-2-kraxel@redhat.com>
In-Reply-To: <20260617100922.1302000-1-kraxel@redhat.com>
References: <20260617100922.1302000-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Make sure we actually have two input characters available before going
to parse two hex digits.  Fixes one byte buffer overflow of the output
buffer in case the input string has an odd number of characters.

Fixes: CVE-2026-48915
Fixes: 12058948abdf ("hw/uefi: add var-service-json.c + qapi for NV vars.")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260526135948.599148-1-kraxel@redhat.com>
---
 hw/uefi/var-service-json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index f5f155683334..8621b86c5c5f 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -98,7 +98,7 @@ static void parse_hexstr(void *dest, char *src, int len)
     uint8_t *data = dest;
     size_t i;
 
-    for (i = 0; i < len; i += 2) {
+    for (i = 0; i + 1 < len; i += 2) {
         *(data++) =
             parse_hexchar(src[i]) << 4 |
             parse_hexchar(src[i + 1]);
-- 
2.54.0


