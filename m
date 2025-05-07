Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E53C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyi-0000hq-Cb; Wed, 07 May 2025 19:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyd-0000eM-6r
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyb-00079t-6Z
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so16930525ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659696; x=1747264496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZudU7n7UwZvkcprmejls7vry6Hzgg8Kb406bPV2gNA=;
 b=fljX8bV8U1/L8/Z9/te4VejOK1qsp2kVbIzEGmUprzgzxkjdSCvW06qrLHkLp2KlpT
 T/nXNgn2z4hCiZM/ONatT0gr5sojvUqVLcxEWTx4JljGu5D2Cyvk4RF40xNa8MzCdHor
 vyJ0xWTQKKKZtHnnCtYXrCr5ebQXmf9KgSaCUbCbstafxyT95xPc7b6cH+YRRyMnzO6d
 +0d6lmv8cUpJS7g1wh9XwZRviAczGO3tPz6RoFFzTvs4p6BLINftPV3e5jtyf0mpEq1t
 9Mp9lEPHT08fkzc+uInIxxuurkNuEB9MZtmRItKyuFMRtNwrDEPQ+rjhxsLzU/baKuqP
 4KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659696; x=1747264496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZudU7n7UwZvkcprmejls7vry6Hzgg8Kb406bPV2gNA=;
 b=cbheIT1j2lsTdVVUVLjs/oOpnYH2mMlgNG8ygILQk2TWJuXoYtx+Jrf7HV81eorTJv
 xaRfS+vp0dpSANMHdE9RqHxapc2Fh54KDpFv8uVRjFKMAKjURk4CUPX2hRvnwUHMKRHA
 iCyb97JKTvwq3QEUp6iJEcLds7f7oFVLWiYJi2HvCUGQkYkZtwJUBUDhTczAVcFfieEs
 f/j2ecvJHtmnvs6epFkNHv6NQYgKKDotUlAZH9sog5iHwHgbrYEwt3QoC9gyhcQKUuyl
 HDBdk0cCF55xwMcO/+EZvd83viXN47B5kmNPjB6aK/FXdGKqNZznE9+8Ri+hi22V1Fqf
 kVpg==
X-Gm-Message-State: AOJu0YxRx/8m6hk4rD0PI6Dp7dZuZshQB+wok8MArWihtkSJ9VCaaYJd
 Qy8gkHTsmDcKQBJfk7mv3k0O/FLg57gpcFhfZUbpSsbmqg+XSY2XxEf86B1WvPWwAdRwvPad2nr
 eFtXSzA==
X-Gm-Gg: ASbGnctjWHIbzHtrH+4SPRWccdkJ42Qzw+6fQKGHyRw4T/OsZQgOgBB1RA7oPV7dzv4
 GwvW8Mih13e/SRLRzXhJpzryKJm8fPtokHc8qLjueAJkIF03HxpzZOoebU7TgNCBYXICVav60Sr
 QdmeX407EZcrIVLkZU596SNY8j3A9G/mx7VqbBtLcuXHxfEx63zzP+mg04Z/fxLVjusd0VXds4p
 jeRHgu5RiOdpj2kRmtgqaBdsYQvIt9doTwvKlXcrppP8tJIRKxyn+pedWZbPQebux7NvkkNAAfj
 caT85FU2SiM4I5CzmhNFyV35Mg1Za9b8OGu94KLo
X-Google-Smtp-Source: AGHT+IHttjjxZTF7MIo6ouxyM43VFwIVxtiFTdcp73tV0joWvqKvRmf6gt1aabXPkj9VzOJ9gQrhPA==
X-Received: by 2002:a17:903:1a6b:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-22e846c95e2mr15724075ad.7.1746659695912; 
 Wed, 07 May 2025 16:14:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 05/13] qapi/commands: register commands conditionally
Date: Wed,  7 May 2025 16:14:35 -0700
Message-ID: <20250507231442.879619-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/commands.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79142273828..7b172f7c081 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -27,6 +27,7 @@
     build_params,
     gen_features,
     ifcontext,
+    runtime_ifcontext,
 )
 from .schema import (
     QAPISchema,
@@ -406,9 +407,10 @@ def visit_command(self,
                 self._gen_trace_events.add(gen_trace(name))
         with self._temp_module('./init'):
             with ifcontext(ifcond, self._genh, self._genc):
-                self._genc.add(gen_register_command(
-                    name, features, success_response, allow_oob,
-                    allow_preconfig, coroutine))
+                with runtime_ifcontext(ifcond, self._genh, self._genc):
+                    self._genc.add(gen_register_command(
+                        name, features, success_response, allow_oob,
+                        allow_preconfig, coroutine))
 
 
 def gen_commands(schema: QAPISchema,
-- 
2.47.2


