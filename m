Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC43FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 06:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUK4v-0003AD-6X; Wed, 25 Jun 2025 02:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUK4p-00039n-H4
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUK4i-0003EZ-QB
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750834656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rh9IvgYkWEJtFDjQpIsBtBQDxdl9LyKiDC0OFZ1llos=;
 b=i6BU0XvKjIqQC9muItq32CEMkNW7lmjfa9+N5+FLYn14RUb/o24aLHHcxFOC9Cs8wzz6+F
 Q4bwa+M5BxNTcV39w8O3iSULKdOfpsw8RSQDCwMrfzlcspSQuM/wrz6afYioCN8wHSxUET
 tZCFYi/Kqdyg0g5LG+Ruc+AHsmLJzC0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-gQgq5HdjNhKTUx8GmD4HsQ-1; Wed,
 25 Jun 2025 02:57:32 -0400
X-MC-Unique: gQgq5HdjNhKTUx8GmD4HsQ-1
X-Mimecast-MFC-AGG-ID: gQgq5HdjNhKTUx8GmD4HsQ_1750834651
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E90919560B0; Wed, 25 Jun 2025 06:57:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1091956096; Wed, 25 Jun 2025 06:57:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A61F121E6A27; Wed, 25 Jun 2025 08:57:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Jason Wang <jasowang@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
In-Reply-To: <3bb6ca25-c691-4a9a-9de3-9db7444c8904@redhat.com> (Laurent
 Vivier's message of "Tue, 24 Jun 2025 14:47:05 +0200")
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <87pletlflp.fsf@pond.sub.org>
 <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
 <87pleticbb.fsf@pond.sub.org> <aFqUENpgRvcYru6L@redhat.com>
 <3bb6ca25-c691-4a9a-9de3-9db7444c8904@redhat.com>
Date: Wed, 25 Jun 2025 08:57:27 +0200
Message-ID: <877c10cnqg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Laurent Vivier <lvivier@redhat.com> writes:

> On 24/06/2025 14:03, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jun 24, 2025 at 01:55:20PM +0200, Markus Armbruster wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>
>>>> On 24/06/2025 10:16, Markus Armbruster wrote:
>>>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>>>
>>>>>> This commit introduces support for passt as a new network backend.
>>>>>> passt is an unprivileged, user-mode networking solution that provides
>>>>>> connectivity for virtual machines by launching an external helper pr=
ocess.
>>>>>>
>>>>>> The implementation reuses the generic stream data handling logic. It
>>>>>> launches the passt binary using GSubprocess, passing it a file
>>>>>> descriptor from a socketpair() for communication. QEMU connects to
>>>>>> the other end of the socket pair to establish the network data strea=
m.
>>>>>>
>>>>>> The PID of the passt daemon is tracked via a temporary file to
>>>>>> ensure it is terminated when QEMU exits.
>>>>>>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>>>> index 97ea1839813b..76d7654414f7 100644
>>>>>> --- a/qapi/net.json
>>>>>> +++ b/qapi/net.json
>>>>>> @@ -112,6 +112,125 @@
>>>>>>      'data': {
>>>>>>        'str': 'str' } }
>>>>>>    +##
>>>>>> +# @NetDevPasstOptions:
>>>>>> +#
>>>>>> +# Unprivileged user-mode network connectivity using passt
>>>>>> +#
>>>>>> +# @path: path to passt binary
>>>>>
>>>>> I'd prefer a more descriptive name.
>>>>>
>>>>> Elsewhere in this file, we refer to programs like this:
>>>>>
>>>>>      # @script: script to initialize the interface
>>>>>      #
>>>>>      # @downscript: script to shut down the interface
>>>>>
>>>>> passt isn't a script, of course.
>>>>>
>>>>> I don't know, perhaps
>>>>>
>>>>>      # @passt-filename: the passt program to run.
>>>>>
>>>>> or even
>>>>>
>>>>>      # @passt: Filename of the passt program to run.
>>>>>
>>>>>> +#
>>>>>> +# @quiet: don't print informational messages
>>>>>
>>>>> What does the printing?  A peek at the code I snipped suggests this f=
lag
>>>>> is passed to the passt binary as --quiet.  Correct?
>>>>>
>>>>>> +#
>>>>>> +# @debug: be verbose
>>>>>> +#
>>>>>> +# @trace: extra verbose
>>>>>
>>>>> Likewise for these two.
>>>>>
>>>>>> +#
>>>>>> +# @vhost-user: enable vhost-user
>>>
>>> [...]
>>>
>>>>>> +# @udp-ports: UDP ports to forward
>>>>>
>>>>> Is there anything in this struct that configures qemu-system-FOO itse=
lf,
>>>>> i.e. isn't just passed to passt?
>>>>>
>>>>
>>>> Yes, all parameters are just passed to passt.
>>>>
>>>> Do you think it's better not to add all these parameters to netdev bac=
kend but only one
>>>> generic containing the passt command line parameters?
>>>
>>> I'm not sure.
>>>
>>> Thoughts from libvirt's perspective?
>>
>> We already have passt support in libvirt that leverages the existing
>> vhost-user netdev backend to connect up QEMU.
>>
>> I see this backend requires QEMU to be able to spawn the passt binary
>> itselfm, which is not something libvirt would allow via our security
>> confinement of QEMU. So that would rule out our ability to consume
>> this netdev backend, as currently written
>>
>> Is there anything QEMU can do with this passt netdev, that can't be
>> done via the vhost-user backend ? ie is this merely syntax sugar to
>> make it easier for humans launching QEMU, or is there some feature
>> / performance benefit ?
>
> The idea is only to allow user to run directly QEMU with passt in the sam=
e way it's done with the netdev user. There is no other benefit than the ea=
sier interface for humans.
>
> For instance, we want to run '-nic passt' as we can run '-nic user'.

Good to know!  Put it into the commit message, please.

Hmm, it's good to know for management application developers, too.  So
we should also put it into documentation, I guess.  Where?  Looking...
Oh, there's a section "Using passt as the user mode network stack"in
docs/system/devices/net.rst.  That section clearly needs an update for
the new backend.


Back to the design question how to pass configuration via qemu-system to
the passt program with this new backend.

Your patch replicates passt command line options as optional members of
QAPI type NetDevPasstOptions.  Any passt options not covered are
inaccessible.

Or rather inaccessible via QMP / HMP / CLI.  You can still access them
by pointing @passt to a wrapper script.

This leads us to a possible alternative: make such a wrapper script the
*only* way to configure passt.  This is like NetdevTapOptions @script
and @downscript.  Mind, I'm not telling you it's a good idea, I'm merely
trying to map the solution space!

Instead of trying to make NetDevPasstOptions complete (so you need to
fall back to a wrapper script only when using a version of passt with
different options), we can limit it to a curated set of options.  We'd
need to decide which ones :)

You pointed out yet another alternative: pass through the passt command
line directly.  Two obvious ways: a single shell command string to be
passed to system(3), or an array of strings to be passed to execv(3).

system(3) is a terrible idea with untrusted input, but this is trusted
input.

Any other interface ideas?

Since the backend is for human user convenience: which of these ways
would be convenient for human users?


