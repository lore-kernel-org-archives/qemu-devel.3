Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDE2CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig5-0004Dc-9w; Fri, 19 Jun 2026 19:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifs-00047F-Ma
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifq-0007Y2-Rw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLZKIO1909469
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=fNRf1w3FWsd+f03wmR+fqTbcYSxUZt7zBbSNGiEflbE=; b=bJ
 sqe8dfdh7eADRJo22EpP0XPhNm7HOtoqkJEX0VJ1156Su/+82g7bn9RbbYKiCQz1
 xcWbNx2jzVYAVMnwZ09v5KQW+zRc6bA/wIeP15X0j0ER++8HOweGXY8D54hIDprh
 Shku2gKomrgOuhPpozDEzBiomADOGug/FhopJHOu3d85dpKLHs+Xyi6ukQy4TcIh
 EVGIWTIyLCgbQMvyBIPaN6FXsKsSGaTDyrzfWUFi4rsxiyBytzXrTxbhYijQt/2o
 oPn6Y64Lr1qrnTw3O2jmOketXsxlPu/2pLr9L4bjGtlhLANFNUDN69KC1mSn6BYo
 Uz58iISmQuIZPY4F2boA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewb9wgsv4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:57 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-138156c0492so8943345c88.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911857; x=1782516657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNRf1w3FWsd+f03wmR+fqTbcYSxUZt7zBbSNGiEflbE=;
 b=DTYFsv+C2LcGRpEiJmrYkwZ+/g3zmwSZlG0e8OSzAJcBVFYVM2yXBmBZKBb7z5Ya4h
 YRsH8GbTXjlXPblMOB3aRfyPLnTIu6hu+QstEFoYMcc20Cl9WIyXW9viocllRvVP/3bJ
 TzV/ElrNqCpI8TSw3mH+yu+IRxZ42P4AJ2S5dM15Ir+xjci2H6/mcHa+GZ1rzkFD29al
 6qTsX9DlxDVIMax58J9JI3Qj/VqiIUeuTa7RDjxuV9y3y1WUXXPfJnRgMiRLDutB3SDL
 KVId3BUwdF7xYXXyMNkUMH/dYl9aW8EkWqQ5fCythU1WUY7J2rKucEAFY8ywpUo/ZCTR
 zHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911857; x=1782516657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNRf1w3FWsd+f03wmR+fqTbcYSxUZt7zBbSNGiEflbE=;
 b=ePrAv0SWDTGpPQu+wTi8tQi4N+LOZ+AEokRYaYn58uP9OzaSaLHrGHUX02L+8xlq9b
 klPcTkhv7o0oV5ZD+Ek6Pzj+8UB+qv4REWEzZKEeUZ+N3DtGuKVkGFRwkL82jl0JojqZ
 NttO6Ej4HYPNWdW7RUNRoOME8if60CeilSsq9S8jGA7EHLYouCwTKY6CbWhwWJI1PfGA
 hPbG7n6/YHTQN5mHlYjwAjaemSpaXkdm6+O8HI8Y2k4WVY78xaZ2t8TgOXm90xuvbqnP
 vn78FUrFkstOj8m98UILBoxIACatJlxVhPCxcaf++s1Au6eJ5m/mvmpCphyqIy5zGuyU
 hoPQ==
X-Gm-Message-State: AOJu0YzxDGSla3VGM90ynt2TxYcUgIk6ubIx4vOo5iPVVHRX4VcKkSgK
 Me9AdXuPJyiyl6YuY5U5LMhRAgrQefLLrZn3v4H5kg8QqzM1oVkYV8tekDw5OWvzD7IOcHLnVxo
 FgFBAM1TwNgxLybDZPpuaphF6HEpTyF56mWRvSCt08WuvpaKPhpgTHmID2+Gz0lUl/g==
X-Gm-Gg: AfdE7cm+LTsAPMjEFhWzbr7EU/i75rdKPLOQ/O97E2/JdVRj0SuJMyXNO7toT4bxm2y
 H7xwZ9tXez5ShnAbZXFpIId9SlmI7cOlGttzGLKNoHxeukY+Lzk3ogYPLr4AWAPILTe09VUwjAZ
 gmBV+os9FJAofirDXeYxLLWfhfXf6GHa2e1flnOdWljyK7b3pzsApCFJZSYuO3Gj23CLXB9JX/T
 P8sI8PvZhKSCwKovCW4QlkcNPKJ6Ta27FkAcDQS18wPBm8tiQCFwjT7QX5JcuOLv4f+lp4NoBTH
 L98GD/18r8P4Tx4VxbTen960+ndtlvqeTgGQasHr9ugLuFgeHixencxQvryl7qkVReU0vcB69Yn
 uW8IUXS/pPd79IjM8S9OlEjeaTCpLY/udDh0rtiUhglmCIKIvB7jr6w2MfQM=
X-Received: by 2002:a05:693c:65cb:b0:30c:19fe:3c99 with SMTP id
 5a478bee46e88-30c19fe5dcbmr927741eec.28.1781911856771; 
 Fri, 19 Jun 2026 16:30:56 -0700 (PDT)
