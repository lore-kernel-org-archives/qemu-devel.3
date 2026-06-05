Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2F0CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVX81-0003G9-1d; Fri, 05 Jun 2026 12:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVX7z-0003G1-Os
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVX7y-0006pV-1s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780675832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Esun/u/+nZY4Z6Wp9Q8MqvFcsNJwMkYOko/eiT/LiUU=;
 b=iU8hQr7Erqt33jBW25au1Pto9dmgNH9zep+Mf8idlHz7cpuBg6wfQho4Ar18rZiQLcKmDL
 4K7QYF3/7u+77qtl7v3MxmulxkrIB0tLcU2lMdeTy+VzUTZSYeDj5MZ9PWSJlJWehGdgAL
 2yr11liPtJVzXpiq19UBPSHG3XrfwLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-f2b1UL-oNMixrKNBxOaGpQ-1; Fri,
 05 Jun 2026 12:10:28 -0400
X-MC-Unique: f2b1UL-oNMixrKNBxOaGpQ-1
X-Mimecast-MFC-AGG-ID: f2b1UL-oNMixrKNBxOaGpQ_1780675827
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B084195609E; Fri,  5 Jun 2026 16:10:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57EF11800348; Fri,  5 Jun 2026 16:10:25 +0000 (UTC)
Date: Fri, 5 Jun 2026 17:10:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
Message-ID: <aiL07TJlvZM8-ZAk@redhat.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
 <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
 <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
 <9bef9acb-3153-4ef8-b3c6-6ff6303336f5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bef9acb-3153-4ef8-b3c6-6ff6303336f5@virtuozzo.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 08, 2026 at 10:30:29AM +0100, Denis V. Lunev wrote:
> On 1/8/26 09:11, Marc-André Lureau wrote:
> > Hi Nikolai
> >
> > On Wed, Sep 24, 2025 at 12:30 PM Marc-André Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >> Hi
> >>
> >> On Thu, Sep 11, 2025 at 4:37 PM Nikolai Barybin <nikolai.barybin@virtuozzo.com> wrote:
> >>> QMP query-dump-guest-memory-capability reports win dump as available for
> >>> any x86 VM, which is false.
> >>>
> >>> This patch implements proper query of vmcoreinfo and calculation of
> >>> guest note size. Based on that we can surely report whether win dump
> >>> available or not.
> >>>
> >>> To perform this I suggest to split dump_init() into dump_preinit() and
> >>> dump_init_complete() to avoid exausting copypaste in
> >>> win_dump_available().
> >>>
> >>> For further reference one may review this libvirt discussion:
> >>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> >>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
> >>>
> >>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> >>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >>
> > Have you looked at my review & updated the patches? thanks
> I will send updated version next week after vacation. Nikolai has
> left Virtuozzo.
> 
> Thank you for the reminder and best regards,

I don't recall seeing a followup v5 for this ? Were you still
interested in progressing this work ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


