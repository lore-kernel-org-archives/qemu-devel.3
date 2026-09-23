Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3327C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SA6-00016G-2S; Wed, 23 Sep 2026 14:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SA1-00015M-CQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9z-0003YT-QG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTwDe3665925
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cEHdBSPicj8
 2wJE0dJMVUeI54oHu8lauzuULAdotmCo=; b=QXYKWpHJFaLHxJg+x4vMeWO6Jyi
 Qf0kbsFSJNNJROOLt32GOKN8FQDKYokqpwGlEIjec2VSj4wIOFaX+UCD7OKwfE7T
 bizhtttAuRTsIXI7OQxKzKqPtvoEz3UhvXVTmDKa2fZqcAfXKXUXZ2Wbqi2CQN9F
 te7eq1hpQ4/rec73pqM2zG/isUShGeVtBytlw+OZebZySrF1F0oWoIBitLlrdjd6
 yyhSMl2du/u2SOTwHXt3MNmVecn5NMagFmi5lg0JKWjM/c1tNmAlMe0GRPLcIvUN
 NmJCzUTQ1ixXSo9bVoifYBlUX81h3JlcI74zpVGP4BW1jbSpYkjuYSZzI5A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwatfxq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so1876939eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189858; x=1790794658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEHdBSPicj82wJE0dJMVUeI54oHu8lauzuULAdotmCo=;
 b=jmfWgOYpSIZvkXrFjPPixu1D7Mqw3Q25aE+sAQ/wk1qGVr7f5mAedEpiJRaup6UgTm
 ayXWB3LX6Mo+iTeGyzAanE0gDhaqETyHYib+DZFr1OaJFFZwf7S1L8g91Z/JGwqC2Lh2
 mi24aNEkL5gNqMcxtO1O9HtV16wKTtqLyAGlKMc6t9Lxvi9mW2U2RZTJoME0MDMejHog
 zC15iBNMefeFXXH4WqOQHfbzLb32j0aeJRK4P/hdD/DDrORnBSOMTRj+NCXWzmsDzYXc
 DfFR6NFP/u+/iWgFqglB91ZU1oPLpka4aYiIYWcM9m3Z1xS3D8zIH7Vy/vElvhXzOD4K
 DutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189858; x=1790794658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEHdBSPicj82wJE0dJMVUeI54oHu8lauzuULAdotmCo=;
 b=CEqqvJA8M0KXtvGGCkQopRFsLpw9IC78MnBky8w3ATSAKiGXgLtwlQms+RvMwnlcWR
 rDFSw8tjoOa/Ub4Y406NnosZjSZTSD6ArLc2pJ9NObRO97rjmKIXOfTMk3/BKo6Zzkr/
 bnJY0u+B+wSE9jbwfwiab0mgellxm0YLPIUtzavOiC6rfBKm71qhkzv5uDP8tYGx/fLc
 1W4WYzMLcka7CMAiGApyOcz58OxBz8a7xnR9dCSIrwmG5m3yq0hPVcJw9+nPNUnW/uf5
 edyHEnHPJdSurGnORsjrVl5zl4sG/BeSN3WsQcae20OQE9dsutPtcm+zvnk+HTd+cudv
 9few==
X-Gm-Message-State: AFuF++kLIFwi2Jt1QgBJsFvWgm+8gdPGAW2v5i/N7loEzthrYULhT2/Q
 5QLgJSM8Y+k0C2a1oV1u1z/ksexZr//8QWmleYqOiBftmeWRNYP45o5k/Jw+IvwBxMePPWwi3Ni
 7KC0Bn+MgnFanSLLlP11sMdowhjy3knPxujMZXZ3iyey0X/qJV0vsKeQyPkd3cHMWJg==
