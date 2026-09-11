Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82C1C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526W-0006hH-7Y; Fri, 11 Sep 2026 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5261-0006eI-Qy
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:19:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x525z-00046e-UX
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:19:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCjEct4141208
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 14:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=4Aeh2ENd1LF
 Uy0A2dHUUf/yifa66pMvI7L4Dq0uj56U=; b=pv2nkM9zxLFfnrydxaLZKPA36Tg
 V7xpJmJfI0tjyH1TJZnMqKld5vl5L2BxNZzvGjIWroqWnu3/tB9Qzl4qPPrqABSM
 xDxbL8rJOTfGv9n3P0/Uge8637j/lqtSHgxXcBG5njW3qSm9hEuwLAYP2PV8hHqp
 Io3imVzOSPC4zjvl6SKNNPCppQgLOWRrpdH2RrX+cNIIJ3gbshMsrnbzgsVRQuQg
 E68NQizLOOg1p2/+TlHmwbVo72HuVeJ3Mq6lUUDC+fgxHmr+VVM6ioZJycBvTdmk
 IAulxBmxoP+f96c2aJeEVp4+E0330sQurKPq595/BIydAvm+x/IeWSjYzsQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdra4vb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 14:19:13 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7ffe94da829so1511830a34.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789136353; x=1789741153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Aeh2ENd1LFUy0A2dHUUf/yifa66pMvI7L4Dq0uj56U=;
 b=ZFFeYDxkUVf61vSTPiVaWRHzkrBeosdCU2cLmx7HwDNsiE2xkpHYAWfyYXaq46lpBG
 eg8a9pt0XPpudgM1nXeHzghpLugAcuDml9ypbRJjTJkygDzrWWTwnU7OGzpmle50d1hN
 Brf5HBXTCUdiXqkEe+RmssbWXY3H16lU6hVuSUXZtAmwz2sTOeARB4tbL02aGCnMQ1TD
 HsMCfdlZ3fGRQjtCLjCNXy844Toz49tHl5ZxLFXcJfkeJkfjv/zkpejZefVOyObtcteV
 2jhKZWfkj3UGwAQTdgcelfRbS2DIZ6zjp6LnzU9bK/ScLdd8rz5NS87J9ynl9u3Jef50
 8/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136353; x=1789741153;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Aeh2ENd1LFUy0A2dHUUf/yifa66pMvI7L4Dq0uj56U=;
 b=WW06G8MkgEuVjg9GOtmWlqYzyBPhe4bkVzpkX0UFKQkAuXbpzzeAzcHUbF+/OYnrQ+
 xc/EdnocrVmTW0cccqRSJ+RFAF3okvyEbg8+dExz9WLt2jfSf+c38znsdZln54ziGs0Y
 /XPmWeT8HJGXQ8Qw/GRiypd3nPpEpLLs2oAupty2biFOyZA6CohXZr+nyWaQi5El2NoH
 l5f44+7hm9NzbpeItd8VDFTneIdQEALtriKG0PQIS4NljTIUoGrubm1QP3y3z2/LaoLF
 lMrAS5iT4ATEM2DO6xHrSeZhDv2x9oxdjzWPtNOxCfnDMFOYMD8FaYZpwu9P5woIhwQh
 Zv6g==
X-Gm-Message-State: AFuF++kqwuOEnC7zP8OwMd8TN+oDLBTh0c54F5f+CSyYKXuJREJv+Fb2
 +S5Mhw1oKVqCxrUUkQIv0uSvr2yd4bchFDVw+PtJMQPl1j8YeMhlzwC4FAAG43wrO653oyXPzi2
 RrdoYJ+ihtQ9r7kMjYaZWHwSI92B2+CJqY8krgW2xVUfMAUgK4pKzJyX1MG5pe/0zeQ==
X-Gm-Gg: AYBFou0B7P7JBM4gg259HlROilIWK0GS4Wf7LNCcef08Zka2hedHtLaLQLl3e5A+ZYM
 mvJUDUEqFqwtizEHwnve0tChtJVhKQT7YcB/dYO6Sse6ksA9WYK+dPhu7dDyev0qfp+uaQ9jdBN
 7Q2fV+3YlSnAK2DSXxL4YkZbNK+2/rE5fsoEI7fomEjMjsEYyzJZ8wxrjU5tHyyef87Z0bqoxDo
 kR8cMDH5Ecf3zpgz6Fp/AZy/PMiigEwbFkELs3G9eOzNeKXV6LPGWyAOgTtla6pPwdoP21c9779
 DTWZBzAcWctUdxFyHDake+sOGoUDOeNDX6ld2GCTIcvvTIrxdmaPJNdNezpnAhjeCKj4w6hYOKt
 BqbQizSdl9HOmswwijk11J41CUXM/69+VIBwoZi8qgY8zHTWD
X-Received: by 2002:a05:6830:3817:b0:7fc:fbf4:7b22 with SMTP id
 46e09a7af769-8027b140d88mr5614302a34.14.1789136350734; 
 Fri, 11 Sep 2026 07:19:10 -0700 (PDT)
