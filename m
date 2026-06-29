Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9344C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCII-00045b-K3; Mon, 29 Jun 2026 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHl-0003oH-G0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHj-0006Ir-Qy
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuqT2640954
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=W53kfRL1hJ9thlax
 5qhidjgqUd21YAqYtiUwV1RtEd7nW7DC/mMKxMw0bJNjfvTwEOYQSyN03n+p0tFp
 T4539ZZlCq5BUd/S8jGrGsj1b13MSPlR68cyTPRtzCw4DYuMjKMeQ993O/twmZto
 7a6jXH2N5NrKKfdY+FSxFQqE2h9xxu+We2Zqs+uTOhz2iLeGkhAt7T3Yuu1f13Tr
 0RR22nsXpr9tgSYxyV0tPv+JynlDDUjoiY3lV1ilDg2TlSL9QMUAkAGj3O8VC7gK
 /6jL2GXFO7JOqlpaJVbzmxOkUZY1FtZiZcBdWdHQtuhVQchqY276ynTBHxkPtx0G
 +yB7XA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s181t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7ee3952d6so26053055ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740655; x=1783345455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=DXC5ElaCZ0WZRFtW3H9MdbaB9noKeLo71N1unJhJqWhIKT4pFbGbh6FJLhukrpFeVM
 JrREBm/gtkrFyerx75hbth33Q3NoMGYHvS3gWP4AHDiSJOHJfhdn8DlklygAhItLAE1h
 Et5sQoP56x2EyfYYDT63hLQvJTzHqSWsChgUjRWMXBvHLdYlDEVJQ7u7UuoeZ2Tmsm2g
 OQZXEEHNTN8WFiZv8SysU9zRCIIu26G5yzlQ8FFv6joSBePoG9fXBllFRoZZDThzj8DH
 coaGC33VgU+2XpZ6Hgdz0oZxzdUg8xUNKS2v91TFMpRHfNwI4nGkbCkJsDKLQy5zJa4K
 pZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740655; x=1783345455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=WuhSggI4BJYsxtLuKYQIM5H2VJ/pwnfQoM+OMCpqj6KKcHlwrlti7VMLKdZOvF6kHX
 jy8QM7DWDIgwtp4mwB4r786P3a2ma3NfTzqZ8IoizLxii8Cy1+BzMx29rQt7PXUuyWJp
 1xPF+S8ClVyTOUPuV/Y6g+21NhkKgT47BBO2Z7oBzMlwgExOoJMrGV3lM1HGPezPDXIH
 tJwCZILdkzALz+DUitbKoJ61GVUylMyIseQ4UvO3H8us7g2zU33ld7xtgtwO7BIKkEe5
 Lz2PDA2OxYv2NSeIou0t+thhM4zpFzAuTaRyD1MBkEM3jM8Fr8tJtCVoI+0DS5bm6lCb
 Cl7g==
X-Gm-Message-State: AOJu0YyrLK5XxeqtasTFMWwNA9EO8ubT/2YpJc36eZ6ZJEll3uXwCAgz
 7ZGIlAH11EwaVvQteWQd9yXD4oawIRpR20VqUx/3oN1/jImqm9BVaZ/lt16LsYu4f0Txr3mFGNV
 ECpMl6NMo1E66aQfS5itov2cH/b6w3GTPKyBwANURZhrsfKn1a3Ms4nyyr70jr/herA==
X-Gm-Gg: AfdE7cloLL+Iikf0baLkPc1oes+tC4ZyAAEs7F9i2fjt9sERktl2PEEZCJhWLUv9dKz
 yWAqfEL3aCuloC4IwfOfgBsHoOhd1WtwKvHQuvDNV9zPg8KO09M+UoDxM8lOJMZwKGyCKCF17dm
 PLNWk/nXPnUvv9LOd7uFoOFREXuD9JYf7OPN25IJTcemiavSK+vcFCzm9ru0JcfUHoXOWdO4exd
 Bi7A3nbel/ZQ1CdgQ1C9hPSrUTFQBENCJLP7HwIT7LJkmKi1T3bBlc1t4rjXDBrhOoJklTnTva3
 bh8jfPg4eiVe7ofSShCVN9DGl4w0+Ul+vQuCoSusDVkCfwvSkTWCtzP/BdVSvD47SAtXQ8PNIWY
 m1sHXwu2703tSNi44IrtTXivfvntWF8vPDP5napMgz6+R4pyE8bIVIKi/riQ=
X-Received: by 2002:a17:903:1b03:b0:2c8:2808:3ec7 with SMTP id
 d9443c01a7336-2c828084228mr102940615ad.34.1782740655124; 
 Mon, 29 Jun 2026 06:44:15 -0700 (PDT)
X-Received: by 2002:a17:903:1b03:b0:2c8:2808:3ec7 with SMTP id
 d9443c01a7336-2c828084228mr102940375ad.34.1782740654659; 
 Mon, 29 Jun 2026 06:44:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 62/77] target/hexagon: Add implicit sysreg writes
Date: Mon, 29 Jun 2026 06:12:17 -0700
Message-Id: <20260629131232.2487780-63-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXyzAJ+/bsAbpu
 1P4HQrOLrq05Z7ZSuxFwYrv1Tj5WJVv3a4npjICQfX2DsCLm6O2JcrLEYxx+tA9uHDOUNCeF710
 9gQpmgAxG/0UYC4bHCRyrVkcjxuq8i8=
X-Proofpoint-ORIG-GUID: Znia1_c_3k_GTJ3JLsdUxk9m4tWCxXVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6A9kASZZwuB2
 wxCBxCnHwjtV1rTdnRTc+6YflVEtHY1Oowq/2earzRZhf71keysrvkE9mtYkY8SzYpH8682l2TW
 1NzRYdQ+VMMyA0IVGJ5hTwXkW0sp9jE4gIWhrKq6eYrL+oa7bs/o3jW35xDZ5InUTcgbjvUNPrF
 k1Lcza2cXIKAf/3hs1Wg5dhTyQQcI2zVTNUYnQo8ohYnto35r1H/aohOubv03v3WQiNI3uUNwae
 /IOxdZaQ/BIAgoG7X6rNey5QlbgSeNGMoiWYO1yNePg7E2dR3Uxct/4CzV6gEaZlST5RcgkgOe7
 d/VjXTcklok8LuTiwRe+Xc88cUXQy8HmgPRQw4L4Kz8ogMZvgRITMhuItP3pkwVoPy/dUF4Ef6y
 ic/AmDW/P/yG1hyG4C+K007MptrYSpWHgdkwRAqRiQCSPkosD3KHEXQG4zz31tz+MN7CUMg6afM
 /8Z2qfk3iY8MjeYXJwA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a4276af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Znia1_c_3k_GTJ3JLsdUxk9m4tWCxXVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

