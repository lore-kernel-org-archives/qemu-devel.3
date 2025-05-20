Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85541C54756
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRu-0000FK-SS; Tue, 20 May 2025 13:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRs-0000CR-M3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRr-0001Ac-4U
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMKQccz4NfqoEUSihdV88pqT2wjsRf3oFYxwpJIsn2I=;
 b=C1+zug/E9/lkdovXklhImBzRCubeWeX/Qa13T4GQT2BmE8LKPTP8mMzecZSogyR7hA2XmH
 ubymDdnKvgK9Yx+krQ0rD3wZuOj8arRkntubmUmxL5ZhounWglwZeNZV6j3QZOrk/ohMuK
 w5nmVwDlum9Z9PVQ4FVXLdScumF3gaI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-BSiT8sSSNeW1iwAAJg3A8w-1; Tue, 20 May 2025 13:08:13 -0400
X-MC-Unique: BSiT8sSSNeW1iwAAJg3A8w-1
X-Mimecast-MFC-AGG-ID: BSiT8sSSNeW1iwAAJg3A8w_1747760893
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c53e316734so1073591485a.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760892; x=1748365692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMKQccz4NfqoEUSihdV88pqT2wjsRf3oFYxwpJIsn2I=;
 b=U59SE3GvWL/PyG7RvhMwl3vnBuSiq2Ojum5Iy/pQvUGvpRls1kYdez7os/L25w2j9T
 tlGkCrrOwMOhIPIaTjKL4h/q1RXcH6Rko3QMhiSKOpdayF93uZNBTzDomqFDxnlP7d4n
 Wy0XjSftk8/Bllx2z8AlIA81YETNwsQ35VKb9HN3MpVImnxrG/sHr0sHc/xVScAEdXgw
 5E+2ZLnLYHUIH5CVBc0/Leg2KYnys0rRojbiZrsHHbfT5/dgptJf/7M9Q+J8qOp2gATd
 at+6ttbPNly8NLLIDm/4rh47E0zLi8o3RieHCHamPAz99SSrebKcRbAuE5Xb+r4852HS
 kufA==
X-Gm-Message-State: AOJu0YwbBWzXquD0e3HTRdizr64GodaUe/NDPhoEeBY7GznnKceEDsab
 tlTk87Wkn3/n4MbFnNUuyABA3Ny8PbsfXFs+gUIDctnSQEHZZm5Q3AesTvA7dpb9OSpjtBO1b0g
 SjQDAaIOHcm5fapnQCeyrk5CKbrGajwyoIEbEtIAgvNil1r6pHv0khM+Ib9rh6m3SzZ4Qz0ggvo
 CNipNQcOtJ6UifWsUTiQaZd6F3L7hbCJMt9Ui+mQ==
X-Gm-Gg: ASbGncsL+iy5yzQG+e0hmxMNqkvKVqXUgRoIrV5QlW545SqhwB4r/SB1GGYOzxwbV5W
 4Rawqvzwtqh9b4J8Ieu0L/XyBxNB2wWcTKNeFrqcvraEQamsOXSQ1yo3xITaGO8aTpaFnoA5RlA
 mRCUiIjexMPa40PSeKkag+/wUWOWPW6npYAAnb6fmw7J02dmwhtF0mLM2P30IycYjI7R+DB5hKb
 UyW0Td6xyPYW8f9lfNN+49EX+JNlTmp2CHL8FVgSUNxG76XK9OAPlHIYE4zWZTSzAkmVXCbJzNr
X-Received: by 2002:a05:620a:2848:b0:7ca:cd70:718b with SMTP id
 af79cd13be357-7cd4679c9dcmr2793400685a.35.1747760891899; 
 Tue, 20 May 2025 10:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE0mqoXb04w4Aa1zfWjUQc/fNc75N1Hkcyl3zALqNroJmsJxWlZlHVmuXnpQsZRf3HbLghQA==
X-Received: by 2002:a05:620a:2848:b0:7ca:cd70:718b with SMTP id
 af79cd13be357-7cd4679c9dcmr2793394985a.35.1747760891535; 
 Tue, 20 May 2025 10:08:11 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 11/12] migration: Allow caps to be set when preempt or multifd
 cap enabled
Date: Tue, 20 May 2025 13:07:50 -0400
Message-ID: <20250520170751.786787-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

With commit 82137e6c8c ("migration: enforce multifd and postcopy preempt to
be set before incoming"), and if postcopy preempt / multifd is enabled, one
cannot setup any capability because these checks would always fail.

(qemu) migrate_set_capability xbzrle off
Error: Postcopy preempt must be set before incoming starts

To fix it, check existing cap and only raise an error if the specific cap
changed.

Fixes: 82137e6c8c ("migration: enforce multifd and postcopy preempt to be set before incoming")
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3fcd577cd7..162c72cda4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -568,7 +568,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        if (migrate_incoming_started()) {
+        if (!migrate_postcopy_preempt() && migrate_incoming_started()) {
             error_setg(errp,
                        "Postcopy preempt must be set before incoming starts");
             return false;
@@ -576,7 +576,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        if (migrate_incoming_started()) {
+        if (!migrate_multifd() && migrate_incoming_started()) {
             error_setg(errp, "Multifd must be set before incoming starts");
             return false;
         }
-- 
2.49.0


