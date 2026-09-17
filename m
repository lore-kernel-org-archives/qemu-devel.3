Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF22C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KKT-00037e-Bj; Thu, 17 Sep 2026 18:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKP-00036y-NW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKM-0006gY-M1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLpOcR3859915
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Unqk3gu/z0v
 CXdrMzJ9egQgs4QkD66vBZ0LRReALOH8=; b=ideObUN2WCVJh+QJS0sSzm8PIA2
 12kC84PbgYcTPTVQYekjGEYkZBpTklnE4pbVChsNVn2tQWN7IfEXxhDrPZK1uhvl
 MR9xnuDQjAB+Guef3yyZJ6KS7iadqVwnkNSMyYibS1LRfH/zxNQQ/WF+X8bUNx2w
 7jP/K6rSqk9T/0Hw/9fDv20iUMHTgbrlBzU57asYXx0Ej6vG7RKsD1eP5SJbt+8+
 fIFhed3u81siIZJonZngj8HvZnF65uSC40BN+jLg8BJsx1VORGDrevY1ObJEs7NT
 6BRCVFyrpj2sgqb0L6tvMPntrbS9dUD/+tK4pgNtjtn+6j3UgjtChf8jAgA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg4022a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396901263b6so238531a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683092; x=1790287892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Unqk3gu/z0vCXdrMzJ9egQgs4QkD66vBZ0LRReALOH8=;
 b=ALw+bDSXkQOYcs6BzpefD97+7M0P8LG8j3oO1BVlbgITyPFQ0b8vHNl+U7xj4YZdpi
 UTbpq9OBbMcHP2d1a+lZK/WoiPqrY2NdP8C9EC1NJ0PEVbnaA0YckpNYmXzjXP4sJ1pd
 SUPrp+PYuQCR+tJSY5Ioz81ze9/V/LzVbJYGlDD8x6xU6zc2EJH1rJ7gJJC2nkJ0oHXl
 JN3fQz8mjnlYXjE30Rzjes5Qzz2JRs/Ej1qBp8UfS4OtV308KEm+t/FV1mJRLvXcgCUD
 Q3ZuiqF5ue5EC2MZ5l6HtHZIufcBY85AokIMSv+xSCKit1HZRi8GWOJUaqtCxT7iXwTA
 dkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683092; x=1790287892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Unqk3gu/z0vCXdrMzJ9egQgs4QkD66vBZ0LRReALOH8=;
 b=hMjrnMKRVWApfKQZZFPx1e1oh6PmA6KpWGIdymeEzXiXhc2X0TVblnYevDUzzepuiM
 UUoSDcCJi7FcsRrvfFrDLLsab+cjFSBxoTS6IqVr47Vy1QAEAF/Oy8oT3ldJGheLNaaG
 9Y5Y8eNMNRfy5vthuceI9naD9Uht32U8rkDlV3GeisIDverNvxLrYZhqY3S4HLyWBofJ
 0o+oIeSCeMJEwi1ud5lTCFuI8gL2+nuHaeONq1hc0ugurQjoFAnJpqLYrkuAY7n4Idn6
 N1BpBkEsE7DIDea1yuh3jSZEJtmx4/gkD9fhowXzHcO1bfl+OVLi0IaGFgpCtfOio6y6
 CzLQ==
X-Gm-Message-State: AFuF++nBttOtm0FpDUCuJkEag57Eb5LcOQDu4Idw70JCeNEBDiW9e4aL
 +g8zdG5Xa57PBPgRNQwHsLJjpL/VkoGolP+VlVcQp8lSYfotzz4J6vtPVw2cQpvC6ivtlmUebxY
 AgZ8VTETzVDAZ4qj6Q8KuDkx3pWQ8XW2VD8cGE48eInCAP5bnOtoef7yTkD9ivDbZZA==
