Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9ACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbneG-00047X-4n; Mon, 22 Jun 2026 19:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndk-0003Kk-0U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndi-0002dg-Ec
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZwmb1612689
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=; b=ku
 V8xok8P/4KGzclWhg04NvYE0hF7SjAb3hQFWj+c4jv0bVUv+t+/3/qvv9zcN5WnD
 P8TgsoW8jDPbOEDzYcX6kN5a9R4zAyJLymc6Hgk7iPM8hQzx0B0iGSTHBCBym49a
 FfzukNeQvgv1Q93JmKFEJh71I2Nzjwigrro2ord/kmMqEuF+w+HXZ0O5eHdjPfrd
 T+r/RqXLvyzbsgh7EhhaKhJ4h2rg4D55WNeDZGcIo33fPoV/Xzc5DUlPoXJw5EZx
 lIMesmgFRULW2FRRt5/OVaZ+ztEfcZu+M+nCLy0Bb9jocPCA9DRu4Zqswbuwu8Bs
 6rRzFxTEX5We/G655BIQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjanu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:01:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso21360371c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169262; x=1782774062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=;
 b=OdEnm2XFxGm1YhsyNP5A1aUa+c7Sy7B1twnB17u88W+5olqE9jvoboMxJeqCKy54bH
 tUrKwV/4yIN/aDLvIOD5+FmpvijujI0JCMVRj9Qdl1WpNmYgZ9w+Ogj++9xWgdEefgvK
 fDEQRbETZ47XcyunT195Z2jGkIZjgzdhwBmqAySIqId7K04YJY3WyMHfblHrQT9gCSyh
 nm4EXPotOKKN/ihS3DdJqqthNQWJ1AVO4lB4Hd8VDRD168Ucr5p+1Ymn7DSpB9jb44gJ
 DHPspq4y+6cBKU1HEegmR8mPMO1q6SyPeZvNbVA5ikrmVjRqNFsoKLZaQ+U640cFLyzt
 97gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169262; x=1782774062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=;
 b=peup6R6JBCOgMB/hZbNl5hJWJClbRzcCrj3yLlD2SbGaWb2kBuVYdUdur/slO/yIcG
 Qb5QuejV6AGWuoQm2EGPJ4HcQaS//8D5KDNM5MD3ZcFKrroviL6SmQVBjwFAK8fCZqKQ
 q4p0YFlZqtGada+ikcQD6tiRVap6ZJ1mrtvsp+jtJQk+X665F3xoXgozVqKrQDFbBLD9
 feCJoCUuwqFWET1ISpPzv2EvE40qpsFrOxGsYuD+si635CY7EcOStdhlZhWyS3W6rvlm
 5hAgTJnz/wCieTdCVlIOGiuQUzUOhGfVw6CWLMY38nVTZ68d61Rcs/GcHu95hm0rwheA
 PVOw==
X-Gm-Message-State: AOJu0YyNMkXolMigoMLlr+0hy1R4IXCLwR42RAszf3Z3CDhghh1KBjQD
 tyHmffbn3d8GU8jJg240K9w87n9yejtzKmR5ZmdaLQ9ZLx5GUOAzz5PSMBa/JCqxN0+de0jU4Tu
 X50b+VbRkXv64B12caaiVBBVeyf05VTvtxxbfOsIbC1IZtiK4/QJOGqKkQPgmcSn/Wg==
X-Gm-Gg: AfdE7cmPRkKxqZaKCpnyf7ccdMG9KMi6seHXmlcd/1vXGor66MuXMdLNvb6CxbfZY62
 bBcFFclaClZXdBRYc8osOpWuaH+PAJxqCaBzcRyeAsBQ20IYphb1qVHmov4DSyhOtTlr5i/v38d
 Kf6SHWHG2+IxTs6VCw4LwYCqr5opecm+5MOM6f6JzYy70eguVbeYrA9jL8fwVtnqkagi/lOPw45
 0ospQkuz5YQWshXvpMlORL8KuLkTi+s/1JYe/DdT9DTsdvlRbH8OsxTRY5kMrVmgaHnMNZVVIW9
 KWPKZcdrUn2BftYnDSLm5/8VCvpxO/NhENTCFYxLl7OrLXgukZ+Jdu5A+/Mi2tHd1OEey1EQMAw
 bMFDqGET7ctCXJ/qlKDkUK4FMeXfwpNXTAIlLSl24oRgfl+w8o8MzLQZ1o6w=
X-Received: by 2002:a05:701b:4354:b0:139:c4e3:9499 with SMTP id
 a92af1059eb24-139c4e39832mr504358c88.2.1782169261904; 
 Mon, 22 Jun 2026 16:01:01 -0700 (PDT)
