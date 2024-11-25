Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C52D3B7FF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 10:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWJP-0001vS-3O; Mon, 25 Nov 2024 05:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFWJN-0001vC-CC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFWJL-0002zb-CQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732530436;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC32yhFCH3PE4V5dxaO3oTrUUjpWSd9JDUa6laDXrt4=;
 b=dEPC+0ZSxjDdzut8jOX8pYWF0WrhemTEa3Z0LPxCmWEwNbCh6mDwQhmtcq/zdQ8qz4+7Yl
 vMr27NwBg+SWdWiPrOL0TBJwYjwc+h9jOatlKbP2uXdlDGYyqbdY8vOt+zT6YNEnl8Hbe7
 eL3G9OevQPoBu1UvINTlIsyPRKqLxfQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-Kjo7e13ENVG1GGjIZnRejw-1; Mon,
 25 Nov 2024 05:27:14 -0500
X-MC-Unique: Kjo7e13ENVG1GGjIZnRejw-1
X-Mimecast-MFC-AGG-ID: Kjo7e13ENVG1GGjIZnRejw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84D5C19560AF; Mon, 25 Nov 2024 10:27:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9EB30000DF; Mon, 25 Nov 2024 10:27:10 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:27:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] hw/i386: define _AS_LATEST() macros for machine types
Message-ID: <Z0RQ-uM6czdfI-cT@redhat.com>
References: <20240910163041.3764176-1-berrange@redhat.com>
 <ZxaXYjG_lMqUuWUy@redhat.com> <87zflnliq5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zflnliq5.fsf@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 25, 2024 at 11:18:26AM +0100, Cornelia Huck wrote:
> On Mon, Oct 21 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > Ping: for the x86 maintainers.
> 
> ...has anything ever happened with this patch? It's machine type
> creation time again, and it would probably make sense for me to do the
> 10.0 machine types on top of this.

Still not picked up by the x86 maintainers :-(

I'd suggest you just put it at the start of your 10.0 series.

> 
> >
> > On Tue, Sep 10, 2024 at 05:30:41PM +0100, Daniel P. Berrangé wrote:
> >> Follow the other architecture targets by adding extra macros for
> >> defining a versioned machine type as the latest. This reduces the
> >> size of the changes when introducing new machine types at the start
> >> of each release cycle.
> >> 
> >> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> ---
> >> 
> >> In v2:
> >> 
> >>  - Rebased on top of new 9.2 machine types
> >> 
> >>  hw/i386/pc_piix.c    | 11 +++++------
> >>  hw/i386/pc_q35.c     | 11 ++++++-----
> >>  include/hw/i386/pc.h |  4 +++-
> >>  3 files changed, 14 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >> index 2bf6865d40..4953676170 100644
> >> --- a/hw/i386/pc_piix.c
> >> +++ b/hw/i386/pc_piix.c
> >> @@ -446,7 +446,10 @@ static void pc_i440fx_init(MachineState *machine)
> >>  }
> >>  
> >>  #define DEFINE_I440FX_MACHINE(major, minor) \
> >> -    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, major, minor);
> >> +    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, false, NULL, major, minor);
> >> +
> >> +#define DEFINE_I440FX_MACHINE_AS_LATEST(major, minor) \
> >> +    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, true, "pc", major, minor);
> >>  
> >>  static void pc_i440fx_machine_options(MachineClass *m)
> >>  {
> >> @@ -477,17 +480,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >>  static void pc_i440fx_machine_9_2_options(MachineClass *m)
> >>  {
> >>      pc_i440fx_machine_options(m);
> >> -    m->alias = "pc";
> >> -    m->is_default = true;
> >>  }
> >>  
> >> -DEFINE_I440FX_MACHINE(9, 2);
> >> +DEFINE_I440FX_MACHINE_AS_LATEST(9, 2);
> >>  
> >>  static void pc_i440fx_machine_9_1_options(MachineClass *m)
> >>  {
> >>      pc_i440fx_machine_9_2_options(m);
> >> -    m->alias = NULL;
> >> -    m->is_default = false;
> >>      compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
> >>      compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
> >>  }
> >> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> >> index 8319b6d45e..42bdedbaa4 100644
> >> --- a/hw/i386/pc_q35.c
> >> +++ b/hw/i386/pc_q35.c
> >> @@ -327,10 +327,13 @@ static void pc_q35_init(MachineState *machine)
> >>  }
> >>  
> >>  #define DEFINE_Q35_MACHINE(major, minor) \
> >> -    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, major, minor);
> >> +    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor);
> >> +
> >> +#define DEFINE_Q35_MACHINE_AS_LATEST(major, minor) \
> >> +    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, "q35", major, minor);
> >>  
> >>  #define DEFINE_Q35_MACHINE_BUGFIX(major, minor, micro) \
> >> -    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, major, minor, micro);
> >> +    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor, micro);
> >>  
> >>  static void pc_q35_machine_options(MachineClass *m)
> >>  {
> >> @@ -359,15 +362,13 @@ static void pc_q35_machine_options(MachineClass *m)
> >>  static void pc_q35_machine_9_2_options(MachineClass *m)
> >>  {
> >>      pc_q35_machine_options(m);
> >> -    m->alias = "q35";
> >>  }
> >>  
> >> -DEFINE_Q35_MACHINE(9, 2);
> >> +DEFINE_Q35_MACHINE_AS_LATEST(9, 2);
> >>  
> >>  static void pc_q35_machine_9_1_options(MachineClass *m)
> >>  {
> >>      pc_q35_machine_9_2_options(m);
> >> -    m->alias = NULL;
> >>      compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
> >>      compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
> >>  }
> >> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> >> index 14ee06287d..890427c56e 100644
> >> --- a/include/hw/i386/pc.h
> >> +++ b/include/hw/i386/pc.h
> >> @@ -320,7 +320,7 @@ extern const size_t pc_compat_2_3_len;
> >>      } \
> >>      type_init(pc_machine_init_##suffix)
> >>  
> >> -#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, ...) \
> >> +#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
> >>      static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
> >>          MachineState *machine) \
> >>      { \
> >> @@ -334,6 +334,8 @@ extern const size_t pc_compat_2_3_len;
> >>          MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
> >>          mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
> >>          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
> >> +        mc->is_default = isdefault; \
> >> +        mc->alias = malias; \
> >>      } \
> >>      static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
> >>      { \
> >> -- 
> >> 2.43.0
> >> 
> >
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


