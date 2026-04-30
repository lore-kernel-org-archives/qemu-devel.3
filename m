Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD71CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV69-0004gX-S0; Thu, 30 Apr 2026 13:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV67-0004fy-DQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV65-0004GS-VO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sLEO/HdwvhM9eov1goIg+f1P573AH4+S4G4nVnNMjM=;
 b=U7NbaLLoMkgGMvyholvoQfhwZL8Q8MFcRMjnmG3t4+dJbosiSlyyM49WdJ+PExq/GldYq0
 nlaqhoEz2yj3Lnyequ1go0GlORrdw3p68DlBRhDnRd96he+o6nrEPo3ucA5pJ1NhVe5lh0
 0QDr3smQYgGGtrSr2SDQuAD3TOlsIFM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-dY1Mu_1mOsySOkMc1UEhvA-1; Thu, 30 Apr 2026 13:22:43 -0400
X-MC-Unique: dY1Mu_1mOsySOkMc1UEhvA-1
X-Mimecast-MFC-AGG-ID: dY1Mu_1mOsySOkMc1UEhvA_1777569763
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d812c898cso28614581cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569762; x=1778174562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sLEO/HdwvhM9eov1goIg+f1P573AH4+S4G4nVnNMjM=;
 b=Y8Mk6CUBrova1yO3dleamEo+o50h8uz+Kgp2g3HxXj0Jh1kJ9kZ6yBaD6cLPq6f9Ky
 mOxqlWjTyuMRbM82PDpaQVFUq9BJpupAVyUPMKx+hFtXEtl15Fx5thJu89VDiOWYJrE3
 ouRMrkJ0K06LXLN7h0NHV1XoPS+Odr97UnU/iBP5ABc2porBXTw4+r+oXmYo+3XBMGVN
 vUz4cuzrbLwBqzhUBiiKTq0WS9dfFEyJIjB9/pTIyMqPCD/tQA/HrX6Xz1drdSzIk7Nr
 ArqTVOVsLXPsVDtyiIiMm8gnYJqS7aqMDQHCF8Jz+b0Skapk89Yf8a274s41oXBKG/bL
 pf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569763; x=1778174563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7sLEO/HdwvhM9eov1goIg+f1P573AH4+S4G4nVnNMjM=;
 b=OvH13j0zyMUvfqozGUzU23fc4aO46xP4n5iySrAZ+b2jtT9LKiY1ZmHff+YMnj4yne
 huvc5eeymVw6yd+TRbj4AzJUHVAErmYYyCKuQ95NuSr24m4BuouxhAkvRnepXR1NRJ3j
 IrOaBGtOo3rtNeY5boRe6Us6wdkXZ4HsoJD5abHICdWXYeQpzfDisUmqtrAYxwU7UQic
 1J7moVsHejYpJUGKDC//oUAo8fIas0PRhhkEdaUZx35Em9do/8AKB1XQVbDhMe0rxv5w
 ZNvX9m1DCNzRoyHl+MNkHOlYTW72BzcXa6Uym+PeoT65EYxh4STh3BNZU3d5XCsaldSu
 0fNQ==
X-Gm-Message-State: AOJu0Yxrz9jTzaAiP4TzyJnaZQXs4jJuFiXFEo3KWGC8saD1BUpKNtM3
 cZQzHXsNKC1vE8XHitEJAAIeQ5PAlTfBIM3vAXmhgQSs3C1wNykL10W5WgV8vl4NRD69I4U7pA1
 wP750If+8tl/ZwDa5rnYchiUCP5tLCWkYjy71yg0Z3YZ/G3dhPtBMS9BOJn+xscUhSq4bPGTwlZ
 rpoSiDug0fUnMpyF/EOyYoSdcBDHFxW+64z0FPAXKZ
X-Gm-Gg: AeBDiesEb1qoJq0ueB+xw+1H977CsWFrMxYvMaoDDTvfVD/OS0/RmfsgATkOcfEV3A9
 piKtSjPCldVBDCEKcJje5Cvq/Qbsk8XntYuMdySAQbw6r1cX6C3kCsfBBNUg5PvRKKX86+SVafW
 qrRChxkbZA0l35dpZ1k2pXYDiy0XJcoYulkdJ+FjfKamwPppqvcBwyPl78BK5V8VOs2pdPfvAec
 aKxbc1oVyYusMF7ncBad/YwmgrUTQhVQDlH/PgP6pXz3kB4wDHkHqNf7U8aOgfCM8hqWcUHCJ0Q
 eCM4Q8WnidoAhQA3TRhObckfya/ffDjrh0LWgC/u4tz3TAJkiwlv6QniANpCYVpWNWEmx6eFbLb
 bpSKL1nXu4HK/Jmer18VvB3HyXFph5Owntqo66wDZMhI9yXghLm/GO+YkhBcjxVLLYWY3ewb//n
 Sy+DPf25u4TyTqOP2YzUHalAKwNWdx56oPSoc=
X-Received: by 2002:a05:622a:a:b0:50f:b67c:a5fe with SMTP id
 d75a77b69052e-5102adf16d2mr53504121cf.48.1777569762619; 
 Thu, 30 Apr 2026 10:22:42 -0700 (PDT)
X-Received: by 2002:a05:622a:a:b0:50f:b67c:a5fe with SMTP id
 d75a77b69052e-5102adf16d2mr53503691cf.48.1777569762061; 
 Thu, 30 Apr 2026 10:22:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d2f8080sm282451cf.17.2026.04.30.10.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/58] minikconf: fix type mismatch in do_declaration
Date: Thu, 30 Apr 2026 19:21:16 +0200
Message-ID: <20260430172204.1006673-11-pbonzini@redhat.com>
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

The set stores strings, not Vars.  Because of this the duplicate
definition check did not work.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 668de577d09..2656d364920 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -262,8 +262,8 @@ def visit_fn(var):
     # semantic actions -------------
 
     def do_declaration(self, var):
-        if (var in self.defined_vars):
-            raise KconfigDataError('variable "' + var + '" defined twice')
+        if var.name in self.defined_vars:
+            raise KconfigDataError('variable "%s" defined twice' % var.name)
 
         self.defined_vars.add(var.name)
 
-- 
2.54.0


