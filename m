Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E0C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKnu-0001Gf-2R; Thu, 03 Jul 2025 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKnr-0001FC-KG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:20:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKno-0004Ow-4y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:20:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4530921461aso54285305e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751552436; x=1752157236; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YKofTUEQUxvI9iY9E4Ena7buN9HRCjm4eu8sr8lBqpg=;
 b=vMgFD1yW3bF0HiFX9rXsXdvZZHQyyw9+vjgo17TM4ICdBac45jvshb78MeRwzQKIWi
 UA7FMuj0ixLGe6+KO0DJSWHMbkGcAzj+LS2UONHoTVWeb6PjN3G95RdVDmspQdaweX+p
 HqeWXB5AusqwIx/Uihj7B+8rdQTY8TaaaB6EMZJwm5XO5+9wkOfClU3+4ccszoevliH4
 N2zCVanM6bsrGpZhQbBQzvgjiHas8IJAyRHZGrYc8WkMDg8q+PvqYAYtolv4IO6C29bU
 8PPVHhIT5xC3skYX3RdR9+UELWpqQu9HvKu/MVWArlQy5ix/kSEoXGWW9ezKeL+sqzmh
 PsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751552436; x=1752157236;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YKofTUEQUxvI9iY9E4Ena7buN9HRCjm4eu8sr8lBqpg=;
 b=CgfhGExcmsNmP2+1gYzuzc8wEnmFxQ01oCF067CDxPNgvdku94I/L1+20fkQZ+zZYm
 6KnvwV9ow5+FQXChEkqG1uBRrkUCDI3xSl5SEYjbrjobgSqXjiK5lPQRX8FtvPk42tzt
 ArX5n9LzKC4eDj+Sd0XQjbhIfM7sdvgAL+BIMsaLj+UevIK6E/xfVO90uMsmOFRunqQI
 ji3F58zcXv1G60iLGKW/XEJ43IwvmT3VhWZ5q95kd9irgnq4oOWXBBewAH1NfM7+pTDt
 p+VrmNtl+PI5ehemY2EyjIYIfoPP2B5Hf8ODbDq+H0i+KbmoXAovFsQOVZC3LoMfm91k
 R3gw==
X-Gm-Message-State: AOJu0YxJ53KUnVQMsuCK0pdhCmaROuKFnfKd/D2G539J8inLHC3AqEqZ
 G10+3r1XXORL2XUg/9LMPdOz91iWSBoXhVFIV79oJdib7Jo6ROUBnrb/vEg/gJeYqHs=
X-Gm-Gg: ASbGncshYYsYG5Yb7IpIOGINjqkZa5+HEqdMaLu2H5kZ6tuX+7M8bUOKIFpm88ZhJrd
 3aXHPF1ds/E0IP4WEJnGqmlUEc3BLQ+BLVoQoV9oZ1/K6uiGGO7/xihzo53ub6SuJCh1T9litQ4
 JWU7geEHTlGdmjZ+9WNCxxETMIhpsSbdMTPC/hKYVyYbbkhmxpjUpAb8QJev5irNripxrGELhRH
 N4sTeIupU5mm1YWE1oenRWiTMPe7yIy2SWgb3lEm7EFn6ONh+uLyDFpz4k+JiyjRAzqNHfo4/Ka
 f0ZofzXVQAKBNe0+ATv70MgOSJIUuL2tsWkRl2WqkpizhUBy/zm9F8ZIv2dtvr1XShn8/aaaw0a
 H1EoiDvXzUbpeSF6rT5X8Z8LRDNHX/U4=
X-Google-Smtp-Source: AGHT+IGYT963byciZayRsFLXGd2IvlsFsPDOgxTJg45GllKRKmIMfusHgavjNT/HncglWhbPgSIK/Q==
X-Received: by 2002:a05:600c:1388:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-454ab368e3bmr34604495e9.2.1751552436060; 
 Thu, 03 Jul 2025 07:20:36 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm18976600f8f.54.2025.07.03.07.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 07:20:35 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 17:20:22 +0300
