Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDACA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWi9-0005Cb-Tw; Wed, 07 Oct 2026 14:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWhv-0005Bl-8Z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWht-0002qA-Hf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IAg3I3847333
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3aCt+864kDF
 ZX/AHRaQPnGTZgDXP9hyiLii3B4uvzkU=; b=o3HxOhIMgxtwEywf0NgtfcNrLtU
 Q76EWcaPyFVhOjvgZCgB6pL2iMex0ZXnkMWh8lzKCfuSa12iQMc19w1QMoQxA/yh
 GaLuYwGRJcQyD7F0dlvWYUQs4RpOmXh8S7hF5XGzU1QNh588yJ3DACo5qNfnbSAl
 roOoy3PGc+5j5p6UE3jpH84Nb/ymtCVbnaXgrF8mSPYRWlOHYQJmdgjiQC+Cjs+G
 PIZykSF1Y8HLRENjJpXlHJcCI2kxgzzogtNdlstz1Rxo3b0Jc3jwWKXt6LFgcQRa
 zcfhZPRbwOTIL+T+Bm15bGXLa7WTETFMh4rxXng6afojCw9Ty9R+J6uj4mw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5tu807k0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:49:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so6641273eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398975; x=1792003775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aCt+864kDFZX/AHRaQPnGTZgDXP9hyiLii3B4uvzkU=;
 b=bg0sCnBvNaLHhVmUJExie09Z+qA2wyU8bga8gzcPhLdxmVzk3X3OFX6E+1VKcfd55k
 rrTjIDOwuaJ0J/wEB3lkeZQ/LjNyiXFdA6yzwfaTfozXf6c1TFPQzOKQzV8biOrS7StB
 xcdAQcLJLerDIxmQ1S6HZl0LisHuEzpPM78uSdzsXSDmyIrs68+a6nBFxnlvfVS2wP7p
 ZMFGnpp13gFM7zSDbHPCuvUwQ0zoXjJFAIvLBJqiLHT4TqlXmP9gYnpJVoU6vHzc+Nf5
 Vx6vrm0KFYB0hKFUJEVtyL6rWFdGyaWSHDoNM1jNCyhEofOllnsJVIbhYBtUiEx+SpXX
 sB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398975; x=1792003775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3aCt+864kDFZX/AHRaQPnGTZgDXP9hyiLii3B4uvzkU=;
 b=pDhUBOtbXvD2/i8mEeqECdhyye/nnQKmnHjbJkAyxVkw8GockGDYeth/cWe/TghH0k
 YD4AQ0k7VFPOO11ED6/MLMsAoCBOskfkx1MYGKh4/ty7cbmw2IS2shCRfTL4SRrz8las
 Pe4mCt+q8qhTZZEa8SqgaElLjX5fYYfjj7nHgSg4eizQpAt3hgHFs85agKdbbD+rmVhR
 urnfHiHIb+jGgXpRj6crXbSODU924qGTk6j5wUVRAxQD8+3yBUFG8oRWP+FDGxkOsicc
 pnbDS8nkYhUOHf20J89kWh8ZsWxCGg2B7XTQCwnMX9V6gTtOY1dxJGwtzoBL+Soy31uh
 sAYQ==
X-Gm-Message-State: AFuF++nPiE8xwSaZmlN4ZMCnFYx1RTKGcSLMU4WmOOh7uzvH5bEX0wv0
 t/4zKOI7XXZWV+MvEB6bKSGu6a9RV+Wqn+pKHoNJpczpEGRcdFod8JRVcxCN0CxZTgFBz17DJ2a
 9wzIMhO1UljRYvlcpCjcmegpOXuBvNLdccbM4WAgkwmfxjpG6ZNxiu9Oi66kpgPjVkA==
