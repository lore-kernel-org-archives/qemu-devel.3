Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65154C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmq-0002BP-Ft; Thu, 06 Aug 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmS-00027Y-Kl
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmQ-00045I-5u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbTYb225991
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=BdzLX3xBppf
 tUpxq0jw30ruzfdIDRBUhgYWYMtM31D4=; b=hmtvPkOX5C5pW8wIpPqxS7F1hzl
 rTQ2/eFSwnos4/0UfXB6j9QCKxOGC23Ss6cvsTgZo1FeO9qX9FEELs1n++++8iFb
 2Hbt3bJkEnaC1gxHtiDDZ+X9MLn+gwYL8tnALxbsMRs+p65a6MrOBI4j0T95e9uZ
 tuPJz/bmaaTjxcypSDARkpbAOsC1xZk82auGKbrVKOGJx8MoW6JGULzZE1FWYgFK
 Jax+d+eTo8gqtP/ycD2xFSBJnNunaQk1G2cB26besbCnAV9jqw/m/RyARUKQBhWr
 05ckoBzBy+MTK8AQ5wpjSsMaCvtgtr1uVGf1+0UAuicLh7B9pC87WIX9N2Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2r64cc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so43195145ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990746; x=1786595546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdzLX3xBppftUpxq0jw30ruzfdIDRBUhgYWYMtM31D4=;
 b=IRFLX200cS2VDs1RvO/cH1mAxc/gYxETQ6LLnIyRon88KjOk6kQKsH1ZkuMllPna6o
 WVZsEaU/RMOlb0E/hf+ESamtNnPCAhIYTT7zSkLyYAnaxmDhcnwdkMwiWXpIs3kChtyX
 12vtcQr37WRijURJvwKRHjjmDA+Kpqo+mH8G31lcl9AiT+zgSX3+vmjq/Nx/dLJ9w/qF
 N/Evern2t9GbR4eFlSU7dZR+nKpCBL6RleXFirfliSnrCFgBm9lfpoLEuTgTYYy4HfM0
 VxqCcAJeNLNDlTSF32YomPyck/JdN1ImfUYeuAJc8tEVZWduZv2dLtM6w3R8PkVADZjq
 lZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990746; x=1786595546;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BdzLX3xBppftUpxq0jw30ruzfdIDRBUhgYWYMtM31D4=;
 b=tJirCamIJPZB/F/lFPD8+0O0vKL7kk91pH0toxzWoOh7NaoUav6oNza03AjhUP7lMI
 Umv9baWw+AkjnDtMxs+mBBbv2cE4PF20Ml99dfq66SN/JBqJoLSYDtUEyjqCswcR5S5g
 xhTNM3a/sUzISi4T7opGtfHjvGU7qlxc4snkSsaD2CsrJ95Pq7VBnjbfko7edny/6iTo
 l9HXdMyAfKncouAlVYh57x8J1yWH+FUhKrq5aEH1fsQ1aF48lyppWWrdLXmtyp+2aoBU
 lYT5T5ls9aSGTAvwwoHOsgxEt1R4o8A5ch0darPkKEhNiOPRfEyH68cas9qADhQxNzro
 b7UQ==
X-Gm-Message-State: AOJu0YzipDdg42v6ufjBK+A3iB5kdJbULSDqVmOCx3OBhMkg8Rn7dH+7
 /0oqUQZkKVZ74OHtCSXXSAb5lD76wBq1BhixOA9WkQ9ge4WS6LkwwjxfHJAK6Kpc3iALH6OrzaN
 x6RJdB399Of8A+kF1tLHczHDcySpqSRQX15sIEdlzlKNRy45zRboF8lC6SqQ1j1kefw==
X-Gm-Gg: AR+sD10KuM6kcPoHCtyfRFUWceERyJOFAI7Q5tgotBf1JlWwcM7N/E4yxOMbRxPlbIB
 CgyvYdUYQJJevsn90174x1E4di7Q48ob9gkwH/9oFyyMkCkD7Cq9aGorN3YVMgxMFK7TrWbkMwB
 vXYqNH3Ujfv3KYOxHgwkHdDpfeG0/tHLHt3VcidFOQPiG9IM5abS/3lOuli9q4EDe4A1ICRarnA
 00ExBCb6GtFUmO0GbEiEju+WWSW3PPDjMSIiydRyB2d8npuK2KCdpsFiEwJLoMC/tz+Tjriv8F3
 KOdXNJyRe4nLPa3JDiINOqbVAV0DUcOM7hs1e3ihz3x9/Otzc6vrsg8higOLFkO37yWEi+h/g34
 ssn73zDjfKNRHTwlPgmMD9RRTWV+inyp3Jjgg/7BK1YRoUjjC
