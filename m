Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E3DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9C-0003SL-MG; Fri, 26 Jun 2026 19:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9A-0003Qr-RL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG97-00040o-MQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxlMv2206944
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D17DQMd9Qan
 0fIf/b1TuIn+7shy7BCT4D0Np+Oqpwjc=; b=pjTqOKFNgw+4TXakt0724K/W9hh
 xzEQ45wlQqE60sVUoRcRg3tLjuDNq3DH491d13YM8v+2jEV7nmU8Du0c3gM58NuX
 9NnAQeG9QcaavPzFs8tykUSPBs0qqxL/H1uMeSeV5aUVu+jGgizYtoUGammOSE0L
 6yPQKBJjc1M+g5SBA/M1pKCycn2gc5e1Kl8wrARcU4vapTMzNl/zQCBeD4tvXjQJ
 vJi2zN9gjcLk36SIZLKPr5mr2o2T8YFespCGEynBpnAENA1tlKpAqtYq9O3Pxp+V
 NhFI+RSzzliv0ZZy2FuvdAi34LZ+eqEFqwstwbROtam3HFpRvUfqHpVIUWg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1vm2hc94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso1302051eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517178; x=1783121978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D17DQMd9Qan0fIf/b1TuIn+7shy7BCT4D0Np+Oqpwjc=;
 b=h8aMVzENd5CoFq8ff29zHb90qy3dNbx/Z2dXmLtJJXWZCvYaV3mDmU/0xWcPtTG9Je
 5pBW/y71Ogs7eN6nMmZo5sraowWom/6RhdzdeUKWCPEv/1uQLjJbKB/AE1h5eDfI5DXF
 QLSk8i6We8gQdBgN9OuMw02mvH8RF0ijTAl5rhC3yXvXE8AskWoxrdVhKiIlED0BbhM1
 H7nzejYax1lmPf9ldjostiXUYqJDYjk2zvYGBLYZ7bsyafwyNAdckhmXdBqhIRMHlEWW
 17bL+TSj2kHjZYx9U3hlrdaQQVQx8ULZUJVme11hKjqI5QM+kyFwiv7HNItYtgOGYyrN
 JvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517178; x=1783121978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D17DQMd9Qan0fIf/b1TuIn+7shy7BCT4D0Np+Oqpwjc=;
 b=C2k3rj1BGBx8mprgHYxqXWF+S0zJbEp81AR+kWgdHAG2/9iZIKCGdG0riWw+ekX8Or
 b0QMMtzNGOq2fIhTdQSDL/nHQloqMk9+/YTvnu3IKT3VON1mAfHaNlXMhSOYSYsEukf2
 iguxWhC6sLN/TZ74m36CVRUP20tR+OYJ41MJSDHOpKOnoVFisb90oRp53jC3rTQgh6Hp
 pPY/yrgd4WyyfWnxqxbOrGjVigIVlp6lH/EnY66h8o5Cpm0o5FkRSFD7aty4kYqEEebF
 sebSRPoAu1rHtU5qzTc76zpnIY1VXBJx1Ht4zkPbeFtYhWyUFRfUR1Mpz1z7U3I5hGqD
 fuOA==
X-Gm-Message-State: AOJu0YwiU0Uyh754SNCJtTXp0MUtjgwPLtA+9d6uk4ouePUgrf+0NFpI
 pRPMFlSZbCPaE/cgiob5KIbhvVfM3/0EnM1BOeTcP9QQQQTlMcLR+FHtgW9LqQnA3uJrKR83xwm
 KN3mLUvGoZOupOrFWPdoJ6exKNFzVEawGdLCZD+1F5B2ILOscCHQpPGZixWbS9xU20A==
X-Gm-Gg: AfdE7cn6fzN2+mZOyTp1GdxfvhnVaHcs6TYIMQlVVMjg0qvkQpiDnyztBuYZpjrQKnD
 fYZl5rSfc8NBoQMYY6k+t+b29/HwnC2nrgUJsmktb2G/8qLL3fr0rWu25lJ1h+jP1Lo4mc7MbMi
 f5THMOFF6o1eB62lCUIN1ia+yix5gDE+VkJlHEdsDfylhyagHsDYtqoT0/Ol1D3jKesAamfLwC5
 z2EU42NanmCA43RcjRWDNuDoqVUHvZY2yZvmnCjYlnGVJMwEq+FApvWgxQ8KWqWsbuG8WfKJ8DL
 /fvn1VgYTN7IFJT37kIW3SRbWalRwd7dCkKyBQTRQ7jtiIVB1exhVLlHLQsGDNLdsj+5fnMA0/p
 5ojm4210U4AyQosGTTi0iqm2WJrCJTRvsNTz/EvsnweczJkwicy+k+I431GZ6BYzg+7kSTFUbu9
 PO2zbisQ==
X-Received: by 2002:a05:7300:a49a:b0:30c:b63e:bb8e with SMTP id
 5a478bee46e88-30cb63ef7b3mr319022eec.20.1782517178137; 
 Fri, 26 Jun 2026 16:39:38 -0700 (PDT)
X-Received: by 2002:a05:7300:a49a:b0:30c:b63e:bb8e with SMTP id
 5a478bee46e88-30cb63ef7b3mr319001eec.20.1782517177656; 
 Fri, 26 Jun 2026 16:39:37 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 11/37] tests/tcg/meson.build: introduce plugin_test
Date: Fri, 26 Jun 2026 16:38:52 -0700
Message-ID: <20260626233918.158740-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX6GjBPsKUUtcy
 2olyIBadMVDwHR/NItMQF4d9IL+cJKRih346g0GHyHtSp51gMlSlCM4vi0zguBHtPxB+h3ut3l/
 nXA6R4u4QX9dJzHa20VyjUEJ63qPKhnRPkO0B/Rj6m7OEiC9oswQv10PBX/ixzr3j8ulDe8yUUP
 6E0rnBEbGe2wDWq+aWnO05V4gDxcAV/jckMgZqvAHibwp0tiVrvP2DjV+shiCFSsUyyOR7MtDAD
 M/D3HdLMavC6sEzOkKHP1q+MFq7gSBGQuN5CcEilWU+0ic14DE5CCDckIp4fJ+8MiV9r7+T5tD8
 X9z1hwG8sJKkt5v9rhVIiEykrG+puS2CV0dYNLpB+Eva0qUKaAD2RnBZXsTi3jACP08CwXJ+71O
 AO6vh5A1KhLH9zAeBNvgFkWxUemmpiv5mHJ980tvQlRmDO0C9JP76dEdRapw9ymgTqjI0NwYZ29
 mQ/jIqfjfl5TvLxSIfg==
X-Proofpoint-GUID: 1fhLGi_gJAhMLVzHNGY93-yGXBPn2XY_
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3f0dba cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=EYl0GfpNujVHqAgcqgYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1fhLGi_gJAhMLVzHNGY93-yGXBPn2XY_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXwuYIkOD7a7L+
 LEOEd/60emxCAKQBsxD+g2PqwV1rzdcUrUx0nRp/aBmi0jzrEnx9Q/FUTm5ANeR0/GhE/+hevGu
 8hjOVR81S+ybRhEnG4cSolGladPHxkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f5f518fca1b..8419520d9ff 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.47.3


