Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312D3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39e-0001g5-4X; Sun, 28 Jun 2026 23:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39a-0001f7-Py
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39Y-0006Is-L8
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2dR2h1544920
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=cuyKOSYrnmzQDa7x
 GqK7erz6n3BTkQlxs0fHeKocc18EIe8vtIH/D4RJWGbHXfFKvfKnKZP7SpJa3WFT
 U97/IWblvSVgYZfp0qjrQa3fw4KwQkvJD4bT/MA9s873ZKnHRc4p1omKbQD5utos
 jLjT/vlO3k5Q88JBtH+LJmdLpn8EviSEe+ApjL7ztWqHI+K5GanKhgvzz/d2f3Pz
 n8MCLDt5Vn01JVki9eJCpGUM+pI1I1nO4pOgNNhnb6DzjB9aH8yIB3YLwLfKeX+H
 TD0mSbVflW77QLVThWhD46o5wWyzj6r4mBE0gwCBsTbVOykOx+CzAfERLyKMNDIP
 X7TWDw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumacw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:23 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139f77afcb2so3338919c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705563; x=1783310363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=C9T5nvHigyTkt9H8s7/VV9MiX9K3WTE7AZWjFityOQZlGgIiCR3pa2lnl4rvc46kHh
 1ycNbraTJ2UpYXG0XSYV1SO3UslzfBBvZKRhU2NY5YPidjxgP5AvS3L0QciVawTLRjPf
 IhpJQ/d2Btbd3GQ51Jr3f7IdpfZ9HPuC9fFMlJxWoH59v61ggtlrItiKK2QA2uvjLO3h
 UZfiwrywETRUdzKxDVedyjUjZIfKlZFS/rbxRZV/7Hx3/a1I+Q6YuN1mu0UYWKY78POl
 LMCBbWt22dwvr16i+HUIhpOQdgfJciqB1k1Lagv4W4AdN//mpvqUwf8mKxZPhrTMyZ80
 iwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705563; x=1783310363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=MGnQ9ZsLFUHFI65VeaZ9Pb7nWrIp7puExj+VXPZf6FaDYbzFvpGOb7GcB47uwuL0w6
 yDdJ7FEzh4ZxafvbXiL5B72AYE+NlzR6Npp5kR0fhxr/4T4NebbGMQcRMVoKIkLcR9VS
 RviPp3z252MmkuCA+9hXl+QLtWpG3kP/AyKoP96cYacjH+SV5xu9090l+Z4xIUi/URQB
 2wRBpfiEE2J6IxH1+woL1skxBbfiVwWlk9v0cSpV79ZpJFhs7Y7Ca4jsPxHp1bVIFTUw
 tn7ofjIMYw7N16K79D+XOoLAlfmSWb5Lp6B3/KfOYW0LzYQ7+IgwQKeW7x/zyXLyPjmw
 vuww==
X-Gm-Message-State: AOJu0YykFFREFL4IlcaFzECtkg3sB9XotpYBf7qNBb0mrBgGd8SnBjaQ
 NHmbcFyC7bj+IkKccs46DckLfrfzfdna9VKIAseMuveLAFGVjfg4asYEd77z9LgiLmEFNWNc16n
 F7q1LV3A3l/hpPuraRkicS+f7l0j0UNPhGHXwxebZ9LsZ4b77jb9lsg31UT5X3c3M+Q==
X-Gm-Gg: AfdE7cm/0oHFAGCG2OLakhC0j30V8Ozwy/2bt9YHnO1kXT8xn3PhusfaS4D6REqJzKQ
 GPn/eylu+ICzaTFRxiNDDGufII4qAh+TlvKUURANdGBqTBzzlZ5O5ujhMgCZ2jCKgQ5L1CBR8yi
 duoJyDUVdXhBsrmv23W6/g+I6taJht/xX3YrjYIzPuafOtjufSYEpNzx3HKO9SFUg6ShHg4Y3WF
 Ed5EtgZLULBFO4QtgxDEptFYfb2uVF/5r40b+j9Vy6PGQ2L1Zpmpmwp4xuidIYNsjx8G9I6X6Mj
 4R9umnOwVIjzl+T36rYBPlzktLbVNIi8KUkJ5TmykfgLfrrCpJpulZpphggqaErXWHt8Vn3dOoY
 6/1L/98yd96nDdOr/VnenVp5eMQKskiXYeSjMmrlJQFUtD4NYdFeDlCXgeOI=
X-Received: by 2002:a05:7022:69aa:b0:139:ed5d:3ae with SMTP id
 a92af1059eb24-139ed5d05fcmr5642521c88.39.1782705562628; 
 Sun, 28 Jun 2026 20:59:22 -0700 (PDT)
X-Received: by 2002:a05:7022:69aa:b0:139:ed5d:3ae with SMTP id
 a92af1059eb24-139ed5d05fcmr5642508c88.39.1782705562157; 
 Sun, 28 Jun 2026 20:59:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 28/77] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Sun, 28 Jun 2026 20:57:41 -0700
Message-Id: <20260629035830.1520296-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: wOSOYAzUXhgyGCXSbfcy2OZF40oqfsFE
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41ed9b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wOSOYAzUXhgyGCXSbfcy2OZF40oqfsFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX8o+Fo10r6wMQ
 BscAXkuw0dBT2vIQKEUVJOYJFasDMSr3N4jyTItDjr2Dv+dpbXtXXNy5IJBEysbAYL1cfNjMLu8
 SzeR6/asxvOAxncUwjAMzNB1yVMZtO33OR+G8z/Kd4d7hW6qngI7GbxHhfOS+6ocB4HRqGxcGRc
 gC1VnbZzA6KqDbgQQPjQpkMjYaiS54PmBRGqc+lTcQTJcq/1PwMTCuhbuBmeaP/FsRsujn/AfQF
 tHhN/vuXzLpNrf8vYKeZZp58ojoSC2Re0gGKMFDuinPVLgFkFNCDR229rUX7I7+XXiecdcIQtDG
 F4WSb9J0WtUu6gj1xp8GTrkH4xxJjYLrRbCsOpNGqxod+5N/hVgBSDVwCR77m3wrPJZl1R/iHpP
 yU6nlkMbilHEGexRoyo2FZbTdiAKJdc5FcT8VfXnXtnkIZQJaDeiJsJhAAP4M3H2hE9PSRqs2zk
 CkBpEM4N0j/bB4COF/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX5K1EpktOkSDs
 MjTWKsS+1uLK3sN/7/0hA84/gmogwxaltFpYFiFnZIZwavl+ndnv4WPq7tW4ofzyImyB1AwjQWZ
 msITppdlvY5cwpDGg5WDEubAyk5ZMh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

