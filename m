Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50178CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTTP-0007hB-SX; Fri, 06 Sep 2024 03:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTTN-0007Z0-M6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTTM-0008W9-3e
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725608015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LeK2KxjuVhJiBGezPo0zKQhL87mojsaut9uWjJpnJgA=;
 b=Zu4nj700st8b/imGEe1HZ12NrG+tF5/jTj5lpm2WSceWeQdUP7VPuWU9EJ6dEhLWCRMhXK
 NhQTcCzaN/aGMXDNacTVROCqiaBSYcIpyfUyhAbfSHrVKEg2UPvezYOv0BX04hd/tpVcyq
 a+dkJvNKy+iqVxZXnNOQvpcmf/WiLvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-QdqOLZWOPBC-b-nQXB9jqw-1; Fri, 06 Sep 2024 03:33:33 -0400
X-MC-Unique: QdqOLZWOPBC-b-nQXB9jqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c54e188dso1463798f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608012; x=1726212812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LeK2KxjuVhJiBGezPo0zKQhL87mojsaut9uWjJpnJgA=;
 b=A3ENMJgy30YaLRvjd8qyD6TvGl2bUEFUmZ5qzpzQwLXbNZGow+QpRW4WemEQ+vR6hN
 KyoDCCanoq6Ml1CITJxpk3BGtN5axgjKwjyjFQOp/5VCHYiHgvponF2BzqUYB2cATAJ9
 8/hy+2XcGPAtoMCAk76gKECV2MdDxJG/sYztpL86DMAiabqQmpMY9zXzLipGHDlF+a5L
 jgbd/5B9uy43RWulV4vwTBRYnJwynLBVeUJRETiODHkFJiONeHbbi7G+Pn0/f/Syh2VG
 GlOIACwB9LFV8GKpvFL+vnywRQzAu3EMZpCrY2bJnsfKWFcchgGC2J/aAPgpjFN8an43
 vy5g==
X-Gm-Message-State: AOJu0YyFRXx5ERFnGpqkFCoAbczcw2pe4koFdWgt33mJb2wFT1PONCR1
 NDCZHWaLOdEK6AHIatvurlLdCp+bMTFFSRX7vVozz1AgU89ThAv0M55TBAT0Xp23erNyVrFZGFy
 Z6e84/JywFBGztIP+gpstLG2oq3ku6S2GTlV8HOYaPanTro7fj4E826sMHTV+TlzS7aXA6/VmEM
 tjyrPgNYa2px1ZRGUjx/P7qh7E5LN1ivWlBEvWOrA=
X-Received: by 2002:a5d:4801:0:b0:374:c878:21f7 with SMTP id
 ffacd0b85a97d-37799f5e676mr5000046f8f.10.1725608011662; 
 Fri, 06 Sep 2024 00:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoe8dS41a7z2hgCIjt2i3XFy2EOBDx8XcJFOf1cpnErTdWXMRlHRmNUcr1pv1bw3Way1phAQ==
X-Received: by 2002:a5d:4801:0:b0:374:c878:21f7 with SMTP id
 ffacd0b85a97d-37799f5e676mr5000020f8f.10.1725608011037; 
 Fri, 06 Sep 2024 00:33:31 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cc3dbsm11051745e9.20.2024.09.06.00.33.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:33:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] minikconf: print error entirely on stderr
Date: Fri,  6 Sep 2024 09:33:28 +0200
Message-ID: <20240906073328.492089-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While debugging an invalid configuration, I noticed that the clauses debug
ends up on stderr but the header ("The following clauses were found..."
ends up on stdout.  This makes the contents of meson-logs/meson-log.txt
a bit confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index bcd91015d34..6f7f43b2918 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -112,7 +112,7 @@ def has_value(self):
         def set_value(self, val, clause):
             self.clauses_for_var.append(clause)
             if self.has_value() and self.value != val:
-                print("The following clauses were found for " + self.name)
+                print("The following clauses were found for " + self.name, file=sys.stderr)
                 for i in self.clauses_for_var:
                     print("    " + str(i), file=sys.stderr)
                 raise KconfigDataError('contradiction between clauses when setting %s' % self)
-- 
2.46.0