X-Gm-Gg: AYBFou26sbgYKbP5A9QqM9HV6Usv7RuMR1qYTekhndSPU3tcemOxUY2MIKHNRiwlk36
 a0aCQrFaDhDxZul1VVWrT7jTBlWhjN8SuaIwfH9U5ooOWFdR3GcPPsLQQV6mdgceyzCmbpg+GD0
 eIrOZ1TCCom8qrViPANSfQ7yyolv8jp4OOuRmh8n0zvsvTTeohn8j5vJ2CxXnkwTCYYjvGFpsSt
 EWxIP//nNPZS3Q1+f1PhoJVp83L3bnRKx3bXrypySPgcAz7qLuc3JxAKYOPFu7PZVUZ63cUmTVw
 v5cLFyXsEyY2n4nTFmi4w+Oi/0Edenm1QSJmJC28gUC41ud93x5Yxr/70X2bxyaAjlqrpBE8s/u
 XOnJ0PbF6tKm0cih6QG27q/XzYeySXz6kFMkgoTxHnh/t3OziEXDYUIfWcA==
X-Received: by 2002:a05:701b:458e:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-14503e31631mr89300c88.0.1790189857526; 
 Wed, 23 Sep 2026 11:57:37 -0700 (PDT)
X-Received: by 2002:a05:701b:458e:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-14503e31631mr89287c88.0.1790189856893; 
 Wed, 23 Sep 2026 11:57:36 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 5/6] tests/tcg/loongarch64/system: deactivate
 loongarch64-softmmu-memory (hang on aarch64 host)
Date: Wed, 23 Sep 2026 11:57:24 -0700
Message-ID: <20260923185725.863311-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX9TDXvpexq3K5
 2fXodOH4LXgIbfryaub7IUqhXeL4eGsThvKmch4wE0pS9te/VAlyOv+tpjcoGDAwtN1qvUKjZxy
 VD+lpB7RQNA/FtWZNmaUiB/V7XNCo7ZO2Y5wxhlzldxrv2ze+7fIAP8iY3dpSJyp/BhWR+6dF9V
 p0ldj4H03a6g7yUddzG0l4qv3GYBVSnc3hKcbu3rtulqb4f2nDTTv73YlwS3SjU+foALeon2S5K
 YSZ/j1vWWgMHD3L881Z4EpMTYR5uOiKZqoY8eZy4wxHwp5tMKkPDMGmiE/5h7NlIodYG8LlX9TC
 VYm5bdZnUmMP+u4eJkm9Tc/Q6kGRM2isgs51AHdfu37bQ8XENVor/Nnqclqf/tKa36+YeWqjvgr
 2NPDkp0FZVY3G40D05HXngmJzM72EtIgAAAQhP9XpmqsjJdZNHv7/uCdQ7zfDRBj2aU26lCgxtl
 exa71IZkMNlflGKyvlQ==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab42122 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Tik54YSiwzO2kUiBZWMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 5p3EOMSgsWiaERYTz2ysliydwLvmvkln
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX8W7bRQRWFotP
 S9kiyje7YJ7n/TyIyJPemqU9vl8rrI3uxCVAXCNlvfN6ZMoT6z0DWszjHFTKxT5q2zpAyDPk0hO
 +6xa+CkCvN1nAOAJZdBRnV3tBr8S8V4=
X-Proofpoint-ORIG-GUID: 5p3EOMSgsWiaERYTz2ysliydwLvmvkln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

Created associated issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4567

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/system/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 035dd5f85fb..d1ee3986b62 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -24,6 +24,11 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
     new_cflags = cflags
     if fs.stem(src) == 'memory'
       new_cflags += '-DCHECK_UNALIGNED=0'
+      # TODO: memory test hangs on aarch64 host
+      # https://gitlab.com/qemu-project/qemu/-/work_items/4567
+      if host_machine.cpu_family() == 'aarch64' and 'gdb_test' in setup
+        continue
+      endif
     endif
     if src not in multi_src
       setup += {'cflags': [new_cflags]}
-- 
2.47.3


