Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B0AE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCGK-0005l6-Tg; Tue, 07 Jan 2025 11:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVCGA-0005aA-5g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVCG8-000212-Md
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736266608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JUxwiCo8e3lxC+BKSA2tY9HCulg+o+DDynrN1sw7sA=;
 b=KLXdIXKLqFR4H4XSrhVXzApcGaMo7y2STJ6Rl0G7IWMdvKzg0Z1WiwN2+7wOHOCfTwzET7
 JjLD1Xv1i4YaEDEJWfdfo+rLGfWRVzKJyrn4A1O/lIewI3+0wXdVBwqCp0ceF7Hm3f2UYf
 1yiUy/FwVvH466sZQZcUt7njMhT9tdM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Kr7BKKvzMhuzaP7Y22HynA-1; Tue,
 07 Jan 2025 11:16:46 -0500
X-MC-Unique: Kr7BKKvzMhuzaP7Y22HynA-1
X-Mimecast-MFC-AGG-ID: Kr7BKKvzMhuzaP7Y22HynA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4889B195605C; Tue,  7 Jan 2025 16:16:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 700FE195606B; Tue,  7 Jan 2025 16:16:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F1A5D18000B4; Tue, 07 Jan 2025 17:16:40 +0100 (CET)
Date: Tue, 7 Jan 2025 17:16:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 13/21] hw/uefi: add var-service-json.c + qapi for NV
 vars.
Message-ID: <kct6qjtmbetdogd4mwprtzqmd6uv6ugxbwybsh6ehqnp2pz3zi@lrupvba7pbc2>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <20250107153353.1144978-14-kraxel@redhat.com>
 <Z31M9Vd37_koWggu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31M9Vd37_koWggu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > +    lseek(uv->jsonfd, 0, SEEK_SET);
> > +    rc = write(uv->jsonfd, gstr->str, gstr->len);
> > +    if (rc != gstr->len) {
> > +        warn_report("%s: write error", __func__);
> > +    }
> > +    rc = ftruncate(uv->jsonfd, gstr->len);
> > +    if (rc != 0) {
> > +        warn_report("%s: ftruncate error", __func__);
> > +    }
> > +    fsync(uv->jsonfd);
> 
> Although the fsync helps, re-writing the file in-place is a ad idea for data
> integrity on host OS crash. Especially if the new data is shorter, we would
> easily end up with a file containing old and new data making it unparsable
> (assuming the parser doesn't ignore trailing data).

I've tried to minimize the number of syscalls for the update, hoping to
also minimize the chance for corruption.

> I'd like to suggest the write to temp file + rename dance to get atomic
> replacement. The problem with that is that it hits the DAC/MAC security
> restrictions we put QEMU under :-(

Yep.  If we want allow libvirt passing file handles to qemu we can't do
the rename dance.

> My next best idea is to re-arrange things thus:
> 
>    lseek(fd, 0)
>    ftruncate(fd, 0)
>    fsync(fd)
>    write(fd, str)
>    fsync(fd)
> 
> so we should at least reduce the liklihood of getting a mix of
> old and new data - empty file is better than a mix of data.

On parse errors the complete file content is simply ignored, so it
should not make much of a difference whenever the file is empty or
corrupted.

Reorder the calls to first ftruncate then write looks reasonable.
Not sure the extra fsync makes sense.

take care,
  Gerd


