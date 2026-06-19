Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE2CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifN-0003nC-AQ; Fri, 19 Jun 2026 19:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifD-0003mD-1I
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifB-0007Nr-AX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYCDW1336529
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=; b=giwdmLaoj5VPZXWm
 +/miD/DhAF/+vX7Qt8QgejNtChZRJwhUAny5wlZYZxHTj7XuN8+ePwonvX66hi/s
 KSJCSI+QAkEmn9as2btKaC9pGcgjc5U9HL9sSAUqiMrxz+WNSka28e58OAcAWLz0
 3mlXNy6XmxqmcvrUzZD+oZE7ikIOS5xsZ98kKPL3O3kXEN8MYNO9jFN2Z6Ka+lOL
 8++v+7SPpd7ky0iUe2U9i/6sjNQgv93ebCQSd+SewLC77qO3ARuaZAFV37sc3djf
 12M+Zogwyy6456hWZm92vISIHwNLuHFA9adV6Aa3kgOk7WKtL2pdlBCcTPfc/DjU
 ytL+hA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67578w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bef75a41eso2060800eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911815; x=1782516615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=Skxe1OnRZNtUeTQdPWQSnjxUG7A3lTU0QmJYEa6tnkrRgsfdSZYos9LF5YSwSwS59d
 Wb20NaUG6ZToE4WUQRWkW3rjuGNdTPZPT6HYmx8p2/NjExF3jyuMotX7+0X7mhiCKFE3
 PsXeyshok2fs2ZhO65xDLjq2MzwNUV7JjqpIiRlnE7YJXsalyZwi0ikk+VsHz0TuEkdC
 GhgITInYB6/WeTDTMAcd0RgB5SYRAl7kVm0rVjJZCTPtKfv7ttpd5P1styXywdGEAwkx
 0e7zib8FEM2DkLL12sH8LXKQ4uCngQvBSGk7DeaGSkw7Gx2pIJdwDAhz7n9Ka/MbRZJp
 jlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911815; x=1782516615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=GFkYNJNwVFslgNHMkZwESiKy7UrXYABRW84ZDpX7hLPiQcAJKyhRI/2Gn5hYgFFoQZ
 fAhVpE/QNq6RGX7G6dPU2Zdp1y7+0wL6FoX9GZx3zlP3j+Ttk4qdpOAKTA9VW7HxJ9L4
 MevqM5hNLnABMjxIiVswkRJhiqE6C7ahUAXEA6ZhpvC7Agj/1dSuSrd32fiQh+ncuSoF
 pdP6AqEw1R08gugf0zyBddtEX/f9KZlvRIGJ3Fjx21Rlx3UO9agBQ4OzPS5ZtqaIMdXR
 nSjdb/rio959pSjtyBr1/7A9dr69c930ve2gwXMjRs4oXGT9EhLNhO/uWZMqwENP7gSa
 xpXw==
X-Gm-Message-State: AOJu0YzdfWCpBMsluUUcHlR4iqMb7Tcnv5on2VA+49NsKDRSsCqvQXNo
 jOB4pCllmA7aliehWuE0DSxsu2VOxvbT5WsKNS8S1TiZflGfw8P5RokOI5aICWsXLpHw5jTmiqg
 ibWKtJgpU5Hmta3e9RgzyMgCygUTxUk6ob0NLFeckAl1kIyhrdQ1yGqmmCSHbI+EY7A==
X-Gm-Gg: AfdE7clhTdEtyDHVsBxG7ZBa3FpCyTvWq9lMmcS6GWHGDohuD8pnz6Laf1iSusR5Gck
 nbjF1PSSjOkXnaQ7yi3vHLma/kUqGYEHOXGihGOm8qt7UcJD0YN601LDbLBUPnOmkEGehWwiz/u
 YweE1rb2m3FznPP1EZldNTmJXlC5g/C1ORY40//uc/DbC81XeSqM4gZU0ycrq2MJ2D0TjPjBmqG
 j25PGwGDuMMkQuHyeHHsedMWkbkRF+QaCte03cnr5oRANKMTsZI7BVfqOYmL9vOkapaQ7/09TkB
 LHHPkkm3SI7FxFAjpdKKW9O9KyHdzZfT/7KeAXFmnT0s3y9SxGKbmYO2Tv8AXxZcUIU5CrconYM
 ldgWa1QrlteMaz/7A16ZLVvF5kG1cTaGNwVa6RJxr5k29GQSJvVNhz2BKBm4=
X-Received: by 2002:a05:7300:80cb:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-30c1dbd3d85mr898467eec.17.1781911814813; 
 Fri, 19 Jun 2026 16:30:14 -0700 (PDT)
X-Received: by 2002:a05:7300:80cb:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-30c1dbd3d85mr898440eec.17.1781911814316; 
 Fri, 19 Jun 2026 16:30:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 41/74] target/hexagon: Implement wait helper
Date: Fri, 19 Jun 2026 15:58:38 -0700
Message-Id: <20260619225911.159473-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: HJY8nt5pEvnrMR_mdZdzzvaoOwhHCZEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX4KSZm8XVALSH
 tMd2E9Bjd9HCUxTQ7RmkEwR38wP6I/Zank9IaikakOgZkE9VmyJA+A4/kXAROsJQmysO5kkQq8/
 M4AGPHJoLtQUdEyhXqwYLiU/MJXkJpCta5mW9XFnog9kVWeK9J/3YKT2NmomN5Iah+5rZGn2jf3
 bmXvr7/VE95aJXsQ756sAH6BI5cGEWgKJa7h+/9F4J6p+zaX8+6U7exKQwVNXbpYfOOOZsyv5+C
 wEiLRUEfNd7trny9yx9CUxCnAUyOliNUVspD34IpL3gO92StlnBZF3obJWm1bv2MPGplDEzTz9J
 GtKpq5nUttwemzyRhGQketpDHp0w14+uzoA/TFJ/fAJ0p1PK9FAcLnABwoliBVZzbcrd8ZQDdft
 YScVOToB4hPOiksC5NEI9kLdx8l8sqIDapJPsVgSb93fj1Nh6d6AFjMhALHSxhkifGl38RNshK/
 yvDlFAInb/risrQO9tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX5D0KgosJH1bE
 pBi/SDWzDVRd5LjHRUqvdbOU7hGLZ8mabDKr1pK+wo+aJgXeAGaAogj9Vgqz6eEGRUhgrUfYMyc
 /9737O1c2WvtmjP0EIgZ7YmTtTnVo5k=
X-Proofpoint-GUID: HJY8nt5pEvnrMR_mdZdzzvaoOwhHCZEs
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d107 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

