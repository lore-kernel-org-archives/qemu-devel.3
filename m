Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA80C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY1e-0006Jy-M2; Fri, 23 Feb 2024 11:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXho-000536-HT; Fri, 23 Feb 2024 10:43:20 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhn-00065n-4H; Fri, 23 Feb 2024 10:43:20 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dba177c596so7080265ad.0; 
 Fri, 23 Feb 2024 07:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702997; x=1709307797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO+NKJ+3Dy+CDPyb9WGb2hSYId/P5Aznfwy/ttcELlo=;
 b=SveWfWBE8xq66js3xJ3l3H2CPhKLsHvnlQNfLzMpgFndKPl7/nMS3r/GkjKlK7Z67G
 LPg/d7+YX1X9udHnWt/qRs57TD0vuoUHgGQg9HIkHdsYKfbpL7wcaxJhPemzA0RPfqHe
 lRJ43MxFhv3IyAzW4iUlrJ9COx170aTx2H2Di2THSRpOsfxVf+9ADBMx7qNf2OSi3WZp
 2Y1HMY9+oC/wiNacbJNr7weHPKXnHjjaQP3g/ZT8fdGlyO+qWzvwt4mBzjFtGkzO9sFn
 Lbe1Zgd1SkSeqmmi9MG8JlzpaaXyQx9+OEzv177AC+2GlFyKBCAe5rIKEgxwmoT8J+21
 oAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702997; x=1709307797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DO+NKJ+3Dy+CDPyb9WGb2hSYId/P5Aznfwy/ttcELlo=;
 b=XO+9OUqIzherotOnporbxsyPKd6RPWTIz7pPaXBX3sPUEPekPykKtsBm5vexg2eVa8
 q2SnBpT9Y0rRZIvPQOTdHtp8e9SiDH3NLLZYSAC50EmGdgOGx9oOTqTAF2XFUcm/+FVw
 MlBLyuyXYI5YOwJaBABvYWLRFxjjafYEavJlDb2TDpVv1snFg7gn3L8+ganNUpruzKSy
 2T7vQxPuBgTZrZBIJoHi92kTjRoswN73o6Wl/DWoP6tyk08/SNTqLKbwq59VikpdYnwb
 NZchQpB5ySswfn466BehqVj6QXQ4QzmDzxLd3tmJ1vLKh2APPrIc085cYWNRnf0yAJ0G
 95ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGcTAkIgSCv67HqKbZ2auEeXKwra4OMCsUsg+PtKuXqb5j4PAFRfrC913n1ZAZxgXO7nhaGbWjF9niC80zghX1iM5C
X-Gm-Message-State: AOJu0YxboWLN7ub7/mWFuBeBMBKNSq7whoF5V+Qw1MrS9Y5phllZhowf
 3ijkpm32w3uLchz1wwANppXVhf7hSvQmDaY/WArk9/RzWFybpmu24ZM9wWGs
X-Google-Smtp-Source: AGHT+IHsAQtnBhJp7NYP2hh+MKyn05SJETvVUGOfmvWSK9BaJz3TiEmMP0dvFbewdPNeUcBmsnuBnw==
X-Received: by 2002:a17:903:18d:b0:1d9:30e3:ea84 with SMTP id
 z13-20020a170903018d00b001d930e3ea84mr206469plg.2.1708702996996; 
 Fri, 23 Feb 2024 07:43:16 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 07/47] tests/avocado: Add pseries KVM boot_linux test
Date: Sat, 24 Feb 2024 01:41:26 +1000
Message-ID: <20240223154211.1001692-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ppc has no avocado tests for the KVM backend. Add a KVM boot_linux.py
test for pseries.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index de4c8805f7..cdce4cbcba 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -103,6 +103,15 @@ def test_pseries_tcg(self):
         self.vm.add_args("-accel", "tcg")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-machine", "cap-ccf-assist=off")
+        self.launch_and_wait(set_up_ssh_connection=False)
 
 class BootLinuxS390X(LinuxTest):
     """
-- 
2.42.0


