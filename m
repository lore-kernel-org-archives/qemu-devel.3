Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB1BFED3FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMSi-0001Cx-D6; Fri, 24 Apr 2026 15:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSe-0001Bt-LB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSb-0007bk-SF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGuv0B248488
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o5Sa3TBOSAL
 cBPOeP+2URGAIJYC2EhrxNJxYJQV4jJA=; b=O8eSbs37tsP8d5MW7xH1tEc+bVF
 b8GKx2X+On0FB0Ut0g0AeX1neL6OfQuHrsTXQqH0bfFwP8wNULR6n6mrARpx1Q60
 Hrz0ydzJSS0n+9uXFM7I3l94ICi7/tYmqGAn70m7Pa2YPNdlZbJXY6aj0uQbO0+t
 HnLSO28LiZ62LieByz0eks7AexnaCCnmjQkycF/8mtA2wEXyUjjNR+3vvk6O3PLz
 s9yQi69+jYkTVH0TRGqo1wOOkcFb6+KLPugOaRP4z/3NrXG8U4cRjDSQtpTVwO+7
 jRQzBOXS+whbxYH4UcP9GdD5aq0Ul1RiPagkM6yAd/I9nbzRlidkrX7naWA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqxbpc887-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:02 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so39252650c88.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777059902; x=1777664702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5Sa3TBOSALcBPOeP+2URGAIJYC2EhrxNJxYJQV4jJA=;
 b=ULG+MFTsNkg433j8h4Nw0U8fHT/mSgSRi4CcfvgGlUYLKrIHIEQhUch0Qujhz55pcF
 bLt5MJX0y0lphwizKkE1TW1baXeXE/p1lumvOheEziVZ4OGzKuvZjqgd2NC3+C9PrXtu
 9NTq3WXc1fBf/kh9CIfNZPKfafYZ+WK2I8ZxpJUBZ0YIRvBIC+WqHffcpmbAEkpJjOs7
 LcktuR88nD0dMQOkscICXDesMHsK6ebms97enRPNS0t2emJ3Pgc40PeGGs9IXyuwUcRy
 S2Oq57xmt4MvSqxAwt0n2NRRlJhy2c/8tVhWpk0gyBwyASbHd4U+5f/dBeI74osjhfVK
 Bjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777059902; x=1777664702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o5Sa3TBOSALcBPOeP+2URGAIJYC2EhrxNJxYJQV4jJA=;
 b=XmBCXlcTu/Eng5sWveWTL4tIAp6HJ96eoyaXOka6P8pPBzssxaDBgym37Z9eM0qmQj
 p90pAXWem7D16qUQpviGIRn1xRRbbfhi8nYtasQkrP1IVhIFsbzEk9IUGcvAQ8F9Ijnl
 +2N9sgmClPu1fxpZ2Xyglq35jjH9wcqg9FmJG2AZy1ZmHfcJd58BwoNl3gJ+Q4bv/lid
 MEzqXprfI5fP7HyY0QQN5cdJmlAV6BftVkVUeAVvlQKPrg8e/nfWpHYAqegYwD5r+moX
 aOgJhKErV9ijyDPTGuM5NK7gFcuCgZzy+Jg7c5fviPxB1dHGDrMBC6CJo2GEjCj5IdIn
 LdbQ==
X-Gm-Message-State: AOJu0YyduDsQkp9wtMwRJP6h6uFi3l+CKYktiJBQBwxN2yi0M5mJ1aQ9
 mHAUeYPMAFu4tQ9SDpaT2C6UC4+MAY5KTzTiZCd6QlRyjacOUGcLIiEwqSk2IQC0BXezX62Kf8n
 Oz1ww6ejqaSCy/znS11Zo4ZVga9s6VACt8VCSOLXqcMG3n6od5d7JY++Z1R/dmyCMwg==
X-Gm-Gg: AeBDievcWEmjck9jCsA449dgE6Bm5jPjdcEg/wQNrAXkNmFHOCyqmNWpZ60051GxdPo
 XsehsA0Vu6a0j/SCDQfDPPt8Do9n2iUI8NmoBxWmMyoGPsCfMYq5jV2jwcFJQ+nTwwANrUFN8w/
 kgXYYKiEFWYk0hS74LJuNHWa/+Zk1SU7OtGCP8HZNSGWVVR0+U2qJrGnvsLyCpDsdDYQl+rSHiF
 UTQDDp+TKUEVwWYEYUwc/VXh28zT3pcXFJgHlLldGKse+rwxObJqcn90DTHGh/2bV5DQQRWohAi
 EcftmSrcLLagtdyBlyHyhFH0YZq0L8CuCC1y9N4ViYy2zaeoLHqR9wWyzvDHOW8Z+M7ShJBJfGU
 +8a2VefXkxgOnaIDD2D5NFSgh+rovWHOaeqXur7QeqWF5GXQs1LrjnCDg7JtL3Lc0R5SaKkkCHc
 IDvmJ6TxGZDKO8zCSc
X-Received: by 2002:a05:7022:6b96:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-12c73f70cd0mr15689641c88.9.1777059901729; 
 Fri, 24 Apr 2026 12:45:01 -0700 (PDT)
X-Received: by 2002:a05:7022:6b96:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-12c73f70cd0mr15689616c88.9.1777059901137; 
 Fri, 24 Apr 2026 12:45:01 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbe78e12fsm11385660c88.15.2026.04.24.12.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:45:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 1/2] contrib/plugins/uftrace_symbols.py: fix symbols reading
Date: Fri, 24 Apr 2026 12:44:49 -0700
Message-ID: <20260424194451.1439316-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pO6xfiZurmisAO6MoHrhl7Uh9D0CN1qC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MiBTYWx0ZWRfX4jXDjlZgrbGO
 p8N438uxn7qeQJCHoqbu8O+u21+LAJx6nwAWIlkh4RCbmXVjgi0gyQmRfqEi2/3dSIi0206d3OZ
 ewlnnCR2Y+LUBhSlElL2nMLwtwkrG1U16fiBXp6BdYgCmmQs2NIvEbclG/1XSqz/XZRq/1wNuni
 NRNMtS4B4RCLMD3BKFRrrQe1t7uhrsTblT7ZaR7jh9SyrnUXJK/SM0UJglECRnNtbwQ7vXlv+tr
 Ef8QKlTSX/TDb/0jsL1tW3x7S8eOZqm4Qy/9ZgGLIDVX3qImNxTg+YLXatfObOvScPIy2iFnLIq
 fpd2e5HtiUaU65aztXj76Vii/EW49Qf7dIYtWL4S9/ObfXHiDuginD9Kf+ZOABpKbjOe2ftInZS
 p2f5Gx/+WfXShj4pydKvPl33dQnw9ouKwY69paMu92CenBMgNHsuieS2O50O9EaBfVdgJMtSlH4
 gX08ouoZYE1oyi0wqug==
X-Proofpoint-ORIG-GUID: pO6xfiZurmisAO6MoHrhl7Uh9D0CN1qC
X-Authority-Analysis: v=2.4 cv=X+li7mTe c=1 sm=1 tr=0 ts=69ebc83e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ZKpvnbfxhZuoKkEclzUA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240192
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

When running this on hexagon binary, we observe some undefined symbols
without any address or size.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 02d1221228c..6eb999bca5f 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -36,8 +36,8 @@ def get_symbols(elf_file):
     out = out.strip().split('\n')
     for line in out:
         info = line.split(' ')
-        if len(info) == 3:
-            # missing size information
+        if len(info) != 4:
+            # missing size/address information
             continue
         addr, size, type, name = info
         # add only symbols from .text section
-- 
2.43.0


