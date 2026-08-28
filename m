Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A514C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YP-00014Y-HX; Fri, 28 Aug 2026 19:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YE-0000g4-TG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YD-0005ma-3x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTCBf144962
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QnkpK0vx4bb
 0HHxbs4uKYPazmmLRmDbX17zayuGppVI=; b=J2uQG7m3moMfeOPz6Fnrf5OmhPx
 fqToc8dtrzgYy/mm19TAUh6NGLBJDiFqoR0Ux/a5YbP2ORJ+wwB1p41J7k24OAcG
 Ph/wEDmGh51P8loM3v+gA7ASFPpSf6p85WXOMt+OP76kIoq61nYCUmaoJFP5t1sT
 gvVvRA+rnLFTqmicwZxL/UT9Ss0i0nOUgKkBSxJD5ytbYllVgJQZslaFLkKpXXDW
 HXddcYkUgZMnhC+dR9cLBwdB6gpXwmjRJ0f0X/+BRs3c/TGXXDPu2PzrBxSa5F0c
 fpaXrx1ybzMDbndjzK25tboiGR+nsVx7lAKk1GneKFdqYNmApOwTTfMUtMQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so2416701a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957985; x=1788562785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QnkpK0vx4bb0HHxbs4uKYPazmmLRmDbX17zayuGppVI=;
 b=SbzFWA8bWrGl2+VSYbrID5qaMs2zw8oYb5Vs1Eu+8i+v4pYKghvFPAKWuIjcz2+5E0
 m0MYS+77Jebu9GHTwZE19fUyOpvQAcIXiG4rwMNLW5zOjEKzPB+u7IO1oW/x1FMKO9xK
 SnA6S2iX145/EEU4N4spskDU5nitYIowdMPgzYIq70RMcLFG9EI9eO/obW8Y3NAFQ5ky
 39KnQUDOlMV5iGv8dTrFKwyMe8uaiTccCFZXdRxR9rsDzxD4V4NR9920gqRUdNFjygbz
 fJE9Q181+8CzVn4/EQJjzU3atZD2ETjuHML8qKIBXbB8wwWYbgcOf0XoKWzUoPDYOFAL
 g3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957985; x=1788562785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QnkpK0vx4bb0HHxbs4uKYPazmmLRmDbX17zayuGppVI=;
 b=bNjfDZP2CzqHjKEcfB4l74rSuzAz66fhsYXWzIegsMsH23ikAEmHA00witVAZSylVN
 FWng6P/pvy4Zk8nPnu2vCswjOIZAc3kd426Ai7qvCxaTNqEwwoP0UxknHfcbmuxvGbyq
 2jmbGpUPbdX3/P4XngoMqzfKAcbb/U1ebcABsg3QgPtoXiJCbe36YGVH3DE4xGdCwkt9
 UUso50T52l31lYkECRLPqze+XZOFIb06IN6qJan6b2GXXwe33RP0rUDQn9xEY6jZXP6J
 g7eaOvYXNt1cceg70LVnjgTmtzeXkNJI/y+Ru/qQujK321hU2JqpHjzg4J2BsJJ5pbAQ
 6C3g==
X-Gm-Message-State: AFuF++nHsBwWwyd+UyL0gDOcAFK7mtwk0uprr9aZDPPRiKzsq0BNi+6f
 3pGdgkZIufuOxuZ0Fn8psMlDNmGI/aDI7akoTL0fx+1VUufAxMEo52HqZxjNe642PP1H1nu+Idz
 /nUYFPAvN0CFsb0V3G4DAZ1Tbck8Mj2j+xplEcVsgk/61LGT0P54qNspMjWcpVxszvQ==
X-Gm-Gg: AR+sD13lkYeIKUPyQv2CwIjxgRAaaltOS8KGeAxHsVlfCn5Sg27NRADJZnbhCCQysKa
 zo2XHXVvQF/EL7587XIPOCCn36/Lwz1Yy5n/CcG0C6YM1fiHjo+ffwEamR3PGB2KDbkWcR+0dmr
 5kLCTxSANGo9THt8ayR/3KCR92Z+aNy3Ac28fyGGbstuNFlbV48iU6fHKpMCqgRJlQuiwc1x6PI
 uXyZDV2NMKRGcABoSgDfhyfiollUVyFOJdmQ09z2nGFENLVcJZZzf5yV7mWTsKV5gK7hGmYq+ow
 w0cjB/n7nRYYNLrO1YtIZER3f/hZoWWzkeAictWfSzM3ytgCEh9+FIZ2krGJ2wgmqRk2np6sh6T
 KgWW5Y+bW6beyxtsunTY+Rz8hXYAJl1jUTshs2a7PI6i2j7KTWr2V4LKtz7Q=
X-Received: by 2002:a05:6a20:94c9:b0:3d1:be60:2816 with SMTP id
 adf61e73a8af0-3d268cf776bmr16625774637.10.1787957984814; 
 Fri, 28 Aug 2026 15:59:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:94c9:b0:3d1:be60:2816 with SMTP id
 adf61e73a8af0-3d268cf776bmr16625729637.10.1787957984402; 
 Fri, 28 Aug 2026 15:59:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 29/47] hw/display/dpcd: filter from CONFIG_DPCD
Date: Fri, 28 Aug 2026 22:58:43 +0000
Message-ID: <20260828225901.367438-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dyedkWnvOW3okVEijQBk58rUwqHhR6iJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX88VdZzQzhaft
 WIIS/xK1i2yOG50CGStBaUwIDj2ddMxosB3Xz/GoECXw6SKmuhMsTKD9WfbKwv8HL7YsBK2n6XQ
 2ZXi5PUdWFiX6otzldKJx1ymuvxpKmGPmID9YkQXv17aZ2r+NcKlXBw5jbOAj/5x0i276YaGS+B
 qdPGzItN8ZHPVTFY/SVgDV6S5XhCWJFuz7sodcTdPlFNxgQih+D3efB1eO7G8uiZYg58iKHGRpK
 HZtt907JuIJcnhGzo8bfAAHMONrRsqCmxvYP1r2McUnbhbBLK5TIjDcKBvvHgoQ7AQTQQWs5idf
 JoNN6m5gJAIAhPOj66Nv/P+e9axCd7KdFmInCU7mw4gXyXk0sYc3L9CDtg6VPxgpexXJvl7sRa3
 lpDnmAqdGP+UPFw3UVLE714qnwd6pTdJnPqSMeq9l2o+GAG2FF7t2lBYMfCcG0GTJ9MVhg4NuRc
 o/FwCBldfAmEgehM7FA==
X-Proofpoint-ORIG-GUID: dyedkWnvOW3okVEijQBk58rUwqHhR6iJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5198m53WFv5r
 xD2rfP4KNAi9QRZTgP4S4SZPyDcql5cBeGHhP4Y2grl81x1ZTr8q6xaTAolTFTfkOR186KdZsYg
 oEu9u3ZuQL6Blyxvc37pnTx3RTl5EsY=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212e1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=DpQN1NHFPUbzgAs5xLEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/display/dpcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index a157dc64e76..66942e6dd6a 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -155,6 +155,7 @@ static const TypeInfo dpcd_info = {
     .instance_size = sizeof(DPCDState),
     .class_init    = dpcd_class_init,
     .instance_init = dpcd_init,
+    .is_available  = target_config_dpcd,
 };
 
 static void dpcd_register_types(void)
-- 
2.43.0


