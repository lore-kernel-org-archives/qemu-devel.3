Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A43C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9M-0003VP-Es; Fri, 26 Jun 2026 19:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9K-0003UM-Nr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9I-000416-6T
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwpMp2098351
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bPqU+LtYmF/
 NbMSheb6pj/3JEw1F6yfgTjgly7EwQtc=; b=B/48uO9NNRwtLIsdlpikQQ5Rno4
 IrNQU52c4W2mF2ICQsVxE6KM6qwa70o60R/EyxkC5s0xaeF6neOOVtnA7r34S7KG
 Pi2XT1AFY3TntYDKvwZe8oZ9oMoXJ3o9boAQ2Efiij+uC3O84mlfN4nIX6dYorp2
 E2txv3Qfwt41hjAB3qFY+8zlOtkzDPJ9FGJQEj9l8iqaKHjNc35aRQVgJYyf5T8L
 c838eBvWbk8aiJPq1nS77zc3MzRdDq3D441UItrFGeSyt7d9+W0PfJaS+Sw4fBda
 P7icv+e/dKPq0r6yL6soXM/b/2syUKvSvvVBoqqbKxiSLPBzclGMaqmWfWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xxvgtjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c42d96713so1188254eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517180; x=1783121980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPqU+LtYmF/NbMSheb6pj/3JEw1F6yfgTjgly7EwQtc=;
 b=ambVrU8LSUyHPu7rIdZm42meLOdBxDEplyOVwlB4Q4le0LHxApvZLR06ifxySTmcVd
 +Ck4ahHnhs+VXM2BGmDMASamNQ6Xn/Y+Vt5yYPgKK/naBaCQ93roc+oeZSEOwVbr9gHC
 +Zgbsn+Y9TE+5YDKCizLD7VtTEtZp6VYDfgO3ymn+otKkqZNgh/45M6abmNC2NGkH1Ch
 Hkrpj2LIsT7zGOw/iuFGHYEsWUMDzfzGrr0ryFY6VEA6ldtu0lhhdSDoit0zQtqvqZrV
 BCJRPZvY7P5ocXjfWGJMZqPjF3prPeq1tNQ4s0fLG9SD+rmjShqaxxyUbIRWYVauOEvV
 kAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517180; x=1783121980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPqU+LtYmF/NbMSheb6pj/3JEw1F6yfgTjgly7EwQtc=;
 b=gJ1UOGBCinmpp0u9ULS0hIilmLSS9ZAGp4Plwog973Bfn6xh95w7m2sf0+WKGA7L10
 lZ1l840FNrIytOFVtXNNNSOFvc/R0w9wWsm6pKVjWO92ztYjqa+etgl8dB1R8JEo7HGN
 W0HxHbQXQ9ybj+j1XW/Jzx5rwtIh5Wdv0uFfixz0pFZWdj3Y9GC7itKDUj0dW0AiPtQs
 wYGKuwAI7+MYGilRk2CFJKIEywaWP+Czry0DWpnM9XP/FGgE4/qwrxrqlAJYfmzyqOZd
 wQUWumdaEODYcrzYc+sREnIz36N6m4C6/sffP/jV19ocouuFLvER9yZTnDZhbiMClReO
 VKZQ==
X-Gm-Message-State: AOJu0Yx6kWIYG63A9w1/zzDFzY/JgVkbKbgBkJej8QmrQvTUWW1D/zaV
 MrPITnhtHHFNADFlEkN2abgnWL1KT+Rd+f2oRDErEedr7WG23u3e+0VvMiwCMUh7ZZEO3Re4MFr
 iIiJpUfp+WcKm9dmgmHoHsexZrFlvfYqty7o1YFKhVnNvN/tFU4VIVzp4hOAYKwFTZA==
