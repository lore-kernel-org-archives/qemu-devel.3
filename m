Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3134CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifQ-0003rB-MZ; Fri, 19 Jun 2026 19:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifG-0003mk-Mb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifE-0007Oy-FD
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYGe31252439
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=XYyO8XqODDnm5tEl
 hRDugpzlsjr3IzGIjXATS8/W+IGt4+jTrTA8ubpKAcMYUcaqYgmWfWg9IVVPeVqt
 3F9TABdFgCmB8Qyphv45Gf6O8CHCoKmlvT502VZLjPdvhem8Z31cdDVOrqqEZ+8h
 XGEu1EwltSXjnxkJbj/1ijqnKdLvPKI+fniWa4BmRy5CaMDXFRxv5o3IVBDFnGId
 hMA4iTIGXNXl8EP7k8SpPwHO73nwHLksLgYgQfHgfc7fy8kzEGjAwcY0yE5jcuXj
 1/jcWldmfNHaed2LU5oH6Uc4lAnF149cGIrLkFBcOVEELBI1s6GUkBrpDfbGHA3u
 4XsL+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8q6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c108c19d4so1107612eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911818; x=1782516618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=hx74zGBfetlB0eRKfX2owBUwSZwOR20E7itzRN93Vk0id1nYa54Ko7waQ4OUDZHZln
 wHBvufSVEAvQ6fxZFG5X5or7ABs5cK21EizQWneM+B/Z21vW5ToGSbs/SyHKwcUKepbG
 TvbojzpHlEpixRVtZBVuXzsJ9n9RLhk7FQvr6sHmhYHm7VuVX7U6ZRxCxO3uPlBFuUpe
 mcfluQZnuhlSvQF6ikbaV7bmgJNvKsHQY2NUbppMVfWj80zIN5+6kh1WezyAt+jtIYTp
 5G9lWnexEqwyUc0U2cT0p2U6BROd39oNCKmtJH4I0HKadqTZmcr18PD7mGZa/AYg5rBU
 tqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911818; x=1782516618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=rbCjAua7LyznKSsiVf2dVAuCx7bXQdN5zvZQx/F+xFTalYBp8gP2dIxcAvqhCLfeaD
 QWvSIqw0rzpPxVsKMsHcN00K/8sU3qfrbRfZeU7ZVpn/6PNZHaLJQDv8cTz9rRpzxKAm
 xTJIp/mMD/3dWf0QShWpQb1HEGIU7sxZHfwe+EwwsOPYy8nT1VVJ72++V6TKuwYS3/cy
 MFMGpINADzBZb9R3DW5gB9xbbziUD6/5bUkQ2+Dc1Y6Wc8eyUGQavRLWi0JzFemPXwbu
 CaVmgbSTb8y7CPh8rM4qpjqcA5jNK+2tX/j0QljJwfXGr6XtW7BE0dVh8pMOiQXnFHGU
 khAA==
X-Gm-Message-State: AOJu0YyGNhjZu0yhDYEky4ib1bCWhB+EmoeaiiufQGCbks327cln6oLk
 EEzEXhnKw6dw0LqvF37Iy0t25VmGNszvKVHj8GcJltuEchBLr6tPPZUSQjhh/oeEgYI2UEenaJA
 pRmiy3cIbFatDPDRKCq/mesNJgjsNAJWWu+D/whtSsFMfRNQ6ylrcQjD32GrsQJnhFQ==
X-Gm-Gg: AfdE7ck39cC+DONUXbvCmTkhShl0M8G6KsEKnsoz+7HPUhUeazOwdUoJoSAjbJrgJ2f
 Q4gOETF1czRMH/tcHJhugrOfx3x+u2K1jDC4pRtHX7L8MvIfkRSEeXh9MwyM6s8jzuTsdteGU+R
 VWWBddY85qWJbwwshalmaaC63aH/rT7DPrdApmM3yDDENuVzMZyB1itIygToNnrHD6h0mtcvrCd
 tO2lotvXy4OC15OQxBiTLaJNip2fdZhCihPAppzp5xoFlA+3zTvQbbBWRxnEmt8MgfMxNl0GOHK
 8SEaL1n+Qmg5KEZ71MuIj6vkb7AC75ojmsvnyPZxYhVmfVR2tGKBlIBX/7AeqFOInZLQZ14kr5l
 i9spXXKbQvai3hc2Yyq+llvfEbjYGElbj+Kx8xI/TxE2bL43epqirCdhWZi0=
X-Received: by 2002:a05:7300:a987:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-30c06e0dff9mr3018783eec.3.1781911818252; 
 Fri, 19 Jun 2026 16:30:18 -0700 (PDT)
X-Received: by 2002:a05:7300:a987:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-30c06e0dff9mr3018752eec.3.1781911817682; 
 Fri, 19 Jun 2026 16:30:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 43/74] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Fri, 19 Jun 2026 15:58:40 -0700
Message-Id: <20260619225911.159473-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: s2qmbSEicOi66KK-HdJqSEWnF09S7ixp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXzMKBiCXscywe
 ORNCJZ7x7LB6s1h1H7DyVpwaNSiGBhuJ9UmVIliSIMZOZjRrfVszevvQ+kM7zfMmkwkgOQjfZ6v
 oofOvZBZvhefBEveJaJeCnFME8MpCWaVveuWUjCnG8mo85eEDGDg8oXIo8/YYcUHtpAj3VvGw0I
 B5yu1iCyG9OYU4vvfGPDedunIcChQ9TkQy6uL31KGokkJNDmPHWkrWHPKIjjt5Bvb5jVuZoorJp
 b6MsTiR1YQN3LSZhkJoyNYZWzVoFknlxMrH42ekxtxL66aXayeF2EmiGzfxBUpnGxB/zGCi3LkB
 w1bQxf4nB7EUkAFiIDEnpO0246HvEbbpDUCy+PG5nJ2QejUk8a4cMGBA0ZSUgbk9uav7j917vnL
 GUTCOsy3gkr1kbKaQnHhhy+xqC8UvUYlnDOTpisdv4jo4CwLweLrbsdplpOetBelvBeiOHlURpR
 DFzpYduOsRJZJqL1YGg==
X-Proofpoint-GUID: s2qmbSEicOi66KK-HdJqSEWnF09S7ixp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX0rieNwBfLQeS
 8eTgXjB38c2qszrjOs2jIdCmGIrNfI1enphHFObEDGCAOXrUqMr1HVQzDUhDoFw+7y06FRCfAHK
 h/wHkuFtmLt1e3WUCTYUhrHHv0++v6I=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35d10a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

