Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E09FF8875
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7p-00035c-AE; Tue, 28 Apr 2026 19:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7l-00034B-9a
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7j-0000Zk-OE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsUNi1796747
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xN07uQMTIiZ
 ApIZXRasVymLTJTBRJUnIgVVutbnhYno=; b=NPvN3QOi2BfH/8bi1rWPDJM/lBU
 0OQ09uDInsf9tdQhw4DfxsdnjXNgrq+KSgNdqNhbcqYVY779TdkCDjzQknOPCMWV
 YVrTEBdWM8ScMIOYzQ/OoEHqI3jrb0D/ttuPB786bE5/hyD7ZtSTjb9MNHvD1QgW
 7zuYuUnVmTACORBQSySNY/j1PNrN2ZrI4n5La4UQl6vPX7XJkkEdI8tXkxppNbVC
 BRj0n9HSsRljLg9V8DRt09XhbARx2o7BwY4EUx78fYJ7AYMmD8f4prVqSDmFwtby
 qp7Bms3bjX/M58nB8+Mqyd7Y+7EmhyVI070aubqVNLrjKKkIgwjhAK2Eg9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2txy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso15709495eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419949; x=1778024749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xN07uQMTIiZApIZXRasVymLTJTBRJUnIgVVutbnhYno=;
 b=aJrTAg4eVhWvIq59cY0qQ6a+KhScMPxqdGK5oAD36HJcEKO9jcBGGpq3egccO9AIqG
 utdHu5l5uPb+wv9yNV/sSRig1/GhIE3lWC/v4X7NRXyaMvVqnoe4yHe6oGBosZ6pGZ1a
 JWI2wTX2wrFDfa0Zqum8aDoyhYHBz4Xj5QhTApydBg18KLuL8R5O3mCCxkVLk9HCJoSH
 w4Ro8EXPHbq8AwmHZvRUe2ECxeu0qWAD0mp0EN/FozOZGwvhTHigK7pB94bJdiN5zqyr
 My4a+p6TlCBCLfCZg82DraD7l4qwHI4WnP2sqQsw7n7g7+fgIsVH2Nh1aj+Aj5Rvx31U
 lBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419949; x=1778024749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xN07uQMTIiZApIZXRasVymLTJTBRJUnIgVVutbnhYno=;
 b=XvnVDkRXx/VqwhkwEqhyzgUm3QcHYTx/h8HyXv5HV6OLdiVr67ZHMdedtvG464VihR
 zFrpRKjhUrJibM+PQS24n9KdR+Bj2eB0LUninjZ+QnHkuD+D5Ty1i7kp9oQm6ob3IP4n
 9RFNyHK+2fOpgL5DUyAWBDNPu8MiYdvzdCRZWOrZzurMGQe16v10JDMMm+06C8wZIzYV
 qL83B+MRBQ7VwpPqg42DMrYp8rWYiEavVObWG0914JmaDZOKvAWDsIdB+FlIu4ZelaFl
 fptVoDOa2oN+9Eu+o3UucxD/AMg2IiLtqGST2JWOadUijYg777ChgonkqRiqLCjuLUQb
 9Scg==
X-Gm-Message-State: AOJu0Yz2wWfOyl1Wl6zlaS9nHTGTUZYFrmdqBq+xO1cVjkUS6TEs/50m
 4bjEPROI8rPQm0Tcg+OBD3Tr7iNDcUl2VaMFJYnIrFzvuLpI34CD7MOT8Oh7y/ihtIt4q7E99Po
 BWR2tVC4Z1ofbJ5KMT14Q88FY3aztP27BZG6DujcbCQFk6oDAPOl0Rc8nJSaHbJdM/7Pc
