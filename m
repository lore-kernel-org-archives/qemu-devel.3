Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDEACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncq-0002oH-Lr; Mon, 22 Jun 2026 19:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncj-0002mZ-Bz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnch-0002D1-PT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbAQw2205753
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=; b=o//9P+Ruj1aYmrpR
 j/X6tWylWctYu/fNVRFBq6iMADDSF7gmCR84VxBUhFELfPIJIuZ1ilkaxqRiIohX
 AMskfzaeCC7Kgz5jnqRS4wswywEIBx9KCH/8I1EPj7zhSgsM1QsEwtsoMOwQ4XDL
 BxsJK2nRjH7JjP8hChmmUqiAxAINe64xIZiPDWcdFy7Lar20SQMpwIXZMOviaSIH
 Ox7YroTtQZPXz/IbRJn8V1By91s5lruNQGyt8BimldoSq+hMZfsO2tMFBifiXe+z
 0p0Z1jKExDTXFgCs79REsTg/pYYNNBxiyrqXGH6wf1u5y6rAF9LMJfhsC/UplDu0
 pmzRNQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsrec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139871a52c2so7022346c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169209; x=1782774009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=QH0DSf4cPEbiP7bP3yZ8ce/TdzKK1mXQlcJhoFAE6jLqg8YhTj+JUvREbJ91Kp2yf5
 ngAbNNAlvq06EiScH5hdVjI9oceA73Y6UwdU/ZzMm9fKa19ytfZbs4hrQnGhMhSOUcUv
 SQ7DrpJEyfFDImhm0tOeQa2e/7YPAMjJbYYCbKLyvc7NgufCT11p+uTkFW/4x04UVD4K
 GFxcrixQ7LwZWPrrwX5JvAPi1AAwI+NNJCijW0FQctABx2qLnd1l7U3ycU1R3D1nMFm+
 GgwTbXFfsM6WotjybtdnMZXfwnLNV8wsJdx5+B7yLUzPN+L/SWBIIaLNnTrQloAKDakq
 NNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169209; x=1782774009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=YHGqOZkY9w41hyJeE7WEanMHcI1MVkMm/vpNpHztpNj1bg5Mf900GI9JdOwQe0SC2b
 iR7pLHjR+LSAYx74RUaSozb6BianK0SBKTXfv5UF6z2krgH57SXMJr3rpcukNjKTazm+
 PhZhdN2KEevrtFj4WILh+rGRROeZh8CjuXsFn/+Iemag+259QfF6XEFTAHY4mbzLgrU7
 7jeUlDU91q96weIJtLM7EBw5xmwkOnFj62pLdyxJRfttMu2FY4IIdm7fwuu7WvbNin8S
 hK1NnGRePvZM05m7QWTZmlpf5tgZz0qJlbr4e2A6wCNwRo0X2EBBsoOhpN/MEw/hTRm7
 KscQ==
X-Gm-Message-State: AOJu0YzDspjKxtFNtI/USrDBYmJWirZBFJmPvwnXqLKhXnxO5sDdZOwn
 yBCqFQXcS5DSlMz0CIpjk2o5QWFATcPUGNRshjgJewbi/ajS96s9dKjwFeo4y35alNTxbhp9+s6
 vXdgJh+URBh7u3niu87QY6XdQbWkhbhyuo/tYeJc6h4FnVyZlSJlFkiWc9tf0Lnz8Mw==
X-Gm-Gg: AfdE7ckN7BX2/TGMLf1++IL6TySL27VkXuE4ECo1sl46/rtafCro1nvLYuNLqQ0TCa3
 PTtQSsTr8wtj6fnOsDZXFdI8f7/mNCCfLjN97ufnw4m56ZpCZCvHoMiMgjSccE/mc8auDxWRXmM
 U2QIXKsQIBcwqXIevNsSj7BkopnPtTTA4Cs7SS60vPF+wDiS+zkgoQ8t8WxgQJEfN0NnRrcfjjj
 Tlf1b9ASCqL4Fzd82fYClN+0rRj9dHeGApJi9xSvpG9JTM8vFqqxap6BWf3QhytIrhLDXifTYwr
 7ZmFwQzOWDgh0+0Hfy4tCh7kscdd/iywdAw91QZatZupB/pkTQrMY5PuOmQDvuob8LXOrRb0hnD
 MZQAeMv9IOtfDgntE9sRubd0ZjsGC1mTv0+5YbBgOJdggTLzg8XdqSiihnoo=
X-Received: by 2002:a05:7022:fe03:b0:138:407c:1d24 with SMTP id
 a92af1059eb24-139a3898559mr8488194c88.36.1782169208769; 
 Mon, 22 Jun 2026 16:00:08 -0700 (PDT)
X-Received: by 2002:a05:7022:fe03:b0:138:407c:1d24 with SMTP id
 a92af1059eb24-139a3898559mr8488162c88.36.1782169208030; 
 Mon, 22 Jun 2026 16:00:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 41/75] target/hexagon: Implement {g,s}etimask helpers
Date: Mon, 22 Jun 2026 15:28:30 -0700
Message-Id: <20260622222904.607771-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX2rIwAoMeTrBP
 RRHr5G3d5kJXTo+eL21hLazlAG/NSxeqYegzBNcCyt+fRRCmg8zBt304w33IHACs6uGjLJp1Bsw
 ev9RFVyOHIqiTH+99sov6OCX73utAcM=
X-Proofpoint-GUID: ms1fscYl3f8dgeY7lFTOfosKQvMFWwMu
X-Proofpoint-ORIG-GUID: ms1fscYl3f8dgeY7lFTOfosKQvMFWwMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX4yFA6SuCIF+C
 KIYH+l4dfPoLbm1hTT+JQ5QkzDhpa/rC535FLzsdJnsNji5xS4kbSYsRv6TlVL7UTp5zdfQouny
 TZvmmBxnpQtI/so/dtQ//6Z/83OvL729eKhsqRgnWq1x2KBssJZphv14R8ON3ekwtQM6n9p20yt
 40bQ5OPHiPLm5fao6ZHqwOboOJCtsGvRTydQ++g9wAT9gA1VmhAMJSifN5SH1/E8q4Om9GOOo76
 +CYoWuQFKRLIstYlogyiCiTbIhWfYXzEzBF/jeAXzRsOTrUmRaqL6Vqjd0W+vHcIHvEAxAIRmTA
 SU1XBGhtnUXEyFRZSk8sRJQatqgmpoQqqkElZv31B2UC7cyxh7MISHZDVo1g8DNA8CZ2pcgAxqC
 9XX56TrKFpWhhHA6mDdMXRzgJI0OrtLa8uJYVP3kdC8sFk52gPTSdq0usXj4wgUagKC5ldkADYF
 c1PpWBq2MdAjk51uA6w==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39be79 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGI5Y2YxZjE4OGJiLi4xNjgwZTMwMGVjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTks
MTIgKzE0OTksNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

