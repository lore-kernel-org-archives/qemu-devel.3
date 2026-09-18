Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D122C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eKo-0000Jm-AU; Fri, 18 Sep 2026 15:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKm-0000JD-DV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKk-0007Pq-Ek
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoEBJ1666287
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ganEZGG0Sc7
 4bkQYkohPbHsmNDuXbzCHwths6crHjrM=; b=PpRcyN5LKAhvb0uVrUSEEfoo+vu
 C1tQjGWnSLiS0CVQaAONTDfJdC4CmpWlIFVC7YkAce7EzxgNuWYwftCE440MMgoz
 TFD4eHS+V2cRCtU6Z+LIHvucJJWUDq5VG+PnTiSkPqapybr6uNba+Sy4H7QFhPz+
 4ARuUdnl6efFPjLQCKUejavYdnfkBKyfXAHCI8m2zAcAr3fP8qM//wO9RGhYlzmX
 5LCgFO5O9U/xouwDTHl/BXtOrPjSZFPxA2nBR4BNoP9WZYe5ZtueTxu5sV6pYyBZ
 HwHJO9XZhBoNgFLlX9vagxrZAjk5phQtbBJ+OXz/AIYW4ao62cFUJxzwV+A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2ujrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so1069553a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759996; x=1790364796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ganEZGG0Sc74bkQYkohPbHsmNDuXbzCHwths6crHjrM=;
 b=YTK/EtA2EAmeF+ZFozoPYLK4iupas6EZ7suwCwlj3qrPQT7X3dKvck0KkTGMVGbjIr
 3iNqkAlnzNmnfKb1mt2iDTv6Yr9Y6wyCCNOMAsqh1HQczNIEMwY1HpdaJW3y9urY9s2U
 RLs8B/jfwMicYATM/6YcodGNL3xw+/HKT3bdgN0f8UDkjjiZEUVrt3zse1M1Ya914erh
 ygsCVNDdUcYdEEP+GuzIdu4rNfUqrBz0xBcxigi8ocqUsd26OWATQ+T/vkd4yjj2tkpP
 vwo4BAwEi+4PCUlU6574I+ZxGnIXot7DNYYYUyhfaNFiZHbrYZQRR/O8BWo1MjFpSOGo
 IcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759996; x=1790364796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ganEZGG0Sc74bkQYkohPbHsmNDuXbzCHwths6crHjrM=;
 b=D14xNqsJXeod7j4p9ei5JQ/3Sjw+hUU99SrZMynZk16JMjtnUusluWBq43980vFrG6
 BVtVjE0DIH2BIj/PsF5tCXV41rdb2ySAgUpFNV49RfNaWO2c4Q0SLnSxWKaUbj+cJ0i5
 lmtufA82OYvPjuFegOAv96niNaVPdkj82EJQelkEnYtcRCZrtsOFJBf4Gop0O0K327hu
 KKnhsRs1Q61nSZzIJmc7ixwUK4sOji67t0DEsaDE6tzGkmx0+7/RNmB+aFAl5UYwOXJB
 JQG3+S8h1n3ISmlNoiNtKbaIXVkXJwb79ol5LnnaPCTdB6k6OxPcE5OXPifncYg3aelo
 ojag==
X-Gm-Message-State: AFuF++ndUknkUKMGpo1TpxLrfHqnVfYHxlZmEhqoekgnk+Bs6kydvDyx
 /yCYXsvR8O6sr1cWGkTE3DUbzsXq9Sm43Q7FLy/GrDfxHk4cM6i/clrF3V6eK3Vi/v9RWgY620B
 jt1cfRhC7m+EcaJn+9RAP/MzzbL6LaNUxrAa+r2dNcHH86OJZAmqd3hbPUgeQjPYZBg==
