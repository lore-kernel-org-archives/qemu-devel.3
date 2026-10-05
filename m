Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5987CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnru-0000SU-IX; Mon, 05 Oct 2026 14:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqd-0007dr-IM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqb-0005mL-Nu
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HuJqp2484333
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1mlewjgfSfDbYJg+3iqCY3mb5kLo++klDaJeDfoDVVs=; b=daYtozRrBQQ9YukJ
 JbJw69FsV2Ff0Kaib2Svxkc0OTM4A/NMVwoyqBhKyg3zV1+v07C+7NyIjrQ4mFSF
 J9mRqR/MuWy2I0f3Ih6DwaC2VqjWIaCbYdyJX+nZmErMM9sK1/03A38GkmYYndEd
 kjmB4YonyLGZ/Eszv8HLDAhLPvgGVliX+kyrwnJWWZbN+7GDpcV0OXVg5YKV4iZu
 pFO8R8f3LGq3ZhD3qY8csMpB20F2T9IoRHEAFySqZ0wFoVKEOYN9Uprb7TblOPuJ
 nAQpNgdd4928GCY8E0JuYNkr1R1c514Q7EyH9XtT7VpWlGinYoeCYSyIGWu0E/Te
 3+rSVg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr087pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so4557934eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226526; x=1791831326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1mlewjgfSfDbYJg+3iqCY3mb5kLo++klDaJeDfoDVVs=;
 b=TIT97P4w5xvemFB++s1Y16arTt4xRvkq+7IEmCMr8JfCClui2apw1r0n5I2VI5MWic
 5S0P+unE5oo+Gc2waUhqjY2Sevqo331pdvsPiMnJeWfaZbWtiFbzduP1TPi2YNN1leOm
 pxXlUrIchwn3wQAK0xRDiWTnuWGc/CVa/XMQipMljgFzVE/y2aPS9Bz0sLXEDzahBg+T
 +jf0xKUpkpDHG7l4kIy00ZTU9TTj5WvY327ax+2p3JCsgVL/ihkQhFjchAkBVBr/fUUk
 mcOl5cJAuzrwo0dngsuRnDuviK05H/0CupTzGdmOgLQt1gr012zZZC2HYjs8VSg+6qIv
 sk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226526; x=1791831326;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1mlewjgfSfDbYJg+3iqCY3mb5kLo++klDaJeDfoDVVs=;
 b=QbUBKq1quEN4CDyog+A5hgEUAlKOl4l879+2zp1Ihc4dh7UfqMqstGt87lSd0qtCyU
 pf5Uar8qcw5WorpqyZeq/AVH4+LN6e3nYD4QV+p2mxMfWF6oEKFlhq2aRV3e87Fd0leV
 Dx3vNSKmyeg+mgzKT7edsjsep4sKd0JCmOYQpHhM7j+DH1fo1MwUidXAi7ElUVrBnBTk
 xjokHQjCtem1NDeXCHGadGFrR3BijpuGLcRgizmmzhoHV3F5EWwxY2PluacPvBhrB/1N
 RAdcreaD+M4QNvGD8p6rzKsYbBb/G11zOEHTs+KLUkgwT9868CQIEZu6IDCr0PFsqFpX
 H4vw==
X-Gm-Message-State: AFuF++nDEfCt9lxiU9E9+xZgRAZrmwSlDhUaeU6NQATPKYzXmR340Vwu
 gue1+FeGoU6ys9kJCApPjkFaEN21qvPHgtq3rTxI3MAf1RdOG7hWX8OaZQJRK/TwO4+K7jTgtYB
 BxfGq+5b+mc/3YdsgERJe7XxDUD/dn1BiS5rF77z9Y+w3uqz+AWWQ26uhdsMJY/bikg==
X-Gm-Gg: AYBFou3pbi5zTTFVXxdx9XYUS2deg4fiPSZLgxFNr5fQtGt1IF1ld6ZfwjQkT3OdCRE
 r2DxI30LkbgoUjFB87yC0GiXICesWSJmGOIoyQk21v3SFdDGztBokvtQczjFqh85u0bngXSRp4I
 MT3XFgM9Yedp3ppa1l0u7b6u48+v6Z9hUsHVB5kCILoeTXqqOrmvLfLzH7qs3dTBazK2qXYtz7+
 zdureyUYd0VOVOKb1RYIDXOP5E/vRbGSI4djS6haH9AGH2W/3UJR1Gf4ytJMQgpBvxguXRzmof1
 c+zZeUl/r80Di4H8cc5nKmMvqKUFu/aC2QVGZy3Ktk/KgIoCWbiKYpsVKv/+MiXkoYVahosW7R0
 m/jmfxDQotw5JWc855tSW1acSqX44eVsU7VWeVGA8AmzFVj33mqAMPsZGjFaS
X-Received: by 2002:a05:7022:2387:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-14f5c8df270mr22677405c88.32.1791226525750; 
 Mon, 05 Oct 2026 11:55:25 -0700 (PDT)
X-Received: by 2002:a05:7022:2387:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-14f5c8df270mr22677344c88.32.1791226524972; 
 Mon, 05 Oct 2026 11:55:24 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/22] meson.build: add avr-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:47 -0700
Message-ID: <20261005185458.405929-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzjAeMFKvGZEF
 r5//ZKqKlT1D6haF7oq5ZvqgPZ4tcahMO7e1BfeBkhlkk7qBiLlXnX58KIYfXav1PkOywfu/8SZ
 ZfS/l9VvK5yyMCEouKxxguG4Z6V06s4vGmVZcjUZ647NCmObt4ie3H6AZy1eXAkjI0PftXqNhT3
 Op0RA1X/gRE9d+F4s34vgRRi4t5DrNCTIryIW2Zy5G7BDuoilg5uJaMh0KeQiL82uVPbN3foIc6
 SCqLHtLIomLml43hVbSuo0XVCw7EWtt9DGljz9GFEYh+fWCQkqVL3SU/J6evjz8GTL69h8uK0BL
 Zz2awDpBH84v7hCSxvEKk5+4g4PlmhyGhOtrsRzhE0Qm+cj3hgY+PUPtgUT40DqBApiSSZjZlqv
 AqwuTfUSqfjtK5dWJNGxxfauo2AlrkvJeF0qAkRLgxSUNWyB1bJAyUWqHJHA5xEsgl980Lru6ws
 jEytNdkpkRE9psFOi6Q==
X-Proofpoint-GUID: -3ORSzdbSmL8DbbfAsMLt8XFIrnuDpCZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX3Z3rRdYlh8ax
 kP/7jDiC9bwiGHqZ8TOALZejsLWSAgaaZnZ3mWtO1ygUkwUrnZ5wlRlfeg+28oNEHxnbsxfe9F9
 B5sPtDATSmYklm+G52vUuHqMiT2SGvk=
X-Proofpoint-ORIG-GUID: -3ORSzdbSmL8DbbfAsMLt8XFIrnuDpCZ
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3f29e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-12-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 5515f731295..58425a93a93 100644
--- a/meson.build
+++ b/meson.build
@@ -4265,6 +4265,7 @@ multi_target_supported_targets = [
   'aarch64-softmmu',
   'alpha-softmmu',
   'arm-softmmu',
+  'avr-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
 ]
-- 
2.47.3


