Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B2CCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSl-0008Df-1C; Mon, 15 Jun 2026 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSj-0008BP-5x
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSh-0006kd-9O
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhM1x3139330
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c3o7l00HW44X2+IRTm5ghCF2Q8TSQ7V6jSW22ZW6cyo=; b=RxdANedqzc08n42H
 wRuS0WJjt+b3kiRypSFanynAVDPOirT3O0DoyTFawYZybwEFGx9McYXDhZl1Bpx0
 74y6zVIjluw/P/Dfh7wVLlqvhdgGgmVgvRNqx8xWH/oqTJbDGdBuLDIofPX9Q3vH
 6nHWUd7M2jfXzLJrBfFxKAEpibq9vycEFBpfkxhUTFIIKqr1GnklSHHTlSqkciLC
 8zkyr9pGhAXjY0Pp4shfMhoygZ9B/ZCvMqbOz2KFuLxbE3gg1DoOLR2+ljwWzwra
 b32O36H0SC4Fjj7M+QX1ANbNSEXAUBmxb8+qTSZuy08WKmmIGzh9GpOsZoHm/cKD
 ifPh3Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9829yv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307fe856724so2312841eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545861; x=1782150661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3o7l00HW44X2+IRTm5ghCF2Q8TSQ7V6jSW22ZW6cyo=;
 b=haZ6/hEfgYqzOotJ0L8PEX9QJYgXvdTHwOMGUbswyHd/X5yTIWTDZXNjdRzpaopcY7
 VODpLaK0x2MJqpYAjCXfxxgykUupMdo2t9Ucsn+gkrBO5GXGglcKFd9hiyBSC/j4g64+
 19EsKyrVY6bBhsiooMhJ5od3BUgSjzOAEH7INFg8dvG8LIdtsnKFlgv5XKOh9IA/lN1P
 n+kpgvyzg3HtmeD7dqxilVqWz2j4C7y4m6VRGvi9dE2Nawpca+hbW7vfA61Jkm+Kss7C
 vXC8W7wwtQTxldKTq3hU/XqL0C3vwZuEemBTn7A5lugRSlkYMJSBvwITk6KAHQhSOg61
 Mumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545861; x=1782150661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c3o7l00HW44X2+IRTm5ghCF2Q8TSQ7V6jSW22ZW6cyo=;
 b=O5rTJHFjaUxU0yh24Nq76DDnfUehJZ4E79aImavthDkqoHR8KAVujpm6hw8KMA+cpO
 e06nSFaZLIGOdzO4qEYov/MKvZ0SgijXrASuBEo1pFXHa3tT3P3gkMx+PQx8fmuKXmpr
 KZ5X79+teREgTcFPH+K+EsAEO6S26kdti4tQoRuF6P9CoYCulwiHOFx2hGRZj4ByVBB3
 GPCorkMe5J+lDwP5ID8nfkab4GNAN5PK3ZhccWgmRSx9AMBBjjZKa3Ul4dhqeFbI+lKe
 zXKjDn3MtTKOly8oLS8oy3zTNDDOIqYLMS86kcvWEC7h2WJUIVuNGtOcvfnwyhV4VBtp
 zQIw==
X-Gm-Message-State: AOJu0Yw02Dtkl5gy48ukTd5sMXfMlcqQ+yjB0jotqRuolMyG6nnGfoIl
 CPa5hrroxM2J4qgXKGGX+zioZ+cIt1E73ChXYG2wAkViy1Q+CORgff0t5yvJvMXZYS3xAxay2CR
 aRL9jfGeIe1VVtWJO/2hKF4H+mGT1YGypCAVkv1DxNLIQ7PZYl1tVRLM2D2+YLfWaob9i
