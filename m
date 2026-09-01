Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA886C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MEp-00051c-6x; Tue, 01 Sep 2026 07:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1MEn-00051P-Ed
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1MEl-0001Sl-3g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788260465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c8eM6II566DxYYtBXArEMnM0DOInzht6yzfrZidUejE=;
 b=UZfypS8T15SkotUt/oQTiunn3kVvkYVkrJ3fVvkjhsR7E/zPp2mL8VMNokfhTg7tsDDDz5
 5wg7MsMMXC5esUkPOBJS0f3qC0HtF/HM43Ku6FaHA2k2ZJa2+Ti4gLimB4z/kFrHR+cZ3I
 7UZbwtA/E5bkBuaOaroB/WSd42EZ6Ek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-MGHDeLOfP0mvEZKYsVMJvQ-1; Tue, 01 Sept 2026 07:01:03 -0400
X-MC-Unique: MGHDeLOfP0mvEZKYsVMJvQ-1
X-Mimecast-MFC-AGG-ID: MGHDeLOfP0mvEZKYsVMJvQ_1788260462
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cc954a3edso25865835e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788260462; x=1788865262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c8eM6II566DxYYtBXArEMnM0DOInzht6yzfrZidUejE=;
 b=Zvih+R6ORRsC5IVGGNWNjSGw96olFJloKG+0UztBZynLqCVXq7aPbYWeZUS+scedmB
 Vmof/ZatZK/2JBD7PV4uhU6WUvV43/PFMDzMLUENFYzPqPJtRz/Lru6IJ7LAsJm6N8K+
 sO2YDoitYseoTRFai/Z4cwtFISqOtkcKaTr4AJ0WGYCHV3h3gqyyTh2rKkMrsFHvjAfB
 Jpb9YBr2z1N9SCOb16zinf/Y2vI5nue4eNPvBwfL6NcbpaDQrNdEkBbHMfAYI5PS2mgM
 +scLdHQTxuFlyAxeDn3/jDx5W24bNeHkO8fNafGxvThrYfLI9KnMWvv2sO8XOL1A1+wA
 Qc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788260462; x=1788865262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c8eM6II566DxYYtBXArEMnM0DOInzht6yzfrZidUejE=;
 b=fAQkhhe3xyMtxzWlpy1sYDBYQhBedwQ/xWbXd1Wm2PNLqb5dcPgo5/MbgCWhCzT77I
 J25+0Y7mrYk1sZo6F35tKuXPrENn0S+ihmwERMByt+0TCTKaxQsCBToyb5I75SS5KJAN
 +Albnkugd9ZjN8pb/RAJElUzFNf3RZcCuNSlEFKivaXnHv9qklEtgqLQjyxn5heEvDRE
 4M9jWlxu7YBXJ7sqS/DDB5RTIr6RBJhglTaQYzPWTOHBqjyeERR+A44GNpO+5ro7RlgS
 lBkS2hKxqbJcj8Df82dsyV4ifJi1TYPmgXvyAajLWPVX3IMfXV8v0JtqRg8OUY14eTqM
 ee+A==
X-Gm-Message-State: AFuF++lrRIl3n91Yu2GG/GAzW1+9B2wxIkOJQAGvRllvBt0qwXJWv664
 yQSEj3Y1BLMUdq06Xg6hVAXfLPmRmLPb13+Yf78MY58Iz28ILkq5TaUBeHe5+/n1JDacUQzZgPu
 2vIzSvPUqCVFyBFveX1W19tNTDdiHg8nAl6StFMBe+bRRK3uxC/XSfjcso3HmQgPbcgoiSrLYdy
 4wWMYMB6A497iDt1A9Rxd8HCIXBZND8SwCzePxUaPK
X-Gm-Gg: AR+sD10i5FLg6CtRRMhBt0HhVIa6wD/e83sT2GT7xEIBRBCyqS8k1xnUxTmjFVWW3WV
 v94HRQplUzrpAKYOFuCJ12th2pZq3FJI0CV02jm727NcflHeccBoP0yKc35WBQwCeynews+wx2Z
 N96960iiTeTiTI3fyTdBreSuNobK23KtLBWnOi9/4uGwFK9UKkMcpKVmNGKZ+s2BR6ZvYYGHg65
 tK9CC09QaFEvUHb0XRzMG3aPdgTQznva5BV2FxC2KJdjLfqjLUYpLGTBIu7pw93jbBiA64CfuOm
 cZtLbAtlmHGyRdQKUxpt3dqrupJ3Zd/Av29zneUK98mk4vZktnrDtsREtRFbLpn0x5qYQUXqRmp
 0RDUJ/NkMWq+RT0XMap0D8QDS6XG/sO3iIIwGvUt+3cuocYzC8MeMeCFQbC5p57HmqWwfuJNulI
 zVEzM=
X-Received: by 2002:a05:600c:1c27:b0:49c:cfae:34d2 with SMTP id
 5b1f17b1804b1-49ccfae35c2mr327707255e9.4.1788260462169; 
 Tue, 01 Sep 2026 04:01:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1c27:b0:49c:cfae:34d2 with SMTP id
 5b1f17b1804b1-49ccfae35c2mr327705585e9.4.1788260461472; 
 Tue, 01 Sep 2026 04:01:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm744461215e9.2.2026.09.01.04.01.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 04:01:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: link to website for IRC and mailing list
Date: Tue,  1 Sep 2026 13:00:59 +0200
Message-ID: <20260901110059.191022-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide an easy and always up-to-date way to get more information on
how to contact maintainers and other developers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/conflict-resolution.rst | 7 ++++---
 docs/devel/index.rst               | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/conflict-resolution.rst b/docs/devel/conflict-resolution.rst
index bb25f61865f..b6122323978 100644
--- a/docs/devel/conflict-resolution.rst
+++ b/docs/devel/conflict-resolution.rst
@@ -18,9 +18,10 @@ How we resolve conflicts
 
 If you are experiencing conflict, please consider first addressing the
 perceived conflict directly with other involved parties, preferably through
-a real-time medium such as IRC. You could also try to get a third-party (e.g.
-a mutual friend, and/or someone with background on the issue, but not
-involved in the conflict) to intercede or mediate.
+a real-time medium such as `IRC <https://www.qemu.org/contribute/>`__. You could
+also try to get a third-party (e.g. a mutual friend, and/or someone with
+background on the issue, but not involved in the conflict) to intercede or
+mediate.
 
 If this fails or if you do not feel comfortable proceeding this way, or
 if the problem requires immediate escalation, report the issue to the QEMU
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 29f032d6a82..6f9ff4a0b91 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -10,8 +10,8 @@ QEMU is a large and mature project with a number of complex subsystems
 that can be overwhelming to understand. The development documentation
 is not comprehensive but hopefully presents enough to get you started.
 If there are areas that are unclear please reach out either via the
-IRC channel or mailing list and hopefully we can improve the
-documentation for future developers.
+`IRC channel or mailing list <https://www.qemu.org/contribute/>`__ and
+hopefully we can improve the documentation for future developers.
 
 All developers will want to familiarise themselves with
 :ref:`development_process` and how the community interacts. Please pay
-- 
2.55.0


