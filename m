Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1295C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH26p-0005kL-71; Tue, 11 Jun 2024 10:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sH26n-0005jQ-Cq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sH26l-0001Zu-8N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718114657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TTUvEkRoTU27DpZAoSzAkCk9EXn/rTO34SkpWhc2U=;
 b=XtvvIJARY4oT1fsQHvK2S02XOY9PBJNC7voOpogj4zXTBdrAS10xD3Go+tIFhAbXGUQKoQ
 uy6zGas0h4wDlyBVg+0KoBJ2WqLIjmHtFU/XiNdaJGyqE9n3PybMfr64FH3+mDb7wAT5bN
 0cDnsFzrsX3DpOpHxzJWGkYsFlUOJUA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-nZP-so0DOzWHghmGueCszA-1; Tue,
 11 Jun 2024 10:04:13 -0400
X-MC-Unique: nZP-so0DOzWHghmGueCszA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B947D1944CCC; Tue, 11 Jun 2024 14:04:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD61C18D12C5; Tue, 11 Jun 2024 14:03:40 +0000 (UTC)
Date: Tue, 11 Jun 2024 15:03:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 08/20] qga: conditionalize schema for commands
 unsupported on Windows
Message-ID: <ZmhZOLzqPAaJ6e1D@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-9-berrange@redhat.com>
 <87ed93k2hy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed93k2hy.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 11, 2024 at 03:55:37PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Rather than creating stubs for every command that just return
> > QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> > fully exclude generation of the commands on Windows.
> >
> > The command will be rejected at QMP dispatch time instead,
> > avoiding reimplementing rejection by blocking the stub commands.
> >
> > This fixes inconsistency where some commands are implemented
> > as stubs, yet not added to the blockedrpc list.
> >
> > This has the additional benefit that the QGA protocol reference
> > now documents what conditions enable use of the command.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qga/commands-win32.c | 56 +-------------------------------------------
> >  qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
> >  2 files changed, 31 insertions(+), 70 deletions(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 9fe670d5b4..2533e4c748 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> 
> [...]
> 
> >  /* add unsupported commands to the list of blocked RPCs */
> >  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> >  {
> > -    const char *list_unsupported[] = {
> > -        "guest-suspend-hybrid",
> > -        "guest-set-vcpus",
> > -        "guest-get-memory-blocks", "guest-set-memory-blocks",
> > -        "guest-get-memory-block-info",
> > -        NULL};
> > -    char **p = (char **)list_unsupported;
> > -
> > -    while (*p) {
> > -        blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
> > -    }
> > -
> >      if (!vss_init(true)) {
> >          g_debug("vss_init failed, vss commands are going to be disabled");
> >          const char *list[] = {
> >              "guest-get-fsinfo", "guest-fsfreeze-status",
> >              "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
> > -        p = (char **)list;
> > +        char **p = (char **)list;
> >  
> >          while (*p) {
> >              blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
>            }
>        }
> 
>        return blockedrpcs;
>    }
> 
> Four commands get disabled when vss_init() fails, i.e. when qga-vss.dll
> can't be loaded and initialized.
> 
> Three of the four commands do this first:
> 
>         if (!vss_initialized()) {
>             error_setg(errp, QERR_UNSUPPORTED);
>             return 0;
>         }
> 
> The execption is qmp_guest_get_fsinfo().
> 
> vss_initialized() returns true between successful vss_init() and
> vss_deinit().
> 
> Aside: we call vss_init() in three places.  Two of them init, call
> something, then deinit.  Weird.  Moving on.
> 
> If these commands are meant to be only available when the DLL is, then
> having them check vss_initialized() is useless.
> 
> Conversely, if the check isn't useless, then the "make it available
> only" business is.
> 
> Opportunity for further cleanup?

If we eliminate the "make it available" check in ga_command_init_blockedrpcs,
that would be a nice cleanup IMHO, as these few commands are the only
special case where that's needed now.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


