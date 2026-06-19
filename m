Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E739CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBU-0001cx-1e; Fri, 19 Jun 2026 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBT-0001cj-04
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBR-0001Xv-5f
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXi291368803
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=; b=A2dl6BfKLCDkS5oW
 XzCWSMZI5eFDJ4eLKwjmFvl0eYqsK5qEEjTioiZmJOHfrOhz2Nk/Qn5nSbGGs0hU
 kLLXIPz19hnRONidWYW98LUibhPMutdJ67LC5738DHb7xuP7GP0K9UsoYaVXziaa
 rGIWUb+WtXLIKP0ca2u/+5iZCGtp0Nrjvf48cABkoK0rvRfq/T4rG8UW0xcaCqws
 NF36TNUpBbXjRw5O/CcgiPAKJSawujx95nNtj+KqbFEeyk2Jv73IdjdBtOekHOSt
 uLqRp+RVB95wkxjxX9wWlQchlpkwbFJKJcTSy1mBdMM+h0piO9W7DpbO49SmLuOn
 206kRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewcy30brc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bccca5620so3385215eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909971; x=1782514771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=IOs4lL2fFLjGUW0Ka4e7VQnXlwO1i7SEiEV99qyxLsvsG1YBcxBKhUMLHFLv2/mBCG
 GZ6m5AxNFXg0qC6QouLB1dbVGh0ioX4n66MM4Fk23yP8ejl1zZ0S/tDJD5fz7GkFQjly
 BBreLJnIlnkuzvGVxwrofqKX1olgq+/7yBulPJ4nnHharq46E0fKnOF5KXgUm7VP0jTL
 WZACn96wvsZ5tcvb/lZ9eFh3dDDAGyNJy/iL3OZ3luTYFC6/NoP3EsFk8v3AZTh8ORSj
 WdaPOhxSgAAqtlqAk1A/Bdmb1mg0Lb3+v0cL82dOT0KAoQvT1SQcCmKz1OEQj8ZGOH01
 gLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909971; x=1782514771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=ZhnZR5iybXyXvACe5Ot6iOI5ELkDaZgyDImn7xwoRQ60rjirxr65tIr9JVHjkLZgnc
 2KkmihDHwaoQhOD/XWwFgeunXCgLYrHkN0SrGqgzsYXC8mSjuZK7h6uxsMMWpGK9JScQ
 0HCVP0l3mv5kMgXtQGjLj+IBbNM4F2ZTgViTPSuEavUlQzKoe7JaOUojZ4XBsBTs+w2l
 5DoYjJ49/QEs4OTIz12oQ6QDaAi4sRc7o3qY35xDomFmehwS3UULoq4HtyA8Wgaal2jY
 A1sM0CV8KlOJx8cC0SLQ4Pux1tRHGJaD8IdYsCZO3Qdhh5wWM7k07uEn6bIMcIYfCr4a
 dQtg==
X-Gm-Message-State: AOJu0YxN8XLtXxob0t3/ul74p+xZHd3CkAK48OBljwwGWKBoy5+3uPw6
 5UTF7OpOHs1Lx3D0gX49oBzftOw6v7/VgwOVEqyfQe9K3b5TVDXDnth9MUtIc72qYGFFgI2dWOA
 nKVN1FR85Jd505vH72AVaczOfxlLiaPAdRp/7/1ogudmb96/pPMG8BJ5yibE4Na+LnA==
X-Gm-Gg: AfdE7cl2K/Jnu7eISBp+CXp5ruaJ0CW+PJMIU9T7Igd0mNXErHgWM6KrVcdsh+gYY+J
 oH90318h7ERiImzWt850Z7DNyM4gPWynNVPKphHZ+uHlY55qS7AtWukDs29tjQ3FcB1tI2U6FgO
 SN2YIFD9EuRJQ55A5tc4emIyty295e5ilozSdeojgYx7CXrYetqzZHO2G8c7pkDpDdrvThuLL5k
 lINxwHvCFe0A87JSncWqsPdFHrNVOWV/FWxkfK2CEJOL5N8SCJyJFqtr9OndAWZ2aQeONsvJXee
 kTZP2UZXtJ+cPOOzDx3nKw8gTI41jQxiWWOp0/xnlNmxQ3MA/zL2J38NGFBFP2eg26EEr/duO8G
 Y2ariEWPROYQZQLztbETSI3NGQ159ki995jYh09PDRpeY8ZxGJk5nISqzaX8=
