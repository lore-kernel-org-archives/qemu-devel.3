Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F49CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO8-00038b-EM; Thu, 25 Jun 2026 10:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO2-0002sc-6R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNz-0000Bq-C2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9js2T2009329
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=; b=orBa9g79WmfW82s2
 yvFIjKZmYe3eSP0SnHkU1YP7w9btxGrRB5MOUydTGeLmn02AqM84V15westku70h
 ufuE0DmKed3PKMFPk3jmeEemvzIfdB5sO2om3dk94Rb5BRq/KGz2h3+7N1m71DZe
 oO8gfvYE3YBtEIJzzhX+S4yXPCEpatDMS+8OXtl0Ip6KYmOsn6eX4BzgsRSk35xs
 IHqeYgCoANxiVw8AZqfg50KuQSJHIhmHIiY7PwlIJAFpGniQHxjTlRVv7OSiQtlw
 iE4kvVgZc+E8/mfwD36Z+eXtoo/s6Bl1L9ajSgWK35H/zTbAL8i3CvCK0WZ4DfOI
 e+w+7A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjqvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so670412eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398927; x=1783003727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=FDabR218VpaR/PWMnwgL3G4q6T/Q5HZYqTvdl/xms6dYnB0aokM2slAm/xgSeGYNHj
 +BGjiIL1Og0yIHkM1YwWIurRrsFJMnu3c/mnq4A0Jg0/GZHE9a4f02sAqtqiytqCcTdf
 lwP0yY6QtR6wimmD4BadfrIW7OqzdcWl9ZY6UJJGr02ApqC+RHJyj9QTJHHRL2QYuTAV
 4o8ONyh9mMK5Nn8tUQtKBbhC+QQZdxWG4oJQN3+AIZa3GFyOM4HHk4NoX7Ut9fJ23ZQc
 +tnSPyldJ8Cj2cDrXAwl3ag0dDACaqvTdwixFxCky7HAVKfP4VViF5TaKFXVn1VAHROj
 KIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398927; x=1783003727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=Uvc93tIVLZ7UAD9V4z5xV9Z+9X6LWtm4NSiZT/Pfp0Dx1jYhvuLVUC1mY8KlIh7JE6
 F7KZc2/sVUrE8KNgJZ5xa7Leml2qaQqwuF3/pXJ69JjHzmmn9IUaO6dHSM4MUxvLmbl7
 99IN8a4KRH4XVZhOuGFxNXcZeTVQLF/um7ukHe0LjWJet1WVeIq0+lq0Aqoqnph+0Zt6
 TYWpKq6VGH+ud5PLOO9m5xZjs85mbOAe6JFpgXwm56/xsSma6L++jNdGI7ppQqEQEWDs
 RV0ME8NGnGU/pozFNytbs7KH+GVgOZyE0wyHY4svwQchew+vCMyXs0CgM7fCTxgjni4S
 IymA==
X-Gm-Message-State: AOJu0YwMR5V6oXB03nmaRD/YvhGR8/PqlqS7RM4ln55gf+Ab5Cu9Lox+
 ZR6QMu1yGeR+G8Xjvh6eAcl/ugOyD1PNx+ni9jEDO7BarnTnHMVpGTf9ndyRJbm9zAF/RMmdHjr
 zLIGndCPX4dm8oUwvLK7LoAgtDY9IDBIbcdNePMC4yfIidOjkCIfsLoTnnbaI/fkQnA==
X-Gm-Gg: AfdE7ckgkgQcCnWM6yEGwykNYs2OS/L1qkSBs8syYkskBXe93IRYsBvg/EnMivdn1kv
 mn7LQdJXsa92ACeAz/LUJpX3Vfq5CZVjZPNDRNWeyor3nLh8HoRFP3EXUDtsUxmVC32I7Qp9RaM
 4/YloX8mL9AsB6wqtfUMlgd7iTFBjl7BnGSpAPdXJdFFCN8bU33NWlUI7GD3fi48WoPuGVXK4Ua
 n9Kpo5d9Gd9DvWdXw+7Cc1wCnV0YMtzS+6MSFXll1Tuhx9R5qudtJvYY5zF+Ip2gHofwGLiB6Jl
 4/hlmK54T/Doxhx1OGOhT5x0eRsrJT/REwtLq0Mhv4Clk3aGcBZWrZaOwNpopfzn6ZeCCwEk2q+
 5eB7oJVhhaqUMZLfAM1pkFHVCA6/xdnUyght+0bCHHXKWFyjw/oj5IYZOtPY=
X-Received: by 2002:a05:693c:62c4:b0:30c:650c:2161 with SMTP id
 5a478bee46e88-30c650c359bmr5429336eec.13.1782398927450; 
 Thu, 25 Jun 2026 07:48:47 -0700 (PDT)
X-Received: by 2002:a05:693c:62c4:b0:30c:650c:2161 with SMTP id
 5a478bee46e88-30c650c359bmr5429312eec.13.1782398926827; 
 Thu, 25 Jun 2026 07:48:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 66/76] target/hexagon: Add support for loadw_phys
Date: Thu, 25 Jun 2026 07:16:23 -0700
Message-Id: <20260625141633.449487-67-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d3fd0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX5VoSW36HfzZe
 a8M7+z575v/1DqSInYm7FjJkHmPGMs6bhvY604sS9/wCiDxajsh8UP5/miiuXzJv7w7Fad2ALZW
 LNfz9oHFf53ltFIV5s/FDZMmKMKQOQ5O6KpRBdWqvMIHTaMynL79Tzdzie09mFpsxmEiz8BUArJ
 MepCmPESzoyGKq4HspO3TeCDmHT2CE5gvUnfX+ETVJu427i+3dAGIG5sKepP1AFJIjwssnz8xh9
 c+LOSPqQ1mX1YXBmEWpyBdwTNztlcHxWOOiBCRySB9elWYIzQl77r9U0fKj1NnCKH2EDYin1ajK
 aFbKQTVZNR2lwnUjC2imjTeVxkFLYO2cyak72hK6WJjEgdMeJqVholRrFqYruQqRo5vDOCH7eik
 FZgAwXkqktlnlg6tL314xWBiRsgNwheirNwtVH0kWbt+NSKFALsTtRnu3McJFJl+yyntyL86UN0
 qTzS3Q3zSqQs07D4qgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX3eApBSef604y
 y4vioI3c68F68cP9XFIeAyT5UUqwXFwVCDP6NEHeGnvT6JGx66lBo30lbxKI7MbQaw8+K+2EjzK
 Uc7dP5bG4ecduGlKVQyxqApUM0PlBVs=
X-Proofpoint-GUID: 11VjLwxvtKWxoB36xU_NwZChvB47tVFg
X-Proofpoint-ORIG-GUID: 11VjLwxvtKWxoB36xU_NwZChvB47tVFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IGFjYWFhM2M5NDRhLi5kOTFhNjUzYzNkNCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

