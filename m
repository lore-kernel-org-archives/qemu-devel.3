Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4702BCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndX-0003Bm-3N; Mon, 22 Jun 2026 19:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndR-00038V-Il
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndP-0002bj-Lm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZcbD178952
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=; b=lZ
 4FknOHznsOIzR8xmZL4O1yy71h9lPw3Nr2KOoE6f0GCR//opTBLcS+3yKDQB9c3y
 vZklzCVGe9MXIQukwX8KYJWrKDyJMJWU68/hEKo8YZf8w1EMXKyxiLyzx7xaO0MF
 VI8iz0co+8fgkClFL5kJfAKlKAsMi6hJY3fS0axXLKA3xngVRg2UVNZn7R1evOy0
 IR47lnUvtaDQjdNkjbDTKBVopUY6/u7n36YL2pUSh0SuiRmKlR/M1zU8mwNxRYPA
 wD4UVgfcjyKyMZ60nG4ODqvAiowtfHu9dR531s/+fG0B93vGHR/zleJxgQ+GirzE
 Ca4SzAEDLPCWFuqSliyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhtmpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c5319332eso1116999eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169254; x=1782774054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=EA8BWENTebiA8hNAyshUJTrDA5YG6pcC1F1bp0zCZGs8Y5KIS0ZJsH3ZszilNbZc/R
 TifOWlglYHq7t08HZkDHSTRJHy9eliNugxWn3ICNmZ2UMm0O3igjHn6SK02rXjk7c4mP
 7P9Xz3ai2GRyILO9cEmnEU/AGk1zZXNwBQnm5Mj4IV/kgOeKHV4yILFaIBf+grjsRXMB
 XN3E0nzPHP+EgOG4ELFCfcSmpVqML00Qm21qxAEY978F/PD1ekb3b38ZBGBufV3T4xJ6
 BsFALuqUEc4YJFequgI7Prv8BQVjzH28m2/Iuw+V0jVZa5OUgjTgpvfWUytkC222MVZk
 7bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169254; x=1782774054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=ZIg+K8CfFZh92tZz+Qr++kTZP3tYqx/PmpdV6w7dAfDJPdNwP8STHUN1rYlR7IFjlf
 SB75l5ZZ94X8K5l23/J4isYOvLLICmrD79rKL7lMqfe9Yi41yvR4sILc6iZn+61aWISd
 aUfRBWLcQJPx1/gYmdBIWYwHv1KOuKQ9IboNNmL0TzBHWv+VEOgBN1vV6Au4dFG+G4vX
 osKEr/UP4iVqrI8ygPTD07mnIlU6c32Ds8xpChpNBPvmXZHRCjQRP3q9mFiuw8Q+Wz/D
 cvr9enR72HZ80D4Y/xDLsRstVq11ckwr4EFQCQ+NDg+g5oqfNhJtkX0hWkhm6bpdF/OF
 k+PQ==
X-Gm-Message-State: AOJu0YwVPjsgV/BQ6UPzXMlJw4InLGbn9e3Dqt5uLXT0MCHLhKNpK7yy
 hdCbTHRPaw55h87KTnUlKmqTcSyOFUhBSmrOjqnuktOIjabLN7l8IN/iQhltEVcI1gxQTU/5/Up
 KY2HY3DhvMjmwLhZbXynMaF007PqtxZlqlqJ9sl+L/HzeGfMKk6MhUMNXCQ38UXID9w==
X-Gm-Gg: AfdE7cm5ao8OG+UnecGIhM1jEgWeQbhK/1++Gb45wRMkvjdJMmqbrlK0prmYCCjrmY4
 bcKnoWyQ1J5z2SDUVH2xCWkyNpS6TAQ2E3SQCJXq6gdy+NBTJjud0OlVNEa/qROgibR4ObIQnVw
 JqHMstGZGxQJ5ui+e4cpnlBE76GwfbMOl15mWqlAzh1wWzoFHZPxZd4KgaRNRRKfjMHuMcxiaJk
 gyD97BorDpXyTWJzy2qJ5IgX+qx45sem72T/Gd3kZVo3RKFs/HuAQect+M1G3JvQ0YW0efaZd9z
 ortfyLm28VC0fImOtjrY9nds/B3JA1drKvmwun9GzYLPrBJexoWJKMl8vOigHqxmhI8AsU6+Hot
 zpd22Ai/PPZ3B7Au5bnSCLWpGbxKbLZuVChLBxIjOZM0CScQkyz0MN+5ahsU=
X-Received: by 2002:a05:7022:490:b0:137:567:14c4 with SMTP id
 a92af1059eb24-139a21526c7mr9086246c88.29.1782169253334; 
 Mon, 22 Jun 2026 16:00:53 -0700 (PDT)
X-Received: by 2002:a05:7022:490:b0:137:567:14c4 with SMTP id
 a92af1059eb24-139a21526c7mr9086218c88.29.1782169252680; 
 Mon, 22 Jun 2026 16:00:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 70/75] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Mon, 22 Jun 2026 15:28:59 -0700
Message-Id: <20260622222904.607771-71-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX4AplawrFg+qG
 ZI4hms6lZcAKnJkt6mCgsfFSG7cmyVq0VWhqN/wOJOsviOicrWeSTRVZkTwg/fyErP1hqwqZZwG
 cVwpVTyhUQJnMpkbKiqGbK3C2h7YSDE=
