Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBBCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENZY-0005u1-8H; Wed, 07 Oct 2026 05:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xELFJ-0001ii-MN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xELF8-00040b-HJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791354909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHUyYD8RCNBcxJ8FLjXwk9hPn4j8kbFPw5KD/lr557U=;
 b=RrYSLxXoXCrPONmA9yjDftRQRvXTCoyYF2092yjtLnU1NUcXlp2sSRVUogd827TQIMOSRr
 3ks0WoDyJ5Hn54zdIsHN4ROj7z2cvL1HfOT6klY1Ik2OIg0D9vfS+zRsKSRY0nH5ZzuV9m
 B7RRUTRLxr9xuNVjb/9bqo4vXv83Hk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-b-8jgJECMGe4P6NWSHSmFQ-1; Tue,
 06 Oct 2026 09:56:51 -0400
X-MC-Unique: b-8jgJECMGe4P6NWSHSmFQ-1
X-Mimecast-MFC-AGG-ID: b-8jgJECMGe4P6NWSHSmFQ_1791295008
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E894119541B1; Tue,  6 Oct 2026 13:56:47 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715D1180057F; Tue,  6 Oct 2026 13:56:45 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:56:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
Message-ID: <asT-GoQ6xH4-dLET@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:
> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> >>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>> Ok, but I'm not sure it answers the why.
> >>>>>> Could you explain the benefits?
> >>>>>
> >>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
> >>>>> The following original code would return -1 for some user-binary
> >>>>> +    SysEmuTarget arch = target_info()->target_arch;
> >>>>> +
> >>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
> >>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
> >>>>> +                               &error_abort);
> >>>>> +    }
> >>>>> +    return arch;
> >>>>> So basically assigning any value for the user binary is valid.
> >>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
> >>>>> -1 is another option but easy to confuse.
> >>>>>
> >>>>>
> >>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>>>> "target-info: Statically initialize target_arch"
> >>>>> doing that, I am not sure.
> >>>>>
> >>>>
> >>>> I guess there is a (good or bad) reason for which sub variants of
> >>>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
> >>>> that before doing any change, as it might have other consequences.
> >>>
> >>>
> >>> You’re right to ask, and I need to correct my earlier suggestion:
> >>> leaving user-mode target_arch
> >>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
> >>> code shared with user-mode builds,
> >>> including cpu-max-v8.c, where its result indexes a two-entry array.
> >>> For aarch64-linux-user, the sentinel could therefore cause an
> >>> out-of-bounds access during type registration.
> >>>
> >>> I checked the distinction: softmmu needs the full system-target
> >>> identity, including variants such as mipsel;
> >>> user-mode variants such as aarch64_be use their base TARGET_ARCH
> >>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
> >>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> >>> than leave the field at SYS_EMU_TARGET__MAX.
> >>>
> >>
> >> That's technical details, but not an answer to the initial question of
> >> why we need to change anything for user binaries, compared to what exists.
> > 
> > The first two patches revert the current static initialization so the
> > token can be replaced. They are not a user-mode behavior change.
> > 
> > Compared with current QEMU, user-mode still uses TARGET_ARCH.
> > qemu-mipsel already reports mips, and it still will. Names such as
> > aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> > full target name for this field; keeping TARGET_ARCH preserves today's
> > value and avoids the runtime parse.
> >
> 
> Why should we need to expose this precise information?
> So far, if those targets were not exposed (and aliased to 32/64 bit
> variant), it's probably we didn't need it.

Current git master is exhibiting a regression compared to previous
releases.

For example on 10.1.0:

$ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
/usr/bin/qemu-system-aarch64: "aarch64"
/usr/bin/qemu-system-alpha: "alpha"
/usr/bin/qemu-system-arm: "arm"
/usr/bin/qemu-system-avr: "avr"
/usr/bin/qemu-system-hppa: "hppa"
/usr/bin/qemu-system-i386: "i386"
/usr/bin/qemu-system-loongarch64: "loongarch64"
/usr/bin/qemu-system-m68k: "m68k"
/usr/bin/qemu-system-microblaze: "microblaze"
/usr/bin/qemu-system-microblazeel: "microblazeel"
/usr/bin/qemu-system-mips: "mips"
/usr/bin/qemu-system-mips64: "mips64"
/usr/bin/qemu-system-mips64el: "mips64el"
/usr/bin/qemu-system-mipsel: "mipsel"
/usr/bin/qemu-system-or1k: "or1k"
/usr/bin/qemu-system-ppc: "ppc"
/usr/bin/qemu-system-ppc64: "ppc64"
/usr/bin/qemu-system-riscv32: "riscv32"
/usr/bin/qemu-system-riscv64: "riscv64"
/usr/bin/qemu-system-rx: "rx"
/usr/bin/qemu-system-s390x: "s390x"
/usr/bin/qemu-system-sh4: "sh4"
/usr/bin/qemu-system-sh4eb: "sh4eb"
/usr/bin/qemu-system-sparc: "sparc"
/usr/bin/qemu-system-sparc64: "sparc64"
/usr/bin/qemu-system-tricore: "tricore"
/usr/bin/qemu-system-x86_64: "x86_64"
/usr/bin/qemu-system-xtensa: "xtensa"
/usr/bin/qemu-system-xtensaeb: "xtensaeb"


but on git master:

$ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
./build/qemu-system-hexagon: "hexagon"
./build/qemu-system-x86_64: "x86_64"
./build/qemu-system-s390x: "s390x"
./build/qemu-system-m68k: "m68k"
./build/qemu-system-xtensa: "xtensa"
./build/qemu-system-xtensaeb: "xtensa"
./build/qemu-system-rx: "rx"
./build/qemu-system-loongarch64: "loongarch64"
./build/qemu-system-riscv32: "riscv32"
./build/qemu-system-hppa: "hppa"
./build/qemu-system-ppc64: "ppc64"
./build/qemu-system-microblaze: "microblaze"
./build/qemu-system-sparc: "sparc"
./build/qemu-system-riscv64: "riscv64"
./build/qemu-system-i386: "i386"
./build/qemu-system-mipsel: "mips"
./build/qemu-system-sh4: "sh4"
./build/qemu-system-mips64el: "mips64"
./build/qemu-system-mips64: "mips64"
./build/qemu-system-sparc64: "sparc64"
./build/qemu-system-arm: "arm"
./build/qemu-system-tricore: "tricore"
./build/qemu-system-mips: "mips"
./build/qemu-system-or1k: "or1k"
./build/qemu-system-sh4eb: "sh4"
./build/qemu-system-aarch64: "aarch64"
./build/qemu-system-ppc: "ppc"
./build/qemu-system-avr: "avr"
./build/qemu-system-alpha: "alpha"


so we need to fix that behaviour change for query-target.

If we want to be able to expose only the "base" target,
then query-target's  QemuTargetInfo struct could be
extended with a 2nd field that presents the base.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


