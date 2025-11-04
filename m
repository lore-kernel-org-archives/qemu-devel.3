Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwq-0007ku-2A; Tue, 04 Nov 2025 11:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwR-0007dB-FN
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwN-00040T-4t
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMqnHq9v41T505uDGP7K/juFTfDSG9AnMF+W/uZJiCk=;
 b=TeyulT68JoKsUMfKj2Y+esvumWfaEL+nO6Va+RTyqsNobFqVwEfXCNkXqKvhOfJC2qmKQG
 lB66VCBmwAf+rGG6mwS49ghsrot2EAaKohWa19bWThlMrWE33prxzitOlgT5OZ1RjQdg15
 i7p7FR30QuZru1qDfpG5WRDyvd5zRQw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-3Zo_9J8hM6u4w0GjFrtR4A-1; Tue, 04 Nov 2025 11:31:20 -0500
X-MC-Unique: 3Zo_9J8hM6u4w0GjFrtR4A-1
X-Mimecast-MFC-AGG-ID: 3Zo_9J8hM6u4w0GjFrtR4A_1762273879
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b721aa1dac9so402866b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273879; x=1762878679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMqnHq9v41T505uDGP7K/juFTfDSG9AnMF+W/uZJiCk=;
 b=j5YO44Ryki//cCDo8JCdlMBTN7xvT8WqGrVnTaX0nAvJAw9jryH5zMsev2SAudox2m
 vapDfEfKXcIGyqTBFtaBioIhAHLXWX8SWn+/RadRlN4VYVDX/omr/4vR1f65MFXWYkWO
 f/V4z+NdpTn2OCxYNrvY7UGToRv8n/t54czAJlVudqNtH4SOfs9kmh62JIOE1u/HP6vQ
 Ec69hROTNAwM7NjrsO2OII0ivQepUwePZNWqVpN1raMDxHTdzk3ZyGiqhISXofsQosnp
 OW0VPnT5D5egtAD9p/GcphlWxId23Ek3oVOevTX/yctuvK0E9NZe56jarKsd4bEOFDdS
 6fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273879; x=1762878679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMqnHq9v41T505uDGP7K/juFTfDSG9AnMF+W/uZJiCk=;
 b=w33vXgTEYlVvzv4Qri91/TYflwsfemrsASTbTJzCKyXLlUDEO29lRZpA1UX26hjBU9
 mEYOUpZ0hbmhdWOoycuNfITEjGSupGbsjIkAg/Ic6DARk94jRKdLd+ZH8VolazF60BFk
 VCUHQz0mK8MGl6Rnpnnc4cNI1nSsp0q4e4VH/PLSi9E3ME7f1wGquhGy3WJ1aDCSZpO7
 jikMRfAkwjoFSC/bBQrsBmZdm/CUxiRTric3mz39CYxf8/9eIF/JKKgoN8PxN+JYA9X/
 HvA37D+K4LKG/wP9OV1JYdU2JlNAMmgo15PmQos1KybYV0UR7vVfssnsEf2m44BNpPFr
 KUZA==
X-Gm-Message-State: AOJu0YzFizqQiPmJma0kIPdfGutgcwS+qujriFYHlIUV05s7nnhyG1s9
 /WbJrDUBerLAlqBNMDgX10Eon/TQ6YTbihjxeLSM0oR/nqJ5wdQrkLq4Wo89X5rZVAp7sItmGHK
 zK7wDBCmwfIZwYlX2m6N+fPrp0Ty04BcESR9aDfrWxCzS/vqo/R5hdhZOAMHj+NrgCAlCSAsSqQ
 gR2XqVQ8jNdrN2Ugw5T8ltvYsrw2ULyJC3yPWmPN7B
X-Gm-Gg: ASbGncu0yr682Tm+RipyLB4faVR3KEepr+lEmIF4X5SYkywQZe6e71GzQ9mpfCOUWgl
 XziGRrj4wT4TVAjTwEDAGvSPOgLypx8/F8WB0Ih2XEat0LKC9dBmuLr4DZJoq0Z8xifE7Q86iv0
 IonAbNttZLkBkC/RhudxGKLP0ghbThKw0gp2Bp5MmaIJ806OJGM9yKsEToQ4/yIRL7F3DMykOf8
 bKWQ6K8p1nwUmppeIybRp00tttclcrC5QMz9+cyHIfrFe5S7ppb+/IT9d9JFIAcYoni6einCT7y
 6GKxYDowvtCb9GYfU1dVnwtxYSg1Y83JXlH03vYvpM0P5PFBRZwvjej9T5oFWh7a/cyHzt5hXbO
 ApKZN7073eNxEZwXa7zNUWGDoahbHD7M/+HVn0Yp9hZqvP8PMX5fi2khsAaCDYjzuGfdNYPdR8/
 psNnzj
X-Received: by 2002:a17:907:6eac:b0:b72:6224:7e95 with SMTP id
 a640c23a62f3a-b7263023406mr23199266b.1.1762273878749; 
 Tue, 04 Nov 2025 08:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEfw016HcquvKrYf/zzyMx9Rm4uJTB/FIZpL0vjHt2v+/2iYxu5o7Fvq5GZaugD11XJsYqoA==
X-Received: by 2002:a17:907:6eac:b0:b72:6224:7e95 with SMTP id
 a640c23a62f3a-b7263023406mr23195966b.1.1762273878169; 
 Tue, 04 Nov 2025 08:31:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e26d1sm245777666b.35.2025.11.04.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/8] rust: do not add qemuutil to Rust crates
Date: Tue,  4 Nov 2025 17:31:00 +0100
Message-ID: <20251104163102.738889-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This fails due to https://github.com/mesonbuild/meson/pull/15076.
The config-host.h file from the qemuutil dependency ends up on the
rustc command line for targets that do not use structured sources.

It will be reverted once Meson 1.9.2 is released.

Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/chardev/meson.build | 2 +-
 rust/util/meson.build    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index d365d8dd0f4..36ada7c4546 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -39,4 +39,4 @@ _chardev_rs = static_library(
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
diff --git a/rust/util/meson.build b/rust/util/meson.build
index b0b75e93ff6..8ad344dccbd 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -43,7 +43,7 @@ _util_rs = static_library(
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
+util_rs = declare_dependency(link_with: [_util_rs])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
-- 
2.51.1


