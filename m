Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F29C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUd-0000sx-T6; Thu, 16 Jul 2026 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUb-0000sC-UQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUZ-0001TP-HV
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSq0C3481671
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KMIpPvOXOyd
 LxlpKluNdP1sFyAVO3m7HbJayX4OTafU=; b=MWjDtlS9JIR68xfUhMfYyKx19bA
 lxORi/iWLR+6gLwABAaf5QOx+7wYj27o6e8UYWP41w8diHPEcfuoe+sY6t2argWP
 IlLF184+hm9nI5GwMmIPgFtfKRw1Dh8KuQcst0ZUrdBQqcZevT3F7Xv20s1cCKYH
 KHOOdYmbA1huiW0xYzBBMbPRSRS5Flje/QNtZ80PbRFBN6ROXxbNjNSE2Mnp6uNI
 lZqFZ2qmQriAaDvgoSU759jBK3syopmvA9x0+1qCmZeggWGADghWpoxzbM+DUZ73
 SAj55+Y415cJNARA+9VafM//ESE8tqApJYnjimUNG9obiGLRUNag734rBiQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf2usd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38de0739ab6so4871526a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225245; x=1784830045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KMIpPvOXOydLxlpKluNdP1sFyAVO3m7HbJayX4OTafU=;
 b=IAv4Yz0/oxePYt32/2lKvPCja//GdzEft902XiDAaL4n5YfbFGb5zVVovjkDbflM5s
 lQE1Wh0L0oCpFlh8InT+QHRKJjXog1t/2AMjIO2y283IJURmnuJ53lzRbGyimcKjVr5y
 8uPzqZB9H3NLN1N20k1kmwiG4U4ljPHKqYbBFX62PUKIfIaMg+m0jHXW44kbigYTlC3Y
 7Dq0HzLuRiipBhCwmTZtwjTRFd7TzSOybu9NnFJhXwTfJejYlSrWWul0VBHCFK520QGm
 K+hNyS+Li2ErWZZoXXAhdjYY3YNUwFOay01o12jlXxNYEc6zN2HIy2GNCvikXgdodac3
 0CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225245; x=1784830045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KMIpPvOXOydLxlpKluNdP1sFyAVO3m7HbJayX4OTafU=;
 b=hh75ZZs25t2BaqdtkoMjsbOg9Bblx5faAbMn39GxgJLw+IbvouZ3AzgTRSP0MmZ7Pd
 997v0gT6Ul24Kter4uUf8TAI6S1tLpBm1ImgM6/wpODKFKwoonxeOw6VgpZ8GEkYUz1W
 ozL2xeYRuTzLfJfXKkV+QYhCWqeLjT2DYZ/Za+DNnJFem7Twxw/gwgI8PUjq7bmqKmdt
 NHLaSLa7g6vufwiHGVunyBsAXwBodAkwF1zxNjWunAzZ3hsNQB1GHK+U6lJ0SnXX6T/k
 GTmlwev6ysUzhpybIADE6jIz+W+PXnAgi9db0p02cbNWXqk8/wwDtwsTJi8a/SQGv+5Z
 otSA==
X-Gm-Message-State: AOJu0Yyb3nCJj2gsu3GjOy20z1aIgLuqkF+Vboy2D1TV5+6qNZZGMR5K
 WhHpLFXzttu//T37mrJW3SDsIvQ+N4GKdXRYVL1LE95ocnaVJtsUYSqgvcMG5DcbZFv1CgSlplW
 E/21sbpVEsm9vYrtPDxHlXSsRPdg0RPxduJSfEVMnK39V1sYInCUr017zBvXoYjgAmg==
