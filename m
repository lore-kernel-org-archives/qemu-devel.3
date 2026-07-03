Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06609C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcIY-0003z8-FQ; Fri, 03 Jul 2026 07:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfcIW-0003y3-Hx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfcIU-0000Hy-QI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783078985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC4ZYa1/tpGom2+2fSZdaE89SomtyswHIqmRJiLxnjY=;
 b=Dq/dA5L8aRqfUKRKhQmgNMmlMNG06EEfBgMrAgCBNT/OZX/UNYIKA78mey22BH23vSs0hi
 O3C/PORgTNyS/z/EDU3OR1MBMNRwOZSczNt2LBFkRe/RzJjx48ztE6ySs0llmF2cLnUNce
 AkoFYZ6b7qfSOGQXjmKWFg3Fycp2gFg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-BEJAlgD3M42v8TPNH7XiPg-1; Fri,
 03 Jul 2026 07:43:02 -0400
X-MC-Unique: BEJAlgD3M42v8TPNH7XiPg-1
X-Mimecast-MFC-AGG-ID: BEJAlgD3M42v8TPNH7XiPg_1783078981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E89E1944B13; Fri,  3 Jul 2026 11:43:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.149])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC5F1800841; Fri,  3 Jul 2026 11:42:57 +0000 (UTC)
Date: Fri, 3 Jul 2026 12:42:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org
Subject: Re: [PATCH v6 05/34] monitor: minimal conversion of monitors to QOM
Message-ID: <akegPhoEx4_u-4Lh@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-6-berrange@redhat.com>
 <87tsqgwbew.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsqgwbew.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 03, 2026 at 01:38:31PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This introduces a Monitor QOM object, with MonitorHMP and
> > MonitorQMP subclasses. This is the bare minimum conversion
> > of just the type declarations and replacing g_new/g_free
> > with object_new/object_unref. The Monitor base class is
> > abstract since only the HMP/QMP variants should ever be
> > created.
> >
> > When created through the existing QemuOpts interfaces, the
> > new internal QOM object will get assigned a dynamic ID with
> > the format "compat_monitorNNN" which is the historical
> > QemuOpts ID naming pattern.
> 
> Uh, sometimes the name isn't "compat_monitorNNN".
> 
> I'm not sure whether talking about QemuOpts helps or hurts here.  Let me
> try not to talk about it:
> 
>   This introduces abstract QOM type "monitor", with concrete subtypes
>   "monitor-hmp" and "monitor-qmp". This is the bare minimum conversion
>   of just the type declarations and replacing g_new/g_free with
>   object_new/object_unref.
> 
>   Command line option -monitor now creates a monitor-hmp object
>   /objects/compat_monitorNNN in addition to the character device
>   /chardevs/compat_monitorNNN. NNN counts up from zero.
> 
>   Exception: -monitor chardev:ID creates a monitor-hmp object
>   /objects/ID, and does not create a character device.
> 
>   -qmp and -qmp-pretty work the same, except they create a monitor-qmp
>   object.
> 
>   -mon now creates a monitor-hmp or monitor-qmp object /objects/ID if
>   the option argument provides an ID, else /objects/compat_monitorNNN.
> 
> If you want to make the connection to QemuOpts ID, add
> 
>   Note that the object's name in /objects/ matches the QemuOpts ID when
>   it exists.  The only case where it doesn't exist is -mon without ID.
> 
> Finally, point to what's coming:
> 
>   A future patch will make "monitor-hmp" and "monitor-qmp" work with
>   -object and object-add.

Ok, that's all fine with me.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


