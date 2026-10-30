Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E26606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RX7t3Rr3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsNO-0000W3-B7; Fri, 30 Oct 2026 15:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNM-0000V5-HW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNK-0007jO-Iw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793388894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdpktEchiARfY2rBuTFn1FEwz2eIdtaQitw1/wylWb0=;
 b=RX7t3Rr3JXvAYlUFIeCr+0yWxXMNjvVD8HC2U4xExspWekXucc+zFYgdeFcJ8dD/U8Wvyg
 PLBezOGJSDFl6998ZWm9sDoXQrDeDyf6EQNNCeGQVoSFj+quF6pbxDCPwE4jl+aCmguki1
 pg0Soa2K4kD2vImbuTFs2UfJ2GHvd7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-fDh9YkIcOK-jgkd0jQ6SvA-1; Fri,
 30 Oct 2026 15:34:44 -0400
X-MC-Unique: fDh9YkIcOK-jgkd0jQ6SvA-1
X-Mimecast-MFC-AGG-ID: fDh9YkIcOK-jgkd0jQ6SvA_1793388882
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE650180056E; Fri, 30 Oct 2026 19:34:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3B3630002C9; Fri, 30 Oct 2026 19:34:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fam Zheng <fam@euphon.net>, devel@lists.libvirt.org,
 "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, oxsignal <awo@kakao.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/5] qed: fix incorrect denominator in qed_bytes_to_clusters()
 (CVE-2026-118594)
Date: Fri, 30 Oct 2026 15:34:12 -0400
Message-ID: <20261030193416.1691807-2-stefanha@redhat.com>
In-Reply-To: <20261030193416.1691807-1-stefanha@redhat.com>
References: <20261030193416.1691807-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cluster_size - 1 is often used in bitwise mask operations in qed.h, so
this bug is probably a copy-paste error. qed_bytes_to_clusters() uses a
division and the denominator should be the full cluster_size value.

This bug can be used to leak heap memory to the guest with a QED file
where cluster_size <= 32 KB (the default is 64 KB) and table_size = 8 or
16 (the default is 4).

Fixes: CVE-2026-118594
Fixes: 298800cae72e ("qed: Table, L2 cache, and cluster functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4737
Reported-by: oxsignal <awo@kakao.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qed.h b/block/qed.h
index 26d4bf038c7..04bcd7ac4fa 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -253,7 +253,7 @@ static inline uint64_t qed_offset_into_cluster(BDRVQEDState *s, uint64_t offset)
 static inline uint64_t qed_bytes_to_clusters(BDRVQEDState *s, uint64_t bytes)
 {
     return qed_start_of_cluster(s, bytes + (s->header.cluster_size - 1)) /
-           (s->header.cluster_size - 1);
+           s->header.cluster_size;
 }
 
 static inline unsigned int qed_l1_index(BDRVQEDState *s, uint64_t pos)
-- 
2.56.0


