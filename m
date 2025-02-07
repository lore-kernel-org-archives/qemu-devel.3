Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9FC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNke-00078Y-5L; Fri, 07 Feb 2025 07:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgNkW-000786-7X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgNkT-0004pU-Pm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738932379;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2Dwi8xQx4aXnLeXkbpSVcaLs+GuQB6BpBjjAHMiHyLk=;
 b=QxEbHDJaegTLMYdUKzKd6Y59EX5cvOXgIVCh+dknj506gXtD01/NHzHBI29XHg2V8GXzI/
 zD6YT5KdjyXVctlgG+TVKlrMTXVUabbnerOpeR2FzemKn5xTuw4NFYD7g38+exjZ79oDiX
 MZag4kJXe3tvOr0Bk/grXGxSgDFwwu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-oSBFDFteO260X7Tu0sgWaQ-1; Fri,
 07 Feb 2025 07:46:16 -0500
X-MC-Unique: oSBFDFteO260X7Tu0sgWaQ-1
X-Mimecast-MFC-AGG-ID: oSBFDFteO260X7Tu0sgWaQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2491C180087D; Fri,  7 Feb 2025 12:46:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1598A1800265; Fri,  7 Feb 2025 12:46:04 +0000 (UTC)
Date: Fri, 7 Feb 2025 12:46:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
Message-ID: <Z6YAiQ_Rz82IMYu0@redhat.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
 <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
 <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
 <79fea08e-21d0-46ba-923d-8892eef3ce8e@daynix.com>
 <878qqihr64.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qqihr64.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 07, 2025 at 01:31:47PM +0100, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
> [...]
> 
> > Let me go back to the discussion of the bool/OnOffAuto problem below:
> >
> > The values the command line syntax accepts are on/yes/true/y and off/no/false/n.
> >
> > For the command line syntax, you can always use on/off whether the type is bool or OnOffAuto. In my opinion, it is still not good to reject yes/true/y and no/false/n for OnOffAuto; why do we suddenly reject them when the property gets the "auto" value? As you pointed out, the usage of enum is our internal concern and should not bother users.
> 
> The command line is a different mess.
> 
> For better or worse (worse if you ask me), we added code to accept
> additional syntax for bool values.
> 
> Doing the same for enums that happen to have some values that look
> boolean at a glance is in my opinion a terrible idea.  We have at least
> two: OnOffAuto and OnOffSplit.
> 
> But let's get back to QMP.

Before we get back to QMP I should point out that our current HMP bool /
OnOffAuto properties are a significant developer foot-gun in terms of
back compat.

Though I'm struggling to find the examples, I'm pretty sure I've seen
patches where we converted a property from bool to OnOffAuto, with the
developer (likely) thinking it was back-compatible.

It does have the illusion of being compatible given that the HMP bool
syntax is accepting 'on/off' (especially when our usage examples often
on/off rather than yes/no/true/false) values ... very much not the
case for QMP though.

This does make me really want the idea of an "alternate" in QMP that
can be made to work for scalars.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


