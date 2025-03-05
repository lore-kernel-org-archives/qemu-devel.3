Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8783FC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzd-0001Cr-3A; Tue, 04 Mar 2025 20:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzB-0007cX-81
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz9-0000UH-Mx
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22349bb8605so121888685ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139744; x=1741744544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHxwppqX+NiAR+OZkag50+4l/nth1KdlivI6n/xfrDA=;
 b=WAY+67opqid26yhsuIUZLsU05eecKgT6YdE2iD9u2Hy1SyygthXeRE9rDcxfOWZ5Bb
 PGmnQZubyR/zTXbP8Tuk48aL97zy//3D3c0FGA/ZlOadR8q01PLN2tESTH9o4NfQSwO/
 TXPY0UIhDod6ZZgyUpdwGMaWRAK8sg4RnW9jK3UONklaguSNJq18UmFRbT/2++SeqRNn
 3O+REVHu0TrPcA2Gvnz23TJ4mnqOsHI4rbLYZQaKdjx5r+Knt1olqKftTpnTPFniLoVS
 uCKCRu4K+Vfa/dclXZCeUTxhvqJzG2F033S3f2HHjhU9pGzWaluyq549kgCP+GDqWl9g
 eSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139744; x=1741744544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHxwppqX+NiAR+OZkag50+4l/nth1KdlivI6n/xfrDA=;
 b=CnAUX1qwoktRrNeNmgUiTYBuHXsrwRy6HfdEGNhVYhGtqzUYKyOehO2ZTeCFDCeaJ7
 63NKK60k/Wt3H1Clr04nTaoVZGQteYS5QC9n36onq5TH9GpOHJSoM4q6UalqS3bKyWMl
 cyhOgUJCWjtar9JPMA9TmKWrucpjGYBY2xVyPhYlUXR5PftfakfQX8vFkjN7NRlRKYgo
 Gxt7DNUwRdmKF2yk1uDJ6XSFGUBe1tb/rjAeb9kPvgvwjrh184apY1wnlp01aUarwdS2
 m73JFeT4o3ECIObF9OopFwDRg39RjJqKIH9YQwAxnY5R9ONa33lG8AlS7aObgZLDElY9
 nVsA==
X-Gm-Message-State: AOJu0Yzr6F8dNDd5VK5Ky/ZaSQA31Moz05x4r/EHF9FVYkQI/FQ8ggMk
 hLMeHNbiBfGteU1C17p/Oc4Ne2mIUXk104TFJCBx/9qcCcE28vY2eDxfw3WxQY8=
X-Gm-Gg: ASbGncsFL6hZL6OgTmARp2RtVUj4B9fHrRnuXPDbdlbVoDiyuhoVDEZs/TVtY41wlhm
 0BGy7iaiKyRnfNBLgBDxzRZNh3hjOtHJgw3+t8Aw/THWZc6LmlLm4vC2AbWZYAzxwp4Wqt89dsU
 YvXeAJ4FbTq9QPAJCYBrdjX/RNePsGXl9wsJjWGEmebR6Y8S8yTHv41TKvJwdAwLZxYAxw+3GNF
 X8Wu9Q/w7tSJJATjk1biVIaVZrCu0iOj89TE1KXNw/S5xYrSrPOTlM5aH1poqMzZpyjyLNsCcCd
 7NBU4KEe1Frn7eg6jTqaNWiigs7TZ6WRwcUpmNYq6m/oimGS6XeSfkH8fqK4LE6jCLsFegLmvcg
 TwaUZGuiyszSf7KOmQabMc2DOb1m7mEhpfkdFy1sS9ltakZvnmTs=
X-Google-Smtp-Source: AGHT+IEBh7OaYWDy5GEVy0u3nnuUs8+yQ/Hb/75MJcCvd4RA71i270h2Gy9tivzE9kcEoJtOXWaY/g==
X-Received: by 2002:a17:903:2312:b0:21f:9c48:254b with SMTP id
 d9443c01a7336-223f1c9945amr23211635ad.24.1741139744431; 
 Tue, 04 Mar 2025 17:55:44 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:43 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrea Bolognani <abologna@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 51/59] binfmt: Shuffle things around
Date: Wed,  5 Mar 2025 11:52:59 +1000
Message-ID: <20250305015307.1463560-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrea Bolognani <abologna@redhat.com>

This should make no difference from the functional point of
view and it's just preparation for upcoming changes.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20250127182924.103510-2-abologna@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 scripts/qemu-binfmt-conf.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 6ef9f118d9..426f075e31 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -318,20 +318,23 @@ qemu_set_binfmts() {
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)
 
+        target="$cpu"
+        if [ "$cpu" = "i486" ] ; then
+            target="i386"
+        fi
+
+        qemu="$QEMU_PATH/qemu-$target$QEMU_SUFFIX"
+
         if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi
 
-        qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ] ; then
-            qemu="$QEMU_PATH/qemu-i386"
+        if [ "$host_family" = "$family" ] ; then
+            continue
         fi
 
-        qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
-            $BINFMT_SET
-        fi
+        $BINFMT_SET
     done
 }
 
-- 
2.48.1


