Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7684EC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqQ-0002sZ-3m; Sat, 05 Sep 2026 14:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq8-0002lh-OS
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq6-0001P4-Ms
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcCe02452017
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xaxst8wdMWsPo9+AMmjwvV4s5Q17/pJQfAEVLaoAtuA=; b=CW09+Zq+4Ws8vq7o
 M4+XZU7mNysIyQPx2L42J4AQXYVgsI4iJAxUrJBHmbqmj/35qCI++MrKGCggliHA
 +nSA3YrB/JCcy/QuCydjCRtJ8gXqvbj1Tkw7x5xc6ovyJgyt4jc4JALR3/HIgpzV
 B7L+Oqq4/WSy5ThmX74A8u36Vrru3eipBIDZJJOscILv5koVfjTvsXc0fSbASaWI
 vKF6yrmd/sv2scXKpelMg8H+YJVKkyLTO7aeaehSAtnWfRbtIaM1abMP4fxaHzof
 heTacs+RMyGRivWow9mM8D7zMxmAX/sa3Sk7DDYUdBZXJbCbu4qLbsAfjKZIv63E
 P2RDAg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuehxfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:09:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc435388657so2725056a12.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631795; x=1789236595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xaxst8wdMWsPo9+AMmjwvV4s5Q17/pJQfAEVLaoAtuA=;
 b=Yn94pFej2I0UbyAHZXQUbt8hsImrtSPE3Yns4CyAKaE+qhAgc0utuzuk+dy3rPWUsW
 oelEPXR1N7z8q3csBboymy+ZDO0cUczGWHYXn3LIvtpKnwtGRzMtQVWkpnnOvc5kg3Ey
 dFSJkKxiKCofPUnhCt5FMxXD+3JRsmUUpWrBaSwhdph0K3juq/R6etKjvL2/vIVW0XxY
 qyRkqd3vbn63iLfgis3+iZWgDr+PtfiBFPdqKE40N4b1s5WL882DXF30fUXXFxsrliNQ
 lx1H73bkDZPaH0HAzaJJJn27jnTDdOMWxZf3sO964R3iM8fc48oozYIPQLPr/YN7u48m
 /H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631795; x=1789236595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xaxst8wdMWsPo9+AMmjwvV4s5Q17/pJQfAEVLaoAtuA=;
 b=OOb+wfR927bXJCFOKx060FGe0l60PuMxdVxhqUIdGlAP1KROzDpO7bVHVdDmUwAk27
 Xsr+UvuxQJYZyNyqm+oEBngqG12UsMWNPUP8PW5IgWhHX+BVDHNvz5YBPWCwgxkvr96K
 9oF+M/Mi9QD/Hs4aUs2f4kFqpOhwzhkYkp9nZQEs5OwkU5nwPT8ILUIYS0+TJn5nMQrb
 Sp/zPKfpZvBxlC3wzGVx553ukKqLWJACCRBbgXiVMyZL7xtxtSxYxMkMkaMHEseDCKku
 tZ1l3XcGl+0Om9Di4YQ7oo1eseeZ9TYv3sVKb/dQCzUQYG2aEGloH1O2E9Ux+gc1KqZU
 d5xw==
X-Gm-Message-State: AFuF++m09MnJyWw2DJXOT7Qgt0AjmCUoxUkQKSoBaU0g1gMDLOIcXQdf
 utPwEjf7gUimwMYlRasMUFtzrd3JvByWW1CAAwUw3rbhi0irgj/PGxUFbasB2sNiTju9ZTvZFal
 voWqFs3YqrgvQp83oSuMWj72MwcBsefh3ji5N6IVFmPLTdph6HEJDKzBEEFiLvvmMRA==
X-Gm-Gg: AYBFou2BtXV2KpT+QsrP0IqF1uu6RoHvN5kFQrrdXmm093Y9A++2o0H02RROScVHcIX
 PlYanFFSDNWKFj5TJUsaeIyuwUSS+lHnVacj1LD2oY67F/QJQgv6LHdCophctV3l3TQt7CtHfre
 F6HonZLMQGJOBbNnSFJGOSktlolGrXYcx+rOEXwLmgrPtwwk8/lOf8mfIo4ILGetW5b/ofI4Xrr
 TN5iJQfqKuzsbF2FceWKZLrBC6jvjvXzWYbS+kIuyx6ZYAvs1J8+NNLB6J6WKeLjsAbBg7E3cJY
 lt0P5S2408nRZs5is3EFRPL/7A6aITp/Lc0Jbo8J1WVHMJ2Lhaum6uPPCuxm3o7vFFD2JERkR1W
 MpqYdVm1S2xfZ0DCbFC31Pv0POXaXz0d0KKtLqKWyAcLH7ZlQ
