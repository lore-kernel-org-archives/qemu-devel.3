Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2230C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96xX-0003ad-Uh; Tue, 22 Sep 2026 16:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xQ-0003Tn-GJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xM-00080E-2W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69y9HyL13lSknhbAxE4hbmWgv5ZVHGP2g+fYLGQQEkA=;
 b=I48w7o0ghziiA19phmolAJg4EqFhUb+eHJ0WlUYGPcYb2jeRKQ2yCnS0bzoNC47i4XWKYw
 TuFBLR5xhmHmw/mOz7GBo/URhvB2je566qfBqkyRcKHZuuBbb1pCA98bCBoALV197kjwOE
 M8beJQ0D8bCBLInt/pyndGabJujeK5o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-9AaZk9M_NFC1lD1pg3sgRg-1; Tue,
 22 Sep 2026 16:19:09 -0400
X-MC-Unique: 9AaZk9M_NFC1lD1pg3sgRg-1
X-Mimecast-MFC-AGG-ID: 9AaZk9M_NFC1lD1pg3sgRg_1790108348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26464193E884; Tue, 22 Sep 2026 20:19:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2AC41800446; Tue, 22 Sep 2026 20:19:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:08 +0400
Subject: [PATCH 01/88] scripts/checkpatch: skip trailer checks inside patch
 diff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-1-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu@processmission.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=923;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qrLUe2DgABzIRe9O7ucC6nnmE7YYrgIhHXKXGq9YC6M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKtJVfTtcJ9IGw0dOU8em/IuhlgCO/+siZKf
 94vwddYRkiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirQAKCRDa6OEJdZac
 5X8qEACBzIdoEDQdOKlM2DgsDFG/K3BJrtaVzC9xfFgcQsxA19vON2zX1Opp+Sn3+kFNlZsY4cW
 pDxQ5Kb4Q0wp6Lm/iDVFxMYP3todAQF9S3JXcDookybn/Td7Zwp45cXgftl7/KMmogodKX2ZoZz
 GHCHzQJ/WaTRNldrgNFiYhRSboY3+VQmIz6vczRCW+yF5DTC2Nm+3btlTJS4fIJqPRYozK/NYUg
 HdJR88V/7Z5s8obXIe92HasTa9kjjQBvj/HDKhx7RYARh2FIj8ba94A/U/4wkYMdDrR/JpqkxMt
 zCQrkzM+Z1jXW89PBcfU38uS1oDapa+xK23mXC/spJMhAXH2pG2kDXTRUHkqVu8WyKINJ45OP+X
 xWjzS28IAVPP3EzpHbTIsdON5NDEa4dMEFZurxtQgcTrdbWQPKIuk8zTz1NxOUd2d2GuqAOne2a
 bJiIaPI0WUGjZWYcq9nX2wwBaKmnn1BibmML4kQ3G0BDQZsI1T5W9lgdMKvHNzjJ5KwNxH36lfq
 4omDEeGNUn92E4PY4S6MO9zxJrY+Wg3VU2C9rgyxRqWnPbThoaGiY92mWUykN2fL+g301EFDYkc
 owrpPc/Wvx0Sc9sjtnCEXrLas0aQTG5VqjWoo2PYbATDOdSCwCllWKlNq+QM1IIzPrDnIhb6N+C
 bQjA4NwoJlEhbXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The duplicate-trailer and self-review checks matched trailer-like
lines inside the diff body, not just in the commit message. Gate
the check on !$is_patch so it only runs before the diff starts.

Fixes: c3db8e70451 ("scripts/checkpatch: warn on duplicate trailers and self-review")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9838a6417851..c023767f9670 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1834,7 +1834,7 @@ sub process {
 		}
 
 # Check for duplicate trailers and self-review
-		if (!$in_header_lines &&
+		if (!$in_header_lines && !$is_patch &&
 		    $line =~ /^\s*([A-Z][a-zA-Z]*(?:-[a-zA-Z]+)*):\s*(.+)/) {
 			my $trailer_type = $1;
 			my $trailer_value = $2;

-- 
2.56.0.rc0.29.g47ce80527c56


