Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E10CF8E48C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVzB-0002Xk-Id; Thu, 16 Apr 2026 19:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVzA-0002XS-2k
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:19:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVz8-0006V2-DW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:18:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GHDr591245083
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qp7/atX+l33C5gpL9aBiVAQa8DajHQWIjznwPqOENv8=; b=SaD0lDs5OXSuCJpJ
 mhIgzDMIhs8Knqs1yG3OAxGlLODPdtD2na4cTifLp5w6cXCmuGIkr8f2oa/7zy5w
 WCA7B7+I0pXJgzeUCZXhT7wKfUx0dCgWEQBKsM1XEfIyG7StZFfI5KG8Ph1/G02l
 FEtXIArA3QTctSpK4NSB4o6BYqlyOvkAwVuwiXwG+JhG/JEdBQ9JXNEAwIRQzwsv
 SEQ7Hvd7Qz6unfiEljmvhagkHEkVc8nXxvTH5WcQS2VTdBAgZ4aqm+LRDPXWJjLs
 R8l17ok9slMU08IA/sYQPhDcwmV4QndL7JvIvpxaqHAZSfa9DYgGL0ylA9ACna9Z
 TvJAIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djx4kakmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso1146805ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381536; x=1776986336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qp7/atX+l33C5gpL9aBiVAQa8DajHQWIjznwPqOENv8=;
 b=dlnEMx35/v57n/0Ctes1NusTBM7QScJPa4KM24v5CYSOG13F/4M9oGuMw9/NdsleWx
 yEYnKR+3KUGAwoibx4FBjPwukxmgfkbcyWKluqJkSCua1ztx7jDxcaTAMvxhR2qRoWRT
 bv0aLKwliP7eKp6brbxB5DSJIysyvQpwUYofYe5EGvWjtMxWLKxsJCIOlFNJLubcff3s
 Z+fReBzdVCTvpYjI25dtqqrhSVC+tz0P7/Y7YavetCD3xKInHorGMhsPkyRj+2Gx3+kn
 mgdddp0Z3lcgDjq0f1YYlEHj3PvcdXgoYXCjNDdNkAyWcRIeJq+33kA1WQ85DA9fiGM+
 p7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381536; x=1776986336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qp7/atX+l33C5gpL9aBiVAQa8DajHQWIjznwPqOENv8=;
 b=evWqo/upvMFBaC+PbkNOJWjYTNlYCJJM59deGu4S14gqsqCUnXp9EDbSPQ76YMEZMs
 p6ahBOK16p/iUPmJKnvec2H5f/ihKW+EHSal3yfyuSdQsigt2MFrmuvfjQ+71nnZe/XB
 Ny74O/WIuDOkTOUMZDchyg6DWT5W6Gk2jrQ00ZUsp2mk4t0/eGYhjIVvI22Gfw9ErwPQ
 pcyr1hLf9vCRAVjhOF/QRWesudhoGhJX5QIHhsoRoAT3dl1zSVokTDseTtj5biCWgEKh
 TMaHXNDaCClSlNwW8BRyzGoSReK1954zNR2S2ptiESacenyMVkZul1QfGwjY0XsxtA+J
 7OMA==
X-Gm-Message-State: AOJu0Yy9vFTkLufCZwh1MFvIqjGlaiMZb2MEi8pXo0dSdVmf+7rt64Wg
 0DSLL4SjugpEBFDoah2dk8OBiu/4ay/3W74PcnB2z5uNoux6ufjdl5+WB9aJ9hhutx0INuEKVGa
 3rmwzwA4HGjtlP4+eHbHIyBo5RBVdFB5E08GPFN9gpMUdic3YP7OdLHZj2e7qfRvFnQ==
X-Gm-Gg: AeBDiesDl/Ks/8Q5mQJgIBrhmTn7u6pt9P+Qg3QBQJpuWVwEFI4uW5vMeVO+plgsyN7
 2lLm8QbUNXEcjFDpUamSnLZ/wSY9iW7k+3qa8ySlabO+qwo6d3jeoZnby7NLFv04gKbhhU2GaHX
 1zt6IcEmUKElp/FUJ08+8HUACSYvNSpUQ0UwKjpp+vRCJETooAmsOzf5fQovrQ/oBMJnZvFoWb1
 JpBMpr8JllZVypNRqix3hTZHBUOhmNQaA2PRmyNdoIEZzXH7YkfMUTio3Ci9ltVRqRhgH700tUw
 627oZZoOYuLvZHzU/vrZR2ckvwTXN9ipmwOcoaYQ+xWkwfxh4dti8YgvjokCcqsPW9bC6kkRopQ
 fdAF4ct38SKRddfjWhQPQhOHbJhvSAAYD7O6Pw3/mJZFh32PA5UvsgGAUwbXrfl3CXeGd+8iqfy
 x4zhw9aQ1nVyWNs5rPqw==
