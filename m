Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846CDC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDGw-0001q2-JE; Mon, 13 Jul 2026 05:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDGl-0001oX-K4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDGj-0003g4-1Z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783936087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f7npngFV1AQ2QwhoSPTXSrhzAwvyxpkZUaMlsdowmIw=;
 b=BzTiiwdZo9caEy3p1hj4NsQ3fvim4CxlHnbrpIi19A8nzkhdeNf2qV9sQcNSR+H78wgGOo
 4NmqxRt/tS2Rsc6Dco4Jv52dEKnMVeMu25JKfaNP09hsSdxcT8CzLb6ZICtFnimfkkXK/7
 8fcrtxtmNrEn8cdly/XU7lQ+MStSH8k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-2WXUjvIHNqGIPGVhxRUOPw-1; Mon,
 13 Jul 2026 05:48:05 -0400
X-MC-Unique: 2WXUjvIHNqGIPGVhxRUOPw-1
X-Mimecast-MFC-AGG-ID: 2WXUjvIHNqGIPGVhxRUOPw_1783936083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79E7D18052F2; Mon, 13 Jul 2026 09:48:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA4BC195604B; Mon, 13 Jul 2026 09:47:52 +0000 (UTC)
Date: Mon, 13 Jul 2026 10:47:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, jasowang@redhat.com,
 mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sergio Lopez <slp@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 "open list:Incompatible changes" <devel@lists.libvirt.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:e500" <qemu-ppc@nongnu.org>,
 "open list:Microchip PolarFi..." <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v18 03/14] net/tap: deprecate "no" as special value for
 script/downscript
Message-ID: <alS0RZqeyEOVy6e8@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-4-vsementsov@yandex-team.ru>
 <87ech7uycy.fsf@pond.sub.org>
 <d1ea2c42-7990-4529-b9f8-d0d9e35ffd51@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1ea2c42-7990-4529-b9f8-d0d9e35ffd51@yandex-team.ru>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 12:37:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.07.26 10:45, Markus Armbruster wrote:
> > Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> > 
> > > The interface is ambiguous, as "no" is valid file name. So,
> > > using "no" as a special value to disable script is deprecated.
> > > Use an empty string ("script=" / "downscript=") instead.
> > > 
> > > In a future version, "no" will be treated as a plain file name, just
> > > like any other non-empty value.
> > > 
> > > Document the deprecation in docs/about/deprecated.rst, qapi/net.json,
> > > and qemu-options.hx. Update other docs to use empty string instead of
> > > "no". Add a warning.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > [...]
> > 
> > > diff --git a/net/tap.c b/net/tap.c
> > > index fedd48c48d2..1ec9e5ebe6f 100644
> > > --- a/net/tap.c
> > > +++ b/net/tap.c
> > > @@ -103,6 +103,8 @@ static bool tap_is_explicit_no_script(const char *script_arg)
> > >       }
> > >       if (strcmp(script_arg, "no") == 0) {
> > > +        warn_report("script=no/downscript=no is deprecated; "
> > > +                    "use script=/downscript= instead");
> > 
> > net_init_tap() could pass the parameter name for a simpler error
> > message.  Probably not worth the bother.
> > 
> > >           return true;
> > >       }
> > 
> > In net_init_tap_one():
> > 
> >             qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
> >                               script ?: "no", downscript ?: "no");
> > 
> > This sets nc->info_str, which is shown by "info network".  Should we
> > replace "no" by ""?
> > 
> 
> Agree, will do.

Would it be better to not include the script/downscript parameters at
all if they're disabled ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


