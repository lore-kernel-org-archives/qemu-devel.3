Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDFCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncn-0002ni-VJ; Mon, 22 Jun 2026 19:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnck-0002mg-4X
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnci-0002DW-5E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJb06L1902581
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=; b=F1UqBmDqr47RR5sK
 e9XBSNC2hZqUJQQGve0YrWU4ieY9AmGiiU7CNGM/gM3gFGFYhVrLAWj7zPQmxjVw
 oST5mGqUPeexmtlJUJ1jPb+TE6hF2mpB59S39/eAl4/3tcN52jqkJyH+oyCuiz9S
 m8pKmgASjVkyEf4lw5Qq7vphOIyL7y5jm6sdX8I8pFEFflE9AYOGEeSO/JNzdZyr
 XvIDXT49agxXfOFnxszOAkJcQst3dPiDAboX4B3cEoGd0WSq9mQ0MHvZHeV0TuFc
 SIiXfAyk3WFJuSxmvrsJBdempJUkVXys7gNdHHv7L3lX6qDQUaLSga2260BMeG6C
 0vIJuQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1unec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13980b6561dso11641627c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169209; x=1782774009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=GYmPX66lok3zdGPKXdtmcPrqbpdby3Y6TfY0/K+tXWaIMBFn4JHDwWalt3FQwzJeja
 0GiuCPHFCwdc9HnFJQXLuWtzPC9MWcoaS2eFBj1MXZ8z17bKt+srNZ+c3nRCcuHsV6j9
 BVorUb/v962361NbwG2TJaywlI/aXiZyQgQyTqtvvE7pd1I3HTu9wQ/lNr29iM3yScef
 KKcSh/vZyl2i8Mn9ZzZiHF0E4kptqrd5gP+LP1SIhYrKKX1u8HdcbK21Q9VXr+5RjZXm
 MxWX4Me1df7QM7Nca3K+QvbGPFNLcS8lIurMPae5kbpZETR0F0d61iUhF6tuJbTN6pkS
 ACKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169209; x=1782774009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=ZgGdVuHhiLvPPZh5HLwv6X4fHZFg5tG90ifhYSeQgwBZ5l53LCxUxorTDuIUQ8Yjbq
 NqpNe+1QH2wMkU1wTzlb9j5f+yA0ozf2HIlPYFfrlKrxBPzYg8JPiCKk37keJE8PBDg8
 HhkTTj+BIB6TgCEIO3be2PPczKRjc2Oggysgk6B6urkkABfQPzPnBjBu5iWl/kdHg2La
 G366y3bFs8tTXAd+N6AOK4iGzBoZ6wxPvKWmcdiYMwZu3s6Gsw2vGB1bG42MVdQRro5B
 zvQLiQEFuyKr6BWRDf25fFn8hBNcbxbyH0VKSroX/vatFj1vLxYZM9+upeebom1modN7
 ttHQ==
X-Gm-Message-State: AOJu0YzLrmQFmje2dLKsulKrw5Ilaxhl67t0gfDujkmT/Hcf6LDNfRam
 SVRJ9ePojLX2zB+a/DCuLU7fTufly8Vd4Retb8Q3Nwl5fcu3XCzhry7mOZbpnEByO54AUqTPKo2
 b4oQjqTQeDjLaQ22pJJ5OO8jAzwMDU+wSWooU2B/wJSsZmjfcTeNiuZN/JYxCVfk0Gw==
X-Gm-Gg: AfdE7cmpSdZrpdbMup5yeg8Aih3To6PEAG88PZ7WvcN5jYzd1V7L8XegqkjFxGmC+Gu
 UnE7zcR/v2Yx0JZP46bld0/pD5GHFaAhe9GTRoagyImQWgK1xHN8DtdA1/74iuYZbjYPyl7fOJr
 B9s4H1pS9ofFOYTkeXxF/YuxpqDrR0HBBgTlsnuviS6R4lDvfaQ+IbEToF0IYiRaQcN/uIQdPg8
 Q1X9xlHrFUWBV3cSTQVQpUUdns9gChkDO7rjfHu6VK1NQ7md3/KXRDpXYfhWomKiXAHA8faYQ1t
 yXAnzlItpXFULn1dQZcvKl3Th6au60xqtiIErBc3zNCyj7KNFEMyyvJU6C14nyDdv133WJ9pnfm
 L8K8E7Xf4wx5msuUYQbtXbqWjSyLywX6RUhVLTfybzGXPjCWBg+LP0zRtgOQ=
X-Received: by 2002:a05:7022:628a:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-139a367408emr9571075c88.19.1782169209531; 
 Mon, 22 Jun 2026 16:00:09 -0700 (PDT)
X-Received: by 2002:a05:7022:628a:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-139a367408emr9571048c88.19.1782169209051; 
 Mon, 22 Jun 2026 16:00:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 42/75] target/hexagon: Implement wait helper
Date: Mon, 22 Jun 2026 15:28:31 -0700
Message-Id: <20260622222904.607771-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: SN-iWUtX-Oxdk7JXc_Gol0K_7OpbeXx9
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39be7a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxFT3IklYZ3Ex
 mWZLffT1r5HIcguFmL9sPqRXWOs9tbwzufVpAv0EzyffHUZRBAAnmBRNissW6u60TDcLtNADcnp
 loYk+IE/bv7/rd6uFtemek0ea8spx74=
