Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055EECD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA5-0002pw-Oj; Thu, 30 Apr 2026 16:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA1-0002nD-GP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9x-0000ul-MH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UI9o511988442
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fnfFf6Kq30c
 Unyav6D8h/SBee1wOqNfpsYYXewcNm5I=; b=bTWi9Vil7ZbZcUAeJBYd3mDaeJe
 3zuCaSWYXPu2U3rSIJ3f9jfTzPDs450FNcZjxODtJYz5p0xNlm2iKUgGRR/q0Ss7
 3FdY4NH4ls2VuYEV87nK8aEDsFBNTwwwldKGZzpd4m0TQMfoshOTjxqRZJDaiNOk
 UZ6tMpZOSoN+acjgD6gWTGIc7FNYIU3CM9H50mRZIf8iRPzbT+n/i1FiVQDDXR8s
 sEA2+9dhr/Y+A9wYyw8PF/0h6kDIPoOUlzHpd5m70GhmZPd+t5/pgQa4JAtnFTXQ
 nylfnwv/y7u78FKpnq5jSKJrKoJcWU6MgIbGCc4otIK+cQdU0uq9jJtXmlg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvc458mgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2da19227bc1so6073657eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581535; x=1778186335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnfFf6Kq30cUnyav6D8h/SBee1wOqNfpsYYXewcNm5I=;
 b=i3F0MxH4dVQcETE+YPbzoAVH0UW6plkyFrDPcMdvJILkPfnulVBySe+LPDjX4/IoF2
 6qYbWO/f1qa2pr1d+PQfV1B5hawb1zmRmyE52IqlUN7YSlg1KpMrFO+3nVTg3aumWsHZ
 0pWyRjl8NAoB4Jy/pz6SYSqs+YdsZCTV5dvZ5yLuv8WbxyLr9Lz56NoJh24FHOzbgHm9
 ie8G//En0AqsV4w6Ue87LLufNRjUA97RlBZibaXUwuZnJVj/OpeA6/RZ9wyPpGJyVVNx
 IJFKjgvyeVzQ7EUgqfvHdfRoi/l0KVJ5hUQtfytn1tX5oPSNRF213tkWQ32Ih7HtMkQy
 zpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581535; x=1778186335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnfFf6Kq30cUnyav6D8h/SBee1wOqNfpsYYXewcNm5I=;
 b=Zc8EGD7N3SSvmF6MUGiT2xowo73MKAkfPI124zfZ9FGVrK48QN+NhK7Cf5UacaEk+8
 iFRw6BlPIir5htrsIWtOUhrAhasHUeSraCdLtphBhX8Mj5VP77d4i4s+3ZgunHpp/kBD
 gUNLGgVMpl/i6tQAtLS3/yc7IPDWjSC01f1gqap7ZUb9JYDP2jSFrd2nAEthVWlcEAvO
 WaG17wTYkxZG6+2dNlDyb+GEpxennT0SmStt3aGEFxmm1axKdaEUyPxbVUV0GfVENln3
 KDdd5K6rzMJDxdXfwovarnfkz+Jw3DezAdRaMx6dO6z6U8FvvnKFHmITUGIgm96VnfQ4
 0dkQ==
X-Gm-Message-State: AOJu0YxMsTLzeYPQlyMzZkr57oZoqZ0xAbul24Dh9zim4RXBC2REt7bL
 hoCstp0l8uFYbzT7cqic4ZgML6XCPtV+GVVt471P7stontICL6GWLyWGJV0aD4MgNV1CwQ6GOvp
 Gj1WO0bU+MXAFY7orlaDKTvFiR6QLkWYCi9qV3Zt4jVrUwWcCqfj7DVMXF88izoMQIfgz
