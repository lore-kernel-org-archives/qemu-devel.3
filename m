Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC27CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb3F-0006tt-Hb; Thu, 28 May 2026 09:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSb3D-0006tL-F6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSb3A-0001tb-Cf
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779975927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wzNF0nQe5N8Nw08zOIqJsfF9VpXGILd75mFX6/aaU8=;
 b=JDIZxPiYhuWsivzKcXS2eVS/9n7oowXwa/XJaNphRbE0rxSpBni0xJUJTTUUupvfOBrQcP
 G/QF3ZDOZrLDCM1VoKXu8OVz40A0lzaq2DA9up5uAeEUq7vnFxliUFgk6RzvD7b1qLBtWP
 wWxGWBg18eYvzGsm7SCezKlNFI8AnpM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-4PLtR4CjOs2QNLXGyAcYJA-1; Thu, 28 May 2026 09:45:25 -0400
X-MC-Unique: 4PLtR4CjOs2QNLXGyAcYJA-1
X-Mimecast-MFC-AGG-ID: 4PLtR4CjOs2QNLXGyAcYJA_1779975925
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so11782196d6.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779975925; x=1780580725; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2wzNF0nQe5N8Nw08zOIqJsfF9VpXGILd75mFX6/aaU8=;
 b=XZj/17avJvshyDj7DqgNri5dNaBqIwF0ddp/6mWvyKQDB6ALuhqwq4PVRn55RGPIHV
 OlERnPqt2nxfZetGIBb1gnHpWGe5VaApLkzzgVw+1Dezy6ZxWqSOiLTPb12F3hoPcd2B
 vkYKoQelDWl5iKeztJX7SkMVBa2qnWdv2mQ16Tx+iqQnCRHpheme/kE4a5MasA/qanb+
 FqHGUFC9YYq2X2xbc5qALAOg0APU2s04GZKWYKjRgNBHSNvLJqrGdxUzIsKtAQfjSVRT
 J0nvvFiklkaPmW4r1JRnGpHH/VqPwdg360HWO8uDiEMCW1hnxKwCeO1jVac16gcH5XSe
 u7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975925; x=1780580725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wzNF0nQe5N8Nw08zOIqJsfF9VpXGILd75mFX6/aaU8=;
 b=HnPR8zPBoYClrBQLYFqPW7u75AlIfzuE3NZ7hJfg2f5+JEef3rEZqCxTRE5kCb8fzY
 9YHeiHFO6ia3REf3Cw67/62mcGVZTGLJQodWc6ERB6vwtLLbZClppkim2PdzAMyerJsJ
 KQ7VdYs8kyZcEsgWfhSlnusUI3Pz7rNCs3JpbFnh64XnuVSGgJJBop+bAmW32l6BLFIN
 KP2fPPfCaSuKCbzJZ6WqruKGRLd8pmzWnBv202029wjzeXm7zhtcqLyFTRdMrQugCVRY
 PdPHC10M42stjboeQiBdTSdK+xa5s/MFpDZPJRQF4Iw0/EM/9Enqi/S2fU9yzY5IVSKx
 LnXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g2wPQrie8JUXUPY+ORiA/1yHtnG9ObOpvnN0/sbVUdGRJtiCGh/IpJAaorYWNKwebKugXeTnqijgA@nongnu.org
X-Gm-Message-State: AOJu0YxKR3pLLHx4pKGeb/AosEjQDt9/5MLBX0mNAVMY7STZYJYzq3CF
 V/HDV/cX7cUgcabeXxw1uHk/d+y7Xdq26JabUBDmo60+bbYqz6R6zFOLPkWuyw6xBOw8q/Nwc/h
 jT+cDG6oRzD6cUMgGlG5WgkbsQAl2LGi3/qw2uyowD3ZBueiZfRseqrfU
X-Gm-Gg: Acq92OG/cMx36zEuQ2zeWboGO5PocVioBHjGGCGY5G8tHF3JEsp4hrLmjDYTpmaYh4A
 CWibmNqC1F5UlOV81fVidS/GhbyfY3i8q1tGb9CrYycCEk9gzBLHXozlf+jbVQ7t2f2ae2YbT24
 KTmyUvWSC+NDVixwzzBaUWOy7TXT74k3FUG3SLoOl2EwJFNca1kS6GgnHam8Zs7ii+a42lCQBoI
 sXmQJ8dKf7DjHKBscnNpMNtIa/t7IkjgkO2EdTstJV0BajymdPjvRskwSCKiZ22qy+ofKIJZxra
 zqzRYP8UaVYF/1YNpdAZFY/EaovIX/3CeW/1+2nBNtREPXGLl/+2x773SuX/kj75oVVHkMowyOo
 MXxHj3rpuyRgaWp+eqNlcu+gld5qMGnTgIVdzPfvSAf21MPAqjWIwcdKmZA==
X-Received: by 2002:a05:6214:808d:b0:8cc:cf1e:1fde with SMTP id
 6a1803df08f44-8cccf1e202dmr45114076d6.26.1779975924802; 
 Thu, 28 May 2026 06:45:24 -0700 (PDT)
