Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD2AF54AC7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52xs-0003eZ-RI; Tue, 24 Mar 2026 10:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w52xp-0003dm-MD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w52xn-0007wR-VI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774363355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f30onhXfsY7EpO+xSODa+UxRUOOoUXWAFzoPHtSsJPA=;
 b=cnn2jeb9KSax6hxOYKBZVS2DMP1MlX/q342npW47eBYoFV8yJmW7/38DhmibcifE8bT6hw
 2h4MZ0Przc5CdNs8+YLnvX/A4WoYyBZaAGqtXC8hSfujqPSqrDkFaq5LoQzoO9WVdhI8pk
 kdnjMERguykzPagAIQOETtANoiKz8Rg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-D29Jc0kBNzyotYKYXfLN0A-1; Tue,
 24 Mar 2026 10:42:29 -0400
X-MC-Unique: D29Jc0kBNzyotYKYXfLN0A-1
X-Mimecast-MFC-AGG-ID: D29Jc0kBNzyotYKYXfLN0A_1774363347
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61EE219560A1; Tue, 24 Mar 2026 14:42:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D20F1955D71; Tue, 24 Mar 2026 14:42:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4630621E6937; Tue, 24 Mar 2026 15:42:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
In-Reply-To: <CAFEAcA_y5amOwF-HCM8L3xc1_bSbXxno+HjrLBiOaN25fCt4eA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 24 Mar 2026 13:24:54 +0000")
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-4-philmd@linaro.org>
 <87pl4ts7vx.fsf@pond.sub.org>
 <CAFEAcA_y5amOwF-HCM8L3xc1_bSbXxno+HjrLBiOaN25fCt4eA@mail.gmail.com>
Date: Tue, 24 Mar 2026 15:42:24 +0100
Message-ID: <87tsu5qofj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 24 Mar 2026 at 12:57, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>
>> > Simplify MonitorDef::get_value() handler by having it always
>> > return a int64_t type. Truncate to 32-bit in the single caller.
>> >
>> > Note, this handler is only implemented once for the x86 targets.
>
>> > @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, con=
st char *name)
>> >      for(; md->name !=3D NULL; md++) {
>> >          if (hmp_compare_cmd(name, md->name)) {
>> >              if (md->get_value) {
>> > -                *pval =3D md->get_value(mon, md, md->offset);
>> > +                int64_t val =3D md->get_value(mon, md, md->offset);
>> > +                *pval =3D target_long_bits() =3D=3D 32 ? (int32_t)val=
 : val;
>>
>> This assumes target_long_bits() returns either 32 or 64, doesn't it?
>>
>> Is this true today?
>
> It's certainly true today, and we insist on that: exec/target_long.h
> handles TARGET_LONG_SIZE being 4 or 8 and will #error on anything else.

Good.

> What other values do you expect it could have ?

There might be a need for 128 in the future.  Not an easy change to
make.

>> Will it remain true?
>>
>> Could we use something like
>>
>>     val & ((1 << target_long_bits()) - 1)
>>
>> to truncate to target_long_bits() bits?
>
> This is UB for the case where target_long_bits returns 64,
> and isn't what the code currently does because it zero
> extends rather than sign extending.

I signalled my cavalier neglect for these details by writing "something
like" ;)

> If we wanted to programmatically sign extend from
> target_long_bits() to the int64_t, that would be
>
>  *pval =3D sextract64(val, 0, target_long_bits());
>
> (Whether sign extension is what we actually want for your
> average register is questionable, but it's what the code
> does now both for the get_value functions and also for the
> generic cases handled by the switch on md->type.)
>
> Incidentally, we currently behave differently here for
> qemu-system-i386 and qemu-system-x86_64:
>
> $ ./build/all/qemu-system-x86_64 -S -monitor stdio -display none
> QEMU 10.2.50 monitor - type 'help' for more information
> (qemu) print $pc
> 0xfffffff0
> (qemu) q
> $ ./build/all/qemu-system-i386 -S -monitor stdio -display none
> QEMU 10.2.50 monitor - type 'help' for more information
> (qemu) print $pc
> 0xfffffffffffffff0
>
> For qemu-system-x86_64 we have a 64-bit target_long, so
> the unsigned addition of env->eip and env->segs[R_CS].base
> in monitor_get_pc() is done at 64 bits, and that width is
> then carried through get_monitor_def() and to the caller.
> For qemu-system-i386 we have a 32-bit target_long, so
> we do an unsigned 32-bit addition in monitor_get_pc(),
> return a signed 32-bit result, and then sign extend that
> to 64 bits in get_monitor_def().

I'm carefully retracing my steps out of this swamp.

Thanks!


