Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CCDC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLUv-0006DJ-Q1; Mon, 27 Jul 2026 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLUu-0006D6-IZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:36:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLUt-0003bu-4K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:36:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAM2Lc3758623
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gJsdBdB0qxD
 Kx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=; b=fe+bFx250gG+zjKprayYGSeSCro
 lzXsQOTeUqc3EFVfOtRynNQn07sz/iNqHMTQGj3oCdaiK+4kzCfH9526kSlbdbHJ
 HY/RbeJkHTPDwOAkc66283Ud+WnuzJ7NL4rJ/6nKyFT6yLguq1c8+lcPfjOIBXqS
 j9MtyL5KqOzBvtQ5L33m27+IjRdGSxabXv293CUCFv8Y6KHM5b2ZqeNZ8TD4srDx
 sfNJ4HiYnQEKt3SKz9thzRsCmh7PjCya4v2e1PVV0o/ipEXs+cGsFwxRMh0sA/wu
 wkPDEA6OgipMFUeRfhRdXCuV3R1GQBNXBdQpP5t6ZdZNFLBw0UdbV4f90gQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c610kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:35:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2237bc43so1046012a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785159357; x=1785764157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=a1Z421mnkdXqMahm3N2+i8zRUEXTLuhb4r7xkTHGOfjDQR8xrFSJNESoKbwGXlVNke
 JIYQJeweLcEMT4ToWWvO6tGtU/oOeJ8nKwAgEfxwiU1IDfJgsT2ffz7qcsTs2+3KhoCn
 44M9uJ+54PBE/XKAbCJ+jmpFZFKlH+NK4FbJQy3VfskWvjZN2iQgJFLEwBV7Xi5i+GgR
 BmRzTcG/OmN/sz6zOeT/zSmq2BQ6IDnmzBWryOxY0hGqsEtSR2/MuWQV7nipBa+82c4H
 aLVAN2pT5VhH4gJQYeoRyhhyKTEq6BHm/JvTWv/q16v95qJHHbZn1EObySH90y5vK8Uv
 2ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159357; x=1785764157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=OHCtoVEKT7sEYkDjntze/uBqMokFWRIU54E2U3sQUCRqPG86AR0tww8hviCL14mEpj
 DLt7abOm2/Kdh66fM/Qqx7HUnml6ot1edD21tx1u39XBx2241/V+ZTvNgtXSbnb+oVQV
 rCpUZ5Q45K19ZndzgI2OvTlylr0V9DQttecq1rzRO4Z3Qnz9yzGl/JF+S6nrRSYW+/H8
 8v/74i+SBIhMwYiXL99Y74ryVNqQBlyFj+pkEMO31Ss3ayKudL2n3GhzSUlNZ7V5EsJA
 WXvKXMGld7EjajHxSnaZXnzirCHT84ZvIzvMdNa80B4iK4+vVDcKXtVsNGrDmO+jdwTx
 waBg==
X-Gm-Message-State: AOJu0YxSL8ywz66dsBKWHL+n+LOyhpfqsbbZvXPTANlgw6H7K/BFFneV
 qe8thPax3VNFtl+4z+ojWj5DwqQxGnwhAP2ggdcd1UtrjnP9FhMH6Uij4P3LVBYZucXsAaDkyYa
 Y0lyiKWdlKKfKT5QNM7egprIreJi50nmWteA0o26bGR6e4lm19Vu9RAME9Q==
X-Gm-Gg: AR+sD119TiKhSEQtdTdgFTR8Nio6qlHGKhoCC+RFo+Ll0s1u+aJK5NAMYQH/s2yVtGR
 y/t/gPFm7P6pOIDy6iE1euTMTvYGkwAjX88+6M01kOWLfOV+oxImhGsx1sQfX6fYYHa1Sphx3QA
 424FioalP3O/IivY7Nuh7HmP6Q6jg4P125C9LxRmrl0CXKjhHUrkWhzUmb7zSHExsTzoJuc8zgy
 25AKkK3QvcslXU16iRVuVS5X/aN4hIaKpqBsPBPwebMaVV9NOWNhOea6xBguCVXJ78sNk9Jf6Y5
 rljbyKD6E+tWW6sZdzwmg7y+C9PxpGCi8KS6K6LA79H68zXs3jfws7aR2bAerDhOqmX1mYD4X2Q
 J5wL9mx/kx71u97xVCd+zVRcexmfvZabdoNazqZ0ztBf+cqdqs+eK2yk3eNgqjsc=
X-Received: by 2002:a17:90b:1dc7:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38f605a4861mr685123a91.30.1785159356689; 
 Mon, 27 Jul 2026 06:35:56 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc7:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38f605a4861mr685095a91.30.1785159356231; 
 Mon, 27 Jul 2026 06:35:56 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc59e9fesm29280975eec.27.2026.07.27.06.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:35:55 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com
Subject: Re: [PATCH 2/2] tests/tcg/hexagon: add slot-assignment tests
Date: Mon, 27 Jul 2026 06:35:54 -0700
Message-Id: <20260727133554.2611222-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
References: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a675ebd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QQwjxq2vsnLLEq96bu4A:9 a=ZXulRonScM0A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfX1d//hBEClqQE
 rvLB2xTd/g35Jrl2iPfhoJRzBw2EmJ1+vvOMWpVemcTxj/FQCM22ogBsYCTlOGJXsgV+qKzwbpH
 mV8EluZni9/iTtguiC1sv14WRKqKG0Q=
X-Proofpoint-ORIG-GUID: 1J7qsgHBK9AfIaUyHZ5Oky0_8muDS9Eu
X-Proofpoint-GUID: 1J7qsgHBK9AfIaUyHZ5Oky0_8muDS9Eu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfX/z0mU2HHQcnD
 RWke466Xa/yH2I31fC/uoGEjFjc09JreNF6IaYbJDTt6dKr+0f5kmYBsh+48xBxAEj4RVQFNcP4
 LbGv8vortVgPRzz+kW55itU+y6wRutTU0FTEuFYywEkcLAW5qFFUZ7d+AX2wXVv2+/pE294q9un
 cB6GRJmoG3BpnbYFs2MhtQtdOKoqZPGB63qa4ZV8O8AqCEY4iq60wXSSXqJ+T2gu0sKELN4ol2i
 JwHdqfO7kRN0ZP6LZ7rP4qwfx1dLQzsJgZTv+7sfMxLv5wv+nRdkdnoESIF1G5+oXp1BhdS9AXz
 nkzcL+GrGm5xaO9tXBtseNE1rVwFUnUtBfiAbRhVpVmUJHu7RW+PLINoFyKCkc4pUHRLYHIsBJW
 c/S3TgGDXS1GV4xsy7PH1gynZm5sU87yluvgoSlNSAvqriWe1z2SvBKaYmgyPQrzZd/xf7lDxhq
 ZT8NngQ7TYlntf4/4vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On Fri, 24 Jul 2026 10:18:45 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> valid-slots: packets that legally share a slot and were wrongly
> rejected before the fix (load and transfer, load encoded first;
> dczeroa packed last with three transfers).
> 
> invalid-slots: unassignable packets that must still be rejected:
> store + duplex, load + indirect jump, three logical ops competing for
> slots 2 and 3, and five ops for four slots.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target |  1 +
>  tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 tests/tcg/hexagon/valid-slots.c

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

