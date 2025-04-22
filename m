Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A94FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76F4-0005ig-PA; Tue, 22 Apr 2025 01:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Cb-0002Ls-SK; Tue, 22 Apr 2025 01:29:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CZ-0007vD-B4; Tue, 22 Apr 2025 01:29:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso39869785ad.1; 
 Mon, 21 Apr 2025 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299783; x=1745904583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ7bO6pXxeYaOHh3umuOVAnE+OOJlkmKTF0VXeHFfUg=;
 b=enpJ2nlyJUiCG3vT0suLkTsFoSWOtFpTVFfY76f2SPS8erv+CLSG0bx4ZnZyEgKk5P
 Czg1l5dpiS5UVC3rQ98bVN2m+smi/MlbK/sv2w0j80V+yya8smI7kFajWXjayzBHKBr7
 wrh6l7br7odmVan4+k6IRKINn33D6jzUMM+RS4Kcte5JHIcHJC1mOJl2H1/kRK1VlGmK
 Ra9SdfaKp9zHnyiWEwLz4MQvPNBs/P/wTLJ529Ec6h/ZW/a51SJff23tOeVCSJhf/Xk4
 wmDQR6xOJupPn6/ACpR6OZ+N9zRSMGfhmit9cFcOKyR2LKExxL+xH2HAsn0yYDcFmygm
 UPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299783; x=1745904583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ7bO6pXxeYaOHh3umuOVAnE+OOJlkmKTF0VXeHFfUg=;
 b=iOc4rFxxCn6W8fhIwqEb3ASBvGRgQEO3XFE5aJTTW6uikn4FGAVCSmgafCm08aNcGn
 DLVxSYmMiC/SU7oUBWTREyv/HRd3opQe+yGaorNeFZTlVpot9I75kxDnj7ySnTSh3TyE
 0VMa4FQDF88g6m6nWEECptMluuz6/usKL5LYW8Bh41rT+UZWv4nYK2+5EoOiw4PmEf0a
 PdtBmyK5ICNje2cRLOIw3dsc2f4SnEMkGSf24EPlK+Hh8Ssv4iLKu8DqMWLSe6hxYzVZ
 2In6tSanoMeVWyXhnVi2AcocWlZeAJQGAEzTi6dZkwW5arLB0PVTXP14dFDvC48I0h/F
 r+MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlYrsArKbSybZQkpTQIf3mlxW0xDnMkwV1K0VQ9m0DyHgiBe2PthnYucSJc2NyuKmSGOOaq8BYB4w=@nongnu.org,
 AJvYcCW2e27ra4YjP+gYVLkesAG5jp7GE7a8QN3ZoYfcel/zwzkOB+un7gpcGmvfrKCTBZzoz/4F9vLcRQ==@nongnu.org,
 AJvYcCWAzJoCev+5Xv+lso3J81f+xWf7Kuo+sB8SaTyf/C5RRyBLl83NUNDqbyDihF6wHPFAGYmCOeeYephiig==@nongnu.org,
 AJvYcCXzNZQUxned8ndnSOLmFehiV0Jkn8VBL/4Xt/+YUIoCnvGU2w81aFdVP4+4FNVFaOX2YPadOTrMhnAktg==@nongnu.org
X-Gm-Message-State: AOJu0YwuP3gF2J8Gabt2mSJ2+90JiLRX8C7R99IXl5Kx66ml8Dh5Che0
 hiaKzoEqGrtP1D9BAFB2gc9ShMTrFM3jubOGkH31qXlmznuhkKNxbT86WPHM
X-Gm-Gg: ASbGncsUQTE9W6RaHwaWsjKU81lh9QU3aa84M21m4HDnx6/sg1J0kEFAyPLhFXwtJjS
 0iUNm3bXxE+8caVcYGP4e9lxmBNvrLc/WEC4mug2AnucRYUCMW6LNXLcgWsEvOj1DLEgT9lgFy3
 y42EvtOCyyPIAFlEGII2C/XEqmbQ/UvtWrNFQa/0Wrm0DRh16K4lAiftXs3dEwUy9MLc0wkS8DN
 3YtZPW72og6YghvAQED3zUH5n2AH4DrRfLMATf8qXbi95aCtg3oX/pTlhxGzPmVDDeiPRFifDxN
 BAYaQe/O0naRzLemRltMZF81xwyxam11wZXlP80NUlzsdEOe4Ns7RFoLJfKXBjg+6wHtkQ==
X-Google-Smtp-Source: AGHT+IEZF5/R+WzWuaEUpNlwBrdt21FqufDMrrlmvN07ViDg/j4NoEnHz6mNB7gGUv8QbgO9db2OMw==
X-Received: by 2002:a17:903:3d0c:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-22c50cfa84fmr239090505ad.14.1745299782951; 
 Mon, 21 Apr 2025 22:29:42 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:42 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 13/20] block: Fix type confict of the copy_file_range stub
Date: Tue, 22 Apr 2025 14:27:17 +0900
Message-Id: <ce34a721a5283fce854f417baf7b1c8f5c48c028.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Emscripten doesn't provide copy_file_range implementation but it declares
this function in its headers. Meson correctly detects the missing
implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
file-posix.c causes a type conflict with the declaration from Emscripten
during compilation.

To fix this error, this commit updates the stub implementation in
file-posix.c to exactly match the declaration in Emscripten's headers. The
manpage also aligns with this signature.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Removed the Emscripten-specific stub of copy_file_range in
  stubs/emscripten.c. Instead, updated the type of the existing
  copy_file_range stub in block/file-posix.c to match the declaration in the
  Emscripten headers and avoid a compilation error.

diff --git a/block/file-posix.c b/block/file-posix.c
index 69257c0891..2758f31844 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2015,8 +2015,8 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
-static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-                             off_t *out_off, size_t len, unsigned int flags)
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                        off_t *out_off, size_t len, unsigned int flags)
 {
 #ifdef __NR_copy_file_range
     return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
-- 
2.25.1


