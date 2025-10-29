Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A42CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S3-00041G-Es; Wed, 29 Oct 2025 11:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S1-00040k-1G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:05 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rs-0002sP-Aa
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo6765266b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753051; x=1762357851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ni0YILoMYoLe4AZXToJB5KeJng+xXB0/01KeyPSPFl4=;
 b=A5Da82Pnq6NBZIDcYVhrJ/fU4BWKWM0pkY8TRMOagPljIJXpRfbrfgR85qEEOP5tPB
 8RnmbfTTqmQU2dgiGCZARK7vBAaBf9r/y0VeMs+1Y9edLUWRy7X+gt1lA0ZqqZQce7PK
 UwecWR1TIUp1QLSPyt4ULaDVuuPldXpFv0YQqGcoCevz8Lx7SR1BPqwVWKr95Xsbnpcr
 ygMWhT1FymjWL4FQ1hUW8hzaE0DFKHY3C/F6A/J2XUI0iRjwIiOPTxxPuue9ch4l85CB
 dBet9v49wXJHRhBuD3E3t1sPgLX0fN8VQQAaoENjv61fuIHXXbcNrzf1awXd4CUiL5MU
 DHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753051; x=1762357851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ni0YILoMYoLe4AZXToJB5KeJng+xXB0/01KeyPSPFl4=;
 b=uADf2WKJEA/FXXGbzn44t798mhB7HZFejniZ1FLI6GCNM70Ijc6e66OIdL0FpTiPAg
 eU3aWUbtd2XO8I0yndldJlVs5jCIo4TM8TvlprFdxYXWfTipAu5/uXGa1KmI6lOeB6QI
 7f0Yn/P0Od0EBq6jX/Z88xyQsVqdKuqp+TkVM5BZw9YhU++rUOxJuhDMB5f+5u8UDX+J
 QO3wzYvMGi9DjgJdYKX3J0BL65iCEOYQvBstgFCv0GVVXza2tvqKNnIa3dVC+bzTzbR9
 bLJ6w3x3xWvF/kmPd9eYZ1ppF2e3vRFutfuEsFOGvpAPqfAvGSeNtwMT3B82HQjCdigg
 3juA==
X-Gm-Message-State: AOJu0YzZ5/P3plDt3UaZ6FhcrQx+zjDpDdm/xE9DTnH4V/CGI/k/MUJS
 pLtpYnVIRA+LUkXe1rOnZlwnqPTsSqPsceozKH3s04QeaOnKb65x+Kv1zaia8xs1zNw=
X-Gm-Gg: ASbGncut7X8tpjoMAhb9xtIihXFM4pRe9rSkwKolyrGO3n93QCHhbPtuEkHkIEZz/0/
 IN2bifzRO5JfwcS1KmjkkHsTo43ySqFJ+R28kXsXvdfRiiLscL4qW4kxF/nTwporMcBmuvFzb3X
 HnaP3SlTe70PIK5A4esCEZheGnv/73BGuc2o2YRM1BwXlbs8xsu53C27FVFvYwkRXCBmgEkkjPI
 kdgmCNL7KgIKcm9eRRYEtBN2iNlC7R9Fy3pDGjQn2gwT5rfb9bLiQcTLODxdRvuN639vBnLC7z+
 eaYIfQwRoJt2/vwsgD/ofUBzOgafirdBE1om0hmNd4BZdCjn0P2pFzVG70abrWw2Co1slmxuivz
 8lQOjmT1I0mYIegxcjYLFdcW1H2AXpkRfXKRq7gOuBag6IUkWBr5jN2wPnJsfEJFU2r+4t4RViN
 +JdDXOMx156W4=
X-Google-Smtp-Source: AGHT+IEVmy9UpKdBnydzzuxl2QdAO2xRACEDuXrPGtCSO2QqWzKGsYxpnonRBugCiqBLgqmeuRJkqw==
X-Received: by 2002:a17:907:869f:b0:b3c:896:abf5 with SMTP id
 a640c23a62f3a-b703d3929dcmr339212566b.25.1761753051223; 
 Wed, 29 Oct 2025 08:50:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6db1c84813sm822459366b.19.2025.10.29.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D56C5FAA7;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/35] scripts/ci: modify gitlab runner deb setup
Date: Wed, 29 Oct 2025 15:50:15 +0000
Message-ID: <20251029155045.257802-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Both Debian and Ubuntu are setup the same way.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251027110344.2289945-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
index 7025935487a..76aeaf4ee95 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -56,12 +56,12 @@
         url: "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh"
         mode: 0755
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     - name: Run gitlab-runner repo setup script (DEB)
       shell: "/root/script.deb.sh"
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     - name: Install gitlab-runner (DEB)
       ansible.builtin.apt:
@@ -69,7 +69,7 @@
           update_cache: yes
           state: present
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     # RPM setup
     - name: Get gitlab-runner repo setup script (RPM)
-- 
2.47.3


