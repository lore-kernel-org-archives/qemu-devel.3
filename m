Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446A4E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx5-0002PS-Uj; Sat, 27 Dec 2025 04:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx2-00025F-0Z
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwx-0007RG-Oh
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=bmkKLF80bu32sp1mODNzFcSD9hz0U3eShPPsKYV7lNJOBRWZ37/2R1CjQSe6utXqPXxzdy
 H6PT0ui0Bj8zyl5o0mB73K7z5LBE6wpT4yNHzAcMmUzUcB36rsd95nnpwEf0Y2FojJVKrK
 J/uugPsJRGKreL0XwaJcz4D87firE8k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ZkcYquXuP7K0b-pw0wcnTA-1; Sat, 27 Dec 2025 04:51:01 -0500
X-MC-Unique: ZkcYquXuP7K0b-pw0wcnTA-1
X-Mimecast-MFC-AGG-ID: ZkcYquXuP7K0b-pw0wcnTA_1766829060
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43411895e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829058; x=1767433858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=PnAdxgHbjr4VEQSd88/P6z9CQ6OzhsMs3ypwRpDgucW8p6iHP9PRVQNo+/RTqu+w2o
 GgOZqfxwvYsHVy478PScSXmO5z3KSbXhXIzfnOyWlTUNeBFcS/eeC/IfJZcPzodcypcR
 leRSC1SPS7oZ/BsvD5xGAqwNOpE5rvCSkOGV6kJgkti+3RgAe16dRRg++dv6gkrUF69s
 VV4/uytPxMz5PLT4gSFZQLy6trMsQUUXIJ/Y6o+Sdyesboy9rIbXVFegpDBh3pZN6xl3
 xchQj6hn5q2CTFuPRle5kCRoQfIS7HI3DXJGfGB84YJTHlGtI+BrAvUBPphjPQyflRWV
 SAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829058; x=1767433858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rcicS41+qZo6n74DEZ5xaoulNPDZhEO4rXTcSSbca0=;
 b=Q3VATkckpb2no3q+vbumBuDNZjO225DoUxrRuwBG15pAjbCNo9o2PonppbunCdV5ei
 pJCGSt88L0Og5GLjwXNVvsVh8ACbcAJjKShK302IBmAmMlhqAPJ3QbEFD7c4hMCmKXVa
 /gM2ib/XAdxEfGypcR/iYbdb77mrEW1w60NFPYm8WIOgx95QJ/8THhyzqFyXlXLZBPej
 JDTio8L9KLz2bJzc8yhvppPBmw1Qkl7PqAPHYIgE4/NTVc8fzOYGKCzIOQy5X1FNOWvB
 GjycYHGvFh9YacHa73Sp7aZaVxpDIjdbTZ5e9Ku1Tf42hbP9tDSZxS7q9pbgMUffVJUE
 RanQ==
X-Gm-Message-State: AOJu0YzJEw1Mk/fCES/ChJB9PwA69gdOH5PBhtZu1x5sj7AZRee8ycCA
 9BStmrlWSjMSx02Y1wIKGcJsiEQYFt1SCUBaqkGxDcG7XA/OXOdf+vnQZBr7PMMUuIS3nWbvYkD
 Lxl3IhDKudo0SmScY72p8z6TITi09ibGz72Y1f4yn7540UR3DgW+Au8LxMl+XDFXchVlBfYMt6u
 rHkGSpNcB6FWYg+lRY+Ga62EmWx9JLyozt6r1Rdoj9
X-Gm-Gg: AY/fxX4xluV2ZImPjz3qS6iHthkXwzFOIXDph5Uq2ZBClfVj3WKSLYjoyh9P7Tg2O/x
 iaRm48Xh6Cdxdb042Jsb74sNxROlBZg7KiGowM0hacJcElAcwXg5G0CgYFjV44u4/IpNOkjnK7P
 gfySgRiy+eAm0L7SHbsUVH7PnLPsDdhw7xdTXVXOg3WJBctwj7DlyH0IBzmkq4JiDeCGD6ICKSr
 DqIpA9+zhdmy5QnertDVUuQtSw+MoHSoopN2MjO/NHJgG9OlPu11EL75kjqbZTcQDHWY4jlnQj2
 48uvkmp0xqHcwGEDEsFaUVvRzJcxT8zV6LdLd1smWsPtfcLSi0jMzKPi3T0CEhjb422RbMT1lcu
 t2h8aTf24n40/2HQb0ciqnqKd9n4NkgXkAjGI3PttzqZfo1QITwqlsn9WuA085uyb4qbViLKp80
 l2Ct5F7BgZ5PxfB8Q=
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr282250565e9.11.1766829058424; 
 Sat, 27 Dec 2025 01:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFqVfpTc1t9DrHwKVyRC1R1qHKNPpijawDYxEXpXcUmAfKqI1cfd/I6r0fH0liziwBf1humg==
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr282250315e9.11.1766829057926; 
 Sat, 27 Dec 2025 01:50:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb9asm200927465e9.2.2025.12.27.01.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 134/153] gitlab-ci: enable rust for msys2-64bit
Date: Sat, 27 Dec 2025 10:47:39 +0100
Message-ID: <20251227094759.35658-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