X-Gm-Gg: AeBDieslmBn0s9Cfcv0wr1ijt9qiFeKw0FWA0HsZo5tR9LZVqE/QJ8ePPj/Nu950ieK
 A+ZNhwvhbqMIFjq8rHZCJDjiwvY/UtEvnHFK4RXAq6bPpi3OrF0o0XyIAYAdIZgRDDgp85L9y70
 oTSaJPfCr2aVpwtUU9AghTb4aPh0iGMyumJPoBmAogAz200mpBBKMoc1q7gDakO5QsDVBw1q8G9
 +py7nPG2aRqr5iydacFFLhtDAhsvsotEx0nfJIXbAFmvhrdzj95TvhmqlCl0EV6w6a+G03yAKMd
 x/9a5agDH2XPsQyoBl5dCxW7+/FFKXzxoNa+2gEGteZyOC88lSAQvDa3bTT+4rqy/BJfd69PLOZ
 6ZpgcxKBhmcwJ4cgkQKZXBv6ORS9cTbHDXY6mfwnyf7X5kO74TQuzfh5PMf2E32CJWH4YBLWwjz
 7fuldMJo7L8iXo2A8U
X-Received: by 2002:a05:7301:1011:b0:2ed:e14:e957 with SMTP id
 5a478bee46e88-2ed1995cb9fmr676119eec.33.1777419948934; 
 Tue, 28 Apr 2026 16:45:48 -0700 (PDT)
X-Received: by 2002:a05:7301:1011:b0:2ed:e14:e957 with SMTP id
 5a478bee46e88-2ed1995cb9fmr676111eec.33.1777419948415; 
 Tue, 28 Apr 2026 16:45:48 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/6] target-info: replace target_info() in system-mode
Date: Tue, 28 Apr 2026 16:45:19 -0700
Message-ID: <20260428234519.1812371-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f146ae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=PWnYilPcKYMXGEN_2O4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: OTgBWkm_zmU4DmRyibq5enlixkfiP5R_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfX2ou9hVVaXyIh
 qfi49jK9kdTD7Lo4xqj/tZAW1Y+ugfEh/y+4Z3n5cpHG6abIuAaBXd7zcu3JszmW+zsLnStOh1d
 sax4Stltlryh/LYbimrpG/JoMoRh7Xtv6KUDXm5P+VM3CEzomwmEgv4jOqezgMHBEyRavNc7DfG
 F8/7KBrjUwKzqtjQzFX4VHkbgAi0YXLv/W5yb00jtR58mUzaJp//MQZdo7Rh5JizoyskgABjdJ0
 3hOd7mi8w2wYh9RTomSBtDV0emZFG70TFKRw03KLOGakZ7YrG6sBeTe8MhYwuJFIxaD6a7yguMF
 787NLfqRgh367hWZMVTdPuXqkbgVQLrPKZc0eBR4UWC90PCTpbqGNdeNOJchH5k5gri6N1psdPq
 /EyywgNtLXx6hUkZUCRBAJfd1mOL3YAt+7GkfbD9KuSTxNtIviWyby/4LXYc1cUbO0/lvuqu37t
 huxFpeoKSgS46/j610Q==
X-Proofpoint-GUID: OTgBWkm_zmU4DmRyibq5enlixkfiP5R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280234
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

We now can use TargetInfo information available from QOM, and remove
duplicated target_info() symbol.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 5 -----
 target-info-qom.c               | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index f3cea985540..51aa9419e88 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -41,11 +41,6 @@ typedef struct TargetInfoQomTargetClass {
 OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
 
 #define target_info_init(ti_var)                                            \
-const TargetInfo *target_info(void)                                         \
-{                                                                           \
-    return &ti_var;                                                         \
-}                                                                           \
-                                                                            \
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
 {                                                                           \
     TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
diff --git a/target-info-qom.c b/target-info-qom.c
index 748fdd5a8fb..feba764a6bc 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -35,6 +35,11 @@ DEFINE_TYPES(target_info_types)
 
 static const TargetInfo *target_info_ptr;
 
+const TargetInfo *target_info(void)
+{
+    return target_info_ptr;
+}
+
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets =
-- 
2.43.0