X-Received: by 2002:a17:903:b06:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b5f9f2bd43mr3312585ad.23.1776381535592; 
 Thu, 16 Apr 2026 16:18:55 -0700 (PDT)
X-Received: by 2002:a17:903:b06:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b5f9f2bd43mr3312505ad.23.1776381535150; 
 Thu, 16 Apr 2026 16:18:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa59dda1sm800485ad.58.2026.04.16.16.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:18:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] MAINTAINERS: update address
Date: Thu, 16 Apr 2026 16:18:23 -0700
Message-ID: <20260416231824.349872-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fNWuyHrcajWmCYgYEgVCEBdWHI4kLy65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMSBTYWx0ZWRfX+k/2/4ONzaz4
 w6HN2xRR9MO+qUc4Ox0mrRG/ijgyVHp5wE+228l1L11RGh2hhS4JLLVLrd1+rBLtDRW3eRLVOf6
 iefhjCk/n2NgwS8vOJtw9+Ro5s/z64L2t5DIXtvFvdBcyiTILkLIMiEyWoYGWNtIcm02KdNJ+p6
 //kCFt7KuCXF5t94WCMGPgVSw74rI+7I5n9EmmTvZYSEz0DeapIO6rrVCJjGp1QmT4YPSmh01oY
 aKqyC9e1vDNdXprlUuoX44JI6UyFpwKeErGCdd0I9Tf0RnABvHbDvP5Eyr+iTigRBi9G5JjRFNE
 MUu8PpkaAXPVCwYZaR04qed7WC6ML1vd8+bp699QQlCSE62V+15QUPM7jDV/DABzr01d3d+1k9o
 +VDuvdXj0i3I4SlzUKYJZrmnMhWLh6N9uqHfWEvTiZJ8u/szAAeLVuC0FuXWFkT1Ca1KFC9iXq/
 gn2t7Wa3kIJTh+e0e1A==
X-Authority-Analysis: v=2.4 cv=H47rBeYi c=1 sm=1 tr=0 ts=69e16e60 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=KKAkSRfTAAAA:8 a=cplnpDx6AAAA:8 a=dGsWvjqBAAAA:8 a=pGLkceISAAAA:8
 a=SqMvC5kiAAAA:8 a=FyogFE7hAAAA:8 a=Ixn1CAxRAAAA:8 a=20KFwNOVAAAA:8
 a=ciZXtekWAAAA:8 a=lB0dNpNiAAAA:8 a=-c9VzbpeAAAA:8 a=0FD05c-RAAAA:8
 a=TMBx9dqlAAAA:8 a=QktKnYkmAAAA:8 a=uYLkEQlkUP3FWBz33VgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
 a=bHwCOBSOUrNypjIvOSWD:22 a=EwAE0RQWx3bH85eTCWcH:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
 a=p2WyBLmlf5vdw_nX_QRo:22 a=_0vDLAJOulx5KDpLVjVP:22 a=GnyklBnmId1nB8FO2ck3:22
 a=c-ZiYqmG3AbHTdtsH08C:22 a=WAq88MDkwfy8HpmZFCM0:22 a=l1rpMCqCXRGZwUSuRcM3:22
 a=hD-SeztmQn9HBm-AZg8e:22 a=XkBopB_elf-j1KJO54R-:22
X-Proofpoint-ORIG-GUID: fNWuyHrcajWmCYgYEgVCEBdWHI4kLy65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260416231455.346504-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++----
 .mailmap    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84..14bd822ddbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2038,7 +2038,7 @@ F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 
 TargetInfo API
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
@@ -4075,7 +4075,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
-R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
@@ -4094,7 +4094,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
@@ -4556,7 +4556,7 @@ L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 General Documentation
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
diff --git a/.mailmap b/.mailmap
index 383948400a2..ce569d83f4a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -107,6 +107,7 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-- 
2.47.3


