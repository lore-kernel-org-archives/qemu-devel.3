Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ADD216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hQx-000223-70; Tue, 15 Oct 2024 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQs-00021W-VE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQr-0001D2-Jk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQ8XtN0i9uB/gRRK2xzfUT/u47Sg0mX2wOMpc2ThCm0=;
 b=CSONrs4YyoHzXo8fF4/1LReJmpxvYuxcAGUDu47plKsjR2qLiObX8RnPYByHjSpvBAHQdH
 dB0p2z4ml/tdMVmtOZ5naRWhYy6B/dEzBT54HC/Mk5kxkVfjcDRMR9yDOELj3SXZDT9h+w
 zoIFBteI1OEA5BkwMcTHMMo06IHXfVw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-akAhcvkeOZSEanfaVGVRtg-1; Tue, 15 Oct 2024 09:17:44 -0400
X-MC-Unique: akAhcvkeOZSEanfaVGVRtg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so2180711f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998263; x=1729603063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ8XtN0i9uB/gRRK2xzfUT/u47Sg0mX2wOMpc2ThCm0=;
 b=AmXoFyWs5VYuon5UojwaOkSJHsyJRKghi8hQaNKFWISjQS6jGeriqiOEI7a+9uOKp3
 IlinhRYAYKS4t1wPgXoxIAu/BtsDLEq8nqgbPCunc0MhYCfDtIHI8YTgOBL3rODiwKg7
 ZCQT/HppNno3uSrqOd93wZOL7F5v6e4gJJvi05O3M+/9Ys2+9m/AcQekGjPk8Its6u5M
 TaIkgRqCFJz9IdA9nuuwT2t95AmrUnr4Otj4HfrBjLb0CXUZX3CRUGPAi/MFJE0ale/z
 S3R21qAvqw8TvjYJWic4Rwt2tywapvMguYeN0s2WCp4dnOe9EIcJVpyZtIdv4AOLCCEI
 NHLA==
X-Gm-Message-State: AOJu0YzHc3b4h4XygBbdra+lLzB/Xq4N4rJM7xi8y82MLe8DSsqDSZ9D
 9qN01PF6CX2dCNGEwr5tNq0HWFKh40G03yk7O0BlB3mJ1WSLdG+JrwOs9I75uphb6K/47aA19A6
 N30SFwyJZbRFRdrNnJx29LdIVvCTo3qmkSwvJloDhXICEUjQGTr2qL0wk6Zi18WEbJ80/OYWAN+
 0aXkbdUvJnA7PZGXt9cQXJ7S4g1wxnz7AN+quYaZU=
X-Received: by 2002:adf:fa52:0:b0:37d:4a7b:eeb2 with SMTP id
 ffacd0b85a97d-37d5ff1c34emr7953373f8f.35.1728998263333; 
 Tue, 15 Oct 2024 06:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOjUTgCroxJOa5wJt3TxRn4Qker7RUyVW2/1uMxKwQdah9mQg0HfwFqdQOsr2Jg34xeCLQhg==
X-Received: by 2002:adf:fa52:0:b0:37d:4a7b:eeb2 with SMTP id
 ffacd0b85a97d-37d5ff1c34emr7953351f8f.35.1728998262891; 
 Tue, 15 Oct 2024 06:17:42 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf8567sm1563603f8f.76.2024.10.15.06.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] meson: import rust module into a global variable
Date: Tue, 15 Oct 2024 15:17:19 +0200
Message-ID: <20241015131735.518771-2-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 +
 rust/qemu-api-macros/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c85f964bed4..c2e736d2051 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-i=
nstall-tree.py'))
=20
 not_found =3D dependency('', required: false)
 keyval =3D import('keyval')
+rust =3D import('rust')
 ss =3D import('sourceset')
 fs =3D import('fs')
=20
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.=
build
index 517b9a4d2d5..24325dea5c2 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -2,7 +2,7 @@ quote_dep =3D dependency('quote-1-rs', native: true)
 syn_dep =3D dependency('syn-2-rs', native: true)
 proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
=20
-_qemu_api_macros_rs =3D import('rust').proc_macro(
+_qemu_api_macros_rs =3D rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
--=20
2.46.2


