Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ABEC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbI1-0000Af-Ib; Wed, 24 Jul 2024 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWbHg-0007sX-2w
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWbHW-0006Sb-KW
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721824782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4doG7FgGWPcNGWJJHJPJk0rNm/M14H0MAca/J2UMVFc=;
 b=UmY0IFfXm6IwxMnQgjyEBfV22SAU3KhypIqGlNhdu052JuWQYr+Se16qR6sLEjZHp6NPZ5
 rHUy9xpcqQf00tX6NYgGcpJaoCacmWTMd5q9MxqziK8zIYcyv3Waw52JMQKZW+RokIk0ZL
 v06ltIPHh352I1Hq4FIOmqv9BjSpLAk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-TcfKgXheMR-ID3bfodM32w-1; Wed,
 24 Jul 2024 08:39:39 -0400
X-MC-Unique: TcfKgXheMR-ID3bfodM32w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3672E1955D4A; Wed, 24 Jul 2024 12:39:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F367C1955E80; Wed, 24 Jul 2024 12:39:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0E0421E668A; Wed, 24 Jul 2024 14:39:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo
 Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Sia Jee Heng
 <jeeheng.sia@starfivetech.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,  Dapeng Mi
 <dapeng1.mi@linux.intel.com>,  Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache object
In-Reply-To: <Zp5vxtXWDeHAdPok@intel.com> (Zhao Liu's message of "Mon, 22 Jul
 2024 22:42:14 +0800")
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
Date: Wed, 24 Jul 2024 14:39:29 +0200
Message-ID: <87bk2nnev2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Markus,
>
> On Mon, Jul 22, 2024 at 03:37:43PM +0200, Markus Armbruster wrote:
>> Date: Mon, 22 Jul 2024 15:37:43 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>>  object
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> 
>> This patch is just documentation.  The code got added in some previous
>> patch.  Would it make sense to squash this patch into that previous
>> patch?
>
> OK, I'll merge them.
>
>> > ---
>> > Changes since RFC v2:
>> >  * Rewrote the document of smp-cache object.
>> >
>> > Changes since RFC v1:
>> >  * Use "*_cache=topo_level" as -smp example as the original "level"
>> >    term for a cache has a totally different meaning. (Jonathan)
>> > ---
>> >  qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 58 insertions(+)
>> >
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 8ca7f34ef0c8..4b84f4508a6e 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -159,6 +159,15 @@ SRST
>> >          ::
>> >  
>> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
>> > +
>> > +    ``smp-cache='id'``
>> > +        Allows to configure cache property (now only the cache topology level).
>> > +
>> > +        For example:
>> > +        ::
>> > +
>> > +            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
>> > +            -machine smp-cache=cache
>> >  ERST
>> >  
>> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
>> > @@ -5871,6 +5880,55 @@ SRST
>> >          ::
>> >  
>> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
>> > +
>> > +    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
>> > +        Create an smp-cache object that configures machine's cache
>> > +        property. Currently, cache property only include cache topology
>> > +        level.
>> > +
>> > +        This option must be written in JSON format to support JSON list.
>> 
>> Why?
>
> I'm not familiar with this, so I hope you could educate me if I'm wrong.
>
> All I know so far is for -object that defining a list can only be done in
> JSON format and not with a numeric index like a keyval based option, like:
>
> -object smp-cache,id=cache0,caches.0.name=l1i,caches.0.topo=core: Parameter 'caches' is missing
>
> the above doesn't work.
>
> Is there any other way to specify a list in command line?

The command line is a big, sprawling mess :)

-object supports either a JSON or a QemuOpts argument.  *Not* keyval!

Both QemuOpts and keyval parse something like KEY=VALUE,...  Keyval
supports arrays and objects via dotted keys.  QemuOpts doesn't natively
support arrays and objects, but its users can hack around that
limitation in various ways.  -object doesn't.  So you're right, it's
JSON or bust here.

However, if we used one object per cache instead, we could get something
like

    -object smp-cache,name=l1d,...
    -object smp-cache,name=l1u,...
    -object smp-cache,name=l2,...
    ...

>> > +
>> > +        The ``caches`` parameter accepts a list of cache property in JSON
>> > +        format.
>> > +
>> > +        A list element requires the cache name to be specified in the
>> > +        ``name`` parameter (currently ``l1d``, ``l1i``, ``l2`` and ``l3``
>> > +        are supported). ``topo`` parameter accepts CPU topology levels
>> > +        including ``thread``, ``core``, ``module``, ``cluster``, ``die``,
>> > +        ``socket``, ``book``, ``drawer`` and ``default``. The ``topo``
>> > +        parameter indicates CPUs winthin the same CPU topology container
>> > +        are sharing the same cache.
>> > +
>> > +        Some machines may have their own cache topology model, and this
>> > +        object may override the machine-specific cache topology setting
>> > +        by specifying smp-cache object in the -machine. When specifying
>> > +        the cache topology level of ``default``, it will honor the default
>> > +        machine-specific cache topology setting. For other topology levels,
>> > +        they will override the default setting.
>> > +
>> > +        An example list of caches to configure the cache model (l1d cache
>> > +        per core, l1i cache per core, l2 cache per module and l3 cache per
>> > +        socket) supported by PC machine might look like:
>> > +
>> > +        ::
>> > +
>> > +              {
>> > +                "caches": [
>> > +                   { "name": "l1d", "topo": "core" },
>> > +                   { "name": "l1i", "topo": "core" },
>> > +                   { "name": "l2", "topo": "module" },
>> > +                   { "name": "l3", "topo": "socket" },
>> > +                ]
>> > +              }
>> > +
>> > +        An example smp-cache object would look like:()
>> > +
>> > +        .. parsed-literal::
>> > +
>> > +             # |qemu_system| \\
>> > +                 ... \\
>> > +                 -object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}' \\
>> > +                 ...
>> >  ERST
>> 


