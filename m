Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427EAC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81Og-0003dS-GM; Thu, 24 Apr 2025 14:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81Oc-0003bS-0M
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81OZ-0007m7-AW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22438c356c8so16465185ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745519638; x=1746124438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgPV2b7dRwIfWk1tCY6gzPndqnEP/HfMMUWmginm4O4=;
 b=LQuXRgXepRo/00Q9derZJ8fthOmtViVyZwF1rugEb7yuF6Kn2g5GrN310qYuFlkqBK
 jPp90SnjRy3AN3lYeAn+nKu4l/XO7y1hnLL8Pf8mD0UVY5Yl6LAY0xR/B/n7+N0IFDyo
 ZDD1hHVVpF33oET+HHNRGQ6y0DNwM9p1Tih7nlSFTs6A9cen2HjcF+R0gBUdbO47wLkj
 6eIPauZWYJi9A41p9sUxP09J7N56ppmuJsOoJ/XEb+SUobTBoXBFmKr//QZSUdFYGAsx
 QlSC3ozY1Y1N2cUJjzrjRx//tN0Ec+MFrAUBcpLgcw4Z9qOkh/PZrQqeVwYs5ExjpPYk
 mRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519638; x=1746124438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgPV2b7dRwIfWk1tCY6gzPndqnEP/HfMMUWmginm4O4=;
 b=CGcrIsqqL6R1EUr4eeBpJjd37mMy8sgguMDvikiR+lQpqg9mhdVY1VI4F66Pizr/YF
 p97NKpn4c/ZR+LlLZirMgLUmHdSr1nvgjVVf9VTo7OEogJHvm2cEGq67MiiMbHn5dMOu
 eRoUAYtl8ql3NWVLa1TktM8b9z0l1JM6VQ+4+mjbre0fDQ6MYNvVDXaD7myT52AcfPvH
 P/IfSDuVkSvUj5hYaNzeTUSaZgW/XqCruH3DxhjHy27+pLkQBgbKLveQevY54VpvMvY1
 CTHSvkSZbqpdChudYcAOAXmZBQbXte9BjJsj7KBMkdzKS3kHHtnfDD16gtfvv6JyWvWO
 AUYQ==
X-Gm-Message-State: AOJu0Yxjfn3CAcTPrR8FoyyJJSeoIs7g0CxXwtuZrR3ui3fDrJfDL3jY
 PE6JevGsdf4hupk4DB/NrAv2JNs0iTfBwMOwUHcKGPWd2Q83QlaN4yMsVBgzWTwRgYhipRXfRGZ
 gLqs=
X-Gm-Gg: ASbGnctE093VAZYfY70Qv0XAjt8r9jVB4dk60B/sCdfOTzJEVXyg8AuyzyvQXqGxYp9
 dVpaRVSo8mG4JaOibOWlesmyhkLxU206G7lB/yWWX3PtVTeEfKuju5uLNdarf9qPCX0Jzs94c4O
 kz67K4eTcJNU4+kCSDcva9fOgbvoQydtRRl2MhCOXVWnO9ciZef0O/bR+dfClQoIoLmZW46H2iT
 P+XZt+/oIEe02Drm4BE4VzAb1PvnkgTtOhZx85HHUAOhDb+CzOcO5/Rvq5RbhxekEypz0RzUVnm
 bP3l+xhG9PIeW0crAzicp5Q9G7dfQhGiDSYJWQrA
X-Google-Smtp-Source: AGHT+IH800NMHceYVSDK6JiIPViscPtj3caEwOz1FxsPNH9FPH3YAw4RvZiksquhZJVj+aejNWH3Dw==
X-Received: by 2002:a17:902:cec6:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-22dbd416a4dmr7474145ad.19.1745519637735; 
 Thu, 24 Apr 2025 11:33:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa80fbaasm1544157a12.49.2025.04.24.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:33:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 2/3] qapi: always expose TARGET_* or CONFIG_KVM code
Date: Thu, 24 Apr 2025 11:33:49 -0700
Message-Id: <20250424183350.1798746-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
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

As this point, we don't do anything to hide target specific commands, as
the TODO mentions in the commit.

All other CONFIG_* are based on config-host, so we can safely generate
ifdefs.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/commands.py | 4 ++++
 scripts/qapi/common.py   | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79142273828..1dddf008d26 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -405,6 +405,10 @@ def visit_command(self,
             if self._gen_tracing:
                 self._gen_trace_events.add(gen_trace(name))
         with self._temp_module('./init'):
+            # TODO: This if guard should be implemented as a runtime check
+            # instead of #ifdef based ifcond.
+            # "#if TARGET_S390X && CONFIG_KVM" will become:
+            # "if (target_s390x() || kvm_enabled()) {"
             with ifcontext(ifcond, self._genh, self._genc):
                 self._genc.add(gen_register_command(
                     name, features, success_response, allow_oob,
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..98272653303 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -206,6 +206,8 @@ def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
     def do_gen(ifcond: Union[str, Dict[str, Any]],
                need_parens: bool) -> str:
         if isinstance(ifcond, str):
+            if ifcond.startswith('TARGET_') or ifcond == 'CONFIG_KVM':
+                return '1 /*' + ifcond + '*/'
             return cond_fmt % ifcond
         assert isinstance(ifcond, dict) and len(ifcond) == 1
         if 'not' in ifcond:
@@ -247,7 +249,7 @@ def gen_endif(cond: str) -> str:
     if not cond:
         return ''
     return mcgen('''
-#endif /* %(cond)s */
+#endif // %(cond)s
 ''', cond=cond)
 
 
-- 
2.39.5


