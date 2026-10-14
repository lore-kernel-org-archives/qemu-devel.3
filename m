Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F83FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvMw-00040e-PX; Wed, 14 Oct 2026 05:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMq-0003tN-Lf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:51 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMo-0000Wv-Un
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:48 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-170135e43c7so1205578c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970425; x=1792575225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nef3vG5EzYDKP8J72V8FVPzgjgMdn21rsBU8WQpi2Jk=;
 b=pKtiYRjHjGOq3ErIc5eUPU/BBaPglHU1R1cau/KxOUQ8Kg3x3Lm6HsFYv6Zfv0lsyU
 8CElb/koc9DN100ruRYh81TRsltKT6LYjkCcLUPsLNRACQ1YRfhMS0Gp7fYCRwMSJZ6A
 KunFceg/MF8LNhBWStey847Yaj5iBrlLPSH1AACJ2znKLHhdQO8c6DSvxDD4QFjWqQvO
 +4zdEhs7fKtgfZP72CFfvs7zR7KwUEPggdtH4Y/MEFREgjt+V19dIMpyb9H6JZsjs6LH
 w+GbTDUNCy9LWaIMNRyHdhhO7NJTXvMrKvs74InjCVfBOnd6y+pzg+iGa6UZPKlXvSkU
 Jfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970425; x=1792575225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nef3vG5EzYDKP8J72V8FVPzgjgMdn21rsBU8WQpi2Jk=;
 b=pORmloGOh7SlZ0Zc0MRE1bCMmfbhHr5wzUVyXH++TeOhVvylAOhYzYQvdUwkKjgjyq
 hCk3K5FcLUwABk2xkATNXJ0pvzggNVNx9egCnvCbnfibXfcFduFtpYsfrecbpGpXKjjq
 qbiIWNaD+544N1E6NyD7LW/xMrMJBNx1fEe9gEIya7I2rY3Fzm/fSHFsG8lmDPHnfTNc
 +KnSTgIEqYjOX3BI7a+EIl6g2ALsMRdkrV11etB5o7Vaq5AqmtpMgQIR2I2y+T188LaS
 YCC0rBKbZHd+Fr40+MwqvWd3Dyt2fkRn5Aqg+1eTVoSEPwnSoAL+XC5TJJHzTmfoM/cB
 Z0vQ==
X-Gm-Message-State: AFq9FYKjDRLvb6jWlOAEmR4+2CYQUEP9SV8WKn9CLJ4/f9xukLphE/zo
 0K29TsewvW3KOkhPQKWIaa6JyeAvu98aTaCOQLfWH8jfbTpxGhtT/pFKwDEkf0dT2EM=
X-Gm-Gg: AYBFou0MmNcns6uE64YF+e0QLeQkljMLRsYQPt+7T2WAqJ+1nPRErYoLINvsc+D0bvC
 bi7yKTHvoOl/w3rAER9Jjb5XvvF6zod1SLF6DrzAZkKjPylurLQVyUA/YbkFyMaGxCy8iafMCAw
 OEiTT+JvzMWX3P1s3fHuY1uKgyIyOp3CIUu8SaGdXYwRx0dMxDF+ZO8sS0Mk/etPly8WZ5gWeYf
 KDJ5PjqwUjUEjgdgdaR1lDVL/cW5igYCDQ6TX3RCYVne8S8tFcrSpQVjNis6EZZS8zODvLEuLac
 GTPMCnoB3BmxR3b57kY2WPnqvXE8UTf7L/TBdavTW3zJNzVWgcSjMGO2dFKnpj/T1aAfw2TRjnF
 SocSO6KOct2wrNErVpio5xwq7Y98f77GGvFlZyrjy8KzM1/1bIdqIe7fAjq7U9Drzr2FaH/WH7F
 wQh3gLYl0PotLNLnjuAjuwgCnsVFLb4UeoyqrYI3D/Y67bR3uitAxFTSjIjeE1X/jgJLkcKbDeB
 7pjXJV0IGycnHlh9g==
X-Received: by 2002:a05:701b:2713:b0:168:6ad8:e8b0 with SMTP id
 a92af1059eb24-16a6187f095mr23321482c88.14.1791970425436; 
 Wed, 14 Oct 2026 02:33:45 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:33:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 10/34] meson: collect Rust crates for combined system target
Date: Wed, 14 Oct 2026 17:31:20 +0800
Message-ID: <20261014093152.834-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

multi_target_crates += main_rs is not fine, that may repeat crates.
So we need collect crates from different $arch directly, and unique
them to a new list. then reuse 'rust_multi_target.rs' to generate it
properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 3460d031a95..f54687e19dc 100644
--- a/meson.build
+++ b/meson.build
@@ -4431,7 +4431,11 @@ foreach target : target_dirs
       multi_target_libs += lib
       multi_target_deps += arch_deps
       multi_target_deps += target_stubs
-      multi_target_crates += main_rs
+      foreach crate : crates
+        if crate not in multi_target_crates
+          multi_target_crates += crate
+        endif
+      endforeach
     endif
     execs = [{
       'name': 'qemu-system-' + target_name,
@@ -4516,6 +4520,18 @@ endforeach
 
 # Other build targets
 
+# Use collected crate names, not per-target main_rs sources, for the combined root.
+if multi_target_crates.length() > 0
+  multi_target_crates = custom_target(
+    'rust_multi_target.rs',
+    output: 'rust_multi_target.rs',
+    command: [rust_root_crate, multi_target_crates],
+    capture: true,
+    build_always_stale: true,
+  )
+  multi_target_crates = structured_sources(multi_target_crates)
+endif
+
 multi_target_objects = []
 foreach lib: multi_target_libs
   multi_target_objects += lib.extract_all_objects(recursive: true)
-- 
2.55.0.windows.3


