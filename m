Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB371CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bm-0003Uh-Gr; Fri, 29 May 2026 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bl-0003T6-R8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bk-0000Ps-4p
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2HLc198947
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=; b=UdS6nrWTR85i1H7R
 5zp+TlmEemr7AIluhiNpPT9rEfVdhDDkx3yOaVtKY34UUMmcZZ6vWpQl8cRX4Qc8
 mc/WgfzprHMn9oLQR6q2+jnAChV3MSAGRN21aEry/rwSrpd1lquTZo7lY3iOo7C1
 2mJQHADNzLVERwIpl7YET+VxFWhG6DjZNvyljNrdpe9pqz0SjkP9FUEHLAKgnXAI
 ynwvQ1VoWBrs8lqQ9U0fZEuuirySmmMGpCHF7ueV0MoKi/K+deL92GV++UGMiZL3
 ZShN2US1z9u8a2gUwwBq2upMFoBeR5rXjmIExayyYCL6SpDUAJibbL9LpCxEtn1e
 51AhkA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnhxn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ed777a96so465711eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091778; x=1780696578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=;
 b=CDMASmRnqACoUP7BXCiu0gvDd19XHczxtdVGfJ7OyAWwtL0jeRMYlDAnjItG9B89bb
 HnORQX+fhzL3kbwpDUkz0P1aONKWCq1kHtLKBd2xqJaSybFg3N5oLFwc3MtAqfyv5iqm
 tCqFjBNWgsdrryl43UY132FuguvsvKyIoLw7/bqx+Da9cZDTdtwRz/BwKU4u7l/HIGbR
 kH9v9Ohqlu1Q0QHdy4+JkEkh097TbNy4o1lpwYS/aH9wcVTUPtakLTNHFd0HGOYDe+J6
 wWIr3tkML87Va+1j6Ddn1Mn0cUtwZ/zTD54pY/1KavnBkzNrnWi4Zx1t7QQENoN+9iE/
 SKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091778; x=1780696578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=;
 b=sovQmBqVTTURlBOEvEMo2NtLnErcCjc2KTNziilSUg0tG+6yXJUcRrq7by52UQEcrq
 4DedW2c5WH+YLyQplbue4Wx9tlh6yJgQBWq+7MCqSG+7MTntlmcWwX6zLrfNFXnoujFp
 kL2C+GIKfE8Pk33sr/oSH4H4aqKp6o7RELIk813tUXN8ngA7c0Ee1YFVwqw33pVmTR5T
 Idgk3wn5uAZIaerwCVKUUWY2ub6H73jRfoODhbVXE7Zt1HQAw+rCk6ult/9rxKmoF/Ie
 bqYqsX0p12US55Ch/fsREPWu5WuuSJqEWCYc+9etr5AMsTVEhMnbOlTUnfVmYwvo+QnY
 SNvA==
X-Gm-Message-State: AOJu0Yzp0+BPHdk9MwGJUSNCmwHG3DjSNu+nxkn14A1MTUDJwHM4McU0
 458+UEZTSvj8faEB23YFhpZOFLS8P7a7kmgWk6ESTSV/7XKHPoEyo16K3vpRVBo2sUTWE+YrXI4
 SJupmYnAKso3Tb8VhTOwXtufhgPQXjCjDiqnDFttD2+hOHihgbGx1qgtzFs4faNNNTA==
X-Gm-Gg: Acq92OFveOUP+J2T+R7pQDrsgF+W1R7pG/nKmfTx1G5MtmsUWxL7ec9BJsNem7juTZb
 F1/zfRfLqzarx22sQFefeqhoDF9kAzHPx8YVidTBizbvF5dpHhP0/UNN6O9ZjLPiwMtyRg46fdf
 62lMVmLM4ec2/CfYXdwGCk301sao9/4cNNtLqgqgmtYK2xiHk8yrD1Vr/R4lgOZB7+HrqP9GQvt
 iep5bBaAnsLUdv7ej7GjUBHH7F/53BRCPtdL117oE9+HEpV1lqh5U3xSKpfm3A0aWId0lI0B7sx
 uq7/nK9zsIp9sQO+vxI8Nu7bCDdv930eLgJLKOj9BlZDgUTM58JJpapWiQQIEYExpAsMByU5pyr
 uNa+QdfOJeBOQ6BOSDzd/B8C3C1ynz4jbSbyu5RILC6O9cwWHHyz/mi1/uEcwnNoUmMRUGEa7la
 wiZ3ZC
