Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB82CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig4-0004DY-Sa; Fri, 19 Jun 2026 19:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifu-00048G-IL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waift-0007Ya-69
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXsGi1663665
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=; b=UE
 BmAv9APv1bw4nwQrAMPA064a67qmqDvDs7c8Q1AcFVW/eT480Cyxg/O9SfzEzyuw
 1VbeBOdDO2bV7S3zp3HpI0itLDvx/OkT531FN4pTnosqbscA/dkw0KpJ8hHAo1EH
 KNiVkU1btd7H0FuawckYt7w+s3R2EGoQNMAMR7A4KB9Pu3bTC866iXUViY6BtOgx
 OV58SHjPdGyR6hjjR4SfAWKxl9dmuKywKBj0RMhlrlwitsGWU3sYoBnClpzZwES1
 VwKOMQx2CBtXCMydsoPGM/LVrrgo2Z/gbdgWgI9Znqh9SUT9JWi7ueZFNI9L2awm
 SP6ToxjHI1lPbf1QyXiw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sdbu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:31:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so6336880eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911859; x=1782516659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=JbeOLw2JTNUARHHACXv8svh6WGslIx59WOsjfZcS5m8ACAT8vkYoiIAUyr50xo5zLl
 r3xWn+SfK3fufZ6KuCR7Jzh2OG+V/+2E0Qd+vYvYQT8T57Z1oJEN9UqBQzDNVR5RUxWK
 DmqbiTx3Q0OngOOeXSJQkwHCnf2s35rqbYiGg7w0MzHUuUMKDTwip5kmRsy4hvmypppf
 0VULLwgHG5Sl5MuMggHZgUnwjyVfPs/oN0oAPlaDxJOef93RJG6uVzc9fCgOgGzauyBG
 OMiLo8Nm+qsOUp5kEbs5QeHRxUx3TM1ZVl1m3BiNJmg0xw8PNJjnCo/qjw9bGrO9Q1/I
 twyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911859; x=1782516659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=UBzu+ae8jSnGaJkhVB3MEV6aLjYTWnhoZKcHcB9Ftg1drWooY5w8+VT9lrmVqn+HgM
 LcwNI+0ere7kZhX+KpXSr81nlfh8RT/Bm7ZPB3XdqwN/ut7U3D6Qj4igjQcgNEZRuitf
 aKayc7ld8YGXKzjr4MTS3E8PzTHOEeRBFIIppQFGxYV1UbAxtGJrGKXzT7ZlVzrF6wbw
 hc7DFxBimHGnlWVc7dVA+nIshwsS5z0fPXTnV6pjFUO22qqXqjolZvxJEJ61WF1M0842
 8xVdHcEWVU6fv/z4ZMcAq8w8XliYUJzNArmzKZK3/wh6mktfUfPPY9FJ/0gIjX8cGvHa
 FqMw==
X-Gm-Message-State: AOJu0Yxf/+ce1R2tsyQMpw9+pcuIUtqHhTKUYHZI6zDkrYZXrIX2SLXP
 APaCWQROGPP0Xzw4jP/NPSwpg97APihPZFar1LS7wjHQtBwzTAThHPWvEL12ppMlqsfhbrDQswc
 sGw0SS+0FoyYNwkt729Fb1oiwqLDOMeTl4dTT69Gtk6xw/78goLZca29dpHXHRx/PnQ==
X-Gm-Gg: AfdE7cktEBy4NmngYz2x42ecgYcu8qHSRlJZFz8Nd7MQBRb1FM9NWF4ImMitBrnybIB
 ows10MCEuQeB31bBPwhYnNVMdjtRZy60tbAUM4F1VZVsMcnKzKMFLAiVvZ1xpuHUVTMzXtmq4q1
 lnKSS8tRcjfIm2dyTSfcjGZXLA9vrzpIVoK8/vkRb89T7+Rrc2DAS5S7+mVQv2A0owPu+rppqmF
 Nk1GBOlOdUYfrO0MlJrCdFo7WrxJ3U5kMM01mOU6Yell1D51PWTOBivuR9U8nJJnVYJlaehp81C
 +PVc1KecQqiZC7ffMFkqaXHwhVNDJE+FqhIzDRkePMe/Vj4ZJ5B1P5RgCc4zfj7cXi5RfsXj9fr
 gR5/BGTM8kljxwtTAxJXtg4TT5xBFo9SqlDqZ4kri8pqG9XR8+AndDA6s78I=
X-Received: by 2002:a05:7300:80c4:b0:30b:eca2:be75 with SMTP id
 5a478bee46e88-30c06e2b026mr3845092eec.8.1781911859365; 
 Fri, 19 Jun 2026 16:30:59 -0700 (PDT)
X-Received: by 2002:a05:7300:80c4:b0:30b:eca2:be75 with SMTP id
 5a478bee46e88-30c06e2b026mr3845070eec.8.1781911858872; 
 Fri, 19 Jun 2026 16:30:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 73/74] tests/qtest: Add hexagon boot-serial-test
Date: Fri, 19 Jun 2026 15:59:10 -0700
Message-Id: <20260619225911.159473-74-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6yd23JYWQ4D3DrleZ1jcmsDL8aIWve4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX4JeCrT6pwI+l
 RPFz4Xw3+TlUnk7kxIOwusecHZST18TYry10WkH5RkCmy7MrfGus3/zJ9nXaf/Ns4vtRhakP59I
 VPqMxTsWgFEFJJf0T5ugn/lrpVsZg0A3ZFYktpD47LZ7z45AmWifvf0XW6npTV9712+Jrae/RGI
 D6EwQUTNdnPSjl8JE4A48qAYDO5YW2m//3GC+U2f3x8fJFsup8RMslPub3hPwe0mvuzaCLLcI6o
 luIomvicHz+EhhnpkaVQq2ecb4gxejmt4EG+nYeyp/SW6iRudCvrVsOQR5EFLFsTJlFzgRItVGu
 NkH6P8IFss0I1clz0cmjoQOoaC99wtJcSbAKFCNKYehn3bUXe4fFt1DfxAN6TdJFK8KFcvmUYoD
 JFgK+OnRdVW8LMmkAKB2zl7Rg/pz+dyQudLiCCsiB3mbYbFeBNSR5u8QBIoS60AJ6w0WspHSVcF
 Z45k1Z7Bl6+1gJZKnWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX+5g2Vb9HAgfD
 yP3TmhDLh4mPvmxylxk78bJUm4Lw37VGFTJClbSD3ANiNoCNd5XQzCIXFuPKMAOEhd5yN7xOGId
 maEwDrFidq0YowHMA3HfuLymH3w4KyE=
X-Proofpoint-ORIG-GUID: 6yd23JYWQ4D3DrleZ1jcmsDL8aIWve4s
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a35d134 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCA0ODk3MzI1ZDg0YS4uYjJkMzY0OTlkMjcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTUsNiArMjk1LDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBbJ2lvbW11LXJp
c2N2LXRlc3QnXSA6IFtdKSArIFwKICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05G
SUdfSzIzMCcpID8gWydrMjMwLXdkdC10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBb
J2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9z
X3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