X-Gm-Gg: AYBFou0rxdsEju6IgikZIxZRQnoqsB9agx1csjgLI/+fxteLE+4W+2E3V3nZ/Zl7bv3
 V/GpNwR+Xd3dUteQr8SGSZFq4Tz1SKz/dS5mYOt+7IYbk2Ga0cAlck2qBlF+db9VJ/Lnc5dfy6t
 YJgf/y14j5H2sXWR8CTqCLuBoMqfC6hmmFN9LOEmPQQleNylnZuy+eAwXsKknLQt9az9mot+p/q
 kmU0cRgcInAB0iztYKcc/fOSUeI/PprS7cQMne3O8kzDQsSVmY1t+maWDUdKYwU7V+U7nhXJorV
 YD8kwnME6Yu3iZqe3XCmrE3/qlFcijNvnrrW20rKI7+nbIXD8r8vUp/dym2ggpI/CfumreerZBI
 TRZChxCYE2zbksc/VFHYwuUgZxj89rQGCTZupxhJrOleOawoeKu9Qzh/wpmue
X-Received: by 2002:a05:701b:4593:b0:14f:ee48:f26a with SMTP id
 a92af1059eb24-1620693f718mr3129460c88.30.1791398975398; 
 Wed, 07 Oct 2026 11:49:35 -0700 (PDT)
X-Received: by 2002:a05:701b:4593:b0:14f:ee48:f26a with SMTP id
 a92af1059eb24-1620693f718mr3129421c88.30.1791398974695; 
 Wed, 07 Oct 2026 11:49:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1616b01c2b4sm7259158c88.20.2026.10.07.11.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:49:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] tests/qtest: check query-target architecture
Date: Wed,  7 Oct 2026 18:49:13 +0000
Message-ID: <20261007184913.27052-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mfXkvHZYjtoT2t9rM6iHZVluJ2vLuyWK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfXz8gZHJBn9Gw4
 6yWXoSz8Kxi1eyL3ka2xliAw9yA4IbFToPbojrJN5SSJ4X8DGFNi1YRKWvayDDg6Hqtwt4j3BU6
 wRmQjIPqZudwrv/gD9eF8ND/r3QzFtM=
X-Authority-Analysis: v=2.4 cv=H75OUOYi c=1 sm=1 tr=0 ts=6ac69440 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3ko5fs_7CqgIhspINmIA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX2k67jW1ApSnB
 n4zdqXfeCHWF10vQIBba5jcznfa6T8Yd7FD6wVk/yhvy+XqDcKCSJNsBcaGrPbbY0WTZ1dczHSb
 mzysNsG7QWDIBrfCX/xGt9SjmBJVooE+SsYuvVD55dfgi4HdaifleRfii6zxrW5TQ22eemD8LlW
 WZrgYMC8vCyU5yuU5FPCaROH1fKRO65RHF18OvIdqvLCo74aVEGx2dMY/pk4HotBBx2Mz/CPKVL
 3f/YGp2iHvP7C2SmIQp3AKV6uysX/TxBFIaT8s56GRZx0xeOscJ9MFi+slYxHQgLRz8DL9IWA8b
 QfCukVp0NQDIWm6FoRpURz2NcqclfqM0eFcBcEWK/rNy0QHcV3J8uI26Ij87RFG8H91TEGfnRD2
 FQ2PX6AfGLhHbppWruL22uufpJY0gFe/RRoXIQNHz0lcVlGPYGq1kdt8ryK5/DyHF10k9vgcPQw
 /Wdt94FCcQZIzr6ItSA==
X-Proofpoint-GUID: mfXkvHZYjtoT2t9rM6iHZVluJ2vLuyWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

Check that query-target reports the target identity selected by the qtest
binary, including softmmu variants.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261007184612.24073-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 927ab053f8a..c70f6a681c1 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
+static void test_query_target(void)
+{
+    QTestState *qts = qtest_init(common_args);
+    QDict *target;
+
+    target = qtest_qmp_assert_success_ref(qts,
+                                          "{ 'execute': 'query-target' }");
+    g_assert_cmpstr(qdict_get_try_str(target, "arch"), ==, qtest_get_arch());
+    qobject_unref(target);
+    qtest_quit(qts);
+}
+
 #ifndef _WIN32
 
 /* Out-of-band tests */
@@ -517,6 +529,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/query-target", test_query_target);
 #ifndef _WIN32
     /* This case calls mkfifo() which does not exist on win32 */
     qtest_add_func("qmp/oob", test_qmp_oob);
-- 
2.43.0


