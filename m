Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA99C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3gH-0006zT-UG; Mon, 29 Jun 2026 00:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3do-00034A-Vk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dm-0001YG-Al
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NDGM1718813
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=; b=lq
 VH301jrJlNp44xJhV59FHu/Wkh0emOA3kxaimM/a7VHJunephivAhgkhUFhhTgWL
 AVW1Fp9GurAZR7Yw4FM9Wk7X1TV3MQUyQG3i0l2dFhaTdStys/lqK73/cZxLpys6
 nI+/Cs7KB55skUKqk1jrKvI2LwSvRqrCpX6OnWFvgPDtLuOjg+IoOmhZWVUxybYL
 HblgwxL/r8u+IS2u9iuekdOvQ+XIYgA1YUVg4v6E5CcKDZxYMf17phRQKHyQts8p
 7G3gkZloNhHUZ7bP3iss3z2ZN1yPn2JPOBepFxTzvDyCqaBvCn8dMpfs+sWc6bm3
 TKVbk2TP7N9eT4pl9Tpw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf4a0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso10829816eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707426; x=1783312226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=;
 b=CzUxznsl7hoI9Esi/EWDZbTp0Jor6/0Uv1loznXqVkR84gwjsUSycGBFPXOM+K9ihR
 bSzKzkD5KLJE46hLZ329zBuNK8j4ohZ1y5TYw1RedaQBkBWAJgeSXE45jEeW09Ns62af
 541k+NyWZhx8dq4JvKpOviIQt68to68YJPxz40W43ArjVpLsRnvJXmU4Dei2P+85Yqp3
 oewkTom+9Blq+lQJ8fsCXBYSzI9YfUXustBPH0hygtmgnBdMCMTxYJi+6qkczhYe3yA9
 /n0RIzOiS74V8vrtvfK39BdpiuJ3OhfGkBZhAclbZfijYNBFvmqjbNyNzjYQbio7B0cJ
 rJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707426; x=1783312226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=;
 b=J/WKEmbIK/rDizwS3qXnh9UoTZgyh5+B+IcyUdPZYr2itAsXwUTvb25cOFHu7oTOHg
 0i77bb52Jv1BzJfOEUTSvdF/57fGBkLhTm48cDva9g9H5Ixyt+coB7LvzrvmDAjgVZHk
 LZiqlw/QDiLZBZVH67PLtP1iz0YhJ/VNjq4bw6P7L560rBe+pKfOFXp8J3oV9CL2aaUc
 gkh1InxAxohZ+aaUzkptK5uo27mrAE839uY33bynmsN1GrejKbEODjiwg81nUwiKbpsh
 nVd8lyKj+soYe7IcSIsB4VBy07s1ArNiSp008w198xh2/uFNkzSHkE69WQ4CDG93lquk
 AM0A==
X-Gm-Message-State: AOJu0Yy1lfMoexWWRF71XQ94diYQINWasmLi2DTTKMulg+oPak3z5jZT
 hV0aeZT6N+8BscdW7rEZX0UWbg3vCylULXpshjKCp5CuMzFy8CW4H4OFrXwxe0eo2dGWuD+HH7o
 2wVKRrI6i1hxTxOgcko0Pq8fk2bzuQ+KErYF23IvacuTlMj+PbgRhzvs+majt+qc8uw==
X-Gm-Gg: AfdE7cmKvyhtUE04piNpzEm6qtklXCLZ5nINzK+k5bRf3MPBg5HrDh4xPpffk1zFA0P
 q2Dsis04mQCmNqbX6wF/eKC0rhH7w4SdGnapT5yRbah01agcXAiMWlVLUwkXd0GyCAcIsCL+ffh
 FCVb6PPp3gicKR/x6zxCyGAPg4P7dkfrLQNbSJkuwzvPYF0vGCzL/Z5WJWE/+rOBwZlHYX1yTv9
 zmW9jwqrloaV+hA4Y6KUMuImSr7CtUDtc8yz4zUDeDVrjO1TefLj4EBkLSA8M58v9zD+xcpHsfl
 YVDT4TVziZ87sJfgbV7XaeEAD9z0gsNWG2AN62qZGo/Y1f2aURMYQQKiIJOKQIlhdv/FLkDyvFG
 eInedzpOUIHPCzXm7S27yV711CIBbQqHMcf7b2kIsw7NUWBu79XUQSVnQ68g=
X-Received: by 2002:a05:7300:6ca5:b0:30c:283:9018 with SMTP id
 5a478bee46e88-30c84bfe0a2mr14016586eec.11.1782707426093; 
 Sun, 28 Jun 2026 21:30:26 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca5:b0:30c:283:9018 with SMTP id
 5a478bee46e88-30c84bfe0a2mr14016558eec.11.1782707425547; 
 Sun, 28 Jun 2026 21:30:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v4 75/77] target/hexagon: add build config for softmmu
