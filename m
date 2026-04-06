Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C415EF4EB6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9eHG-0007we-0y; Mon, 06 Apr 2026 03:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w9eHE-0007wD-6H
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 03:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w9eHB-0001P1-Bv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 03:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775460095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A4KNjn9htZaCRIRHLEsn8uan9rrHv8Y1Lgt+7LIHeeo=;
 b=U+qK3UqMA0UUfk6m+nckSAZTRFObFp2iEkJi9Y+EHcMtiHotzOu88FgV5+7J4W+ln6GFOn
 QNNM1EddmflNl48BGpwTHYeK1RyZkdMW/A7clqZt9cFuGE9u4k0AaLgaVWu1QTX+qwpkfe
 9PQugyaWN8f52yfOUs5ErrKbikReUVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-eYaCdDcfNbijIeN0tJ2XJg-1; Mon, 06 Apr 2026 03:21:33 -0400
X-MC-Unique: eYaCdDcfNbijIeN0tJ2XJg-1
X-Mimecast-MFC-AGG-ID: eYaCdDcfNbijIeN0tJ2XJg_1775460093
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so46842865e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 00:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775460092; cv=none;
 d=google.com; s=arc-20240605;
 b=F6fTLSFFGGXz4YgSucUNuQ9yUaTPst9PF/+Zpu/ReYGph5lpXg3BZCICLs3+w7TNAO
 TSePSZJh+er5B1QOu5LfG52N+MFU4KW6gL4eB5+ygkayh18eVJjDGQeSpYn7N4FBMfdi
 ncoEmVYvQupoPeJmAKOUlOBhszW6A+4Fu55j4oIZ7Y8QokaiaYQPni86DKw6O7vtcTP4
 d5+RA+tle1JZm2fb8/Nwd7TrxQDBNY+cL9wL+KBXgry4+jwyFgnlmjyHD33cRW+VoBhE
 kSnLDU9YFwVyqbYkLJWjqxjOkK5wAKBz3XGUue+qWiNFQmbHgAtC7EglU+Cyzii7wZ5T
 zlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A4KNjn9htZaCRIRHLEsn8uan9rrHv8Y1Lgt+7LIHeeo=;
 fh=IAeY1DPX4SofG+uEdlA7hmgTetvBCVk9jD4c2nIj7F4=;
 b=LehostOkuk2CI2ac/hOw1uxczB5UaOnZK4A7NLl6YFbXP7iigHEwt4cvHRoyiKjHkO
 f7eV1AlhJ5sm1LsYdrIhJo6PU+6X01nJ5IzDq5qHSiO0pZX0xszigbEia0XtshtWUnGq
 pUgc11Lww6QmwwHLqgunpOHpXGEOcFLXvEvnT2PSoBGQqJ6czIkkqIUn77xPC46N4e0f
 b3CIxlpAt4ypTKyMhbmODCAA9WjEJzSpO7Jx03obrYiPD1JgE4dikviVX6ntjIPrfLtm
 UlxypVKRKXGCSxhCePWVm/Zd71mnFQM0uO9FDweSqypn7f4nSDK3BJWy0sGG5yxWiaaL
 GV/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775460092; x=1776064892; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4KNjn9htZaCRIRHLEsn8uan9rrHv8Y1Lgt+7LIHeeo=;
 b=QRpqWAKvs7LcCyWZOQKlPoTqPQxxTTGJp4n13ZO1d9nVZ5IV0S/38YemrZm7oMb9z0
 ge3rLl8ajC6oyIGLoBPsPOER9SrdVuuJ4E0Ip9uvCttN2F3hOyrjImG/ZIqhEI5S3Zbf
 zSTgqEW1TQWsVhPW7m96XEbmvi07Msy9XCL3wgbJLBEAtEogWDnuS1NRpe7iQAKHmChW
 wMgMoGGYsgcVoCcxqAetcO4iiuNPGF5C4vdZCyE9SUFP7MBp0lETB1bLo/ezujAck7vE
 NGCVuqjs9Z+jNgkSzZwhW/v3mfuR1o/nuQHYV5pZ/lLR9Dnfh8tjimV7sa3dVNfrhevT
 04ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775460092; x=1776064892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4KNjn9htZaCRIRHLEsn8uan9rrHv8Y1Lgt+7LIHeeo=;
 b=GCG/KPwXQ8SNG59N/+s9T1/So3l8y91DJBGQnHrKtw5DNty082eGpBc+mwEadwfti4
 ZkgWMBDbgaUVMEPVZHP/4leaWe4aSlVyRhdLg6j1PDDnpRQUiIFlR5fVandeNI1LNhLy
 xd/fE9KKEA4WHOkZobeY6FfHAeTLQb015Fvs5WgIFCEphwMjZHOr+ZA37zMwtkmL80bq
 rbI0vSDBMkCbsZdMe+V43ngNhHplzsBBrFXEXijrXBqm+FiVru0cMSpxgVKEGcg9vJWx
 +PLPmv8Sx2VHkoSJYDmQb4XRuFurxYd/lxXC5b871BjCMgZ6RiQvsZGedc9sQ6zdCzHh
 vmmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi2NCCtp3/ClOoLcuYTsTQ+pJRtWpGjCWFxfWd2txfdsRV6U/F7giT5ahhZRBIM+U+WQZe5T+HRlSj@nongnu.org
