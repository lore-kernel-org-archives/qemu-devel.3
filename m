Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9E-0003Ss-40; Fri, 26 Jun 2026 19:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9A-0003Qf-QJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG97-00040O-Kf
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxhHH2099587
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1D9F0cWfuHg
 6rzDmCItN7unesvXI6SEuxck8o49D++Y=; b=o2HgsHao8aRi83TJGzFv/msKyh8
 0GqLgKRuewKN/rBSpA/siFBvIOOSodLXMt8HM+kVbyM2Es9UItcrYOdgIJiFnkVS
 qaryBhccRCQDnWlFJFh3zLel6YR5rOeGGuF+KgjTJltuyuDAQj8b1V6Y6XV+/75W
 XahHR7oKYIqAKhVHvzpVBGQ0D9sUCh4A6aYcwFP0kDBdf5nv0/6fOtJkQpY13BN5
 RcSKRtYjHORX8GeLqUPjDD3FYK7r7dz9WlZnBNmrbGTx43GuEot0J3FZ3TzvbPUj
 /ailBHCU5Alxmj4iJ+SvXVx5fgXwPI2/nmEyT6/B+9VNBs8LG9poHq//8eQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xxvgtjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so6487467eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517176; x=1783121976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1D9F0cWfuHg6rzDmCItN7unesvXI6SEuxck8o49D++Y=;
 b=i0xfAoTaMAlDV/0GCBz2dz0Rs9yYIQgH/0A8C64Mu+J7qmgbOyaAZjGGrnQlh+97WR
 s3O7dZzAe2g4EMMHr6DlfmjnqTNpzP9l90PBtVcWorv4IUFAxYiZ2e0FgMbUVj8y8e7V
 T3Qc6HnGt6Wa9KzADsET+nAb6mr0EoYUJbBPuFNtte+/mOigAbOdc15kHzYtyGfqJL7X
 CEBaxPlosvBqFDVNzkqD3V1ZpIONpMnE8Ng7nGgX61UenEQ9eEO3TWTGxvxxcp/FN6yS
 YuxfYbg9bxqNXEzZXsYJHzt+JSwXmKRfEdG7RkzemxX2L3T6GzoS77EfeLzCGKovzpEp
 NPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517176; x=1783121976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1D9F0cWfuHg6rzDmCItN7unesvXI6SEuxck8o49D++Y=;
 b=HSisKbj0UnRmk3ISN0u2uiTAssStvvOk8mO5AdJR0JMiM6vhEaONNJGPFg9Lb1f5xv
 GeKAF57PJRA0jtHYZXdbeqOgnFP7dbX9ALEkszdy87iPx/OM1n5DcPKyqIpkUsp31K4O
 MnIN9XOD4Po0IcWJZm+ZR7bkR7vjKxHRau8fRgh04OamqkAz0F0wXjXmFUmGgH1hHFnf
 kH4TVJkWYVi7gqpw/L4Ru4JUX7a3ojLHtW3RYUhXOreBV6IeoruX6zIHeb0NlEWWR6hL
 2EAAeNgwTe9VPh1zg1OWe/Cz3syRs3Gms86V0/kqa5Gy2c67CX1RjQ9rVu00o9LZTwKF
 8f5g==
X-Gm-Message-State: AOJu0YyYYfGSnoePyXN8e9RpzedHvQ2J5pnTw9qrgNdoMKcqTmUnr+AG
 ou/kJa6HD1eRE6geoUnvvir2/S6yn7bk35EFLCM+beAJyIpm1xYDnETvr6n+yHq82ZD8Tt/c2WM
 yodfFNGlER06avjEc8YcZ7CF6pLlHpDhX/cUKPhb3Z/rrbJ8Jdq/OrorIGVjfYBocLA==
X-Gm-Gg: AfdE7cmR4dfXKk7srp6wWisa1frPrqWWZSjDryQBBwFOftPD9erwGkHvGCozcSFjSWn
 4BUoX2gmFuZ62OhiE+wlqgl5eVPCWHK2EsenV21FHNQJJwHgxcvBL6J5J6rY+hMBP/xn4qJWOLn
 i+cScNdLIltyl2wP43ub8QkSZEtK/KIagrDNrGwWLWmB9WDbFHyajDLgLbH3aC3xu1o3BXVEy2o
 NPDAd2udECPzTYs6hrwLBEe7drL9NJGW97LvAOQPTv6PjdJYqMtLAnWzx1gICp7cSnIW5tI5WOA
 bBSVpnR3tgc5ykqSW1y4Kvsgf8xyXiBarxY+aZVvtuUKlHSgJWci36kzhYiz2m6ofvz7iGtBVdb
 vuNWuW77CjkYJTB/lzNNGeb5X1rclDJNQPBZjlN9+SaMJcmYZynfXJrcyfbYUvfLApfcCpekXQs
 wyvWPloA==
X-Received: by 2002:a05:7301:60b:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-30c84e270b3mr8228933eec.32.1782517175513; 
 Fri, 26 Jun 2026 16:39:35 -0700 (PDT)
X-Received: by 2002:a05:7301:60b:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-30c84e270b3mr8228900eec.32.1782517174963; 
 Fri, 26 Jun 2026 16:39:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 09/37] tests/tcg/meson.build: introduce env_var
Date: Fri, 26 Jun 2026 16:38:50 -0700
Message-ID: <20260626233918.158740-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WxG2nFTQDFYd6BVOlciGCK_1gJu8Iujr
X-Proofpoint-GUID: WxG2nFTQDFYd6BVOlciGCK_1gJu8Iujr
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a3f0db8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX+X/9icuFW0nQ
 MSb+Am3HC1axCW4twH9KdvFseC60HjOuTjm+pbt0OoRsDKnwwGSyCBOTcvVKZ8aEDXezRmWf/pb
 IE0nkiT9GpUm7Z0igaCkoYPtkuKSPUsSls9dt+Hxt5WDNOdtWkO7imzwwImKnE7k7bSRofSYowh
 xS5ZlEq6CFL2fG6Aj7gR9tSh2ELlGe1E8bm3iSZbiS3V6agBt9aH/ceMLwnc8UFmIrgoonm6Mnp
 EOMjYLxA0DhYdVOdcupZOWKmz64B8k1a6yh57EpzI4+FGd5hnvPILEE0wfZ3+W2pidPvx2O/hvs
 tIZa4JNPcKwOcsbl4G9R5vof0d00PfFUTi1nASO1Pk26mKQef9EvDILIirqv3BpdnzMq8Vy+esi
 k6lszXT54r1OGLkb6+ic/Fpahk/k6066WIeLs007EDdZcgtSEy7DbF9B7ZrzD/1DY+WMl6J8mxG
 Upoh+G2DLQytl/HqlSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXyMKwHxTpLTRj
 G5C8gf3XmZ8RS7PVTi7miY06hKgQQ5WtQ6LOfNiR1bSV/i1mav/aYamyTDMLZHXSvKHh9CrH1Lg
 ztYHxTwB3B1uG4yq2v3inFbqouWvwVo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d1a5bf3deab..c7830d2c17b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


