Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A8CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBu-00025X-CU; Fri, 19 Jun 2026 19:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBr-00023K-AH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBp-0001c9-Qq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYkhe1287266
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=; b=nM
 b5+HPovzAtddGxgPkz9s96CZGO+5Fig3pJvLl/xVzvzHPoauWMvl8eZnHJaoLeoh
 ap/FRFjKQ8y97Wz5l2Dns1pG8MC44oMmTh5iiEJ0SZXQUTS2tyltzFvGP407hNnd
 egxslSCLCOh8wL/5s1LXllO+X07G6HCA+Fqc4AhvBhYClBCp9uw5g1zNuYGfV5M7
 zilpCsJtM7hezpDy76tmU5FSPJry8B8jZVsvS/aRnq+jVa35kjUsh3OzyJrWGjSx
 xRZaLbqsG6AAqIU00Xk2uDTi8T89NCUQhDyM5O6Vi7kiwhp9Wl/y4jC8JGtXG9D6
 OCkvffEFohO+ssFqOJBw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72k81x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c108c19d4so1091133eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909986; x=1782514786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=KWP68ECk5k5Pv5CxqsNJOT1RC6WCF5X/cEolWx8vQmx8KQ7GsuP/vSfi049K3p/p02
 po3rsPB2XkcGerAfcgLn9LkrcxuTA8qGQ3rkT1geBYtbEwxCVKt6kQYNFItDerfzdiJR
 tIWS+5aX1Xth4aD0tYwEj+QM8oXUYtisNU6H2lXQNx+C3+4tEz42yjUKtgqE+Qnkf3uS
 q3Nbk1McIRWo1tO1wbHIWmt+qm0SCIuUk7jXnbtYf0CbouAlts+ipHvIy65zqG06DPQW
 QratDihrkVTVVHPH0W8YxriUAjuoBGBclNbDsSW2FTWtKmMyhcI9FaI7Sg1MMsRUM4dS
 Hs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909986; x=1782514786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=LTu+0zYwI9KbzHMCunAJxc1mX8p9HwJgC+d+WhvH6dEgELlHqu/SGIDMW8/u4DvY1v
 HZLgc8wpU3eXZw+CdzH/PI738GWQEhfuhn+ACBezTk8sraSvKx1DzyS3BJvFLG9M7/qD
 x8KMTS//bt+BK1jp2OWeR322rcHPZtVfkPkRnIkXox4lnMEBDwtbVoESuTHqTkIqQN8E
 FJEsK9Ha3OwolFSc4BWQFhTaKyWpRiIRCe/K+dKKtKqOtfwO4LdP+Y6o3HbD8SIBQqwc
 CBUAgNDXF339AT1as83HhBMaaMHADmyNzkpivUAR4aQMW0nvJ0sgePapA9mHX4wBxx5n
 bXfw==
X-Gm-Message-State: AOJu0Ywyt9X7Hyl3HERx56bcvgsHMrxQknozb4CXHbpgLL8/Z30If9gn
 V+djLR+UhR2O1kPaJ81b8+T60pKRFw2DKBVpZJ1fbiocZf/uCeIIyzOzqhUDpTPTtTrdrnWCXsK
 ppiBJ8O6q8FUDGYMreZp0bkNZVieJZwwQGBtD5pZsn/cXbsd4dgPZETN7YvYW26C8xg==
X-Gm-Gg: AfdE7cm0xpDp1QgjEQKXpqkU1f1ePrHWwX6m2NiuSjngX3Z5Uxx4a0+cDhKGY2syD/D
 GSuXHUeat1Oqx9F4kRg/RyvzrZHd5MNOuRhzCnSMCc6b28F1dEJ9T62kyr/m9wGwe/CwfLFf8YV
 6cdu1JlqN+2o9IPU1lg26nrR4SBbCDvehGRiJsks61XDXwWoAbWoD3XjJZ8/1+xuJMT5UTpvHYH
 w0zylw2uLOQWNxWVGoNpwyF8j8vMVhRUMLiwu3f1REljPqjIXuZjK+tPg2rCpD48YrPWR6qAraw
 O05eqOWzmkmwWWJ7c5KZ2VKCWzeZX4SXm7P5ZCSMPwK3WkIT32uZOVsGPFeCVqD9oVFoEmjon5h
 okh2BX3Dnnbo+cWxKSPuXfin86azi/mwkj7+zOUPzanZ98b2kqRVmCw4lGhQ=
X-Received: by 2002:a05:7301:2f8b:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-30c06e33661mr3421792eec.12.1781909985820; 
 Fri, 19 Jun 2026 15:59:45 -0700 (PDT)
X-Received: by 2002:a05:7301:2f8b:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-30c06e33661mr3421779eec.12.1781909985350; 
 Fri, 19 Jun 2026 15:59:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 21/74] target/hexagon: Implement do_raise_exception()
Date: Fri, 19 Jun 2026 15:58:18 -0700
Message-Id: <20260619225911.159473-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX5UZKkEs0qaLC
 HwgZjwPv1PTm1MpZgI7QEBXgJITWjYhFddemYSrUXNG6en7BUziibvsipRNaJj7gVwV71LLqK99
 jN1FnQ+vM7PeRddbJf+QD/jrb2rruGjVaEiyoDViW7MhdiZEr2XSDXtIoyJfWnjBdPVwbLu+FJq
 3ifs6bbGSSh/ZXbiecV0fZcfDc3dwPo/0xh0RYUEC6fGhGAAVsvRCK+PHvhYnz65QA7Rw6PnwLX
 J1jMzFpeGvOfEWcU4Bx3uQDONZ7S1ZuNcjQF+kEFQ6qLALAjxGHXDlgTvl+kppC0B+XPG6yEccc
 kPwiFOT6i9PZztD34LCry1PyerNpE9eQYfH5+WQfJoM+cNsuRPHjPbrjFPnW/pEnJUZZVHegkdI
 kJGWRGF5epJjuFasw3vqBTujemkhU2quQs+rJEfDYItz2AP8oKj26VOk2XErTM5PurjyUkE9vp6
 RgQqKgZuxoawQLorv7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX9e5WPeNJXoji
 qDkEOFz/0sCWI631GajrmAV97R17H+tGEGxjvjbBglGRQmgeFArHkWoZT6134amiQja1wUyrfT1
 HAYL5Yb8QKN5YrNd2KAkixO0bONhAMo=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35c9e2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4IZq540jm7yFXG3ErPrR8IM5IVVC-93b
X-Proofpoint-GUID: 4IZq540jm7yFXG3ErPrR8IM5IVVC-93b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjZDMyNGMxOWE5ZC4uMGY0M2E2NjYzNDEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MSw2ICs0MSwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