X-Received: by 2002:a05:6214:808d:b0:8cc:cf1e:1fde with SMTP id
 6a1803df08f44-8cccf1e202dmr45112786d6.26.1779975924123; 
 Thu, 28 May 2026 06:45:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccc4e8b923sm40284406d6.37.2026.05.28.06.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:45:23 -0700 (PDT)
Date: Thu, 28 May 2026 09:45:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
Message-ID: <ahhG8v8FOXycIEfL@x1.local>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
 <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
 <a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru>
 <f84de0fe-8c93-4c3f-ad05-de40410b4697@yandex-team.ru>
 <ahdI7Vl5KraK566D@x1.local>
 <63bd6255-38a3-4d86-aa9c-e96d9d3b2de2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63bd6255-38a3-4d86-aa9c-e96d9d3b2de2@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 11:32:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.05.26 22:41, Peter Xu wrote:
> > On Wed, May 27, 2026 at 08:19:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 27.05.26 14:35, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 26.05.26 14:23, Vladimir Sementsov-Ogievskiy wrote:
> > > > > +
> > > > > +type_init(tap_register_types)
> > > > > diff --git a/qapi/net.json b/qapi/net.json
> > > > > index 82ddbb51cd7..029f5a4532c 100644
> > > > > --- a/qapi/net.json
> > > > > +++ b/qapi/net.json
> > > > > @@ -429,9 +429,18 @@
> > > > 
> > > > a bit more context:
> > > > 
> > > >    # @incoming-fds: do not open or create any TAP devices.  Prepare for
> > > > 
> > > > 
> > > > >    #     getting TAP file descriptors from incoming migration stream.
> > > > >    #     The option is incompatible with any of @fd, @fds, @helper, @br,
> > > > >    #     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
> > > > > -#     @downscript be explicitly set to nothing (empty string or "no")
> > > > > +#     @downscript be explicitly set to nothing (empty string or "no"),
> > > > > +#     and requires also @local-migration to be set an "local"
> > > > > +#     migration parameter be set as well.
> > > > >    #     (Since 11.1)
> > > > >    #
> > > > > +# @local-migration: enable local migration for this TAP backend.
> > > > > +#     When set, local migration is enabled/disabled by "local"
> > > > > +#     migration parameter for this TAP backend.  When unset, "local"
> > > > > +#     migration parameter is ignored for this TAP backend.
> > > > > +#     (Since 11.1.  Defaults to true for MT >= 11.1,
> > > > > +#     and to false for MT < 11.1)
> > > > > +#
> > > > >    # Since: 1.2
> > > > >    ##
> > > > >    { 'struct': 'NetdevTapOptions',
> > > > > @@ -451,7 +460,8 @@
> > > > >        '*vhostforce': 'bool',
> > > > >        '*queues':     'uint32',
> > > > >        '*poll-us':    'uint32',
> > > > > -    '*incoming-fds': 'bool' } }
> > > > > +    '*incoming-fds': 'bool',
> > > > > +    '*local-migration': 'bool' } }
> > > > 
> > > > 
> > > > Having both "incoming-fds" and "local-migration" (or rename
> > > > it to "support-local-migration") seems too much.
> > > > 
> > > > But, we can't simply drop "incoming-fds" and rely only on
> > > > "local-migration", a this make logic a lot more complicated,
> > > > as "local" migration parameter starts to "decide" how tap
> > > > initialization works:
> > > > 
> > > > We have to postpone opening any files up to "pre-incoming"
> > > > point, when all migration parameters are known, to decide:
> > > > 
> > > >     if "local-migration"=true and "local"=true - do not open
> > > >        any files, wait for incoming FDs
> > > > 
> > > >     if "local-migration"=true and "local"-false - open files
> > > > 
> > > > In this picture, the fact that migration parameter influence
> > > > device initialization - seems rather bad precedent, which is
> > > > better to avoid.
> > > > 
> > > > On the other hand, with "incoming-fds" parameter, everything is
> > > > explicit. We can simply detect and error-out incorrect
> > > > combinations (like incoming-fds=true, but incoming migration
> > > > started with local=false, etc.), but user is sure, that target
> > > > QEMU process will not open any files with this parameter set.
> > > > That's a safe way.
> > > > 
> > > > 
> > > > Still, I have alternative idea:
> > > > 
> > > > Instead of combination "-incoming defer" + "incoming-fds=true",
> > > > make a new "-incoming local".
> > > > 
> > > > "-incoming local" would be equal to "-incoming defer", but also
> > > > implies local=true (i.e. starting incoming migration with
> > > > local=false will simply fail).
> > > > 
> > > > This way, we know that local=True from the start of the process,
> > > > and don't have to wait for some pre-incoming point to be sure
> > > > in value of "local" parameter.
> > > > 
> > > > So, we simply check "local-migration == True  +  incoming == local"
> > > > instead of "incoming-fds == True" in tap code, and we are done.
> > > > 
> > > > What do you think?
> > > > 
> > > > 
> > > 
> > > Hmm. Bad idea. It may have same problem if use commandline options
> > > to create devices, as ordering of "-incoming local" and "-netdev"
> > > may affect how tap device will be initialized. It can be solved (or,
> > > maybe, it works as expected even now, if "-incoming" always handled
> > > before "-netdev" options... But anyway that's much more shaky than
> > > simple incoming-fds=True.
> > 
> > Personally I liked part of your proposal.. normally I would rather leave it
> > for later, but then it means we will be stuck with this incoming-fds API.
> > So I'll still leave the thoughts below for consideration.
> > 
> > In general, to me this is another requirement to specify migration
> > parameters during early boot.
> > 
> > We used to tackle with this problem a few times, in many cases by
> > reordering of initialization of the migration object, which can be error
> > prone.
> > 
> > We almost moved to another model where we moved some special migration
> > parameters out of the migration object, into some global variables instead,
> > then they're available since the start of QEMU.
> > 
> > Two examples I am aware of while looking at this (maybe more):
> > 
> > - The -only-migratable option
> > 
> >    This one used to be a "parameter-like" option, but then things broke, we
> >    moved to a global only_migratable variable, to make it available during
> >    early boot.
> > 
> >    Currently, it consumes a special option, QEMU_OPTION_only_migratable.
> > 
> > - The "mode" parameter (used by CPR-transfer)
> > 
> >    This one is literally a parameter even now, CPR-transfer needs it to be
> >    set even before loading of CPR channel, which is very, very early..
> > 
> >    It's done by quite a few complex steps:
> > 
> >    - hijacking -incoming parameter, in incoming_option_parse() we first
> >      allow setup of CPR channels,
> > 
> >    - then at cpr_state_load(), it consumes that channel when set, invoke
> >      cpr_set_incoming_mode(), which sets a magical global var ( :( ) called
> >      incoming_mode,
> > 
> >    - then, further hijack migrate_mode(), which normally should just fetch
> >      "mode" parameter from migration object, peek at incoming_mode first,
> >      when set, overwrite the "mode" parameter...
> > 
> > Now this is the third one: we actually want to have "local" parameter
> > available.
> > 
> > I wonder if we should just have some migration parameters to be special to
> > be set early, maintained in a single global place, then when creating
> > migration objects we should apply these to migration object, making sure
> > it's consistent.
> > 
> > We could actually reuse -incoming, so far it supprts:
> > 
> >    - "defer", as a string
> >    - URI, in form of (SOME_WORD:.*)
> >    - then we assume it's a channel
> > 
> > Since we already have defer, we could make a special case for it, say,
> >    -incoming config:key1=value1,key2=value2,...
> > 
> > With that, migration options can be set at boot and can be referenced
> > anytime, we don't need to worry on migration object init ordering.  We
> > could obsolete -only-migratable but allow:
> > 
> >    -incoming config:only-migrate=on
> > 
> > For CPR, to keep compatibility we still need to set mode=cpr-* silently,
> > but then we should be able to be able to reference any migration parameters
> > anytime, including local= now, removing incoming-fds TAP option.
> > 
> > I'm not sure if this is a good approach, but we can think about it.  I do
> > worry we have future demands on similar things, then we need to tackle it
> > sooner or later (we will want to stop introducing special parameters at
> > some point, like incoming-fds=on).
> > 
> > Thanks,
> > 
> 
> What make me doubt is asymmetry between outgoing and incoming config:
> 
> If we add early "local" parameter, which is set by
> "-incoming config:local=on", what about normal "local" parameter?

When creating the migration object, we should apply all those config:* to
it to keep it consistent.  Then the global can be released.

> 
> If we keep it as is, user may think, that config:local=on and setting
> local parameter are the same, and chose setting the parameter through
> QMP (which is bad for us)..

Yeah, in documents we need to mark -incoming config:* to be required for
use cases.  We can also mention that in the manual about the difference,
but I agree it's not easy to catch.

> 
> So, seems, local migration parameter and local early parameter should
> be different things.
> 
> Maybe, rename "local" parameter to "outgoing-local", and ignore it for
> incoming migration. And add "-incoming config:incoming-local=on", which
> produces "incoming-local" parameter, which may be set _only_ through
> "-incoming" option and cannot be set by migrate-set-parameters, to avoid
> any kind of misuse.
> 
> Doesn't look ideal :/ And it breaks the rule that migration parameters
> should be the same for source and target for migration to work properly.
> 
> 
> OK, the workaround is: keep "local" name for both "early" and "normal"
> versions of parameter, and add some checks:
> 
> - If user tries to set "local" parameter during incoming migration,
>   but "early local" is not set - fail
> 
> - If user tries to run incoming migration, when "early local" is set
>   but "normal local" is not - fail too
> 
> This way, the only possible and correct way to turn on local migration
> on target is to set both "early" and "normal" local parameter. Still,
> not ideal.

My goal is to make it really the same thing, no need to two "local"
parameters, no need to differenciate src/dst "local" parameters. They
should be the same. Just to provide a slightly cleaner way to let us not
worry about "whether migration object is created, and what's the order of
creation" kind of problems.

-- 
Peter Xu


