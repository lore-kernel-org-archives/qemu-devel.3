Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73908C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NEh-00012n-KR; Fri, 25 Apr 2025 13:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEa-0000sO-O6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEZ-0007Pd-3P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745603585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiuccxRLu8fqNjoYvByXR1A/ypUE0qohnuPHymM6eZ8=;
 b=OJaWUzuUSTRsRJsCrhJuiqJoBw3YqAXMhqzWPNTozf3+eG7+Okjpy5g6/wvq9GY+Nx+ZyT
 +6EXV7SFctaNrA+5UsYJ4WytPVBeHneROWHZ9yBwjy95CNpiye3FrVE52CIbmPHpxotlyR
 EEsU/S4Pcu/GHDsXUL+XDhx5Ps/YFEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-_Ys1nd8CP8iTvuVYb6_hnA-1; Fri,
 25 Apr 2025 13:53:04 -0400
X-MC-Unique: _Ys1nd8CP8iTvuVYb6_hnA-1
X-Mimecast-MFC-AGG-ID: _Ys1nd8CP8iTvuVYb6_hnA_1745603583
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85191180036E; Fri, 25 Apr 2025 17:53:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4954C1800D9D; Fri, 25 Apr 2025 17:53:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] qemu-img: improve queue depth validation in img_bench
Date: Fri, 25 Apr 2025 19:52:52 +0200
Message-ID: <20250425175252.316807-5-kwolf@redhat.com>
In-Reply-To: <20250425175252.316807-1-kwolf@redhat.com>
References: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

Currently, running `qemu-img bench -d 0` in img_bench is allowed,
which is a pointless operation and causes qemu-img to hang.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Message-ID: <20250327162423.25154-5-gerben@altlinux.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2044c22a4c..76ac5d3028 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4571,7 +4571,7 @@ static int img_bench(int argc, char **argv)
         {
             unsigned long res;
 
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
+            if (qemu_strtoul(optarg, NULL, 0, &res) <= 0 || res > INT_MAX) {
                 error_report("Invalid queue depth specified");
                 return 1;
             }
-- 
2.49.0


