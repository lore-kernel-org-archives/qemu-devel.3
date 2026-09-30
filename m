Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCE2CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySn-0003s7-At; Wed, 30 Sep 2026 13:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBySl-0003et-II
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBySj-0001bE-Jv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfEkr4014402
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vQG2DSJsT3sImAhUm+M1OaxGKeflxppaqcynB6KSreo=; b=lNeS3zOZ791Gf5pX
 Ra76xAziuf8QTMVJXshP9DTQEInPD0sKwZwyOVc+pynSO7mXI8PK6mZFIf8dubsB
 ZHYtQMhcmMpbD2CE764+fQOuX1EAvWB69btl5o7W0PBDDpdz6avkqjCyub30Koot
 IzP78FhNgqWlCES5u16XU6BpOZWrWkQ4hQLwnFtG6qxH/wdlK0bF9zykgYHw5niA
 KbjcloLinb+tkeVXLnwP9ilMrjyGfWevE7CWywrX2T++0y0QlZ0KIQbIZBsSeaVG
 1YQmpJFckAVTQgLfGm8hku3NYq89WTQSH6EayuToW8SdeJ8UJAFmq+9BXamSdtqK
 7S2JCg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27jtdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:51:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so5553052eec.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790673; x=1791395473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vQG2DSJsT3sImAhUm+M1OaxGKeflxppaqcynB6KSreo=;
 b=NWCUmApzF2jw9WrRBnysNWStkZl6gT1drHn21DVpWB+Ygl9CP0BqyvIDxNCEjc0d7O
 JcmKZN2ouCmC0n9gvF7vj3EEGNqTdEaYDNOFg04hLbzBaip6/vRsVyayUzXy/byHVjK5
 TWDsKvc7GEGExDkG2YfKgClbrjryoDvuluxCipQIXovymzYKcY8EoNdojngNTG8K0/Vl
 U7RtIDKNaOGVphCQFMVyPdZrJLNJ8bjFz3b9u60WS2SwsKIjVSsgnnI6tXdnXfPgFOOu
 THjuBC9GCEvKm+z78yT+pGZHXix1A6O/M6m81Y2pS4JSUJEjK/Ht2rjIB+PHPO1W5Gf4
 sq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790673; x=1791395473;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vQG2DSJsT3sImAhUm+M1OaxGKeflxppaqcynB6KSreo=;
 b=NlLeRtcc8ctPDFHNEaJt3SHqIgfQE9O1ecPDpcNebEFhbscQBxtgEKxxdRDuzZe2jC
 9IAYa8r7hW4gM7wJTL8B57FOniqwuUZKs1J9Qi1JycN5Z4oeZit3YpIY2YOAjZv1D1CR
 B53S0f0Nd06lsUHakGlLHq/R+7aLLx5zdAJfLVDVDKM2elWn2SQz9SNOeMz/MgG0G/tm
 xu6bT/u7d+Rb5I9uCtuUVzJ8GZntOFkMuoRm0iQH6+f8Qkpu+xnlVsYel2N0OR8/R+HS
 Evz0Dk4Ars/waUA7wngBubc+xXpSDVIaOo75QII+Yp39uLhFqN57vNycPqN+y46vn249
 j2XQ==
X-Gm-Message-State: AFq9FYLZkGkHL94E1ULw4ZCKFdNLIkMir7B24pE4om++lOWMuDNqHoyA
 j384Cxxj/BNXRNs9brN2i4LYdL/CuqdYYgcqFw9b4oYFZY5yfMR8WWqOc0Eh1i2PPlwRyHUfLOO
 LKGk0DVsFTVp32siV7akhxlFI2TJPEmWmgPwRNRc8K736S3FsHGpq7vpMWMfVIBKtDA==
