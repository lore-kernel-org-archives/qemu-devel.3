Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D8EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYk-0001J1-UG; Fri, 02 May 2025 06:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYg-0001H0-Oc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYe-0000kQ-MI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzRX5l4/8S+wmKPEV9zweUNzezcyi85OyNacxdgQyIo=;
 b=cA25XMwGKfqdWRXDpPs4fkStFhg7vNYuDSFuAqDWqGyMtRIAj8TJkq+d1SHzsgypIpYK/q
 cus5UuivNpAbBX2kxXFKXjHsWuhHNZQCJM8JJK/RFAliImbf0gcHShWPVMk962cgWWA4Tl
 bn2Wyyr/gM9H/PEbwQz78oO0YbJv/uo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-1ovr3I_gNbifhneQ5DwSQA-1; Fri, 02 May 2025 06:23:50 -0400
X-MC-Unique: 1ovr3I_gNbifhneQ5DwSQA-1
X-Mimecast-MFC-AGG-ID: 1ovr3I_gNbifhneQ5DwSQA_1746181429
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso8493845e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181428; x=1746786228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QzRX5l4/8S+wmKPEV9zweUNzezcyi85OyNacxdgQyIo=;
 b=Mn2WkalZU5paOGaYa9XomIAfifoMFhONCMVe+2+maTb5m1CLr15tKTKGOOUM8lgYMy
 IIBuzmmGRI9i3wCd6OQ3xShSx6buJDNvOHAXS1jOkivjbewH7I0PLScVt/AaXJjRYBm8
 4KmYYWAZ88OurdE56Ziv6ySYJ+LeH7WtMynuQZaIWWESLNyQ0IsrmTaTtiyWq9FEMAmH
 kKdWvH1fyz2WftsN7rBEoEnhT+fZk22PhAAbhfEx//qoYIhhvhz/PfbZwZ1SNE0OF2XF
 tzwG5gw4Q7Lls0cFP45p4jlOSxws9NSO5n+AbTcqDZUsx5DsLgFnU+bRW4I+bjeF6Y2g
 9ngA==
X-Gm-Message-State: AOJu0YyMAltP9l1p2grPWKR0o7trezUKtw1AnHuUnRpzNJjbPzkFU8s8
 YgG3nvwDAK3ob+DTg7psE+Fznere+vJgs98nnrabNiRCKAVGKxkBUKGyBjZiJd6pbeI20Hekfe8
 147FRscIUNKHdfeat3DTygjNBz7kwc7chV096E73TowQsp3OdOS5rZGd9g1HuFDAjeDSD7Oms8J
 v31ti+wwbrXfA0jTuytki1FjOHdtVrG3QeZzsk
X-Gm-Gg: ASbGncvKwsOioMM/mikopBs+UzacCUhlH2UKC9e1qSL+bwC/g9OyUY+j8RY5ePDRPJB
 mpmg/uxkIIbkcpDT7SG3e7f5aLs5v1LTYg68vj5t+yZySWHi7ZTQ7EXYtSx/A58h+YEL2M+0LCB
 ehekNawKxgbIkrN/rYzCbAAqMD+paZJkSG1oIorAZ2TnZgXJFKtB9rXlmn/l6EVb1zZYhxXIy6M
 xW7HzdVr9E31+yRopuc6QZA+nve2vEhnddAlOhs6JV8DqOQw2UoQTlYEg1Eu1IjAosSuhYv8nyG
 9Ug2FArIsNATAI8=
X-Received: by 2002:a05:6000:1e51:b0:3a0:8819:3b69 with SMTP id
 ffacd0b85a97d-3a099ad61afmr1230259f8f.21.1746181428239; 
 Fri, 02 May 2025 03:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMCuL9/GFEL0oohdP93JrNdFJ3TfQpoPEVsACDzA5eV9MT/4vPp30JD/56X+ULw6GdjstbZQ==
X-Received: by 2002:a05:6000:1e51:b0:3a0:8819:3b69 with SMTP id
 ffacd0b85a97d-3a099ad61afmr1230237f8f.21.1746181427702; 
 Fri, 02 May 2025 03:23:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0bb5sm1727497f8f.7.2025.05.02.03.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 9/9] docs: rust: update for newer minimum supported version
Date: Fri,  2 May 2025 12:23:22 +0200
Message-ID: <20250502102323.104815-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove leftover notes for Rust changes between 1.63.0 and 1.77.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 92550d9d581..4de86375021 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -71,14 +71,9 @@ Building Rust code with ``--enable-modules`` is not supported yet.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
+QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
 are missing:
 
-* Generic Associated Types (1.65.0)
-
-* "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
-  the pinned-init create).
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
@@ -103,12 +98,6 @@ are missing:
 
 __ https://github.com/rust-lang/rust/pull/125258
 
-It is expected that QEMU will advance its minimum supported version of
-rustc to 1.77.0 as soon as possible; as of January 2025, blockers
-for that right now are Debian bookworm and 32-bit MIPS processors.
-This unfortunately means that references to statics in constants will
-remain an issue.
-
 QEMU also supports version 0.60.x of bindgen, which is missing option
 ``--generate-cstr``.  This option requires version 0.66.x and will
 be adopted as soon as supporting these older versions is not necessary
-- 
2.49.0


