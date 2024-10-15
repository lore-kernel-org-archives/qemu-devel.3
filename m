Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDCD2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hR8-00024o-1H; Tue, 15 Oct 2024 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR6-00024E-Vn
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR3-0001EQ-Sl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u45iLCwaL6UDPFZFrxkclA/Jz3UXse/PWIiVqr58mZQ=;
 b=Vbpjts/KDSpUg9e3zbqDwwH3PjkcXVTynvL4RMUSYhCiRX6DJvvDlD+IHdyPNMNVNNZYFB
 qP0KMhWD+YSd8MET8iZfGdF3+w+ZmQkwScCOefB6Oj6eO0zIthnMeeziyf26VD3BLsDZHT
 f6k/ZHkWGtz6MiQEwkCuAwd198RXmpI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-zbt9zO1fPlifDZX_27JrHg-1; Tue, 15 Oct 2024 09:17:56 -0400
X-MC-Unique: zbt9zO1fPlifDZX_27JrHg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d609ef9f7so1322918f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998275; x=1729603075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u45iLCwaL6UDPFZFrxkclA/Jz3UXse/PWIiVqr58mZQ=;
 b=doCxPlKJLCmrMpvTck6WyThV2zf+4mo7P3CVQqoqzi2xyGnekepKIiK65KsLsH7jhi
 StvgUIrNcHNu4brpEX35hq3bpQ7GkuN+MT+GpRBsHM246T/7bXhLD0rLSOfHm10koW+c
 MgSpNbrWh0ZcMWPMw/D7K5PfHt06Q4tmbfSxwjhhu9BYuirWyNLOuPLDzoEC+Xwy6X8+
 qmUEvP4W9GO1FJumFXZMhBom6qVRndOPwU0c39Mw2hO2MiC5GDvCQnD2/NWiEgfF+fqt
 yrRpJ9ptyKkmat4jcfOksoyej/cfsZ5eCNudd2tvU6JD53nzvsD54ix03bv+huuf7fZT
 ksJw==
X-Gm-Message-State: AOJu0YxKf6P6ZGdVcc4h6PLbSMuleHNjl9hbioe0xC/+Iu2ZfEDhD3zc
 xdLJhuF3Dk6CGnAYs9TsNj4QWyW+yP3gDocB4N5YxlpP/FvFDbhJbfbai9p6mINxNNZLanC3LP9
 PxH1FhWE3671O19a8N9Db8/1iHGCoMoA8tVun+EsHeTboelN21PuId7LmQIF9Si0ct1C60I2GMs
 ghOnscDi9ZpqpEB2cJYfW5PPnYVZKuHcMIFef3PnM=
X-Received: by 2002:a5d:5351:0:b0:37d:4870:dedf with SMTP id
 ffacd0b85a97d-37d551d3fc5mr11031840f8f.19.1728998274797; 
 Tue, 15 Oct 2024 06:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVJzhrJlEsj0CCAZU0VlG8SQnJzHqtk7pSGA2WJiTolJ7kHzSRDCGLC3IkWU5eqlMVenSSHw==
X-Received: by 2002:a5d:5351:0:b0:37d:4870:dedf with SMTP id
 ffacd0b85a97d-37d551d3fc5mr11031816f8f.19.1728998274288; 
 Tue, 15 Oct 2024 06:17:54 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa89c55sm1564662f8f.46.2024.10.15.06.17.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] rust: fix cfgs of proc-macro2 for 1.63.0
Date: Tue, 15 Oct 2024 15:17:23 +0200
Message-ID: <20241015131735.518771-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replay the configuration that would be computed by build.rs when compiling
on a 1.63.0 compiler.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subpro=
jects/packagefiles/proc-macro2-1-rs/meson.build
index 818ec59336b..8e601b50ccc 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -15,7 +15,9 @@ _proc_macro2_rs =3D static_library(
   rust_abi: 'rust',
   rust_args: [
     '--cfg', 'feature=3D"proc-macro"',
-    '--cfg', 'span_locations',
+    '--cfg', 'no_literal_byte_character',
+    '--cfg', 'no_literal_c_string',
+    '--cfg', 'no_source_text',
     '--cfg', 'wrap_proc_macro',
   ],
   dependencies: [
--=20
2.46.2


