Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40575C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 01:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wktvD-0005Wk-Ob; Fri, 17 Jul 2026 21:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wktv7-0005WK-4G
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 21:32:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wktv5-0005v1-Cs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 21:32:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66I1HfDe3468953
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 01:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=gbMHETAcVlq
 gm1FBH7xrZrcv1CzQqgKCzi1rpGePi4M=; b=DL1jjil6RXi/a8+aua5l1KB15cY
 16BsGhDGSsObMDfaQn0PUCiyJgMytn6jb5gZ6tzEKYnoks6wVaWwu/cj+VmS+ARh
 My51cjgME0ANb1oLQhxxjr1C4Hv5Zw5dap7028PA5SJUS0iDA8gResoiQKR+mhCN
 0Q5rZC9QxcdWMeUkJ9erWrOhuTWz7y+bqyKfp69qXQGk/+SH3LpxD8kEDdH2ikp8
 6C6CJqbZoUYOoLxJ6JOAZGjsfw78tClYNwPRa4AaShOAWQVsc+7SHZkY/HkE+xmR
 p1fN4si4DJBxur1E4i+GJUxK1oNqWb4AWhG/08CoGR5zh9a4obZuTRyogdg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffyps80q0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 01:32:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso12097718a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784338363; x=1784943163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gbMHETAcVlqgm1FBH7xrZrcv1CzQqgKCzi1rpGePi4M=;
 b=AoOOHJU+2VQMz0DnT43rJZqzxQCYY7yiRT0vlRH6Gmzu8nF74J3vXkzsljcSoTpXuM
 WLHwWkOj1WuyWvNoTF+A/pHibkatcVK/rk8zpowpsaLkK6q7MhE61f3oWjamBOAjo0HI
 2QOzLjVqHQ2KecpcOEQvEfZbqnVL3qIun5SgJkTh9DtNz80Ypp3USNIHpso4VQggbOEb
 LHWg33EzEKvzL2kTbafbrqutWhgUGBN1NCBvdu6/zYK+eYQX6jMs8YzDxAlEZ3kmnWbP
 HABumx3HDbeasU0mfTJFqsLwVu9+GTejpn7zjewyGrnfnk9Hxl6o/ibM7I12cFOUht9N
 hF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784338363; x=1784943163;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gbMHETAcVlqgm1FBH7xrZrcv1CzQqgKCzi1rpGePi4M=;
 b=FXqYSWiY6Q+KNI71of1xMGqL/BAWKr7br6qknBMJ0nmrImMTcK2/iugTng338FH2/x
 m/IkXaVHTZTJ2JKAPogp0ym4kfszpQFmpNZ5oiphPURb82r2cKHYA2n8PlAnsCA6c8D1
 zBkx00Hd+jhCx6IsWSGy5SqYdH8scUwzfK6vVAcuKIBnvcNv+vL6n74hmaND5h/dIkZ+
 tN4bgYjGhnYi2agoJdY4Ui5ajlomyso8YQet8jkWi2SCsB+i1QTJeCuDpRQNGIQzIqi2
 8X+LnbJmklmbMFYcpStbLB8talhYt3hZLel8Pg3HyLViPg75LaOb4ybv6PtYdBuZz+D3
 bBjg==
X-Gm-Message-State: AOJu0YxMp89oiQqzafpNVHyVShGBZqIRia0nm8VRdbidUnTezXvkFgQ4
 SGTMplGTdDqkz6TT6cnp4YU6LmRnS0Kh8XNo4lxfHFtUhH4XltWlFO/T87GP3o0R26Kfd80sL7B
 60bc6n349N1hLX2B4wlmWKfm3dxFy9uMRo2grWOfDlq4yt5niFp24uqFJ9DxcWyVJJQ==
X-Gm-Gg: AfdE7cmyoyzSAgNeD27vyCukXT7TdyiDrzpy1g3GCs5Gl5UZXzWq9e28JlU2yBY0fnD
 QTMhzicedzZ7pVmRjH98ClTE48zCsNpr/NcxHXsoM4UJ5Edk5ZcCMwQaRM2N2+o6iY8PPEoCj+D
 8r9yPHoUHH+46F5OdwWrETJbwgrlADgGRivu8jJaNvsU9+svzfHnXmNVKn3SG0JcNY7sQfOjTJM
 MEmN3aT+Kjedh5cmxTrjkjk7kq0TmXB/v/F+ajJ75h89nsSEHM3vl56sZgvwrO+85loSzqTAWeK
 sXsyqoaAymE6ykOfCytTC9K4l2bIaJ3D790k2aX8DQb8693OFvwltkvVTotQHisuhTsdf7NXaEM
 lMNAiTZ2evy/52EKRRpwgNRlfj19Ixm6uMI0fHHWU2vaAzSqh
