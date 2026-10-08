Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142C5CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkYR-0002Rk-W7; Thu, 08 Oct 2026 05:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkYP-0002R5-PI
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkYN-0004OK-09
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791452201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsS0Chl/KA5ceYU/kfxsYTHzuQjYvLUnD7UDhqYaDvI=;
 b=XRSkjmmou7Drir0ckqb7w0aRdm3uHTAL7iNwpM/bidv/UuX3zQL21WPiZ2lRWdijfxicFW
 8WJHBaVIuztEXsXrBKQW7jX0FkZ+0NCyRWs1zKcXjfBK8Wwzb5rDHk7Au8p/r+8T7rABO6
 OSsuKXbqTKsc+5eBz8rCh+HtzDjp+lI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-Jy2fAp8AMDq5euAPviHQ3w-1; Thu,
 08 Oct 2026 05:36:37 -0400
X-MC-Unique: Jy2fAp8AMDq5euAPviHQ3w-1
X-Mimecast-MFC-AGG-ID: Jy2fAp8AMDq5euAPviHQ3w_1791452195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E348919540DF; Thu,  8 Oct 2026 09:36:33 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8595C18002B7; Thu,  8 Oct 2026 09:36:26 +0000 (UTC)
Date: Thu, 8 Oct 2026 10:36:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
Message-ID: <asdkF80SJzF2W3sD@redhat.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 07, 2026 at 05:00:06PM -0700, Pierrick Bouvier wrote:
> On 10/7/2026 2:42 PM, Yonggang Luo wrote:
> > On Thu, Oct 8, 2026 at 4:44 AM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> >>> Change TypeInfo.is_available to the new TypeIsAvailable type, which
> >>> takes a const TargetInfo *. Registration passes target_info(), so
> >>> behavior is unchanged. object.h only forward-declares TargetInfo.
> >>>
> >>> Switch the existing users (raspi, raspi4b, ast27x0 evb and fc) and the
> >>> generated machine parents to the matching target_is_<arch> helpers.
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>  hw/arm/aspeed_ast27x0-fc.c  |  2 +-
> >>>  hw/arm/aspeed_ast27x0_evb.c |  4 ++--
> >>>  hw/arm/raspi.c              |  4 ++--
> >>>  hw/arm/raspi4b.c            |  2 +-
> >>>  hw/arm/virt.c               |  4 ++--
> >>>  hw/m68k/virt.c              |  4 ++--
> >>>  hw/or1k/virt.c              |  2 +-
> >>>  include/qom/object.h        | 12 +++++++++++-
> >>>  qom/object.c                |  3 ++-
> >>>  9 files changed, 24 insertions(+), 13 deletions(-)

snip

