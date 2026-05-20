Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70ABCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZ5-0001Yl-5K; Wed, 20 May 2026 17:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ3-0001W9-Q3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ2-0007Lm-Ap
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7eMRZuLTlzyY8y/uF1kVGsbn0oKuR1A0Z8JBgJKHAQw=;
 b=Rs2re9pVQ8VBEAM9K/dW/CiqO6GhmDf1KN0ihRxKC20qOmmDnPYjtExV5rQC5ceEh1Gf5w
 dP+cJ0Xe/ex9FRM49m7yVksNN5t7+zhgleBWTt1BgWNoYCEIV49xcbo2t3ti6l6C1k3i22
 uD/QnBd1hVZCDq+3ck4vE6fzhdi3uYE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-HMjUpG4DNz2UxysM4kXeDA-1; Wed, 20 May 2026 17:34:50 -0400
X-MC-Unique: HMjUpG4DNz2UxysM4kXeDA-1
X-Mimecast-MFC-AGG-ID: HMjUpG4DNz2UxysM4kXeDA_1779312889
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b46c014a26so168438386d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312889; x=1779917689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eMRZuLTlzyY8y/uF1kVGsbn0oKuR1A0Z8JBgJKHAQw=;
 b=qScGnH9Xdnb1l7DlguWRPA0gJCHYSQiUxC3g/UU9UcGJyw6t2zxDswGnjdicOvcjYA
 JBON2+6QW4vQFRzQ2mJuO2u8roAyqs+yCeUC32lKGaEwl0AN3j+Iu3N3uY6te20uUCij
 1MAEBzMpCIqcxWOVg+Ex3QN1+VCeZYP4cSpw7T+7c4sZTgvC8aOzcmXlajE91f/qd/Zk
 JifoQCC5bqqj4EWrzOMKFDZPTYp5IfTUtBvmu79KIvpWyhsS7YPasm8eIc0E6JzVSoVK
 84jvfpEs0cYZ4/cUC17WKM0F5X1tvk3mWHkQ7annRcrkObU0m5ooVWk79igukSHyUjJw
 1EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312889; x=1779917689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7eMRZuLTlzyY8y/uF1kVGsbn0oKuR1A0Z8JBgJKHAQw=;
 b=MjQgl/C1ydWGQIl1U+eQkcnps9SYNTlhLnHB8vJgNQmn2w20tA/H+09iG01NepzCWS
 LBmrVxshFwAZmEpYxJ9Qsq7WSq+5WYNLDbwXFF7JJSJnL+oIBpFYKEexUiHrv2/BnHoK
 GmbqbC7IUi6hWZLeh5D50Y+VDIB9D/YbFVAClvLZ/Phy/tPEFdGA8GS6Z2zmqRPSS4+Y
 XXnhmKNXM23IaaEAwCJ/vlfv1Raud9TZV+15bTltosdkdG+MptXNksomDwAC3CURlAlY
 y1FOs7OKuJBipKABgMUZh1zwtRPQwsWHfZdbsBvxmBgplKpvgL1ejSmZCka/HEdfBgRh
 cfmA==
X-Gm-Message-State: AOJu0YwtuhW7yiNBoLqXZVnkANADFxehGP201pbmfYs5+Imc51UM9LIK
 l2pC6HfHeT1WjPkhYevAVhcdI70mUTzTd84Vb8+DYGxuKpBs3RF9iX579vWmyVsA0NoPiFYwYpr
 aeS3rJco9dTwLsArZw1vXrYUULwlyoiRDBb5KJR5ZEOwc5rah8qeL5EOoloDs79LJRlyYZKCJI5
 SiFHdeT8DKXzOeDxea7kC8z8qT38GEZyoqEEb9qg==
X-Gm-Gg: Acq92OFUDXCmaNOTTsHUfNSnxjecdKsI3tz0pIkZGIomlWb7mzpouWgZaPESzR+OJCD
 35lstZlnuZU8yZAG4xKAR8QqVXrwrLVkrqPzfpiGsg/iDbQiY79QIOa3kvv993uH/sPgg2jQwNn
 35Upqeb3iHv5rFj476QD8xYyg2s6Q5T74B4TIHtmmCY4iFCevsZWxRnFUnkrHA/aL6dtCgpaYLY
 xNyUVYxgPmF6tzMhVruunTP4Zi8KJ1WPGwmBtquFwQsfr4rqZGCUeKcve/JiDjpgRkwEr+o4EHA
 hQavAWolR1avfJSLCPTkeinhCLg3oYXkVbR6GycEuD65j4s9gjTq2JACMNzvEEgJiridv8KSK5B
 9KlCtNS2/cKQ6Juo5QS1FKznVp2wOIoD0c3rxuNQ3kMDG
X-Received: by 2002:a05:6214:500d:b0:8bd:c5ca:3975 with SMTP id
 6a1803df08f44-8cc6e6998fdmr3481596d6.46.1779312889355; 
 Wed, 20 May 2026 14:34:49 -0700 (PDT)
X-Received: by 2002:a05:6214:500d:b0:8bd:c5ca:3975 with SMTP id
 6a1803df08f44-8cc6e6998fdmr3480886d6.46.1779312888613; 
 Wed, 20 May 2026 14:34:48 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 19/29] tests/qtest/migration: Use defer in dirty_limit test
Date: Wed, 20 May 2026 17:33:47 -0400
Message-ID: <20260520213357.40646-20-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-14-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index bf01fde8b2..e915b21712 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1021,11 +1021,12 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.use_dirty_ring = true;
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
     /* Start migrate */
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
     migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
-- 
2.53.0


