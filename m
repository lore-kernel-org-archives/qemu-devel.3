Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3B8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3R-0002WS-QN; Thu, 11 Jun 2026 01:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2r-0001gX-WF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2q-0002n8-43
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GCZW3843612
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bj9eFNWT2Jx7cinFrO9cHCVAd0yrhcaMGOXbDIJ+gvc=; b=SuqN1Lyj5w39FUUb
 wAKA9rfYVlm857m0OorPOvX+ZJvrBfmIKUjh000q85q6bz9cdvkOVP4r1WH3oL0p
 inwDmdfrpzbm9N84xK+E+MxXqM1USPJTEzxcgsJXxfyCHjf9tzySZpdVh93m3Rxu
 8NR8pGvCaqQ/gwx3D5JBuE1YdYIz/yLczizqs+qc4voC3bPG+kdJC1CF45r1yoZV
 ty67fP+SC1hxMwDTrK2LLEIQl9VlpLw0AZzj4RabfnhcF7c3NporEQVNrvw7aHgK
 OSLOAuk/ifkUS8Tu6NMJ/i2jxio0xSZ1LVCAGhwnAG3AgMTDEmIjx0r6jPKysziF
 11t8hA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701rty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-308004a2c49so1582717eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156013; x=1781760813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj9eFNWT2Jx7cinFrO9cHCVAd0yrhcaMGOXbDIJ+gvc=;
 b=eTOegFA2NUMPQbY1qaVGTPwAWVdkHiCcAR0qamQfZjqGV0gH7xrXBjfvweqe8l5d5Q
 W5otNm5ZT8u6olLKDEceMRlAgBbqbwfUje56C7BTqqlNKqdGWo08QRNFJLONmVjsfYWm
 avmNczrgB0ZoHYDzsDiYHWazkv68rlib7ImLyfIIm9CMA9zkdZrOJBSaKVMQSF9/6xpe
 X3hYEa66yGc+FLrY1pJ4bTEVgr+W9uoaiVcaOtKj6Dh/FFIgUcCX4a+xelxt4/dykEIC
 j+xFW7ZCCB8Z7EqvcJM1eNSsXGNbIawjpuQOvu/QzIVs9JsuVmXfjK0GjKT963ZnnhXD
 vcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156014; x=1781760814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bj9eFNWT2Jx7cinFrO9cHCVAd0yrhcaMGOXbDIJ+gvc=;
 b=LDND+69CorqAg47ZbAaWEJel+C8pdS60g2lpl1RKPV9j9/2akU5DOZXxPRKxKMivmR
 +4HeTDONPK23duoLQxBV3jRQrK5CYI16XihVDEEbWYRE17SYw25M5mddKmnzgi143lYC
 +0eDDrNZDlMNdwkqwE4jZ8u2YTwt95bv+8VHYqZ9+x9OvD+rC1FJ1/Dfolz9utuakob+
 OjBUQGHCt9uCxAOTUa5v2QBNjDpTQEwe7j+7DVyZLoBHCmOJVrzkDPsR1pWB0/SFOC8h
 vqmRDZ2wxpstRzwdlts+IwwXOSATpad2OT9hKeCYiW9IW/EnxLl//JJ6FQF8xqyW0any
 aEUw==
X-Gm-Message-State: AOJu0YzWyplEw+O3ZwTYXCyr2Ll1uzf7O6ufxKjbtCqdUwMU7ZOdzWIx
 BSMhfYumYtyhHXuiBb1gOBrGfajZd3LsZQphk4lKcS1rwpmBlVemQo2JFmqtUZJLk0lu9p1qgnr
 bVmddW5i8CSh7Re6Ia9P10DCPxLd2HWH5hJPmvGC9YItm5lhPLCVQYbr2558uhDHDjw==
X-Gm-Gg: Acq92OH6eZtfWogeDymSM6f8z9ShYVpnFkgk3sO3c+oS1crUy1wtRbyBwHihXPvFDP4
 F5/zq3yDnhXR8T9moDPVSC4xDUuVqLz/e/CYnUvfD10P3xAC+7vugr3OyhwQhcIaHuWPDdLNAoW
 +TyLWah6UTugXmuRErx+bjya/Xdp21zdJEOdAeZCCS+oiqBITBJ2bB5JdUfUNEIQgsZMNPj0W0Q
 SHW030yQ6PxrKCSItqyAxchUOPoInGPgzugqs77hj34IE7OUBN/f432U6CES38RU2kxn/urNSeI
 B0vjZct9xFNh9ySa/Y2qYZ1GlwzvLvJATGfg9FOv0tjD1Y0SgctllcfpYgFPrXlnqBatIaYWay4
 YmX0ArjxHYrg79MAEIctHy1EI+HUJYSILAbbhIWnjn1Yfx26XFGSGuem/ZoXC3FwIcSH7K6JGeu
 K7O81c
X-Received: by 2002:a05:7300:b918:b0:2ea:ed3e:13b7 with SMTP id
 5a478bee46e88-308046071f2mr1160023eec.7.1781156013462; 
 Wed, 10 Jun 2026 22:33:33 -0700 (PDT)
