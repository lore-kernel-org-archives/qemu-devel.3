Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32CFC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4k-0006Es-HC; Wed, 21 May 2025 18:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4h-0006EK-Vd
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:12 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4f-0005dZ-Sh
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:11 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3dc87649822so9568585ab.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867084; x=1748471884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eI0EvUmIkbWrjMKnBfnwOSekuZrl/EU3iIxo3aepxTQ=;
 b=CruQuO7VBDX7NXXccl1jKKHprt0KM9xBOOREl5MtCXsA46tfAYDQHVCz0W/nZvcL2j
 yC/6S75Id0CNEPUc2AQOYNxQPbBbP8EEzBsFjOxRO0rjFBwkG6ms2+CUPBVZhyTblDQd
 XKKaKAZGs3M2LvWlkjFbcc99b+2Qj/YolhrMDHXXvR1yY25bt1LqRSxtaLAVekLziOLv
 +0M0ESR9OchnIxRTHm4pWnD8t4audgYZ/OMZZ3hiP/bqb9OkazWQTnASNmnMrXz2SOGZ
 zIlHBZaFGk5MmvMC/CEy1JvcZiU6qWGgTWz2VYJmizVS2fvGKjVD5twmJEkI2DiH92Qq
 gPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867084; x=1748471884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eI0EvUmIkbWrjMKnBfnwOSekuZrl/EU3iIxo3aepxTQ=;
 b=sD9rL05H9YopW9KBCfdi68PtXbWrm/t5P/BXXpCipZbS2iA7TdvJPIx8CSQf7UiHOl
 eyXy2Eyco9o2iHoVxqBiyUMtQPpb8SziQmVIAj4SN7Nz7I74IiabVxTsJfvpYwmE1UuM
 Tc6vdy4Ka0NttVlXomJr4A+t6Iiqr1Qm7euXigZjDSlp8ggIPSs9tgUTenHWhAf7MCxA
 Ef6xA9k408CRV0Z2UkNiMPNJGnonnONh71eLpNYC+DNosUlz+1zFHVs4XQhYk6EKFt6y
 01FXtbhJtwPnfaYmBrmmGPzU5UT7tT9a+gI4ajnHynaAAbOjGChjaqGtMXiQn+9fkbgb
 DYQw==
X-Gm-Message-State: AOJu0Yyyoiyi4KFAxKA09+EgU/U+ZtCO/pPCbKxpXF8o+FGhpqOe5yH1
 BdligdPbO8m3nw51+/4BvHH1yYo+gfyNLpPSogYxyOfbh+baYgtIrLAAWvVm/G07o5VMhgWtGHO
 oRRGe
X-Gm-Gg: ASbGncuP5YBTR84j10MuB9zKV0rFCrZNTVh55fgAs+ItdfITPOheYSSXaUfunMEC+8/
 IjNoMMQeSNpOAphaEjhmmwIyllNbwn8arBj/MM26XXO2n2drY7kyZ1cuJZFZvcroFkoXsrFA6hT
 5lBfjOw/QS72rCNAKjHxYG4s1+X2RvsDLNIcZOjLZZdk0OTnhzDYLcntmmYrw6QQU+tnzQrI5p+
 w1pAs8f7vkU4g9HI177pXehVDLpugtmLKH7xG+/2hYaSKYl4/7nbh5Vo6vDb9ctWm5W4AbnpbUP
 +tj96sZArwEoz2NFeUdDpufzKNzgzrVIpdSQTvpwIzyfzDSp890=
X-Google-Smtp-Source: AGHT+IHvYFfY1S33T1lU1/0MJAqc1SHFeKukRBUmn2XwAk75gMGPReXd8sOlNKPWCIJmYA6NHAy/tw==
X-Received: by 2002:a17:902:c951:b0:22e:421b:49ad with SMTP id
 d9443c01a7336-231d454e4bamr343299675ad.46.1747867074513; 
 Wed, 21 May 2025 15:37:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 10/14] qapi: remove qapi_specific_outputs from meson.build
Date: Wed, 21 May 2025 15:37:36 -0700
Message-ID: <20250521223740.249720-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x129.google.com
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


