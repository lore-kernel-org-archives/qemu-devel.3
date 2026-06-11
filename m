Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCADCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2u-0001gP-RE; Thu, 11 Jun 2026 01:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2m-0001Zw-06
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2f-0002bS-Uk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GIaT3791689
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+fQJ66elCq2Gz4l12pqfNjnGqlZK9Ut3/hkXyOSvUY=; b=clxVZrmf8PaNXxua
 y9FfQPIoAIoidpqvR/aLKFr2tXK/qjU17Ny15/9oGxsenTRgIOhLeuhq5uBnUK/2
 JByt8qD5WITsa0p3AUtoQAlv/tAid8U0ULDpA0rzkJucb8ax7V6U7RUbjzTqDcvL
 1m/D6Vv8tojas+HynCmM80uP5kMArOpxb3WGNhwCGd7Z2SJF6rfgl2xNSrLtaPPM
 KrreaThVwJYE6E2ZiWHeehR9a1+rm9jlzRlamu+Ye94BvW/nkm5iA8rME2qHVTNM
 H7DPArKpC0Sm0r28c8ckkb+keBX/H9/HWr2PafNwrMwF6HhDRNi0tk3kKk6MqYXG
 EThrjA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701sk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30761ab3483so6234300eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155993; x=1781760793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+fQJ66elCq2Gz4l12pqfNjnGqlZK9Ut3/hkXyOSvUY=;
 b=iTEg41JTO5p7VyT+LXJ2zCXhZBHpf2b9gwE0B7cP9oPBWw4rgoGIfMuF3Ea6Hfz1mQ
 PJTF4lOCf2NZ/NCrIJ3DV3DZj9qQ3QEukNl1QQYQlQXdMhfeBDt6zNMV/0gbxg6oTeK/
 ek5JWqcJXVF5TyUFY3YwgeIn6A5I+9IEwWdnsYmyNYYyg/CP3rPiwgNTuzQ0hu+u6PiY
 88Pi6VfEhDsMgdwnHZLZNWEI7Zbs0IpzJRwLvBqtGw15zl90IWO5VcGdUHxeTbMhPq1h
 dNGF6KMX2sTzVjwF0pco09hXBRzos2fODrxNEw+/WlttQYqskqiOI9PQfyflebenqbAt
 aY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155994; x=1781760794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+fQJ66elCq2Gz4l12pqfNjnGqlZK9Ut3/hkXyOSvUY=;
 b=Cf16pdTdgL3CUpdv5W9Vf2btDmqkpDiCK5Acm3uWOzToA8h0RkzB0qWTqJKeOqiYED
 HN9+LtuuRyZflHAcjWSJ/mzb2a+b3ZEWp2rh63nmWwuDLXteAOw7E0HjIyo8Ifp1fV68
 IhTBpB4Xxeiv3HU+H4lHtA0UUsx1CTWu+lQQjoLCNyoF8wKI+dW0w3kbrUckhYFT7cPs
 9YuV3M7YDWsZCndtWWJzB3muA9wQswnw6wg+3642qou1KzZiq/MkBFHTWTXNDZGdgprj
 1eyIacPAvewpIk/NgD/6/tx9WjD5p2+hEWoVRYxyqymi470dhTdWvVib/l7rXOKEss/m
 JsdA==
X-Gm-Message-State: AOJu0Yz+iDogPyFKzpA/vjHSn+XRnMyfUYUuewWz47J4zpZ7lcGOnaZU
 4lLMT8AUcvu2Kq/yIHbciMjYtE8+PHb++TgXJsY1nGa9gMS92UHlEmojhNyLkFVkKaulWkiDlBF
 JsJzNh+yssRjBR0j1Bz0zOvQ3dRLJx6A090CTyQvLJrCGJbf9JXxNNiUYqNG8fRuMNw==
X-Gm-Gg: Acq92OFIV/KyMk60+nQQ7dwHDoV9I6LytSUkgqyUvncittEBQIHlAcgGYCS5vnNqJDt
 R3Kig//iuDvED0ZywR+DpdtlOTSzVNY6UtcLSj33TbjK9sidHlG/pVanhxplp93x5nSuYf7mxs1
 Zk1MlWlgfXoneRVh6+EkUw1Qo+3WyKrRmL8SjapG38cULCCoYMKcUeB7zOugbwZIeg7GfDd0gN8
 LmsiWcFjfwRNCCm41L/tsNweSH3sCPi2NYbM1OMhp87Ns7Br7EI54LHdE4+Uocs2DS33Ir6v5mx
 bvYBYS6PteGHP8/zYRyHsqpBlToFaR7C0SmziJqWSraoiCj7QHG1y95CE8NhmlxzFlj8zIE/XE7
 jA2BK2K8Snk4gsNWpEhTFs47Xr8r3EcwYoWcpj3Igemi5qZfQfE4qqsoaOSakKVz3gBA21oOHPM
 ml+eLm
