Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B1FED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMSf-0001CO-Or; Fri, 24 Apr 2026 15:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSd-0001Bg-Ep
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSb-0007dB-QF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGur9c084649
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=54HUJ8UTeGm
 Zz6IAB8pdJRmD2gc8N0BiMJdRUFBLNSk=; b=Z3jhaWu8QvXyNiBlfYfo8hOAB+C
 T8OmBMoNcGzg4d5A7SlMA9ak76WVWBYD+Sys6TfPHSBqhJieVEeLLf08720Iz81O
 Q3phxef/u50qj6ef4GtZfPm61nuwYVfvLhvsZzj5yxXQR7djjHiuAfCXAabv/8hb
 J4xgP5XTVBPcl0N3H84bdKtSyOY12o9mAVFMTG+qZrYFX32ki0P15y6Kpql9sUUV
 /OzPwf8nxjk0PvFPljBJBcLh4fSEYb0EqdIJck/XM2VxsTvAzpKqm7zxyvJbdVLy
 Jdc9nw0TdFU3sb0lFl335jsXEkbh5CbMX/T5YSVZN4xTVv1b6menRKmrngA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5rvm0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-126e8ee6227so7978552c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777059903; x=1777664703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54HUJ8UTeGmZz6IAB8pdJRmD2gc8N0BiMJdRUFBLNSk=;
 b=foW+LW156S0pk72UnqnGwsFmQOIlLcy2cVjK/9qdWczBkcQBKhe347mRDQsZ+Adt07
 EV3G+oAGx47abtXvSBDLCDNSOzbKO5pBhYV4HVRyXf56WMAZGV5hAN7SSASqa2ezdgKU
 2xIeK3I4GJbOW2onpa4dio3+NS8aNdnCAQ3ryAbx0bJaWhq5wuC3WWu6Mk6L7FfXNh2b
 SiuB3Agcx05BaBUXAE7jYfjMjVabzrCKjCszRXa9U0lQeh4dXcL507YsY77rSMtSG5QH
 Oc6T80mS5lS6c1m9FDDZyZkCL55Xq3VDFRXeRL1PCHsAzjwt0b5klwYFEa0XFcnTgZie
 RY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777059903; x=1777664703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54HUJ8UTeGmZz6IAB8pdJRmD2gc8N0BiMJdRUFBLNSk=;
 b=s40bvVGFiKF38irbOiqs89SXAYvMfjSSXobFriFp4/XeCZ8U6aqD/iYsl5ntFN5rjW
 fukJJ4/l7Xzl6cI9s+K7N0YL01R3iNsCQ16bPiU9wkJjgXJIsC4G9FrVHXpVJ+c/b5S4
 lheLSY3ZSrUn4Jqq1JFQSMM8Zd3UZHAEqJuy+ggL5/DSA3663OJAz3rJscTz1nyPLiOe
 bHKOIZ7GM2x6v9Y/XB5jQMSW7md5zOVfLSLL75MY+/WuygLKfc4UjPTCLE6r4k4nGxA4
 8IZSLZCo57EGTjwvcypsmmgiEwuwjJGl5ioye7MV4qWiZr+NBUNsgZbPOFZ7NZoGak72
 5j8g==
X-Gm-Message-State: AOJu0YwPceBFO3CFUxQrOr1riXCZEA6fcRBcsLzIATg7/x/MxuZ1FmGU
 D3DMj49rJLoh1WxCBkCwu/8cna/whQD8hxARkEMpz6m8NMVoOhzZq2w5RsWjEawCdQ2FneVAIY7
 yJ1krKSgW9LjhweHz31IeZqAcxDP2Qvq2ZRA8PVeKZL5w6BQEh/EGBNk2rFZMM0ewPq++
X-Gm-Gg: AeBDievwKselVCx31DAuw5b5WxeZstbDgfAXxqky/zRUr2yFVx6fd3BqQBXJAElgVjR
 AIc+c3cuxjVHOUxOhB0C3TEK84OTYAbFwVgTLq+pjEkvROsdrb1p5VdRkL+jvubGARA+N50t9fj
 UFEUjurKh4hdiKP6JzgDuByBJRLhoob59pbowkhSHzTOQyLY9MPIKuUpZqXBPPKLGytueU4xg51
 CW0j2X8d3pUIA4kGxin03CgIQwV+tmOWlfZnQ5kDJTaFSjTSQ+P1Oc731k9oDtV+w+mIMJD3+xN
 1YH/m2oSmBrVfqP2BXmOWuITYnTYlT/0GfjN4O8OQDeI0QqPaYnnIYFPw3Oaol5++awh3q+AfdT
 IkArdK4yUDG9MzFF+OcJdmi6W0bvETU028EKH68VYR9qWbFk/FTdWRLRSbvv3AVr/kS1ZQbPxHX
 S5fxCIlwznHYEjedCX
X-Received: by 2002:a05:7022:6b99:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12c73f9fb84mr18387172c88.30.1777059902573; 
 Fri, 24 Apr 2026 12:45:02 -0700 (PDT)
X-Received: by 2002:a05:7022:6b99:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12c73f9fb84mr18387149c88.30.1777059902024; 
 Fri, 24 Apr 2026 12:45:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbe78e12fsm11385660c88.15.2026.04.24.12.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:45:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 2/2] contrib/plugins/uftrace_symbols.py: handle missing
 source line from addr2line
Date: Fri, 24 Apr 2026 12:44:50 -0700
Message-ID: <20260424194451.1439316-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69ebc83f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=piHZDCMnzvVDxLRhvVgA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZSQPP_t3wsLGzVhFrpWPZgzGagITVI-t
X-Proofpoint-GUID: ZSQPP_t3wsLGzVhFrpWPZgzGagITVI-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MiBTYWx0ZWRfX+/4QD3/IOuG6
 K5VUm285eXl6V51NiurBGVnBmT1TmvXmNzOhnqQl/M3gWQVM92q04xG+RLsCoA7N7au27+bWR4V
 olcR3HVt3GZK0xyfutfFLXAo9w7ZkhALIPJH4u0VAlookydHCogfd5wca3MPHrLnPMb8huQFTRB
 qneeLsY40i4cl3FAhsr4JBjhuNhorU9k9dWwxPr2em9SON+yZI2KiaeiXTnzR5KhwDAUOydVZHJ
 +Lyqi1LtLgQ8ncwhGVdC2GASP2Hx1ffEL4LkFTCecjZPN5NcqbrNTO4eFyhSWiGTJW6njmRDkgq
 8VA2XGLi+AZAukW8b7OkXY8kzybfQ1OB25TrvPO4QcIHtrzuG2Ev4NYR4FrNoeNNT2JqdLx8jPT
 +qmeMKVaiIlPUTDWYhR01/MzpkVfsEsgg6O4Vl96Wo8CHJABI8AjNy97p1okXoMv/xE6K/ddlYV
 72shGWaRYQV6g8uww3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240192
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

Some symbols have only a file information, and no line information. In
this case, addr2line reports '?'. Replace with 0 to guarantee consistent
data for consumers.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 6eb999bca5f..9f0095e73b9 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -70,7 +70,10 @@ def find_symbols_locations(elf_file, symbols):
         file, line = out[i].split(':')
         # addr2line may return 'line (discriminator [0-9]+)' sometimes,
         # remove this to keep only line number.
-        line = line.split(' ')[0]
+        if line == '?':
+            line = 0
+        else:
+            line = int(line.split(' ')[0])
         s.set_loc(file, line)
 
 class BinaryFile:
-- 
2.43.0


