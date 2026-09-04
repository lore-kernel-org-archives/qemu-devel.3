Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC53C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SE6-00054m-3J; Fri, 04 Sep 2026 07:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2SE4-00054K-6n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2SE2-0007VO-AY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788521812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ty9G3jdjTov5BZ1GA227LSBcLNkdQuFwOl50sXc+QvI=;
 b=KIbzBM7k/7wk+e2U5y36TnJ+gitJn4guzI3ZVzQmVOKTTZxwolWjrTsuBZOckYRHEuSspN
 IRyGT+lKypy4qWNTQOc+3tMQYKxQNUhJxmCxz+VrY/UDMd7K8bGbdHwVmXK8yAXD0YMe2I
 3Y3H+Q7hPz+KOahCPB759D5PMbgFNqI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-O8r4VhskPn6F5lQLEqng-Q-1; Fri,
 04 Sep 2026 07:36:49 -0400
X-MC-Unique: O8r4VhskPn6F5lQLEqng-Q-1
X-Mimecast-MFC-AGG-ID: O8r4VhskPn6F5lQLEqng-Q_1788521808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A1E01955DBA; Fri,  4 Sep 2026 11:36:47 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF9691800598; Fri,  4 Sep 2026 11:36:44 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:36:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Message-ID: <apqtSjY4MLwRIcJq@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <apqTS3HjhLxF7ond@redhat.com> <878q5h8di4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q5h8di4.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 04, 2026 at 01:25:23PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Sep 04, 2026 at 04:58:10PM +0800, Yonggang Luo wrote:
> >> Device filtering would be complicated, I guess, as there is so much
> >> CONFIG_* for devices. Another approach is to just place devices under an
> >> meson "enable_modules "  (in *.so/*.dll/*.dylib), so it won't be
> >> listed(memory consumption will also be reduced when it's not needed).
> >
> > While modules are important for reducing memory consumption, I don't think
> > they need to be a blocker - making more things into modules can be done
> > in the backaround as & when people want to work on it.
> 
> I fear modules need serious work to before we can use them more widely.
> I described issues in
> 
>     Subject: Dynamic & heterogeneous machines, initial configuration: problems
>     Date: Wed, 31 Jan 2024 21:14:21 +0100
>     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> Copy of relevant part:
> 
> = Problem 3: Loadable modules =
> 
> QOM wasn't designed for loadable modules.  Support for them was grafted
> on, and there are serious deficiencies.
> 
> Building a loadable module results in a DSO.  Additionally, module
> meta-data necessary to load it is compiled into the executables that can
> load modules.  Actually loading a module can fail, e.g. when the module
> was not deployed.
> 
> Loadable modules are designed to be transparent, i.e. users don't need
> to know whether a module is compiled in or loadable.
> 
> QOM types don't exist until the module is initialized.  Compiled-in
> modules are initialized early in startup.  Loadable modules are
> initialized on load.
> 
> QMP command qom-list-types returns all QOM types.  To be able to find
> them all, it needs to load all modules.  Modules that cannot be found
> (or have dependencies that cannot be found) are silently ignored.  Any
> other loading errors are reported to stderr with error_report_err(),
> which is inappropriate.  In either case, the types provided by the
> unloadable modules are not returned by the command.
> 
> We have two functions to look up an object class by name:
> object_class_by_name() and module_object_class_by_name().  The latter
> attempts to load a module when the type doesn't exist.  Again, modules
> that cannot be found are silently ignored, and other loading errors are
> reported with error_report_err(), which is inappropriate in certain
> contexts.
> 
> When to use which of the two functions is unclear.  Existing usage may
> well be wrong.
> 
> The QOM functions to create objects in-place (object_initialize(), ...)
> or on the heap (object_new(), ...) cannot fail.  This is just fine in
> QOM's original design.  It is not fine when a loadable module fails to
> load.  Since the functions can't fail, they exit(1) then.
> 
> This means things like a hot plugging a device provided by a loadable
> module can crash a VM immediately.

The object_new() side effect is unpleasant, but we're not all that
far away from avoiding the crash on device hotplug AFAICT.

qdev_device_add_from_qdict() will call qdev_get_device_class() and
if that returns NULL will gracefully return the error to the client.

qdev_get_device_class() will call module_object_class_by_name()
which triggers module loading and can return NULL if loading
fails. Unfortnuately it throws away the error message, and
qdev_get_device_class() doesn't appear to handle NULL correctly
in all scenarios. It is not that far away from being able to
handle module load failures correctly though AFAICS.

The unpleasant bit is that we would need to audit other QMP entry
points that can trigger module loading, and ensure they all trigger
module loading prior to object_new(), and perhaps most importantly
have a way to test this in functional tests. Without the latter
we'll surely bit-rot this subtle edgecase.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


