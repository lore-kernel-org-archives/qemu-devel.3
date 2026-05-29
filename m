Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF69CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT75X-0007Rt-Q5; Fri, 29 May 2026 19:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75V-0007QU-Dp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:58:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75T-000551-0V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:58:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJa9Gn519996
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=; b=hkvJNKi8vPVmNtRB
 +GcLcViB2vKBCG4lIp6fQbKhCTyigLRTj7RP4QIOcUb8bA8eWGklftr9PM1uNkXx
 +9L22zPPyBgWFe0Der+8veJ/BN/pxhwV84jCkiay5ALjo/E/oDfGNG+4t7T0d15I
 9PH4XFxGFVI11J6EzN/KRdEcn9K8z2R5gudqTJAQE1d6qTYfPE30KuS8nLkfuU0+
 lduVpTxUeavPBQMMGkjca4BiUbN6GCZiQ2alPCJjcHLcAd1YZ8Uhf/wUa3x5bYIE
 WvYOV6QP64vN0Xt5Gw1toiVjJaKxyESqeam6gTY/UTWcxSabZ/Xb92DHeL53tfXD
 Ob+FYQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3srtt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:57 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1370417c0bfso4219920c88.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780099077; x=1780703877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=;
 b=BjzdCpzhoDHMO5zbuEVzt80zrvFfP2mija0DgHK4gHcNyz+OFHXyRRiVb/Si6p8ohj
 AEUgr7e0jmdaspJ7pwOUAEd67cSNa5WR7AHSuyq6r1VccqSqJnou8bkiqaEZc4gdhJl6
 hCd0nJg5KRjvB0YKbHdf8Ng2wfHRXJJjHHzuBoYjUHLLmOOyzm5YS0rJTx7qwm8diVQR
 dNcPjLxmodFJp4ptnxZR+DdkPljP1cKeYdi+WW9fEtcknKeyJgif7QKh31ZLE13MaNaQ
 +A8tUDzlqBTzA3HtUPp+M8FwJzSlstQtl8+ALYd6CYbwfUMLChZf2931OcbFzxTQBkJZ
 4a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780099077; x=1780703877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=;
 b=aaLcTCMMkVkIf9tD6+evBizgUc9f+0/IvvFeT1IEVhaTdOhsP56nsNInl7er8F7FYD
 usiuWNIT6Q3S/Ha4BiLvb4R96IKJyoZzWJnlRQCMfYURcSh0WbLdfA7BqLNNXmXJieHs
 ouZqrKdRnHU4QJbh2/3OoJ3GQbxWBytr6HuvQpNHdAaPxhx9tsBN3Ac6/N+hzNlDPb1S
 yy9iGcZLUoS895+h4S/ed3D3xgo45RAg1bSvOVqvc0qPJIWplGwDsxvYOjmCaLRwdm2c
 DBf8TReK2QR30AEYcMvLlvKfgefTjHEGKPMmB3k23dUz1JpCTmoojcZT9n3RQFPhU4ii
 mxmg==
X-Gm-Message-State: AOJu0YxgHRgtpJe+F9ZS9PxRm5yd8hQD2QzmSJ/Ehghd/fSomR7xyK5h
 M55VaD7OOMnxJttRJSR49NWyvcYAMQGA+VWN08V52feeXvCl+WLlno1PJafeuzdj5oMauTGqzR4
 OaNht3rUEp2rVjrR1YZOZSxBg6kF6Q6dXqOijIgTUwQc/bRivd9Cc+Fda17VfF9ZHNg==
X-Gm-Gg: Acq92OFW4+mLTlWWd5SRJe/zTtP3wdfvQS1EK4HOv7nvaAqK5eUc4VE+Rp3l7SEpH4q
 8QqS8u14q7x0/vtHrEzkXOFLgGl5LDc+1DWw7pb/3NjxVEA3WiU2MR+6RBmMRYjd66IcZrQqcnP
 v4P6/3iOmz+4J8ehrsn66204WyMBtn7Kb5fJJn3BKL0Oc0IG10WPWsIvfoq/vRmD9y9HQUtfNtW
 lGTDOSBjCEctchDRJAQgd95clIbKMo+6/117dnNyYpr3tm+7LVzsizOpGG4hnZO6/dbLWk796y9
 aH0LRNOYKMzu51k3BiApXgDn0MkKU8Of8KHRr8wSIcyw2fNSjan+zOUjlrbLQp0wDhoMoOKchDe
 3ilcZk6G+2jyoLLIVcB3zrl4UpI+ae9CaeJ4wytoPLtYk5RWLQlyUotnam7Ani8XXmMn6cEug+c
 A2qwai
