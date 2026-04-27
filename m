Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9433CFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsl-00040r-9c; Mon, 27 Apr 2026 15:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsi-0003mL-8Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsg-00080D-Pq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMnEmi3v8/QqeA6DDuFhvLERp1GfLcHeEYC6X5UXDMs=;
 b=RmKa9p6B4J79ok+PAvh6ocqWhivVcM1fRlOGJ1YOmOgX3R7CAsoMSkwghabTuTPv/lXELR
 zvCC8Q5TJcQS8s8pYmFapxoXq8kNA0nYLKxfScg9n3kKa7zg541TypnPHSTXtUDtm1IEEL
 wDOvQ9WlpIMvPSujytxgdOaUCwoaZuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-9-KmE8VJMyim9euSymLtBw-1; Mon,
 27 Apr 2026 15:44:32 -0400
X-MC-Unique: 9-KmE8VJMyim9euSymLtBw-1
X-Mimecast-MFC-AGG-ID: 9-KmE8VJMyim9euSymLtBw_1777319071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F6E1955E9A; Mon, 27 Apr 2026 19:44:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69E9F180047F; Mon, 27 Apr 2026 19:44:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:20 +0400
Subject: [PATCH 21/41] target/i386/kvm/tdx: free strings in tdx_guest_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-21-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HEXbom8w6BaN+wnuMFqRD/qko2iqRyMwfut0S8bMS2A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVvhksEAaDilerpCh7L2D/LJtSDHrTV/YOI
 JtQDppNNjKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5SblD/9F6GLRocqj6HK3EDhpWsm763/GmQ+d+FKaaP9TgBgpqpbtshl7JDgKzNKw3mYjol7asfD
 8irw2eHDICvJiaSjPwofwI6H/qs5EadLeuc6mtU3CopHJbmgwSZXEVwohbCHTVb5nx0NmpVko81
 yOKK/hpHOX5fNL0vaiC/yJrMSftf5pb3iCUy+8bXCTfuyqF0mQp0btrlCC9Ium4sW7ZY49+Ab6t
 uFJd/eTkw1y5hqbxnFu+z8OqxuQVw8O/8nlK8q4/BjOASkcwkbyJiNKova7lqnjI5HnMZvUdtzj
 viBdWlip/6NSp6Hs60SQNP7Jfh9hxI6ITSJI2f558WvPQFESrmFC9my7RJowzFumnfZHXd3agN5
 rq4wWl0yYSKs51CVMBa+evChZm7eNRadiAllxF/RTxToJfxzFKrugyf3aiI3vFzhxs8naTl/q24
 MaDg4HQjPAHKLrMdt50+d65t/88ECnJPYJIHPj+rPf/g8JMESz1CaC/5Ii9RbHA91kE3WvNHqH+
 q0JRiwncISmZYlblCWD9BOgR49eW/TQoDR689LrAU4wqjcXQQgCZx0XcoHRcS8QwGGlGRdRK4j8
 4AocIXyOH3+s6PmZA6Gu4diPHMzq6cocvxA9hvuVgPqzgtFIniCMszr+50t2GuMcSMuBDlnF1I1
 mpjlBDZu/NQYM1w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tdx_guest_finalize was empty, so mrconfigid, mrowner, and
mrownerconfig set by property setters were never freed.

Fixes: d05a0858cf87 ("i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..df46fce7693 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1585,6 +1585,11 @@ static void tdx_guest_init(Object *obj)
 
 static void tdx_guest_finalize(Object *obj)
 {
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    g_free(tdx->mrowner);
+    g_free(tdx->mrownerconfig);
 }
 
 static ResettableState *tdx_reset_state(Object *obj)

-- 
2.53.0


