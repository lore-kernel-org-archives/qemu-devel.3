Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F35CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRm-00075y-Va; Fri, 16 Oct 2026 14:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRl-00075F-Kb
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRj-0000UO-Ga
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5gnm1613410
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sHCvKcH4WY/
 B5Yq6/c5OukZLpLqjtB/TYLvBS58kYc4=; b=dgUguDs7uXJNc2PcyheFLKwxHws
 Zv+vY+bupGuppKp7GPhmHoxyRv9oqBgsS80P+OV73CQoGF8owRbA0ow/po0a9gew
 5sEZ8/C9KDYXAKiT4LpSLu0yjydXLneh37nYti858C//6JQ7KFA9slP4+CQ77Ht9
 gHa5bcv6BwTcBvpagS268/HstNdP7qKgqdN8oJm2+miF+f3SJ6WDINbNLz3EYbYc
 ukj+WEDd9YKAo19j7FT8PN8d7aUn1TKJV1WAnNUkva2RJKq+7AWYcDzhdZmDc4zw
 qtVmGIFdP+xnDFPY4qRyQMaBr9bJbNb/zaER3WNqokfDbveyVej/nFnWC8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v1hgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab9850456aso377105a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174459; x=1792779259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sHCvKcH4WY/B5Yq6/c5OukZLpLqjtB/TYLvBS58kYc4=;
 b=WR74StlO2Ns/pmIV5rR16jDdoYb/fWZrG3wDm9zHVVB4scs4arxokYakfIXu3VlzwC
 p4AkuYE4ecCjm9TUhFtv9e8x5lAwq6xW2J0ahepwAg7smbsK01uShjWjVK3obWPRMKak
 Uyz5IF4N8cHX1hHhV4rZbt9DW7ZLgqDteHqnDqK+Jvmyum1i1oyhR/auDAJsF9+F+DaS
 vz3Uaq6pYi29V534v3vIvo0bQedAfLBVmT4sz+IGgAxM8C77XSXcHrp9pYfsFwsXrntV
 kTxx+fNMS9NgPKDspn53w/tg97PpwweSRhe/jC2r0bRZeZShms/Ws4/zmmqM+UK4ETs1
 HrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174459; x=1792779259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sHCvKcH4WY/B5Yq6/c5OukZLpLqjtB/TYLvBS58kYc4=;
 b=yBu1LOJaiFmciAHIsCEQQvbWSJ1iAAkRyyGi0mh4ovrHcfXXBD7oIbf+say4COHWNC
 UcRSVaaTJTeNkIL5jJz1HNKeXCNqYVONzlQs80PTv12EAQEy77z4koHFp2zW6JIq7Mmy
 MKS08AmehWYypLeJsESZxMo1NozkOPFRBPfIQpAvponeujJkZppEv4pJmsjd2+F+oA8r
 TfzoBvBnfsAhGMgpAAiRfIbzH23wTiral2jNxIsDxKPg/f2ervu32gHRwAg+pzvI/RCx
 O9kDsWBvKPgUnoulcFjwvxwqSxuG3ZqrUjT/53AHMi5svmw9wgk7ukLt7BY6RKHTGWL2
 HxlQ==
X-Gm-Message-State: AFq9FYLtxuURAUyXaVc8xDvLeKVlzprgumQ1/oZLJwl8cpz02TQl7g8I
 lSYNvhxR3OiQiN5CiJQygoOcTt0/t1zotMeqRUR9qSJMqkYxJ7QV9ZFOiMJy1iIFyOswwAP+Jzs
 /iaU/DsTM+vsDtMR0Yv95/BRNNJbZR7Hn/Zax7YL+3lXzQant4t9aXlKK2VXoH5l6zA==
X-Gm-Gg: AYBFou23n9n+Gv/GoLTg/7+SnabKzz2QJ82aZ0bOeUIg73qzk66BPocPzNz2bkkM3i2
 1yFJFx7XT8oCMPmzY88VKFi8N1wv2vHRY89SJbc/SyFLJXoCW2OBsmC6IKuvJDIVoCCJusTvL5Q
 t/GJSZP7o27vHBet54Kei/hFhRx7esDvIL5tmIcvcZIMFrlyG/yffUl46VmaoZZ6CjO0qH09sUv
 R9cIp116VtTsJx1I1PxLJP1k1O43bzuLTS7wABCGGsnqKWL5UeNafvY/89n4BJkOCgWY0YcHr/x
 /3SdX0oIPtE9EXVAnl/c/VO5vWY8tFabl3z6KcYQ6CoQu8Bz2x71R6VfxheAcW73pBgBdoNyKtq
 XQkqP+PPKpS/kmMXpX2jZgq3CeEB4bQnJryOLT4jJP2dyLy/bK4OxYMsotbIdXRM=
X-Received: by 2002:a17:90b:3892:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3acef3aa12bmr623274a91.52.1792174458537; 
 Fri, 16 Oct 2026 11:14:18 -0700 (PDT)
X-Received: by 2002:a17:90b:3892:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3acef3aa12bmr623250a91.52.1792174458110; 
 Fri, 16 Oct 2026 11:14:18 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 01/23] target-info: add target_heterogeneous
Date: Fri, 16 Oct 2026 11:13:48 -0700
Message-ID: <20261016181410.191743-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UhTBkBWjit91bM_OcosHxIVFkmHdGRzy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2fr+31cXsaWd
 EwuFpL3fyTf8kZC02jFIwN4jwVjickDbFK8CteaDfTAEq66D1BavqET6WeVaCgSY1ExR1Qa5eoS
 /ATwrTMzSyoOnmvKObpsjkmH5FvvRtw=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad2697b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gWBptB01sUyPCzWYWEIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX57ubUIAPiUdw
 gjSagKncF7NTfrZCP4uY8xtFpIWLu9ZXFQ7HN4fCSwEARyUJ4VXF0Ns0UR27lrSfjaWWgdzVAW5
 qRCaWf1i7C0HqjVRNA69X8QLgur4WQ1N4aHva/Uaa1biwi14hLMaDQ0mlD50kilqgSwEJJzNTj8
 bAb44Ll8MebIeSIVPeZIoq8onbTvRKvnKQOxel2kXTrcrAaAB52/3zRZ8Cy92yEnJkyxQvpWO6U
 Duz4oYWPsdPcz2zJ5Z8FW7z0oqOlhHV381Skkmi7o8XhkjZXu7p+rcIH9fCyE5IjEIQEs0ROHHZ
 uCVodO5EWLbMXwTLiajSYKuP0pIDapSuOUG2hKHd4AEAQf0Okkr237GeTU5D89H82+o+bALzZH5
 x78LVrlHRIwUvI8hU5nW8ZlHi26dfzkNWCqRDbZwDrD1h69OG3FEEppj7nJPZZ55nYNvyvtEek9
 lkSjLCoyYgZeFnpIG5A==
X-Proofpoint-ORIG-GUID: UhTBkBWjit91bM_OcosHxIVFkmHdGRzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

For now, this function strictly returns false. We'll turn it to true
once heterogeneous emulation in supported. Meanwhile, we can use this to
add various checks and asserts over the codebase as reminders about what
we'll need to modify.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 8 ++++++++
 target-info.c              | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..923c00c917c 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_heterogeneous:
+ *
+ * Returns true if current binary has support for running several target
+ * architectures at once (heterogeneous emulation).
+ */
+bool target_heterogeneous(void);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..b8a4a7ebf7a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_heterogeneous(void)
+{
+    /* For now, we only run a single target at a time */
+    return false;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.47.3