X-Received: by 2002:a05:6a21:6b04:b0:3c3:8c88:7b29 with SMTP id
 adf61e73a8af0-3c3ad665989mr5464956637.16.1784338363517; 
 Fri, 17 Jul 2026 18:32:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b04:b0:3c3:8c88:7b29 with SMTP id
 adf61e73a8af0-3c3ad665989mr5464929637.16.1784338363065; 
 Fri, 17 Jul 2026 18:32:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1ddeb6sm13393494eec.20.2026.07.17.18.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 18:32:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, matheus.bernardino@oss.qualcomm.com
Subject: [PATCH 0/3] Add QTimer device
Date: Fri, 17 Jul 2026 18:32:38 -0700
Message-Id: <20260718013241.1550124-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: xnVLPh7VZtVfo8zHIN5ZJpS76NoiUare
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAxMSBTYWx0ZWRfX6k3S9Ld3a6EV
 EhmBafR/e5mJL1+JGqL8/xxOMMWKMS0cnUEepbbEr5KPEUFEt3CWvFCNr17gUdPS3e3elkNxLt0
 NIZ9H/5owB50o9nIotDom/TpQaGYz8w=
X-Proofpoint-GUID: xnVLPh7VZtVfo8zHIN5ZJpS76NoiUare
X-Authority-Analysis: v=2.4 cv=M5J97Sws c=1 sm=1 tr=0 ts=6a5ad7bc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=3tUfcxxtymIm7X_CcSwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAxMSBTYWx0ZWRfXyhehzoRDJxH7
 8MU2wfTMG/3Fr4tjmJgG2knScfpW9KS7wCmVjQ/yYZQDhgOUrb6zek+HM/QRRbsf+vBLyBiqWsr
 YTemhF33JBOZvkjGavXxtg6Vb8NwcijZwUozXq92HLikmebbVQmVQRdzhzGKgDk0lt/CUwAiOQz
 uGBwKRHE5INdmXcNJOMMjZdyjz9oQbWJGu7ouMGSV+At+K4IFTZAX3ahkljUv+ZtrlWqFJvNiRS
 Jax6dPlU2JiAf5TFKZhN0gpKn2ib5yMtyHiPOCPg4fCL+IOrJL0Tb3QfUmnIacy4y4slmKpOMby
 q/h/BNGxIA8HENZzrMxgXPJZHGY3iSoqCVuvsH5j4K7BH+7knkd3wmXQVNH1Ze3Mqt+UJEKL3qj
 Lb7Z4Wcd3YY5TZ8asIZihKnvFawqqycaiDWI3I0Acpya2oeaAHDGp1TupAL8N8XME8lX5UwVqFv
 pClTHbt+Qy8kdA16ASw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180011
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

VGhpcyBzZXJpZXMgcHJvdmlkZXMgdGhlIHF0aW1lciBkZXZpY2UuCgpJdCBpcyBiYXNlZCBvbiB0
aGUgbDJ2aWMgc2VyaWVzIHJlY2VudGx5IHJldmlld2VkIGF0Cmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNjA3MTUxODU3MDEuMTI4NzE3Ni0xLWJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbS8KClRoaXMgdHJlZSBpcyBhbHNvIGF2YWlsYWJsZSBhdCBodHRwczovL2dpdGh1
Yi5jb20vcXVhbGNvbW0vcWVtdS90cmVlL2JjYWluL2wydmljCgpCcmlhbiBDYWluICgzKToKICBo
dy90aW1lcjogQWRkIFFDVCBRVGltZXIgZGV2aWNlIG1vZGVsCiAgaHcvaGV4YWdvbjogY29ubmVj
dCBxdGltZXIgZGV2aWNlCiAgdGVzdHMvcXRlc3Q6IGFkZCBxY3QtcXRpbWVyIHF0ZXN0CgogTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb25fZ2xvYmFscmVnLmggfCAgIDQgKwogaW5jbHVkZS9ody90aW1lci9xY3QtcXRpbWVyLmgg
ICAgICAgICAgfCAgNzggKysrKwogaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jICAgICAgICAgICAg
ICAgfCAgMTQgKwogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgfCAgMTcg
Ky0KIGh3L2hleGFnb24vdmlydC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsKIGh3L3Rp
bWVyL3FjdC1xdGltZXIuYyAgICAgICAgICAgICAgICAgIHwgNjEzICsrKysrKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL3F0ZXN0L3FjdC1xdGltZXItdGVzdC5jICAgICAgICAgIHwgMjEzICsr
KysrKysrKwogaHcvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
aHcvdGltZXIvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogaHcvdGltZXIv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgIDIgKwogaHcvdGltZXIvdHJhY2UtZXZl
bnRzICAgICAgICAgICAgICAgICAgfCAgIDUgKwogdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgICAg
ICAgICAgICAgICAgfCAgIDIgKy0KIDE0IGZpbGVzIGNoYW5nZWQsIDk2OSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvdGltZXIvcWN0
LXF0aW1lci5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdGltZXIvcWN0LXF0aW1lci5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvcWN0LXF0aW1lci10ZXN0LmMKCi0tIAoyLjM0LjEK
Cg==

