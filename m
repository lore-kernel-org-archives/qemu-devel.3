Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B69C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFue-0000Zn-3d; Fri, 12 Jul 2024 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFuZ-0000GQ-Q4
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFuW-0005aM-TE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720789323;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARL2kqQnjMbu5DhDoCvAaDjTh5SJim1WFmjmYkUBpyQ=;
 b=XsonLrQkB0iUBHP3/LUzJUzndLL6M+G6ktrveJnfz4jrf9DXmPyDDboV2PGxdsFPx5qwpk
 DxYpUJ1eWE1jyNfDFnYg0yR1XTefxe7vZ7HYgycej3uh9nzQJY79dPqLHCF1IeocYiV7pB
 Z1ovV+9L5LzbgEoGNQWFMJVcM9z3zfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-KZyDDsg4Piy-MJ4MTfFa4Q-1; Fri,
 12 Jul 2024 09:02:02 -0400
X-MC-Unique: KZyDDsg4Piy-MJ4MTfFa4Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33AB919560A2; Fri, 12 Jul 2024 13:02:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 145A01955E85; Fri, 12 Jul 2024 13:01:57 +0000 (UTC)
Date: Fri, 12 Jul 2024 14:01:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 22/22] qga: centralize logic for disabling/enabling
 commands
Message-ID: <ZpEpQwrAyBrPf-ix@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-17-berrange@redhat.com>
 <g1m2c.r93vk15jos2y@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g1m2c.r93vk15jos2y@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 03, 2024 at 01:01:11PM +0300, Manos Pitsidianakis wrote:
> Hello Daniel,
> 
> This cleanup seems like a good idea,
> 
> On Thu, 13 Jun 2024 18:44, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > It is confusing having many different pieces of code enabling and
> > disabling commands, and it is not clear that they all have the same
> > semantics, especially wrt prioritization of the block/allow lists.
> > The code attempted to prevent the user from setting both the block
> > and allow lists concurrently, however, the logic was flawed as it
> > checked settings in the configuration file  separately from the
> > command line arguments. Thus it was possible to set a block list
> > in the config file and an allow list via a command line argument.
> > The --dump-conf option also creates a configuration file with both
> > keys present, even if unset, which means it is creating a config
> > that cannot actually be loaded again.
> > 
> > Centralizing the code in a single method "ga_apply_command_filters"
> > will provide a strong guarantee of consistency and clarify the
> > intended behaviour. With this there is no compelling technical
> > reason to prevent concurrent setting of both the allow and block
> > lists, so this flawed restriction is removed.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > docs/interop/qemu-ga.rst |  14 +++++
> > qga/commands-posix.c     |   6 --
> > qga/commands-win32.c     |   6 --
> > qga/main.c               | 128 +++++++++++++++++----------------------
> > 4 files changed, 70 insertions(+), 84 deletions(-)

> > diff --git a/qga/main.c b/qga/main.c
> > index f68a32bf7b..72c16fead8 100644
> > --- a/qga/main.c
> > +++ b/qga/main.c
> > @@ -419,60 +419,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
> >     return strcmp(str1, str2);
> > }
> > 
> > -/* disable commands that aren't safe for fsfreeze */
> > -static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
> > +static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
> > {
> > -    bool allowed = false;
> >     int i = 0;
> > +    GAConfig *config = state->config;
> >     const char *name = qmp_command_name(cmd);
> > +    /* Fallback policy is allow everything */
> > +    bool allowed = true;
> > 
> > -    while (ga_freeze_allowlist[i] != NULL) {
> > -        if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
> > +    if (config->allowedrpcs) {
> > +        /*
> > +         * If an allow-list is given, this changes the fallback
> > +         * policy to deny everything
> > +         */
> > +        allowed = false;
> > +
> > +        if (g_list_find_custom(config->allowedrpcs, name, ga_strcmp) != NULL) {
> >             allowed = true;
> >         }
> > -        i++;
> >     }
> > -    if (!allowed) {
> > -        g_debug("disabling command: %s", name);
> > -        qmp_disable_command(&ga_commands, name, "the agent is in frozen state");
> > -    }
> > -}
> > 
> > -/* [re-]enable all commands, except those explicitly blocked by user */
> > -static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
> > -{
> > -    GAState *s = opaque;
> > -    GList *blockedrpcs = s->blockedrpcs;
> > -    GList *allowedrpcs = s->allowedrpcs;
> > -    const char *name = qmp_command_name(cmd);
> > -
> > -    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL) {
> > -        if (qmp_command_is_enabled(cmd)) {
> > -            return;
> > +    /*
> > +     * If both allowedrpcs and blockedrpcs are set, the blocked
> > +     * list will take priority
> > +     */
> > +    if (config->blockedrpcs) {
> > +        if (g_list_find_custom(config->blockedrpcs, name, ga_strcmp) != NULL) {
> > +            allowed = false;
> >         }
> > +    }
> > 
> > -        if (allowedrpcs &&
> > -            g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
> > -            return;
> > -        }
> > +    /*
> > +     * If frozen, this filtering must take priority over
> > +     * absolutely everything
> > +     */
> > +    if (state->frozen) {
> > +        allowed = false;
> > 
> > -        g_debug("enabling command: %s", name);
> > -        qmp_enable_command(&ga_commands, name);
> > +        while (ga_freeze_allowlist[i] != NULL) {
> > +            if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
> > +                allowed = true;
> > +            }
> > +            i++;
> > +        }
> >     }
> > +
> > +    return allowed;
> > }
> 
> IUUC, we can check by priority here: first check if (state->frozen), then
> blockedrpcs, then allowedrpcs and then return a default fallback value
> allowed = config->blockedrpcs != NULL && config->allowedrpcs != NULL

That would imply each check does an early return. When I add in the
following series, I have further checks going in this method which
rely on the fallthrough for overrides, which works better as it is
written here.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