Subject: [PATCH] rust/bindings: allow unnecessary_transmutes (1.88)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-rust_bindings_allow_unnecessary_transmutes-v1-1-692ca210d331@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKWRZmgC/x3NQQrCMBBA0auUWRtIamrBq4iEtBnrQJ3KTKKW0
 rs3uHyb/zdQFEKFa7OB4IeUFq5wpwbGZ+QJDaVqaG3b2d6ejRTNYSBOxJOGOM/LNxRmHFE1yhq
 yRNZXyagmXZxPg+9cHz3U4FvwQb//7Hbf9wNQftURfAAAAA==
X-Change-ID: 20250703-rust_bindings_allow_unnecessary_transmutes-d614db4517a4
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=qBnzFK2jzBx9ni4zlQZpeE9EoRu2AVMJDhHXnUF08bA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9acEd5YXhRYm8wandnZjVEcEVGZjhMajkyYUU0ClJkYWI1eGExTmxKN08yWXgx
 SmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhUnNnQUt
 DUkIzS2Nkd2YzNEowRi9ZRC85MGtQV09zMkdiVUpmd1NqaWNQcHhRV3dnMHpxNjF3MkN1RmRvYg
 o0NXNXeUdtdm9STDZSYmlGaE5lMVFGMmlMdGkwMWRLRG1PcSthUVpLeTV6MllBYjdkZy9lS24yS
 U1hQUgwTkYrCm1zam5tRzc0cGhjMm9KOG5SRjlQakt1QlRzcGhQUnJ1WlVGdDNlNnBoWWpBT2FQ
 SjVTcDVwbGRaVnNCaGdQZ24KRlgwUVN4bmVQWXloTTRGdjAvTStjKzRBR0YrL3BVMWdHdGdlVS9
 5c3UwNWZESHZXZUlZendYSi93YVlGUGhhRQpnazkwdEtMaUkxQkRpM21oZmduWnBEakVHWHN6bF
 k3UlZZWUlxWGsyNzZ6UTdQaFBEYWJCR2dWVHVXMzFKNnlkCkhjaWNEUWhQS0ZocTFXYkhXYk9QT
 WhtVzRFN2hSU0FsZWlQK2tsVTdkZWRzZTFHZ0JnNklUS0pvYzZud2gvUmUKR1c2K2g4bVROWjl5
 dUIzMzU4VU5oVmtneXZBa3BtRHRkSmFKZThodWNQbUk3SDRoR1Y4dkN3TDJHTUpEUnpvVApoSnV
 aaGFwcmNvQzlkREhYTmhqRzN1WldKK1JWalNPYkNJNG5ubmI2RUhWWjBYZWpCdzl3VEd0TURSdU
 ZHMm55CnZxR1E4ME94M3h4UHJONFNTUHJ4R2NlbzJYb3M5Mm5zR1pvaHdqSnEvR3dhSTFpbFhUZ
 k9KR0JpTnJCSkI2WGMKUWdPZVRxdEhNZTMxUkd6OHRLd2Z4d3VhK3JpUG9SaXVjd2FVZVNwazQ4
 eGtqeko4Tmw3blZ5dWt1aE5ETHI1KwpIYlQ1TXVQTHVtVUt4c2ZWamE4QlkybmxIQ1NWRXpYbEc
 0TVptVlZQN2Q5dGdxQnhjc2lUWlNNcGphM091cEFBCjN6Mmhndz09Cj1SVWZPCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is a new lint introduced in Rust 1.88. It does not affect
compilation when using a previous version or our MSRV, 1.77. But with
1.88 compilation fails because we deny all warnings:

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:729:18
      |
  729 |         unsafe { ::std::mem::transmute(self._bitfield_1.get(0usize, 24u8) as u32) }
      |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: replace this with: `u32::cast_signed(self._bitfield_1.get(0usize, 24u8) as u32)`
      |
      = note: `-D unnecessary-transmutes` implied by `-D warnings`
      = help: to override `-D warnings` add `#[allow(unnecessary_transmutes)]`

Allow this lint, which even though it does not exist in previous
versions, it works because we allow for `unknown_lints` in
rust/Cargo.toml.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api/src/bindings.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 057de4b6467c50ecc5acb6b51e6fde87ef5fa67f..3cdad0f0ec640880bc74a942bbcb303be4cda775 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -6,6 +6,7 @@
     non_camel_case_types,
     non_snake_case,
     non_upper_case_globals,
+    unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
     clippy::pedantic,
     clippy::restriction,

---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250703-rust_bindings_allow_unnecessary_transmutes-d614db4517a4

--
γαῖα πυρί μιχθήτω


