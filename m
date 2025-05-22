Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB1C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFK-0001Af-VL; Thu, 22 May 2025 15:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF2-0000xl-Hv
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:10 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006UG-O5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:08 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-310ce23a660so550173a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940762; x=1748545562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKpDcwMErvQxgyaL+Q2tctV5ddB+KbCBa/wlI68stYM=;
 b=NISuLF01GpztabWUlR67hZXKEt3eGD+MXTBAheHDsNDT55HiYetp5Nt3DBjhF71eod
 sxc/8FiynKiqQxg2ETayl4IpYvudncxlIVoV9mAkaG3GkKHv+FfcDEgrIoXHynjoWEVL
 XhPn8erZJd8y5H1gA8PvjKG4DtlbaP5t8GnkuhXhH5RblCuyb1izuPMS5njeT7Q7k8Ru
 JpieevWP0lZ4EsuOFhlGGlo7hQ6Wt9yeH93J3XFzQ8h59hgolfO+r6xBZv8Uxa0putrX
 j022Bievj4Le7Xe0WK5Ngm394+FUEfTmfdnmR+NS9XOl6kudd5El6LOF+CQVlAv1gcQJ
 VavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940762; x=1748545562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKpDcwMErvQxgyaL+Q2tctV5ddB+KbCBa/wlI68stYM=;
 b=KEGcKnjNI8vRK9OWOqga9hmdTpjAywRrbjvwNBsKz954FpH6GYVoViBJ12WyMsq08c
 C97+JAaSnHLYZo/Iu6hWZ2K6Wm5cz9TZ8uZvNJeH3frFSSEUg5rtM8L1wxY9X5CcjoRi
 HDnkMyISTl51zFwBT0ruoVsXP1dF2LUkjKu5g8GVBs8V/NzWgqYDKISoGHydiNSxwbKb
 Pfs96RFtvHkIcAhmBvg/b/heTDiyVCu3ydU/fTwuc8jhKoFFTU5pC0MWiDJmrQkhVjof
 trNly1S6Sn+OQ26OcEg54H2Q2nkMwnJTf2jo3wGqHQff7aDocGQq9b61sHi50V5iC013
 6MCw==
X-Gm-Message-State: AOJu0Ywx46fEoaxIONjtTSaDdihLrc2ReAEk1YBkuHR/WdPlhBt9YCK7
 a/tYnErBpyq4BIVAzSFjTJ3rQ6/eeoRhkRW+e4wYbiNEwTCx7g8tSqOHSWYsfkMST7O02SZHM4K
 SYpVn
X-Gm-Gg: ASbGncteOTpw+1WM/HP/PvBxZNoF/SCDZ1CTdMPjXX6DAN9DmWiLFdm/34RLULJmKY5
 IIEjZRkeNODYQ3oVDf77TnXuSDsv3ce/qfmUZ6MkNCzgKwHCol/Q9+Rzdl1lg72v4eL+hzEfcSh
 DZbkz5si+U/8QryPc3FoyFMN6HvYzxN8U7iaaJlgeYPVY0NqsD07o1tZPT0TZjOuXvMGbcCTumz
 wd+nB4j3u/gVN8cg/98IOw7k8wUtKy5k4+cQ1rqqUCrZzaIKoK2Bu/kzLol9ANqwrDSH1AeHYS1
 fx2hdP2HyQKOHTvhbrCD42IQefJPGR/RtmDOj0ISC/FiXsRS3kM=
X-Google-Smtp-Source: AGHT+IHDh8FiEznzPLjsuVTJ7cxt9M/OwunSmIidZ8ovWq7boiQ1zkwVpksgwb2Jbx/oBKLn1j84+Q==
X-Received: by 2002:a17:90b:3c03:b0:308:6d7a:5d30 with SMTP id
 98e67ed59e1d1-310e96e6cb5mr613322a91.18.1747940761656; 
 Thu, 22 May 2025 12:06:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:06:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 12/15] qapi: make all generated files common
Date: Thu, 22 May 2025 12:05:39 -0700
Message-ID: <20250522190542.588267-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

Monolithic files (qapi_nonmodule_outputs) can now be compiled just
once, so we can remove qapi_util_outputs logic.
This removes the need for any specific_ss file.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7582c2b5bcf..3b035aea339 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -85,8 +85,7 @@ qapi_nonmodule_outputs = [
   'qapi-emit-events.c', 'qapi-emit-events.h',
 ]
 
-# First build all sources
-qapi_util_outputs = [
+qapi_outputs = qapi_nonmodule_outputs + [
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -109,20 +108,17 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  qapi_util_outputs += qapi_module_outputs
+  qapi_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_nonmodule_outputs,
+  output: qapi_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
 
-# Now go through all the outputs and add them to the right sourceset.
-# These loops must be synchronized with the output of the above custom target.
-
 i = 0
-foreach output : qapi_util_outputs
+foreach output : qapi_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
@@ -132,14 +128,3 @@ foreach output : qapi_util_outputs
   util_ss.add(qapi_files[i])
   i = i + 1
 endforeach
-
-foreach output : qapi_nonmodule_outputs
-  if output.endswith('.h')
-    genh += qapi_files[i]
-  endif
-  if output.endswith('.trace-events')
-    qapi_trace_events += qapi_files[i]
-  endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
-  i = i + 1
-endforeach
-- 
2.47.2