X-Received: by 2002:a05:7300:d508:b0:304:705f:e4d8 with SMTP id
 5a478bee46e88-304fb2ee1ebmr529653eec.16.1780091777918; 
 Fri, 29 May 2026 14:56:17 -0700 (PDT)
X-Received: by 2002:a05:7300:d508:b0:304:705f:e4d8 with SMTP id
 5a478bee46e88-304fb2ee1ebmr529641eec.16.1780091777397; 
 Fri, 29 May 2026 14:56:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 11/38] target/hexagon: Add guest, system reg number defs
Date: Fri, 29 May 2026 14:55:27 -0700
Message-Id: <20260529215554.606133-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX6tg0b9G0Aj6i
 cWmP3wKnfHkzGJ9Ph8CTtp6E5iIm9hqOk+M0U0w7T4dPQ8wB9tGvVmow1IdgVvlFXmKJwZcHn90
 +HgmebdH3esUJVcyciV9D5C0caUtQoSKyJFSwXVxVVlXQj5ZiE3r8JPu5wgaEChR1EQupX89Rpc
 xEHvlB4UUa7F3RqamTgL4xAOS5G5W2RcnLh6Omzh4uH0vK3/WQFb4kbQ9rQ6casnBGxdMpOe4KW
 g+ZHWgU9SJkt7acN92O/4xGHakdoRh9bPAKsimJGztrJOgkk7Ud0SyXcR4OP2F4f7vKJvWd2ESY
 7bCtdtd8eWjjuhQCQwRnaCLfiatD4wWkZP39/3zc0D8/wS5t/HbEaRoWsjtm0HMvYN0ay9wNrsP
 7sMPWxHvcvEj1fmMcDQ2eg2f5nu8O/1HGMdbAIlA8BwH4gJ3laoS7KlmXZ7zwaLxpUPNxOvSHkV
 94hmHWx5RnX9coKtE0A==