X-Received: by 2002:a05:693c:65cb:b0:30c:19fe:3c99 with SMTP id
 5a478bee46e88-30c19fe5dcbmr927728eec.28.1781911856270; 
 Fri, 19 Jun 2026 16:30:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 71/74] target/hexagon: add build config for softmmu
Date: Fri, 19 Jun 2026 15:59:08 -0700
Message-Id: <20260619225911.159473-72-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: TbxjwGCUCP5Y42UtGTX_OGFmGL2EpflD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX5rWkVPyxAnrY
 CHhc+FJcBcmh3Jg4bib97kv3J7FuGMS8LhD9zdI7n+Vbsgg1j9lkIPYQ1ZPqg3XYuqAyOqoB0Yu
 IAoOz/sIhsVaKzOmtTEy06z02CW6caI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/dNfk8DWMYq5
 fciwDdrF2mpYT1/s7L8WSAR8GD1eCk4DOiv4ZIi3O/bz7kzhUVNCc4qZc6xaaz8StiV2mkXJVCR
 aNgWjx4H1Zvk2XidHUdAcvI5K+qgYXAvXUTPLYwth19tRAMb5yU+FfXeotIfZdCUlQP/YLTwm2K
 /OJqAUOPJTK1j74LAc+uE/CS8ogRvlaA6PjyyGiDPy0CaaBl6RLpyXb5NprsCI8RKo69JR2ezlG
 HO82zMjHsrCXDNW9m9lVg/CS86l8xPNt0BlzO4A9yMLP8Q7E0qvc2Qhbfgd2V0FVdroW6z1JdsQ
 eIHlUKCxvfwc21DXV3YSMmwqF7goqxKl/qYNz+y5/ppCsTMa2xWWV0TYV1U7D/4tryQc9pj+L39
 G8ER/tJ7SJHM2r5Hbq7x8a2CXMwHRQyGtA4fD2MhXHfqyWy4zd3kRG7nhvJX0PWcpI7kCFka91f
 GklMAzSDoIbhSCNyg9A==
