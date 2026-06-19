Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EF6CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig5-0004Di-CZ; Fri, 19 Jun 2026 19:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifs-00047G-Nn
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifq-0007UH-Tx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXfQR2932967
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=; b=SVK3tPXgqy9Xs1KV
 Nbhr+pcha/RI2AqponBkUufTVdt1e+VgiQS/Dpx1RNZQ47yR3lZMWQ9Ri/KeqTbZ
 RaUdb72lCmgcQyhcXpCZ4WBQ19yLAsmxDsIP1c7vuDbWFmDSAjVlTCVn7woMb8X8
 KtsAT9xR0z4OMEEgrHIh2qG7qPpuYNPXUwaZN4P3VdzAMWAKZjmbvrU8oX9WwKfM
 zVE2N5c6H5ThBvvNo7aI0/zXjoTQRFdy5POWh5BSo7+0GkGVoDoufJ7q2U2uW8Uy
 vuIwWjfoO8/tYYY2BWIutI0zF3TncViswGZrX43WOXgAXvu2hR1NYHFqAqxiyPzu
 CWQFpQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa52e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4441800eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911847; x=1782516647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=Blc1amioIC5fEJuq/yDJIzGHiabpVG4fVxKdP2z42vDvOyhv4FSFlmhoCUFRLszzvs
 Zp6qo+7meOaP8Ql4L/vU0fwrnsFsNJw9/PeB/UYVcTFNCt24pUoId2Jkp16+fIpS972y
 ZhUgA/1Ub2yN4ZVdtVhtogoVxO6HOIQeOMeo3MbPqtGEjok6/NgZ1q/5hxfT0DZNLsQm
 J0aNjjeOa30vcj4PzOaR/gFYVIg7ba7i+98eTHxKAzlxt7P/3fPNFOd0Emon0pwigShJ
 R5hTtFCzMAJ56ueK1XxNo0p7I1G4MsMdTfz9xEEXFRbP5/VBIkRgQ/UHqMadf3BEhX0S
 1Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911847; x=1782516647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=YSbucTA30cCDKF/dz/BTDzq03F7HkjznkUS67V+BIuUtCYB75eIEsx1IMLUhDXNlnE
 eQSS+r++2G3vlhsw+KUItW06CRadxeveskerMGL0tHmQUUc6QnEfX0llUAx/He5y3mYz
 VK/55I59slFOJl6PrW10aaEOW+TAc9G/f1kyak/IV69MnDhvbVtmnLvETd8KDthwBIoz
 8mtru5rncdJKu7Mq6RcGwgzJKUoRDnywkG0zSYLXq4ORbWuUUm6V4C6PyRQlePsckFHv
 T+AAGDz7XzUyLeFj5+PM4Ea+g1SQyEcHc+iGUKocmUv5Mh2ckMdjPZnhvw2ZAEFdoetp
 8jtQ==
X-Gm-Message-State: AOJu0YwZADY+bhkj5SBTXl4kuNwlbAtOb/Y/5Jq+cKJ90rr2vK8g/5eG
 qCTLTBSsW8jwC8nGfVicYLzuvH7mN2QXSyyKx4C8HhS+JMl7Svl/cC6D2eauPztOe31OzAj43MU
 YJeuAwNwupU9dTVJ2sVHDat6vS/dWRqi5Nf+/2ZMqkFdeKjz0+YisvB6r2rJg+dvk2g==
X-Gm-Gg: AfdE7ckUT4YU+HOW2yXdA69TzJYe7HSJSe6/9FotP8RgJ09KnHBoBumsJi60OE4IFfE
 IrKwPxXKNvNfRr7Uy41ZopQ1BtfWG9bY+9+B4JhfzJ8EtJcTEfkM6l3xmNFM+Vop4MfH+ukODKi
 RgKdtqHoNZPOQC9/oEIWUsQftiEX6zbyUT4UynkWZK2mvm2J4wo5Pz4VYsfECzMdI2P6o3uhoYH
 X4/FojiJK6bscyqDDOKto0gDeDOVUlIp4COIkykPS3SQrYGkiLn5j1zFCFgGVknY6VEBdIsezL/
 c7EkwHFGP3P2gZpxOw5j/+bvSK3+d2pR6c4YR32XrbIslS1GOmm7Mm46qdHrkOPND8HWA8gI+0r
 sfrEn1FSxKALUWsB/6FW52J+iNcgUDonpQLiVu/wJjhZW1QR3MAd/3iW4Phs=
