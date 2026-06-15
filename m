Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CFFCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6m-0002hR-Fh; Mon, 15 Jun 2026 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6Q-0002X4-Ma
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6L-0001UN-RN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1Nd41433346
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NkLysV+dJWq
 XafnbnPgwx8xeH9SklIX3pIVaVwWq0d4=; b=onIAaNJXOkmpZEM1C0PwKcfd/1R
 l4d6UXv19Z6vS7iBRqPFH/DZRzOV1EQwDRo93TQUabhbw2Qy/137sPC5Mme4V0hg
 uoDWpIHQngw/f8qFqB8f6ocaSVJGTqbHoua6rwe5luVZIo/G0826dlg7D680IB5L
 e9yo8aShMYIgu4+/dzS2fau0yy6zDP4fb14olBAMecBayNiNbDZhQkREAYoTR1Cm
 7EGh0CFhsjeNjNfVSDsOFnioTuz7N48gMdH+TGTQ1ljeRc4Vm7KBLAe/F9RFa8Rq
 YLdKZv1HalUbmVPHPsn7jhORz8pwgxqS1igXMZc+jfvRepMQH+uIEiSAJ1g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhj487-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:54 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so8344683c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552154; x=1782156954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkLysV+dJWqXafnbnPgwx8xeH9SklIX3pIVaVwWq0d4=;
 b=ZbiTVIZlluByWxN/aE/Cbm/qeoWn2ymhYFDo4Cwh6yRaJcmSov9wKwHhOzB+z369fC
 l/s5HwpvMMUsZGYAArXe2eSYAvpOPp/gRvlR94BWBXPBM/0zEWyI+t0lL9/dXxDFQz1m
 Ms/ukH1BGihuQ7dIOZj+5dn9jMV5PWVDN/Q9oHph9MtBwhsWMd1uLr005y4tz/J9xsII
 KlHpaTKTbcrutA39CujG175HBemJwQWRCn/UFyWIf0Z8xR6DlFzw0T2f9R1v4eiJC3ti
 rd4KCH04lp9aJl1wFw9gHb68ANrKSDeACxa1ukm5zdoQe1NfN8qTUt0C4J+LdNGOZ/jR
 Bf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552154; x=1782156954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkLysV+dJWqXafnbnPgwx8xeH9SklIX3pIVaVwWq0d4=;
 b=Q/4QOSFuqI01296/aYc5rICOv/gFOrHGxqfrvjbPojQyOuDgZpgUyAdn4TnDtSTWsB
 VvMtE+hVqbz1ImxZjM+b/iara86JCPOjD3Cq0dfj7rB8hSD/l2ShTbIAduS0U7RKeyNT
 JFEeoy8XAm2mhwOkHMPYigONcaEDygCRY29DWGlQBXpDiv68V3Ro0fQJYPnUeuKAG/Xn
 e8KiZBqb5QS0uywGpvq27gKYnuWvPwaxJ29QpSTxvXL2EeaHfllJPzF6OuECdcLnV84Y
 Zs3TaZE/EdYvCFlMk41a/vmtsW+1fXaWostQbbGmDO2VT3RiNJEkVuQdANIOci2x9dLW
 rQfw==
X-Gm-Message-State: AOJu0YwLnEWUCcslNQZIJ7M7Kw2mjxBQkJcWG4En/mlrHHwLhO/wR4Su
 UVuUoLcSXvRIpY4QuUhRq0DO6ia93dq1SroM/haPceeFVDbtosOYFik7j8P2sXOvGIWLvbQebtP
 U2S+eclfy4T7qIMSwNS7ySR3VjmV+549NADtbyZNzHhcxFzN32dOOJBtO4hxJqtqHHLMG
X-Gm-Gg: Acq92OFfl573gKg3TSoyVddn7XHK+bMI/Io4OrBeRzrq76nhqTLW8wVCO6rZSNUvAGE
 eNgTPsdCZO05WZbA2Ja6bNXvZ3uviixPnruvYBIrwMspPMMtQuJ0/S0G5uIDHuxzW1ZX2v/ZEke
 q/HhPaWkuKlU7NziQcXC3wlnDxm+GZo8VW3ltXUw+NAzoP5s/0ViiYRWk+J89SvDciTXx3xpSUY
 jWRFh2KEOg5tjiH9qo9rLo+FpFxk8vXl8xjUVV7f5K4qLUB4jK8HIhePk3b1wgz4IT9oBmk/1YT
 Hh5YbE+2mh3s9illGJ76rhpyP9EDzIn4wWg69RY9u7hAdxTk27mU9r2clUUsWQOqocpQ3JW/pV5
 b1VT0lmKxb2fUQ1vkpAIAbtPcYL8O/FYJcwBsKtdLBxN0atozF5RJ34wizPHVyL5tB1AUOMdgfJ
 8Un9b8tg==
