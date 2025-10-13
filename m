Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79831CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Eif-0000mb-LD; Mon, 13 Oct 2025 05:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8Eie-0000mF-2h
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8Eia-0003wT-LD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760347184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3H27P22J6xNfc/DKcK+Oi8DzllDH0pw3IsgrWZ/Ir3U=;
 b=W5RkrWS00q8n9wyKi8BJD8r6yIs1HVDJ8EnGcHzkhMtwEm9oHjD0i9YZbrACdmwO7FczFT
 WUWLD/AldD8oxRQ7lpEixUi1oqmpHfNK4+RgCD1VhXAZQijBf3IsiYbIsmuiW4hlgdg/SY
 292vi9ubIqJaiYnBDVdBkjfbNiqfcQ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-ileFY3lWOlaMtqqpxg3RCA-1; Mon,
 13 Oct 2025 05:19:38 -0400
X-MC-Unique: ileFY3lWOlaMtqqpxg3RCA-1
X-Mimecast-MFC-AGG-ID: ileFY3lWOlaMtqqpxg3RCA_1760347176
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D8871954115; Mon, 13 Oct 2025 09:19:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D93E30002CE; Mon, 13 Oct 2025 09:19:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 530F618000B2; Mon, 13 Oct 2025 11:19:33 +0200 (CEST)
Date: Mon, 13 Oct 2025 11:19:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <3flcrys75wbso64zpfbika46klfbg7khbrtug3avrpfixaxmo5@vuidk7ktxnpi>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecrbj85s.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

On Fri, Oct 10, 2025 at 01:41:35PM +0200, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > optional support for logging to a memory buffer.  There is guest side
> > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > But that might not helpful if your guest stops booting early enough that
> > guest tooling can not be used yet.  So host side support to read that
> > log buffer is a useful thing to have.
> >
> > This patch implements both qmp and hmp monitor commands to read the
> > firmware log.
> 
> So this is just for EDK2, at least for now.

Yes.

> > +    char                 FirmwareVersion[128];
> > +} MEM_DEBUG_LOG_HDR;
> 
> I understand this is a (close to) literal copy from EDK2, and adjusting
> it to QEMU style would be a bad idea.
> 
> > +
> > +
> > +/* ----------------------------------------------------------------------- */
> > +/* qemu monitor command                                                    */
> > +
> > +typedef struct {
> > +    uint64_t             Magic1;
> > +    uint64_t             Magic2;
> > +} MEM_DEBUG_LOG_MAGIC;
> 
> Unusual capitalization for a typedef name.  Why?  To emphasize the
> relation to MEM_DEBUG_LOG_HDR?

Yes.

> > +    if (header.DebugLogSize > MiB) {
> > +        /* default size is 128k (32 pages), allow up to 1M */
> > +        error_setg(errp, "firmware log: log buffer is too big");
> 
> [*] We limit the buffer to 1MiB.  No objection to the size.
> 
> What do you mean by "default" in "default size"?  Is the size
> configurable in EDK2?

Yes, there is an option for that.

> Should we try to cope more gracefully with oversized log buffers?  It's
> a ring buffer.  What about silently reading the latest 1MiB then?
> Behaves just as if the ring buffer was 1MiB.

See below.

> > +# @log: Firmware debug log, in base64 encoding.
> 
> Can this have a partial line at the beginning and/or the end?

Yes.

> > +#
> > +# Since: 10.2
> > +##
> > +{ 'struct': 'FirmwareLog',
> > +  'data': { '*version': 'str',
> > +            '*log': 'str' } }
> 
> These aren't actually optional with the current code.  See [**] above.
> I guess you make them optional just in case some other firmware can
> provide only one of them.

We could also make both mandatory.  There is always the option to return
an empty string ...

> > +##
> > +# @query-firmware-log:
> > +#
> > +# Find firmware memory log buffer in guest memory, return content.
> 
> Should we mention this is implemented only for EDK2 at this time?
> 
> Have you considered an optional size argument to retrieve the tail of
> the log?

I'll have a look.  If we implement the 1MB cap suggested above we would
get that (almost) for free.

take care,
  Gerd