X-Proofpoint-GUID: Lui7ZLuVhZcVYDiZ6vshusAVqHnpQ8aS
X-Proofpoint-ORIG-GUID: Lui7ZLuVhZcVYDiZ6vshusAVqHnpQ8aS
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a0b83 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgIHwgICA3ICsrKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggZTIyNTY3ZDhlNjcuLmUwY2Y4N2U1YTRjIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMjAs
NiArMjAsMTMgQEAKIAogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCIKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE5VTV9HUkVHUyAzMgorI2RlZmluZSBHUkVHX1dS
SVRFU19NQVggMgorI2RlZmluZSBOVU1fU1JFR1MgNjQKKyNkZWZpbmUgU1JFR19XUklURVNfTUFY
IDIKKyNlbmRpZgorCiAjaW5jbHVkZSAiY3B1LXFvbS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWNv
bW1vbi5oIgogI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X2xvbmcuaCIKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2hleF9yZWdzLmggYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCmluZGV4IGJk
ZGZjMjgwMjFjLi4yMTRiN2I4ZmRlOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X3Jl
Z3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCkBAIC04MSw0ICs4MSwxMjEgQEAg
ZW51bSB7CiAgICAgSEVYX1JFR19VVElNRVJISSAgICAgICAgICA9IDYzLAogfTsKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisKKyNkZWZpbmUgSEVYX0dSRUdfVkFMVUVTIFwKKyAgREVDTF9I
RVhfR1JFRyhHMCwgICAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0VMUiwgICAgICAgMCkg
XAorICBERUNMX0hFWF9HUkVHKEcxLCAgICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHU1Is
ICAgICAgICAxKSBcCisgIERFQ0xfSEVYX0dSRUcoRzIsICAgICAgICAgMikgXAorICBERUNMX0hF
WF9HUkVHKEdPU1AsICAgICAgIDIpIFwKKyAgREVDTF9IRVhfR1JFRyhHMywgICAgICAgICAzKSBc
CisgIERFQ0xfSEVYX0dSRUcoR0JBRFZBLCAgICAgMykgXAorICBERUNMX0hFWF9HUkVHKEdDWUNM
RV8xVCwgIDEwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzJULCAgMTEpIFwKKyAgREVDTF9I
RVhfR1JFRyhHQ1lDTEVfM1QsICAxMikgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV80VCwgIDEz
KSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzVULCAgMTQpIFwKKyAgREVDTF9IRVhfR1JFRyhH
Q1lDTEVfNlQsICAxNSkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ0LCAgIDE2KSBcCisgIERF
Q0xfSEVYX0dSRUcoR1BNVUNOVDUsICAgMTcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UNiwg
ICAxOCkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ3LCAgIDE5KSBcCisgIERFQ0xfSEVYX0dS
RUcoR1BDWUNMRUxPLCAgMjQpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFSEksICAyNSkgXAor
ICBERUNMX0hFWF9HUkVHKEdQTVVDTlQwLCAgIDI2KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNO
VDEsICAgMjcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UMiwgICAyOCkgXAorICBERUNMX0hF
WF9HUkVHKEdQTVVDTlQzLCAgIDI5KSBcCisgIERFQ0xfSEVYX0dSRUdfRE9ORQorCisjZGVmaW5l
IERFQ0xfSEVYX0dSRUdfRE9ORQorI2RlZmluZSBERUNMX0hFWF9HUkVHKG5hbWUsIHZhbCkgSEVY
X0dSRUdfICMjbmFtZSA9IHZhbCwKK2VudW0gaGV4X2dyZWcgeworICAgIEhFWF9HUkVHX1ZBTFVF
UworfTsKKyN1bmRlZiBERUNMX0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisK
KyNkZWZpbmUgREVDTF9IRVhfR1JFR19ET05FIDAKKyNkZWZpbmUgREVDTF9IRVhfR1JFRyhfLCB2
YWwpICgxIDw8IHZhbCkgfAorc3RhdGljIGlubGluZSBib29sIGdyZWdfaW1wbGVtZW50ZWQoZW51
bSBoZXhfZ3JlZyBncmVnKQoreworI2lmIE5VTV9HUkVHUyA+IDMyCisjZXJyb3IgIk5VTV9HUkVH
UyB0b28gbGFyZ2UgZm9yIGdyZWdfaW1wbGVtZW50ZWQoKTogdXBkYXRlIGBpbXBsX2JpdG1hcGAi
CisjZW5kaWYKKyAgICBzdGF0aWMgaW50MzJfdCBpbXBsX2JpdG1hcCA9IEhFWF9HUkVHX1ZBTFVF
UzsKKyAgICByZXR1cm4gaW1wbF9iaXRtYXAgJiAoMSA8PCBncmVnKTsKK30KKyN1bmRlZiBERUNM
X0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNlbmRpZiAvKiBDT05GSUdf
VVNFUl9PTkxZICovCisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZW51bSB7CisgICAgSEVY
X1NSRUdfU0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisgICAgSEVYX1NSRUdfU1RJ
RCA9IDIsCisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JFR19CQURWQTAgPSA0LAor
ICAgIEhFWF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NSID0gNiwKKyAgICBIRVhf
U1JFR19DQ1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAgIEhFWF9TUkVHX0JBRFZB
ID0gOSwKKyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9TUkVHX0dFVkIgID0gMTEs
CisgICAgSEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NSRUdfRVZCID0gMTYsCisg
ICAgSEVYX1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZU0NGRyA9IDE4LAorICAg
IEhFWF9TUkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQgPSAyMSwKKyAgICBIRVhf
U1JFR19WSUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAyMywKKyAgICBIRVhfU1JF
R19JRUwgPSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAorICAgIEhFWF9TUkVHX0lB
SEwgPSAyNiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAgSEVYX1NSRUdfRElBRyA9
IDI4LAorICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVHX1BDWUNMRUxPID0gMzAs
CisgICAgSEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JFR19JU0RCU1QgPSAzMiwK
KyAgICBIRVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVHX0lTREJDRkcxID0gMzQs
CisgICAgSEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JFR19CUktQVFBDMCA9IDM2
LAorICAgIEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9TUkVHX0JSS1BUUEMxID0g
MzgsCisgICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVYX1NSRUdfSVNEQk1CWElO
ID0gNDAsCisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAgIEhFWF9TUkVHX0lTREJF
TiA9IDQyLAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBIRVhfU1JFR19QTVVDTlQ0
ID0gNDQsCisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhFWF9TUkVHX1BNVUNOVDYg
PSA0NiwKKyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVYX1NSRUdfUE1VQ05UMCA9
IDQ4LAorICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhfU1JFR19QTVVDTlQyID0g
NTAsCisgICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9TUkVHX1BNVUVWVENGRyA9
IDUyLAorICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZH
MSA9IDU0LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAgSEVYX1NSRUdfVElNRVJM
TyA9IDU2LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBIRVhfU1JFR19QTVVDRkcg
PSA1OCwKKyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JFR19TNjAgPSA2MCwKKyAg
ICBIRVhfU1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2MiwKKyAgICBIRVhfU1JF
R19TNjMgPSA2MywKK307CisjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8KKwogI2VuZGlm
Ci0tIAoyLjM0LjEKCg==

