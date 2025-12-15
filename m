Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B63D5B173
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3MG-0000su-37; Mon, 15 Dec 2025 02:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lk-0000du-Fv
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lh-0000o8-Pz
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=R/fn9pJ1mBR+njPwNRRdOAjKcjyYcDR89eSYk2i17NOGaq7peIyr+LNkULUkriXNaLAdA0
 qh14YXTmeQwCpjXAUvwO1W0Bu5P+wSRz2KGxS1NI9ZgB3ncWp9PMpRC1X0lsRjyu5a6yS+
 +l38a4ytxnfwnCHdMsfW4aOYcNIKqQ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-mGOha-rLNeqsEhOPqrOksA-1; Mon, 15 Dec 2025 02:50:28 -0500
X-MC-Unique: mGOha-rLNeqsEhOPqrOksA-1
X-Mimecast-MFC-AGG-ID: mGOha-rLNeqsEhOPqrOksA_1765785027
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47a97b719ccso3593355e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785026; x=1766389826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=iVIfnJzbku0cbx1hEzOzAdjt9YarpXW4sRzdKdhSYeUJrd449xm41WLSvHPlnFXh1c
 q5kYBUMm5v0cXvmPa/VgD2ja2x81inDgJxzOPAey6tSjHPN7Ib1sQiWtl2pZvPN0GU+K
 6qtvBHLu/TrM7ayV27y4it/KBY0/wx88d2xTeRgL0EwZt/v1EJZ4WJ0I99TJ6PltyRno
 kPab2sprIybiOgdaJyRkKnKCfUOhGVWGZ+OGuZjBQ0cZN0WAcwxz5dZgsmAVkrxTfDnc
 ky/gDgQ8iYfzQ5BCGFL28WquCnMGyx/jvWHr3XInv6jJpX4+NBoiq07RuSe0VYg4UBsf
 FHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785026; x=1766389826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=k+egwJM9UcEC/6Y04tMGWJRfSKVIX+RsHEApC/lwLywBOE3o5ILbnMeaAPzMGyFOPV
 b3q6CCx9xM0Mfx+wAP9W63J2F0XK2fXzhE/B+3iuLXLW9qv6f6IPkfecGig+2CMUj61d
 NNdEQlvYktlslMEbRvmSV+YKV3U0rOJ08t5dErN5l6ZHZXhJ+vowGOJiPfvF3jyXTzzN
 lbOSke7IhDQCWHXNho+byEwHF09/q6F1YdCKKlT79dpG8G/nYn5Gp3YGpoII1vtajH4K
 /PTuTRgUoAcVbtkTji8T62uAeVCPNVrgyJU3iuZd7kGM2RCVqUc1zX5VuzrQF3ffuxQB
 4exw==
X-Gm-Message-State: AOJu0Yz00blUzytNMVrNpeHWfMCZI3M3NcLhTSF3jkZdfMvv8XTqg4Mr
 1Kxkn7cRFKvhrQTREB+fyHhoqLZPquxJjTRGP14MghUNPoCPAM1epwlqx5P2xAemwadxAV0+Ki9
 ch2UIFjSMIqqrARCMP4jfTS8pf1APNVc19fZd+WLz+Fw04zCM9RycTzlv2X1T2Tq9q33QcPfm7F
 +eN2nbGwhK9WbHZ9/hzZ9sH1ocxDSF1J10117ODpNO
X-Gm-Gg: AY/fxX4DtJLgV0HvXw/MLVFkr27/79lLZGQskm42pRFFBMlDNt4RJhto6r88vd2uBD2
 IWWYZwdY1Cmtk0HehYUAbRykn9VeEPG8k54oDUxrX8+J6eYgSAycOUOEQt4GJMsVzZO4jWA7NQM
 tqN27Ssyfy9IYKh4kpP5CfTmFktvhc5tab3UFXCKF/rOJJDwYDTr9z92hBJVs7XB9KUlnVdc37b
 9Z9XiSVoFl0+rmfGMECF8KXkToeBgauZIqwZxn7l/1NbhDHxH5wqH9X039Gv7HXkfGXzW+Wb37L
 wADm3npeqvyuZmrSVJUxzj6CGDhcN0FZVtx6f5HsMGNiiJ3LCqknuE/p444cbzSDTKUNJYFg8fM
 JZHOVl8SHhtj5iteL+lAyXLTHOiDxI55evnLlaNqrmpmAfnyYQBThhOxgVP4yZxEwveNtfzpR9F
 anu4c0qO4zU0gGgUM=
X-Received: by 2002:a05:600c:6291:b0:479:3a2a:94e7 with SMTP id
 5b1f17b1804b1-47a8f8b1449mr101944835e9.10.1765785026375; 
 Sun, 14 Dec 2025 23:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFp03gBJKeoB+vrkkQzMXKYMOJfHNSIDf9/2sLNziUm3xHT7/4zXr5bXR76DTD24IPowu2Dw==
X-Received: by 2002:a05:600c:6291:b0:479:3a2a:94e7 with SMTP id
 5b1f17b1804b1-47a8f8b1449mr101944705e9.10.1765785025973; 
 Sun, 14 Dec 2025 23:50:25 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f768936sm175988655e9.6.2025.12.14.23.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 09/11] lcitool: enable Rust for Windows cross targets
Date: Mon, 15 Dec 2025 08:49:58 +0100
Message-ID: <20251215075000.335043-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The issue that is mentioned in the comment has been fixed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora-win64-cross.docker | 2 ++
 tests/lcitool/refresh                              | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 4f743c00434..c5e1fcebf51 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -120,3 +120,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9df607a55f8..01a71929542 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -291,10 +291,7 @@ try:
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-                                            "x86_64-softmmu"),
-                        # linking with rust is buggy:
-                        # https://github.com/mesonbuild/meson/pull/14991
-                        enable_rust=False)
+                                            "x86_64-softmmu"))
 
     # We also generate some docker files with minimal dependencies and
     # as many cross-compilers as Debian will package for building TCG
-- 
2.52.0


