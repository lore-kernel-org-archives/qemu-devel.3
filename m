Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F1CCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9a-0003cT-Iz; Mon, 22 Jun 2026 18:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9L-0003Pc-DJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9J-0006Yo-FW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZwpJ1612690
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=CID2UqZGazdoc1Zi
 JIYLg2DovrniH8FGNjYILU/6sDka2L5MRZxfwypMetpwDZ5wyIIPOF4qKIO1sXyP
 NWCvpI8rgRs9cpBS3ZOr9uMkcHtJ7EEJez53mJaNmGv4OBsg55ViF29twaGcjIei
 8bmiFUiPQN4a+cWNhojy1h/nXUSmByFQ0hOpIttnwZtsU2mXeHK/16vn/PiQIopU
 3lyf0Rt48dWdp8X19QChrrTgSRLKmzLBuqMTFCrSTK/PRG0RNDX91nOFmEFeGVQx
 vV8udX/dBGksFYkmJvyGzRJFCuLz3uA5cOI6iTbKDK3fqxqIf4nxQuv0XBS3Eykv
 hVCbcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjakf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c42d96713so952118eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167387; x=1782772187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=EnzTVqghfRfHrUbvQiafA+TnQF5lUjd1hvYIA31Zg9ddeDrqVHzNeNZpocxjqTQEk4
 qq7Zi9PEb1KF/OAllpX/trjqe/zMYbknfSuUxt5WYeFxKH02FbsgnrYITLOP8SX82P59
 AcvJti7kw3JflUHuxNbFVR9oc9XwQFYuSzNkp6gKK54/QnAbdGptSRAjQ1Z4zTUYq+Jw
 ggVJ8ArpuibQ5Aw2vOGoEuO613yBxn/4YqWNAZs9bPNKKrSUUriTIC4UiKK60CNbygUa
 izdl7he0rc5p9BnQA7lWBeYjI5TwzROFX7Ei9v2UjXU0mi7Utuf+qWRrPeTj8GAj+dEK
 ywQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167387; x=1782772187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=DQ14az1kvXOWOXU3JweBRQ56CEDWTVHMFGZodMJl8BeUZN5jL0DgXafzcVeI6K9na5
 uTsRRwhp3rX4U8YX0G1I4i4ZBGwdchuIwpyYi/TGUplQ2VNp3CVMpoAyDZaLIjZuuPyv
 9z3AyUXQnLy29BIsD7Y0IWkPvo4+OqUNlzJQ05OiG4t9A7x0Z8D01en+qYv4PQY4pQIF
 NeTu26OP+ZSNNFX1vxIsYXVOg2KYzkeudkKbDzY7rBibe9mgI+vp8WBIEy3/4W2kuQhG
 zZGlN4N/N9YnVSSM5xlLEr3E4HSFXOLcr5U5aJaP28betJI73YaQSB0spd9G5s8j40eu
 SK8A==
X-Gm-Message-State: AOJu0YzOlHCm6owcoIp+SsX1hPybfH8/Ctozn9s6O2zDMod6lKxhU+dS
 kX1m+ApgefAppgwKlH/2fYPeeGCIqIAZVQ9UBVvuK/Ru3dxX6ZW0bfe1DBdhqaV+zAG1Ajwx4iE
 JGsaPkNnBmoiyAzsh2+WTU0UAGOl4zrQEX6H+nhxWTtAfiR5vrOHFtCC0QpOEN2HCFQ==
X-Gm-Gg: AfdE7cl1kv0yb2SbpkIcNbo1wMDkBywS9PsIyhtrXCz1B2QdyC5cljFqAR0yjcmv60w
 gK1GdawYLDmBbmY+MX9xlDcG6ncFaBfZwYUNImV+AIdnnGi3KYLRssOxW7ahJ+eRYNfV7XH1ipE
 YjlOKsNfrJ6oUnFLoHRn+tcXv4ThDl1MHl6rNv0pEYHFIqczWo9XFC7H30Q7Sa2KqWk4iG9o507
 0acICtBLFZ/o8/4CQaYcjsvRkb+Skn73jPEIIl/SBHvl+eQfertIIFHb84Hkcu9YfbP9yJeCOIN
 bgBN9T6i7Q1oEjWlJOhC8NZydEljMqpxm+Xaamzs8RppnZa6a/xj3xLnXE/ZtP26aKmtWyp7W0Q
 D9d02p0jtvseUoHAlRfgLuaDOeu4eO28CVxM3ROeAoIrQimmspJ1M5kcOWDs=
X-Received: by 2002:a05:7300:641a:b0:307:d4e7:b177 with SMTP id
 5a478bee46e88-30c06e0cb8fmr11846484eec.16.1782167387205; 
 Mon, 22 Jun 2026 15:29:47 -0700 (PDT)
X-Received: by 2002:a05:7300:641a:b0:307:d4e7:b177 with SMTP id
 5a478bee46e88-30c06e0cb8fmr11846457eec.16.1782167386678; 
 Mon, 22 Jun 2026 15:29:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 25/75] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Mon, 22 Jun 2026 15:28:14 -0700
Message-Id: <20260622222904.607771-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: c1x4JnzNyH1zIfAEzqUozyrX_puvwD92
X-Proofpoint-GUID: c1x4JnzNyH1zIfAEzqUozyrX_puvwD92
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX29Oy9JDwNSdi
 i7pr9hY4m8NFxkkGfS2mdFJAN+w8AEma93MYRDSaNoAzhv5p/L7W9XYuv+oK/mGiyXe0YaloOFT
 cc+G1larYRNLs0VVzY5kt438V3XJXCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX/gIKQTPL6TFo
 eV8TNDlU1wenexjhZKrWEIEEMc5ho5NVxvjk6Q6PcZ/OWj9XNJZrQH6fgWWOhnMs5DW7FDegW4C
 v7L/8Xkn0YtainbRayfaRaTp158IlsJgTYYF0p3gsZ6ut1xAcqWg0Qp+ERnKF8Y1f60Ofh+8qAJ
 zUPQooeTZfK0IOYqqP+YFgufVamJyebZLkJoWi7TRW68SW9WI8vdf1DIicKDBdSx96hQbRXpQ0s
 u5Fv6BE8yn3PBj/geEMC6kQE0GryqCJpM10OOiM2RKZIS9VHNSD41KCZKodUY54NXYVkmV1NDg8
 J9sj5qEL0Iw+C0nEJvWM8z2oippPErXArKIXPZ3B83/CzIvwEBh+KvcKDS7Q7L/fITOuYRV+voA
 beHwy9NhYfFtV1kgzW859tDNRBnusJ34lWOX4pURv3v29HkMzX+nYq7VQljv8LN1Gtv+xdXavBJ
 c7rnlzMgFlXpz5nZLzg==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a39b75b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDhjNmEwNTg5Zjg4Li5hY2FhYTNjOTQ0YSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