X-Received: by 2002:a05:6830:3817:b0:7fc:fbf4:7b22 with SMTP id
 46e09a7af769-8027b140d88mr5614284a34.14.1789136350338; 
 Fri, 11 Sep 2026 07:19:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f6d2c072sm2644755a34.26.2026.09.11.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:19:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 marcandre.lureau@redhat.com, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] hw/display: Guard new_blob to fix Wunused-function
Date: Fri, 11 Sep 2026 07:19:06 -0700
Message-Id: <20260911141906.736052-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Aksr0aiAuCXISx7WSp_SM_BgOmRFeflM
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa40de1 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sbH21Evi0Ti0QKz8ZO4A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: Aksr0aiAuCXISx7WSp_SM_BgOmRFeflM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfXzWBlhQNf5c+f
 wvIbx6LTYcBWMa/tev35jGEwfrwQl1gS5e8E0YUzMT4sxTf9UyqffcieKOgwGWl+6T1DLrWyBpV
 TV7Je8n2KLBVUN2QnYZH3AzM5rbUkcQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX2o1quOdNTiyu
 tryZJ4FBpau1PJ/VOTDoti8p3Xp42uZlxrBiNCSuo2nGlcA/CoeFgEAITylRNOTs9BkDFdzGrdE
 x1xS4iTtf58Y/5/j1bREIFfMC73Agqa9K6RhNIZN+viJqFFb9cQ94+v4IZsxm0QDlR//WwaqaSq
 38zDKFYV1/sKOKF6i58q3xkSvVkObtALIPETLGbuSWDj0KgXX/BVB3PrjY51dw6b+ibMaD17iwc
 9K8ChwCoKXWDVtQOJ0iFUoP6dBwqqnxNgDB/J1xAYOE3bW/y2WCg89Ah8srylSmDCjjZpQPch++
 /YAgjFPhO7TqKT6o8ejiXoKYbh4NBKZpaTWiNxRZp6WBlcgkgeJb+cpKk1IToy3nPFS6M87zoh8
 XRAuuBz6GA84W00XcJrxsizsuaoZ4MXbg4Vp5qHWrIy2WmwcIxn80PP24UP6Cq2gzt4608IfYAH
 9padiQDa5fDT8w/XvOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGNhbGwgdG8gdmlydGlvX2dwdV92aXJnbF9yZXNvdXJjZV9uZXdfYmxvYigpIHNob3VsZCBi
ZSBndWFyZGVkIGxpa2UKdGhlIChzb2xlKSBjYWxsZXIgaXMsIHRvIGF2b2lkIC1XdW51c2VkLWZ1
bmN0aW9uLgoKICAgICAgICAuLi9ody9kaXNwbGF5L3ZpcnRpby1ncHUtdmlyZ2wuYzozMjg6MTog
ZXJyb3I6IOKAmHZpcnRpb19ncHVfdmlyZ2xfcmVzb3VyY2VfbmV3X2Jsb2LigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQogICAgICAzMjggfCB2aXJ0aW9f
Z3B1X3ZpcmdsX3Jlc291cmNlX25ld19ibG9iKHVpbnQzMl90IHJlc291cmNlX2lkLCB1aW50NjRf
dCBibG9iX3NpemUpCiAgICAgICAgICB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBody9kaXNwbGF5L3ZpcnRpby1ncHUtdmlyZ2wuYyB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody9kaXNwbGF5L3ZpcnRpby1ncHUt
dmlyZ2wuYyBiL2h3L2Rpc3BsYXkvdmlydGlvLWdwdS12aXJnbC5jCmluZGV4IDFjOTM4MGUyYTZk
Li5mNDU1NzEwNjBmZSAxMDA2NDQKLS0tIGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LXZpcmdsLmMK
KysrIGIvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LXZpcmdsLmMKQEAgLTMyNCw2ICszMjQsNyBAQCB2
aXJ0aW9fZ3B1X3ZpcmdsX3Jlc291cmNlX25ldyh1aW50MzJfdCByZXNvdXJjZV9pZCwgdWludDMy
X3Qgd2lkdGgsCiAgICAgcmV0dXJuIHJlczsKIH0KIAorI2lmIFZJUkdMX1ZFUlNJT05fTUFKT1Ig
Pj0gMQogc3RhdGljIHN0cnVjdCB2aXJ0aW9fZ3B1X3ZpcmdsX3Jlc291cmNlICoKIHZpcnRpb19n
cHVfdmlyZ2xfcmVzb3VyY2VfbmV3X2Jsb2IodWludDMyX3QgcmVzb3VyY2VfaWQsIHVpbnQ2NF90
IGJsb2Jfc2l6ZSkKIHsKQEAgLTMzNSw2ICszMzYsNyBAQCB2aXJ0aW9fZ3B1X3ZpcmdsX3Jlc291
cmNlX25ld19ibG9iKHVpbnQzMl90IHJlc291cmNlX2lkLCB1aW50NjRfdCBibG9iX3NpemUpCiAK
ICAgICByZXR1cm4gcmVzOwogfQorI2VuZGlmCiAKIHN0YXRpYyB2b2lkIHZpcmdsX2NtZF9jcmVh
dGVfcmVzb3VyY2VfMmQoVmlydElPR1BVICpnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2dwdV9jdHJsX2NvbW1hbmQgKmNtZCkKLS0gCjIu
MzQuMQoK

