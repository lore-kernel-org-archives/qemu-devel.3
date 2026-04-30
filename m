Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE69FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLC-0007wU-1A; Thu, 30 Apr 2026 05:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLA-0007u8-9k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL8-00035q-PT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VfLYqMZyHqKeWJPdeYOSwKb4EQB5ql3jIF868ZoYDg=;
 b=XTF/ZtPrJIWrKapuB7PhGGkK94pTnQwsrnqxoKXdbRz1Fv4VYLrawYHidLnMQBISfTnR1Z
 XfnxT+s89ba35yGijA50iyqC8uQCJm4a8l3v4fXKdj5gHTFE4DW1sCFqwRU90w9/U5Iyia
 tPWHT5ak9C0H/qtZVFMiBJhclKLmx+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-quKxCLF5P5Ct4UNNnl0Lng-1; Thu, 30 Apr 2026 05:05:44 -0400
X-MC-Unique: quKxCLF5P5Ct4UNNnl0Lng-1
X-Mimecast-MFC-AGG-ID: quKxCLF5P5Ct4UNNnl0Lng_1777539943
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d2cd2674so5213525e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539942; x=1778144742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VfLYqMZyHqKeWJPdeYOSwKb4EQB5ql3jIF868ZoYDg=;
 b=YqQIcUg2Nq0h5baqWBnZIg8dCJ+OVkHMvyMNjWxKXGxoBcFE5IosWrIYNPA3kOjOlC
 tkQ5ZJQnbRYcORFpwRUZKv0dzIaPZSzlE/sC36aO3rRRXBdDbBOWiLplr2e3TEQd5TdN
 NgtzJu410Z2ttZSNWTnbzdRLT0gJXZZoro6iQlNLKNBrk7eCnuqgIPmkrYcknEF+yFAr
 XGrwFEfZHMgoCfH6lS09wqRTz1FmiOd7NWUqIB68QocfsmJa0aTI7SPvbOaBhrmGzxgS
 PSQCCkxBt8b0p5+wmphzN0XubQ7Hl15KxMukm+2Dh3qV5voD/YfLaQcOPBekwNuUYWvq
 OW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539942; x=1778144742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0VfLYqMZyHqKeWJPdeYOSwKb4EQB5ql3jIF868ZoYDg=;
 b=T064nXaT0RrzRGszP4uVyKf78zxtCieAolbpw7pKkizQ5cnbGPo4sZ7R7VE4ZUxpu6
 zCJTTpxxdla5QnwI9kdG4YjRSqEtPx4Ylz/4fkuB9i4duJEyGQuKX7PCFb4CiijiZ3vy
 xldVS6QqfegIXKeddOTsmuBK2QLHnfZQr7xzY/fQi4tUyoVG+0vYXGxXfJz8/bNRmXYd
 n1MAyhwTE2AtAv/UnT/6Og3JJbu3XapinTEUIq+9cJvSd/SJ20QkIuAtrbn2s94uP384
 J4l7RENNen06iIYedGjS8oKa/t1G597Ahc1KO38tzhuH7jYAsfkBECjUEVuc14+2byqh
 vWog==
X-Gm-Message-State: AOJu0YwMg0O5wYHmG1rCzvMBzNvMA3tckA8urKErev/8+WEN3CVhi/sG
 luxqJWnCuXYdHXpoubeCRPinY/hRd+u8vcD6nWpWCt7/pu6mV48lIQQABJ0HJEzjOQ8ooQLeyX2
 PJvL1+3x3ME7px9+Cn5zKhUcz29rivmn8fy9pz5QpduxFvtjCwE3DM+/oKL2IAzpN58O6HWViND
 +Tbpn8OApCjKej59o4BMOT8eKXjInGjVSHG2TXRMci
X-Gm-Gg: AeBDietV5+L/l9BB52EWWoCVQF5nT/EAWapJ4YSfIZ4EqDvfp0YHodbIpK4EUkJiOV9
 awnkWBn64QnHWRlhdaes4b8OJwNhk+xFwV4wZnY0koeGJykB2zrvcDDYi9SSXHxUrKaqirPqKlq
 3jdFTkhCyfmnPmpReWsD73Y8pn1Z3zb6GWv09cUIpJcGzdhvBDssA8Xua221rvjLrl3hxfI0O1L
 Cqt2NEj6AXfrve6U6GkEYXRjq9fUupvxtC5o+FB/5MCR3ZfwQR2U8Ikfk2JrgG1+luEAnygtFA6
 462MOnzRMnY2Q4w0vaKsLACtsnCHDtGhfTwuvpwV8H8PaGeX4Yi0j856TtHdk6m5Nmj00Uv7fYz
 MvKna7aP/I6c59ycPWLLQ3iVPbJulfRdL3uKQE/TPx0yLMHuVi0JbCrotcHsJVPITlnA7vYT75l
 15yrF8LByVT+vEcagpH/xDaQveM+ma6pAf8rY=
X-Received: by 2002:a05:600c:c049:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48a8446db7emr24284385e9.18.1777539941887; 
 Thu, 30 Apr 2026 02:05:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c049:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48a8446db7emr24283955e9.18.1777539941325; 
 Thu, 30 Apr 2026 02:05:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bceeesm52245305e9.8.2026.04.30.02.05.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] minikconf: run through isort
Date: Thu, 30 Apr 2026 11:05:24 +0200
Message-ID: <20260430090534.841894-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/tests/linters.py | 3 +++
 scripts/minikconf.py    | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/python/tests/linters.py b/python/tests/linters.py
index 9696c0b71b8..4ce4e8a9805 100644
--- a/python/tests/linters.py
+++ b/python/tests/linters.py
@@ -25,6 +25,9 @@ def test_flake8_qapi(self):
             ]
         )
 
+    def test_isort_minikconf(self):
+        check_call([sys.executable, "-m", "isort", "-c", "../scripts/minikconf.py"])
+
     def test_isort_pkg(self):
         check_call([sys.executable, "-m", "isort", "-c", "qemu/"])
 
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 4de5aeed11a..24389763db0 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -12,9 +12,9 @@
 # the top-level directory.
 
 import os
-import sys
-import re
 import random
+import re
+import sys
 
 __all__ = [ 'KconfigDataError', 'KconfigParserError',
             'KconfigData', 'KconfigParser' ,
-- 
2.54.0


