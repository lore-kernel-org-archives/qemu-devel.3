Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAA2CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncw-0002r3-T3; Mon, 22 Jun 2026 19:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnct-0002pg-Kr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncr-0002R4-R7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJavx92205271
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=; b=GR0HDKB6p4bKluwK
 P8/eduLWcXXVttBRHPRUjP390FNLV7vBVKp0QFKmSalUyXpMJfagTlbkjvHs73vy
 FWpur+0y1ba35QnuVEruJ0ZJOGGRZ5ye7TB35axNqThyfXXiDx+UdWhNd9uGR8YB
 jLCHT4cxB69ruiKpuq7BcLxrhT56t0SFJAftQHfwXV3TBOHS7ziJYVT6Yv7mR8QM
 BcQomD7tqEZqD3L91LnpU62wbjNIJEOXgnBZMg6wYsAW+mrc3ji+0Y4Mra253XqB
 yvuqiDCEg1TUVAYaOHfBx3T3lwO8lBRI7SsE6NYO5emhExnKJXHCwCBJ/jP1IStE
 2hWD6g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsrfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139c6673856so69663c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169220; x=1782774020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=hqN0h4xdGm6ZjuTnvHr5oAOGpR/x/uG1R9lEaAI1Lz172RINaN/nxd38EORHDt4g2c
 9on6B+KcELFMz9lkM2mAz2l1G3XvazyWV3U0834v1TiciHbGhQTsySf2RnZ1ZzlCQLDw
 pJ2PDjPB/Pjzk422l/tZtZBniQbooE5gxV86DE7wckz+/2wgZH4mE3Wu42OVaI1y28Vj
 DKqUjFtFIBjU7a+y28NH/w4Fz6l5jWayvW0LxnlQVBp8P8yFOm08gcCaUyX0ALvKqbVj
 02P2fSublnr+OebQfZu+ZG/XRtxm2UKrk+3TbDLUyJtuAs4hM3mje+hFo8qfyJGi83lQ
 1LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169220; x=1782774020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=GoOVtqGBw/C2FOpzMg1Q09O/7+SiZZDt6SOfOitxylnaODnxttSQmx8eE9dP8MdSH7
 AfpzdF+3kRG2gpRQdQY4r/+HVqjFzGyilZ+FvnqTi1aeH1pdhv/+PvAeqjw4gPR34Tjo
 Bashc4ATF25CV9y/1o3hQb6RfdATJAzYXD/1INL4wuoAiT9U5kHQn2iaqjWcjRv/tlAj
 MyBQl1FhElQAlz3jkZjJZNu+THZeXPcCXCs8BtpKND7lXF9B6WesvAclyOEcSdEBCn77
 wJMPOT0o9pMcIjbfnNOna0elDb6VxGxZOpoKv+bQvXQEwAYeyN3aFAvawiBsTuZoDDPK
 +krg==
X-Gm-Message-State: AOJu0YwlpPsWoPpbCNB1KL8uDYHW7yexii1ID4+S9D7llkkFj9dUeLod
 /Gfgtxbx1dXKjjodX3AiSdgWfzObSx/Uc2uIQzi5gWz+nf9gSr8AcTYbJBvlEkr+2FTTS9ElRSX
 qszRNfc6MpwjJSwDxedSVgN6okbXMpXP3UUXSPGY6QohQpzkwsQctq6q0LjdDrvdtMw==
X-Gm-Gg: AfdE7ckucTtS+bPjsB+5Cu31BnZ992M0RuyA0t3uPfM5BYwheiCusc9eWW/UYvCt5tQ
 kXXq3N6J5h+qkj+jSyfLDwPSbdBzEL5henpW6FtKzrS244eberXL2DVqV0ePJmt1ClKuPjrVXiM
 9blzeEQn1A70drr3asrVpGCTt39cYlRjj4yAOdSpdJOevnGG5jVvqcs88B76RU37GumRX+aHv6g
 EyCu2Nk9kWE8cK/unQiwoIRB3i7yE8MAJR0cTb1tsFFTnWP9SXBmR6dPMdhiuQ/r6cWViN5uxqE
 yzE5VPMeTvUZV563D8MH9yZCLfZdIsuS3JFHMrrHMLjuk+suwTETxoqmzDOVRYBMoy7qHUkQfyc
 xJxWC83YjYkkQofkNuR41CktoHAnlDf4Zh0kRt42u24wbmRVrTHZlOllv4wA=
X-Received: by 2002:a05:7022:68d:b0:130:ab68:2b7c with SMTP id
 a92af1059eb24-139a2035e45mr8697007c88.2.1782169219806; 
 Mon, 22 Jun 2026 16:00:19 -0700 (PDT)
X-Received: by 2002:a05:7022:68d:b0:130:ab68:2b7c with SMTP id
 a92af1059eb24-139a2035e45mr8696985c88.2.1782169219187; 
 Mon, 22 Jun 2026 16:00:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 48/75] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Mon, 22 Jun 2026 15:28:37 -0700
Message-Id: <20260622222904.607771-49-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX1V9f2UZfprDM
 F57NIrkbQL+2+GFHKQjfH4SirN+g2LjG+Mo45Yj9hpswzzRJAve1P6yvjsuTQ5tvSMCax5bOdlT
 rIqcY19RTm6tMcFt2EteRZ4tbCVCEXo=
X-Proofpoint-GUID: Bhp_gVJ8LLGeIuIRs93lHwr5go0P9sKi
X-Proofpoint-ORIG-GUID: Bhp_gVJ8LLGeIuIRs93lHwr5go0P9sKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxdEASIg8wYaO
 wapKLVyiWlCaN1YAMgXAiXInT2cCIgz3y4vMeyow/stoszcHdtu5lXTdYopcu5r/WoPpjgFNaZG
 LGNLvl2OdzDT95IMDIb2sk40Ln8h30YWnx4nSFU6VWJgaGa1BYQ+NlVmKt676xse3crOr+Drjvk
 c5TibCWE+JsY0c4+8e+7EVYSwWNSFn34a8c6jRznwZeEE0tzXKd+lHyxMVZaperWAVVMMuR7A4P
 1DjJSWmHHZfjy2p258JD0DiPq6upMlEOg2yUYg1bLDqpQ129MSy2EvLxwG98MX+pRyTluCrFR0l
 MJZJzXoh0SUi9UcT5w5tOGfHLxYfZknTUnARetKwsrsAtxRRPIKRvazfdf+NN1bbmI264whk78d
 tfb2f0IZFHwlYlauzNUukl+ce8zYfEYxi1lSToJTZtSBnvzacY9241iyL19R8Gz93B8Gh7Setf8
 /lTIM2YmdbJ+pOeqdWw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39be84 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MGQ2NTUxZGQ1YjYuLmVkZGU0YjFkYjg0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk1LDYgKzQ5NSwxMiBAQCBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhhZ29u
X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICByZXR1
cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29u
X3RjZ19vcHMgPSB7CkBAIC01MDksNiArNTE1LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBo
ZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRl
eCwKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBo
ZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9w
b2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAogI2VuZGlmIC8q
ICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

