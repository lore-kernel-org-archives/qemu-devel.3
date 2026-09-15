Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBDC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1I-00065T-Iw; Mon, 14 Sep 2026 20:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H19-000620-Ci
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H17-00011J-PQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxxDr1272473
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BTXXcS6bESA
 dJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=; b=lfrSd0/p2LXVyhfFp1WBvfS4hby
 yf4Pv20v8XW7mRrxyLYHWpbpUbDNQU2BsLRerfvIrm2lv5PyPmvpssMApYdbrxOC
 W4aeV2zdqjt/6mWBtCYklIFyFWq3JVQjrJIYJHJsb3R3HI0mvY5jzzMiyPl5hWQV
 B4Wa2ZPOvr50DH6I2mBlhEA61B+MlhNM6dSnhK4yz6DeeYkm0htlc+qjoepFdR9E
 ztSzFc13lvgRk2oNT2I2zI9sHpMAh/hCK/Y40Hav8p6vT4/lhGb1DKpKuiK67HR0
 7e/kHJIc6MkJC4RP7WJo87UN+JfrkbLnYsZUOhLGslyOFkSF0swOoo0oo7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f3mwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so4712309a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432040; x=1790036840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTXXcS6bESAdJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=;
 b=gn4Hoh/KXoFg54YY5ePw2HuDUE6EWuPCr24paa8yBBdKr7K/zcErUEy+Tq0d3udciD
 spwFisFGHocjcmqsEdZHHvehQaidYHwCsc8V8ErLezT7QhQKVecjTnC5OBugxQsH28ol
 Efa/FVP0Pnm2gRtjPiYCmkaor7XpIofp+0xPgb604ZWkbpeywtmY2/+4lpNQx7xzuwgt
 KnLAqhWYGXbst5QMsZk/P+je3p/fs2B0KCeooOm1PZo49qryRSyJ+ahow9GUM1DBTPv/
 DfGwJRarH7kmwxEW+3bm1ZBWUG1UobHc+1aSEwoQsYxvYr/tTQZLlK8fEiAZLXKhYcbb
 7EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432040; x=1790036840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTXXcS6bESAdJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=;
 b=RCOQ4fuCDnOA15RhmOmXqu1+70NKN9biAQZGl49puZItGspsBQDqGMyS2BfsnxjCpP
 CPd+9ezADbAeBPcYC+upxVRFU0yVsGLdC8S7GuNErsvzEqnXt9ZezHRb4Zd+QOPP2IML
 WZFHIvl5OXZqqJnRhVXyZEmmV8CEu42zsmfdautFQP7s4vCruc2YMx/PZftZ9tiZmeXr
 9sVxnJx7smRm5Nc4e80wfgxrCEKEFWslol5edbuDF4KEJx0AWxWTth0Bmd4OYqODeuwu
 SxR83lhQXMwA06+TTObgKlAiwjaWGiHKC3XsnhT/LUDq1AfvLvqMcpo7hGqa4zWGDwYv
 BwKQ==
X-Gm-Message-State: AFuF++mK4QXMxog/QYoUAZtTmWskC7hKRL9m7k6oJz2v1qPTR0njNIZv
 JBQtcTXRd2WTFcPfW9S1hp84fgJ9cjoA3xN8s+rifNQNTn4uMLBUyGAPfyxCb+OWLbdRbYACe8M
 ZfnaDj+0463iBJ6r6qokOhhu85Ljr+kUCxjYv02hiSGOeUV8nL1Ch+LuZOqm0LVLuNQ==
X-Gm-Gg: AYBFou1GmM4pxTfkhuIGVDLr6dZZb1M3Z6nhw3H6YmuhDK74PhgeSsW+1t8xVrEr4+6
 zm9YZX+m2EVnpSLbCtJq4GhPX74XxcW2I9+OTNIagt1B/aAV6itcudh/cnF+INjYCMKlvHdi94w
 gBeOgg2OK2L15XMgOzvQMGbfDRqKRyGXHlM6IWYFDI5PrxgwY1B1wZ1i/XO6ieY/lhp1DyLlCE7
 ule4Oq0JPY4mqAzjWGJ46oMjwvLcopK7NU9sy1RTzlZbuSoyGsOGFvaZ0CtLpjOhqdjhv3XzUNn
 PivztO6gPZp07JFV0pMFv4dyvVFPhu8II1mQ+3q/v80oAcG0RUvbERE+fTu3GFtwtg061R3C20n
 ACvpPr8RjWam6Kdopr8qobG3EBkT2w8G1BnURFH1uyAWGRwtlBxU+eAgO8SE=
X-Received: by 2002:a17:90b:39cc:b0:39d:b769:3067 with SMTP id
 98e67ed59e1d1-39debdffe17mr9713990a91.0.1789432039893; 
 Mon, 14 Sep 2026 17:27:19 -0700 (PDT)
X-Received: by 2002:a17:90b:39cc:b0:39d:b769:3067 with SMTP id
 98e67ed59e1d1-39debdffe17mr9713933a91.0.1789432039463; 
 Mon, 14 Sep 2026 17:27:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/6] roms: move optionrom from pc-bios
