Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F6CCCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S7-000446-3p; Wed, 29 Oct 2025 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S3-00041A-Nb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:09 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rs-0002sA-EN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso6367366b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753050; x=1762357850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tp9uc4NfmWDvr0PUctvJtnAF7CDE8AZuaPcb/KS1+g4=;
 b=UOy6phT9ZwlA5ct1uBN/iG+mhH38CL1tjw65+7ny1b8E6PXon1PI8hCOA0wqqsRntC
 zjYmulp5kEAbybdzVNCR3HE1oryrWkLVaRdwYLnFJ+/ZVxrXuT3rU5bUUkqoOoT/nD65
 togRi287sFR6HfAObY72UftiWNgopcbU+CswuZk4+roLF7lL89F9l2wuLYPgu8jXqRrk
 jJc0icQqkkY01jyxJmwKBajHTacCReTOpFRhWxxItVJTqmYhKkqQwwI7n07TQLNA70lD
 7bIusClVcT8SOqOZD6bZFU3UEvDWEct9fipM5DmAkzXx2K4kQXvrMAsKIATeouaQu+Zy
 pXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753050; x=1762357850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tp9uc4NfmWDvr0PUctvJtnAF7CDE8AZuaPcb/KS1+g4=;
 b=Yi5g+vEAMimZCYdssWbY0fL6P4Czs3/qni2K/wjYun6PfSUNM/06LvZ/myAauFkhY3
 KrodUv+N3Nv0ul/WrpepE8/dqaF4WsbEjmM90Uke85kHQecid1dJ7x7XkbHzLiuaTwAj
 wx8wDFevYYM4Z10v7gXo0Vc7Gou+ZtNNsyAyCArKmBdJc+2WOX9oHuToH/+DZOAjsG08
 nRg7wLipRcdpzvJz5aae5FnDiujTLqBHcZJRrdnemnCusDw1dHgA6rIvYwHNV2QKsScv
 W5wrDqAigvGeT3AAfRPQzFny+K0CjitKUUTAgFFo7UPbYGjv3ZsT3DZRYvGqtaG7+GDw
 74Cg==
X-Gm-Message-State: AOJu0YxnHJJLaqFBNE+3PiO53rXfZ9PEZJIEPd9vNJtCmEcilVqPlnjI
 8UUkLItb4o99//IC/dWvPZnPx+yZY9IQmVexwdz85IPvla59cVIOagJgtPjL1WkqAAs=
X-Gm-Gg: ASbGncuoKFX1tlUTeynyVTurMqdT6AHQvSBDEkCB2QUUZ/F0qun9wAoPv+wR2OtpSnF
 DxjkETQt156UPRqLcfTId8UcxTEAXIO+h4X46Jw8xT/7UiDUXNJeGypK5eoLzJrQMwUtnZRIo2n
 MaJyjyhLERS+cw7kZ4H0u9b5ZslAADuH4XlFs3UN6f6X7DH8qBZhD0haFT1ZHu5jNw3ln9vrUm4
 tgBVg/MFERQN9C/35A6EP5ljzTaatU7S6MxotFzS7/gmDOfnK1/4zPJnyDOdG6W520iem2doS7j
 5bqQVvXQsnCR3E5Koo/U6TZgDlyftBlfuEQ2agq8df9/7mTmuVqN+WfS9ceOTNoT2yK0fjN/N31
 qbXmjZe9jwyFd9ZnURH6nH26hOKD+k6Q42yjUcY7rFBWlv34CB7ahCt+NhCWfdD+aMWPfYspIJk
 Ud
X-Google-Smtp-Source: AGHT+IEcoPm+8umaacXTGKLFAevzgxBC3rhPG/WhLN5vbSpUff4wkt4u0rmE29YP8Wn4gWRSTg+pJg==
X-Received: by 2002:a17:907:728d:b0:b6d:5aac:5062 with SMTP id
 a640c23a62f3a-b703d31503dmr348378866b.14.1761753049865; 
 Wed, 29 Oct 2025 08:50:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f98adsm1436225766b.49.2025.10.29.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 285045F92F;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/35] scripts/ci: move build-environment.yaml up a level
Date: Wed, 29 Oct 2025 15:50:12 +0000
Message-ID: <20251029155045.257802-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

We can share the setup of the build environment with multiple
operating systems as we just need to check the YAML for each env is
present in the directory structure.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251027110344.2289945-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/build-environment.yml
similarity index 81%
rename from scripts/ci/setup/ubuntu/build-environment.yml
rename to scripts/ci/setup/build-environment.yml
index 1c517c74f74..66bde188755 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -27,18 +27,24 @@
         - ansible_facts['distribution'] == 'Ubuntu'
 
     # the package lists are updated by "make lcitool-refresh"
-    - name: Include package lists based on OS and architecture
-      include_vars:
-        file: "ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
+    - name: Define package list file path
+      set_fact:
+        package_file: "ubuntu/ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
 
+    - name: Include package lists based on OS and architecture
+      include_vars:
+        file: "{{ package_file }}"
+      when:
+        - package_file is exists
+
     - name: Install packages for QEMU on Ubuntu 24.04
       package:
         name: "{{ packages }}"
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '24.04'
+        - package_file is exists
+        - packages is defined
 
 
-- 
2.47.3


