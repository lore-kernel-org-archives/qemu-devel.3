Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB910FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV60-0004cU-1a; Thu, 30 Apr 2026 13:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5x-0004bp-OR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5w-0004Dn-C1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8fecc5VSTWHnY0CdYsXELtvS880scUEHmF/ygznSek=;
 b=FdXw4MV+/v6c6meEW9KMhMdh633Wh3ETTMRHZ+rLYR6Q62xezfQlOFUtMoMHBROpWU1jaJ
 UTLM7b9feRUkA4Q1yiTwInhqlYeb2bZobsQxjNpuNkoKUZGqM15RuE66vb7t1QlYElNb1N
 +CdOM2bu154p9QU8EMDdAVH8zT66s7c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-lJYfvEp6MpmaLuYyv44Qfw-1; Thu, 30 Apr 2026 13:22:34 -0400
X-MC-Unique: lJYfvEp6MpmaLuYyv44Qfw-1
X-Mimecast-MFC-AGG-ID: lJYfvEp6MpmaLuYyv44Qfw_1777569754
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ae6aa148a7so42007366d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569753; x=1778174553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8fecc5VSTWHnY0CdYsXELtvS880scUEHmF/ygznSek=;
 b=T4jTnME6JdL5Vv+DiRcHpR28wcBp0gNEWm78cLi50Ixlzp2cor2RAi963zTocYxIxE
 9nAhTfTc8DSAp7gEP8duAHycs6RuYSTQHp9h9dWzullHKnu6fOCKUW9EcNcIfrQseKxI
 B5zEAYEmdRSTkgdYQNxSCiy3crkjxO+MCQ6utSahIjgyvhfxp0aKbm9E+AZycarV1/IG
 ad8jstYdzy3JqGpPUfHTzsD3CeGfyelD8kGWxNqK1FTYnsM+4ZtbLf0vAtnWNk+MLc91
 uDtM3dBCKU6IECprK0MWcQOyUK13ne3Nz4OSNagvnsOo5WcnW72CbhrIPrRFug5tQWl9
 wI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569753; x=1778174553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8fecc5VSTWHnY0CdYsXELtvS880scUEHmF/ygznSek=;
 b=PsFTYOH4OFnpliuHxc/FMz2xACrJ0k5wGcDfNRCty1r+O9aFGUoLeU0iyM2PM9kTf0
 Q6NDj4xNY/bjqg1w2SwC4FXg7kWNSQFJvIDpJmOBD8wTYqkg5XSN0LRFtzYvFgp/pUUJ
 8V/gat/UV5ihGjwueUEIMrSssGb24Twc6omO4zJXXwlBo6nsbRR+7Xdg49rmClB3M2qY
 9XMr4vdGBPWtnGoRkNcaOZ2+TY3ZRu6W53BgQoLvBm5FjOvG4T6IwWDRZ0i8XHWXKueb
 5M7dmuh7fDbHhazpgw6rLKN3MPy9VfSX04IsGZp3JFPNJBQWhpW9VPgwXj0VjEeVTC12
 +Gyg==
X-Gm-Message-State: AOJu0YyJa4lE5YcC9SvWPJJYRMyIjNbDn0GSGi2rLkD/moN84yOtGsK8
 VcGnPcZc+2mzmHswGruk5NglVrNkidDs5t+vn8H6rLAvRoDHiCcnVeQ8fs6Od3xy/CWrpfA06TY
 Ev6CxicQ1+7PkV6r83C4nBgZhIuvdiOq18ixUoUN5UowGOjl0UEAc5LysAo9pMFqi/6oCTdvk/V
 zy+os1ZvPA7QSrU0g7X0sFHpO41Q24BNrKhO/vZ712
X-Gm-Gg: AeBDieu3MS2ASIi4viet40MEpOZUtst3ivh+Cb0fK5QAGXnbKKRoXfGsI7Fm8dY97Wy
 a3i4tGKAi69oxlhvhMGxpESn8MVkiy/I2/d8PSFZsTTnsvtc9xUzhH71nHdUYPoWdzIX1Xogp46
 nSCr/h77Ggxp+qnGnehSomTdpeSWCXIrkEN+tE4aSVRCJRP9VYfPQpVQ8DSy+HPoUlJ+zTjeEDe
 yp5T6baLW37kawuHCFUGkW4PUw+DASLwINqYeYMoyCPMeiQwhEAgzzY9xev72pomRyqjQv85NI5
 kPtE9/ol5JTG4+eSCgtqFNqiI1Hd0MtnYkckWKrMo2E9eybfN3nPoXBrAn6lc8quCnYzmc8qThk
 +Jzw2081u5q07i6IT0ZztbkUrz+B8ZLWBj3+PEyJHg89gD9LqTVuHY6FH8NotZ4pADT+Rp8kJYp
 ztm+2vLhf9bZPA2Y2vVBBWBH5Be5rr38e/gjE=
X-Received: by 2002:a05:6214:449e:b0:8ac:b24a:f53f with SMTP id
 6a1803df08f44-8b3fffdac01mr43687996d6.5.1777569753206; 
 Thu, 30 Apr 2026 10:22:33 -0700 (PDT)
X-Received: by 2002:a05:6214:449e:b0:8ac:b24a:f53f with SMTP id
 6a1803df08f44-8b3fffdac01mr43687346d6.5.1777569752671; 
 Thu, 30 Apr 2026 10:22:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff4782ebsm23404726d6.45.2026.04.30.10.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/58] minikconf: run through isort
Date: Thu, 30 Apr 2026 19:21:13 +0200
Message-ID: <20260430172204.1006673-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


