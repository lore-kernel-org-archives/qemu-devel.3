Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E39C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoWi-0004We-2y; Tue, 30 Jan 2024 08:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUoWg-0004WH-BN
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:51:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUoWe-0002MC-Aw
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:51:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UDgbFD031921; Tue, 30 Jan 2024 13:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=J2/Mm3KLYRte7mAm5li1L+S45pf2x/GofsfWgxrt5cU=;
 b=jMKwABOfP9KCuoW6tPclQsBqGYxFh/DQg7tcUnn/NdKJjrIH+KMA9lyvcRQLPHKBu6rD
 5+q090L8ophrIgjvxNYnH0iEEFExULIYaHDviCIin/WU+R11ggyth7zT2s+xGlHLCYDh
 OEknUfnUYHZvkt/XGfXjFgOk53THl74OA28heSXF46C21Z0eSE/GhzTuGKggn8xamZns
 s8HjHCkWxG/IDsyWKSh/MYUxhhkKgV3SEun/wWkYTlYCuiQnGciUanNV/6mwHPmEbp2n
 4SR/weQ4rSdMmv2qmfCfuGQgx47liLT01eK1vc3YUWXyJbJDwJ0VoDmCh2KWL7G/T5li AQ== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy27r078v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:51:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UBgrvu010884; Tue, 30 Jan 2024 13:51:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckeq7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:51:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UDpbOC18153918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 13:51:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D15BA20040;
 Tue, 30 Jan 2024 13:51:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB7112004E;
 Tue, 30 Jan 2024 13:51:37 +0000 (GMT)
Received: from black (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 13:51:37 +0000 (GMT)
Date: Tue, 30 Jan 2024 14:51:36 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 32/33] target/ppc: Enable TARGET_PAGE_BITS_VARY for
 user-only
Message-ID: <c5c2y556qjlmiqrgjqwgbjkvouoipz2t2dgs6w7euvj2qbgsph@2s7o4mjf24it>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-33-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: btq6_j9bhmDwvSVLiYOIgJ346zCC6HDz
X-Proofpoint-GUID: btq6_j9bhmDwvSVLiYOIgJ346zCC6HDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=697
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 12:58:07PM +1100, Richard Henderson wrote:
> Since ppc binaries are generally built for multiple
> page sizes, it is trivial to allow the page size to vary.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu-param.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

It would be great if it were possible to choose the page size from the
command line for linux-user. I was recently looking into comparing
traces from ppc64le-linux-user and real hardware, and mismatching page
size was one of the things getting in the way. Of course,

--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,10 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
+#if defined(TARGET_PPC64) && defined(__linux__) && defined(CONFIG_USER_ONLY)
+#define TARGET_PAGE_BITS 16
+#else
 #define TARGET_PAGE_BITS 12
+#endif

worked, but an official support for this would be even better.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

