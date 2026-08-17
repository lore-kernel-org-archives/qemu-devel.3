Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F703C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3t0-0003rB-2O; Mon, 17 Aug 2026 16:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3sy-0003r3-Uz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3sx-0002mu-Fj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgBbw+t3RVlz7upZwL/XQcgod2d9abAa1FIZVPanRhc=;
 b=CW7GP741Q/4LoNxWhsinlA4QvlMhXw/64Vaeq0HyQqSADwFKngSGDsh4/Kio8h64sxE36J
 KBGdnq55WeF7CpYDCW3VktJGO3/yJdKC2JtRH2PVlTG6AVFdSkdd0nGhUVbug7BLp4bKl+
 4Jem0OoD2SZCM/Hj0xpCmb/4g56jC4M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-9Fs4cQZ6O5uay0nqTVveZg-1; Mon, 17 Aug 2026 16:24:40 -0400
X-MC-Unique: 9Fs4cQZ6O5uay0nqTVveZg-1
X-Mimecast-MFC-AGG-ID: 9Fs4cQZ6O5uay0nqTVveZg_1786998280
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso49752051cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998280; x=1787603080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZgBbw+t3RVlz7upZwL/XQcgod2d9abAa1FIZVPanRhc=;
 b=RquZTUSbGVA7tAyDwSDLFl+XNhldKp64Nw3UahAyYUtDJMdHVaDt5Kr0oB8BiZ4jrt
 RzqBeYCUM9sdSBof+Td7vdFlDqnrPdwXtRL8YV20uFjDS650DHJL8YGwRQ8L3JO3xVd4
 tY5f9SEe537Wr60iRwM6q16py/RfWYYtNwnlNwkKKzhmBh+Yv7jy1xoO+ae0InVdwiWM
 cvl6C51N2tvOrBUBeaXJaxQTZ1GY6J8VYdyBQY/utkdMH+6pAJjWdkMBQpYfdFMZu7vP
 xNnCcqrtkIku83LE9KgjGnGUA37Qoq+7iK/XziIlszICE+Tk7WSYqwu2p4FkIJYZghlu
 4qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998280; x=1787603080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZgBbw+t3RVlz7upZwL/XQcgod2d9abAa1FIZVPanRhc=;
 b=qIgRbPsIZW1MI7pNtJYVaf//j+2mUpicvv4EnrsZYnaGcQP/uM3IpGZ0UmNfk7rNDA
 Vm+mX4EsfygIOSmWptA2dAUTiIp4vpcwP+g5YDFEnoYgzG0h9OG9/kIkxHBCHjuphbhs
 jpBseiUC/Sdb8Df93NyAlzx/VdJqlhs+qqYEYdVRA2VgV+glIyrSehXU4r3iihfUks+2
 W2kZ1942gEXu5Nk8bfTIm1j7OhzuKrWjo1l28wlEk+5kKiND7P2yOivKeC4RoYe4SzrM
 5++c0Guedv6r6HXfjtKNIBYopswjRFtEiKF5Mr34VrYOfU9hONlO25xY8ZL10DlrSQcu
 UM3g==
X-Gm-Message-State: AOJu0YxobpL35Z3eK0/rzVgsXYn741zakdI/dO/nJldBHmoQlMbTn0A6
 Tlwf4vUfCR6n35hbypTB+X+zLgjWoQDi3opTnucMZ5g1LLjpOr6GUz0nclV6GJn4Hsv5XyIbDxH
 lQCe0mcgUetpT2mtaGnpv4YcehBEkrS9a/cRJ5yd0LB1pjYTVCpMzjh+DVqDIYmgEP4/5CEEIyS
 OcXkjKfWqe4kMO/uQMvECWZUcIz2xEp3E0c2ACbg==
X-Gm-Gg: AR+sD12XCfPSzMNfk/syzV6lNSfjwAbJfUXGk8k6L7DZZCNUScCsyYG1xswU83v28Oc
 GKEhTXZqrsgZ+TGV97nHKuhFVCq1nij6sGVHvmWkfvBWfvNdhZI8xQaGtthhtKKGvMLNo3aLyNk
 o+HbvYifajMrfPo1o1ungSHNUsrtGIUK16KHtSjZBPW9Q/BbSxxFDzkqLvNZlprAYwhiIv+bWf1
 5Q7GcDyxYGKphT7HO8gPUeaBxdpQXXDqQ7UDCfa42vLr//N9GsZHRO/CkdOoZnYJK89kDi8pajY
 orMaO2bZIpyLDBdeuBAEsvx0fU3qVPQoqeSFm6KBPizrTbEo2oAU1PZPZAdZgTa4rw==
X-Received: by 2002:a05:622a:181d:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52dbd76c23fmr36195911cf.40.1786998279709; 
 Mon, 17 Aug 2026 13:24:39 -0700 (PDT)
X-Received: by 2002:a05:622a:181d:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52dbd76c23fmr36195151cf.40.1786998279118; 
 Mon, 17 Aug 2026 13:24:39 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 01/10] migration/rdma: Introduce RDMA_CONTROL_NUM
Date: Mon, 17 Aug 2026 16:24:15 -0400
Message-ID: <20260817202424.2901438-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce this to say how many control messages we have.  We did it because
we're going to remove the last one (RDMA_CONTROL_UNREGISTER_FINISHED) soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 438419d189..62a509b236 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -144,6 +144,7 @@ enum {
     RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
     RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
     RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
+    RDMA_CONTROL_NUM,
 };
 
 
@@ -235,7 +236,7 @@ static const char *control_desc(unsigned int rdma_control)
         [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
     };
 
-    if (rdma_control > RDMA_CONTROL_UNREGISTER_FINISHED) {
+    if (rdma_control >= RDMA_CONTROL_NUM) {
         return "??BAD CONTROL VALUE??";
     }
 
-- 
2.54.0


