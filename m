Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2011FDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyqm-0003ct-Ok; Thu, 23 Apr 2026 14:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqj-0003cX-Db
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqg-0001KG-QQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y2Ve4V4QEYXRrJPSWkdiI5lVBGKfF9N/aa0OwJDsJY=;
 b=dC3dMSN97gvC+XrBkt5IBDUqj368FfbAFy5eDfgnUHuCAHk2Lqy61uuMSvDpm/qj1oUB6y
 skWhFoQ+0DF2zNp0oLE2++/yzCGwGE0mc7z7TqlHh2eB+SmVw5rFo+JT6AmEloyrwNlvsd
 ITuVvDXf1p0nkPZslTNRHFqpwAdG1qY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-q7GmzJdINIiX8lA0q09KJQ-1; Thu, 23 Apr 2026 14:32:22 -0400
X-MC-Unique: q7GmzJdINIiX8lA0q09KJQ-1
X-Mimecast-MFC-AGG-ID: q7GmzJdINIiX8lA0q09KJQ_1776969142
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89fa878662bso159775846d6.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969142; x=1777573942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Y2Ve4V4QEYXRrJPSWkdiI5lVBGKfF9N/aa0OwJDsJY=;
 b=lEDmO0dW8CoYcmNRsPpiLMoyWA914O9DFpU4dnFxd/s9UaFR7Yzjb/BLQKbza5J0hJ
 P6DpI7j8ALcAUc8unlBFuyaxnSwELTLsnewElbvwy6OR+wriXWDUfoI9cQrhsNrbAJoq
 gcGHP0IYYmbd5yGAMKfSuKqrHxa+mK5kpPtBvxmCpxVdiLsNn3YGfXHleLILHD13nlVj
 kPdSyxApyVJ96Ietiar5rIXoPMh8ZJuV2tOFsqmE9G+6pkVb9v+DmHYlqbDTv8P4U8qd
 GboEv/BniUr5yxMMc2iN6UfRylw/oTN3hzpRX9n3J9ywsxKURccPpIuWWhw3PKfb0sxg
 zU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969142; x=1777573942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Y2Ve4V4QEYXRrJPSWkdiI5lVBGKfF9N/aa0OwJDsJY=;
 b=lms2/jdQk56PCcEoPBOY5O/HcFbLCV8fJbB4s3xsIseh6jE8yaseJazOI1FUI6rQm5
 fDd81ANr3SpnAlN8/+P8fXyR81Cldnfs9tiNZw5gqw1E26dLLj5mRghYXFdFXO/GDLx6
 BVOO/KXGObcgSRsS4XxcLA/Fz+cDrce0yWiVTY/sSn+plgHwXvNUhrrkSXwB2hAi5zc8
 XCPbG4SQjVF39t+qjWElcfVrndOpgCdYrQDEHQebhLRQiwZSXl2jCca3BTcZk2YF4KE+
 Lcv9FgeXpDiRMBYOzxHSOl/sf/BuV5k9qGNN8eW4Ahbhh5fecF327gAndBpY60kGqHfy
 3dfg==
X-Gm-Message-State: AOJu0YxZAxRCB1lVDKNTa7IERoNxuW+LMCf8B86mSY61zaAkEng0s2Dy
 WSwzwKs5+TzlM8HIPEfB/u4AQAHFE6zWAGSaNvJoIz3PTTFGH8bDZsuT7uzaLAAAUFv97N9wPiW
 251qTS2aVGaaHv2qcV0wOCsIl3w+LtPou4GU5N6NC0ZD/BMk5W3NC3gLFnTrLB3PkDsLzJPI/i/
 k6NuhkX811fLvoqJX6NCzZXluchi+SALWpUPqbPw==
X-Gm-Gg: AeBDieux1/xWeWia0v9otAon4TpkAqb+aulN6ivkLY3NCLEBNv3QroPb07d12hYeVQb
 3iOuNN/COXjSvh8RHeChIEYXo1I/tUeLgMvKVF5Tbwv0WuH3toigRnS6pmBB+mpzxnZmq1udguz
 5XIaezaLFwuVtHzMSb/sMH/MLSA8wqAbZyWxR5NvsDN+1gQHn66MyF8RN2BYfDI8aswvhaJWjNi
 FZHeBRvtF9phOLPVthE6WqjuS5+cN3+MLExFYByI8qGOZZ6aj8YtLDPfjv952j8kEuD9XvdodcI
 W52fKraSeysWdyjfy2cdpvq6gYgS/MEXtspHW4+/cI6NpIq7BtMaKcjbbIO6yfllSikyxrHnPNx
 VTFGUeKb8UWzHU2Eylxqwc16/8xXjI/iTSfYG700qw44LZY714NrKmDU=
X-Received: by 2002:a05:6214:4783:b0:8ac:b2e1:37a4 with SMTP id
 6a1803df08f44-8b02812e432mr406399776d6.25.1776969141775; 
 Thu, 23 Apr 2026 11:32:21 -0700 (PDT)
X-Received: by 2002:a05:6214:4783:b0:8ac:b2e1:37a4 with SMTP id
 6a1803df08f44-8b02812e432mr406399176d6.25.1776969141260; 
 Thu, 23 Apr 2026 11:32:21 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae92fc8sm160665566d6.40.2026.04.23.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:32:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/3] colo-compare: Fix QMP qom-list-properties crashing
Date: Thu, 23 Apr 2026 14:32:10 -0400
Message-ID: <20260423183212.468047-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423183212.468047-1-peterx@redhat.com>
References: <20260423183212.468047-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Many of the colo_compare_finalize() code relies on complete() done in the
first place, hence the crash.  Fix it by detecting if complete() is
executed, skip the rest when not.

Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 net/colo-compare.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a..bae9d9c07a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1416,6 +1416,15 @@ static void colo_compare_finalize(Object *obj)
             break;
         }
     }
+    /*
+     * If this object is never visible (colo_compare_complete() not invoked
+     * or failed), skip the rest.  One path to trigger this is QMP command
+     * qom-list-properties.
+     */
+    if (tmp != s) {
+        qemu_mutex_unlock(&colo_compare_mutex);
+        return;
+    }
     if (QTAILQ_EMPTY(&net_compares)) {
         colo_compare_active = false;
         qemu_mutex_destroy(&event_mtx);
-- 
2.53.0


