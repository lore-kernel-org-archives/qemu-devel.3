Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E98C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkO4k-00062W-MB; Tue, 18 Feb 2025 08:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <solemnwarning@solemnwarning.net>)
 id 1tkLpb-00017l-RY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:32:09 -0500
Received: from chulak.solemnwarning.net ([50.116.12.208])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <solemnwarning@solemnwarning.net>) id 1tkLpZ-00086V-3C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:32:03 -0500
Received: from gandalf.solemnwarning.net (82-71-51-99.dsl.in-addr.zen.co.uk
 [82.71.51.99])
 by chulak.solemnwarning.net (Postfix) with ESMTPSA id 11E741DE5C
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 11:31:54 +0000 (GMT)
Received: from [172.24.128.21] (infinity.magi.local [172.24.128.21])
 by gandalf.solemnwarning.net (Postfix) with ESMTPSA id 6F7FD202D4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 11:31:51 +0000 (GMT)
Message-ID: <73cc235e-6401-426e-b02e-e5a72ae8059f@solemnwarning.net>
Date: Tue, 18 Feb 2025 11:31:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Daniel Collins <solemnwarning@solemnwarning.net>
Subject: Strange floating-point behaviour with some CPU models
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=50.116.12.208;
 envelope-from=solemnwarning@solemnwarning.net; helo=chulak.solemnwarning.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Feb 2025 08:55:48 -0500
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

Hello all,

I'm encountering a very weird bug with some floating-point maths code, but only under very specific configurations. First I thought it was a Clang bug, but then further digging eventually showed it to only occur under Windows VMs with specific QEMU CPU options, I'm not certain whether it is a QEMU/KVM bug or a Windows bug, but thought starting here would be easiest.

When compiled under MSVC Clang with modern CPU instructions disabled (e.g. -march=pentium3 or -march=pentium-mmx), the floorf() call in the following program always returns 0.0, while the truncation works correctly:

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
     float n = atof(argv[1]);
     printf("n = %f\n", n);

     float f = floorf(n);
     printf("f = %f\n", f);

     float c = (int)(n);
     printf("c = %f\n", c);

     return 0;
}

Example output on an affected VM:

C:\Users\Administrator> floorf-p3.exe 10
n = 10.000000
f = 0.000000
c = 10.000000

C:\Users\Administrator> floorf-p4.exe 10
n = 10.000000
f = 10.000000
c = 10.000000

(floorf-p3.exe was compiled with -march=pentium3 and floorf-p4.exe with -march=pentium4 above)

I've tried a few QEMU CPU models on a variety of Intel/AMD VM hosts and two different Windows versions (10 and Server 2022), and observed the following:

host-passthrough: works (on AMD and Intel hosts)
qemu64: broken
EPYC-Milan: works
Westmere: works
Penryn: broken

Happy to provide executables and/or disassembly to aid in debugging this.

Daniel


