Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4BAFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcm-0003EE-Gf; Mon, 04 May 2026 07:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcL-0001yt-JR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcH-00014v-Mh
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cm1yArhtz5sU59WBphWUAJT4oX4EP1pkrBrfy7DzZ4I=;
 b=hxsfnZSw0DNvb11THHnFQ/n91eWSbER40CIvEPgJ0z6o0bBDvK5ypUpT5L7WZdfpwWvG2b
 oNwa/C0dyKV5mU8SvOEOUh/jJLXJGBxrxKlINaeQIgckZXcfPm20JCXfsgkxxZ/IKdaryN
 Is/KXgAGqkbCxV81nv5Ra1/bxKbyyG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-iVFG4InJNDqPsfsJ76hqwg-1; Mon,
 04 May 2026 07:37:32 -0400
X-MC-Unique: iVFG4InJNDqPsfsJ76hqwg-1
X-Mimecast-MFC-AGG-ID: iVFG4InJNDqPsfsJ76hqwg_1777894651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9455619560A1
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A44F30001A1; Mon,  4 May 2026 11:37:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:12 +0400
Subject: [PATCH v2 24/46] target/i386/kvm/tdx: free strings in
 tdx_guest_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-24-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MNRXqvTukQ+paxNe0QQZQxRe4jE5rhTlC8L20HzTXMs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtQtX9JxEv+O0kJbEHXz4bE2RWRVIZgpamM
 tHpQOFLiqmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5Yc0EAC43PcJp56qBFLKLkT2I1GTl3qEU5ehBc1lJRnhdk4ULP9WynqEA2kYWbC7AGgIRoUGXSV
 FUjq+xoS249crsL6pWItXd2eFDVjhZOdY0WBFycDDXCFcJ4scysM1gbL5ifomVdplxRihhjDmih
 TFoTGMiSqANzcQwCHNHb2tBtUQn1ZIedeiINrxkTPukO9eYikJpbtW0GGuZoXbn0IRtNqaejMVp
 k/t74mUH0UzT1VP1nhf6pGLBHCopdyCOt1k0HpDnNfuQMbGQFtUiU3NQhX1dScyRRObEafqPzEy
 GxBYpgf7BR8978MMD3ILUH7uc8noNZjhHlKEVSkPGLx3MTe2+H9lRSVJMi7ROTr5U9CgK3KKr9f
 38qhvox+bEcy4bsuzOrjnbKIS5JKcyYyquBTvAapKhEDpAcypA/PQ7uowJb5l/KHlbIE1N93tQX
 WIXaiYWGcKgNC8UcyW43XkAB+riIJlE4V+x/gYHdzjxN0Ll/HWTuUBssWVp72X5nzLlAyoEMW2Z
 paEDCua9+U2mnIqEtZq32Y7vt/+nDCzPhGIb8xmyCPl/yJOMoaPcgjlYypd23sHDiSMwDTBmECI
 rASkVUg9ZO/tZ8FpMnHjN/5t3OorNRd9NwYfERzIFPgmjagjMZ3DIfYB8zgv7DDAK4jKPQ72aO8
 pRfhPvQsv71rBFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.54.0