X-Proofpoint-ORIG-GUID: SN-iWUtX-Oxdk7JXc_Gol0K_7OpbeXx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX7reLmb2O9b22
 kEywxVavzNKLg7fR0TFhZRJ4L85RRE5BEh/p4VV72EV5AY9Ju9p+xK+5tqIfzfZxTK8mkh6rO8H
 0pJjEJV7reoZ1DkFPwkutjZSWwOUQNFVTIb8FMJhC2+vq7r3wsvvjYyl8KhD0sYpsjkbDxCqvH9
 v2QV/og2zkQhkfbu22nk8tUHwJLMshYsdjI8zYufbrtBf84dHRx7DWfM0O/HMzfivv+t8z1HJYv
 v/jXeVop35X8KH/tPhfyfbXeZ3iR+Wc+sRq1MzkCrwY9LP2DbFXQdmXwB6seJHu/MUYnQh+MWoT
 9tNmCYCMh6dP9dbqNWSyrSO3c2EATDaKyN/bCfelSvTFHYpwVPR13L+GztHgL9QduxZpTB+QVQ6
 sLarQDpESD/+91DGygid7SA3fPIdWIW3vnXkX/ZWQXMWPY/L7N9pGgAHmzXbZiWx1wqL/x257JB
 yhu0992F74/pePSpkIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8IDYwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1OSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDI2NGVh
MDI3NTJkLi42OGIyMzg5NTQyOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19z
eXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw3ICs4MCw3IEBA
CiAjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCiAgICAg
ICAgIFJzViA9IFJzVjsgXAotICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2VudiwgdGNnX2Nv
bnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2FpdCh0Y2df
ZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QucGMpKTsgXAogICAgIH0gd2hpbGUgKDApCiAK
ICNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCAxNjgwZTMwMGVjNC4uOWQ1MGU2ZWY4ODIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg3LDkgKzE0
ODcsNjUgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgaGV4
YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCi12b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQorc3RhdGljIHZvaWQgc2V0X3dhaXRfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAg
IEhleGFnb25DUFUgKmNwdTsKKyAgICB1aW50MzJfdCBtb2RlY3RsOworICAgIHVpbnQzMl90IHRo
cmVhZF93YWl0X21hc2s7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgY3B1
ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpZiAoIWNwdS0+Z2xvYmFscmVncykgeworICAgICAg
ICByZXR1cm47CisgICAgfQorICAgIG1vZGVjdGwgPQorICAgICAgICBoZXhhZ29uX2dsb2JhbHJl
Z19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICB0aHJlYWRfd2FpdF9tYXNrID0g
R0VUX0ZJRUxEKE1PREVDVExfVywgbW9kZWN0bCk7CisgICAgdGhyZWFkX3dhaXRfbWFzayB8PSAw
eDEgPDwgZW52LT50aHJlYWRJZDsKKyAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCwgTU9ERUNUTF9XLCB0aHJlYWRfd2FpdF9tYXNrKTsKK30KKworc3RhdGljIHZvaWQg
aGV4YWdvbl93YWl0X3RocmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgUEMpCit7
CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKworICAg
IGlmIChxZW11X2xvZ2xldmVsX21hc2soTE9HX0dVRVNUX0VSUk9SKSAmJgorICAgICAgICAoZW52
LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEIHx8CisgICAgICAgICBlbnYtPnRs
Yl9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEKSkgeworICAgICAgICBxZW11X2xvZygi
V0FSTklORzogZXhlY3V0aW5nIHdhaXQoKSB3aXRoIGFjcXVpcmVkIGxvY2siCisgICAgICAgICAg
ICAgICAgICJtYXkgbGVhZCB0byBkZWFkbG9ja1xuIik7CisgICAgfQorICAgIGdfYXNzZXJ0KGdl
dF9leGVfbW9kZShlbnYpICE9IEhFWF9FWEVfTU9ERV9XQUlUKTsKKworICAgIGNzID0gZW52X2Nw
dShlbnYpOworICAgIC8qCisgICAgICogVGhlIGFkZHRpb24gb2YgY3B1X2hhc193b3JrIGlzIGJv
cnJvd2VkIGZyb20gYXJtJ3Mgd2ZpIGhlbHBlcgorICAgICAqIGFuZCBpcyBjcml0aWNhbCBmb3Ig
b3VyIHN0YWJpbGl0eQorICAgICAqLworICAgIGlmICgoY3MtPmV4Y2VwdGlvbl9pbmRleCAhPSBI
RVhfRVZFTlRfTk9ORSkgfHwKKyAgICAgICAgKGNwdV9oYXNfd29yayhjcykpKSB7CisgICAgICAg
IHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAiJXM6IHRocmVhZCAlIiBQ
Ukl1MzIgIiBza2lwcGluZyBXQUlUIG1vZGUsIGhhdmUgc29tZSB3b3JrXG4iLAorICAgICAgICAg
ICAgX19mdW5jX18sIGVudi0+dGhyZWFkSWQpOworICAgICAgICByZXR1cm47CisgICAgfQorICAg
IHNldF93YWl0X21vZGUoZW52KTsKKyAgICBlbnYtPndhaXRfbmV4dF9wYyA9IFBDICsgNDsKKwor
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7Cit9CisKK3ZvaWQgSEVM
UEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKK3sKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworCisgICAgaWYgKCFmSU5fREVCVUdfTU9ERShlbnYtPnRocmVhZElkKSkg
eworICAgICAgICBoZXhhZ29uX3dhaXRfdGhyZWFkKGVudiwgUEMpOworICAgIH0KIH0KIAogdm9p
ZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKLS0g
CjIuMzQuMQoK

