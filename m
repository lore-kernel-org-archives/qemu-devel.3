Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19818C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTzB-0004C1-65; Thu, 01 Aug 2024 07:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTz7-0004AM-PM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTz5-00034N-5l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722511717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDxUGggwXWhjZViKaa52XrXs/fzrEJLE9M/NPwvujOg=;
 b=N04jRzRFIEs2ysgVCBSH+vvB1Tw62RaN36No35gsRbu+q4cJaOENLosPuUfhNgW3DGuSfM
 t5jw5W73srwfDrNZs22yPOAjTPv9EncJfEZUos6uh5lfhqMJnwpDLer27fwxzg2VbZjRYZ
 dbgbk6Q9pDZs0J7kSHuwxd0g2+DHhRo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-UbpUzyWTMHCWhQlKJuqY3g-1; Thu,
 01 Aug 2024 07:28:34 -0400
X-MC-Unique: UbpUzyWTMHCWhQlKJuqY3g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0D291955F28; Thu,  1 Aug 2024 11:28:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B3419560AE; Thu,  1 Aug 2024 11:28:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6556C21E6692; Thu,  1 Aug 2024 13:28:27 +0200 (CEST)
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
In-Reply-To: <ZqtXP9MViOlyhEsu@intel.com> (Zhao Liu's message of "Thu, 1 Aug
 2024 17:37:03 +0800")
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
 <87bk2nnev2.fsf@pond.sub.org> <ZqEN1kZaQcuY4UPG@intel.com>
 <87le1psuv3.fsf@pond.sub.org> <ZqtXP9MViOlyhEsu@intel.com>
Date: Thu, 01 Aug 2024 13:28:27 +0200
Message-ID: <87mslweb38.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:

> On Thu, Jul 25, 2024 at 11:07:12AM +0200, Markus Armbruster wrote:
>> Date: Thu, 25 Jul 2024 11:07:12 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>>  object
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Hi Markus and Daniel,
>> >
>> > I have the questions about the -object per cache implementation:
>> >
>> > On Wed, Jul 24, 2024 at 02:39:29PM +0200, Markus Armbruster wrote:
>> >> Date: Wed, 24 Jul 2024 14:39:29 +0200
>> >> From: Markus Armbruster <armbru@redhat.com>
>> >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>> >>  object
>> >> 
>> >> Zhao Liu <zhao1.liu@intel.com> writes:
>> >> 
>> >> > Hi Markus,
>> >> >
>> >> > On Mon, Jul 22, 2024 at 03:37:43PM +0200, Markus Armbruster wrote:
>> >> >> Date: Mon, 22 Jul 2024 15:37:43 +0200
>> >> >> From: Markus Armbruster <armbru@redhat.com>
>> >> >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>> >> >>  object
>> >> >> 
>> >> >> Zhao Liu <zhao1.liu@intel.com> writes:
>> >> >> 
>> >> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> >> >> 
>> >> >> This patch is just documentation.  The code got added in some previous
>> >> >> patch.  Would it make sense to squash this patch into that previous
>> >> >> patch?
>> >> >
>> >> > OK, I'll merge them.
>> >> >
>> >> >> > ---
>> >> >> > Changes since RFC v2:
>> >> >> >  * Rewrote the document of smp-cache object.
>> >> >> >
>> >> >> > Changes since RFC v1:
>> >> >> >  * Use "*_cache=topo_level" as -smp example as the original "level"
>> >> >> >    term for a cache has a totally different meaning. (Jonathan)
>> >> >> > ---
>> >> >> >  qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>> >> >> >  1 file changed, 58 insertions(+)
>> >> >> >
>> >> >> > diff --git a/qemu-options.hx b/qemu-options.hx
>> >> >> > index 8ca7f34ef0c8..4b84f4508a6e 100644
>> >> >> > --- a/qemu-options.hx
>> >> >> > +++ b/qemu-options.hx
>> >> >> > @@ -159,6 +159,15 @@ SRST
>> >> >> >          ::
>> >> >> >  
>> >> >> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
>> >> >> > +
>> >> >> > +    ``smp-cache='id'``
>> >> >> > +        Allows to configure cache property (now only the cache topology level).
>> >> >> > +
>> >> >> > +        For example:
>> >> >> > +        ::
>> >> >> > +
>> >> >> > +            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
>> >> >> > +            -machine smp-cache=cache
>> >> >> >  ERST
>> >> >> >  
>> >> >> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
>> >> >> > @@ -5871,6 +5880,55 @@ SRST
>> >> >> >          ::
>> >> >> >  
>> >> >> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
>> >> >> > +
>> >> >> > +    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
>> >> >> > +        Create an smp-cache object that configures machine's cache
>> >> >> > +        property. Currently, cache property only include cache topology
>> >> >> > +        level.
>> >> >> > +
>> >> >> > +        This option must be written in JSON format to support JSON list.
>> >> >> 
>> >> >> Why?
>> >> >
>> >> > I'm not familiar with this, so I hope you could educate me if I'm wrong.
>> >> >
>> >> > All I know so far is for -object that defining a list can only be done in
>> >> > JSON format and not with a numeric index like a keyval based option, like:
>> >> >
>> >> > -object smp-cache,id=cache0,caches.0.name=l1i,caches.0.topo=core: Parameter 'caches' is missing
>> >> >
>> >> > the above doesn't work.
>> >> >
>> >> > Is there any other way to specify a list in command line?
>> >> 
>> >> The command line is a big, sprawling mess :)
>> >> 
>> >> -object supports either a JSON or a QemuOpts argument.  *Not* keyval!
>> >> 
>> >> Both QemuOpts and keyval parse something like KEY=VALUE,...  Keyval
>> >> supports arrays and objects via dotted keys.  QemuOpts doesn't natively
>> >> support arrays and objects, but its users can hack around that
>> >> limitation in various ways.  -object doesn't.  So you're right, it's
>> >> JSON or bust here.
>> >> 
>> >> However, if we used one object per cache instead, we could get something
>> >> like
>> >> 
>> >>     -object smp-cache,name=l1d,...
>> >>     -object smp-cache,name=l1u,...
>> >>     -object smp-cache,name=l2,...
>> >>     ...
>> >
>> > Current, I use -object to create a smp_cache object, and link it to
>> > MachineState by -machine,smp-cache=obj_id.
>> >
>> > Then for the objects per cache, how could I link them to machine?
>> >
>> > Is it possible that I create something static in smp_cache.c and expose
>> > all the cache information to machine through some interface?
>> 
>> Good questions.  However, before we head deeper into the weeds here, I
>> feel we should discuss the things below.  And before we do that, I need
>> a clear understanding of the use case.  Elsewhere in this thread, I just
>> described the use case as I understand it.  Please reply there.  I'll
>> then come back to this message.
>> 
>> [...]
>
> Jonathan and I provided different use cases for x86 and Arm. Could we
> come back here to continue the discussion? :)

Can you provide a brief summary of the design alternatives that have
been proposed so far?  Because I've lost track.


