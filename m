Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E65606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=etik.com header.i=@etik.com header.a=rsa-sha256 header.s=20210927 header.b=cQxdshKV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT0Vg-0008D2-8W; Mon, 16 Nov 2026 12:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dv@etik.com>) id 1xT0Vc-0008Cc-4X
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:28:48 -0500
Received: from smtp-8fa8.mail.infomaniak.ch ([2001:1600:19:e38::8fa8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dv@etik.com>) id 1xT0VZ-0004ii-AG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:28:47 -0500
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvwR05KVz2kNw;
 Mon, 16 Nov 2026 18:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
 s=20210927; t=1794850118;
 bh=sksj3erO0Akx5zzJjGKDAnrGDqLQmFXWSoMgfv5FcBI=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=cQxdshKVjvsM39W9Gap2BRzIbXEaf1d/No2nWFKAUSwvNOUV8gHSyKC6R2d1cBd0C
 MYDXtX311AflSc+xrxIyZzAIJKlRBSmJPWHwajQQAvOoDVjRXhbkkUF8hQv1ogIlAi
 gGhu6QsEblH34EbgOm93qm2GRqDN3dpaW0DQdFEE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSvwN6vjBzcsX; Mon, 16 Nov 2026 18:28:36 +0100 (CET)
Message-ID: <999079c0-c728-445b-a122-720d93f112cc@etik.com>
Date: Mon, 16 Nov 2026 18:28:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: DV <dv@etik.com>
Subject: Re: [PATCH] kvm: hyper-v: Delay firing of expired stimers
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Sean Christopherson
 <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 hpa@zytor.com, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 nh-open-source@amazon.com, gurugubs@amazon.com, jalliste@amazon.co.uk,
 Michael Kelley <mhklinux@outlook.com>, John Starks <jostarks@microsoft.com>,
 David Woodhouse <dwmw2@infradead.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20260115141520.24176-1-graf@amazon.com>
 <aXO8I6xuZyZB7CxV@google.com>
 <769f538d-dd42-4d36-a4c5-7e6e48b209f6@amazon.com> <87bjigaeyx.fsf@redhat.com>
 <1435d106-d4b0-487e-85d3-4032a9fe9332@etik.com>
 <kupzev8hf8s.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Content-Language: en-US
In-Reply-To: <kupzev8hf8s.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: :74c292bbbde641d:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:19:e38::8fa8; envelope-from=dv@etik.com;
 helo=smtp-8fa8.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026, Vitaly Kuznetsov wrote:
> From what I remember, direct mode synthetic timers were added
> specifically to aid Hyper-V-on-KVM case as non-nested Windows was
> preferring non-direct version anyway. So I believe we need a fix and
> not 3).

Thanks, that rules out 3).

> I'm wondering if the issue is somewhat related to the nasty hack we
> put in commit 0469f2f7ab4c ("KVM: x86: hyper-v: Don't touch TSC page
> values when guest opted for re-enlightenment") but maybe hibernation
> is somewhat different. Or maybe we misunderstood the problem in the
> first place and only fixed one sympthom of it?

I don't think the hack itself is involved here, but your second guess
fits what I see.

The hack only takes effect once the guest has written
HV_X64_MSR_TSC_EMULATION_CONTROL. In the failing setup
hv-reenlightenment isn't exposed, so KVM recomputes the TSC page on
every masterclock update and every KVM_SET_CLOCK as usual. With
hv-reenlightenment on, X was 494.7 ms and the timers were just as
late. I didn't trace whether L1 wrote the MSR in that run, but it
wouldn't change the lag at boot: L1 enabling the page sets
HV_TSC_PAGE_GUEST_CHANGED, so the first setup is computed normally
either way.

What points to your second guess: X is already in kvmclock before the
guest runs its first instruction, so when L1 enables the TSC page,
KVM writes a tsc_offset of about -X into it. Yet on a boot with no
pause and no migration, L1's counts were still X too far out. If L1
used the values it read from the TSC page, even cached ones, it would
have been right at that point. So L1 seems to take L0's reference
time to be guest TSC / TSC frequency with no offset at all, perhaps
because on a Hyper-V host the two start together.

If so, the 2021 migration storm and this are the same assumption
broken in two ways. The hack keeps tsc_offset from changing after L1
has started, which helps on migration, but it can't help when
tsc_offset isn't zero to begin with. And without re-enlightenment,
nothing keeps it from changing on pause/resume, which matches the
virsh suspend result in my first mail.

If it helps, I can rerun with hv-reenlightenment on, trace whether L1
writes HV_X64_MSR_TSC_EMULATION_CONTROL, and repeat the suspend. If
the hack engages, I'd expect X to stay the same across the pause,
while the timers stay X late from boot.

As before, Claude Code did the code reading for this.

Thanks,
David