X-Received: by 2002:a05:7022:69a6:b0:12d:de3e:86b1 with SMTP id
 a92af1059eb24-137d4448359mr676104c88.20.1780099076964; 
 Fri, 29 May 2026 16:57:56 -0700 (PDT)
X-Received: by 2002:a05:7022:69a6:b0:12d:de3e:86b1 with SMTP id
 a92af1059eb24-137d4448359mr676092c88.20.1780099076388; 
 Fri, 29 May 2026 16:57:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36aef95sm2143282c88.4.2026.05.29.16.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 16:57:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/2] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Fri, 29 May 2026 16:57:49 -0700
Message-Id: <20260529235749.879787-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
References: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UcPSfRglcfRZ1dFfdl0A6va0jdXlyePk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIzOSBTYWx0ZWRfX01QxHx8Wn8B8
 fHZEK0aNsfPmrCWdu8xLPTtfiuYD1AmLwQykFyVooJ2VnlZYIGxjMBcLDy3UmzX2OEiEYrLv2M+
 57ZrrbfqICnDsXsQXx0jD2ueMaxa5Z8jbqPfsrqWZicCg+NIORrGZgZ134vy5EjAjTAD7uOlGL3
 5V4+cc0JNusrx6W7kXRe2TGQGI8j/AAi9LTm7kKYK7aWbzThQHo85/i3lkTwabrPMnX0YoBelgo
 6S6gqmIaPPylc8YiXZtVwMvlktgXo1HYR5KUfGt96a3W5qw4+22sgiCsUzB8LZdyC33vt+lwrl+
 VKos22i31VQZaVasjqZAdM8sHfxNNaXtmYpDktSJOknwZxlXrnooG4pw/rlJMbT9wwWHgYCTNTq
 /M3SUTLvDzGeINTQVer2hKqGoikaNePXH3nNv0TpebMBOHZUbxN/9/8GojtpKteS9TId3B9lUJ8
 OsuUhAIzfDmakTBIT6g==
X-Proofpoint-GUID: UcPSfRglcfRZ1dFfdl0A6va0jdXlyePk
X-Authority-Analysis: v=2.4 cv=b9+CJNGx c=1 sm=1 tr=0 ts=6a1a2806 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=q7X4_axEi9qJq2Gpr8MA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290239
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