X-Received: by 2002:a05:6a21:394a:b0:3d0:57c3:65f4 with SMTP id
 adf61e73a8af0-3da39cffe6cmr21516988637.5.1788631795521; 
 Sat, 05 Sep 2026 11:09:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:394a:b0:3d0:57c3:65f4 with SMTP id
 adf61e73a8af0-3da39cffe6cmr21516938637.5.1788631795043; 
 Sat, 05 Sep 2026 11:09:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 02/17] tests/tcg/hexagon: fix undefined signed left shift in
 brev.c
Date: Sat,  5 Sep 2026 11:09:34 -0700
Message-Id: <20260905180949.1852673-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX7lXi0HCz+i2D
 Aip57Z6cR2wI0z4pEX04uw1R1tbAV4yQpVaKqnH9ud9Vssz/7gwfk/rFIGjmacY7ePbxYtCWFJa
 WKf8DS5Lu1A6WvEXP1rJKH9cHzLjqh8z9iivZt7OB4eFhgPooeioCnhjGHnOdAjikfuO3bCRAc2
 qYyJcCxSwn40YRwGU09+YYoO8XFSUlpulQJLTgbSSIV2fcBXm8lRnWHhLkSiuGy/VGXMC07q5Y3
 RjR7+yaO0c/CC6T+0zmrtKIfS/dW7encvEz00z+81cE9eNzuaZqR8A2pD0xP6wAuCXJlc6lapq9
 nX8j1dm74WgndYjcDBWW+tgfQyckTqIY5qjq1bxZyEm2w6rDvEQBMQcWbVFGNxNRDwKuTw6zlpm
 No9P1CfC4jFBYf7CH08tE7WjihsF6aAzlSXLhL9middJpynQ+tCUeiY8AHNLob97L8NTBjqprLl
 X0zFqoYfAQXpGP+pXIA==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9c5af6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4mfA0qixJg5lnvjYkK4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: lIlnVYu4XB1v3UFdsufrpBfGsmPKMhfM
X-Proofpoint-ORIG-GUID: lIlnVYu4XB1v3UFdsufrpBfGsmPKMhfM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXwOLqppHnI+j5
 0qYEIA879LEC0FvsQasz1hrxBWFgY2MM5VmbLMsxRus1gXq9Vv4//WnZinmoHDUo0B3Wjr1Y5Kg
 wT8HPnHOgYevmWBgdi1WUa15vl3dcR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBzZXh0OCgpIHRvIGF2b2lk
IHVuZGVmaW5lZApiZWhhdmlvciB3aGVuIHNoaWZ0aW5nIGEgbmVnYXRpdmUgdmFsdWUuIFRoZSBz
dWJzZXF1ZW50IGFyaXRobWV0aWMKcmlnaHQgc2hpZnQgb24gdGhlIGludDMyX3QgY2FzdCBjb3Jy
ZWN0bHkgc2lnbi1leHRlbmRzIHRoZSByZXN1bHQuCkZvdW5kIHdpdGggVUJTYW4uCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVz
dHMvdGNnL2hleGFnb24vYnJldi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vYnJldi5j
IGIvdGVzdHMvdGNnL2hleGFnb24vYnJldi5jCmluZGV4IDZjN2IxMzQwODQ5Li4xNDczZTMwOWVl
MCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vYnJldi5jCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL2JyZXYuYwpAQCAtMTA2LDcgKzEwNiw3IEBAIHVpbnQzMl90IGJpdHJldmVyc2UodWlu
dDMyX3QgeCkKIAogaW50MzJfdCBzZXh0OChpbnQzMl90IHgpCiB7Ci0gICAgcmV0dXJuICh4IDw8
IDI0KSA+PiAyNDsKKyAgICByZXR1cm4gKGludDMyX3QpKCh1aW50MzJfdCl4IDw8IDI0KSA+PiAy
NDsKIH0KIAogI2RlZmluZSBURVNUX0JSRVZfTE9BRChTWiwgVFlQRSwgQlVGLCBTSElGVCwgRVhQ
KSBcCi0tIAoyLjM0LjEKCg==

