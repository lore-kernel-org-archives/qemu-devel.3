Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7EFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLI-0007yc-Me; Thu, 30 Apr 2026 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLH-0007xt-BD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLF-00038H-TE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tzzrS5ecz73Iy3hYAnDaiqAQMntarfFddC3xG+/3gs=;
 b=Y6OGl6Hr1kxRxfU5e1ZJNZ52q94ts1OHNOyxL5W+XAMyT1jfMuBpJuM48Z3VSJ68J4lNPQ
 0D1X2NbEaR3IOGL4rqC/r1EcOEGKY+UqNRYt3wsFlXCAOmRIXm7Dg4TyFugEL83dz6EXHC
 Jhsv4lHLvLRL8fRlumWs2IkEoMWlkVM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-GdRjHZKlNUeFL8Jf2qqdNg-1; Thu, 30 Apr 2026 05:05:50 -0400
X-MC-Unique: GdRjHZKlNUeFL8Jf2qqdNg-1
X-Mimecast-MFC-AGG-ID: GdRjHZKlNUeFL8Jf2qqdNg_1777539949
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so7102345e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539948; x=1778144748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6tzzrS5ecz73Iy3hYAnDaiqAQMntarfFddC3xG+/3gs=;
 b=hJGbAHZWkXYFyRPwLnmnXGhcTZj7+TB6M+JwTfsv/5hciGxepIdTYlWVXUVK/q6NIx
 67pEPqEdJx/rlMQ9sbOs7zqjAACnvDHHebfA1V1EwacXLZOB0JMwE1w7vn1bzUeomsv8
 JsFYkyxg+Ynl7xHT0otGiCp374m9KWuGWjZVkis5r24lz4tKkHiAS5MkJvVtYdkXojiC
 YXeP5UmE7h3JSjaqkDMtGdXdq4fijLocXsnKiM4uKA6/yT9ZGyeZTrd2PM/SSlNkPc3y
 W4z4a1ZRp+JhdDO0DKh1HUXJhMQvSW8fXv1LGUH6amjzd5Yseql7sFhI0AAWQuyVUyyV
 rV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539948; x=1778144748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6tzzrS5ecz73Iy3hYAnDaiqAQMntarfFddC3xG+/3gs=;
 b=NvpnJcb+AaFDGzmWWPIz0AOMWdWXzRForW11CeDYKwtzmvvCSfscaqcxdJINtVQ6d7
 qHangpEW40WxWypOEkI9In0Y3o8eGgnSApGEiKabQ/wiWPPLwSkv4NmD5nel588MKyr0
 Wkmn4FY4Yf9C9SCMIfe8fJoutTRo2gPv280CI/8O0lJGm7+x0DA6k9eNv5DCQH24Z54H
 mKcvLuWaCHSXzt9AQTWjccDt1ie1fDrtHcSQXrq0aN0E1rnVIkFygmoO17cnQ3u62bgk
 00h5le1Jmec7OhcVWGPTfrbGfEyB+K3T7CA3zlxUzDWMGGWhDx2YUIQrV+pHKW1RwDZr
 JElg==
X-Gm-Message-State: AOJu0YwsIAz3hq6gkILiuZ7TEzbQRRmzS9hIma90LbLzaXuf8VKZStbh
 ofPxMmoVVmQoHRUkHWbDRZzftpV0N/CSpD52GZiGmbnmdYMuu9OnMBS/Z0Kx4Qo4fcoW1VL5lmZ
 P9ZhPJD4NjOwvGMCXzr5+AfxkuHlf+9xWhFfdX2ffiTsdAKTcTDKY/QwGUmoWVz5DqAOIQq/PTW
 /SDC3FUZxvo4pyAvq72fnbQQm+9NicKLq+UG+4CXeR
X-Gm-Gg: AeBDieuYz9zkTaZg0qhBxeI0TFgFKj0sP/8IffRLVrcxDfOviJm7byCJ16AcO6akqVT
 4oytS4+enO11CMmu1BhqxP4V58N7DEt2n2xuw2OPgk/Nuv32FdGyTd87oMfNFlQ0j96Fb6OQqnR
 AgOYVO9YHR4wC9pxj8WiOxAJRJ5vc7f2QdJv/hH5nxFGQFukCUCxj0ReBbg1IogX7bDtS2UmgUo
 zyoj0X7lvJqW4/NGoA+syQcFR5ggOGwx9wSt8kAG5BvzK/mimc3DsOJWkoEckYVlArzLRawcwqQ
 YSQTR20Ii0gnVraMiErZCmeT3wz8hd1GQRIF+peOhbnlMPJW6YOitmnhX8RRyjck3Rb1c1ktXRQ
 k0nDlJTohECaZqbgbQd+w3r58Va1cn568QjDd8BXR6s53T3HZX+chQ+neYytNGp/YlERdtrj2Ae
 3pRFsyorcuVOVuINAg4frbBeJOArgpuI/dULM=
X-Received: by 2002:a05:600c:c174:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48a84468397mr33966575e9.17.1777539948314; 
 Thu, 30 Apr 2026 02:05:48 -0700 (PDT)
X-Received: by 2002:a05:600c:c174:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48a84468397mr33965995e9.17.1777539947825; 
 Thu, 30 Apr 2026 02:05:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c303c3bsm56350335e9.7.2026.04.30.02.05.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/13] minikconf: fix type mismatch in do_declaration
Date: Thu, 30 Apr 2026 11:05:27 +0200
Message-ID: <20260430090534.841894-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The set stores strings, not Vars.  Because of this the duplicate
definition check did not work.

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


