Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFBCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO9-0003J5-Nx; Thu, 25 Jun 2026 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO2-0002sd-FX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO0-0000CG-LD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juAM1919787
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=; b=U1M9x5Ff8z8lAti3
 yKDI2EoZggr1ACY8Hu+JNad2DYQ5QwNPxL7BtGdEK0nJ8M3Yt6sK7QcglQu6bLSN
 PQQUWflVUQPNb1rBj6A5dR+Mvy0YTijEX363plHwg9f1DxvGgUbHBnC/ZeAZytbQ
 q6n+1zWN6gStlJv6T7TbbsnS+lgDAecO2ycvHZpbGmCQVE6rbBGw0GnjxY2qIGp8
 JPOGJmV2obAlB9qhqp1hURyh50BvcplYAhQaRBobv8mo4wY7iuUkkXm/E2mUD+3p
 krouSFPwXlEwzrNYGn3nORXJz3CX8u8KTwaEkgfy0UHscbPns9iezFzZPmYBGjqO
 6S3AMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuaqnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c8a940e76so783261eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398929; x=1783003729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=TdPOEh48dkudop8W6fXa2D8UhUZaBu2s6Cvntza7+aRrH9ZjqoGpbd9wI5pjZtS2Rx
 EJ8RZMU3ZANfrCIzAY6mE9Ij30sn4Zfs2q7H/BpwhnC4rieov8CP/DFmlR8T7FjgDnes
 oHlFChl/d12uK1HSEh/yZ7vokqjZ4L+SHxRK0pnVLztnGmh5f5dh0qXes0fgeatTg/6X
 fic5Okst02eHXQqMWciSw7KxeXQ35WawmW3ZS6irvWVe6mP6CQnYyc6dUkZ45ABNK4ij
 9reRmsz0nmoZwTtY5fVjfI+lXXoOonhaJA8abtbkOF6Rng6oEP7XW3VADtzv3kBON3lM
 lb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398929; x=1783003729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=M6anHavtGZgn2mNWbELpHmt9r7gClv52uxKEk9H7+PHKR+6bnRNds/9igzalGl+haV
 ByKvt4YwseFzdWxtPUw4pqbDlpqVUT6X1UhV9ppdX7i/5XUqHMu+xiIsEQ/QLVBcxXsJ
 9u2ffF9EESI50Af3we7Y5vVPy0BiERv4fRM94e/hIp+2uWWvjVhW4N+GirDFTxhRduHK
 bF8nCMVcXENJxTpsOFsqtxpZMkgEfbr5xO4m5clDY1oq9yAK4xrsunSODw1koQDCcpbr
 2IQWfVVdIf1YXwzCiD3nmpQ1Nmr+1W7bV53jDeQbOcecSDs9FciV35T1qgLvTXk7V37/
 E88Q==
X-Gm-Message-State: AOJu0YznUdBjH8i845YuEyOO0tUs3+wLP2WJxd285p8HDxwdFRgVTHbt
 tJvUF6Lx32mTqZXvh5F0a7ScG55BmCe8kdUscs4yXd3BYBAUi5rO2Mly9vp7K0p/uGaxgJyQ44R
 /eZGr8WD8dw9Yg8d9EN7e3YkN+I5zEA2/Gm3GTfg5vPe5XIwtRyhVOtSxEUZ7Dmqlew==
X-Gm-Gg: AfdE7clJpr4e6lXxhns9Gel3rifIgCh2KGareExDHegU6N55CpTFDdir8HoM+rpX09p
 O68BZqvO3UiNhHps3X0CfVPwxggh6bBjJvvkW8XrLkLULMdIAe66to1Mx61jv99/VJTol83LbE9
 Z7YhSlK92ju0egyM2yD8AxENNg8MYkB7BDERXzmJB/8gqBgo08ml1eyEN8jSLQzkDnf/HnIc4yF
 woPq/3SeszXp57XDMYUht+H3GHU9ExCOctKJAjUq2NLL3f1xy7b2qnj4sDGNer3PdTUQ1oCK2OG
 9uxehI8BdfD/pFXWLWA8F17WHd9Q/xpw6PSTLW11CSiCUsksKx9G99wPMh5UNU3WUSG9zWsV9rk
 BggmqKqU8LM1TjWLW6HOem7zv3pvRcIHBHmKtP/5v42uux796dyPO4rpwtYs=
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c84bcdacfmr3093727eec.13.1782398928631; 
 Thu, 25 Jun 2026 07:48:48 -0700 (PDT)
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c84bcdacfmr3093691eec.13.1782398928117; 
 Thu, 25 Jun 2026 07:48:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 67/76] target/hexagon: Add guest reg reading functionality
Date: Thu, 25 Jun 2026 07:16:24 -0700
Message-Id: <20260625141633.449487-68-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: aYpMZc7sk_0r220ZPaTvBlKPbjp3CA7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX1xDIZU0Z1J0N
 6+ahx4f4DgDzxeVCYHthEeZmmJ8qKWTctEYDm2qn+SSVhu+M9gBGdwzSPzsrtvHTvNBbF5x6Wba
 8BfqLkzOZtQG/YKdMJE3eauIRdJZ2TA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX4WzqyQ4BY4Y4
 R661JypJvdmY96AUZTFXlV45pjFS/XTo2V/lCnvI4UPx7ovHPAh39+KaLiqA+WUNKIqUdjGuNjQ
 zFB19WLsCovfGetoXqb2mZqOzCZDhW9MhT87YARQdJxPZrzxqvfIy3OHufYyTpPXLVcyx2KoKGh
 eIQdfklyZCeFyzr9X0M78ihRkf46EwT9PvkqsSlihR36hlRgv3NFCa5+O5Gp9fGGRR5tdSOYwh6
 7/qHG5Gew8EGtS9pxlThr5gV9MfqP5c04H6afL6c+QIy99jJ4oxuqjC99z9vwl40KidylcAgAdb
 CIo+HYOhTXezK5DTu+kiDwHgK4cK/ySaeOfGxkFbGniPTqNHw/JrKN32h056+0Mz7nMjEcZwsJB
 SUQTpFlaoE6iUh/N0N12FLxPuWgxBGxemgPw/hshGjRgZMtywOgceFeA0LjpezJlVedYJpltUsZ
 C+boSS76yVuWFuH+Z1w==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d3fd1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IJQQmebJWjVxhimlKuwA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aYpMZc7sk_0r220ZPaTvBlKPbjp3CA7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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