X-Proofpoint-ORIG-GUID: yRHiSLoPlE5Xg9J1POdEE7DtBMEFdYaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX3BWruv4l3IHb
 Y/hZ9BjJd/kzONf9R4G4hwBFQJi8LHX+baS2fdT4CpTWUY1uL/n4Y+jk8LnKwe2w9y40h63Ixe4
 76JQqB64L3t6J+3TFBuNHouQK8fgI7P2d8AsPs9aiM/+4Bj6P4OHoOBBqES5JPBWQ6Wn36+v7QU
 WT8OKfqPt7vXrn1Qx2DbxO5w2e6t8PSq2/IjwPpeadV31XapR9cYHULgjBlBzqE/N65oL+YKZ7j
 1Ywqgx5nZOe19/jXOky1Vc4WiecxKqEaieDB7yoIPXd3/xeAY6yRAjQepzHHLMd+HK8BPhhQKBU
 ZH5P7n9ZcjryXi9zyskC0bfFr91qc9dJaDUhls6C8hRh8FCmSkaTYIBlE48Cbg4ow3aatEDD5zg
 2g47bkZxejvB6/Fw9EKDpj+dNDJAlZ1B/ZiaHautsrlX/5pu/NYjBeF0mR0g1DnR4QcKNbGQ++e
 dEhpYE/UM6uRsHBr2bw==
X-Proofpoint-GUID: yRHiSLoPlE5Xg9J1POdEE7DtBMEFdYaD
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a39bea6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKwog
aHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgfCA2NSArKysrKysrKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40NDJjYmUzYmUzMQotLS0gL2Rldi9udWxsCisrKyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQg
QEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0g
eworICAgIC5jZmdiYXNlID0gICAgICAgICAweDI0MDAwMDAwICsgMHgxODAwMDAsCisgICAgLmwy
dGNtX3NpemUgPSAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgIDB4MjYz
MDAwMDAgKyAweDkwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAweDAwMDAxMDAwLAorICAg
IC5jc3JfYmFzZSA9ICAgICAgICAweDI2MzAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAw
eDI2MzAwMDAwICsgMHhBMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9i
YXNlID0gMHgwMDAwMjQwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDI2MzgsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4
MDAwMDI0MTksCisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwMjQxYSwKKyAgICAgICAgLnJl
c2VydmVkMSA9IDB4MDAwMDI0MWIsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDAyNTAwLAor
ICAgICAgICAuYXhpMl9sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jh
c2UgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwMjQxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRy
aWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwK
KyAgICAgICAgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2Ug
PSAweDAwMDAyNTAwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAg
ICAgLmwydGFnX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4
MDAwMDAwMDAsCisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAg
ICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDAyNDFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAw
eDAwMDAwMDgwLAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwy
aXRjbV9zaXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwMjQw
MCwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2Vu
dCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDMsCisgICAg
ICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLAorICAgICAgICAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9j
Ml9yZWcyID0gMHgwMDAwMDAwOCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAs
CisgICAgICAgIC5jb3Byb2MyX3JlZzQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9y
ZWc1ID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsCisg
ICAgICAgIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA2LAorICAgICAgICAuYWNkX3ByZXNldCA9
IDB4MDAwMDAwMDEsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmwxZF9zaXplX2tiID0gMHgwMDAwMDAxMCwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgwMDAw
MDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLAorICAgICAgICAu
dnRjbV9iYW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAw
MDAwMDEsCisgICAgICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2
ZWQ2ID0gMHgwMDAwMDAwMywKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgwMDAw
MDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MDAwMDAwZTAsCisgICAgICAg
IC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19sb3dhZGRyID0g
MHgwMDAwMDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9j
ZmdfdjY4bl8xMDI0LmguaW5jIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5p
bmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjgyNjE5YzQyYWMxCi0t
LSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
QEAgLTAsMCArMSw2NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY2
OG5fMTAyNCA9IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgICAweGRlMDAwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgICAg
MHhmYzkxMDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgICAweDAwMDAxMDAwLAorICAgIC5j
c3JfYmFzZSA9ICAgICAgICAgIDB4ZmM5MDAwMDAsCisgICAgLnF0bXJfcmVnaW9uID0gICAgICAg
MHhmYzkyMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgw
MDAwZDgwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJz
eXN0ZW1fYmFzZSA9IDB4MDAwMGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTks
CisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAu
YXhpMl9sb3dhZGRyID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAw
MDBkODFjLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAgICAgICAgLmZhc3Rs
MnZpY19iYXNlID0gMHgwMDAwZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgw
MDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAg
LmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDBk
ODQwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAgICAgICAgLmwydGFn
X3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAs
CisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNj
cmVnX2Jhc2UgPSAweDAwMDBkODFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgw
LAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXpl
ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwZDgyMCwKKyAgICAg
ICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAw
MDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5odnhf
dmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAw
MDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAor
ICAgICAgICAudjJ4X21vZGUgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFmMWYsCisgICAgICAg
IC5jb3Byb2MyX3JlZzQgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5j
b3Byb2MyX3JlZzcgPSAweDFmMWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MWYxZjFm
MWYsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF9zaXpl
X2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAgICAudnRjbV9iYW5r
X3dpZHRoID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5yZXNlcnZlZDUgPSAweDFmMWYxZjFmLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jYXBhY2l0
eV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgxZjFmMWYx
ZiwKKyAgICB9LAorfTsKKwotLSAKMi4zNC4xCgo=

