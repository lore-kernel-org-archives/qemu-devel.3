Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC014C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFv-0001h1-F1; Thu, 22 May 2025 15:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF2-0000xm-KY
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006U6-Og
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74019695377so6161262b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940760; x=1748545560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eI0EvUmIkbWrjMKnBfnwOSekuZrl/EU3iIxo3aepxTQ=;
 b=yN7jISKNttC6ki5CzMzcTEmiTW7y4aEEvtJo/cEFYxRYhhVd6c+ZEzpD2OJbBE70BH
 psudSXnaxXZqfV3rAv3N/YHRyL8G0VZXMZv/xvbqi0zYAjb+0EBZIZXvKPUl+cemg3J9
 eFEbUMxLCJluv7ZJk1+oUA/FdUOgG37ly5IGvjeAZVtA9SqdAbAn6urkN9fSqNKW31Y4
 7gvMk0aYPL1AG7gngF7Gf9e2tp9LJfN+HrACNfdSYUZOCIgM4uOD9fz21K37DimHaT8H
 P2hzcF4TNlhJTuftQ9xdqJLvTD5yWOAD1LEL09J5f251To3CJct6846ApB2vt2qgJPEB
 BTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940760; x=1748545560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eI0EvUmIkbWrjMKnBfnwOSekuZrl/EU3iIxo3aepxTQ=;
 b=RqEIieEOgrjSuDC2SFB6Mtnr0yjsCS0W9zGMWfwTwRoAy2enwC8nix8YLR4IqWI9qt
 VWttLBPm4AHHc1zyahZ7Z/lBnNXLiOSZ7TuoEh7WKIBMQlrpnJdDFlNE+FWMWsvnkZs3
 aomkMgXLbARhDsDvdXfZt2IaJqiQsFYpm+trzQVaI8OILQoNd4jDowhz5E6/dCmq16A6
 fSfKg4jXRFIzxNxi7KT+SeDKnsr03X84t/d5ildxgtABY1miUNtXrA9J+xbOMRdZKoF8
 vgWkNp+wd0FZCIC7KTMSMGZ9uMUBPOgjG9Uk2PvU9sKeeW0maEiRWta068q9xgw6sLJ4
 tB9Q==
X-Gm-Message-State: AOJu0Yy+rj4BjiEvu0gwmXHkw1EGOPkh4diNG/G/8PQw3PV/xPj+kify
 AcJHPCwiabVbZovjtdKv5D7KLEriELFKMWrgryUWz4WIteZnpNTyWDokgiTcGCiyEozgLL5bWxn
 XyGBj
X-Gm-Gg: ASbGnctPBWk8MsklRQOezVxk/4fwp7AwHtxzRJsmxW8Ty62vGumlrFmNbFR3Xlu3ek0
 mE8KOscIjJAZ4ib6fIeimrlv9iCSDwFHAEtb4aOi+QmWrAJHIZkcz4VgyXfPoqIiyWkOoE3Nvpl
 BInfqmqh6+4bpLhGN1rQWTMu5y/iFytEOKMXX0uJVwgX5II4vV9lycj5BzZ9yg/MaUYU93swaId
 n8l2+NQi1zrYX8K4N9JltITg0XQdbUjqFDCEo/0LFy4zM9APC1bcwTl0UrXaDESHDTMbu0x0gq9
 6VdX/OKS0rHGQBsRgCunY7h+b65t7BvGDsihaU0Jz/btdjb050c=
X-Google-Smtp-Source: AGHT+IF4KvT7GGS/qqlbRAOkwHE22T50UmZ/6YYCOmaKzQ14zDfVDprLjEbQM4LO0UnhIj9iXhBVvg==
X-Received: by 2002:a05:6a21:9012:b0:216:19c1:1f54 with SMTP id
 adf61e73a8af0-2162188b866mr36919548637.4.1747940760545; 
 Thu, 22 May 2025 12:06:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 11/15] qapi: remove qapi_specific_outputs from meson.build
Date: Thu, 22 May 2025 12:05:38 -0700
Message-ID: <20250522190542.588267-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

There is no more QAPI files that need to be compiled per target, so we
can remove this. qapi_specific_outputs is now empty, so we can remove
the associated logic in meson.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index e038b636c9d..7582c2b5bcf 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -92,7 +92,6 @@ qapi_util_outputs = [
 ]
 
 qapi_inputs = []
-qapi_specific_outputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
@@ -110,15 +109,11 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  if module.endswith('-target')
-    qapi_specific_outputs += qapi_module_outputs
-  else
-    qapi_util_outputs += qapi_module_outputs
-  endif
+  qapi_util_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
+  output: qapi_util_outputs + qapi_nonmodule_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
@@ -138,7 +133,7 @@ foreach output : qapi_util_outputs
   i = i + 1
 endforeach
 
-foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
+foreach output : qapi_nonmodule_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
-- 
2.47.2


