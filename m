Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09440C02187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgCi-0004Te-U2; Tue, 14 Jan 2025 07:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXgCO-0004OR-Ke
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXgCL-0005n4-JK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736858347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcfkq1thCuH886su3jqqmfCMc2hBNW60IIcd/ffExOQ=;
 b=Iz6n3yVHO32lLqlPaRK7sc5XDUJEB84udQDI3Il2gVaf/NU5N9mzGDKAZuB6ixrs4YSMJ5
 nzjIfE+Uj8RUziTtUhBFuj+x5ioXQhUGQvOxj3Jrn2oHDnUTKtH+3LJNr2DfHn+q2VaTU4
 BFfjTC93ByQoBCzmNx0tADW9FZAT9Z8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-yDdIOSBHMmStxWaqflLtSA-1; Tue,
 14 Jan 2025 07:39:04 -0500
X-MC-Unique: yDdIOSBHMmStxWaqflLtSA-1
X-Mimecast-MFC-AGG-ID: yDdIOSBHMmStxWaqflLtSA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D33E19560AB; Tue, 14 Jan 2025 12:39:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9B7819560A3; Tue, 14 Jan 2025 12:39:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4693521E6924; Tue, 14 Jan 2025 13:38:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
In-Reply-To: <20250114111829.2f577596@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Tue, 14 Jan 2025 11:18:29 +0100")
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
Date: Tue, 14 Jan 2025 13:38:59 +0100
Message-ID: <87zfjtfu3g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 13 Jan 2025 17:00:55 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
>
>> On 13/1/25 13:28, Igor Mammedov wrote:
>> > On Sun, 12 Jan 2025 23:16:40 +0100
>> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
>> >=20=20=20
>> >> QDev objects created with object_new() need to manually add
>> >> their parent relationship with object_property_add_child().
>> >>
>> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> >> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> >> Message-Id: <20240216110313.17039-22-philmd@linaro.org>
>> >> ---
>> >>   hw/i386/x86-common.c                     | 1 +
>> >>   hw/microblaze/petalogix_ml605_mmu.c      | 1 +
>> >>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
>> >>   hw/mips/cps.c                            | 1 +
>> >>   hw/ppc/e500.c                            | 1 +
>> >>   hw/ppc/spapr.c                           | 1 +
>> >>   6 files changed, 6 insertions(+)
>> >>
>> >> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>> >> index 97b4f7d4a0d..9c9ffb3484a 100644
>> >> --- a/hw/i386/x86-common.c
>> >> +++ b/hw/i386/x86-common.c
>> >> @@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, int=
64_t apic_id, Error **errp)
>> >>       if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
>> >>           goto out;
>> >>       }
>> >> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));=
=20=20
>> >=20
>> > I might  be missing something but why it needs to be done manually?
>> >=20
>> > device_set_realized() will place any parent-less device under (1) /mac=
hine/unattached=20=20
>>=20
>> This is exactly what we want to avoid, to eventually remove
>> the "/machine/unattached" container for good.
>>=20
>> See "=3D Problem 4: The /machine/unattached/ orphanage =3D" in:
>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>
>
> QOM paths as far as I'm aware were never part ABI nor I'm aware of
> of any proposal to make it or some parts of it a public interface.

We've been waffling on this since forever.  QOM is not a public
interface except when it is, and it is when somebody says so, and it
isn't when somebody says so, resulting in a wave function that wobbles
like an underdone souffle, but never quite collapses.

> IMHO for public ABI, QEMU provides explicit QMP commands while
> QOM should stay a playground for developers.

Plenty of commands take QOM paths as arguments: eject,
blockdev-open-tray, blockdev-close-tray, blockdev-remove-medium,
blockdev-insert-medium, blockdev-change-medium,
block-latency-histogram-set, cxl-inject-general-media-event,
cxl-inject-dram-event, cxl-inject-memory-module-event,
cxl-inject-poison, cxl-inject-uncorrectable-errors,
cxl-inject-correctable-error, device_del, device-sync-config,
query-stats, x-query-virtio-status, x-query-virtio-queue-status,
x-query-virtio-vhost-queue-status, x-query-virtio-queue-element, and
possibly more.

The only way their QOM path arguments can be used without relying on QOM
paths being ABI would be obtaining the argument value with a command or
from an event.  I doubt that would be possible even if we tried it,
which we haven't.

> I this specific case, one basically replaces /machine/unattached
> orphanage with explicit /machine one and many 'cpuN' children,
> which ain't any better than device[N].
>
> and in future I can imagine that at least in x86 case vcpus
> might have another parent depending on configuration.
> (i.e. being parented to cores instead)
>
> If goal is to get rid of /machine/unattached, that's fine.

/machine/unattached was a lazy mistake.

> But please not make brittle naming under /machine/unattached
> as a reason as 'cpu[N]' is the same just in different place
> and scattered all over code (hence doubts if it's any better than current=
 way).

Can you suggest a better, workable naming scheme?

> (ps: don't we have exactly the same for peripheral-anon container)

Yes, but users can avoid that by passing an @id argument.

[...]