X-Gm-Gg: AYBFou2HcPuMVcoXpD+lcfxCs4RSmsHu7aHXOg2oThevBkubsdY8CzlmxnK3ulXt/ws
 fC6ADIK9Nde30yes9BsLz5fAeKTzPVpVdLab3jl0zRD3whtAyQFsBJ8rgnjtyR+FTc9fIZGrFx4
 Vzn08ybZ0nVjSOuG+IUiA/h8HLfTe+lw4Pw7cMz5Xddlctcn6FZXz9Z9xhpoNaDDnE+sMje3eEV
 X1KCNpQv0ZJcuTV8zNLIWvT1QH8kNAvB3L6usncRpWGKwMVkilqvsCroFEPlROX4tAc3Q1472my
 9fTmxIgF4dsAUu8gRuJrk7gUsQGCOQ8YVtJtok0EEc7DJUFn0NVW2Unf8AlFmGrey+fboEKrjov
 yWcfzlDImG4LT6C0xZII28dkRxEzp7QF0zQzZoZssjs+7cqE=
X-Received: by 2002:a05:7301:1403:b0:34c:5831:8a19 with SMTP id
 5a478bee46e88-34cdd984722mr2063045eec.40.1790790673040; 
 Wed, 30 Sep 2026 10:51:13 -0700 (PDT)
X-Received: by 2002:a05:7301:1403:b0:34c:5831:8a19 with SMTP id
 5a478bee46e88-34cdd984722mr2063017eec.40.1790790672121; 
 Wed, 30 Sep 2026 10:51:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34db42325c5sm496156eec.21.2026.09.30.10.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:51:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] target/hexagon: gdbstub - Add sys reg support
Date: Wed, 30 Sep 2026 10:51:08 -0700
Message-Id: <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX2VNNIzr9kxFt
 oeG21meceVPUyihDeNF5w9qfiKx8M1gCrQnaqw1cSe7/LMvkPoyyZeKOWZjTSZLbIGF6OPWRH8m
 OA7ivmclopQlUUZVoMvESmLeNVRrY1U=
X-Proofpoint-GUID: EEYcdJMz8L1_gNACAEEzjdViFkgGn9nR
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd4c12 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vRNxcDKAyvZ69p8uYekA:9 a=tBRmkg_bpSqWmzMI:21
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX00HA7+8Xe5dG
 et4AVY1SivtUTkNuXYBjkOosl10orZb2WI6PTbmkHy369vCEqL3XgVdyD9p97+s+wb8OJVhFrgh
 +p9FV8F1PPg6uNhP5u0DYO0detodykphGlSZZPJVyNX0XYc9lHh88tzNmu4IqF7peeDUf01vC98
 dIKek41g8gMXRwNIYKrH/igAa7RtfZQZyo1/4mAMBfkvqF/KsrJ0X5v0nN8/IUaBS+XhdEter2h
 8TurYeEx/y0Y0Ly8kbe3MY31upqX+rKYKbmC07x8dcsLcFIld/9w+0MvulrN1aOwnCm/UHXEZUS
 m9CDsTXQCPZaXl7nb74WgZgkVgj6QQANNy45uE+eIfCir55y3CIk1WFmkXl32MR/7CTaJpKlJxs
 j0X+bvNmUp4hgBwWk8X9SJgZYpeTuXAkxnr2D3PAdSN0qf0EAvUV9gRmmpilanyMhp6GYJot+UW
 xWaWYrCFu2dzerrpkGQ==