X-Received: by 2002:a05:7022:1284:b0:136:4a60:43ce with SMTP id
 a92af1059eb24-1386f246125mr5416211c88.11.1781552153895; 
 Mon, 15 Jun 2026 12:35:53 -0700 (PDT)
X-Received: by 2002:a05:7022:1284:b0:136:4a60:43ce with SMTP id
 a92af1059eb24-1386f246125mr5416188c88.11.1781552153326; 
 Mon, 15 Jun 2026 12:35:53 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 18/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_cb
Date: Mon, 15 Jun 2026 12:35:17 -0700
Message-ID: <20260615193526.2883349-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX3NtxUK+btWN1
 jyq+Ydr717UjMhMZLt1YrqRjHCTsByjKMZr55XcUUGchBjjlvSgSQugvadY80nAx8lfmxJ9ML+Z
 cBTBZsmtwjyTDaVSJzJWaOWHYHwKgAg=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a30541a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=HFGiEJlbZgj7dAjcEtYA:9 a=Fk4IpSoW4aLDllm1B1p-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2h_XFesJ_ItKxQYiI9octazGzqx11RZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX9qdMOqzz0ciQ
 pJFEpA1t+GQuhc+QReMGnZ1sSLSxMAUuwfqVH0eQSiHIMb8r38AeNC4YjuLMC+UInXRUnOv2xCa
 4Nm125vGrq/qEvDQjuqFDi4pn9RPPAiQvZx6m4Gi9p7zuMMOX+2Lh3RYFpKq5l7JLPtmb0TMlA0
 N4VRy9wZurhlWiTZ9iR2kx1elFuCKGwspnUMHBv4Pyl2p3yz+z2mwJZrsvbn/anxirpU4MsFL02
 N93tP70UdliNB/e4RcU+3kyOWmUPpCx7NMMs5sk0xjbsEwOyTXqMiQE5V5WPYe0snO97oFuhiKv
 NdX8XxvSUovZJnN16RdB/w5dnZae6L0tZZBEdviulcjkMCyyIfsJnfwsWtEuHL3VG1vAUZUmYq1
 tTZZonvZl4Zpfzu+jGFKiScUgMee2yYoQaRtF3+4RY9mmm5Onc9An/feAz4DzGA1wXCn8RmKCap
 ZvJyGUPtQ+IfdcwrgWQ==
X-Proofpoint-ORIG-GUID: 2h_XFesJ_ItKxQYiI9octazGzqx11RZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d82d996bce6..909f19b7128 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -840,12 +840,14 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a6: the 6th syscall argument
  * @a7: the 7th syscall argument
  * @a8: the 8th syscall argument
+ * @userdata: user data for callback
  */
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
-                                 uint64_t a6, uint64_t a7, uint64_t a8);
+                                 uint64_t a6, uint64_t a7, uint64_t a8,
+                                 void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
@@ -891,13 +893,15 @@ typedef void
  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed before a syscall is handled by the host.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb);
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
diff --git a/plugins/api.c b/plugins/api.c
index 774b1b80214..a72cec541dc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -202,9 +202,10 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb)
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb, userdata);
 }
 
 void
diff --git a/plugins/core.c b/plugins/core.c
index c272f47b642..7e2f25a9548 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -534,7 +534,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8, cb->udata);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index bfe12ad5558..8a823acfca7 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -128,7 +128,8 @@ static void hexdump(const GByteArray *data)
 static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
-                         uint64_t a6, uint64_t a7, uint64_t a8)
+                         uint64_t a6, uint64_t a7, uint64_t a8,
+                         void *userdata)
 {
     if (statistics) {
         SyscallStats *entry;
@@ -271,7 +272,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         memory_buffer = g_byte_array_new();
     }
 
-    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.43.0


