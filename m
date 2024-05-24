Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D26C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 05:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sANbK-00089t-Q7; Fri, 24 May 2024 01:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbI-00089b-O9
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbH-00013w-6O
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso4001515ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716528978; x=1717133778;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ktjQT4R7pKWFtbxj3xSZ2/NJzr1LvAGm2r7cio2ONHQ=;
 b=rlJKdLW2cU2UfE6g76HOCF8HkidZSG2rfVmvQ8uTgNXi4k8tq+jekuouxVreyoWE7/
 lkldnr9wOhH10VnztlLWbCR7b8NFhNPOmPpmw0R1NYH8pa0gkmsxMVerHE0AF+Ty5Bdi
 xVvEPusiTT4NlCiHxye//uZl9w5AYz7cYStk2KHGtsGVs8A3AXza0OwK52Tp4Z7W3hpk
 2Q6pKH0j4Th5TJLUH0u12CInw3OA+BZ4jVRuT6SaZInHSrDYBhjq+rYr2RUhhe5ChVws
 ElgVuDNzU5041miSKX2cE9pIS7nX6eE92Nk+jifiQaYvhjjRbKSFXJtMBWQM3ly80PBG
 Ddow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716528978; x=1717133778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktjQT4R7pKWFtbxj3xSZ2/NJzr1LvAGm2r7cio2ONHQ=;
 b=turtUu1J6v7MemSdg80W05/s6zhXm4GsgrNgsqxodkzMA+lWGKeOHds1IfU8M7ilfl
 MDIfCRso/7Qt7w1g48JeERtkTCW+rK3ng4j8XrbF/bYKH41YuwVnwG7I8u7TAx9wbW3t
 ir2ltNgYB3T7KxiJEVOdrpabgQ/9peBMQQN4lR331E76khCpLq9rOinuD2NJZkNwDQWB
 qAWILnrzbbQkq3/8Wd5LGdHfbT5o3OocO9Q3A286WpfrrpJNnQ1PMZUqCHCB1PJSErK2
 jPh2BMx32r9Nt+bvPYi8SJN0l2fJqwhiDYZB68WB/d4XZSQASSQtoLPkVeNd97QbQoVJ
 NrJg==
X-Gm-Message-State: AOJu0YwEBlx9Uqg/VCpdrXpA+3sP3kT/wxYW4QPv8gMCUfrv8d1Zwy/Y
 8YVl2PAf/iaQQpD89aaBcgywLOi3IBte7sdBOL3EIz2IHIWcZOY7ziaaXM6+8xw=
X-Google-Smtp-Source: AGHT+IEFZ+jesRSDpf/pppvd2SVpWqc0Szr2Uz9/jVsqRlDjjtNUrDEY0kJClmvpyIRc2rOKUG4/Kg==
X-Received: by 2002:a17:903:41ce:b0:1f4:5477:4bfe with SMTP id
 d9443c01a7336-1f454774e3cmr2458085ad.69.1716528977932; 
 Thu, 23 May 2024 22:36:17 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f44c75697bsm5260235ad.34.2024.05.23.22.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:36:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 14:35:47 +0900
Subject: [PATCH v4 1/4] qemu-keymap: Make references to allocations static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xkb-v4-1-2de564e5c859@daynix.com>
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
In-Reply-To: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

LeakSanitizer complains about allocations whose references are held
only by automatic variables. It is possible to free them to suppress
the complaints, but it is a chore to make sure they are freed in all
exit paths so make them static instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-keymap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 8c80f7a4ed65..701e4332af87 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -154,9 +154,9 @@ static xkb_mod_mask_t get_mod(struct xkb_keymap *map, const char *name)
 
 int main(int argc, char *argv[])
 {
-    struct xkb_context *ctx;
-    struct xkb_keymap *map;
-    struct xkb_state *state;
+    static struct xkb_context *ctx;
+    static struct xkb_keymap *map;
+    static struct xkb_state *state;
     xkb_mod_index_t mod, mods;
     int rc;
 
@@ -234,8 +234,6 @@ int main(int argc, char *argv[])
 
     state = xkb_state_new(map);
     xkb_keymap_key_for_each(map, walk_map, state);
-    xkb_state_unref(state);
-    state = NULL;
 
     /* add quirks */
     fprintf(outfile,

-- 
2.45.1


