Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E05C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2U2-0007HV-Tl; Wed, 12 Aug 2026 02:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U2-0007HE-0N
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U0-0003qV-0n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62dp12190445
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=; b=br
 c5q4bsrB37GjyjI9EN181BDR+LDOkiz0GmkFp6vs9xP1oKoAxAhQUQ/ZGS9b27/j
 yvObRFjAauT2arRy+CQDZlj6LbW2nlCwZw4EEwGqyrticcz4jV7XPMaKxVlA+WDF
 fmDLBnXN9OTxzxvzTnAIhkJ8pGJ72yDX8O3yvdb46myoTcAXXTYGcY3VeYwAMqVT
 AALUuS39S7w8kfYj5ir1YoKWOpz3VnwovrRqjKy2mkdXz9HZlDw94PI0ZenSvLjZ
 GEOYCLe2SeVvbFZ3QNOj+JvnIq6NLPY2d45p/UovzxaQAI4CmvVRJccXKSZRzyon
 KPqobMAQ2fPx9yj8px0g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g3t4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso739003a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516233; x=1787121033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=;
 b=SPb3NHhLRtCL5UQlD3heiLVaUBn/kH6nQ0JMgeG+Z+EKStEEpYDRi5zLTkxLjBoyjP
 47El3Q7v+XCDmox1ASIJOBeNnLjnJecd40P0gfb+wIqAQDCzbP+9MpQw1/tXVLDGYEh/
 7a+WlBNigjvpjvexNHfPf58l/orWUNxpXDqiia3ZUtvoXmpWoDM1wrynUc4Pvu7fJJ29
 Xc99FzDIU23s5SWBkMNZKbdTNyWkNFFas+STDbc1SPtwTY2ux2msWoDtfwiPX0wGDqox
 YDkMDQq1QCMocf9wPWUy4VEj3ukQifMmghJaw7UZ0mOxfLrMuMMs1dqgB4TVL4QxvaLr
 xLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516233; x=1787121033;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=;
 b=ICYPpU9JNdajV434ldCk+NChUFkuFU2QlY/+bVeVJWHtNzZKPISMlHuoZ+Tl6+GvVX
 ZKAdPN/F0cZKAYrO3Z8OEfTAxb67sNszlZRn9lSyqVo/LyDZafwv6ww8eSrsAW7A0bQl
 k2+aRP9HiCGMQCbSwntEV8bt3+Cd5L/y8iNFiORGBXuc5MYPTt5mebrQhASwb5Oz3/Q/
 3M8SoLYGD9xcYtjr6KdWj8m9658jcIb3zrrnKIkBWH95+9iETFcb+/IqQ7i48f1x8gh9
 IIIxkt6jrMF7sziBR4bX8+4/HHV23IPkuM334yL0wk484YvZhXSiD7X8Z6U0RnVAuon9
 SV2g==
X-Gm-Message-State: AOJu0YyQOn5aZC9bnCQU8mTfwnGd/z57OfJGhlHCFDgDxYVjh7nxqEfv
 ON7ZbZB1PgRyzWpTa4tnD0yheVjYRu9d2t9NnuyVOq25iyuDDcu5/1EKWAOwrPVcY9Iq0U7XAEc
 7SWwpsivd+k0v1iPEsRuMw00LffTyN5R4aerFqs03mXGbkEB9yBZbjpVnzRFDX6cbqw==
X-Gm-Gg: AR+sD11jDfNTtRw4re37Sig5lTkpPnZZlgthp/w1FT7/+9pDUqPFzRuGcnagGzDfS32
 TCKw49wsJhMCBH2a1QVn66hF5cMDZW6A6NflljURGeLuU/G5ppaPVHbsFVQHLRHN+rCZp4UhNdG
 gamyV7sL3Gdgy2T8iy93c7JMDw9tdY1FI1u9YKHEQYskitU37dQsWoDekvEST9lq8zlRWpwjNaK
 RRqeVzlKVXC3cN1LH21LwdnR94uhVb+sya7vxTJnKOvS8k4I2gBobo+h45vUOa3EOzo1yA2b/Kp
 ojGwprqxXHBCLA2p6jMl9C6P7oDZkr1//GirgvJxCjsXLi4O2/XbXaMVOYX7HMmu7zW+qvkPmEK
 qwbwG1hQHX8tChto1JipT+5yOwG6rAJ4Fm6SS3VMBkumSdrDh