X-Gm-Gg: AYBFou2MdGB3uW9FCwJK10fBAYnPVLzIvYg2L6nYhwEhp3GYC0q7jLe9cgZblY4WyfN
 Lk4UHJNqjT+Bga0a17xvnIgm5DY/Rni6lG3S7TNV1f/dKgN0JpQJVKlKT0u6WDjNhf3tiXbSj7K
 /Fqkac5HqIU5ZrZ4D3Oo8i+cExnhF2RpP6FZ2SnOpRaqYdri/H7pFxV/QJl+aRya0kbDE8h1mAQ
 HcCwYmhFVWb0dgqAgVNOrO0DxgBEmUzb4jtwHAmyaoZTGuq7LCxNPgQqi2BeG6Fdf3XR9r+ZOvI
 J9j3hxrlkt0dDfCjAHJrbx3qkC13OIdiGENSktgBYxWHGoNpyXwAnzu6aODYY/3WZoNvRsxAzK/
 v6Z3cuA8tf4GGWCFBunpGpJ3Wgvh5bHi6HgtKlc3oKcyYUK3y/GrXUJ+tDCc=
X-Received: by 2002:a17:90b:50cc:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-39e54dfa5fbmr1904587a91.8.1789683092454; 
 Thu, 17 Sep 2026 15:11:32 -0700 (PDT)
X-Received: by 2002:a17:90b:50cc:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-39e54dfa5fbmr1904523a91.8.1789683092010; 
 Thu, 17 Sep 2026 15:11:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm21021430eec.14.2026.09.17.15.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:11:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/3] tests/tcg/meson.build: fix host fs mount on SELinux
 enabled systems
Date: Thu, 17 Sep 2026 15:11:15 -0700
Message-ID: <20260917221117.274619-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KHqyUKddw7jCeIF_bnIxtbGnFib6Pin-
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aac6595 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=q-u7UfepXwwUxeN4VQoA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: KHqyUKddw7jCeIF_bnIxtbGnFib6Pin-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfXwAETSQ+Cb2qL
 oTOsMZNuCYBtiIm7AN96H1eJ2wxSROx6qjTCrIlxF4035Nak1pUpSz382S00vLMUt0cm1C77jKs
 FIdylZzHLhUesXpW3DD3AX1FrUSHrY56rhL8p9tNr7tpMUsSRJeslb61/PhtI7RvubUJRth1Tie
 qdV8yZHygQ4a52ljc5psOofXcVaGBDgpHCoxPE/tKfzoZrkTexjmVWfAeEKisy4/aXFd/bxQMIf
 8nUCYQZcFvtxx0g1LrA5xrkDhiqB3W/GB6YDM2znhoOlqGch25t27MbzP73ue7jogIA/aEFwY+2
 xEusam6llx3MDmm3FXHXxW3sAtDrnh+7r+3CoAM7YLHSik9ZHQwZ2BN+ml72ZUf3DJRd48XSc5S
 hhuGuvMlvrxSO9+i3vUyNAbPNHXwQtkFgyWVtRPvzwB2L1cRSaDI5TsZq7kkXN2ckBsaDdic46H
 ZowZmKP3aJNFqg1AySg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX3BcqQRhTjEHC
 XTu/JyXRXheUJiRE0KaEOZs8HZhEBNksb71L3p1Cf4Hs8qihphpd0+PQPBnLgLy6eqUTOWw/rpj
 O2H6gvrEmH6un3odksvS8c8M6CnJaMM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170319
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

Fedora enables SELinux by default, which has the side effect to block
writes to host fs done through containers (docker or podman).

$ podman run -it --rm -v $(pwd):$(pwd) docker.io/debian:latest touch $(pwd)/file
touch: cannot touch '/home/user/file': Permission denied

There is a :z flag for mounts, that works with docker, but not with
podman: SELinux: relabeling of /home/user is not allowed

The right solution is to disable SELinux label confinment with
--security-opt label=disable, which works with both podman and docker.

Reported-by: John Snow <jsnow@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com/
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a5e0462732d..75f0a52fd22 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -277,6 +277,8 @@ foreach target, plan: tcg_tests
       mount = mount + ':' + mount
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
+            # SELinux blocks modification of host fs by default
+            '--security-opt', 'label=disable',
             '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.47.3


