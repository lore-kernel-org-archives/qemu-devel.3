Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49938D149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MoU-0004wa-UF; Fri, 25 Oct 2024 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnn-000411-Ka
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnm-0004xZ-3m
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NHNEVxOvAxgYJFwBOR2YWeM/1KhpOxYbBjuxgcI8Io=;
 b=Bw0xe0vzSCQn0uMNDIEMwg3rmRCsX1VAGmBscyVUR2AenT7FcGLyX9/6i6Hlz2FWwCDx4p
 NWs2Loyr/VfHUSjwpPfMZ7sV+oO+7aUFNtnZfv5JIAqRnR9348tz9lGwfr2Dp+05idyyQ1
 f//mdaYAHiSAfGUUgz6tZMEkutjJml4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-dWkPTc2SNTa1fMH_RwIdJw-1; Fri, 25 Oct 2024 12:04:36 -0400
X-MC-Unique: dWkPTc2SNTa1fMH_RwIdJw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a0d8baa2cso334453166b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872274; x=1730477074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NHNEVxOvAxgYJFwBOR2YWeM/1KhpOxYbBjuxgcI8Io=;
 b=SzBpmEnXLho0TaN8Usct1qn/BVk7XpgG9CkcclVzQCihscsKjjyKb/SFyrUm0pfe4T
 RimUejkMietUVKmjn0l/ulmi6qIhSWv38nl/krux5MBLwOPybEzdXgqjtacQGSUrfnMf
 3qLkeePsv640D8Wo7ocuR4ZGihtl7kzVEUr/cOsZpUg/8FdH6THT1s43n3+bloUSCVcc
 gCh4z42/6D4BWMTP9q6ceJdNEjCv6csHj6HXT7ZBcdB4gCtilfqKm4qHW/wfpOsUnYZm
 lelMqWOAOZZic+9IxiWZkWcpy1rFSxgcZFLhzYMG4lEpFn4G8g2v4fEmkvq8R9Ndlp87
 +8KA==
X-Gm-Message-State: AOJu0Yzw70gmOA0t53iY7qB1JcD7iYnQNCJeGKMGak5Q5UEYCI8XKd6F
 OM/0nUKEkYq6/B/W2IRrWxWo0BfJAp1Tw0Dbb5oxNIGC67HDf0MboutRkScTMHoqNq7AVhGbzEm
 N5r0BUj0zvcZfeN/HFKDfMrxaENj7Ob4FCaIXDVIrPS+oExE606SxVCeos+L61jveN5P/TKlZst
 L5tj+fFqUYnhnuFRBLir/zWhBNbj4qaExppjNk4A0=
X-Received: by 2002:a17:907:7f07:b0:a9a:1af0:ee1a with SMTP id
 a640c23a62f3a-a9de355da45mr5038666b.6.1729872273821; 
 Fri, 25 Oct 2024 09:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSLFvMWkTfjUsPsdDsvB3CJIpM6PmWDI04XYFlfwHqCBZJGG7AaL2FkvzhWG3fpPx/hGugCg==
X-Received: by 2002:a17:907:7f07:b0:a9a:1af0:ee1a with SMTP id
 a640c23a62f3a-a9de355da45mr5035066b.6.1729872273353; 
 Fri, 25 Oct 2024 09:04:33 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0292c2sm84958766b.69.2024.10.25.09.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 18/23] rust: allow version 1.63.0 of rustc
Date: Fri, 25 Oct 2024 18:02:03 +0200
Message-ID: <20241025160209.194307-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

All constructs introduced by newer versions of Rust have been removed.

Apart from Debian 12, all other supported Linux distributions have
rustc 1.75.0 or newer.  This means that they only lack c"" literals
and stable offset_of!.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index d199bcdd824..ab0613f353c 100644
--- a/meson.build
+++ b/meson.build
@@ -89,11 +89,12 @@ have_rust =3D have_rust and add_languages('rust', nativ=
e: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc =3D meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.80.0')
+  if rustc.version().version_compare('<1.63.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported: Please =
upgrade to at least 1.80.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please =
upgrade to at least 1.63.0')
     else
-      warning('rustc version ' + rustc.version() + ' is unsupported: Disab=
ling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      warning('rustc version ' + rustc.version() + ' is unsupported, disab=
ling Rust compilation.')
+      message('Please upgrade to at least 1.63.0 to use Rust.')
       have_rust =3D false
     endif
   endif
--=20
2.47.0