X-Received: by 2002:a05:701b:4354:b0:139:c4e3:9499 with SMTP id
 a92af1059eb24-139c4e39832mr504320c88.2.1782169261218; 
 Mon, 22 Jun 2026 16:01:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v2 75/75] target/hexagon/idef-parser: open input file in binary
 mode
Date: Mon, 22 Jun 2026 15:29:04 -0700
Message-Id: <20260622222904.607771-76-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hTHQHpE2Th17P9aBOxFhZvTs1OBlfB2T
X-Proofpoint-GUID: hTHQHpE2Th17P9aBOxFhZvTs1OBlfB2T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX6Nh+54oTqqhY
 jdW3lC4F6Nwh1domxErLiflKmHpqTn26q9KrwClVEozv1w/AV4dAi00KRsEJJWzxky5Mzrrhcy+
 1KkAXxBLHugFUt9eWsAaic3UloZ2AZI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX+Snk/JsCaJ2K
 tyfwT+Soy5x9MMHOmcEWP7p+4/8qGT6VVqFmjC0oOp+byOltJ9leGc7FPFF0qCNz0ufv+9ttgd9
 n3Uo0mkVGaYkJcgTWfUVRvOeDoe2YrmBELBFzUbsO6+rUIK1FIAJqTE0PTuiWyYFCGlYMWJm6mJ
 Gsqu+Bni2rmyEuyA5ObdHwUkPe1mxbgcge00om1YOyxV4LDI/COp3X2aHSa6dx1SIt61gFtTR0p
 zjlvPTeUP8CDPkwhqF7WpQ6eK5Bk6YFkyofWtu9e1xKrFj2/FnEYdebgb+MhwLZrsxhGYrmjRNE
 y7aA0BaT6FmxolviBFkX3qQdJ45V2Y2hr4JGo+nnaHfMhyMMWuuuyE/JXgVydTEC9M5U0Y81wPs
 s/lGjcNceZPCsLhXL6Yc+HnraYiYA4rW28oPEtu8l+8Jbv8cc9RQ+7UpPdzpN0KF5tl+0nZZNpa
 ST03BWN1fC0v85TrvMA==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a39beae cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

T24gV2luZG93cywgb3BlbmluZyBhIGZpbGUgaW4gdGV4dCBtb2RlIGNhdXNlcyBmcmVhZCgpIHRv
IHJldHVybiBmZXdlcgpieXRlcyB0aGFuIGZ0ZWxsKCkgcmVwb3J0ZWQsIGJlY2F1c2UgQ1JMRiBz
ZXF1ZW5jZXMgYXJlIHRyYW5zbGF0ZWQgdG8KTEYgb24gcmVhZC4gIFRoaXMgY2F1c2VzIGlkZWYt
cGFyc2VyIHRvIHJlcG9ydCBhbiBlcnJvciBhbmQgYWJvcnQuCgpPcGVuIHRoZSBpbnB1dCBmaWxl
IGluIGJpbmFyeSBtb2RlICgicmIiKSBzbyB0aGF0IGZ0ZWxsKCkgYW5kIGZyZWFkKCkKYWdyZWUg
b24gdGhlIGZpbGUgc2l6ZSBhY3Jvc3MgYWxsIHBsYXRmb3Jtcy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55IHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKaW5kZXggMjIwNzBkOGMzZmUuLjNjZmZhZmE1Yjc2IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBi
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTg3Miw3ICs4NzIs
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgY29udGV4dC5oZWFkZXJf
c3RyID0gZ19zdHJpbmdfbmV3KE5VTEwpOwogICAgIGNvbnRleHQudGVybmFyeSA9IGdfYXJyYXlf
bmV3KEZBTFNFLCBUUlVFLCBzaXplb2YoVGVybmFyeSkpOwogICAgIC8qIFJlYWQgaW5wdXQgZmls
ZSAqLwotICAgIEZJTEUgKmlucHV0X2ZpbGUgPSBmb3Blbihhcmd2W0FSR19JTkRFWF9JREVGU10s
ICJyIik7CisgICAgRklMRSAqaW5wdXRfZmlsZSA9IGZvcGVuKGFyZ3ZbQVJHX0lOREVYX0lERUZT
XSwgInJiIik7CiAgICAgZnNlZWsoaW5wdXRfZmlsZSwgMEwsIFNFRUtfRU5EKTsKICAgICBsb25n
IGlucHV0X3NpemUgPSBmdGVsbChpbnB1dF9maWxlKTsKICAgICBjb250ZXh0LmlucHV0X2J1ZmZl
ciA9IChjaGFyICopIGNhbGxvYyhpbnB1dF9zaXplICsgMSwgc2l6ZW9mKGNoYXIpKTsKLS0gCjIu
MzQuMQoK

