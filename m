Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC11FEE4CD
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 07:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwF7J-0000Ly-TW; Sat, 28 Feb 2026 02:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwF7H-0000Lg-FD; Sat, 28 Feb 2026 02:51:59 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwF7E-0006Nc-F5; Sat, 28 Feb 2026 02:51:59 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61S7o3lr012919
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 28 Feb 2026 16:51:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vTjWadEvTBHuiB9pG19yl0PGYUuurjYy2jRtAfTa7i0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772265099; v=1;
 b=o/XwUd0DxPZlT2RS97vi+Ad0kIwNBG6B/f2UCIVywHUU+ylYqb5riALjVYsPUuyr
 ywOm6ykyAX77RmEgBmrmhEK9s/lcfP03fCZbij2tEyuOQvmT8FsjCPswL2Zv2UMO
 q4mFiJUDhXIbXdK24J6koWzD1rgxTyFWLUyUWJTRYu/kMCRabFsvkpWF7ITNjS+Z
 f5faJgFfqQsjCxZc2pXhJjdmhoKU80U2qb6vnKh2z2XpsebRKosVihSPb+6bWY/g
 sg3Xzno5ZQZw3+19KRuj1QZyFcWq+cV9KFXzdw0b/N4lHOVDp2Tx0cDCpsvLYhEh
 FnVDNmkfi7VIsXshaQr1bw==
Message-ID: <b30f4300-33be-4737-89d8-3742efbfeb87@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 28 Feb 2026 16:50:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] gdbstub: Always infer base register index from GDB XML
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <d381b443-93e8-435e-801a-eae414216940@linaro.org>
 <bc7dd4b4-f011-415a-bcd7-6f4fb45b6d55@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <bc7dd4b4-f011-415a-bcd7-6f4fb45b6d55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/02/28 8:10, Philippe Mathieu-Daudé wrote:
> +Zhao/Paolo
> 
> On 27/2/26 23:39, Pierrick Bouvier wrote:
>> On 2/27/26 1:39 PM, Philippe Mathieu-Daudé wrote:
>>> Generic fix for a latent bug reported by Florian:
>>> https://lore.kernel.org/qemu-devel/e44df309- 
>>> d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
>>>
>>> Use the 'regnum' XML tag for feature base register index
>>> (after fixing the incorrect m68k FPU ones).
>>>
>>> Philippe Mathieu-Daudé (4):
>>>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>>>    gdbstub: Make base register explicit in m68k GDB XML files
>>>    gdbstub: Emit base_register index in GDBFeature entries
>>>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>>>
>>>   include/exec/gdbstub.h     |  4 ++--
>>>   gdbstub/gdbstub.c          | 16 ++++++----------
>>>   target/arm/gdbstub.c       | 21 ++++++++-------------
>>>   target/arm/gdbstub64.c     | 19 +++++++------------
>>>   target/hexagon/cpu.c       |  2 +-
>>>   target/i386/gdbstub.c      |  8 +++-----
>>>   target/loongarch/gdbstub.c |  6 +++---
>>>   target/m68k/helper.c       |  4 ++--
>>>   target/microblaze/cpu.c    |  3 +--
>>>   target/ppc/gdbstub.c       | 11 +++++------
>>>   target/riscv/gdbstub.c     | 18 ++++++------------
>>>   target/s390x/gdbstub.c     | 15 +++++++--------
>>>   target/sparc/gdbstub.c     | 12 ++++--------
>>>   gdb-xml/cf-fp.xml          |  2 +-
>>>   gdb-xml/m68k-fp.xml        |  2 +-
>>>   scripts/feature_to_c.py    | 14 +++++++++-----
>>>   16 files changed, 66 insertions(+), 91 deletions(-)
>>>
>>
>> See some check-tcg failures:
>> https://github.com/p-b-o/qemu-ci/actions/runs/22505136358/job/65203283939
> 
> I ran check-tcg on a user-only build... And neglected system binaries.
> Sigh. Thanks for testing / noticing.
> 
> Per commit f46e5073a8a ("i386/gdbstub: Add APX support for gdbstub"),
> the gdb-xml/i386-64bit-apx.xml file comes from GDB, but I can not find
> it there...
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/ 
> i386;h=524dad125c554f6210e8987f141383b98ec606cf;hb=refs/tags/binutils-2_46
> 
> Maybe it has been generated manually like the m68k one? In that case
> it could miss the @regnum tag, and the fix could be as easy as:
> 
> -- >8 --
> diff --git a/gdb-xml/i386-64bit-apx.xml b/gdb-xml/i386-64bit-apx.xml
> index 11a4ec67cae..34cd501881f 100644
> --- a/gdb-xml/i386-64bit-apx.xml
> +++ b/gdb-xml/i386-64bit-apx.xml
> @@ -9,3 +9,3 @@
>   <feature name="org.gnu.gdb.i386.apx">
> -  <reg name="r16" bitsize="64" type="int64"/>
> +  <reg name="r16" bitsize="64" type="int64" regnum="16"/>
>     <reg name="r17" bitsize="64" type="int64"/>
> ---
> 
> But I have no clue, it is too late for me to look at GDB source code
> so I'll defer to Zhao / Paolo and revisit after the week-end.

Found this:
https://github.com/intel/gdb/commit/de7fe4e5efa952da2499424f7b70a5d4fad7cf6c

Regards,Akihiko Odaki

