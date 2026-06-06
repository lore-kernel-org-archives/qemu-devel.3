Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB49CD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 14:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVrau-0005gh-0O; Sat, 06 Jun 2026 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wVraq-0005fr-G1
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 10:01:45 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wVrao-0007Cx-QA
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=oyMDvmTExp3BdQtP6HqeB2oZ43ihDQ1Cr6l8pJNYXSY=; b=JDOuEq6ab2tLAlD/
 vliKWyux733AvMNcorCQw59Mcd+BVdoEInFekMMmPQUmXBXUzJRoDeIJDppmN+To+hc/s2dFdkovu
 eORHRTSjoVnMuC95vDSbqacB1jvf/dqb6FmUgXqww/C7mzL9WMQHy+fFIstXErDNFBIRdaFzYcS/c
 hEOl1WUf+mYeXuo+kwlP0fo0aV7fiqzDbkRHwWxvi7NAOZjIGBcb+BfsFxBMv9fddZX/06YSF6dXu
 n56mEoFXPvAiLJsWAXHw3FJIz/49iraXwK27OivLWomoPmVJp3UFZQ4KsiahyJEzjeelJ9X8qI4DL
 YoR2ZUGxxgx2aT/aeA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wVrah-00000005edl-2334;
 Sat, 06 Jun 2026 14:01:35 +0000
Date: Sat, 6 Jun 2026 14:01:35 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alano Song <alanosong@163.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH] target/i386/monitor: Refine `info tlb` command logic
Message-ID: <aiQoP29Y4DVr-CBR@gallifrey>
References: <20260524124129.174254-1-AlanoSong@163.com>
 <2e90e85b-a8cb-4f6c-b7d4-f2f6159b6d55@linaro.org>
 <5f951c07.4fa.19e7679781f.Coremail.alanosong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f951c07.4fa.19e7679781f.Coremail.alanosong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 14:01:03 up 21 days, 17:13,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Alano Song (alanosong@163.com) wrote:
> 
> 
> 
> At 2026-05-28 23:24:56, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
> >Hi,
> >
> >On 24/5/26 14:41, AlanoSong@163.com wrote:
> >> When booting an i386 guest, the `info tlb` command
> >> may walk the entire page table hierarchy and emit
> >> an enormous amount of output (as many as 800+ million
> >> entries under my test).
> >> It will take dozens of minutes to print all the info,
> >> because each monitor print function will holds 'mon_lock'.
> >> This effectively hangs the qemu monitor, and even leading
> >> to program exit due to timeout.
> >> 
> >> So it may be better to show only the first 32 entries
> >> and the last entry by default.
> >> 
> >> And if full output is required, the user can redirect
> >> the output to a file by specifying a file name, e.g.:
> >> `info tlb xxx.txt`.
> >> 
> >> Signed-off-by: Alano Song <AlanoSong@163.com>
> >> ---
> >>   hmp-commands-info.hx  |  10 +-
> >>   target/i386/monitor.c | 230 ++++++++++++++++++++++++++++++++++--------
> >>   2 files changed, 195 insertions(+), 45 deletions(-)
> >> 
> >> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> >> index 82134eb6c2..33b4604d11 100644
> >> --- a/hmp-commands-info.hx
> >> +++ b/hmp-commands-info.hx
> >> @@ -188,17 +188,19 @@ ERST
> >>   
> >>       {
> >>           .name       = "tlb",
> >> -        .args_type  = "",
> >> -        .params     = "",
> >> -        .help       = "show virtual to physical memory mappings",
> >> +        .args_type  = "file:s?",
> >> +        .params     = "[file]",
> >> +        .help       = "show virtual to physical memory mappings (optionally save to file)",
> >>           .cmd        = hmp_info_tlb,
> >>           .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
> >>                           | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
> >>       },
> >>   
> >>   SRST
> >> -  ``info tlb``
> >> +  ``info tlb`` [*file*]
> >>       Show virtual to physical memory mappings.
> >> +    If *file* is specified, the output is saved to the given file
> >> +    instead of being printed to the monitor.
> >>   ERST
> >
> >What about passing count or range by argument instead, keeping the
> 
> >default behavior?
> 
> 
> Hi, Philippe:
> 
> 
> Your suggestion is good,
> I can add several options,
> so that users can control the output range and count.
> 
> 
> And just as I described earlier, we should modify the default behavior:
> only print the first 32 entries and the last entry.
> so that users can know the range while avoiding
> the output of all the entries (there are too many).

A comment in the help warning that they'll get a lot of output would
be good as well.

Dave

> 
> Alano.
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

