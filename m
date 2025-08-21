Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A159CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 10:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up2vw-0000AK-9x; Thu, 21 Aug 2025 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1up2vu-0000A7-2m; Thu, 21 Aug 2025 06:54:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1up2vm-0002g3-Ui; Thu, 21 Aug 2025 06:54:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0C4nb002157;
 Thu, 21 Aug 2025 10:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5yHoLeTiaysUGgLWnLEACUyxrZ7A3s
 RY9tBLnJx6TnY=; b=EVP4Avw0/kgXfWxXDO7JyFNi87RsqHHqPRDzi/Gr+kBal0
 o3iT6kdUoqPKTKXssXw9PP1IByMqhAx50G0ne7SJqZABWfylmyNVAbMrgN3lSn6r
 nI0BcyrUyXJaAVnpI86xx0rtzmsDsHg467nrMTMhPzPwqDURmuHyUp22LUue0fwp
 F7uMb1Ov56A5Yfv7YEB41fk/LUWFC8DXmVYO3zyd8mlZw35Y52HKBBoBFGxDTIWr
 +UQ90GciL06n7F0/3dl2Jgo9bHiw1pleFUlEaINYhlsmjFSJhe53DV9P2iW2yiny
 eBL0+n7A4RNp1gQfrNioLcUHjDQr8TZDg11GkLzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w82e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 10:54:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LArxxd006306;
 Thu, 21 Aug 2025 10:54:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w82e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 10:53:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6sKWb024778;
 Thu, 21 Aug 2025 10:53:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5vyx1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 10:53:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57LArteg62521812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 10:53:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AD5220049;
 Thu, 21 Aug 2025 10:53:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DAF420040;
 Thu, 21 Aug 2025 10:53:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.211.200])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Aug 2025 10:53:52 +0000 (GMT)
Date: Thu, 21 Aug 2025 16:23:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
Message-ID: <3xbdwul3qwdb246pk5xeeduotfvyeyjr6qkozzatb7h2zdrxlb@pcuu3ewglrjj>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820122516.949766-2-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX0FdUNxUd2c49
 jMM9fW/zXuZmE9xOsWb+zO7Svje2LGZ4FQUMN6fDjXD6JVu+6fgpDNajL/mrfZRFgyCL3E32TTs
 nzWJXHA7S7YdwHtqP7nmDbMk6YZZAy/gJPNYI352L5Pxly4pYxCimrDk55hjU22GIiXvR/T8XNJ
 /jpN91pWgOH3y1eKvbnSASZ18eAX4IiSh219bfKh2kIVozKU/n8ftIv9n50JAPeyMwwNpaoh4Vh
 g1+UeHK/O4sKmPhrf0JNt80bCQOrFln5J0+B5iuyoZpBUdzlgM+pO+bVPOpIYzXJ3R4zLmcO5SW
 9Mcm91dm64fstT/84xkNdz5+lyzgz/XokTK3xBx6vZe9qhf0L+gpbqGnHVz8LRh//IZKS36Vbe0
 cO1GEOPQ0a5hu2kCrmRVfDIENh0hrQ==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a6fac8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=r-MSxGZfJkXS_mSMAKMA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: pI2M6cQAdNrwlu-K8AdDAQNSkqwXgMNi
X-Proofpoint-GUID: ZW6SubSS6iyLszio1hObX8VVpqKPJTGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/08/20 05:55PM, Aditya Gupta wrote:
> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
> with --without-default-devices:
> 
>     $ ./configure --without-default-devices
>     $ make
> 
>     [281/283] Linking target qemu-system-ppc64
>     FAILED: qemu-system-ppc64
>     cc -m64 @qemu-system-ppc64.rsp
>     /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>     .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
>     /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>     .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
>     collect2: error: ld returned 1 exit status
>     ...
> 
> > <...snip...>

The following is also sufficient to fix the compilation issue. Wasn't
sure if #ifdef POWERNV looks good there:

    diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
    index e7d94625185c..a8e55b2937c7 100644
    --- a/target/ppc/misc_helper.c
    +++ b/target/ppc/misc_helper.c
    @@ -323,6 +323,7 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
     
     target_ulong helper_load_sprd(CPUPPCState *env)
     {
    +#ifdef CONFIG_POWERNV
         /*
          * SPRD is a HV-only register for Power CPUs, so this will only be
          * accessed by powernv machines.
    @@ -361,11 +362,14 @@ target_ulong helper_load_sprd(CPUPPCState *env)
                                       TARGET_FMT_lx"\n", sprc);
             break;
         }
    +#endif
    +
         return 0;
     }
     
     void helper_store_sprd(CPUPPCState *env, target_ulong val)
     {
    +#ifdef CONFIG_POWERNV
         target_ulong sprc = env->spr[SPR_POWER_SPRC];
         PowerPCCPU *cpu = env_archcpu(env);
         PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
    @@ -392,6 +396,7 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
                                       TARGET_FMT_lx"\n", sprc);
             break;
         }
    +#endif
     }
     
     target_ulong helper_load_pmsr(CPUPPCState *env)

