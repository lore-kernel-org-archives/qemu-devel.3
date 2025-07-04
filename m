Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B475DC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3X-0007hD-82; Fri, 04 Jul 2025 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3Q-0007gO-K0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3P-0000Ay-1q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msW017fzKYg1BzekObA96QwL6ot5xfmZJnekxiLRO+A=;
 b=b7OGnFqKtVsxmM79GGxR6YrB8EMgzAJyz5rtb9wJH0Bofp2PsOB0+KR4zFkxJJwika9lSA
 LyraxGkjZTZYptQ/jqs6taa04cWh1x3U4ArL6PQ8S0i2toab/7y1DSvZh0l8G1j385VoFn
 spf9cjf0BOFU8WxOu9aNR5NqQ3aqVn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-OrHf_FUPOxSG8S09UoKPdA-1; Fri,
 04 Jul 2025 04:45:50 -0400
X-MC-Unique: OrHf_FUPOxSG8S09UoKPdA-1
X-Mimecast-MFC-AGG-ID: OrHf_FUPOxSG8S09UoKPdA_1751618749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C774D1809C81
 for <qemu-devel@nongnu.org>; Fri,  4 Jul 2025 08:45:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB0C819560A7; Fri,  4 Jul 2025 08:45:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/27] Makefile: prune quilt source files for cscope
Date: Fri,  4 Jul 2025 10:45:07 +0200
Message-ID: <20250704084528.1412959-7-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Both quilt, to apply patches, and cscope, to navigate in the code, are
useful tools. Make sure source files that quilt saves when applying
patches are not taken into account when building the cscope database.

Link: https://lore.kernel.org/qemu-devel/20250630172048.519182-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c92a3cf7857a51dbda71bf6b4bbe35564e8fc67f..74c2da2037203d812c7a42074343b043af5322e4 100644
--- a/Makefile
+++ b/Makefile
@@ -227,6 +227,7 @@ distclean: clean recurse-distclean
 	rm -Rf .sdk qemu-bundle
 
 find-src-path = find "$(SRC_PATH)" -path "$(SRC_PATH)/meson" -prune -o \
+	-path "$(SRC_PATH)/.pc" -prune -o \
 	-type l -prune -o \( -name "*.[chsS]" -o -name "*.[ch].inc" \)
 
 .PHONY: ctags
-- 
2.50.0