X-Proofpoint-GUID: TbxjwGCUCP5Y42UtGTX_OGFmGL2EpflD
X-Authority-Analysis: v=2.4 cv=D5R37PRj c=1 sm=1 tr=0 ts=6a35d131 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=nnu-IgKveahPCV3q3nEA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29t
bS5jb20+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG1haWxvLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrIHwgIDYgKysrKysr
CiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgIDcgKysrKysr
KwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstLS0t
CiB0YXJnZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFy
Z2V0L2hleGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrLQog
NyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL0tjb25maWcKCmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDQ0MDYzZDZlMTNiLi5jZGE0ZDU3YjQ5NSAx
MDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI1Niw2ICsyNTYs
NyBAQCBGOiBsaW51eC11c2VyL2hleGFnb24vCiBGOiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRp
c2FzL2hleGFnb24uYwogRjogY29uZmlncy90YXJnZXRzL2hleGFnb24tbGludXgtdXNlci5tYWsK
K0Y6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCiBGOiB0ZXN0cy9kb2NrZXIv
ZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCiBGOiBnZGJzdHViL2dkYi14
bWwvaGV4YWdvbioueG1sCiBGOiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKZGlmZiAt
LWdpdCBhL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsgYi9jb25m
aWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5mN2ZjODc0ZWIwYwotLS0gL2Rldi9udWxsCisrKyBiL2Nv
bmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKQEAgLTAsMCArMSw2IEBA
CisjIERlZmF1bHQgY29uZmlndXJhdGlvbiBmb3IgaGV4YWdvbi1zb2Z0bW11CisKKyMgVW5jb21t
ZW50IHRoZSBmb2xsb3dpbmcgbGluZXMgdG8gZGlzYWJsZSB0aGVzZSBvcHRpb25hbCBkZXZpY2Vz
OgorCisjIEJvYXJkcyBhcmUgc2VsZWN0ZWQgYnkgZGVmYXVsdCwgdW5jb21tZW50IHRvIGtlZXAg
b3V0IG9mIHRoZSBidWlsZC4KKyMgQ09ORklHX0hFWF9EU1A9eQpkaWZmIC0tZ2l0IGEvY29uZmln
cy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1z
b2Z0bW11Lm1hawpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZmRmYTI5
YjRmMzkKLS0tIC9kZXYvbnVsbAorKysgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11
Lm1hawpAQCAtMCwwICsxLDcgQEAKKyMgRGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29u
LXNvZnRtbXUKKworVEFSR0VUX0FSQ0g9aGV4YWdvbgorVEFSR0VUX1hNTF9GSUxFUz1oZXhhZ29u
LWNvcmUueG1sIGhleGFnb24taHZ4LnhtbAorVEFSR0VUX0xPTkdfQklUUz0zMgorVEFSR0VUX05P
VF9VU0lOR19MRUdBQ1lfTERTVF9QSFlTX0FQST15CitUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9O
QVRJVkVfRU5ESUFOX0FQST15CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRhMTJkYzA0NzI3Li43Njk0ZmQ5MWZhOCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAg
LTM4LDEwICszOCw3IEBAIHR5cGVkZWYgc3RydWN0IEhleGFnb25HbG9iYWxSZWdTdGF0ZSBIZXhh
Z29uR2xvYmFsUmVnU3RhdGU7CiAjaW5jbHVkZSAiaHcvY29yZS9yZWdpc3RlcmZpZWxkcy5oIgog
I2luY2x1ZGUgInFlbXUvYml0bWFwLmgiCiAKLSNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQotI2Vy
cm9yICJIZXhhZ29uIGRvZXMgbm90IHN1cHBvcnQgc3lzdGVtIGVtdWxhdGlvbiIKLSNlbmRpZgot
CisjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oIgogCiAjZGVmaW5lIE5VTV9Q
UkVHUyA0CiAjZGVmaW5lIFRPVEFMX1BFUl9USFJFQURfUkVHUyA2NApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L0tjb25maWcgYi90YXJnZXQvS2NvbmZpZwppbmRleCAzYzczZTNiYWUwMS4uMDI4OGEzZjQx
NjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9LY29uZmlnCisrKyBiL3RhcmdldC9LY29uZmlnCkBAIC0x
Niw2ICsxNiw3IEBAIHNvdXJjZSBzaDQvS2NvbmZpZwogc291cmNlIHNwYXJjL0tjb25maWcKIHNv
dXJjZSB0cmljb3JlL0tjb25maWcKIHNvdXJjZSB4dGVuc2EvS2NvbmZpZworc291cmNlIGhleGFn
b24vS2NvbmZpZwogCiBjb25maWcgVEFSR0VUX0JJR19FTkRJQU4KICAgICBib29sCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9LY29uZmlnIGIvdGFyZ2V0L2hleGFnb24vS2NvbmZpZwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uN2U1NTZmMzUwNjMKLS0tIC9kZXYv
bnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9LY29uZmlnCkBAIC0wLDAgKzEsMiBAQAorY29uZmln
IEhFWEFHT04KKyAgICBib29sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWls
ZCBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDUyOGJlY2EzY2QwLi5iYzdhMjky
ZTQ3YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0
L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIzNSw2ICsyMzUsNyBAQCBkZWNvZGV0cmVlX3RyYW5z
X2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgY29tbWFuZDogW3B5dGhvbiwg
ZmlsZXMoJ2dlbl90cmFuc19mdW5jcy5weScpLCBzZW1hbnRpY3NfZ2VuZXJhdGVkLCAnQE9VVFBV
VEAnXSwKICkKIGhleGFnb25fc3MuYWRkKGRlY29kZXRyZWVfdHJhbnNfZnVuY3NfZ2VuZXJhdGVk
KQoraGV4YWdvbl9zb2Z0bW11X3NzID0gc3Muc291cmNlX3NldCgpCiAKIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdjcHUuYycsCkBAIC0yNTMsNiArMjU0LDE0IEBAIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogKSkKIAoraGV4YWdvbl9z
b2Z0bW11X3NzLmFkZChmaWxlcygKKyAgICAnY3B1X2hlbHBlci5jJywKKyAgICAnaGV4X21tdS5j
JywKKyAgICAnaGV4X2ludGVycnVwdHMuYycsCisgICAgJ2hleHN3aS5jJywKKyAgICAnbWFjaGlu
ZS5jJywKKykpCisKICMKICMgU3RlcCA0LjUKICMgV2UgdXNlIGZsZXgvYmlzb24gYmFzZWQgaWRl
Zi1wYXJzZXIgdG8gZ2VuZXJhdGUgVENHIGNvZGUgZm9yIGEgbG90CkBAIC0yNjIsNyArMjcxLDgg
QEAgaGV4YWdvbl9zcy5hZGQoZmlsZXMoCiAjICAgICBpZGVmLWdlbmVyYXRlZC1lbmFibGVkLWlu
c3RydWN0aW9ucwogIwogaWRlZl9wYXJzZXJfZW5hYmxlZCA9IGdldF9vcHRpb24oJ2hleGFnb25f
aWRlZl9wYXJzZXInKQotaWYgaWRlZl9wYXJzZXJfZW5hYmxlZCBhbmQgJ2hleGFnb24tbGludXgt
dXNlcicgaW4gdGFyZ2V0X2RpcnMKK2lmIGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5kICgnaGV4YWdv
bi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycyBvcgorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdoZXhhZ29uLXNvZnRtbXUnIGluIHRhcmdldF9kaXJzKQogICAgIGlkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5oLmluYycsCiAgICAgICAgIG91dHB1dDogJ2lkZWZfcGFyc2VyX2lucHV0LmguaW5jJywKQEAg
LTM5MCwzICs0MDAsNCBAQCBhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQo
CiBoZXhhZ29uX3NzLmFkZChhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCkKIAogdGFyZ2V0X2FyY2gg
Kz0geydoZXhhZ29uJzogaGV4YWdvbl9zc30KK3RhcmdldF9zeXN0ZW1fYXJjaCArPSB7J2hleGFn
b24nOiBoZXhhZ29uX3NvZnRtbXVfc3N9Ci0tIAoyLjM0LjEKCg==