X-Received: by 2002:a05:7301:6084:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30c06e0e5d3mr3200785eec.4.1781909971312; 
 Fri, 19 Jun 2026 15:59:31 -0700 (PDT)
X-Received: by 2002:a05:7301:6084:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30c06e0e5d3mr3200770eec.4.1781909970777; 
 Fri, 19 Jun 2026 15:59:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/74] target/hexagon: Add guest, system reg number defs
Date: Fri, 19 Jun 2026 15:58:07 -0700
Message-Id: <20260619225911.159473-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Gom8XFXEyc0NLeQAlkMvpi86CvrM38R7
X-Proofpoint-ORIG-GUID: Gom8XFXEyc0NLeQAlkMvpi86CvrM38R7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXwvM/snK0rkvt
 FK1xmPh0PWbEQoPe0th/qqx0gQDbNGoRzc5x6pYl/SAZkwYET32pEar5t8UmcaH35ctwVD9IkdH
 U1N31nK/ed9SkIOBkQv6c6sDZhNlqAwh2f2lRBRawI6m8KN1Ew/SCdDsmYB9ay8xmgWuKF1DgkG
 hGJgA8dyDPPwDWzD+wXXwQJcijkJA1UCXgY1xksi8mCPk1UCoDtKUcpD2zJrfnDJdmWJYutOhU7
 yV0AAvxHvrmPtPsb0FCbyPAZt8HTQO3CYa1nlqE5cLMVsIYv6wS+sabopfO/nNLjgLUAaM3WsU9
 iI0ulqc90XRn/qCdwuwfgCoaVofW8e1aAcRRbSMmzF/uNTDWGKoxDyPk/blxxCgDc3ePYl06AFJ
 itTTNmWOrwRCuLRhdmdK32FhIa7aRrbf37fTmr/R+OIVmy0hSKjXmLF46XfIFyy8o43DCLi9X6n
 Kz4OVJa+bSN5QkfcT9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX5jqwQeXClKxh
 uOMd4HckdHXpVosXK8I/SPrSzVWBen+U1+yYlce5ULM9+xko2kMGQmZxPpj7lrPhewsWj2vfnCK
 7Ogq0U3YefKLoFMp3yAbhmoZS78oCVg=
