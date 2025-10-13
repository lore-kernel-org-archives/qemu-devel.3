Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC35CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8G20-0002at-Ee; Mon, 13 Oct 2025 06:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8G1x-0002aL-4G
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8G1p-0007Na-LF
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760352221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEjlAkXX+32oLJxS7LvsJN/STwER0w1mg9Sg2ZelkBs=;
 b=DOT8qZOlq9pIkZ3uwzjjg1eSkABXTYpV7iQR/l6k1puqIP+p2zRqiX/EDRJQukE/SGAnCQ
 AxGmrke3cvW70tDzQTqB+/kvK6RFpmTrbOED0oY4ijwmd3lzMuL9ekMM5OCcjM0VbHMKC7
 3z/J+CMRqCK6ucfVHaM2ki0onH396Q8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-mYUZjLpqPkyDYqOyX81HgQ-1; Mon,
 13 Oct 2025 06:43:37 -0400
X-MC-Unique: mYUZjLpqPkyDYqOyX81HgQ-1
X-Mimecast-MFC-AGG-ID: mYUZjLpqPkyDYqOyX81HgQ_1760352216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C7E619560A5; Mon, 13 Oct 2025 10:43:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05EB51800452; Mon, 13 Oct 2025 10:43:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80A9D21E6A27; Mon, 13 Oct 2025 12:43:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Laurent Vivier <lvivier@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
In-Reply-To: <3flcrys75wbso64zpfbika46klfbg7khbrtug3avrpfixaxmo5@vuidk7ktxnpi>
 (Gerd Hoffmann's message of "Mon, 13 Oct 2025 11:19:33 +0200")
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org>
 <3flcrys75wbso64zpfbika46klfbg7khbrtug3avrpfixaxmo5@vuidk7ktxnpi>
Date: Mon, 13 Oct 2025 12:43:31 +0200
Message-ID: <87bjmb6q0c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Fri, Oct 10, 2025 at 01:41:35PM +0200, Markus Armbruster wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>> 
>> > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
>> > optional support for logging to a memory buffer.  There is guest side
>> > support -- for example in linux kernels v6.17+ -- to read that buffer.
>> > But that might not helpful if your guest stops booting early enough that
>> > guest tooling can not be used yet.  So host side support to read that
>> > log buffer is a useful thing to have.
>> >
>> > This patch implements both qmp and hmp monitor commands to read the
>> > firmware log.
>> 
>> So this is just for EDK2, at least for now.
>
> Yes.
>
>> > +    char                 FirmwareVersion[128];
>> > +} MEM_DEBUG_LOG_HDR;
>> 
>> I understand this is a (close to) literal copy from EDK2, and adjusting
>> it to QEMU style would be a bad idea.
>> 
>> > +
>> > +
>> > +/* ----------------------------------------------------------------------- */
>> > +/* qemu monitor command                                                    */
>> > +
>> > +typedef struct {
>> > +    uint64_t             Magic1;
>> > +    uint64_t             Magic2;
>> > +} MEM_DEBUG_LOG_MAGIC;
>> 
>> Unusual capitalization for a typedef name.  Why?  To emphasize the
>> relation to MEM_DEBUG_LOG_HDR?
>
> Yes.

Okay.

>> > +    if (header.DebugLogSize > MiB) {
>> > +        /* default size is 128k (32 pages), allow up to 1M */
>> > +        error_setg(errp, "firmware log: log buffer is too big");
>> 
>> [*] We limit the buffer to 1MiB.  No objection to the size.
>> 
>> What do you mean by "default" in "default size"?  Is the size
>> configurable in EDK2?
>
> Yes, there is an option for that.
>
>> Should we try to cope more gracefully with oversized log buffers?  It's
>> a ring buffer.  What about silently reading the latest 1MiB then?
>> Behaves just as if the ring buffer was 1MiB.
>
> See below.
>
>> > +# @log: Firmware debug log, in base64 encoding.
>> 
>> Can this have a partial line at the beginning and/or the end?
>
> Yes.

Partial lines can be troublesome, in particular when complete lines
start with a prefix in a known format.  If avoiding them isn't
practical, we should at least document.

>> > +#
>> > +# Since: 10.2
>> > +##
>> > +{ 'struct': 'FirmwareLog',
>> > +  'data': { '*version': 'str',
>> > +            '*log': 'str' } }
>> 
>> These aren't actually optional with the current code.  See [**] above.
>> I guess you make them optional just in case some other firmware can
>> provide only one of them.
>
> We could also make both mandatory.  There is always the option to return
> an empty string ...

Yes.  Loses the distinction between "firmware doesn't support this" and
"firmware supports this, but it happens to be empty right now".  Do we
care?

>> > +##
>> > +# @query-firmware-log:
>> > +#
>> > +# Find firmware memory log buffer in guest memory, return content.
>> 
>> Should we mention this is implemented only for EDK2 at this time?
>> 
>> Have you considered an optional size argument to retrieve the tail of
>> the log?
>
> I'll have a look.  If we implement the 1MB cap suggested above we would
> get that (almost) for free.
>
> take care,
>   Gerd

Thanks!


