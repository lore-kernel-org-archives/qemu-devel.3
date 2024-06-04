Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C3DC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwV-0005XQ-PQ; Tue, 04 Jun 2024 02:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvL-0004Ei-RH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvK-0007Zu-CF
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3zBoQP1hiY+/+l3optnBxCNybf1DH1hAS8jMLWIU5Q=;
 b=Xo8mvFc8i+b1xI+Wufgc6oynk6GOYuPk3VRb81qpTqxCihr4B2Fvc3Eiotj5hJWYVO2UeY
 rLkqX3XIc6pX/GUtDtJ1IZ2EEfD9yogGxJFxdN1uhvGx65/ayMwDw5qlm6/LgDR7EVxIWJ
 yr7eWbphhsa4nE4NAzgXfCTEb/OQ11o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Ap-Mm33eMHSU1TcASXvIpg-1; Tue, 04 Jun 2024 02:45:29 -0400
X-MC-Unique: Ap-Mm33eMHSU1TcASXvIpg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68ee264225so92329066b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483528; x=1718088328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3zBoQP1hiY+/+l3optnBxCNybf1DH1hAS8jMLWIU5Q=;
 b=mneN0t22bo2F3Cz3/wGUEFIA8/mzkIxPG7z6K1DDxHQGwAsN8zLHXonbyhuikcbOGu
 v+XhTnk8R3OtM7fN7/kAkB0g3NhOhrkWuvzWtF6Pa90prVE3/EqQ1PhOkGyYnHvcOhrt
 mk7xdG+eKLVI1TtSLhdNhgXoWQ2tREylkSkqN8bz4EBsUZDodWPk9GzBhiQvZnyKVUG1
 MUlghJL/ZOQKHRRBi433lNppxoLaEzMumV9yF2AGgpq2pH+V4pXyWwNRUmom34Rsq+lb
 8rLlJ4SBgqkKYnYSl/PY24fMgix3tR44m2imyOQSZr0cischUX4JoJ9eb7iuQpXqTAC6
 cqIw==
X-Gm-Message-State: AOJu0YxGOoXeFBJ9hTyH/m8+LWd7wn1YAIMsXNaNz21lsDOSyJa0bBkX
 BsKwxX46BGARtMW+GqStM3S7FCa5rRG4YKHQpghlDz5LeP0VAJ4/uOtu/JrJu5xlzqy1ql5YfIR
 zUkkr0wqUCwlKpBJpd5VuCksw0S0D3oQAy4S7QqcX3d2pDPNUGVSuKrZ1B6wtYpZgYU4s+TTWUR
 r8/oYxxizEVJ/5O1zndpvXooYkXv3j2qBzZDxv
X-Received: by 2002:a17:907:9046:b0:a68:413b:36f1 with SMTP id
 a640c23a62f3a-a68413b3739mr676303466b.32.1717483528252; 
 Mon, 03 Jun 2024 23:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI3Uhjh83MQCKuTSMBdkT288C9oJxw+fB58J2xHQ/WKBJTbyCNsZGlsyGZtr9xP/Rch0WVyw==
X-Received: by 2002:a17:907:9046:b0:a68:413b:36f1 with SMTP id
 a640c23a62f3a-a68413b3739mr676301966b.32.1717483527859; 
 Mon, 03 Jun 2024 23:45:27 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ca4d6570sm401527466b.28.2024.06.03.23.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 26/45] i386/sev: Don't return launch measurements for SEV-SNP
 guests
Date: Tue,  4 Jun 2024 08:43:50 +0200
Message-ID: <20240604064409.957105-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

For SEV-SNP guests, launch measurement is queried from within the guest
during attestation, so don't attempt to return it as part of
query-sev-launch-measure.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-13-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6525b3c1a0e..c3daaf1ad50 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -795,7 +795,9 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
 
 static char *sev_get_launch_measurement(void)
 {
-    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    SevGuestState *sev_guest =
+        (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
 
     if (sev_guest &&
         SEV_COMMON(sev_guest)->state >= SEV_STATE_LAUNCH_SECRET) {
-- 
2.45.1