VXBkYXRlIHRoZSBoZXhhZ29uIGNyb3NzLWNvbXBpbGVyIERvY2tlciBjb250YWluZXIgdG8gdXNl
IHRvb2xjaGFpbgp2ZXJzaW9uIDIyLjEuMCwgcmVwbGFjaW5nIHRoZSBwcmV2aW91cyAxMi5EZWMu
MjAyMyByZWxlYXNlLgoKQ2hhbmdlcyB0byBhY2NvbW1vZGF0ZSB0aGUgbmV3IHRvb2xjaGFpbjoK
Ci0gQWRkIGxpYmMrKzEsIGxpYmMrK2FiaTEsIGxpYnVud2luZC0xOSBydW50aW1lIGRlcHMgZm9y
IHRoZSBuZXcKICBMTFZNLWJhc2VkIHRvb2xjaGFpbgotIEFkZCB6c3RkIGZvciB0aGUgbmV3IC50
YXIuenN0IGFyY2hpdmUgZm9ybWF0Ci0gVXBkYXRlIGFydGlmYWN0IFVSTCBkb21haW4gdG8gYXJ0
aWZhY3RzLmNvZGVsaW5hcm8ub3JnCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2Rl
Ymlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciB8IDEwICsrKysrKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZG9j
a2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciBiL3Rlc3RzL2RvY2tl
ci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKaW5kZXggM2M5NGYwNDBi
ODEuLjIzZThiYjJmYjI2IDEwMDY0NAotLS0gYS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGVi
aWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCisrKyBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9k
ZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKQEAgLTE5LDcgKzE5LDExIEBAIFJVTiBhcHQtZ2V0
IHVwZGF0ZSAmJiBcCiAgICAgICAgIGN1cmwgXAogICAgICAgICBjY2FjaGUgXAogICAgICAgICB4
ei11dGlscyBcCisgICAgICAgIHpzdGQgXAogICAgICAgICBjYS1jZXJ0aWZpY2F0ZXMgXAorICAg
ICAgICBsaWJjKysxIFwKKyAgICAgICAgbGliYysrYWJpMSBcCisgICAgICAgIGxpYnVud2luZC0x
OSBcCiAgICAgICAgIGJpc29uIFwKICAgICAgICAgZmxleCBcCiAgICAgICAgIGdpdCBcCkBAIC00
MCwxMiArNDQsMTIgQEAgUlVOIGFwdC1nZXQgdXBkYXRlICYmIFwKICAgICBkcGtnLXF1ZXJ5IC0t
c2hvd2Zvcm1hdCAnJHtQYWNrYWdlfV8ke1ZlcnNpb259XyR7QXJjaGl0ZWN0dXJlfVxuJyAtLXNo
b3cgPiAvcGFja2FnZXMudHh0CiAKIEVOViBUT09MQ0hBSU5fSU5TVEFMTD0vb3B0Ci1FTlYgVE9P
TENIQUlOX1JFTEVBU0U9MTIuRGVjLjIwMjMKK0VOViBUT09MQ0hBSU5fUkVMRUFTRT0yMi4xLjAK
IEVOViBUT09MQ0hBSU5fQkFTRU5BTUU9Y2xhbmcrbGx2bS0ke1RPT0xDSEFJTl9SRUxFQVNFfS1j
cm9zcy1oZXhhZ29uLXVua25vd24tbGludXgtbXVzbAotRU5WIFRPT0xDSEFJTl9VUkw9aHR0cHM6
Ly9jb2RlbGluYXJvLmpmcm9nLmlvL2FydGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZv
ci1oZXhhZ29uLyR7VE9PTENIQUlOX1JFTEVBU0V9LyR7VE9PTENIQUlOX0JBU0VOQU1FfS50YXIu
eHoKK0VOViBUT09MQ0hBSU5fVVJMPWh0dHBzOi8vYXJ0aWZhY3RzLmNvZGVsaW5hcm8ub3JnL2Fy
dGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZvci1oZXhhZ29uLyR7VE9PTENIQUlOX1JF
TEVBU0V9Xy8ke1RPT0xDSEFJTl9CQVNFTkFNRX0udGFyLnpzdAogRU5WIENDQUNIRV9XUkFQUEVS
U0RJUj0vdXNyL2xpYmV4ZWMvY2NhY2hlLXdyYXBwZXJzCiAKLVJVTiBjdXJsIC0jU0wgIiRUT09M
Q0hBSU5fVVJMIiB8IHRhciAteEpDICIkVE9PTENIQUlOX0lOU1RBTEwiCitSVU4gY3VybCAtI1NM
ICIkVE9PTENIQUlOX1VSTCIgfCB0YXIgLS16c3RkIC14QyAiJFRPT0xDSEFJTl9JTlNUQUxMIgog
RU5WIFBBVEg9JFBBVEg6JHtUT09MQ0hBSU5fSU5TVEFMTH0vJHtUT09MQ0hBSU5fQkFTRU5BTUV9
L3g4Nl82NC1saW51eC1nbnUvYmluCiBFTlYgTUFLRT0vdXNyL2Jpbi9tYWtlCiAjIEFzIGEgZmlu
YWwgc3RlcCBjb25maWd1cmUgdGhlIHVzZXIgKGlmIGVudiBpcyBkZWZpbmVkKQotLSAKMi4zNC4x
Cgo=

