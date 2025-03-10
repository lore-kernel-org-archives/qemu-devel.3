Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82011C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEU-00039m-C0; Mon, 10 Mar 2025 00:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEP-0002xe-Io
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEK-0008Gz-1S
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso69003065ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582747; x=1742187547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMZho2jTEznhsPIS6UESQksv+KrJv0rJOAa8ZMe9/mc=;
 b=vl/3QBoIqw9Qo67gjzeRTZf5tZdGGkp3Lk25WiyBkbcHApQ+4XU1tJxOeULMgE5/PM
 PJHZelilBpXjGuYDj4lbx5CuCFhH3ysjnYYENFVXMENJwK+/heFoKkrMBHIof8/NpgQn
 S4s68eN8qFQDBc+mqgwm1qrX4aIUkegXv9QyrvYIGCLedMbadpjhsCrwxEkdpcFbA+uV
 TIkeybhjxnDkT7fvXh6s3I5icbD1H3a31ud+kdnF/PirgRm5HxlPyeFncdb+oSNIxe2d
 wZKYuKBS5mHz2qXcEwXXhcpCdx6E+5lKapmgyfj4f1qdHj5XkhOI/92zOwwraqcK209p
 KUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582747; x=1742187547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMZho2jTEznhsPIS6UESQksv+KrJv0rJOAa8ZMe9/mc=;
 b=bKrBbp6hFhE3ZIidDOPhpUEYSEj6WS85pGXttOdFOwF4KtnbodnRkYbveZ+8fUs4h4
 8oSRA5X8mBVgt/LLKGuPGRI9icGw3RDkoeV5dSqCzvYEdi0iwJOhFReJU/QNg4/xcV5B
 wvY/REXoeb6zDURmDt9DaKofNj1Fkp4lIkOsvihBV4H5TGD9P8k84gr8nbiaQa+uPk1+
 jzDkRXj5u4GEH02aiqHONpaz4oeH49Nf8VRvq59YmLpbe+G3Cbt1Rjrz/NEe3w/5zJ8e
 A68pjLqjQ5HyNUkMaDy5gKafD5KSlUdJdGjpqpc72Zl2KJJYFChYxpFD3z3l0rOMb/wa
 2k+Q==
X-Gm-Message-State: AOJu0Ywh5eH7It67Iv7MQHnPhFFs5NNpCdu92HDvlDdddmSQUXE0Kr1C
 /SNsx7vJtABshvFF7upsvX4BEXUEEh0Z6B/o//6ob7MANnmJ93r/1HRW3ecZ4Pe68ry/w2TsUhs
 6VzE=
X-Gm-Gg: ASbGnctprfWkyapYcQNZmCkrmnTnNVyH1wG4HZRXQ2HOrHVqJ+kUEoiUN7qesL9+6rW
 sTJht/MdutwE3pSk3tSCc35/PxVqRlw7St+8iElWuxWi5Lvn3tn8O4wZ5UnUP4ERRibWQmI6mzs
 +rMwaf1AnDV1RNKy56N3f1YV7ek+jkAeahyN6BuTxhOW3JECEEN5al51FUIIdiOqQmCtIDkhh3d
 QQxhejIjwfa+QG3aKby1Cn3OeRERu19eqtL5jBlYELgJqtITmQcqk6NctF+1SGurQC+mAl1kS2I
 Bl37AYBXHqVpk/JVa+0iBbWAQJ4+9Jx1+sHOyVH1mNs7
X-Google-Smtp-Source: AGHT+IHbQ1zJTyihYPTNnOdjfB7Sf4JwjgD8pBM833NXOATM0his3HUH4Ux5tSFbwWsuCfmQbH8fWg==
X-Received: by 2002:a17:902:d488:b0:215:4a4e:9262 with SMTP id
 d9443c01a7336-2242887fd5cmr174335945ad.8.1741582746784; 
 Sun, 09 Mar 2025 21:59:06 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 14/16] system/physmem: compilation unit is now common to all
 targets
Date: Sun,  9 Mar 2025 21:58:40 -0700
Message-Id: <20250310045842.2650784-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index c83d80fa248..9d0b0122e54 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -15,6 +14,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.39.5


