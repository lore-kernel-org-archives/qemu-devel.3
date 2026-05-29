Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE888CD6E54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5EQ-00067Q-Ju; Fri, 29 May 2026 17:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5ED-0005xC-T6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EC-0000xK-AX
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2IBF589662
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jaVf7UGKXmu9hxPq43HrJcXFS7n+cdTO02SwzBafwd4=; b=HviXoLp43xmfR3DB
 7uIk2dL+jUn16E4D2QGgRw9zPwBNCtB3wfignifZW64rRijwHsJjTr96QkHAIV8s
 8jHEopgfMz8fO9Jd5N8PgnQfN478DuKrwiWe/jtq7YeFBayPWxZ2SS5INX98dU0r
 eJgsdNshO2sVVdC/GlpuwmWXdVmU9PSLD0H0tJOjMraOUWvavCMn21xctTm3V4X1
 LQC/vfrIX2yWJqxwm6dvknqVF4Li7yb4vozJOKT46omyO9qNW33W6GY1yjzbuJiW
 8no/gYXZ/aLw+iVTThr/p0rQbOX5UhiiaIGdpvsBpmfUx0LLwnUd+29eQMl/9e+a
 faGbcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rckbx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ed777a96so466529eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091920; x=1780696720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaVf7UGKXmu9hxPq43HrJcXFS7n+cdTO02SwzBafwd4=;
 b=aqQUBOw5pFL/8WL/4tIIs5kNV2Z0JBBwUhpJXbX+8rRr1QGgSFgeFvafWsNL32T4dE
 38oA9UAbFtptg5Z/+t39HajhRraJ1z2OfOMOijlyEVVUAZvx6vooc2xhgmUC8VfN5TJm
 90CEefwtXQriQ6+ErLcm9cHgHsD7WnHbC5gxBCiKvT3dIj+AvUQ6h2KOVCNzZ6RAZ9jn
 3IGOo5KvIa3J5MXJ34d0dH+6lzGq/QMyz0xXvPOH9P0SCFpsT4LmkkMg+7LvFH6t0LcX
 5dZe27mV34tYF7WJFIjP0XZjXOhEjBGu7ZtihT4AIGP81cQFOvai1v2QfF7A53fMXsjj
 8IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091920; x=1780696720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaVf7UGKXmu9hxPq43HrJcXFS7n+cdTO02SwzBafwd4=;
 b=Qa3GYM/x3ZYQ3JSJhqJiPSkJAXKwGkwaDrVBm0nchX82RUXGTyE0BRb8kxqmPSKJ2E
 b6SJ7zHXt40WiIFWgFm0c7hYwSPrMwQLW5xjhosLptVqzo8H3Wns3VV+9/ZqVzpUvtrN
 MJ2V/IWx04zM8l+wxGM0wvzDqxJJj2ivGwO7AIaKxfD0YkzxweZDiMlYwDLm4RFRdUCp
 OHgPJTc+e85JMGdqPT7Zzq2+15yYJ8n1ymzte9REQLJ3oq3nnMtWHBpTGVS0CHz1QIbP
 AqVP7ZRILYPR6HpL1WPsnySZCij43PMY6Djk3tlHD22vzSE/1DAYtQwXx8iPh/8lBYib
 9/Yw==
X-Gm-Message-State: AOJu0YwONevx3kgC2yjjO1jMizsWWaczTT2olXDBke62k1mzQXPn5YMm
 AYE3ERDJ7gGP9xW7049vom4qLY/JkMDLVP+7m+RGS2c6GTKYgYEhEdbELk7HRAayYK4orJx0hQf
 vW/HuGyUtC7u0fIrjo6gTKI6JB67ARwpxKi6aNNHJ9hgjjSb0zui+p62ugOZ0RUjtlg==
X-Gm-Gg: Acq92OF42VwL9PrCo1IEIc6DEK4j/u0xfsPGgrCOZ8U6VDFEZt3Soun+jI9LgySYjCA
 TExG1ZUBSBar9ZE/la/MaseReDyu4Wf9Dj8+XkVl2dMDzR81751XqJzD/jURVVTJUNBdGu0dDT8
 GfSxuVzjYL+jQV8hiBuIs3dKAg47m7Z6BGB/JXBcthrpHYc7e/oPlGihSnq9s3qQ8YYCWCWSX39
 6sCwiLWfaJnmMa+o9XuxZ0g6fvfTcv+YhWqh0DvEoHzWqZ03PBBFH7TaO52S8RqRtaElmQaqQMW
 Wfkr0n5nJC0C63+gQZRXczIhLfRkx5l9SeP3Zm+TchQ3wLXTSKnNu09kRIUwlqwZCXYJOJLmAln
 XguAJuy2FaFWl6xnVZJ7/hlFXbIUgzM/Xa+cfLIXnGbdBCYHCiYMzFnnWoQ0k4ssmNBo09tXpkY
 6pyR1J
X-Received: by 2002:a05:7300:6426:b0:304:c9f1:a0e9 with SMTP id
 5a478bee46e88-304eb115e9amr2300923eec.9.1780091920306; 
 Fri, 29 May 2026 14:58:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6426:b0:304:c9f1:a0e9 with SMTP id
 5a478bee46e88-304eb115e9amr2300904eec.9.1780091919791; 
 Fri, 29 May 2026 14:58:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 22/28] target/hexagon: Add implicit sysreg writes
Date: Fri, 29 May 2026 14:58:00 -0700
Message-Id: <20260529215806.608770-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xqQYy3PowsTNq2ID9Eviseplye2Vv3Oe
X-Proofpoint-ORIG-GUID: xqQYy3PowsTNq2ID9Eviseplye2Vv3Oe
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1a0c11 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/BCZG2b0s0sE
 2/yYEMp79h3vHfT2XIpq5OLtI/8onzhZ2K3g99p0HAdGiKqV9jc1tof/0IeXtn3QSgGvgWflPeO
 lk5qcE0LOz+BzFf8D7zjt1v/AsRjcxMNsPuddkRb+dkT4tnhXzugv7wUrIfBntUKDee4ktiaDsN
 DyMUcsMUJbBJlZ2MHPqA6Zj1ufTE1R9bXVIS5+9jNltluiEadb1O4qD03BypipDwEjgAHXlgzfJ
 pfSoJzqmzCUsvQElPnNIvIpJfE7dpGu8PsOmIZOboUy2d98XdphTJEn7n//YwCv+D1G7QcCn7c2
 dRrmfgolCLivabE8U1jlQjVXnZUTaaaP0CH8FXUVvyvg3yFaFPxNCAXILDFHgsvA4NAcWewnzUa
 WGULbnUyLoJmzATVIRa0KULVS8uFdss0QwBzDCt3dlinXAyA43Ppm4YDHTVqFFwlZ8hn8a4wxTA
 bt3yiztBwMelPnlZDcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDMyNWMxYTllOGZiLi5kYmM3NjQxOTIxNSAxMDA2
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