X-Gm-Gg: AfdE7ckvQXDOt3xAN3Nl5rLq7KR9K2SBgkCcCkChQPnjT+x9ssBvleBA3T5xdB9jvza
 OiNtINAAvmmHt9QHgzQLzDYSmuzMGI3bJk7p1+SHo2yddOa68oGwwOQ+NuLti5eQ8ivMLOSKkK4
 0l3MEO4pKOiXs43+V8AoI5gmuRgk22fr/u6lymbERkfs7nnBhP80xcZqDYoQ1t3PqjRp8kcJPlx
 qQ003cv/opg959DHqEi1lkLc6tGeU/9VBGw1sF+O3J8Tz+a70TInj19z65dfj0gOTDvBz/VYfIO
 z1NpXAbPEUWzfSoU7AMGudGVfFusWn9RahnD6Fc7+U4Ic7E1+8XkAM9xnHexMBfIfLqQ7J2u/lp
 2TfASUlPv5w9aTbzqQcxCWmoHHUs0IcLl6igbCmZzcD/4fmG/Vys8tW1MGwv6NRM=
X-Received: by 2002:a17:90b:510a:b0:387:e0bb:57ff with SMTP id
 98e67ed59e1d1-38e2a10a4b0mr7190958a91.38.1784225244590; 
 Thu, 16 Jul 2026 11:07:24 -0700 (PDT)
X-Received: by 2002:a17:90b:510a:b0:387:e0bb:57ff with SMTP id
 98e67ed59e1d1-38e2a10a4b0mr7190925a91.38.1784225244161; 
 Thu, 16 Jul 2026 11:07:24 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 02/14] target/hexagon: fix get_phys_addr_debug with in-page
 offset
Date: Thu, 16 Jul 2026 11:06:46 -0700
Message-Id: <2f5247200ec9007c2765d9275f84dd45095b07e5.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O_a-skEHZ7F47S9UaHE6UMw1IJ7vPlRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX4vKYhfxe0OW1
 hOb6W6RrT3jF4YyrcA3ukTdBxgvbVoOKKStFYx+2Uo81avihdcJPpscCBNF9BZsnURH0hL8tWpw
 ZLVUEAmUBSvxi79PAzvD0lRgu1MKi/yKa1A6+zLmYqoZwuDT/+8zeyNsRr0CQJF/nVIS8FnRTus
 2I82pdxpPJZSbd/n4IpHBzORdszq7wPs903oV18L/H1oK5uwKEH4bRoRb9IvTPAdkq6iHEu9eRE
 besquLmIopkyhCoLWKnTECUJsZapJQJ0C9W/Gk+2FptjP3WhEueUOXGyBevYV7ropDKG4GXSaSs
 lygeqM9XF6IL+kbM0/BvWtmfX0tbyX7jU0Rv8HnOH3rDG5+qSJ1OZ9FTt/XbO+gfoT1ajlG0XWO
 ewEBR2gHIGmlv0VC6R9wDzxInLFj7h/v2/8H2k3xUajgFYZfkGs68lJR8ijxy+3HYK1JwQ2TLmq
 Qx8bZujomA7OB5pCYyw==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a591ddd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ERpe_kbT2-JOHJ70sIsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: O_a-skEHZ7F47S9UaHE6UMw1IJ7vPlRK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXwMgmXByeMMnV
 N32nVWMgr58jv6yzPqhcgs3kEJQDM2N8n+ZCxJrL4prz7fIfz54AmV1TVOut3+7VhWf3PjBGOu+
 tDc26HSDEO8on5BwgL3cZi6NRHMxgd0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
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

As documented:

     * @get_phys_addr_debug: Callback for obtaining a physical address.
     * This must be able to handle a non-page-aligned address, and will
     * return the physical address corresponding to that address.

When MMU is enabled, hexagon_cpu_get_phys_addr_debug() returns the
physical address page-aligned, not corrected to reflect the exact byte
the virtual addr maps to within the page. Let's fix that. The
MMU-disabled case is already correct.

This would break semihosting argument reads when it is added for Hexagon.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index eac355497d8..73a799da877 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -570,7 +570,9 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, &page_size, &excp,
                              addr, 0, mmu_idx)) {
+        vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
         find_qemu_subpage(&addr, &phys_addr, page_size);
+        phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
         return phys_addr;
     }
 
-- 
2.37.2


