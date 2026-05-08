Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0118CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4H-0000sw-Bt; Fri, 08 May 2026 11:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4F-0000s2-Fo
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4D-0005UW-FR
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so1595533f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253880; x=1778858680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phy4N4YSnQNyULhSjp4nqi9ibEMtEknuKbJe7mg5d/4=;
 b=CvSqWb5eBU6BFH5CR/+ytyb0hL5j6xubpWkS/B3Ge7eoIf7g9m37NDcw7c0/e535MF
 VLwOcthuMDP+GV2njBlClGzPdRgn0m4pO325RsjQeIsAkvaBNbTMhxEs5chFgBfoT2yP
 4lyMLzen5PAHMrw3nCQCehS9M4bgSlnNLrIlq5j5G4VxWBAigSpVjUb2U9qZdyNJyR9j
 aaEFudzOdQR6H56vyYbOHMjc6/ZNhadAzRMwSOT2N8qReW+pcxBUkCkzeFFkMMRKngYb
 ToNDbidysq2OTyxdZOVumwb5TN99cjtQ9KkTaguIy+9WU+AzNxQBRAMdr3pWoDeBWoRu
 2ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253880; x=1778858680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=phy4N4YSnQNyULhSjp4nqi9ibEMtEknuKbJe7mg5d/4=;
 b=eVAJiVAD/zf83XW2fhxVlyNaNEF4F8EX6a97IiSDFlFRqg5S6d1BfR0bXbEDBoU72W
 krD1VTYuqC7grd58S8+/lLG8k6RrCcyiScefH0zy2tXzi+gdJkh6UO9Ru526qDEhbw5q
 ZVYQHWngu99TP8/s7lVG+a0qUVkkioizRUV+7r8jYa3hGvsvMsA/i6GHXyIk73XkTEAS
 GePDIJoommuivzMPrcW8IJe30Wtg2ZszdPBMygTsxoE81b53pv2d9dl5aEk6ZtJxQeKS
 Ly3NOBhO75Cuc4vR2bXEJN5cmK9UL3Erp1p+/AYswl+UOqeGCshfPrYhKYW76CdeNx5L
 4dZg==
X-Gm-Message-State: AOJu0YwsAOSgDd8P1foVjZO9J6GJIsogdsd1OUKhxhEdoc/VRDretRJz
 AlTKQ2b0W/PChSytaSRYBlbLs3ySvAevENwMG2+K0yOSnkb81e68bsPd75CcLEUrOzPVKiCILR4
 +L7nT
X-Gm-Gg: Acq92OEoCpAlFJqZwutHPDtZg2m8XJ7/EvN9nQ0v9AUTBmueMVNeuBwCPEUIwNWq03k
 qCsKu2NhIP1xlfSv1WnRS+dUaaDqdSV4fZbop7oE0ls8SR6MbsIzwLS1kQ0gB2YH4GLNEJ2LsQb
 T0C3MV1upKhAWQfXWy8eW/EiF6uCfRUCM80m7dMyvU3KaDeg9Po7pfGl0pnGe8/OmpmHGKmdxjl
 V6sb5IpJhu3bhwIQh4V2klYEpkd96v+s8XThLSKjXE4WV9JVX2LYTTJffjZAwccmNH6y/hPu5W4
 G3ClF19Bb1A85ZmElE42rMaIXY/sGiqLuaVcMZyHukDwEMo84Ac7xN5/D7M8/jUvt6IcxZjk8TD
 XPqtm06LcADJ/r6DbyiuHrPNAoaJ3dyXpiCTSWYaaQeMOVmgpMwl00F6H/7j3KqNo/+dVkBSc/5
 UnIuZMFUlG+OViy98dMKCA8JTIvx+BsceE0cAIxdqkPGvscxg5nkkvrILC/G3J97yJlQVGKMje8
 rCdyJ+cB1KDKHoA5ZhGCL7n+k4HchQ=
X-Received: by 2002:a5d:588b:0:b0:44b:7ec9:2d76 with SMTP id
 ffacd0b85a97d-4515b056d5fmr22368735f8f.7.1778253879756; 
 Fri, 08 May 2026 08:24:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 9/9] tools: Move elf2dmp from contrib/ to tools/
