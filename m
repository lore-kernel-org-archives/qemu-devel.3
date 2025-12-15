Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1341DD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3ML-0000wX-Aw; Mon, 15 Dec 2025 02:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lr-0000gE-Qi
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lo-0000p9-HJ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=cNciDL1q2EqHtv/MuoR0nLMXxwBVZPMLXJ1WCROI4Sw6ngc7puN0+k+J264C7zulfrjfKM
 lZ3Ql+m4xbVFypifFUCr+e3YUMbuBc4hyo3eo7bsosIi2ox/syXgRXmk7k9y/SoImpCloi
 +PFDb3pFpaM4vmtVF3fnTMFOUU1aWtA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-WmIKl4PPN8u5zp4Q3DmVbg-1; Mon, 15 Dec 2025 02:50:33 -0500
X-MC-Unique: WmIKl4PPN8u5zp4Q3DmVbg-1
X-Mimecast-MFC-AGG-ID: WmIKl4PPN8u5zp4Q3DmVbg_1765785033
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-431026b6252so725f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785032; x=1766389832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=O6rVxAJqsIZs/lV4B94LPgX4mdufNpIqWBNcBT5xcEaT+JKnznh7tPhnVVtdGb/jQu
 1BHJwacBrrn+NQSCKoaHT0sdeFVsCBPEsxsNizlR6ATjdXjtgs4RkTOpyJDjs9iwCuYX
 FkLCmUuGNTXsrQDWLAPGT+LtAQVgQw7JSUZS//thEWBcMmRnGh5UchTEqW6FQu/mN7cH
 AaamdVmk2/s0+5b49/981pSnVwrB7E3zmgBmqaZ76950cC3ZtYmu9e7qe2Oscapgp1nx
 98qRTamNszIWQ4t03vXDqygMWp3Q1QC30I8YCGKuXWV/cbLPT0SKK/dJbGwxJz4Sek1k
 49lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785032; x=1766389832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=tywpjaqsUweHN97LfJgKLyYIdhsQWDgOv8o2KVLfU3Pg+QjaNeCANMELXLvhG8k+7v
 QfEPJVNvb5k6vQjmfWf7mAUCb9oI24jAvUpTDqM4bi2Y8o/2ggKveFZPTLFGJaQYsp/K
 y0MGZWn7oE4aarT78YUqbvrZqdvzw4pgxH7w2m3/QyMAY6Kf2kD43s4GrsggI+ZXKn/i
 eHH9PbZSOe1YPO7CLmd+2VagTiITk4jb5gzFg1NRbQ0mmaaAJhRtJjv+MiHDXZtjBq1j
 r4P7JoqHPRJq/PQQbDykSYQTlohtpKYA2CE2P4+uwIUJdJ2ICMDyc2gOy2IhKzdZyWpJ
 NFdA==
X-Gm-Message-State: AOJu0Yzc1oHYeZ0XTX8JlypJkkb1oN3FUMqOpIFxc4NVAMmseZ2mMhlE
 5HcI1x0m/9RPpGO1OsMFq74alBQXZs2L8xs8pQFCxVqBRcTBw/DyCqkxyMf+l/5ZFY6ekIteaxV
 BXxX2CBDtBPkaruQH8EeDbFMAWLA5kDq+SCYCSEMYXf8NCI5g1rX3G8coiP727f1+oBimYVqfQy
 B6NgphEVdgTkEIdeaJJhDcfLSbtNoxYFfNg1jlPVHh
X-Gm-Gg: AY/fxX5eia7OBxCAckUy1gPty0lNQU/mBnEbPxsMFQGNUF7eHG13hVp+ajgROPOPwZA
 AEKkqMwL5zLymrWCwnL3kN+TU9LJW+44wNag96wBle2pLuyIXYcbZk8ArmgyrjoU4B2ccscJsky
 h06Lxm9VIiJRZxgazYTHokCuUzQtkhOW7SkdvVG0R7oe1R3UI5ZEx0iz6D3YPXwFjjSDLj1+8ae
 rrnFbQsddlc5/zy8DIAgXCAan1AC0OE+Z2wvOPfTs2+snzu/hNpPgXo1upaaidh8e1a/jc9FyiD
 ryVZyTRfvc4O2OkFP0bgDMmSHVsWoFmecXxBJUQ7+P6afyeOC6bBjm2qVZlMOQkVqc9cK/8ryqd
 WxZseY2LDWJAw2Xu5P6CowGosFcVOWhN4b5w12sDod1l55D4t6X/KxM6p94wKuyOKybLL+y79cS
 xbmQ2oXHZlXSTcs4U=
X-Received: by 2002:a05:6000:604:b0:42b:3ded:298d with SMTP id
 ffacd0b85a97d-42fb46e4781mr9358309f8f.32.1765785031866; 
 Sun, 14 Dec 2025 23:50:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGM/GbrCf7HXKj3IUIMQaXQFCH9SychVYMlIxpZp9GoC/Qz/KTGMaXRoVfbkiY1j+BYOVqOw==
X-Received: by 2002:a05:6000:604:b0:42b:3ded:298d with SMTP id
 ffacd0b85a97d-42fb46e4781mr9358283f8f.32.1765785031378; 
 Sun, 14 Dec 2025 23:50:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f5f6ede8sm10550964f8f.4.2025.12.14.23.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 11/11] gitlab-ci: enable rust for msys2-64bit
Date: Mon, 15 Dec 2025 08:50:00 +0100
Message-ID: <20251215075000.335043-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250924120426.2158655-24-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/windows.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 5dbdabfbec0..5ef4d34d1ea 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -17,7 +17,7 @@ msys2-64bit:
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
-    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0
+    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0 --enable-rust
     # The Windows git is a bit older so override the default
     GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
@@ -77,6 +77,7 @@ msys2-64bit:
       bison diffutils flex
       git grep make sed
       mingw-w64-x86_64-binutils
+      mingw-w64-x86_64-ca-certificates
       mingw-w64-x86_64-ccache
       mingw-w64-x86_64-curl-winssl
       mingw-w64-x86_64-gcc
@@ -87,6 +88,9 @@ msys2-64bit:
       mingw-w64-x86_64-pixman
       mingw-w64-x86_64-pkgconf
       mingw-w64-x86_64-python
+      mingw-w64-x86_64-python-certifi
+      mingw-w64-x86_64-rust
+      mingw-w64-x86_64-rust-bindgen
       mingw-w64-x86_64-zstd"
   - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
   - Write-Output "Running build at $(Get-Date -Format u)"
@@ -98,6 +102,7 @@ msys2-64bit:
   - $env:CCACHE_MAXSIZE = "180M"
   - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
   - $env:CC = "ccache gcc"
+  - $env:LIBCLANG_PATH = Join-Path -Path $PWD.Path -ChildPath "msys64/mingw64/bin"
   - mkdir build
   - cd build
   - ..\msys64\usr\bin\bash -lc "ccache --zero-stats"
-- 
2.52.0