X-Received: by 2002:a05:7022:42b:b0:137:8bc2:f501 with SMTP id
 a92af1059eb24-139a4e9bf7fmr1707423c88.7.1781911846794; 
 Fri, 19 Jun 2026 16:30:46 -0700 (PDT)
X-Received: by 2002:a05:7022:42b:b0:137:8bc2:f501 with SMTP id
 a92af1059eb24-139a4e9bf7fmr1707411c88.7.1781911846259; 
 Fri, 19 Jun 2026 16:30:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 64/74] target/hexagon: Add guest reg reading functionality
Date: Fri, 19 Jun 2026 15:59:01 -0700
Message-Id: <20260619225911.159473-65-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXwwV2aluzDdIz
 lsi5+t16rO22G11wfMue1BjRqczsfNzJk2MN9RKfuGGz1OaRWaTxRtZvuaZsuWxrX5KNOHEtiRc
 M+BcMUK5nyVCYJvWMWoY3ycm23YZtl9CyXhKhgCsxmfyPBfSJhunO93KP0f7KH1bBPSTI1MgDYB
 +hK1fSk13JIFgu5D3LBG10bySu0Ga4PPZvj3UswJZg8DcO3/9Lt3bpYwSjmmJU4hVsRHZZJpb0Z
 4flEohahqEJbabYQgqi9rW3O9T1t8CDsYcoiMdbolGkzC/cDhq6Xa+VXMF2iSdULppNc316fWr1
 5vjlk3D+eoq0iQaD13kAviqwMEdJxYRVSf3bk9UNs4YPyTYqLfibTZh5BJgHWsZ7VSm39hmp4vW
 DpSB9Oflwqcgy4+/YsyDAM6qVMiI51pTmioO5zWJwCYP4q2/9ijErOxzSxOVpvkWMPzkrkdK5qi
 0WcynChesedm4euxLzw==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35d127 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IJQQmebJWjVxhimlKuwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OXo4Em8EeO1Q8z5F2Sr_txFOWo4X5gyt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX6MH/wb4A3yS4
 DP3d+Pgmb7IHG31caDFxjKLQIwo6gUUnq/W1Y9Ou58kuSSBaxCgzhDEYfCIIke8nTDN8J8Jvu1u
 0p45EjngOuU0yylytXhSHZIG8XTgIWw=
X-Proofpoint-GUID: OXo4Em8EeO1Q8z5F2Sr_txFOWo4X5gyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICB8ICAxICsKIHRh
cmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNiArKysrKysrKysrKysrKy0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA2YTk1YTZiYzViMS4u
NGExMmRjMDQ3MjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0yMjAsNiArMjIwLDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFn
b25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqIG5vdCBzdG9w
cGVkLgogICovCiBib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRl
ICp0aHJlYWRfZW52KTsKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCByZWcpOwogdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKICNlbmRpZgogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGIzNWNhYWVjZmFlLi4wNmJlNWM4ZDQ5
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTc3MCw2ICs3NzAsMjUgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICNlbmRpZgogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8PSBIRVhfR1JFR19H
MykgeworICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CisgICAgfQorICAgIHN3aXRjaCAo
cmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86CisgICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAgIGNhc2UgSEVYX0dSRUdfR1BD
WUNMRUhJOgorICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdo
KGVudik7CisgICAgZGVmYXVsdDoKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJy
ZWFkaW5nIGdyZWcgJSIgUFJJZDMyCisgICAgICAgICAgICAgICAgIiBub3QgeWV0IHN1cHBvcnRl
ZC5cbiIsIHJlZyk7CisgICAgICAgIHJldHVybiAwOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0
IHZvaWQgKmRhdGEpCiB7CiAgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhBR09OX0NQVV9D
TEFTUyhjKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOGEzNzIzY2JhZmEuLjEyNTk1MmFlZTU5IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTg3OCwxMyArMTg3OCwyNSBAQCB1aW50NjRfdCBIRUxQRVIoc3JlZ19y
ZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcp
CisKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBoZXhhZ29uX2dy
ZWdfcmVhZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7CisgICAgaWYgKHJlZyA9PSBIRVhfR1JFR19HMCB8fCByZWcgPT0gSEVYX0dS
RUdfRzIpIHsKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5ncmVnW3JlZ10pIHwKKyAg
ICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsgMV0pKSA8PCAzMik7Cisg
ICAgfQorICAgIHN3aXRjaCAocmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Cisg
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgZGVm
YXVsdDoKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJl
ZykgfAorICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcgKyAxKSkgPDwgMzIpOworICAgIH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

