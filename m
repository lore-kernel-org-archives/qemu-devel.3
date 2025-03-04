Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27D2C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNBq-0000Bf-VK; Tue, 04 Mar 2025 02:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBW-00006g-Me
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBU-0003H1-Bt
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=SG8udyNgcXPK4khZdpXuLvQKpbrngN6G82L4C6A6YgM=;
 b=IilfKwp6feg4B2VBhOFJ5+LXJWQrvLeh62m464phvVCOBk39T6ncRnnmB8Bbt5NtkfbIud
 p5V95c71k5ZIL/QRKwBB+Zex15GaC3t/fnDX0SEexfr1szJTnBFp5DdNWJmLYujcYaqJjU
 HPzhABHsnd2ZD0Ng0usk38NIkKS7L2g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-DuNRvjDbOl2XvWHBoVRN6A-1; Tue,
 04 Mar 2025 02:59:21 -0500
X-MC-Unique: DuNRvjDbOl2XvWHBoVRN6A-1
X-Mimecast-MFC-AGG-ID: DuNRvjDbOl2XvWHBoVRN6A_1741075160
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1828619137AE
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2EBF180087B
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DF6B21E66AB; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <878qplw7je.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:47 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315749; 04 Mar 2025
 07:43:47 -0000
Received: from blackfin.pond.sub.org
 (p200300d36f33fd00dda5bc774eb05696.dip0.t-ipconnect.de.
 [2003:d3:6f33:fd00:dda5:bc77:4eb0:5696])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7a2asm16895541f8f.37.2025.03.03.23.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:17 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 560BE21E66AB; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL v2 2/5] qapi: update pylintrc config
Date: Tue,  4 Mar 2025 08:21:14 +0100
Message-ID: <20250304072117.894134-3-armbru@redhat.com>
In-Reply-To: <20250304072117.894134-1-armbru@redhat.com>
References: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647234672510546
X-GMAIL-MSGID: 1825647234672510546
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: John Snow <jsnow@redhat.com>

If you've got a newer pylint, it'll whine about positional arguments
separately from the regular ones. Update the configuration to ignore
both categories of warning.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-2-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/pylintrc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index c028a1f9f5..d24eece741 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -17,6 +17,7 @@ disable=consider-using-f-string,
         too-many-arguments,
         too-many-branches,
         too-many-instance-attributes,
+        too-many-positional-arguments,
         too-many-statements,
         useless-option-value,
 
-- 
2.48.1



