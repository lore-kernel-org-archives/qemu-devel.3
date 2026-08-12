Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E089C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAfz-0006G7-Tf; Wed, 12 Aug 2026 11:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAfm-0005vd-Fg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAfk-00072Q-Ol
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TX0U+ugy7x+wm20G4gdM+YFRzx0HE5ijHl7s3lRaCoQ=;
 b=i2BOSmqV/JSO2W6/PFoS3zkZLoB6abI4ZrTaJUkWUiu1CfiOCknFDndhcMOFNJQ7tKS60+
 t17Zf30UwBzOIQtqLJT5hd83j2g0spElKgObs7wto86rGPASZ0mHLsiumPdpmxbIRoVepk
 k2PrmPf1HGrxqQ/nVLUskl9HfRyNGCI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-GikNWgtvPeiV1LfX4Fvc0w-1; Wed, 12 Aug 2026 11:15:14 -0400
X-MC-Unique: GikNWgtvPeiV1LfX4Fvc0w-1
X-Mimecast-MFC-AGG-ID: GikNWgtvPeiV1LfX4Fvc0w_1786547714
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso18863601cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547714; x=1787152514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TX0U+ugy7x+wm20G4gdM+YFRzx0HE5ijHl7s3lRaCoQ=;
 b=DZIOBqTORtTism9cRq8A3nAoXiK1s9L3U3cVeBwaGW082LjRECZ2aGKiOaR2oNVZX2
 CpqVhx6PKLL2Wr2o0pyu8o8rxNjuxYBSo3SOuVHfmihtSd4xrbs+qaZD3P2tcVw8Gt6y
 VM4k6ARvHkopYXD1KuY/Wrb/iaZF9WWrcBOaj7lNP1GqczTX0l2qdvgHT4cdnkFqxDbI
 LAyulOTpzIF2uAHPJRShHVvw0IWr2YCW4W8KTNn/f2EoGl0yuv+3yl4aWhuKpVCnN0mf
 2UeHg8lMzu/qvhlSXL5Brsb++Upf6tcLtjD5iHFpRer9/+nEqp5P9URtDpCF28AwDrXk
 y7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547714; x=1787152514;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TX0U+ugy7x+wm20G4gdM+YFRzx0HE5ijHl7s3lRaCoQ=;
 b=ph2XOnwM7Btdu3u9QOqa/novLxtNCwjqTrVE2/COZljZbVD6x4qa3kd6bI45PRTKy/
 JwfECiVneQ+DteP1sNdXW34vECZmeecYaNecihV1LE2bXZp5rQ4fuYcXmx+vaLNuBCg8
 DgXDSDikQkbZSjGm1DNFAQXPjZx8VU4o2CKq6bcV1aPaSRbodpUcS/EsArTJwmR+q8jn
 LqqYHL8VpJvJGUaxFC2KhABYYgZ44vuKAlvsAhgPaEuCipyNVN78917Temrgk6NbCIhi
 xmh9hG5Xgh+/d7zrfgT+djNklDhOfCDyXiVQNIsxCssOru8MEJv+DVaNvkhMtUmLSlSc
 WJ8Q==
X-Gm-Message-State: AOJu0Ywr0J+vbBka4Mt6v0rwoWQyFNDA9FVQl5JZ9T5LSQelh/6gMh8b
 JzVL60zq5oTkk3nD+l7gIzZ29eVt0XqLsJ/4jYQMNWzP8Wr5tWerV31EaQAfwg64AVOrLCaUux5
 dtKAwF0m/hStdm+VevAIJDfmeKGaH+t29m9fluiiQnbNcYOHby0eyiJExiKl/VlCf22FSYfHK6/
 gjCcIueJuYUh37xvlMhM+pTssTJhqc0SUJrxwvDw==
X-Gm-Gg: AR+sD13i8rdQ1kIPtCjUBmHGyo4AUFs4pqI2yV/3AFLDiVfQBClpXFdevtyLsbk8063
 r3gImhV0EcuShx97q0WdWHA67XPz1OP+AOfa56ZG2cQhj0vFXjMchHcIWKHD0DKUsSB0p6uyPck
 sJ5fLxhyRs3rz6ZBcicSSxoToyEbssTIeM4z3hX0dIaLvUGXDY7qy6JWTSGeHQRxmVFtnU/UWNV
 x6RmVH7VTcJ0nHcqK+NacR0WPLlDKayS/eACQAZpl77oWWdpPkxpWP6Bp83E+ezD4ShVyhbxkRS
 DmY7rgISYS+DEosrdZeeVk9vMgt/LZGUTqDsJYZZGl4MSCCLETguBO02p+8wTk4Yzg==
X-Received: by 2002:a05:622a:38f:b0:527:7d0f:709c with SMTP id
 d75a77b69052e-52d648836b3mr49885961cf.42.1786547713675; 
 Wed, 12 Aug 2026 08:15:13 -0700 (PDT)
X-Received: by 2002:a05:622a:38f:b0:527:7d0f:709c with SMTP id
 d75a77b69052e-52d648836b3mr49884621cf.42.1786547712951; 
 Wed, 12 Aug 2026 08:15:12 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/10] docs: Add security considerations for migration
Date: Wed, 12 Aug 2026 11:14:34 -0400
Message-ID: <20260812151444.2611689-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Fabiano Rosas <farosas@suse.de>

Add the security considerations that are unique to migration and that
do not already fall into one of the other categories. Some aspects are
better framed as security architecture considerations, so extend that
section to mention TLS and clarify that disk images and guest network
also need to be isolated from other processes, not just other guests.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/system/security.rst | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index 52bbf0cc7a..af626a4230 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -133,6 +133,16 @@ an issue as a normal bug.
   that affect the level 0 QEMU process. While these bugs should be
   fixed, they will not be triaged as security flaws at this time.
 
+* **migration/snapshots**. Migration failures and snapshot load
+  failures are considered part of normal operation as long as the
+  source virtual machine and savevm file, respectively, are still
+  functional. Aborting the QEMU process at the migration/snapshot
+  destination is similarly not considered a security issue. The
+  migration stream is assumed to be secure as long as the design
+  principles described in the Architecture section are held, in
+  which case plain manipulation of the stream is not considered as
+  an attack vector.
+
 * **low severity impact**. As a catch all rule, issues which
   are judged to have a "low" severity impact on the system will
   usually not justify handling as security bugs, nor assignment
@@ -159,10 +169,11 @@ could allow malicious guests to gain code execution in QEMU.  At this point the
 guest has escaped the virtual machine and is able to act in the context of the
 QEMU process on the host.
 
-Guests often interact with other guests and share resources with them.  A
-malicious guest must not gain control of other guests or access their data.
-Disk image files and network traffic must be protected from other guests unless
-explicitly shared between them by the user.
+Guests often interact with other guests and share resources with them.
+A malicious guest must not gain control of other guests or access
+their data.  Disk image files and network traffic must be protected
+from other guests, users and processes unless explicitly shared with
+them by the user.
 
 Principle of Least Privilege
 ''''''''''''''''''''''''''''
@@ -223,6 +234,9 @@ Some Linux distros already ship with UNIX groups for these devices by default.
   system calls that are not needed by QEMU, thereby reducing the host kernel
   attack surface.
 
+- Transport Layer Security (TLS) protocol can be used to ensure authenticity and
+  encryption of the live migration connection where the network is untrusted.
+
 Sensitive configurations
 ------------------------
 
-- 
2.54.0