> >>> @@ -167,7 +168,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
> >>>          abort();
> >>>      }
> >>>
> >>> -    if (info->is_available && !info->is_available()) {
> >>> +    if (info->is_available && !info->is_available(target_info())) {
> >>>          return NULL;
> >>>      }
> >>>
> >>
> >> ```
> >> info->is_available(target_info())
> >> ```
> >>
> >> or
> >>
> >> ```
> >> is_available() {
> >>   TargetInfo ti * = target_info();
> >>   ...
> >> }
> >> ```
> >>
> >> Are doing the exact same thing today.
> >>
> >> So what is the future goal requiring to introduce this?
> > 
> > From Daniel P. Berrangé's
> > requesthttps://lore.kernel.org/qemu-devel/apAszS1ewxM0Y1XU@redhat.com/
> >         I forgot to mention that this is also pretty important for making
> >         introspection work, as we need to be able to say
> > 
> >           'qemu-system --machine none -qmp ...'
> > 
> >         and connect to QMP to introspect the binary. Having to add a
> >         '--target <name>' into that mix is undesirable, as it creates
> >         a chicken & egg problem. You don't know what targets are built
> >         into qemu-system without introspecting it and you can't
> >         introspect it without selecting a target to introspect.
> > 
> > From Pierrick's review
> > https://lore.kernel.org/qemu-devel/557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com/So,
> > for existing binary: -M virt works as before.
> > 
> >         For new multi binary:
> >         $ qemu-system -M virt:
> >         Multiple machines were found, select one among:
> >         - aarch64-virt
> >         - riscv64-virt
> > 
> >         Does it matches what you would expect?
> > 
> > From Daniel's review
> > https://lore.kernel.org/qemu-devel/aro93NuZBXYGbD33@redhat.com/
> >         We already have  'QemuTargetInfo' struct which is used
> >         with 'query-target', that should also be used with the
> >         new 'query-targets' command.
> > 
> >         We need to add the 'endianness' field to QemuTargetInfo.
> > 
> >         I don't think that we need to report machines though.
> >         We already have 'query-machines' which gives much broader
> >         information on the machines. "MachineInfo" needs to
> >         gain
> > 
> >         "targets": ["SysEmuTarget"]
> > 
> >         to list which target(s) a machine can be used with.
> > 
> > 
> > To achieve these, we needs add TypeInfo parameter to it so that we can do
> > 
> > static void report_unsupported_machine_type(const char *name, Error **errp)
> > {
> >     g_autoptr(GSList) machines = machine_class_get_list(true);
> >     g_autoptr(GString) targets = g_string_new(NULL);
> >     TargetInfoNode *node;
> >     GSList *el;
> > 
> >     error_setg(errp, "unsupported machine type: \"%s\" for target \"%s\"",
> >                name, target_name());
> >     QLIST_FOREACH(node, target_info_list(), next) {
> >         for (el = machines; el; el = el->next) {
> >             MachineClass *mc = el->data;
> > 
> >             if ((!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) &&
> >                 object_class_get_is_available(OBJECT_CLASS(mc))(node->info)) {
> >                 g_string_append_printf(targets, "  %s\n",
> >                                        node->info->target_name);
> >                 break;
> >             }
> >         }
> >     }
> >     if (targets->len) {
> >         error_append_hint(errp, "Available for targets:\n%s", targets->str);
> >     }
> > }
> > 
> > That is we can iterate on all target-list, and check if it's can be fitlered.
> >
> 
> Ok, I finally see where this is going.
> 
> So, based on all the previous conversations, we agreed to have a
> qemu-system binary with all the QOM types available (for all targets).

ack.

> I personally think that if we go this way, we should not have any
> -target option, and even less a -target none option.

If we don't have a compelling need for -target to exist now, then
dropping it as a concept is good.

> The current is_available() approach was made with filtering per target
> in mind, which predates where things are now. So, it's a good time to
> reevaluate how to do it.
> 
> This leaves us with (at least) two options:
> - keep the callback and add TargetInfo parameter (what is done here)
> - remove is_available, and adopt a more declarative approach
> 
> How about we (re)-explore the second one?
> 
> It's what we did in the past
> (https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4de1878486c16d73e),
> and that I removed recently, in favor of is_available.
> My rationale was that it was incomplete, since we needed to filter types
> per config also, and not only target.
> Now that direction is to not filter anything, filter per config is
> unneeded, and switching back to declarative instead of callback makes
> total sense. Using interfaces like we did has its own issues, and I
> would not like to see this coming back.
> 
> I'll do one very concrete proposal:
> 
> ```
> How about letting machines (and machines only first), have a new field
> 'targets', being a uint32_t mask with an array of EMU_TARGET?
> machine->targets = EMU_TARGET_X | EMU_TARGET_Y;
> ```
> 
> @Daniel, IIUC, this is exactly the approach you proposed a few weeks
> ago, just before I got frustrated and lost my patience against you. I
> think it's more clear for me where you wanted to go. Sorry it took such
> a large detour.

Not a problem. We were coming at the debate with different ideas of
where we were heading, so talking past each other at times.

> 
> Yonggang, does that sounds good for you?
> Daniel, does that sounds good for you also?

Works for me.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


