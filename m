Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F29C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Vot-0004Ti-Ri; Thu, 02 May 2024 08:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2Vor-0004T2-FW
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:45:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2Vop-0006LF-BF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:45:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2441122C14;
 Thu,  2 May 2024 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714653943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lfPy3UgMGJmLNXbfawJ8gGTzIcwZ/EErPqISE/ilpQ=;
 b=XLMVRP3ulDWICoE3g2tNHKBwk4iEDBbwittI60UOsZCXgqO+6oOWiuDDmmmT3nB6Jnd0Ec
 ZakPWNA92zgKjadZ2pitIW/S7nRbehL6cFVjQ8h6vD2ifPSzlfk+fQOj7P74Fpv4R/s+Vi
 9Q1rUsf8f/VOeAICgEz9cSzAGVCc9F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714653943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lfPy3UgMGJmLNXbfawJ8gGTzIcwZ/EErPqISE/ilpQ=;
 b=u4O6N7sV31teBcF3Hfsj1Tw7gcVsiQXQJeN58kqG5bOkv5UvpsY979QUmKIyKUpcB+v3oN
 6KjvdXVp1b3cC7Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XLMVRP3u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u4O6N7sV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714653943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lfPy3UgMGJmLNXbfawJ8gGTzIcwZ/EErPqISE/ilpQ=;
 b=XLMVRP3ulDWICoE3g2tNHKBwk4iEDBbwittI60UOsZCXgqO+6oOWiuDDmmmT3nB6Jnd0Ec
 ZakPWNA92zgKjadZ2pitIW/S7nRbehL6cFVjQ8h6vD2ifPSzlfk+fQOj7P74Fpv4R/s+Vi
 9Q1rUsf8f/VOeAICgEz9cSzAGVCc9F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714653943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lfPy3UgMGJmLNXbfawJ8gGTzIcwZ/EErPqISE/ilpQ=;
 b=u4O6N7sV31teBcF3Hfsj1Tw7gcVsiQXQJeN58kqG5bOkv5UvpsY979QUmKIyKUpcB+v3oN
 6KjvdXVp1b3cC7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A47931386E;
 Thu,  2 May 2024 12:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6q7cGvaKM2Z2QAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 12:45:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Song Gao
 <gaosong@loongson.cn>, qemu-devel@nongnu.org, Tianrui Zhao
 <zhaotianrui@loongson.cn>, pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maobibo@loongson.cn, lixianglai@loongso.cn
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
In-Reply-To: <ZjJjl2fIU1s24uFD@x1n>
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org> <87edanlzlz.fsf@suse.de>
 <ZjJjl2fIU1s24uFD@x1n>
Date: Thu, 02 May 2024 09:45:40 -0300
Message-ID: <87o79oo00b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2441122C14
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Apr 30, 2024 at 11:00:24AM -0300, Fabiano Rosas wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>> > (Cc'ing migration maintainers)
>> >
>> > On 30/4/24 03:23, Song Gao wrote:
>> >> vmstate does not save kvm_state_conter,
>> >> which can cause VM recovery from disk to fail.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Fixes: d11681c94f ("target/loongarch: Implement kvm_arch_init_vcpu")
>> >
>> >> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> >> ---
>> >>   target/loongarch/machine.c | 2 ++
>> >>   1 file changed, 2 insertions(+)
>> >>=20
>> >> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> >> index c7029fb9b4..4cd1bf06ff 100644
>> >> --- a/target/loongarch/machine.c
>> >> +++ b/target/loongarch/machine.c
>> >> @@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu =
=3D {
>> >>           VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_M=
AX,
>> >>                                0, vmstate_tlb, LoongArchTLB),
>> >>=20=20=20
>> >> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>> >> +
>> >>           VMSTATE_END_OF_LIST()
>> >>       },
>> >>       .subsections =3D (const VMStateDescription * const []) {
>> >
>> > The migration stream is versioned, so you should increase it,
>> > but this field is only relevant for KVM (it shouldn't be there
>> > in non-KVM builds). IMHO the correct migration way to fix that
>> > is (untested):
>> >
>> > -- >8 --
>> > diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> > index c7029fb9b4..08032c6d71 100644
>> > --- a/target/loongarch/machine.c
>> > +++ b/target/loongarch/machine.c
>> > @@ -8,8 +8,27 @@
>> >   #include "qemu/osdep.h"
>> >   #include "cpu.h"
>> >   #include "migration/cpu.h"
>> > +#include "sysemu/kvm.h"
>> >   #include "vec.h"
>> >
>> > +#ifdef CONFIG_KVM
>> > +static bool kvmcpu_needed(void *opaque)
>> > +{
>> > +    return kvm_enabled();
>> > +}
>> > +
>> > +static const VMStateDescription vmstate_kvmtimer =3D {
>> > +    .name =3D "cpu/kvmtimer",
>> > +    .version_id =3D 1,
>> > +    .minimum_version_id =3D 1,
>> > +    .needed =3D kvmcpu_needed,
>> > +    .fields =3D (const VMStateField[]) {
>> > +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>> > +        VMSTATE_END_OF_LIST()
>> > +    }
>> > +};
>> > +#endif /* CONFIG_KVM */
>> > +
>> >   static const VMStateDescription vmstate_fpu_reg =3D {
>> >       .name =3D "fpu_reg",
>> >       .version_id =3D 1,
>> > @@ -194,6 +213,9 @@ const VMStateDescription vmstate_loongarch_cpu =3D=
 {
>> >           VMSTATE_END_OF_LIST()
>> >       },
>> >       .subsections =3D (const VMStateDescription * const []) {
>> > +#ifdef CONFIG_KVM
>> > +        &vmstate_kvmcpu,
>> > +#endif
>> >           &vmstate_fpu,
>> >           &vmstate_lsx,
>> >           &vmstate_lasx,
>> > ---
>>=20
>> LGTM, I'd just leave only the .needed function under CONFIG_KVM instead
>> of the whole subsection.
>
> But when !KVM it means there's no ".needed" and it'll still be migrated?

I expressed myself poorly, I meant put the return from .needed under
CONFIG_KVM. But that is not even necessary, kvm_enabled() is enough.

>
> IMHO it depends on whether loongarch is in the state already of trying to
> keep its ABI at all.  I think we should still try to enjoy the time when
> that ABI is not required, then we can simply add whatever fields, and let
> things break with no big deal.
>
> Note that if with CONFIG_KVM it means it can break migration between kvm
> v.s. tcg when only one qemu enabled kvm when compile.  Considering the
> patch is from the maintainer (which seems to say "breaking that is all
> fine!") I'd say the original patch looks good actually, as it allows kvm /
> tcg migrations too as a baseline.

I'm fine with this approach as well.

>
> Thanks,

