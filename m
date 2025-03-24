Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD6C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewk-0002uJ-8G; Mon, 24 Mar 2025 06:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewS-0002lb-HN
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:03 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewL-00071r-1L
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso854931166b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811710; x=1743416510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iW3Fn8eqm0D6+xTGEoDksVr71AgPRXfZU523o0DiCP4=;
 b=VBrvkZpkdOFOY96wtkxxFD9XOYmXzJYtln6RYHrAGHmjzb84XVKfudzr3xNZdYZOzi
 SBzHrMbjQkMvwrVtsfvUbhEcHrgwWP/J757IWQqtad1KWBvYkCvcufQ8F6aYXp5b4Cmp
 txO3u2fzCZjl2IDL0UJ6lMpM/DqvobEJY6ccIFNPTE+MLMpN41QB48IF1vC+aqW/qI+e
 84xvtunpCciW9/1Cd6QhIhnagc1XkdyJu8ZNoJ4Xb+p7QT4xLG26nC3T0iIUG6wRY1IT
 jNvuDAI/sMoETn98vpqNm47yD/H5GUJWQ1oChHB/3vtEwSlCBjXK8IafhfdI+2V0tglT
 76SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811710; x=1743416510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iW3Fn8eqm0D6+xTGEoDksVr71AgPRXfZU523o0DiCP4=;
 b=gn1//GbGtoHDfd8Eq1MREdYG1/gE9X5T+dUglCjUxcfutmbGI2Ejsan09y5Q+LbdoG
 mQo2cGOWBF/UZ0d86sAGMFMXVsYqlMLp5w6oX205QgjbdjfEvOI9kJT7cHCFBXmMUQjN
 vnD3kT3/Vv8aqGl7C5SSUzLfEHUYmT3sIA+xAukv1iKKdzqAH6GcM3VOkVYdrPFLpLV5
 yi8Y9dymIayBRh4RMVQQNvSBHVtPrw1OEOqbSaKUcWF8jMxzhh3TgzZKxk1LI00UI4fg
 Xg7m1jxybrFmRGxscB7oyblldQINrq5lf3jN8ywyuibq7xYZJmmRDV/1fvnMttTJnRwX
 ejzQ==
X-Gm-Message-State: AOJu0YymtnAGP+PpO3jwczg0RAnjMGKMsWNQR2kq48y7G5bDVuanUvnY
 jJ8RYskZ9FNkk+MwAXm6GLo67hbmLMrtF1hh78JyRzreiOZuYTXwy5A1dIBBhf4=
X-Gm-Gg: ASbGnct8hjfQJTt68Qkle9jdPJdgp0reRbqIetvl59OOAp/oQsPyThZNy3zQL8qKVi/
 ncm0Hv47Q/q8arQ1YDBpo6nR4Vxq2W+HfNk2uirZh7qOiy08MWhOnUZWiGBhNFcjRQYPx9YsX+V
 aEXxkWkBExe41xVyl0AtM5VJNUqrDr9llHdadmhxigXfkIu1OjEh06KiHIk+wrqS9n55CjI9srk
 ucIBjeIoNLDK1KXXg8uP9j+YpUHPaJTzHRSJeEoaQdBmkeCPUvtdx59opsKB/Dn9wC2r90QXcjQ
 Ln2CWqL97P9ZF0XJO8P7sgoJRyBueDc0rUSRaF4FiUclUsw=
X-Google-Smtp-Source: AGHT+IHTbIoZ9tLGno6JURbszhYf9MxRehBTNDNSIVqj6/q4UcG2lHlak8H2DzY/HL+KYEfVcTRB4Q==
X-Received: by 2002:a17:907:f50a:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac3f251f180mr1253979066b.40.1742811709663; 
 Mon, 24 Mar 2025 03:21:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef868769sm651607566b.14.2025.03.24.03.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C3C85FD17;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/11] target/ppc: make ppc_maybe_bswap_register static
Date: Mon, 24 Mar 2025 10:21:39 +0000
Message-Id: <20250324102142.67022-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's not used outside of the gdbstub code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu.h     | 1 -
 target/ppc/gdbstub.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1e833ade04..950bb6e06c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3016,7 +3016,6 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 
 void dump_mmu(CPUPPCState *env);
 
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 void ppc_store_vscr(CPUPPCState *env, uint32_t vscr);
 uint32_t ppc_get_vscr(CPUPPCState *env);
 void ppc_set_cr(CPUPPCState *env, uint64_t cr);
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c..c09e93abaf 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -81,7 +81,7 @@ static int ppc_gdb_register_len(int n)
  * TARGET_BIG_ENDIAN is always set, and we must check the current
  * mode of the chip to see if we're running in little-endian.
  */
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
+static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
     if (!FIELD_EX64(env->msr, MSR, LE)) {
-- 
2.39.5


