Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B10D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3MA-0000pa-V6; Mon, 15 Dec 2025 02:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Li-0000dF-Hf
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lg-0000nb-Ar
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=Mc1o9GVy0/CO0fzi3bBFHbRPAeEmQG0O0JpoCtnxhYdmeL9oXeEekoqymorMrEjAJGXnI7
 yEarhXFdiNL2M/iVRj1E/dNntCiLjSiIWqEoh6cNb791iS8sUGyaNJlH2UAhM2fvJC1Lbq
 WiOAwOm6lRriQ9D52Nr0DhnAOmdZGTI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PujjD2_gOFKnoWbrT-INew-1; Mon, 15 Dec 2025 02:50:26 -0500
X-MC-Unique: PujjD2_gOFKnoWbrT-INew-1
X-Mimecast-MFC-AGG-ID: PujjD2_gOFKnoWbrT-INew_1765785025
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4d3so519982f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785024; x=1766389824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=ib71a8Vp4L5H7owd8pYx1S4o/IvZ4+iMxVycjqpjnkocikj/4FFVjNpcfqqJHhXC1z
 VKZ7xNpRp3zY2ZMMGmhxcsctizx+TH7DdUqT68yTRsESnFLUX8+KZCBgMnZX3juVbhpK
 +fAna5bhyiErgjfG4oJJJjfOHIF8165wZNjyCHCc1l/afjyU3YWf800o2c9wgMmnytY1
 Wvnv3PvSMo9ikgmhySVSbW9sNsdR0Xl2ZgadYwPm6gB6Ht56vc+deo1s5ogiciVha8i1
 FSPQTHOSV2cV8GQAH6ADa59vsmI2my9pHfSEkNDjxrVjkK+mYJ+L7f1LhuzsbCYvaRjU
 by/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785024; x=1766389824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=YRDm1TvEt4PGKjSJfo9+pblA4zhO+QOMkWha26vMcs8NwHApUcN3V7NyMlSQd3GqfL
 YEcwA35e39XIfhm7iRpDGXoRuSQ6S1aS8s62v35NeXtCND4TDt9c8C1RwcwT0BHB+Q5k
 vhorP7m2fPh3vJLj87y3TvWaFBO40ENffOGfLPT0WFjikh3hU+i1rc5ZNv9rmzE5hjPN
 TflaZIMjfMM59CLiMzloOj6RRlwc9fmZYPtLG6MAieevFOm73Fmg8WufhvweMA8OZCl1
 b1Jc2UF0vIoNKpKXLqzabnmjkZeXLe3ZZe9qdMZyRAEB7Pwam3OuSYYNB6AerDuDaSWK
 d7Bg==
X-Gm-Message-State: AOJu0Yy+9zKDmp0rHarTEgAb+2OZPIrI8XxX5cCajpWcndiwxemW2J+a
 2fJbqUDAi08ALLdeddYXOdsM+rzPwt2wcXFVPMGQ4c0HmHl4EI4KWiVHqKtq6Lsm5SD9TcUu4l6
 ciGjBJFXLEG/YF0HjpM64PKsr3l5IZsyHCiDQp14ntXOmG5i1I98wH4m2aUjOX4i843iiJYXdhc
 zoCbaFgFNjLR9hg2v1t+2HkaxzKbjrRflnBSYNWR3i
X-Gm-Gg: AY/fxX7ZRupBolIbunRLaUGeKj5nhI6jPyQvaBfnaUw26UHq2ywYewV/bIjX3PeYnoN
 rmAH9TB/FtdpJ3bj9MLynb3Jmy3Bx1oi8ZJewFd74tcg3eFjSU3DhD2uZMradIQWDbnHVU7bF6S
 p+RVG+mxgi1zocpWhvGUPQN/5XvDtNTnZrdqFDfdS8cYUYGolgODpVjaYG1PefDOWnA4pdFC7Rh
 1DnYDnxlVedAAqLGcIHlbD2xMiY+h7ZRN4xOsod0RVjLS3km14j0yNEPcVLq0UcksVlXQi9D6y8
 ctWSFtXbeerGeO76J/LB6X6Ii94YdTUCJ2Z0Fhpn8riUlK1akITaPIn/cxDwnog0XEmaLdMgxgg
 DpwKOswQWDRgqIzsUCQ9b+boIososkG6y8qU+5QsBZaOkb/5FdCvjvk43tE1fbPC8k2bhDkLmoT
 gaboaXvnr+vqAaUlQ=
X-Received: by 2002:a05:6000:40e0:b0:429:ca7f:8d6f with SMTP id
 ffacd0b85a97d-42fb3eb7fcemr11515252f8f.15.1765785024347; 
 Sun, 14 Dec 2025 23:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzr4Qa7z823ZKf6NrADTVTA3K6/TM8v0csmwqncT5+jfA6CptT+1C3N2l/7wFRzF/o7SAK/g==
X-Received: by 2002:a05:6000:40e0:b0:429:ca7f:8d6f with SMTP id
 ffacd0b85a97d-42fb3eb7fcemr11515224f8f.15.1765785023871; 
 Sun, 14 Dec 2025 23:50:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f1fa232csm13332149f8f.6.2025.12.14.23.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 08/11] rust: skip compilation if there are no system emulators
Date: Mon, 15 Dec 2025 08:49:57 +0100
Message-ID: <20251215075000.335043-9-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Otherwise, the Rust crates require the corresponding C code
(e.g. migration/ for rust/migration/) but the dependencies of
that C code, for example the trace files, have not been built.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/meson.build b/rust/meson.build
index afbeeeb47a7..bacb7879102 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,3 +1,9 @@
+if not have_system
+  subdir_done()
+else
+  message('Rust enabled but it is only used by system emulators.')
+endif
+
 subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
@@ -30,6 +36,7 @@ subdir('qemu-macros')
 
 subdir('common')
 subdir('bits')
+
 subdir('util')
 subdir('bql')
 subdir('migration')
-- 
2.52.0


