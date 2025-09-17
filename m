Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B890ACA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 08:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uynUR-000389-5g; Wed, 17 Sep 2025 04:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uynUP-000344-8x
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 04:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uynUI-0005BF-SU
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 04:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758097560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fpZO5nXH3nbubX6fPCpJwRlkdJoG+Bmuf7/h0l52DTM=;
 b=TzLcTWDGIUQFhFGvbDGxRvjFO0xHjmuWi2XPmRLT5GhrrKGYTrYzG03UsE4y8SOwpenZrD
 O7bgsb+/W6nraJGPa2Gskl+lpk/Sde0SCVqEywXqTHEXL3lhTd45oINTj93iAFsNDxc3LE
 vt4lDbllWGZeP9K0rfhU1VKpYmU1rMY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-0ZcGT8IFNMqjezdAVkWdnA-1; Wed,
 17 Sep 2025 04:25:57 -0400
X-MC-Unique: 0ZcGT8IFNMqjezdAVkWdnA-1
X-Mimecast-MFC-AGG-ID: 0ZcGT8IFNMqjezdAVkWdnA_1758097556
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52D0C1800359; Wed, 17 Sep 2025 08:25:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 056BF1800446; Wed, 17 Sep 2025 08:25:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59D9821E6A27; Wed, 17 Sep 2025 10:25:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit Shah
 <amit@kernel.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Szymon Lukasz
 <noh4hss@gmail.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v4 07/10] qmp: add chardev-resize command
In-Reply-To: <53a9b16a229930a3caa80af9541f16b4a8b6094c.camel@gmail.com> (Filip
 Hejsek's message of "Tue, 16 Sep 2025 19:01:49 +0200")
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
 <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
 <87cy7s1auw.fsf@pond.sub.org>
 <ffa90309f0ce8c81836e5e7074d67ae76033b67f.camel@gmail.com>
 <87bjnao8ae.fsf@pond.sub.org>
 <53a9b16a229930a3caa80af9541f16b4a8b6094c.camel@gmail.com>
Date: Wed, 17 Sep 2025 10:25:51 +0200
Message-ID: <87tt11iiy8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Filip Hejsek <filip.hejsek@gmail.com> writes:

> On Tue, 2025-09-16 at 15:07 +0200, Markus Armbruster wrote:
>> Filip Hejsek <filip.hejsek@gmail.com> writes:
>> 
>> > On Mon, 2025-09-15 at 08:35 +0200, Markus Armbruster wrote:
>> > > Filip Hejsek <filip.hejsek@gmail.com> writes:
>> > > 
>> > > > On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
>> > > > > Cc: libvirt
>> > > > > 
>> > > > > Filip Hejsek <filip.hejsek@gmail.com> writes:
>> > > > > 
>> > > > > > From: Szymon Lukasz <noh4hss@gmail.com>
>> > > > > > 
>> > > > > > [...]
>> > > > > >  
>> > > > > > +##
>> > > > > > +# @chardev-resize:
>> > > > > 
>> > > > > This name doesn't tell me what is being resized.  PATCH 04 uses
>> > > > > "winsize", which is better.  The (losely) related SIGWINCH suggests
>> > > > > "window change" or "window size change".  Below, you use "terminal
>> > > > > size".
>> > > > 
>> > > > How about chardev-console-resize? That would match the name of the
>> > > > virtio event (VIRTIO_CONSOLE_RESIZE).
>> > > 
>> > > Not bad.  It could become slightly bad if we make devices other than
>> > > "consoles" make us of it.  Would that be possible?
>> > 
>> > I don't think the size has any meaning for devices that are not
>> > connected to a console, although the code does not care whether it
>> > actually is a console and simply has a size for every chardev.
>> 
>> Double-checking: the command works for any ChardevBackendKind, doesn't
>> it?
>
> Yes. For some (e.g. stdio) it will clash with builtin resize detection,
> but it can still be used (last update wins).
>
> Maybe using the command should be prohibited for some device types?

Depends on the command's intended use.

In general, failing a command is better than silently not doing what it
commands.  If the command is "tell the guest the window size changed",
and we can't, then failing the command is better than silently doing
nothing.

Howver, other considerations can trump this.  If we want to use this
command on any window size change without having to know the device
type, having it silently do nothing for device types that don't support
it can be more convenient.  Fine as long as the behavior is clearly
documented.

>> > I guess I could also rename it to chardev-window-resize
>> > or chardev-set-window-size. Let me know if you prefer one of these.
>> 
>> I think I'd prefer "window" or "terminal".
>> 
>> "resize" and "set size" suggest that the command initiates a size
>> change.  Not true, it notifies of a size change.  Maybe
>> "chardev-window-size-changed", "chardev-terminal-size-changed",
>> "chardev-window-resized", or "chardev-terminal-resized".
>
> OK, then I'll use "chardev-window-size-changed".
>
>> > > > > 
>> > > > 
>> [...]
>> Another question...  'vc' chardevs accept optional @rows, @cols (see
>> ChardevVC).  Is this the same size or something else?
>
> Well, yes and no. @cols + @rows control the actual size of the console
> screen buffer, while the chardev size is only used to inform the guest
> about the size. @cols and @rows can also be unset, in which case the
> size will be determined automatically from display and font size.

Thanks!

> This patch series does not yet implement size propagation for the 'vc'
> device. I have WIP patches for that, but there is something I'm not
> sure how to do, so I will likely send an RFC first.

Would it make sense to mention this gap in a commit message?

>> > > A clearly invalid size.  I guess it effectively means "unknown size".
>> > > Should we document that?
>> > 
>> > Probably. 0x0 is I think also the default size in the Linux kernel, but
>> > I don't think the Linux kernel documents this.
>> 
>> How does 0 x 0 behave compared to a valid size like 80 x 24?
>
> In these patches it is not treated specially (apart from being the
> default). I think the Linux kernel doesn't treat it specially either.
> Terminal programs generally interpret it as unknown size and use other
> methods to obtain the size like environment variables, the terminfo
> database, or defaulting to 80x24. Example:
>
>    $ python -c 'import termios; termios.tcsetwinsize(0, (0,0))'
>    $ tput cols
>    80

Do you think working this into the documentation would be useful?

>> [...]
>> > > > > Do we need a way to query the size?
>> > > > 
>> > > > I don't think it is necessary. What would be the usecase for that?
>> > > 
>> > > I don't know, but it's my standard question when I see an interface to
>> > > set something without an interface to get it.  Its purpose is to make us
>> > > think, not to make us at the get blindly.
>> > 
>> > I guess it might be useful for debugging. If the size is not propagated
>> > correctly, one might query it to find out on which side the problem is.
>> 
>> We have query-chardev.  It doesn't return much.
>
> I'm not sure what you're implying. Shall I add the size there?

If we could already query chardev configuration / state comprehensively,
then I'd ask you to make it cover your new state bits, too.

Since we don't, and there is no clear use case at this time, I'm not
asking you to do that.