X-Received: by 2002:a17:90b:580b:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-39301490293mr3144389a91.9.1786516233361; 
 Tue, 11 Aug 2026 23:30:33 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-39301490293mr3144334a91.9.1786516232762; 
 Tue, 11 Aug 2026 23:30:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/41] host-utils: fix ssub32/64_saturate return type and clamp
 direction
Date: Tue, 11 Aug 2026 23:29:10 -0700
Message-Id: <20260812062932.543840-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: wN6VmOnSic6qXP6RCGyGDz_B2yozQdDB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX0AHaN6jO1xWv
 XZlCHwTGV5fYne/XHYFKnvVA8uDNOcwibn+7YVdtrgFbUs8WUHxU8o/vs49R+P7dIpBjlMrgCZH
 EjUD018eqW5uFv1ff/EdwkQITIn92cw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX5vSH8w/JdIn5
 9ONifWRRMWIR8YvlVBgEzunw1JEPyeKmX/+hH/EQ4wn0R5NHEmid+l65Eh88KGdl+0UswWIMINa
 gHX4GIx64OizwXaMhkaz05yb4WmaMCA+9VUbdn825Va70vJ+QTM1H4puXXVu6TI0wPKalT2iNKT
 yWvWmofM3OihdKhl92EPILRhMoani80jt6g6GinYnbnYA6O1R+NknLqxCwbiizZB5JJoOJT071Y
 BZqbd53ofTEjxH2lYMqWDdNGdUFT5CHsGGRsyvFgBiYxxsoF5FsyWFcKnjJLTcfNVF+ftsObA3A
 A3sQFDUqtQG48I/7AauAncCiZLNotPyG7Klvr9si2aCTf1QGBnNKaIUR8Y/k37CdVbpAOuOZkbl
 TGr0YCS443VEgSa2iHojf3tLozM5MTKM3jiBmp4FAnKdTin82x+QRJ1pXp/+XkPJJjnj9cn5O/j
 ygia0Q1bL2YaPwSfHXg==
X-Proofpoint-ORIG-GUID: wN6VmOnSic6qXP6RCGyGDz_B2yozQdDB
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7c130a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=kM50MvNqywxRmdRKJWUA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