Date: Sun, 28 Jun 2026 20:58:28 -0700
Message-Id: <20260629035830.1520296-76-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXwZNZTWSAs5Dh
 3ILEpVGenH7rQ5GkRxtg/pEh99QMYaYrHhTXW+vH5a0wkwARTbtnwNsKmacwDlmOXyG2kRFMuNk
 mtcAP6zxX1rY4xEEPhyVE/nTvIv0jHk=
X-Proofpoint-GUID: zjztOIhSfU5eVNf4lnM3xNKQofTiLAU-
X-Proofpoint-ORIG-GUID: zjztOIhSfU5eVNf4lnM3xNKQofTiLAU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5PKTDFSbr++w
 71xXmVU9cOoJyxE5sU97+ZdkzcuuEM+u8UsUdEgFPbETwd06PZP8K0D8K9gNr/ZOWvEQml9j+oy
 9XdPWDjLsrhc/7kNNV5tRSkG57JxU2IjZat/7ymC4+zuNNDiKa4gsmd+TMePyUplh5aMYK08XZh
 yWHk0IDKWoMPM87+1yi+OpYqeXKMT+K8H/xtI9z1VTGDpF4SUDtyIznG55GSnArjytah0Vh6ibh
 j9LlAKzzTZSgMR4Yf5LA86bk57vwKChOt/q4uk03JhuMMa/saeDx5etvFtyIz0sl7L6gDDAaOjr
 rDPmHuRzhIOJPb+cufY2OV5+n60dKG01d3ZFCzfse2T6w0bV2iISoQVSm/Wuy37EB6Ib6t4RF/E
 QtLtf2eu7XoP/asBN5RM1VJ0n8H1XkjneOHogkXxP0nnwSv6QQVzwr/MTgyBJKyN54YdJB5rIwa
 CClOWPkUpKMW9XqM3gQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41f4e2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=nnu-IgKveahPCV3q3nEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29t