X-Gm-Gg: AYBFou2Luv25QQ/tpyontbRVy5oadQpa9Dipgnyx17QIFuKDXzBARuUy9MBHGL3Szd/
 fQL5IkvqX2mkE3kGlv2gMuwiCq01erwnLOLtoiSuh+yX2kKJbTSL+MX+eLg+N+O1JuOLnAL5auO
 Pbvt+vxVeQvWtuVNYdDcJpTC3fZ0F0yJBpjnGLWRJe1QXR+E0kIKhSuy0vDS8FPd9j8yzyMXSmC
 CYuPUsKrg01koMPMZtmFlJ9ol/BDWwlsMiRn3BYXv9bEVeLfOMNY9+gEcHXbW5nt1Bs22OoJd+v
 7jDtu/MHi3ZF8Z3VOZtN2xT8krAKqxippBb9mholbc7tAZ0GMOsPqamXaYILmy1p0yXRuxUeB1+
 i9v7dH1069J6FtT4FOZWLk3bMWD3EngcUc44Na0R+zsGC/qH5GgeQrETrIe0=
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:2097 with SMTP id
 98e67ed59e1d1-39e6c6a2359mr858008a91.56.1789759995801; 
 Fri, 18 Sep 2026 12:33:15 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:2097 with SMTP id
 98e67ed59e1d1-39e6c6a2359mr857988a91.56.1789759995142; 
 Fri, 18 Sep 2026 12:33:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a716sm810682eec.8.2026.09.18.12.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:33:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] tests/docker/docker.py: fix run command with $UID == 0
Date: Fri, 18 Sep 2026 12:32:58 -0700
Message-ID: <20260918193259.704462-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfXx6GKlHEN6cdh
 vFpQftOhidPix/RhgLUmBHnst6ZLlNoC2JFMVdo4NQH1K83D4LWtRVZA4lEYcTH7bOKqvee1P6u
 xG0ud5wWxo4+lbboy4Y1iOS44bdTUPc=
X-Proofpoint-GUID: lLriY7aZ8T0oCXMioxvUiV-eb574e2s2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfX6jJLfzLbV/nH
 oveRBQRMZa+P1GcC3dwMIfJQ+uLl/n3KhAXROzi+qSOSRPjo+KLynEp79SDz3jouOOMQi4FM6oB
 OsKc6MXjkz16yYoPPtg2GOSXW097+EU3iGVLcHpuh8OyXwR01UjAUj8da9KPD2nmmXj+wNjP4Mt
 YCGJsFeptIXESQml7qI4UIdMlltvIFPJy60vTTtEu63xyubA7X/KdjTBz3N/Rx84FsVNDHTHa9I
 YDksbSkxXFgbjR3XiLoUqN+n9U4q7T+85l4wqyVd2f4BdrhBeDZdCymrwBJzb3+ZzqpXXMzsdnI
 sHua33kIUqPTcr6hPhoTWUT1qpsOGqF01WUuuhLlip6/lIGPYaqRgRJfmM/zoMxl8iWT3TZTWUK
 RM7/sDg+vUx85/3OABdEaZ5D41o3jKVzBnvphjEvSBJpyBDpiB9ZReShWnQFHgRQ48aSGyzZIkw
 qK0S4wCQnxDxU03Garw==
X-Proofpoint-ORIG-GUID: lLriY7aZ8T0oCXMioxvUiV-eb574e2s2
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad91fc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=T_LeFyhLTpD9Fp5MPwMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180281
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

when running with uid 0 (like in nested container), podman run fails
sporadically with:
``
Error: preparing container ... for attach: container uses ID mappings ([]specs
.LinuxIDMapping{specs.LinuxIDMapping{ContainerID:0x3e9, HostID:0x0, Size:0x1}}), but doesn't map UID 0
```

Since default user in containers is 0 (run without -u option), there is
no need to repeat that in this case.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260917221117.274619-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d97dda26967..7c15da59db6 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -334,10 +334,11 @@ def run(self, cmd, keep, quiet, as_user=False):
 
         if as_user:
             uid = os.getuid()
-            cmd = [ "-u", str(uid) ] + cmd
-            # podman requires a bit more fiddling
-            if self._command[0] == "podman":
-                cmd.insert(0, '--userns=keep-id')
+            if uid != 0:
+                cmd = [ "-u", str(uid) ] + cmd
+                # podman requires a bit more fiddling
+                if self._command[0] == "podman":
+                    cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--rm", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.47.3