X-Gm-Message-State: AOJu0YxJdweJnXPJRgvAwjXH7cSnGHkBQ1aYz63KuKva7pQmH7zh2Xwl
 FjAWf7mG2xXOPSVeXD7CN524Y4n01yU16UDXiiTCkG5QWMdc9AbZDLFwQVG12nCOoS7QYwAZoNP
 CplIDVhQk0LSULDfqHQL63E/u37+17F3urkR035rv2YTFk/5AfuoeNxSGsuXruM2meGi3Y6QJ3B
 ZMtA1hwLYT0zyJ3gngRugCiUjqCJtzytw=
X-Gm-Gg: AeBDieuM4o9g5UHs74kbAyA+LJjQ26NZoHembfiqKykkZXniAfSMxoxkDmvSO1PqxmW
 NVNnV92gl0bLzX62XCGz7D58yN/afvfJEArNPy3Cd3P9CMqyib5qY9oh+0elov1n+yXv/rsgmSu
 MfF4VQ7GgIpZ4JMeo8aN3IkVRJkaJx2rkghS0NOi/dpnsaPgxnNYvGgxkpGTKHhyoqc14hIiUBX
 QZuERRkMbZL2j0UnRl7V/cB+75YNafOpwYwyYD8PPdTJeMvaUCVXxjuvAK5tcU/HBE=
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4889945f8e8mr108143525e9.2.1775460092588; 
 Mon, 06 Apr 2026 00:21:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4889945f8e8mr108143285e9.2.1775460092140; Mon, 06 Apr 2026
 00:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
 <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
 <acaNfFWvNAEpFsFD@fedora>
 <CAE8KmOwwFmrNgb8MWO7yprPmtautrbrWzF5FYdJ4ODboQxhwUw@mail.gmail.com>
 <acuQc3dVq5vfh3cl@fedora>
In-Reply-To: <acuQc3dVq5vfh3cl@fedora>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 6 Apr 2026 12:51:14 +0530
X-Gm-Features: AQROBzBwMuwaDVLTRLd3N-xRgENmTniD0Mo3lsHYmtrpXjHl7sikIO1iu4qLknU
Message-ID: <CAE8KmOxtcwoFKNgihWnheY8F__uPbzGC9u_5ve24+5oLbb+_sQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On Tue, 31 Mar 2026 at 18:19, Juraj Marcin <jmarcin@redhat.com> wrote:
> QAPI schema defines the type of 'avail-switchover-bandwidth' and other
> '*-bandwidth' properties as size, which allows users to use size suffix,
> for example '100M'. QAPI parser then parses this value to
> 100 * 1000 * 1000 bytes.

* That's nice, and common with other tools: dc(1), wget(1), curl(1).
It still doesn't save user the trouble of converting 100 Mbps ->
12.5MBps. If we check wget(1) and curl(1), their '--limit-rate' option
accepts values as Bytes/Sec, but that is usage limit user wants to
impose, it does not entail bits <-> bytes conversion. If the intended
use of '--available-switchover-bandwidth' option is analogous to the
'--limit-rate' option, then naming it --available-*bandwidth is
confusing OR wrong.

* The contention here is the deviation from the norm of specifying
bandwidth in 'bits-per-second'. To accommodate it we add conversion
arithmetic and (miss) documentation, etc. Above all it breaks user
intuition.

> Changing from bytes to bits is API breaking change, I don't think it is justified.

* The sanctity of APIs is important. But that should not prevent us
from improving the very APIs.

> Devices report two pending values, 'must_precopy' and 'can_postcopy'.
> 'must_precopy' is number of bytes that must be migrated in precopy (or
> switchover) and cannot be postcopied. 'can_postcopy' is number of bytes
> that can be migrated either in precopy or postcopy, those can be RAM
> pages (with postcopy-ram enabled) or dirty bitmaps or any device that
> would support postcopy.
>
> If switching to postcopy is allowed, we only need to be able to transfer
> 'must_precopy' bytes in switchover. Rest of the pending data can be
> migrated in postcopy ('can_postcopy' bytes). Thus, we only compare
> 'must_precopy' when deciding whether to switch to postcopy.
>
> However, if postcopy isn't allowed, and we are deciding whether to stop
> the source machine and complete the migration, we need to migrate
> everything in switchover, including the data that could be postcopied.
> Thus, we need to compare 'pending_size = must_precopy + can_postcopy' to
> decide if we can complete the migration in the specified downtime.

* Right. Is it fair to say:

        /* Return pending data size to decide if we can pause/stop the source VM
         * and start the VM on the destination side */
        uint64_t qemu_savevm_state_pending_estimate/exact( ... )
        {
                 uint64_t must_precopy = 0, can_postcopy = 0;
                 ...
                 if (migrate_postcopy())
                     return must_precopy;

                 return must_precopy + can_postcopy;
        }

       pending_size = qemu_savevm_state_pending_estimate/exact( ... );

Thank you.
---
  - Prasad


