Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C38C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5JwH-0001N7-Dn; Fri, 10 May 2024 02:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5Jvc-00017L-HK
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvW-0001Ys-Ta
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyN2wHv1ijdGz2Ma84Ruv6QsDQCxtoidDGw13yagQg8=;
 b=Gie1GSGmaNE2fPfMwK5Dz6wOIsItzMBqHLnZTp42Ke/3E2hvbwhTmQFqcAB52JTEYJpozw
 BdTs+zpOpCvSb0jbhpC4568NJ18v882o7UI3qkL9zgrqrIKrOZcj3OS7jCO39lEXet6m+f
 TMw978iieNC2BwlzuoU4RmOKS54D+QA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-pdffeqLHN_-M7E5vqETdyw-1; Fri,
 10 May 2024 02:40:14 -0400
X-MC-Unique: pdffeqLHN_-M7E5vqETdyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79F143C0E642;
 Fri, 10 May 2024 06:40:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 195E32079267;
 Fri, 10 May 2024 06:40:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Collin Walling <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 6/8] target/s390x: flag te and cte as deprecated
Date: Fri, 10 May 2024 08:39:59 +0200
Message-ID: <20240510064001.26002-7-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Collin Walling <walling@linux.ibm.com>

Add the CONSTRAINT_TRANSACTIONAL_EXE (cte) and TRANSACTIONAL_EXE (te)
to the list of deprecated features.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240429191059.11806-3-walling@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index efafc9711c..cb4e2b8920 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -218,6 +218,9 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          /* CSSKE is deprecated on newer generations */
          S390_FEAT_CONDITIONAL_SSKE,
          S390_FEAT_BPB,
+         /* Deprecated on z16 */
+         S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
+         S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
 
-- 
2.45.0