X-Received: by 2002:a05:7300:7492:b0:304:188d:d0b0 with SMTP id
 5a478bee46e88-30804b8bf3emr1031081eec.20.1781155993546; 
 Wed, 10 Jun 2026 22:33:13 -0700 (PDT)
X-Received: by 2002:a05:7300:7492:b0:304:188d:d0b0 with SMTP id
 5a478bee46e88-30804b8bf3emr1031057eec.20.1781155993004; 
 Wed, 10 Jun 2026 22:33:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v6] target/hexagon: add simple cpu_exec_reset and pointer_wrap
Date: Wed, 10 Jun 2026 22:32:32 -0700
Message-Id: <20260611053249.3918491-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX5LAKvpWaq7JE
 0obE3eu4KAdJrH+s2xbLe75NFu4j3FF2CqULieuMod5uUUehJfY+2Pf2SQEySMaC2YZCEi0Ke5k
 8AHwgwHOLgwnATVggv2V7OuoCsRFP3zozIGaNiZ/XmrOht6EveMKRZ0MMJNNppA9vRn5YrFuccy
 NuP0AazAqfohhjPC0yJ7VTtPC+5P0yYAoHmaGC0ewjDyfUXxkx+xwsn/tg2xsRsCWKWcFsp4tnw
 M3Nn36IlaipltuZhpWKBW5Wo9OVGaT4iLtzUqtbEPT/IH9AdOYGpCXqAnPHuXzQQRppbSQcVLmQ
 zjY9IDtm+oWQ7I0hidhFMyjxZGD6IuFyVO6XAqzA3ZUeyPYinN5vsj9ddSMycHpIxbxUEoX4jO5
 wPmMeUVpFxuWidcuzP/pupMqeipLplMH/CUd8HvQCt6Z+bUofGQdILy4PRbNAQINlTgzVFlxIgr
 sBbUYX1h+0S1HSjkAsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX4hMmoprOCG8E
 XRzq9LLzLFjJ1Ptd208w5oefQmIi2DBKpZn0G6UQa0d8BxnNcdaKX/EHIE6zV7WVT/L+1iNi9ut
 Y291LTJEl+qWRDBMs7vZ4b60ISMTsgA=
X-Proofpoint-GUID: YcZA7XI8EZ0J53M4BkxS_I9fPFY189hv
X-Proofpoint-ORIG-GUID: YcZA7XI8EZ0J53M4BkxS_I9fPFY189hv
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a489a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4
IDBkNjU1MWRkNWI2Li5lZGRlNGIxZGI4NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ5NSw2ICs0OTUsMTIgQEAgc3RhdGlj
IGJvb2wgaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJy
dXB0X3JlcXVlc3QpCiAgICAgcmV0dXJuIGZhbHNlOwogfQogCitzdGF0aWMgdmFkZHIgaGV4YWdv
bl9wb2ludGVyX3dyYXAoQ1BVU3RhdGUgKmNzLCBpbnQgbW11X2lkeCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2YWRkciByZXN1bHQsIHZhZGRyIGJhc2UpCit7CisgICAgcmV0
dXJuIHJlc3VsdDsKK30KKwogI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdv
bl90Y2dfb3BzID0gewpAQCAtNTA5LDYgKzUxNSw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMg
aGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5tbXVfaW5kZXggPSBoZXhhZ29uX2NwdV9tbXVfaW5k
ZXgsCiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0g
aGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQsCisgICAgLnBvaW50ZXJfd3JhcCA9IGhleGFnb25f
cG9pbnRlcl93cmFwLAorICAgIC5jcHVfZXhlY19yZXNldCA9IGNwdV9yZXNldCwKICNlbmRpZiAv
KiAhQ09ORklHX1VTRVJfT05MWSAqLwogfTsKIAotLSAKMi4zNC4xCgo=

