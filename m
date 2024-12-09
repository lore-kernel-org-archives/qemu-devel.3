Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A0EE77182
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgkw-0004TJ-JS; Mon, 09 Dec 2024 11:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKgku-0004RY-Up
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKgkt-0004v6-6y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733762224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UsyPNn7HCEQGIw7zBl/R1eGSoI1IEujvA9dGrTug/y0=;
 b=bQkXEleromA2KUp6KOX+9Vn6rHJ+bLZFNRT7GZvClwVGVeLr5mryAqtA6nSgJTkQeR8AVV
 SUjQGlSzhwpWtSotKiDnSuDOYqimCZBg5HmRE3JI121i+vZJNNph2uAFG/epawx1Dc0DHx
 DLVVuTWjJxi5qacNL01PiXzsIdiG7cM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-iKzLlwBtNwSQ6PxMQJ5qwQ-1; Mon, 09 Dec 2024 11:37:03 -0500
X-MC-Unique: iKzLlwBtNwSQ6PxMQJ5qwQ-1
X-Mimecast-MFC-AGG-ID: iKzLlwBtNwSQ6PxMQJ5qwQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8897ea603so85043786d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733762221; x=1734367021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsyPNn7HCEQGIw7zBl/R1eGSoI1IEujvA9dGrTug/y0=;
 b=tlFR7lwWhyZ9ppQggJ0h5wlN1WhFHppDvZ8RTfNi3oQdr7KhZhIeTxHkTgfhmmaIJf
 3A9eGj+Cimy/lSjZRHEG70V7f4oiil4ivDMesaEQ0GOouliTb2NZvefK1r9jOzrrls/q
 g9wwivDsHDjhgSdBlpW2UjuvmYjC+PzWSNlhKen5w73RNQCopAgLHsZMDJUKeqg4i/Lw
 Wd1zVf3OY1cQuBl2I+nYcWKVh/Fj8qfH29GCxxlEBy7bAnsk1aEJKQNCD10jMclBjTuj
 HQkZDRUhLzJkgVySTPcvIUB9rDUtrfWzqPkVtjmhvd3V0NLRPVTOGzxe1RGLi/mCeBpU
 fUfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOF60xh6b4aeT5hwtJzuSxIoTzlCrfudEokgQTOkRPzoMRFXfV8okj8iuzadu9lquV0f613ejHgnW@nongnu.org
X-Gm-Message-State: AOJu0Yz82AwFDqMnV7//0jMagfDMISmbAi70ea1jrqD4UcQDLh+OAOce
 A5z6SaotMWFdul/Wge0aqeXjzoV3OGA89UkNBqIBsBO6u3FBjKvX2D9djUXesTozuqoTklbR5d1
 B3IvWxVDRZblRsICZ+eEuoH3bb7W4lCMoClmjCqwkQj60Rptg8cL1
X-Gm-Gg: ASbGnctbOyKYrS/N0N6MkzVLBgz2tIQ6T3lEoVH/hs3vA9ZCTwZTnev75oMYYkfkXHR
 ZB637YxEUwYhCCdlm4IpdAR50C80DZ17xRnObNO1UsNhpVcJwjlKSXC7PczsudtGzzg9J9wR0Tv
 X9+StInB0B5Ev4zN3u6jLv3Coum3OWhcnGhSydL7vn4Pxm3T+ksQ8uzX3KwBTnonoLhA5d1Viug
 flKDt0vWgDgygguJf+iTSqksnzOmfpDHnnRQonxHDOkgoZq37n82dRKKvUrG+XF1sxCYOQgL/4m
 FFc0LrHeV/8=
X-Received: by 2002:a05:6214:c45:b0:6d8:98a0:23b6 with SMTP id
 6a1803df08f44-6d92128f88dmr38126d6.4.1733762221627; 
 Mon, 09 Dec 2024 08:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8LoHFAwcYjxbcqSqUukPYZwFcfXVlcty1bpi3Xh8IyBBuvYb1N49MmiinSlJfmfObdHhHbw==
X-Received: by 2002:a05:6214:c45:b0:6d8:98a0:23b6 with SMTP id
 6a1803df08f44-6d92128f88dmr37836d6.4.1733762221354; 
 Mon, 09 Dec 2024 08:37:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6739a9sm50404216d6.3.2024.12.09.08.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:37:00 -0800 (PST)
Date: Mon, 9 Dec 2024 11:36:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 09/19] migration: incoming channel
Message-ID: <Z1ccql5bRaEGt7DZ@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 <87ser2cfw6.fsf@pond.sub.org>
 <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com>
 <87seqxf42e.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87seqxf42e.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 09, 2024 at 01:12:25PM +0100, Markus Armbruster wrote:
> >>> @@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
> >>>       if (incoming) {
> >>>           Error *local_err = NULL;
> >>>           if (strcmp(incoming, "defer") != 0) {
> >>> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
> >>> +            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
> >>>                                    &local_err);
> >>
> >> You move the parsing of legacy URI from within qmp_migrate_incoming()
> >> into incoming_option_parse().
> >>
> >> The alternative is not to parse it in incoming_option_parse(), but pass
> >> it to qmp_migrate_incoming() like this:
> >>
> >>                 qmp_migrate_incoming(incoming, !incoming, incoming_channels,
> >>                                      true, true, &local_err);
> >
> > Sure, I can tweak that, but I need to define an additional incoming_uri variable:
> >     qmp_migrate_incoming(incoming_uri, !!incoming_channels, incoming_channels, ...
> >
> > Only one of incoming_uri and incoming_channels can be non-NULL (checked in
> > qemu_start_incoming_migration).
> >
> > Would you prefer I continue down this path, or revert to the previous -cpr-uri
> > option?  I made this change to make the incoming interface look more like the
> > V4 outgoing interface, in which the user adds a cpr channel to the migrate command
> > channels.
> 
> I'm not sure.  Peter, what do you think?

For this specific question, I prefer reusing -incoming rather than going
back to -cpr-uri.

We should have discussed about this in the previous spin of a follow up
discussion, using -incoming for cpr channels seems to always be preferred.

https://lore.kernel.org/qemu-devel/Zz4NqcTDK73MKOaa@redhat.com/

At that time, the concern from Dan was not reusing the JSON format or
design the CLI's own format.  That was always based on reusing -incoming.

In this patch it's already reusing the JSON for the CPR port, which looks
all good from that POV.  OTOH, I don't yet have any preference on the impl
of how QEMU should do the internal parsing of such JSON string / legacy
URIs.

Thanks,

-- 
Peter Xu