c3N1YjMyX3NhdHVyYXRlKCkgYW5kIHNzdWI2NF9zYXR1cmF0ZSgpIHdlcmUgZGVjbGFyZWQgdG8g
cmV0dXJuIGJvb2wKaW5zdGVhZCBvZiBpbnQzMl90L2ludDY0X3QsIGFuZCBjbGFtcGVkIHRvIHRo
ZSB3cm9uZyBib3VuZCBvbiBvdmVyZmxvdy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+CkNjOiBxZW11LXN0YWJsZUBub25nbnUu
b3JnCkZpeGVzOiAxNjQ5NTUzMzEzMSAoImhvc3QtdXRpbHM6IEludHJvZHVjZSBzaWduZWQgc2F0
dXJhdGlvbiBwcmltaXRpdmVzIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI2MDgwNzE1MjI0MS4xNTc2MzM0LTItYnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBpbmNsdWRlL3FlbXUvaG9zdC11dGlscy5oIHwgMjQgKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaCBiL2luY2x1ZGUv
cWVtdS9ob3N0LXV0aWxzLmgKaW5kZXggMmU4ZGE3ZmIzZDAuLjFkYjlkYmIxMzhlIDEwMDY0NAot
LS0gYS9pbmNsdWRlL3FlbXUvaG9zdC11dGlscy5oCisrKyBiL2luY2x1ZGUvcWVtdS9ob3N0LXV0
aWxzLmgKQEAgLTYwNywxMCArNjA3LDEwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1bXVsNjRfb3Zl
cmZsb3codWludDY0X3QgeCwgdWludDY0X3QgeSwgdWludDY0X3QgKnJldCkKIH0KIAogLyoqCi0g
KiBzYWRkMzJfc2F0dXJhdGUgLSBhZGRpdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNhZGQzMl9z
YXR1cmF0ZSAtIDMyLWJpdCBzaWduZWQgYWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwg
QHk6IGFkZGVuZHMKICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhl
cm4gdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCArIEB5LCBhbmQg
c2F0dXJhdGVzIHJhdGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwogc3RhdGlj
IGlubGluZSBpbnQzMl90IHNhZGQzMl9zYXR1cmF0ZShpbnQzMl90IHgsIGludDMyX3QgeSkKIHsK
QEAgLTYyMiwxMCArNjIyLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50MzJfdCBzYWRkMzJfc2F0dXJh
dGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCiB9CiAKIC8qKgotICogc2FkZDY0X3NhdHVyYXRlIC0g
YWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCisgKiBzYWRkNjRfc2F0dXJhdGUgLSA2NC1iaXQgc2ln
bmVkIGFkZGl0aW9uIHdpdGggc2F0dXJhdGlvbgogICogQHgsIEB5OiBhZGRlbmRzCiAgKgotICog
Q29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXJuIHRoYW4gdHJ1bmNhdGluZyB0
aGUgcmVzdWx0LgorICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXIgdGhh
biB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCiAgKi8KIHN0YXRpYyBpbmxpbmUgaW50NjRfdCBzYWRk
NjRfc2F0dXJhdGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB7CkBAIC02MzcsMzEgKzYzNywzMSBA
QCBzdGF0aWMgaW5saW5lIGludDY0X3Qgc2FkZDY0X3NhdHVyYXRlKGludDY0X3QgeCwgaW50NjRf
dCB5KQogfQogCiAvKioKLSAqIHNzdWIzMl9zYXR1cmF0ZSAtIHN1YnRyYWN0aW9uIHdpdGggc2F0
dXJhdGlvbgorICogc3N1YjMyX3NhdHVyYXRlIC0gMzItYml0IHNpZ25lZCBzdWJ0cmFjdGlvbiB3
aXRoIHNhdHVyYXRpb24KICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsg
QHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAq
IENvbXB1dGVzIEB4IC0gQHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0
aGUgcmVzdWx0LgogICovCi1zdGF0aWMgaW5saW5lIGJvb2wgc3N1YjMyX3NhdHVyYXRlKGludDMy
X3QgeCwgaW50MzJfdCB5KQorc3RhdGljIGlubGluZSBpbnQzMl90IHNzdWIzMl9zYXR1cmF0ZShp
bnQzMl90IHgsIGludDMyX3QgeSkKIHsKICAgICBpbnQzMl90IHJldDsKICAgICBpZiAoc3N1YjMy
X292ZXJmbG93KHgsIHksICZyZXQpKSB7Ci0gICAgICAgIHJldCA9IHggPCAwID8gSU5UMzJfTUFY
IDogSU5UMzJfTUlOOworICAgICAgICByZXQgPSB4IDwgMCA/IElOVDMyX01JTiA6IElOVDMyX01B
WDsKICAgICB9CiAgICAgcmV0dXJuIHJldDsKIH0KIAogLyoqCi0gKiBzc3ViNjRfc2F0dXJhdGUg
LSBzdWJ0cmFjdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNzdWI2NF9zYXR1cmF0ZSAtIDY0LWJp
dCBzaWduZWQgc3VidHJhY3Rpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwgQHk6IGFkZGVuZHMK
ICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhlcm4gdGhhbiB0cnVu
Y2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCAtIEB5LCBhbmQgc2F0dXJhdGVzIHJh
dGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwotc3RhdGljIGlubGluZSBib29s
IHNzdWI2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0X3QgeSkKK3N0YXRpYyBpbmxpbmUgaW50
NjRfdCBzc3ViNjRfc2F0dXJhdGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB7CiAgICAgaW50NjRf
dCByZXQ7CiAgICAgaWYgKHNzdWI2NF9vdmVyZmxvdyh4LCB5LCAmcmV0KSkgewotICAgICAgICBy
ZXQgPSB4IDwgMCA/IElOVDY0X01BWCA6IElOVDY0X01JTjsKKyAgICAgICAgcmV0ID0geCA8IDAg
PyBJTlQ2NF9NSU4gOiBJTlQ2NF9NQVg7CiAgICAgfQogICAgIHJldHVybiByZXQ7CiB9Ci0tIAoy
LjM0LjEKCg==