Date: Tue, 15 Sep 2026 00:27:03 +0000
Message-ID: <20260915002706.36318-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nGYK6zMkWx4o1971LTCc40h-w_PILnxJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX1VyRCVSk7BwF
 2e+bnAqqJlxdjC1s4E2h9lpWywT3tZNd52tz5MKHOP73FZ/v+F64BjKOUdF75iMRuibb4aRikLD
 E/5ZvXFKsx5kYEHXwaIOxR9r7TaPZuc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX2Qap3koXzVo0
 gBxB2V33geymSZlCmAAEdEuBm/yLt/FucD7M+RZe5d+9CDmeyU9gt5bQ6faDU16RkzabSZiuuAH
 xwP08Z19UcXgvfQvwvN1TNH5R6vF7OAi291jMcNzEpRwSnazCA+bH8oynMApwCHmTsmtVqFAQao
 j6Hd6Xztg2/Z6EO8jwKIseKdNxEO4oXgz33jWDqZZq6YgH0iD0VHJJU65JE0iIZQq4W0zamhde/
 ya/5BccgKnKEd9Hb8pDZW/u8cr4Z0xZAvYx0vh706LdOjA6s0570H6jcb7V5Ajj1kJgbahHXDm6
 +woxiXTDn3kIw4VrCeNND4JYlec6eqA2YE/Y5+dx2Hk1hnSOeK10NnfWYCtevVe2neVixE3bf84
 7q8TwwzZOhX+X7HDSd5SGtNebSDFxaZZEDdi6Sl4iGvKcU95M5sBCOGv4j7nb5iB0rbs71XBkn2
 WCNikNCcYSSZJ7sgoKg==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa890e8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=3qtoDJxBsQnwwpl5T48A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: nGYK6zMkWx4o1971LTCc40h-w_PILnxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150004
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 {pc-bios => roms}/optionrom/Makefile        | 0
 {pc-bios => roms}/optionrom/flat.lds        | 0
 {pc-bios => roms}/optionrom/kvmvapic.S      | 0
 {pc-bios => roms}/optionrom/linuxboot_dma.c | 0
 {pc-bios => roms}/optionrom/multiboot_dma.S | 0
 {pc-bios => roms}/optionrom/optionrom.h     | 0
 {pc-bios => roms}/optionrom/optrom.h        | 0
 {pc-bios => roms}/optionrom/optrom_fw_cfg.h | 0
 {pc-bios => roms}/optionrom/pvh.S           | 0
 {pc-bios => roms}/optionrom/pvh_main.c      | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 rename {pc-bios => roms}/optionrom/Makefile (100%)
 rename {pc-bios => roms}/optionrom/flat.lds (100%)
 rename {pc-bios => roms}/optionrom/kvmvapic.S (100%)
 rename {pc-bios => roms}/optionrom/linuxboot_dma.c (100%)
 rename {pc-bios => roms}/optionrom/multiboot_dma.S (100%)
 rename {pc-bios => roms}/optionrom/optionrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom_fw_cfg.h (100%)
 rename {pc-bios => roms}/optionrom/pvh.S (100%)
 rename {pc-bios => roms}/optionrom/pvh_main.c (100%)

diff --git a/pc-bios/optionrom/Makefile b/roms/optionrom/Makefile
similarity index 100%
rename from pc-bios/optionrom/Makefile
rename to roms/optionrom/Makefile
diff --git a/pc-bios/optionrom/flat.lds b/roms/optionrom/flat.lds
similarity index 100%
rename from pc-bios/optionrom/flat.lds
rename to roms/optionrom/flat.lds
diff --git a/pc-bios/optionrom/kvmvapic.S b/roms/optionrom/kvmvapic.S
similarity index 100%
rename from pc-bios/optionrom/kvmvapic.S
rename to roms/optionrom/kvmvapic.S
diff --git a/pc-bios/optionrom/linuxboot_dma.c b/roms/optionrom/linuxboot_dma.c
similarity index 100%
rename from pc-bios/optionrom/linuxboot_dma.c
rename to roms/optionrom/linuxboot_dma.c
diff --git a/pc-bios/optionrom/multiboot_dma.S b/roms/optionrom/multiboot_dma.S
similarity index 100%
rename from pc-bios/optionrom/multiboot_dma.S
rename to roms/optionrom/multiboot_dma.S
diff --git a/pc-bios/optionrom/optionrom.h b/roms/optionrom/optionrom.h
similarity index 100%
rename from pc-bios/optionrom/optionrom.h
rename to roms/optionrom/optionrom.h
diff --git a/pc-bios/optionrom/optrom.h b/roms/optionrom/optrom.h
similarity index 100%
rename from pc-bios/optionrom/optrom.h
rename to roms/optionrom/optrom.h
diff --git a/pc-bios/optionrom/optrom_fw_cfg.h b/roms/optionrom/optrom_fw_cfg.h
similarity index 100%
rename from pc-bios/optionrom/optrom_fw_cfg.h
rename to roms/optionrom/optrom_fw_cfg.h
diff --git a/pc-bios/optionrom/pvh.S b/roms/optionrom/pvh.S
similarity index 100%
rename from pc-bios/optionrom/pvh.S
rename to roms/optionrom/pvh.S
diff --git a/pc-bios/optionrom/pvh_main.c b/roms/optionrom/pvh_main.c
similarity index 100%
rename from pc-bios/optionrom/pvh_main.c
rename to roms/optionrom/pvh_main.c
-- 
2.43.0