X-Authority-Analysis: v=2.4 cv=ZOvnX37b c=1 sm=1 tr=0 ts=6a35c9d3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgIDcgKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIHwgMTE3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQv
aGV4YWdvbi9jcHUuaAppbmRleCBlMjI1NjdkOGU2Ny4uZTBjZjg3ZTVhNGMgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMCw2
ICsyMCwxMyBAQAogCiAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC10eXBlcy5oIgogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdfV1JJ
VEVTX01BWCAyCisjZGVmaW5lIE5VTV9TUkVHUyA2NAorI2RlZmluZSBTUkVHX1dSSVRFU19NQVgg
MgorI2VuZGlmCisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29t
bW9uLmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKaW5kZXggYmRk
ZmMyODAyMWMuLjIxNGI3YjhmZGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVn
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDEyMSBAQCBl
bnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hF
WF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBc
CisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwg
ICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwK
KyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xF
XzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hF
WF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMp
IFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdD
WUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVD
TF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAg
IDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JF
RyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisg
IERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05U
MSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVY
X0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUg
REVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhf
R1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVT
Cit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKwor
I2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZh
bCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVt
IGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdT
IHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIK
KyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVT
OworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xf
SEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19V
U0VSX09OTFkgKi8KKworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitlbnVtIHsKKyAgICBIRVhf
U1JFR19TR1AwID0gMCwKKyAgICBIRVhfU1JFR19TR1AxID0gMSwKKyAgICBIRVhfU1JFR19TVElE
ID0gMiwKKyAgICBIRVhfU1JFR19FTFIgPSAzLAorICAgIEhFWF9TUkVHX0JBRFZBMCA9IDQsCisg
ICAgSEVYX1NSRUdfQkFEVkExID0gNSwKKyAgICBIRVhfU1JFR19TU1IgPSA2LAorICAgIEhFWF9T
UkVHX0NDUiA9IDcsCisgICAgSEVYX1NSRUdfSFRJRCA9IDgsCisgICAgSEVYX1NSRUdfQkFEVkEg
PSA5LAorICAgIEhFWF9TUkVHX0lNQVNLID0gMTAsCisgICAgSEVYX1NSRUdfR0VWQiAgPSAxMSwK
KyAgICBIRVhfU1JFR19HTEJfU1RBUlQgPSAxNiwKKyAgICBIRVhfU1JFR19FVkIgPSAxNiwKKyAg
ICBIRVhfU1JFR19NT0RFQ1RMID0gMTcsCisgICAgSEVYX1NSRUdfU1lTQ0ZHID0gMTgsCisgICAg
SEVYX1NSRUdfSVBFTkRBRCA9IDIwLAorICAgIEhFWF9TUkVHX1ZJRCA9IDIxLAorICAgIEhFWF9T
UkVHX1ZJRDEgPSAyMiwKKyAgICBIRVhfU1JFR19CRVNUV0FJVCA9IDIzLAorICAgIEhFWF9TUkVH
X0lFTCA9IDI0LAorICAgIEhFWF9TUkVHX1NDSEVEQ0ZHID0gMjUsCisgICAgSEVYX1NSRUdfSUFI
TCA9IDI2LAorICAgIEhFWF9TUkVHX0NGR0JBU0UgPSAyNywKKyAgICBIRVhfU1JFR19ESUFHID0g
MjgsCisgICAgSEVYX1NSRUdfUkVWID0gMjksCisgICAgSEVYX1NSRUdfUENZQ0xFTE8gPSAzMCwK
KyAgICBIRVhfU1JFR19QQ1lDTEVISSA9IDMxLAorICAgIEhFWF9TUkVHX0lTREJTVCA9IDMyLAor
ICAgIEhFWF9TUkVHX0lTREJDRkcwID0gMzMsCisgICAgSEVYX1NSRUdfSVNEQkNGRzEgPSAzNCwK
KyAgICBIRVhfU1JFR19MSVZFTE9DSyA9IDM1LAorICAgIEhFWF9TUkVHX0JSS1BUUEMwID0gMzYs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcwID0gMzcsCisgICAgSEVYX1NSRUdfQlJLUFRQQzEgPSAz
OCwKKyAgICBIRVhfU1JFR19CUktQVENGRzEgPSAzOSwKKyAgICBIRVhfU1JFR19JU0RCTUJYSU4g
PSA0MCwKKyAgICBIRVhfU1JFR19JU0RCTUJYT1VUID0gNDEsCisgICAgSEVYX1NSRUdfSVNEQkVO
ID0gNDIsCisgICAgSEVYX1NSRUdfSVNEQkdQUiA9IDQzLAorICAgIEhFWF9TUkVHX1BNVUNOVDQg
PSA0NCwKKyAgICBIRVhfU1JFR19QTVVDTlQ1ID0gNDUsCisgICAgSEVYX1NSRUdfUE1VQ05UNiA9
IDQ2LAorICAgIEhFWF9TUkVHX1BNVUNOVDcgPSA0NywKKyAgICBIRVhfU1JFR19QTVVDTlQwID0g
NDgsCisgICAgSEVYX1NSRUdfUE1VQ05UMSA9IDQ5LAorICAgIEhFWF9TUkVHX1BNVUNOVDIgPSA1
MCwKKyAgICBIRVhfU1JFR19QTVVDTlQzID0gNTEsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHID0g
NTIsCisgICAgSEVYX1NSRUdfUE1VU1RJRDAgPSA1MywKKyAgICBIRVhfU1JFR19QTVVFVlRDRkcx
ID0gNTQsCisgICAgSEVYX1NSRUdfUE1VU1RJRDEgPSA1NSwKKyAgICBIRVhfU1JFR19USU1FUkxP
ID0gNTYsCisgICAgSEVYX1NSRUdfVElNRVJISSA9IDU3LAorICAgIEhFWF9TUkVHX1BNVUNGRyA9
IDU4LAorICAgIEhFWF9TUkVHX1M1OSA9IDU5LAorICAgIEhFWF9TUkVHX1M2MCA9IDYwLAorICAg
IEhFWF9TUkVHX1M2MSA9IDYxLAorICAgIEhFWF9TUkVHX1M2MiA9IDYyLAorICAgIEhFWF9TUkVH
X1M2MyA9IDYzLAorfTsKKyNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLworCiAjZW5kaWYK
LS0gCjIuMzQuMQoK