X-Gm-Gg: AfdE7ckUVmVPcOhtGcnRgYzp6wuat7Wk2zRrWZN3nZDawY0svW9lcFias+ugYImct5L
 PaEDsCBYmatjwXckniYSOJaYOMfKJsEXOW2INz1W3KpVBhxK2zyrMOnm1lptzyo63iy0VrwJIIr
 t2+lQzBg7u0Pl11116B7sJt5JRUnxT659A0qLGXY7axj/zV3DaUaO9NyvQnALk7QF6d+ZkTHLsf
 LPK7NtWY/82dC6rhSPtlWxNf/UvPFxdAokXpQv2Kxl6iDyH4YV2whI7+bCoP9BB2h6bBY6QepNl
 6mXtC/lhsh79vcfCmkUHUyT0WwCzYZ3s7TvCWAXyJG7bg8f29IXGgMpxCuZU9ZdQbEnhs4snftm
 A5+TJ+NEVRmoTYnx1daU/9IqApRLR3X0lrgmUVXd/FPrPL3JFWoi6N1xf1f+iPlP4Mt5uRNi7Zf
 7B5qkQvA==
X-Received: by 2002:a05:7300:4342:b0:30c:2d3d:7838 with SMTP id
 5a478bee46e88-30c850a51f2mr7293785eec.31.1782517179918; 
 Fri, 26 Jun 2026 16:39:39 -0700 (PDT)
X-Received: by 2002:a05:7300:4342:b0:30c:2d3d:7838 with SMTP id
 5a478bee46e88-30c850a51f2mr7293757eec.31.1782517179320; 
 Fri, 26 Jun 2026 16:39:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:38 -0700 (PDT)
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
Subject: [PATCH v2 12/37] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Fri, 26 Jun 2026 16:38:53 -0700
Message-ID: <20260626233918.158740-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nHAyxuGuPh8Xl7PKbuVuDrwAZvEZKbUb
X-Proofpoint-GUID: nHAyxuGuPh8Xl7PKbuVuDrwAZvEZKbUb
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a3f0dbc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX18Dod7uwdWY3
 C2GbKvA3wDTdlXJToOXP5o1vni5cHbrJ0MtzaZhs02CmUHSYcDLvHkTRkeC96WswrFC0JNrngO2
 CFRjXY8P3gZRKAQmyZezCiqVmAD6ufumqQYPjmK5iAXpYW9EvUfS+FOW+CxaVUYyl/gFhItqmgz
 PYmvuKtxRFY9mBsNNcG8fYxo/uiQ2cUUV8izwTbQeHOL74HN2jQsfGa5p4QofJWv25HtSn/x4HN
 1zo5PaAB1dcUMR9fyIn+Hyev6tU25lo8b3iy1tJpzlEpzBVvDspbm1vVcyWmrnvwNzLbuYf5YsE
 AlY+pDNCerPCmHDbgFFwawK49zyPSKVU54DOyxyQHRJB1NRwRsQhGFrj8YxMRaXbZzBv3fHLLqV
 9IcjuT58Rmbk3TZpgcJoqKXJkUrTJpVIP5MCtOlzmX5yZRkKQmPO0JA94wxp0USojMx1IxadZHz
 HTm+5ybjqJdoXCDGHdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX4junGvQw77Ji
 BOZSBYJatJDC2ZBmlWxcZcNmzR4LzBA15MWbM/XipT5s71qDU6OVhmfnB86mTo6ERSO1+9t+bQs
 gJkCAYPpFrLK6E8X4KwHEiTw/DCSvtw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
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

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8419520d9ff..2a2e619e363 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,11 @@
 env = find_program('env')
 
+gdb_progs = ['gdb-multiarch', 'gdb']
+if config_host.has_key('GDB')
+  gdb_progs = [config_host['GDB'], gdb_progs]
+endif
+gdb = find_program(gdb_progs, required: false)
+
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
 #
@@ -7,6 +13,7 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': cross_compiler,
 #     'folder': 'folder_for_test_src_files',
+#     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -34,6 +41,18 @@ tcg_tests = {}
 # declared using 'test_name'.
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
+gdb_arch_supported = {}
+gdb_version = '0'
+if gdb.found()
+  gdb_version = gdb.version()
+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
+                           gdb,
+                           check: true)
+  foreach arch: gdb_arch.stdout().split()
+    gdb_arch_supported += {arch: true}
+  endforeach
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -47,7 +66,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'qemu', 'tests']
+    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -56,6 +75,7 @@ foreach target, plan: tcg_tests
 
   cc = plan['cc']
   folder = plan['folder']
+  gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
   tests = plan['tests']
 
-- 
2.47.3


