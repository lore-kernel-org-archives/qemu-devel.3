Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344EEE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvh-0006ed-Jm; Sat, 27 Dec 2025 04:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvf-0006Wf-Lt
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQve-00073K-3u
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=f2D6WDed+m2HT13V4obzDkiELk3FNGFhHN8zdQBGDc9zvL7WLzH8/zEGzMK/AEfek4Vmp1
 iohEfd2liR5w96TQyyHIWAtDyM4QzLdsBwicISK134s49K4NUjuEoAOZluWlxImbcjymbJ
 /v5iCSueTEJibOW9at/jtlOJDX7cFFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Yo7y93CVPpGAUpqAXLEl6w-1; Sat, 27 Dec 2025 04:49:39 -0500
X-MC-Unique: Yo7y93CVPpGAUpqAXLEl6w-1
X-Mimecast-MFC-AGG-ID: Yo7y93CVPpGAUpqAXLEl6w_1766828979
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43408715e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828978; x=1767433778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=dDU2GfEVAFul4kn/O9dnAJ2Q7sLWKdnzPPbqscXTKAqCV3GVJUIRGDeIjZjQxwOnLf
 JqvVdVG+FbSY8PNaZuTtUEua7kURck2H+Uf7aj0O5gH4zIiWZeheWYYh1PH6fuu347aR
 yZRB/p8rSlGWAfVSaGK1omB7oe4BFt5Mup97MMI4hMuWJ1wrgCPXH5ZB871lgfHX1P8g
 wxNEr5u08mWT0+3VOyzSpFfhFAVvc9We0N9xdiMVjGkokBx5Cq9ja3z1Nlojqy5D7YWO
 7Uc1x+dmBkVDKRaXZkAflIiBmhKQKs9JAWuhBs/z+7czAISp2WNsqAxYdqsuyGF1O66l
 /+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828978; x=1767433778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=VfvYoKaMmWQDYb3sE7WPUJkJEQn/LdTNbvbWFO75uidEnyRtuQB/0HF1JTgWdZLDU7
 1sLHLFt/pSRT0uUUlh6MnZFf+GtZ7tZcDO7xe/ICkVxQkbVljA9prsLtoKzT2HzjKrZX
 LaAwyIAird9U3GEM/ZS6gSo/X1cGJOnWxbTRF/bYQ/8l/j63FzopWUSwSOGYTHgHYOkZ
 huiwTUAFY4I9IWPS3mSI2fyfjzermD1WKG6YLWd1JDfxPMsuePTxndSAxS8TttiOAxjW
 fBqPoNTNWxX8uOa68ThOPNT2sGvz8JsOL1tFDadwHmVEPrYBILZsYzr0bwPqtTr/ZnlD
 pt3A==
X-Gm-Message-State: AOJu0YxutD5DHPsRZnuuuwJ/dnmUXgQMqzKuMl/mq2bjV/4QQwoWpif1
 /C/qGwvMi82z4yoVlFl6auuOGOo0OCiMtD169+xW3s+d+dnFBGPEAqTOoAGmC1XizkO4Tn8iRnK
 4Vt8YgtzEW9SnlW/vz3t7TOR1QAR5DwExfVZ7sidwxoG73W43YzpOv7GKUFNxEi4MlidXEw/Jq0
 GyDYAJAWYtxbYDp+xX+ROBkNnViW1P+2qT/d7UiIMb
X-Gm-Gg: AY/fxX6Xp0TeE2+xsv+jqz9WdyLQHtwEULNITeJFj8mj8JTLhypfuirmUd0zTIORQkP
 BR45W9L5nvErKFaVN9mLS2gdO8lPnAuWsEsQeaEFXx4k6g4AeEr6Doe1BHaW4ueb5oMgbpmCPLm
 tXiAa3yAUf6ia/fteI3FCVfHqamqS1uRVrVgxLn0R0XK6oMoE/qsN3KTEYKPhqPYHOIj3TH63A3
 jhveAHUT5dxsfMwtqzqTeZXz+1uVkZlIcIeHxid1x6D166qo0RSzTNpmEVpZDOoMKgOlrKzhZIY
 8Dwisq5C4GiukzRqB/aSxt8UfrLfRUTVOYjXLQQ628EOGUkQ0vdROZwvKbp35V7UTXPgllGuRHx
 6WBmnTWZJXH697Az//h66AYLufTqVpyEp+cnSW0lbuL4mOTRgH01CVmUuOyPq7Vj8T35l5pHz2o
 +lcm+fLbqKb5962jE=
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d18be144fmr247925385e9.14.1766828977874; 
 Sat, 27 Dec 2025 01:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPrVhcMLPVwypXBmPE4HZStT44PLN1/1SjH6Euq3upZZzmTmO46k9mHVdN41bW+olRNlquew==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d18be144fmr247925205e9.14.1766828977493; 
 Sat, 27 Dec 2025 01:49:37 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm453474415e9.14.2025.12.27.01.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 111/153] rust: Meson now adds -Cdefault-linker-libraries
Date: Sat, 27 Dec 2025 10:47:16 +0100
Message-ID: <20251227094759.35658-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 02738c9765f..e2de3832ac3 100644
--- a/meson.build
+++ b/meson.build
@@ -136,13 +136,7 @@ if have_rust
     rustc_lint_args += ['-Dwarnings', '-Funknown_lints']
   endif
 
-  # Apart from procedural macros, our Rust executables will often link
-  # with C code, so include all the libraries that C code needs.  This
-  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
-  # passing -nodefaultlibs to the linker "was more ideological to
-  # start with than anything".
-  add_project_arguments(rustc_lint_args +
-      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
+  add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
       native: false, language: 'rust')
   add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
       native: true, language: 'rust')
-- 
2.52.0


