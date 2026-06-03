Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2E1CD6E72
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsar-0000xF-7g; Wed, 03 Jun 2026 16:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsa0-0008Hg-UC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZy-0004Je-Sz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EbhHm1476759
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JQR90cp+QFP
 Uvm6Q8olzCzDAjjCzsQS5gRAB0T0h0cc=; b=JGpzHJyVDwLKguJ2jIY+2sZAgDo
 Zm4lunUmBz8YZS8dKNJxJAPqRTe/Aa0K+E32iBh0fWRdKGjttmBMASkh7iNv8lSJ
 p0nxEaXo3VOnnhRfQqQ7JylhjE72eLzcwFfaZa67wbeaGr4qjg8vGmyGzID/5C6O
 tMS9Wj8Pzn4eRKxOpM5tfuq23pJAeluk8Ea+5DQ5d6FzNDUhsgnGVd+HlrQNScZz
 14G0u31lgMcOD1e71y47t1ZFkmw/X1OD4I1RWd+QW6sztURRF1FMmkyr80XkXOIA
 bokWjzgm7YKlghrkoxCCWbgmHeQANM4cHp9ZPGhZI90gQCvfrIYwa6EXeQA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nsmyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ed777a96so756401eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519951; x=1781124751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQR90cp+QFPUvm6Q8olzCzDAjjCzsQS5gRAB0T0h0cc=;
 b=cX2qYP9Cwf+VeJ+SD9MSjSWXHlTmBTYBTD4HIdzJExm6ZG4BdUBEn353ROw5uEyUhq
 eOCdNyULPSWKaseEUfJy93Zly3ZNdGKr8qlb41Tc1S7X9j1Z27AxwCXoNgK9klHBd4N/
 d3q+VwMkG/W+87Rht/tmmjp0r3vMTXDiNz1xQiPDCGGMshxZHEZYqE5mhJpfFt0uM/jF
 2t2NjU/QH9Zz9Ik8LYA25ChpFfb4J5hMI7Xo7kHxvUDio+GOOeIJZznmyAm3ncbEQ3LU
 1JBDmHhsxEAnek9VpuJCBj5Yj+Smmi0m1cKIg8oNhsqwDoWQONt6AMZLGohqkqljLNV+
 7h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519951; x=1781124751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQR90cp+QFPUvm6Q8olzCzDAjjCzsQS5gRAB0T0h0cc=;
 b=qlsXlmQY2TTmXXrczUevPPKDIGUAF1gPQaApXkfXF1/BkIfNhiHnhN1nFMwRd+LxUm
 f+Dr9n4BXmxxPssUmzp43d5n+l0MO4LNE3kczAu/6jx5S7G4vHug6vRRQCnna+fZZ9/K
 FGTKs5gF+zNfwgLzZU3znGNObNelKcFcOngWAhyA7DDOS5nsQL1ARCJY2rq3sjOQMV/h
 0972wTZvLaqmnEiFWweoI973Cz+P4OWoOy40J9TLDZBhrHDVaA15jtexGQ9rZKqiyQeu
 eTedpKKqk2Fp7ViDUPr1eGYy8QwboNW47XMcC7QHlI7T9mRI93R1X4Bw6T3oNvFHpJeM
 DnDA==
X-Gm-Message-State: AOJu0Yz6xTrIWpjIgD0SmkCgr8j0dxIFvdDxX7ZCtIVH6383vyDL2Jkt
 I+d99TSk3UdWW2/jq0wPSQFNzZj31uf1hd17TLxxKbLa8xhb8WCDCF+S5pL4KBqJKmv6/BvcZvD
 EyXKuedD5/rI087pk7yjuS21LbAg8O/8GmRlNxwzPWhynKdXXgQuNUZ8SkzR9/rlHgruq
X-Gm-Gg: Acq92OGx7mjVBhWTERz4/P7Amlat63oO1504gUxZ/22q7HNn0TwbtQIZt2xNz0anT0+
 5gzA2rr5cl8fdmz3xs8s3DGa/MI9F5Kq1p6r2+n1iBODSLvSeyVl7AAxHk158ZcVer7UBzgT7Gw
 XVUJFCyg+ck+xkYzcZHVjoD+mddd5w9wn6GSFV7I8LBmvCg40OZQSGcnoQwHxTJ66FTNAQwgY5A
 HHPQjHwOvZ3CGNVRpXJkqH54XYtAajtY17F3GRotoB6VwqevHpWZ/5rtbLrKu1jUNaAY2vtXc8T
 OzT3g5exiYSUxaWixikZRikCdm/2CM5A/sRKBkpWB6XSSWWukY33vj44hDXmT1QQrHeyuyOwcEn
 MUI169cnebdKXicyAyNF8SqMH0e881pbtlPMEeJLfzzgICmISs1CSamqAKAYZwEauYd0MRwKHjr
 Jv0deLvilN2atqUQUb
X-Received: by 2002:a05:7300:cc8a:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-307621ad2c4mr313844eec.16.1780519950866; 
 Wed, 03 Jun 2026 13:52:30 -0700 (PDT)
X-Received: by 2002:a05:7300:cc8a:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-307621ad2c4mr313831eec.16.1780519950360; 
 Wed, 03 Jun 2026 13:52:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 23/25] scripts/checkpatch: ignore spaces required around some
 operators in C++
Date: Wed,  3 Jun 2026 13:51:50 -0700
Message-ID: <20260603205152.1440291-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RiMVzUVv-XLb9-lRpqJrrxZqEGKSoBrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXym4eWKjEQiVI
 auikULkVxhtIpl8qobggexzJ0aYhhg1NUqA2v5ERSOgu28P0+4lca99wm0m+XEDyuS5JvaA4RRS
 95atkNPbGuxZJJ9Tr+6blHBlViNx8oN07FMjVcTQa+WdYnQRE69gjM8JLgXQ59s0pBM1yDRbya4
 Ho4oitLuHEZZx8hLBkqHQ7j+AkH82s7uJL02CUTD1a0v3EZEvtbBXgoNECqIkumJm1UpJiFdFCs
 VzGX+llrYgt6srWyD7vCJs6RbVTBQwCYV2PskgU/rU8MjBgDXe95l5pAWtZCctzxiVfyjGymZjo
 JUQe4DOlGH8PDsegr+Ph56dE/vmBrqP45ycaoTmMDe0z4ZpCy891lOGNeqGnkGvC3wToVDr8N5b
 ZtulivVhg6iAP0okHSOyaqSRwL+YUdxBzaCkas19OtIvDD2tJ2RwhCsl0okRD3KDFXiWFO4BRK/
 vb/FcdnHaNHuOCt9Egw==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a20940f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=CL0rStCbWIDYl8qm6LgA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: RiMVzUVv-XLb9-lRpqJrrxZqEGKSoBrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

C++ has a different style when it comes to space around references,
dereferences, so don't report it.
Also, closing templates with >> gets wrongly confused with >> operator,
so just relax this check.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2189db19f54..c74ec070c53 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2621,6 +2621,23 @@ sub process {
 						if ($op eq '::') {
 							$ok = 1;
 						}
+
+						# Ignore * in C++
+						if ($op eq '*') {
+							$ok = 1;
+						}
+
+						# Ignore & in C++
+						if ($op eq '&') {
+							$ok = 1;
+						}
+
+						# Ignore >> in C++
+						# checkpatch is confused by
+						# >> closing templates
+						if ($op eq '>>') {
+							$ok = 1;
+						}
 					}
 
 					# Ignore email addresses <foo@bar>
-- 
2.43.0