X-Received: by 2002:a17:902:e94d:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2d0ca757624mr160826775ad.12.1785990745806; 
 Wed, 05 Aug 2026 21:32:25 -0700 (PDT)
X-Received: by 2002:a17:902:e94d:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2d0ca757624mr160826115ad.12.1785990745285; 
 Wed, 05 Aug 2026 21:32:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 0/6] Fix host-utils sat; Add GVec overrides for HVX ops
Date: Wed,  5 Aug 2026 21:32:17 -0700
Message-Id: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WrIb99fv c=1 sm=1 tr=0 ts=6a740e5c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=US7OFz8TDSOAQJmZ30UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: jzbMnL-91a2Kv0wAyEjlBVrpmR8NzKQn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX/5+U1jG3/JQd
 CYltk595jyBZbXiCRdwlBFm46XZ6l97LzA73XRp1eeJiAxbPPW+OPcD3T/z49xm1FZvx273Njj2
 RxMKE4JqOmfSeGbXo0KyvD5EgOT0y84=
X-Proofpoint-ORIG-GUID: jzbMnL-91a2Kv0wAyEjlBVrpmR8NzKQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX5/u8Bch+IA9L
 Ma4QIFIClZIdyLGrC0DNVCClnPXVzvnsBslWTt4+s0If8bPZ0IdFdjNQxP1jQp1nwqgAaE9G/TS
 1oiwzyIVHCMo+p5QuJiJiE6d/Z2RjonsOmsaKGtBnmvoSxwP/6ZL+APjQY12qziMVpTa/ShsX7u
 QbCvOrzDBO3L/P7g0ECxnukcLoIpV9oHtBQOI3FKcZUccY79FMLxuxTjUvHdKCkwnlIIt1hRE3C
 Z9ez6gInNLjcp6QjamBl49UBclJOVni1UleWvdYnIXNkf0uOc58etoVlhV5rWsSYLuqzkr+5zTF
 xP6CIDJyZs4tGJf7N2dXA93U0HCDHYnppFiXu97BCs3f7MHV+YbOVCfr5aQtGpO3MEMFjjdqDRe
 MajipfLPDjjFDAl2d21PzqCsNkd1sS45RwPU/jnjqrtji/Nupc1HSHpj0ZURhPt/jnlOq6TGVQQ
 IGYTd+OaWyiZH0hF5lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060031
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

SSB3YXMgZ29pbmcgdG8ganVzdCBzZW5kIHRoZSBob3N0LXV0aWxzIGNoYW5nZSBvbiBpdHMgb3du
IGJ1dCBmaWd1cmVkCml0IG1pZ2h0IGJlIHVzZWZ1bCB0byBoYXZlIHRoZSBtb3RpdmF0aW5nIGNv
bW1pdHMgdGhhdCBlbmNvdW50ZXJlZCB0aGUKaXNzdWUsIHNvIEkndmUgaW5jbHVkZWQgdGhvc2Ug
aGVyZSB0b28uCgpJbiB2MjoKCiogVXBkYXRlZCBjb21taXQgbWVzc2FnZSB0byBpbmNsdWRlIHN1
Z2dlc3RlZCBgRml4ZXNgL2BDY2AKKiBGaXhlZCBjb21tZW50cyBwZXIgcmV2aWV3IHN1Z2dlc3Rp
b24KCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA1MTY1MjI1
LjMxMTc5MjQtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICg2KToK
ICBob3N0LXV0aWxzOiBmaXggc3N1YjMyLzY0X3NhdHVyYXRlIHJldHVybiB0eXBlIGFuZCBjbGFt
cCBkaXJlY3Rpb24KICB0YXJnZXQvaGV4YWdvbjogYWRkIEdWZWMgb3ZlcnJpZGVzIGZvciBIVlgg
c2F0dXJhdGluZyBhZGQvc3ViCiAgdGFyZ2V0L2hleGFnb246IGFkZCBHVmVjIG92ZXJyaWRlIGZv
ciBIVlggdm1weWloIG11bHRpcGx5CiAgdGFyZ2V0L2hleGFnb246IGFkZCBHVmVjIG92ZXJyaWRl
cyBmb3IgSFZYIGFic29sdXRlIGRpZmZlcmVuY2UKICB0YXJnZXQvaGV4YWdvbjogYWRkIEdWZWMg
b3ZlcnJpZGVzIGZvciBIVlggdmVjdG9yIGF2ZXJhZ2UKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRk
IEhWWCB0ZXN0IGZvciBWNl92c3Vid3NhdCBzYXR1cmF0aW9uCgogaW5jbHVkZS9xZW11L2hvc3Qt
dXRpbHMuaCAgICB8ICAyNCArKy0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCB8IDE4
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24v
aHZ4X21pc2MuYyB8ICA0NCArKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjM5IGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