X-Received: by 2002:a05:7300:b918:b0:2ea:ed3e:13b7 with SMTP id
 5a478bee46e88-308046071f2mr1159997eec.7.1781156012863; 
 Wed, 10 Jun 2026 22:33:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Wed, 10 Jun 2026 22:32:46 -0700
Message-Id: <20260611053249.3918491-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: MNbGIm-YZqd0wRgAhRvTcqMBAuyeNq-z
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a48ae cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX+E7kzjE9YF56
 RX7eefxpjtvioAUyQwVD1X7Vk7CbgE+1zqXaYHs8d/PyzHDex1ix3OcaXkGbA3S+HGJIk/7iZPc
 FvSl8B82U1T1tJg8SsQ0f4DPzh/RSKqEdQKa60y4IOpnR3D08s30LFDC8FSr1gpSf4IHgUA52DR
 0ZBmW0eIPSSNJ9PI0MNT2mXHAm1KNga65CHNJFpVL6EB2iT5Zc8E++yjnoaz67BqIpPnOA2p/h0
 LmeZJP9g+Iyb93ZfsNjL2ZyQyFpQLIA30UqsCY840LG0gxq1MruHyrITpPUzl+8EY001XjFNGrq
 PTemtbS82BtI6WXW/HI2OatspgqtYevk5j0UYWfuoDGiXPSN7N+lzx8xtInA9OHqzmd+PrFMoHr
 y5iJm2XzjivKpZVXCiGGyllAyTyZoJDthdnIZYyY9KZM4Yu2/f1PSoeUX2hgb7RuHFelilQo57I
 DOlH20RaNMA6jP/NGKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX5JRtL7ko0vUY
 dpRngkFX0LxqqzZbPV6Ux1acmJD9jYSju1AD+9gjTka8NXOtxG1vTtILla7rSp8ExOHlGWArauS
 o4xIkhFAIq49vDfVqUHveuzsxop1Av4=
X-Proofpoint-ORIG-GUID: MNbGIm-YZqd0wRgAhRvTcqMBAuyeNq-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDRhNThlYWQ4NzdiLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC5wYyk7
IFwKLSAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7
IFwKLSAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwK
LSAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfQTJfbm9wKFNIT1JU
Q09ERSkgZG8geyB9IHdoaWxlICgwKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCBhYTM2MDRkYmRjNS4uMDMzZTU2MTlk
NmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNp
bmNsdWRlICJoZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFH
U18yKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBp
MzIpCitERUZfSEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRV
Uk4sIG5vcmV0dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwg
dm9pZCwgZW52LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkz
MiwgaW50KQogREVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IDFhZTU4Yjc4NzI2Li40MzIyMGExMjFmNiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTY1LDE1ICs2NSwxMyBAQCBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25f
ZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBwYykKIHsKLSAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7Ci0gICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiAlZFxu
IiwgX19mdW5jX18sIGV4Y2VwdGlvbik7Ci0gICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2Vw
dGlvbjsKLSAgICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHBjKTsKKyAgICBkb19yYWlzZV9l
eGNlcHRpb24oZW52LCBleGNlcHRpb24sIHBjLCAwKTsKIH0KIAotR19OT1JFVFVSTiB2b2lkIEhF
TFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBleGNw
KQorR19OT1JFVFVSTiB2b2lkIEhFTFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IFBDKQogewotICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2Vycihl
bnYsIGV4Y3AsIDApOworICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIGV4Y3As
IFBDKTsKIH0KIAogdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY1NDUwY2VkN2RlLi5lMDQxOGVlOTkwZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTEyNiwxMiArMTI2LDE5IEBAIGludHB0cl90IGN0eF90bXBfdnJl
Z19vZmYoRGlzYXNDb250ZXh0ICpjdHgsIGludCByZWdudW0sCiAgICAgcmV0dXJuIG9mZnNldDsK
IH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCitzdGF0aWMgdm9p
ZCBnZW5fZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKIHsKLSAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBn
ZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3Ap
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoUEMpKTsK
IH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3By
ZWNpc2VfZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKK3sKKyAgICB0Y2dfZ2VuX21v
dmlfaTMyKGhleF9jYXVzZV9jb2RlLCBleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKEhFWF9FVkVO
VF9QUkVDSVNFLCBQQyk7Cit9CisKIHN0YXRpYyB2b2lkIGdlbl9wY3ljbGVfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQpIHsKQEAgLTE0
MCw2ICsxNDcsNyBAQCBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERpc2FzQ29udGV4
dCAqY3R4KQogfQogI2VuZGlmCiAKKwogc3RhdGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgdGNnX2dlbl9hZGRpX3RsKGhleF9ncHJbSEVYX1JFR19R
RU1VX1BLVF9DTlRdLApAQCAtMjExLDggKzIxOSwxMSBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
KERpc2FzQ29udGV4dCAqY3R4KQogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXND
b250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7Ci0g
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7Ci0g
ICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2Vsc2UKKyAgICBnZW5fcHJlY2lz
ZV9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlz
X2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjYsNyArMjM3LDcgQEAgc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3Jk
cywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9u
X3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZh
aWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