X-Proofpoint-ORIG-GUID: EEYcdJMz8L1_gNACAEEzjdViFkgGn9nR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300071
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBzeXN0ZW0gYW5kIGd1ZXN0IHJlZ2lzdGVycyB0byB0aGUgZ2Ri
c3R1Yi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICB8IDE0ICsr
KysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgIHwgNjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5o
CmluZGV4IGRmNGMwMTgyMjQ3Li5lYTU0YWY2MjFkMiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTI0MSw2ICsyNDEsNyBAQCBH
X05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0
ZSAqZW52LAogICovCiBib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoY29uc3QgQ1BVSGV4
YWdvblN0YXRlICp0aHJlYWRfZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpOwordm9pZCBoZXhhZ29uX2dyZWdfd3JpdGUo
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywgdWludDMyX3QgdmFsKTsKIHZvaWQg
aGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmgKaW5kZXggMDVkMTEyOTkxNmUuLjNlZDgzOTA0ZWI3IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pbnRlcm5hbC5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAg
LTI0LDYgKzI0LDEwIEBAIGludCBoZXhhZ29uX2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpj
cHUsIEdCeXRlQXJyYXkgKmJ1ZiwgaW50IHJlZyk7CiBpbnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVn
aXN0ZXIoQ1BVU3RhdGUgKmNwdSwgdWludDhfdCAqYnVmLCBpbnQgcmVnKTsKIGludCBoZXhhZ29u
X2h2eF9nZGJfcmVhZF9yZWdpc3RlcihDUFVTdGF0ZSAqZW52LCBHQnl0ZUFycmF5ICptZW1fYnVm
LCBpbnQgbik7CiBpbnQgaGV4YWdvbl9odnhfZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpl
bnYsIHVpbnQ4X3QgKm1lbV9idWYsIGludCBuKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQor
aW50IGhleGFnb25fc3lzX2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcywgR0J5dGVBcnJh
eSAqbWVtX2J1ZiwgaW50IG4pOworaW50IGhleGFnb25fc3lzX2dkYl93cml0ZV9yZWdpc3RlcihD
UFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsIGludCBuKTsKKyNlbmRpZgogCiB2b2lkIGhl
eGFnb25fZGVidWdfdnJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSk7CiB2b2lk
IGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSk7CmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmlu
ZGV4IDFmN2Q4YThkZjcwLi40NWViOWE1ZmI5OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ5NCw2ICs0OTQsMTAgQEAgc3Rh
dGljIHZvaWQgaGV4YWdvbl9jcHVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVy
cnApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdkYl9maW5kX3N0YXRpY19mZWF0dXJl
KCJoZXhhZ29uLWh2eC54bWwiKSk7CiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGdk
Yl9yZWdpc3Rlcl9jb3Byb2Nlc3NvcihjcywgaGV4YWdvbl9zeXNfZ2RiX3JlYWRfcmVnaXN0ZXIs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fc3lzX2dkYl93cml0ZV9yZWdp
c3RlciwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2RiX2ZpbmRfc3RhdGljX2ZlYXR1
cmUoImhleGFnb24tc3lzLnhtbCIpKTsKKwogICAgIGlmICghSEVYQUdPTl9DUFUoZGV2KS0+dGxi
KSB7CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImhleGFnb24gY3B1IHJlcXVpcmVzICd0bGIn
IGxpbmsgcHJvcGVydHkgdG8gYmUgc2V0Iik7CiAgICAgICAgIHJldHVybjsKQEAgLTg2Myw2ICs4
NjcsMTYgQEAgdWludDMyX3QgaGV4YWdvbl9ncmVnX3JlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0dXJuIDA7CiAgICAgfQogfQorCit2b2lkIGhleGFn
b25fZ3JlZ193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnLCB1aW50MzJf
dCB2YWwpCit7CisgICAgaWYgKHJlZyA8PSBIRVhfR1JFR19HMykgeworICAgICAgICBlbnYtPmdy
ZWdbcmVnXSA9IHZhbDsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKyAgICBxZW11X2xvZ19tYXNr
KExPR19VTklNUCwgIndyaXRpbmcgZ3JlZyAlIiBQUkl1MzIKKyAgICAgICAgICAgICIgbm90IHll
dCBzdXBwb3J0ZWQuXG4iLCByZWcpOworfQogI2VuZGlmCiAKIHN0YXRpYyB2b2lkIGhleGFnb25f
Y3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyBiL3RhcmdldC9oZXhhZ29uL2dkYnN0
dWIuYwppbmRleCA3NmFiNTIzNWY2ZS4uMTU5YzNmYWM0OGQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL2dkYnN0dWIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKQEAgLTE2LDkg
KzE2LDE0IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJxZW11
L21haW4tbG9vcC5oIgogI2luY2x1ZGUgImdkYnN0dWIvaGVscGVycy5oIgogI2luY2x1ZGUgImNw
dS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyNp
bmNsdWRlICJjcHVfaGVscGVyLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5oIgorI2VuZGlmCiAKIGludCBoZXhhZ29uX2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRl
ICpjcywgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pCiB7CkBAIC03Niw2ICs4MSw2OSBAQCBp
bnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1f
YnVmLCBpbnQgbikKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKy8qCisgKiBTeXMgcmVncyBiZWxvdyBIRVhfU1JFR19HTEJfU1RBUlQg
YXJlIHBlci10aHJlYWQgYW5kIGxpdmUgaW4gZW52LT50X3NyZWdbXTsKKyAqIGF0IG9yIGFib3Zl
IGl0IHRoZXkgYXJlIHNoYXJlZCBhY3Jvc3MgdGhyZWFkcyBhbmQgbGl2ZSBpbiB0aGUKKyAqIEhl
eGFnb25HbG9iYWxSZWdTdGF0ZSBvYmplY3QsIHNhbWUgYXMgU0VUX1NZU1RFTV9GSUVMRCgpIGlu
IHN5c19tYWNyb3MuaC4KKyAqLworaW50IGhleGFnb25fc3lzX2dkYl9yZWFkX3JlZ2lzdGVyKENQ
VVN0YXRlICpjcywgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pCit7CisgICAgQ1BVSGV4YWdv
blN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBlbnZfYXJj
aGNwdShlbnYpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisKKyAgICBpZiAobiA8IE5VTV9TUkVH
UykgeworICAgICAgICB1aW50MzJfdCB2YWw7CisgICAgICAgIGlmIChuIDwgSEVYX1NSRUdfR0xC
X1NUQVJUKSB7CisgICAgICAgICAgICB2YWwgPSBlbnYtPnRfc3JlZ1tuXTsKKyAgICAgICAgfSBl
bHNlIHsKKyAgICAgICAgICAgIHZhbCA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIG4sIGVudi0+dGhyZWFk
SWQpIDogMDsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWdsKG1lbV9idWYs
IHZhbCk7CisgICAgfQorICAgIG4gLT0gTlVNX1NSRUdTOworCisgICAgaWYgKG4gPCBOVU1fR1JF
R1MpIHsKKyAgICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVmLCBoZXhhZ29uX2dyZWdf
cmVhZChlbnYsIG4pKTsKKyAgICB9CisgICAgbiAtPSBOVU1fR1JFR1M7CisKKyAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOworfQorCitpbnQgaGV4YWdvbl9zeXNfZ2RiX3dyaXRlX3JlZ2lzdGVy
KENQVVN0YXRlICpjcywgdWludDhfdCAqbWVtX2J1ZiwgaW50IG4pCit7CisgICAgQ1BVSGV4YWdv
blN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBlbnZfYXJj
aGNwdShlbnYpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisKKyAgICBpZiAobiA8IE5VTV9TUkVH
UykgeworICAgICAgICB1aW50MzJfdCB2YWwgPSBsZGxfbGVfcChtZW1fYnVmKTsKKyAgICAgICAg
aWYgKG4gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAgICAgICB1aW50MzJfdCBvbGQgPSBlbnYt
PnRfc3JlZ1tIRVhfU1JFR19TU1JdOworICAgICAgICAgICAgZW52LT50X3NyZWdbSEVYX1NSRUdf
U1NSXSA9IHZhbDsKKyAgICAgICAgICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIHZhbCwgb2xk
KTsKKyAgICAgICAgfSBlbHNlIGlmIChuIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CisgICAgICAg
ICAgICBlbnYtPnRfc3JlZ1tuXSA9IHZhbDsKKyAgICAgICAgfSBlbHNlIGlmIChjcHUtPmdsb2Jh
bHJlZ3MpIHsKKyAgICAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFs
cmVncywgbiwgdmFsLCBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4g
c2l6ZW9mKHVpbnQzMl90KTsKKyAgICB9CisgICAgbiAtPSBOVU1fU1JFR1M7CisKKyAgICBpZiAo
biA8IE5VTV9HUkVHUykgeworICAgICAgICBoZXhhZ29uX2dyZWdfd3JpdGUoZW52LCBuLCBsZGxf
bGVfcChtZW1fYnVmKSk7CisgICAgICAgIHJldHVybiBzaXplb2YodWludDMyX3QpOworICAgIH0K
KyAgICBuIC09IE5VTV9HUkVHUzsKKworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGludCBnZGJfZ2V0X3ZyZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIEdC
eXRlQXJyYXkgKm1lbV9idWYsIGludCBuKQogewogICAgIGludCB0b3RhbCA9IDA7Ci0tIAoyLjM0
LjEKCg==