X-Gm-Gg: AeBDievzLlRZmzynXaws0odSHDNO+vpjuafLv4KmDkJAwdDwUW6qmgg4kx9z9ZZDVHs
 P8cWp4xfaVKLwG67sYS2DJ3A6I5agTDEwgjrGAUUBe0kKxMRiv8ZSL4myuFL53j7K/B+o+rub+6
 T8/I6Yod7fQKknbHASE2Q5oABxCS0sD+ZbWkR8TLugfq03GtJOKch/fMrsQot4SEekU5kWDnu34
 BUHWPNKMOsiuiES4mZFO1EUFOtvUqh4rmXj5YPE33sONvh5cpwlZZKavgC9IrtdzlC5tDdJnjt+
 lC3ZdntqY1wlp+V3HHHLUN/lDGxGSZpbwwNdvSC2fvvfWq2lDVWnaFIsgMJXQGos7ySTWkU5HR8
 FIIPSJplOkD/39MHD3+4eevqpu//+aSM3I8sMPbsYzBS2iKNN728i6MZ+h9SUYJf7EYY+p0p0KN
 SYlhMXzc46pcNUH9hT
X-Received: by 2002:a05:7300:818a:b0:2dd:c066:bfe with SMTP id
 5a478bee46e88-2ed3dea53c3mr2194579eec.21.1777581535411; 
 Thu, 30 Apr 2026 13:38:55 -0700 (PDT)
X-Received: by 2002:a05:7300:818a:b0:2dd:c066:bfe with SMTP id
 5a478bee46e88-2ed3dea53c3mr2194559eec.21.1777581534884; 
 Thu, 30 Apr 2026 13:38:54 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/8] system/vl: init module QOM_EARLY earlier than QOM
Date: Thu, 30 Apr 2026 13:38:40 -0700
Message-ID: <20260430203842.29156-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX5/urYiyCP6m+
 Q3Ka1rZ9PncvaoGWHcSNhg2TekQdnRraRVxkbVyWS97px5CoAKosjG6jr07VxSiEY3kdiFbOWyd
 L5KKI+iVZfry4Z8iRHd75rTgoUzfJ6HrPwpuSMaC5vtYc+Ht94dzqTF8+M5/TSryBEUt3ojRk+D
 k0lWGNwucMWHHSnsWI3i6fkWXnzkCKrV49va+CRJTeC/z93JnIZ3FjdhSmBmLK3DPOWpr6N+IWl
 IO/Xc1cEH93A5EjoYs86FpEuCvsDuCYd5p05fjPOLFDpr+D9ucAMA+urkOeheLOEALXm1TPkj/h
 Zk5bSSyCrVRyTO8SW+Xp8YGIMCVU0UUqDv4dzrJ+Y98w7366CBR+eAe6D7NVU4F62WGf42TlGI0
 794Zlqmlz0/MuWmWmKRBecAGl7wmbJ6oPwzP0Bv4Z/Z4S6TnixEZU9pYe9Ciq3XDK07KatFdlrO
 SHxtJ7St728iLaJh9Mw==
X-Authority-Analysis: v=2.4 cv=DP+/JSNb c=1 sm=1 tr=0 ts=69f3bde0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=C-Hl0FBBUL-qwPW0LAkA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: _AR9kPOSomq1j7fwgh42pgpm65G-Qkti
X-Proofpoint-GUID: _AR9kPOSomq1j7fwgh42pgpm65G-Qkti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
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

It allows to access those types before all others, and especially to
query target-info types in next type.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 system/runstate.c | 1 -
 system/vl.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 43d60bafedf..770253b467b 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -981,7 +981,6 @@ void qemu_init_subsystems(void)
 
     atexit(qemu_run_exit_notifiers);
 
-    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_MIGRATION);
 
diff --git a/system/vl.c b/system/vl.c
index 0e1fc217b4f..f777a6da1ce 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2888,6 +2888,9 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
+    /* We initialize early QOM types, which include target-info types. */
+    module_call_init(MODULE_INIT_QOM_EARLY);
+
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
-- 
2.43.0


