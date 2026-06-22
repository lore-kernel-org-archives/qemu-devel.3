Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836ACDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndG-00030C-Rr; Mon, 22 Jun 2026 19:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndF-0002ze-Px
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndD-0002To-M1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJdmG51940410
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=; b=Z8wYEEmmLNaZsQ2E
 7OHMkIu8QVgfabRUfswUOp9eh641+h0+byTc4oJkucgUpXKC99cJcxuQCYkP2Mvg
 NjAdNvVplXbFbJx30/CXvS5Ixmf4phXb7hUTBVZDsec2hgNDSZLWG3lFPAJ4puwO
 aITm1vlcLM3UpdRsOxV6+ncBch6JOW9Xpj5td1SuMeqlu9pTjpydcnpKwKDZEgQl
 bLdMGL+iiV2K1+yT9UyjDO6RAbiCCzzFC6ck26ocR/d00Hck/T92naB+0sIAa4We
 HGzayqaKc47A3S653u3t14+4Xhp8mZscMsRbFhzlqBD39SdX08rE/D3mF5R5zfD7
 w83S3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yea03e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so5882936eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169232; x=1782774032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=aGQ+y8JHN4ePDm4nalH948EeeBGvb6tTHyfZnWTqLSA6lo2SAVIrKTv5F3fq+jgOZV
 8njzSNYzE4ngVQWd0/NlnkRRMO2KPk1lEq+Je5EOQ+ef8FH/+j2CZJCggDlQZyT6Oq55
 +onV6OiPd4/9h5qSF8Qv8dftxHcoUNj1m0XYwKhILDvVS4hCK8rgWRa8JrlMlFhWhA53
 AttTJuEIE/8IbVt3hoMxuehKwi9exSdIM+CR8yIg35HAsUmPRef9zigRqnCQh4uaaEGs
 un/dgb+UNyzHnC3lP8Ek+imoy8rOwM2qCFoYFaoOxkDy4faX5JOZ3Xbb6ULbrMMnSXSS
 boiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169232; x=1782774032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=bJbAMtKIaIOZUPhgT2JmCsa+AazNquK0THPM0KABK1mn6xibIeVidBX+pMbR53008A
 oA2JW+ZuSbB0q1Z0vTf/1PkG/cqJCrPH4WZDnLU7PiB8z19aoZ0EATao+1+1pyadXUxi
 fPiUbKMKu5KkBRvKcFCSLdBAyz9HBgffmdCBqFLbJR5AKPM3A0VTWU4EyA+2JXQAdBi/
 PqMi5bboN0/QVVD2Avvuh+30lKLf/W6QPkQqbGyNC57xyVqqLE/bAVPYNEVZOohSWeoA
 YDumFffoW6eqITv82YVR/uZzGbbuYcbolh5bHANbKMB2GHYKBrBCDH4vpZs/XZVA16+b
 c0Iw==
X-Gm-Message-State: AOJu0YyW4XxxDMCpKbY1AxNd4He4iH9Ug6xg/cx+FrnSLrNfNYEL09+L
 ZxYPjAUmzadu8jCOclt8MQ5Im7PzqDqNP3Itwg1bErQI+PbuyP+kImeXc+R9qzgXQ+SEx4E53Iy
 Y+Bswsg8j/ZT5kTTv0E7Mg0amwMeeu9irANW8C8qVL8nwOIG61UUu2YzMujxE3BJMCg==
X-Gm-Gg: AfdE7ckBnDfl7tz649XeovLrDxoxpx8RQPPHToCPPY2dXpWed0MEl7FVOGLa/DwdC0W
 TQB/Ho8q+s+vBuVlkLKyW+q/mfp+ub2RKPzbctUg/YEB0NgtXSWV0ybcTZdLlHhZDciqpno/EmS
 3Nx7LwN4X2fpC8TcHekSzo/C32xGkyIT46MnTjWUbPWyTGx9DTQql/k1oTuEPRGLCjSrR/BT6Mr
 c2zbiI2HnGUN/eAQuMtPD7Mwm87vLHs/7uXuMunL6WIFTN43hY0gSioEspM72mEEE+289IG7BPr
 H4gIPTDU6eLKx5qloYG/9+kL+VYcA24z2ghoqlDabUZM8+0bzZut8xo1n5Y5hIP1T7u+yuTQ6hb
 VY4HuWtd8PUVJ19M/FGInhXCdvQ55qwhQQj1o3YtasuetNhotZW7Q81ABykU=
X-Received: by 2002:a05:7022:6b89:b0:12d:ca31:f1b4 with SMTP id
 a92af1059eb24-139a210df05mr12212177c88.24.1782169231692; 
 Mon, 22 Jun 2026 16:00:31 -0700 (PDT)
X-Received: by 2002:a05:7022:6b89:b0:12d:ca31:f1b4 with SMTP id
 a92af1059eb24-139a210df05mr12212133c88.24.1782169231060; 
 Mon, 22 Jun 2026 16:00:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 56/75] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Mon, 22 Jun 2026 15:28:45 -0700
Message-Id: <20260622222904.607771-57-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dkC9PZ5w9wyc6eBwuxTYmJXd-H4zISmE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX4J8Fl7yW8a+P
 7jh9pFdY3nxsbSUttBhDLebY1rE0k/jheMqdFo7COqgVuMYjbjr+0PMwC8dhKG8jSoTDPVvh4I7
 fgqLlBvdHBvbmGgMhIoy5KSl9FF5ooU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX4oMpn5V+GZs9
 3+/L+Obo+x4s2GJJ/YbPNj1V34YzKhbSGRc2lARIh41rDeyfCD4QzaiTAYiIleJ5OYhSqzsAYqW
 22NhPmw1iw+UwytpKaww4BtWTfCR30rMUGhFF5CUiEwiJQjHEd/XycI0UfQsuNv21LJxKBqAZNl
 LDvYem/K/x0gC7nuz4iI0oloZ3gGnB0DkUH05P6lRUsYUEzoWVMmK4EfZaDVmEVDy9QpXlqp33Y
 uq99icoBq2MCX23hYf+xhxjSC30/G1GlDXRKj4014rFDMBs6zs1iOh2LDdxJBTx719tHokphRCu
 3ijl2dxB6h9ZI1Z4hZhZlv3iste275mJO1vmpa94/HlNI233IIUkQiRt4ZoP6xFre2PUKIetYPg
 uz8d+a05/cx0hghXzlVBDAnim4WcXze2mCE8Z+Sgqw0sKdqoF+b3r2uVVSXZgzzo7glgzyckPYZ
 VoflFZBnBO2NNm7kmMg==
X-Proofpoint-GUID: dkC9PZ5w9wyc6eBwuxTYmJXd-H4zISmE
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39be90 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzYzI1M2IzOTFlNy4uOWZiY2Q3OWM5ZDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI3LDYgKzEyMjcsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDgsNiArMTY1NywxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