bS5jb20+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG1haWxvLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrIHwgIDYgKysrKysr
CiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgIDcgKysrKysr
KwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstLS0t
CiB0YXJnZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFy
Z2V0L2hleGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrLQog
NyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL0tjb25maWcKCmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDM5OThhYmFlY2YxLi4zYjMwNWQ4ZWQwYyAx
MDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI1Niw2ICsyNTYs
NyBAQCBGOiBsaW51eC11c2VyL2hleGFnb24vCiBGOiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRp
c2FzL2hleGFnb24uYwogRjogY29uZmlncy90YXJnZXRzL2hleGFnb24tbGludXgtdXNlci5tYWsK
K0Y6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCiBGOiB0ZXN0cy9kb2NrZXIv
ZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCiBGOiBnZGJzdHViL2dkYi14
bWwvaGV4YWdvbioueG1sCiBGOiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKZGlmZiAt
LWdpdCBhL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsgYi9jb25m
aWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5mN2ZjODc0ZWIwYwotLS0gL2Rldi9udWxsCisrKyBiL2Nv
bmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKQEAgLTAsMCArMSw2IEBA
CisjIERlZmF1bHQgY29uZmlndXJhdGlvbiBmb3IgaGV4YWdvbi1zb2Z0bW11CisKKyMgVW5jb21t
ZW50IHRoZSBmb2xsb3dpbmcgbGluZXMgdG8gZGlzYWJsZSB0aGVzZSBvcHRpb25hbCBkZXZpY2Vz
OgorCisjIEJvYXJkcyBhcmUgc2VsZWN0ZWQgYnkgZGVmYXVsdCwgdW5jb21tZW50IHRvIGtlZXAg
b3V0IG9mIHRoZSBidWlsZC4KKyMgQ09ORklHX0hFWF9EU1A9eQpkaWZmIC0tZ2l0IGEvY29uZmln
cy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1z
b2Z0bW11Lm1hawpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZmRmYTI5
YjRmMzkKLS0tIC9kZXYvbnVsbAorKysgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11
Lm1hawpAQCAtMCwwICsxLDcgQEAKKyMgRGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29u
LXNvZnRtbXUKKworVEFSR0VUX0FSQ0g9aGV4YWdvbgorVEFSR0VUX1hNTF9GSUxFUz1oZXhhZ29u
LWNvcmUueG1sIGhleGFnb24taHZ4LnhtbAorVEFSR0VUX0xPTkdfQklUUz0zMgorVEFSR0VUX05P
VF9VU0lOR19MRUdBQ1lfTERTVF9QSFlTX0FQST15CitUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9O
QVRJVkVfRU5ESUFOX0FQST15CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRhMTJkYzA0NzI3Li43Njk0ZmQ5MWZhOCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAg
LTM4LDEwICszOCw3IEBAIHR5cGVkZWYgc3RydWN0IEhleGFnb25HbG9iYWxSZWdTdGF0ZSBIZXhh
Z29uR2xvYmFsUmVnU3RhdGU7CiAjaW5jbHVkZSAiaHcvY29yZS9yZWdpc3RlcmZpZWxkcy5oIgog
I2luY2x1ZGUgInFlbXUvYml0bWFwLmgiCiAKLSNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQotI2Vy
cm9yICJIZXhhZ29uIGRvZXMgbm90IHN1cHBvcnQgc3lzdGVtIGVtdWxhdGlvbiIKLSNlbmRpZgot
CisjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oIgogCiAjZGVmaW5lIE5VTV9Q
UkVHUyA0CiAjZGVmaW5lIFRPVEFMX1BFUl9USFJFQURfUkVHUyA2NApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L0tjb25maWcgYi90YXJnZXQvS2NvbmZpZwppbmRleCAzYzczZTNiYWUwMS4uMDI4OGEzZjQx
NjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9LY29uZmlnCisrKyBiL3RhcmdldC9LY29uZmlnCkBAIC0x
Niw2ICsxNiw3IEBAIHNvdXJjZSBzaDQvS2NvbmZpZwogc291cmNlIHNwYXJjL0tjb25maWcKIHNv
dXJjZSB0cmljb3JlL0tjb25maWcKIHNvdXJjZSB4dGVuc2EvS2NvbmZpZworc291cmNlIGhleGFn
b24vS2NvbmZpZwogCiBjb25maWcgVEFSR0VUX0JJR19FTkRJQU4KICAgICBib29sCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9LY29uZmlnIGIvdGFyZ2V0L2hleGFnb24vS2NvbmZpZwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uN2U1NTZmMzUwNjMKLS0tIC9kZXYv
bnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9LY29uZmlnCkBAIC0wLDAgKzEsMiBAQAorY29uZmln
IEhFWEFHT04KKyAgICBib29sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWls
ZCBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IGZkM2Q2OWZlZmZkLi41OWNiMDlj
MTA3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0
L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIzNSw2ICsyMzUsNyBAQCBkZWNvZGV0cmVlX3RyYW5z
X2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgY29tbWFuZDogW3B5dGhvbiwg
ZmlsZXMoJ2dlbl90cmFuc19mdW5jcy5weScpLCBzZW1hbnRpY3NfZ2VuZXJhdGVkLCAnQE9VVFBV
VEAnXSwKICkKIGhleGFnb25fc3MuYWRkKGRlY29kZXRyZWVfdHJhbnNfZnVuY3NfZ2VuZXJhdGVk
KQoraGV4YWdvbl9zb2Z0bW11X3NzID0gc3Muc291cmNlX3NldCgpCiAKIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdjcHUuYycsCkBAIC0yNTMsNiArMjU0LDE0IEBAIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogKSkKIAoraGV4YWdvbl9z
b2Z0bW11X3NzLmFkZChmaWxlcygKKyAgICAnY3B1X2hlbHBlci5jJywKKyAgICAnaGV4X21tdS5j
JywKKyAgICAnaGV4X2ludGVycnVwdHMuYycsCisgICAgJ2hleHN3aS5jJywKKyAgICAnbWFjaGlu
ZS5jJywKKykpCisKICMKICMgU3RlcCA0LjUKICMgV2UgdXNlIGZsZXgvYmlzb24gYmFzZWQgaWRl
Zi1wYXJzZXIgdG8gZ2VuZXJhdGUgVENHIGNvZGUgZm9yIGEgbG90CkBAIC0yNjIsNyArMjcxLDgg
QEAgaGV4YWdvbl9zcy5hZGQoZmlsZXMoCiAjICAgICBpZGVmLWdlbmVyYXRlZC1lbmFibGVkLWlu
c3RydWN0aW9ucwogIwogaWRlZl9wYXJzZXJfZW5hYmxlZCA9IGdldF9vcHRpb24oJ2hleGFnb25f
aWRlZl9wYXJzZXInKQotaWYgaWRlZl9wYXJzZXJfZW5hYmxlZCBhbmQgJ2hleGFnb24tbGludXgt
dXNlcicgaW4gdGFyZ2V0X2RpcnMKK2lmIGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5kICgnaGV4YWdv
bi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycyBvcgorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdoZXhhZ29uLXNvZnRtbXUnIGluIHRhcmdldF9kaXJzKQogICAgIGlkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5oLmluYycsCiAgICAgICAgIG91dHB1dDogJ2lkZWZfcGFyc2VyX2lucHV0LmguaW5jJywKQEAg
LTM5MCwzICs0MDAsNCBAQCBhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQo
CiBoZXhhZ29uX3NzLmFkZChhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCkKIAogdGFyZ2V0X2FyY2gg
Kz0geydoZXhhZ29uJzogaGV4YWdvbl9zc30KK3RhcmdldF9zeXN0ZW1fYXJjaCArPSB7J2hleGFn
b24nOiBoZXhhZ29uX3NvZnRtbXVfc3N9Ci0tIAoyLjM0LjEKCg==

