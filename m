Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BBCC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 12:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWyOH-00041F-VK; Mon, 05 Feb 2024 07:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWyO6-0003qX-SC
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWyO4-000077-2p
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707137267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XuT0GZH9MBGxpqmVbb32km5mlpDqDwT0suBot70Gw3s=;
 b=gQC4N/9FWqlXMPou3aYr/67uWhVeczuUjdwqbdWFVp5CepTupAW2XwkTnDhk6p4p2cO7GX
 a7z5YIyEgLhDMRG894AvZSpZuvKVsZcmWAKmCB3ackIEddllT/g8tHdWbw6iA57Wu/OkmZ
 TtyrdOz/bN62Y90oYFF/5wKpmOszGyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-24z_lPLTN-qxnkg9FBFgDQ-1; Mon, 05 Feb 2024 07:47:43 -0500
X-MC-Unique: 24z_lPLTN-qxnkg9FBFgDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BAC3108BDD3;
 Mon,  5 Feb 2024 12:47:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7874B2026F95;
 Mon,  5 Feb 2024 12:47:38 +0000 (UTC)
Date: Mon, 5 Feb 2024 12:47:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Warner Losh <imp@bsdimp.com>,
 Luc Michel <luc@lmichel.fr>, Bernhard Beschow <shentey@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Mark Burton <mburton@qti.qualcomm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jim Shu <jim.shu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: Dynamic & heterogeneous machines, initial configuration: problems
Message-ID: <ZcDY6ARr7VnOtJTn@redhat.com>
References: <87o7d1i7ky.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7d1i7ky.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 31, 2024 at 09:14:21PM +0100, Markus Armbruster wrote:
> == What users want for initial configuration ==
> 
> 1. QMP only
> 
>    Management applications need to use QMP for monitoring anyway.  They
>    may want to use it for initial configuration, too.  Libvirt does.
> 
>    They still need to bootstrap a QMP monitor, and for that, CLI is fine
>    as long as it's simple and stable.
> 
> 2. CLI and configuration files
> 
>    Human users want a CLI and configuration files.
> 
>    CLI is good for quick tweaks, and to explore.
> 
>    For more permanent, non-trivial configuration, configuration files
>    are more suitable, because they are easier to read, edit, and
>    document than long command lines.
> 
> 
> == What we have for initial configuration ==
> 
> Half of 1. and half of 2., satisfying nobody's needs.
> 
> Management applications need to do a lot of non-trivial initial
> configuration with the CLI.
> 
> Human users struggle with inconsistent syntax, insufficiently expressive
> configuration files, and huge command lines.

Our two sets of users (humans & machines) have pretty different
desires in many respects. To suit machines, we've made our config
more and more expressive & detailed. This has worked well for
machines. Humans have largely ignored most of it though, and
stuck with the massively simpler ("legacy") config approaches.

Every now & then though, humans are forced to use the modern low
level config to access some edge case feature not exposed in the
legacy syntax. Pain and suffering ensues.


I feel like we have become somewhat incapable of innovating on
features that are in the interests of humans, because our thought
processes get derailed by a desire to keep thing fully expressive
for machines, and the human areas of code are often the most
crufty with highest risk of breakage.

My wish is that when we switch to a new binary, we exclusively
focus on machines, and build a human focused frontend above
that, so we have clean separation, and we can do whatever we
thing is right for humans without being distracted by whether
machines can consume it or not, and vica-verca.

> = Problem 2: Defining machines =
> 
> This is how I understand the problem.  Please correct me where I'm off.
> 
> 
> == How we'd like to build machines ==
> 
> We want to build machines declaratively, by configuring devices and
> their connections.
> 
> We want to build composite devices the same way.
> 
> The non-composite devices are provided by the QEMU binary.
> 
> Users want to build machines as variations of canned machine types
> shipped with QEMU.  Some users may want to build their own machines from
> scratch.
> 
> To enable all this, machine configuration needs to be composable and
> dynamic.
> 
> Composable means configuration can be assembled from components,
> recursively.
> 
> Dynamic means it can be done during qemu-system-FOO initial
> configuration.
> 
> 
> == What we have for defining machines ==
> 
> A QEMU binary provides a fixed set of device types, some of them
> composite, and a fixed set of machine types.
> 
> Machines are QOM objects: instance of a concrete subtype of "machine".
> 
> Devices are usually QOM objects: instance of a concrete subtype of
> "device".  Exceptions remain in old code nobody can be bothered to
> update.
> 
> Both machine types and composite devices are built from devices
> by code, i.e. imperatively, not declaratively.
> 
> The code can be parameterized.  For QOM objects, parameters should be
> QOM properties, but machine type code additionally uses global old-style
> configuration such as -drive and -serial.
> 
> Code may create default backends for convenience.  Machine type code may
> also create backends to honor global old-style configuration.  Only some
> backends are QOM objects.

The default devices/backends in machines are an artifact of use trying
to do something which suits both humans and machines, while at the same
time hardcoding machine definitions.

Our '-nodefaults' hack is a gross solution to this problem.

An ability to dynamically define machines could give us a far more
attractive solution to this problem.

<handwaving>

eg we could have a  'q35-minimal.cfg'  configuration that defined
the minimal 'q35' machine type, along with a 'q35-recommended.cfg'
that added the typical extra devices, and possibly even a further
'q35-simple.cfg' that added the typical extra devices, alongw ith
typical extra backend connectivity.

Using a 'q35-minimal.cfg' the mgmt app would have to setup all
backends and extra devices explicitly as it saw fit.

Using a 'q35-recommended.cfg' the human would merely have to
provide backend configuration

Using a 'q35-simple.cfg' the human would merely need to provide
a disk image path.
</handwaving>

this would also solve our forever problem of "sensible defaults"
for RAM size, CPU model, etc being an undecidable problem. We
could have 'q35-tiny.cfg' and 'q35-huge.cfg', or any number of
other profile variants. Or we could have 'q35-windows.cfg' and
'q35-linux.cfg'.

We wouldn't have needed to create 'microvm' at all, Kata could
have just defined a suitable config themselves which was optimal
for their needs. 

Essentially once machine types are turned into data, instead of
code we improve life for humans and machines alike, and likely
eliminate entire classes of problems[1].


I wonder if machine types as data might also have a positive
impact on our migration compatibility support. Say we screw up
and break migrate compat between 2 QEMU releases. Fixing it
requires new code releases and builds. Fixing it with just a
data update may well be easier to consume. On the flip side,
however, if mgmt apps are maintaining their own configuration
for defining machines, they might have to take on full
responsibility for adding changes to their config ro preserve
ABI.

With regards,
Daniel

[1] And create ourselves a whole suite of entertaining new problems
    to worry about, which will be a refreshing change from the old
    problems we're all bored of by now :-)
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


