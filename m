Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5A9CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Di-0003zf-Fp; Fri, 29 May 2026 17:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dg-0003q1-V9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Df-0000rN-A6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIesGO117825
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dFpJLxF599R2lJ90oVxGgJLLfXFdboKXiWyqbkD2Y7E=; b=JdaIPr6e5us7Q8PQ
 6g2gIHn+l4xgYNSVhtj5nRw279HNC7SrqRV42V5jlAmLw28kezgEYMg+ZimejJ/G
 f4uzJy21xS7y4e45GpMv3BrXSN34RvXUHdBybtAG7hUgLWx3u4l188i6M8YnlpO0
 oVAGY5zFA60vBqFWT2vPPcCIyYeT5Zpua0HUvUSqL6m6KOJ2CCGnjKOrY40SU9dY
 p4SULpGjS782MLrHXPE/RCNOObv+ay1BLvRvwQcLIhvrFZW1K2uSO+KIc7pb10X/
 GeWOxsBrHz387LQBlzDN3+MYuLllkDexbDAn05H/Z//ni3Nim+ZoL9tg7YCa40nb
 GoV+gw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrqhb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5136601eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091897; x=1780696697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFpJLxF599R2lJ90oVxGgJLLfXFdboKXiWyqbkD2Y7E=;
 b=CiZPzJplKQ/J2FVPLoEJP9Dg61XNTj0jU6IKnJnn+5sFBg+JD/IzzbXrlAy9w0sev+
 tTY8SOlBP+yiC93t5ayH0OHjIDackfkz+3MEQ2v1W2+l9nnLaZakgLtc/iKOWFaRj4AS
 loSXnEEK5WHV6V0zU98YwDlOY62C9/wYzNixVzOMgvI+WiP1iCXdpw1NaGyLEfkJyF1+
 mh0a+dgqZvpEqF1/MKfrActKW7Mqg6/kvVKMyu+4ni1cN7EQ/zR+raexAeYeAYzia4bn
 rktMX3hAikbDtYKx93Rh+bxrrDLcY+r+0mcx7NwV8S6fqwjLTLaONr4fH5PJpD8DuxVW
 3mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091897; x=1780696697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFpJLxF599R2lJ90oVxGgJLLfXFdboKXiWyqbkD2Y7E=;
 b=EGIxXmFu1FymLxN5XB9QDvN9ZnWBAUlYu0Nxgc50mU7bqPrej1fU7wMVnQNPNcnWWy
 n7aeaurTx88M+YdxYUYrEWeFQ/lCQr0WbBkXT/MBlPd0lnvr/IpWHrJWQn/loY+x2vb4
 BgtZL8aDvBD3d1dC4Nkpw57OWHaJ/g0KGs/mUMs/urRCkuMLcNwjIjj4AlQq5TB7E9ed
 3OM9+IMgjPQc0Ts3quGIYZI6vkQjrLv6GXVUXrsQYI+5CTKGrDwZLBU7j/gcN4KcQYud
 k4V6gfPHwJsafuGD2IG9xMmZF3IOpuvi7XdHfPRlSj0wwzXLkG4Xc0Cfni39oaTEk9SM
 UP8g==
X-Gm-Message-State: AOJu0YwtMFG9aA2K6z6wbv5zYZUj2occVoy8ZEnshxZnY7yWPrhdOC3v
 2hUd/K3lU5FWrN8D7nS0UiZ/e93mQo1e5ab9S23tb9w6xRDJpPLQQBgDNcU96q2TxoAD+kcKzW4
 YdonVyoL5LyIrexZyqqQ5tYu7nvcuSl+K9n5Wmraa28laeu/FrU1HyLDraUZW77CbGg==
X-Gm-Gg: Acq92OHRNV/MowAjV68IvQmP17pPXdmyWOC4JI9YTSlKN3YeQUFHgAbSqYnWFhuaHRY
 skMO94NVP/3yNvnP24mKLF05+NTdQGDOQrBW7XRiD4wDrQMfFYbHXFpmnvAULU5nqTzz/g3o2YW
 AhTBH6gv0JwmFxOZhAh6g4NAfWmh0fUXgfMeuJDKGnYsGCiQk+cLyegbUhwdg7gAHygvKVjy7YS
 Cc67f+xDjElECyS05LrAOH61m+4EdjEGiXgUYjn3KMXGItsJzN0S+xbS8ovSbqKSzKqz603pMOz
 6yfkWSVykFxkS7omLUsFTRH/ewy/uXRzRfW1HJTawOoLJzbkSsu2HcDuhy3H2uvH0OfW+eCbkpo
 OHoiC6t1M/tUOYOfxpXMcdnvcsyVlsmDjlXhMEqPKa0xIS4eB2088dZzXZXkYl4IoBoQHGXnDXQ
 SurA+v
X-Received: by 2002:a05:7301:100b:b0:304:9b48:53d8 with SMTP id
 5a478bee46e88-304fa4c7c48mr745576eec.10.1780091897498; 
 Fri, 29 May 2026 14:58:17 -0700 (PDT)
X-Received: by 2002:a05:7301:100b:b0:304:9b48:53d8 with SMTP id
 5a478bee46e88-304fa4c7c48mr745555eec.10.1780091896962; 
 Fri, 29 May 2026 14:58:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 05/28] target/hexagon: Implement wait helper
Date: Fri, 29 May 2026 14:57:43 -0700
Message-Id: <20260529215806.608770-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX7s6SakvB+w+t
 pXmC8fo1Zg8/qQM3fMrwV52pIie1S5ca3URORtN7ELDCCy3KWBaQ1mwdBJvFnUIVhGCMA2YEtrt
 r0RFjObXP84IR/49hA8KBv5mHtfrNLQvUT5MPnbwlqbFYHblFENFPfCl2pg7XX+7AMtjxibv9V4
 zrroeGDeXeUU6aH6H36QPPhUaJGp7qWlDNVOFRpnMSXUrVPJ44FvMcfh1DNf2jRfbx1GUWhFJ7V
 EeuwIamsMLcE32czHkb4lEqfHSTRfBPoHUcnWwpRpp3ZbLpAZo2Yyh/k0QREkuhhp7VHIU67Mhg
 57RaEGRFLoeJqB2dwVbuMKEFrQBZ8YgROSyNXUS3gZqfOgLeIwGLujnjxb2vAPmzth272Du3Ttm
 HBmh+lxOhbPYgm6XcHE2DWZpklS/cAiAdiByvcZwpH8ICvwZVS42Sjprcaq6/b2sxoknIfaNJ3x
 2qZ+JjMaeaxex4RITCA==
X-Proofpoint-GUID: 5BCfhpprVNV7bePgFr3_Rwu3lUmN7Tia
X-Proofpoint-ORIG-GUID: 5BCfhpprVNV7bePgFr3_Rwu3lUmN7Tia
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0bfa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
L2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDAwMGZj
NDE1Yzc0Li45OGNmNjIxNjc4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19z
eXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw3ICs4MCw3IEBA
CiAjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCiAgICAg
ICAgIFJzViA9IFJzVjsgXAotICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2VudiwgdGNnX2Nv
bnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2FpdCh0Y2df
ZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QucGMpKTsgXAogICAgIH0gd2hpbGUgKDApCiAK
ICNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCAyMzVjNzBmNzM3MC4uZDQwMDYxZGUwNmUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg2LDkgKzE0
ODYsNjUgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgaGV4
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