X-Gm-Gg: Acq92OFCT8GeCdB6hqmzr4Oqy8IoHyTm6ZZzJRTdYeMOPSKFat/y7yag9c5vna024au
 Yd4Fp2Xejq9t/Ld56O93Z4KOe8RTRuwdahqUHFBEENT8ZHr+jCR/ImRS6Lq7YbBG4/eeOdFRHyd
 Chp55ZldLudj9t7YH4X2yBDy+Uf0wKtqLBZzKwc5qj/YcpfL0H6n+Uu/o1/B8zBV8pk43CPcZ4H
 cqvylvogN+9VS/ed4hnCTbXiQHI0gzxMRnl8zmrwF44acH1Nk5xv9NngnfessaDCoDzVhPeAHHE
 As5o4l3OzcQonxk/RUWVgdIILWcQ9CQAtUMDychtOrTClazfmhPky4YbO+2wfbLu2hDpCD1fEpP
 jfQTq2nLHaxkn78XstjLYSMfNHpruqvOfyI0+FAvhZX2u2dVd+W7ho0iWKLtyqq9UjNdG0NTKCD
 VVuVtwzQ==
X-Received: by 2002:a05:7300:e7a3:b0:304:d14b:b706 with SMTP id
 5a478bee46e88-30ba5f03865mr134661eec.27.1781545860543; 
 Mon, 15 Jun 2026 10:51:00 -0700 (PDT)
X-Received: by 2002:a05:7300:e7a3:b0:304:d14b:b706 with SMTP id
 5a478bee46e88-30ba5f03865mr134642eec.27.1781545860031; 
 Mon, 15 Jun 2026 10:51:00 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:50:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/5] net/af-xdp.c: maybe-uninitialized warning with gcov build
 on ubuntu2404
Date: Mon, 15 Jun 2026 10:50:48 -0700
Message-ID: <20260615175052.2751738-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a303b85 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dURgFwUa2F1EbzCuMrAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: epK9ZWLmj4_lmpzHp95hmDXrLcIWJOmO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfXxJW6CXZd24M8
 vEvN2dPD0AIgXZFBdd8YxtnqsPqhf4IZ/W41071G/x8SGkIN9g+O/bkIn8aoZkN7SQiMvP8ejq/
 +EDMyKK5dM/3kIMvXDhd49g/kA82R0o=
X-Proofpoint-ORIG-GUID: epK9ZWLmj4_lmpzHp95hmDXrLcIWJOmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX0Gtxj9W9b4pF
 lrWGLYWMv0paYgUiY9ULK4KFB3hPuXQ+cWSgJJE7JjivhLYBx/x5nUNX/yUZEjeBmZfA9hJYFXQ
 xCsKBiuLKWWo7hl7XoYddwND3t2+z+y0UcyU5/ZQsjxdAD/wpTfQJziBuI89rLRSy0LFteSMIEL
 Y3WGydimsWLqysb51ULYZ1CRn6t5ozs41skM1T7yUaLKsm9KfUdxGkTuktnoRdkDuUF2Oe1HVQw
 hyi6B5IEye3QD8OgWbbS/6niwiWVxrKk3NwTPq5TIYi29HFCyvfJToCBh+Rq73WkZHNLtiLCBRy
 NduWWhuJ6wkGRpZuqs8agbTZa2hLrs1g1waYfPba9k5OHDhrfFLI4isKN5AetouqOmGjP36YClz
 PSGzP91n3j/ShXUL8EerOM8hVAt63zxO4I+At/T7vVA6SFGkOFVPsi3MHeJnAcz40+INOQSCTSY
 7nII7VMYeQRbWWPKbFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
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

This is a false positive, fixed by explicitly initializing
variable to NULL. Variable is always initialized during the for loop
above, which is guaranteed to run since queues >= 1.
This is correctly detected for normal builds, but not for gcov builds.

In function ‘af_xdp_read_poll’,
    inlined from ‘net_init_af_xdp’ at ../net/af-xdp.c:546:5:
../net/af-xdp.c:78:10: error: ‘s’ may be used uninitialized [-Werror=maybe-uninitialized]
   78 |     if (s->read_poll != enable) {
      |         ~^~~~~~~~~~~
../net/af-xdp.c: In function ‘net_init_af_xdp’:
../net/af-xdp.c:461:17: note: ‘s’ was declared here
  461 |     AFXDPState *s;
      |

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 net/af-xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 1ffd6363a8c..72d75748c6d 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
     g_autofree int *sock_fds = NULL;
     int i, queues;
     Error *err = NULL;
-    AFXDPState *s;
+    AFXDPState *s = NULL;
     bool inhibit;
 
     ifindex = if_nametoindex(opts->ifname);
-- 
2.43.0


