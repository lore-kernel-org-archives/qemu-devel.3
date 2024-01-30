Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DFC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoSm-0008AK-Qp; Tue, 30 Jan 2024 08:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUoSk-00088Y-Vk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:47:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUoSh-0000xt-Q2
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:47:42 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UDgB2r027784; Tue, 30 Jan 2024 13:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=NJXpPJkkdXXjmIP13XZ1szEZHNF8AUdw1dFPJrDHqfI=;
 b=hlqV90Vs5V1Dj/tOSb6c6oEtmCoW3OYmp2GZyQYwG2G+p0+uM5nzc925wYqCheXdA0FU
 ahUhVRuDE3KvpA/fGWe3YZ/24XMFKIui/4ibYid8nL0id0+2ucUjD7Z0m5mF4m5TS8/P
 CokVPf00cmT+/X/tsnINLCm0RO4/FdnL3buuIkIHFftutaRPhTGfoD4q3vDVzT/6RM7X
 lrmfknLvyR042UB7h6vdxEacc6+2E5SFu4kM/ruR338PVy2abE2YZs0gB0NMB/FGbPHM
 3gK1F9ZPXpc2HLymqdHZ9I2HF9/L4oSBtSy4fZgmyOWYilFgAandCcqcnCMsSTC+FE2X Rw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy27rg4js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:47:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UBxmKr007188; Tue, 30 Jan 2024 13:47:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev26jym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:47:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UDlYW944761794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 13:47:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7FE2004F;
 Tue, 30 Jan 2024 13:47:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D972004B;
 Tue, 30 Jan 2024 13:47:33 +0000 (GMT)
Received: from black (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 13:47:33 +0000 (GMT)
Date: Tue, 30 Jan 2024 14:47:30 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 29/33] linux-user: Allow TARGET_PAGE_BITS_VARY
Message-ID: <ms3tptv4ivxdhh5w7kiqtyukg6de5zpjja7bwdjz5g5xhhdirq@octi35juyhse>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-30-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-30-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I-79r6irshxbhXOhJyhymfNXo2jogHjA
X-Proofpoint-ORIG-GUID: I-79r6irshxbhXOhJyhymfNXo2jogHjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 mlxlogscore=939 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300101
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

On Tue, Jan 02, 2024 at 12:58:04PM +1100, Richard Henderson wrote:
> If set, match the host and guest page sizes.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

[...]

> @@ -794,6 +796,16 @@ int main(int argc, char **argv, char **envp)
>                                   opt_one_insn_per_tb, &error_abort);
>          ac->init_machine(NULL);
>      }
> +
> +    /*
> +     * Finalize page size before creating CPUs.
> +     * This will do nothing if !TARGET_PAGE_BITS_VARY.
> +     * The most efficient setting is to match the host.
> +     */
> +    host_page_size = qemu_real_host_page_size();
> +    set_preferred_target_page_bits(ctz32(host_page_size));
> +    finalize_target_page_bits();
> +
>      cpu = cpu_create(cpu_type);
>      env = cpu_env(cpu);
>      cpu_reset(cpu);

Not sure if that's an officially blessed use case, but I tried to
increase the alpha page size to 8k by doing

--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -20,7 +20,7 @@
  * a 4k minimum to match x86 host, which can minimize emulation issues.
  */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_PAGE_BITS_MIN 13
 # define TARGET_VIRT_ADDR_SPACE_BITS  63
 #else
 # define TARGET_PAGE_BITS 13

and this triggered an assetion in set_preferred_target_page_bits().
I wonder if it would make sense to add something like the following to
this patch?

--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -26,8 +26,7 @@
 bool set_preferred_target_page_bits(int bits)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    assert(bits >= TARGET_PAGE_BITS_MIN);
-    return set_preferred_target_page_bits_common(bits);
+    return set_preferred_target_page_bits_common(MAX(TARGET_PAGE_BITS_MIN, bits));
 #else
     return true;
 #endif

