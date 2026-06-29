Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC2C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIP-0004S3-NT; Mon, 29 Jun 2026 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHa-0003gy-CV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHY-0006G2-Pt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3FI2604339
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=; b=Zj5CUH70h7bBQdza
 uF0m6ljxcaRmoAN1q+3RPL3BGjKKINnWMSLydfLYv1YdnoyssjyOBgwwjjpWgBN8
 wSIMNsrLEPn8nYivrSirnE7IsksM5e7ELf41N5crVwoZfy4u9nw8/2Woc/2FTa7s
 Ifu7FOc93Ze/QsGUQtkXWHt5LbHHDNy2tfDLt9CHt6hoBUWKX6ZrHYXqeK7sTb9h
 zZUyc542JpDBvtt5xYtdWj5IFQ8dT17ZXrXflaN48rRF/qqUxpSi1p1YMEfNiXD7
 GqhJ9CsvtTY8hYK0DT7eEaU9zIbPJpoiBOC7eDe1rh1loXwYs5xC58oGWrbmN9Qf
 Hu1EAw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq892na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c82843005eso31767365ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740644; x=1783345444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=RgCZ5XCQ0jpyWiGwYBzJ83TeIV4nr5aL4UexGtBxkg6k6rocmQpp15KQ2GzFMAbtFf
 BW5HOa7OXJ3cWsSIHlQPIWk+2VjTmfOqzfOi6h8o2eOLQ7vzq8eaCB09cd84/cGAnYr7
 K2OEK2x8+MZtojY+0lgnqYt6FOmnfdJE/eqK1GNsnFc5nlJZDK6K73GA0HG+2GiVFJ25
 NZzu1zqdo004sLMfIXEDc8Qb1iNbTvunVvONsAGWvzAW7df1fQ6F+wXjvcrdwc6t4IhB
 Eq3ccs8u6ThMXekyZTF+hmLrpfl+p6mSdzad4AxpGpphV7gnG63HDhfg3Ts+hrF4TXxd
 jeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740644; x=1783345444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=rw3KizgItt81r2smRIY+Hii4fFBUsa0esVdz4AcQVbvnS93AysziOlgXWPo3V7Ux2V
 x/Xe6R6ihe0mWmjb7xhLse+ji4EJZLIiUXtxth5hF49hFBiTrFTCkgpl1mR0ECejwQC/
 urBim9dnyepiKfQj/zdbk2xWEKrn3WcUom4TtcXf60wycWSXCMMZje2oZCMpY8+0TMYV
 Dxsaf9Mxb6p3C84CyYzUr+dfdG7bQe6PLvaNTn8FGLewm7uB2+mo3lGGDf7Rf6soE/Qq
 p4aIAQurkvoAQO7aTnve7d4ww4Pf767qpt6pMETq/8fwFRIkPb33eJPafuFVQaS4AiOO
 10Iw==
X-Gm-Message-State: AOJu0YzlAm13qIoAluBwPBObLGUHvt+dFNHlXMjZGsTl43MOrKa8763B
 kpss8Mz3KZG5zO1Kp2cBQkYGJGaCQJ2AEri9Lg8LnLdc+ONZj1H+GbY+prrLUB9saaTx1BJy5L+
 gMoHjd5z8EmcstxmU4b6Ljlwly3boADd940AEZw9oD+BkrtrS3xhBAqQyyU4x/x9S7w==
X-Gm-Gg: AfdE7cmhh/Gw4QKDOnxOl2+hcRhQ5Dr3W+TpVpKL9FqT5s07aRllFxvyOiMCRyoT1Hh
 ajj+LiQigrtHIhu7scPquwzp1qP2//dG922IVCogs0LjmxTpTb6Qvro1zmexsPy5AzrhfoD1xav
 kyJFCVSnuC5IazKTXe62k/tUtrSRfdEIUL6tD2+mpMKHgTXgAxlh+l9Qk4tlUaRpkTF459/eCHL
 97wQpESy9XZsh2ELXsmK/NVCPmvQPbqH+6+bl7z+sBB0Z1UqwBzkYD5JyaDBX/03tEw5kPwrnr3
 08DF1L7/YTCVIXK5AC4YhMmaPFi5ivS1WOoGxLGlR8KiPpRGVF+8IGT0Z9r8qLOES9miM0OGvsy
 T1fxVTZNDj8DMZ5Ng6PstaUwYO0YNNQANGYT5tK+VE6JnJsuAKmNgVVJD6D0=
X-Received: by 2002:a17:902:e5c8:b0:2c9:97a9:2097 with SMTP id
 d9443c01a7336-2c997a92151mr98103925ad.43.1782740644259; 
 Mon, 29 Jun 2026 06:44:04 -0700 (PDT)
X-Received: by 2002:a17:902:e5c8:b0:2c9:97a9:2097 with SMTP id
 d9443c01a7336-2c997a92151mr98103705ad.43.1782740643869; 
 Mon, 29 Jun 2026 06:44:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 54/77] target/hexagon: Implement hexagon_resume_threads()
Date: Mon, 29 Jun 2026 06:12:09 -0700
Message-Id: <20260629131232.2487780-55-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: R2rDFw7Ik3zAxd3YxoDyIXubo7oYMQXP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXyDWjRed7aEAM
 dtx/XfSdJrFhqS5B4QoDcxHT9k9OGuDcspBw7prtwXBQ3lDajuTtzVaM4pMNcoegMvdeO3KTlGt
 DHJY7J2nzMPiE8TomwMpMCE4eRstKD4=
X-Proofpoint-ORIG-GUID: R2rDFw7Ik3zAxd3YxoDyIXubo7oYMQXP
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a4276a4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXyqGcC2/wPKkB
 F+mOQLxrLp0YmYDUxiKpud5daypP3+NlPNErQa8+ePkUMZKxRDMlKHGM0VOBkExuH51RzZEDTZU
 aQeo0b08zN580DJ3/RkCPCFkv6CMTHZwuwQAk8+bGxJwHTT7FlWJEWcAe01hVo2lsJqqO4fw1g2
 HlCmC2SKTs9BpPbXzQAzliY1ts5Ylasb8o3s7+dgbihQU+c+dZJDgW3hFPz1LvjU31Jx7IbSalO
 qITJZF4oGXNj9adpWZAZ+bZkoXGANDBN4fp1seKY3NDe5YV6zA7p2bN+veY+W987QBBA3fOYa/f
 LYOYjzBG1Qa2vuYJghPmerwq5wOS+HrVIgkaCgkDuZDev2KAuO3osP7U8Mitx4rS0e6OSqqSC7P
 m9enzUmCnECyR/8AtJBe3qu5hO4Lekuv24ZcZnbAj22Pa8/HF/DjFQQD6Sde1qFkSr0VOYv5dsP
 UF8Kmqj6l31Ovv4iVKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRkMzE5
YTI2MzdmLi4zNGM1NWI1NjBjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDEsNyArMTYwMSw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