Date: Fri,  8 May 2026 16:24:28 +0100
Message-ID: <20260508152428.2648560-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We install elf2dmp by default, so move it from tools/ to contrib/.
(Almost all the other tool-like binaries in contrib/ are not
installed by default, so are more like example code.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                            | 2 +-
 meson.build                            | 2 +-
 {contrib => tools}/elf2dmp/addrspace.c | 0
 {contrib => tools}/elf2dmp/addrspace.h | 0
 {contrib => tools}/elf2dmp/download.c  | 0
 {contrib => tools}/elf2dmp/download.h  | 0
 {contrib => tools}/elf2dmp/err.h       | 0
 {contrib => tools}/elf2dmp/kdbg.h      | 0
 {contrib => tools}/elf2dmp/main.c      | 0
 {contrib => tools}/elf2dmp/meson.build | 0
 {contrib => tools}/elf2dmp/pdb.c       | 0
 {contrib => tools}/elf2dmp/pdb.h       | 0
 {contrib => tools}/elf2dmp/pe.h        | 0
 {contrib => tools}/elf2dmp/qemu_elf.c  | 0
 {contrib => tools}/elf2dmp/qemu_elf.h  | 0
 15 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib => tools}/elf2dmp/addrspace.c (100%)
 rename {contrib => tools}/elf2dmp/addrspace.h (100%)
 rename {contrib => tools}/elf2dmp/download.c (100%)
 rename {contrib => tools}/elf2dmp/download.h (100%)
 rename {contrib => tools}/elf2dmp/err.h (100%)
 rename {contrib => tools}/elf2dmp/kdbg.h (100%)
 rename {contrib => tools}/elf2dmp/main.c (100%)
 rename {contrib => tools}/elf2dmp/meson.build (100%)
 rename {contrib => tools}/elf2dmp/pdb.c (100%)
 rename {contrib => tools}/elf2dmp/pdb.h (100%)
 rename {contrib => tools}/elf2dmp/pe.h (100%)
 rename {contrib => tools}/elf2dmp/qemu_elf.c (100%)
 rename {contrib => tools}/elf2dmp/qemu_elf.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88cc1516d8..054ae3e6c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3938,7 +3938,7 @@ elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
-F: contrib/elf2dmp/
+F: tools/elf2dmp/
 
 Overall sensors
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
diff --git a/meson.build b/meson.build
index 1dad3a2462..69cdf2ab60 100644
--- a/meson.build
+++ b/meson.build
@@ -4543,7 +4543,7 @@ if have_tools
     }]
   endforeach
 
-  subdir('contrib/elf2dmp')
+  subdir('tools/elf2dmp')
 
   executable('qemu-edid', files('tools/qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: [qemuutil, rt],
diff --git a/contrib/elf2dmp/addrspace.c b/tools/elf2dmp/addrspace.c
similarity index 100%
rename from contrib/elf2dmp/addrspace.c
rename to tools/elf2dmp/addrspace.c
diff --git a/contrib/elf2dmp/addrspace.h b/tools/elf2dmp/addrspace.h
similarity index 100%
rename from contrib/elf2dmp/addrspace.h
rename to tools/elf2dmp/addrspace.h
diff --git a/contrib/elf2dmp/download.c b/tools/elf2dmp/download.c
similarity index 100%
rename from contrib/elf2dmp/download.c
rename to tools/elf2dmp/download.c
diff --git a/contrib/elf2dmp/download.h b/tools/elf2dmp/download.h
similarity index 100%
rename from contrib/elf2dmp/download.h
rename to tools/elf2dmp/download.h
diff --git a/contrib/elf2dmp/err.h b/tools/elf2dmp/err.h
similarity index 100%
rename from contrib/elf2dmp/err.h
rename to tools/elf2dmp/err.h
diff --git a/contrib/elf2dmp/kdbg.h b/tools/elf2dmp/kdbg.h
similarity index 100%
rename from contrib/elf2dmp/kdbg.h
rename to tools/elf2dmp/kdbg.h
diff --git a/contrib/elf2dmp/main.c b/tools/elf2dmp/main.c
similarity index 100%
rename from contrib/elf2dmp/main.c
rename to tools/elf2dmp/main.c
diff --git a/contrib/elf2dmp/meson.build b/tools/elf2dmp/meson.build
similarity index 100%
rename from contrib/elf2dmp/meson.build
rename to tools/elf2dmp/meson.build
diff --git a/contrib/elf2dmp/pdb.c b/tools/elf2dmp/pdb.c
similarity index 100%
rename from contrib/elf2dmp/pdb.c
rename to tools/elf2dmp/pdb.c
diff --git a/contrib/elf2dmp/pdb.h b/tools/elf2dmp/pdb.h
similarity index 100%
rename from contrib/elf2dmp/pdb.h
rename to tools/elf2dmp/pdb.h
diff --git a/contrib/elf2dmp/pe.h b/tools/elf2dmp/pe.h
similarity index 100%
rename from contrib/elf2dmp/pe.h
rename to tools/elf2dmp/pe.h
diff --git a/contrib/elf2dmp/qemu_elf.c b/tools/elf2dmp/qemu_elf.c
similarity index 100%
rename from contrib/elf2dmp/qemu_elf.c
rename to tools/elf2dmp/qemu_elf.c
diff --git a/contrib/elf2dmp/qemu_elf.h b/tools/elf2dmp/qemu_elf.h
similarity index 100%
rename from contrib/elf2dmp/qemu_elf.h
rename to tools/elf2dmp/qemu_elf.h
-- 
2.43.0


