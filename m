Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12816E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDx9-0004y9-2d; Fri, 10 Jan 2025 07:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWDx0-0004GS-0T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWDwx-00041w-AV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736511433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G8F+cM0o0ec8FPrXFb3A/imTvNM7oVk4+RjgjDNH858=;
 b=bZfuG0VojKh+6XxzP9mzIT3mJdPEq1aKmULy1/ngHGrb2nuOJCL00g/Ruequw+dTtU75uC
 sf3hlXnNKPdMJ7Ki08g711G1xgyvQOjVMbgsobDW97V1UphzmTuMYdAC0KRD3BKtzOrO1g
 hqVPKU8jpQqAaDvcRXQ3mXFbeq5bRDE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-HH1qhlw3OH2UjBJ4HeCbbg-1; Fri,
 10 Jan 2025 07:17:10 -0500
X-MC-Unique: HH1qhlw3OH2UjBJ4HeCbbg-1
X-Mimecast-MFC-AGG-ID: HH1qhlw3OH2UjBJ4HeCbbg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19C8A1955D80; Fri, 10 Jan 2025 12:17:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DA5919560AD; Fri, 10 Jan 2025 12:17:00 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:16:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
Message-ID: <Z4EPuISnjKJ-P0j2@redhat.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
 <Z4D_zK-QIN07EXR5@redhat.com>
 <65364ac5-3d8e-4f43-a371-4661bf8b5437@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65364ac5-3d8e-4f43-a371-4661bf8b5437@daynix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 08:31:57PM +0900, Akihiko Odaki wrote:
> On 2025/01/10 20:09, Daniel P. Berrangé wrote:
> > On Wed, Jan 08, 2025 at 03:17:51PM +0900, Akihiko Odaki wrote:
> > > Accept bool literals for OnOffAuto properties for consistency with bool
> > > properties. This enables users to set the "on" or "off" value in a
> > > uniform syntax without knowing whether the "auto" value is accepted.
> > > This behavior is especially useful when converting an existing bool
> > > property to OnOffAuto or vice versa.
> > 
> > Again, to repeat my previous feedback, OnOffAuto is a well defined
> > QAPI type - making it secretly accept other values/types behind
> > the scenes which are not visible in QAPI scheme is not acceptable.
> > 
> > Effectively this is a backdoor impl of a QAPI alternate
> > 
> >    { 'alternate': 'OnOffAutoOrBool',
> >      'data': {
> >        'o': 'OnOffAuto',
> >        'b': 'bool'
> >      }
> >    }
> > 
> > except this isn't permitted as the QAPI generator explicitly blocks
> > use of alternate when the two branches are 'bool' and 'enum'.
> 
> The QAPI generator specifically blocks the case where the enum contains 'on'
> or 'off'.
> 
> > 
> > I'm assuming this is because in the QemuOpts scenario, it cannot
> > guess upfront whether the input is a bool or enum. This is unfortunate
> > though, because at the JSON visitor level it is unambiguous.
> 
> It's probably for the command line and possibly HMP.
> 
> > 
> > I wonder if the QAPI generator could be relaxed in any viable way ?
> It will make the interpretation of 'on' and 'off' on the command line
> ambigious; it can be either of OnOffAuto or bool.

The ambiguity would not neccessarily matter from a functional POV
though.

The consumer of an "OnOffAutoOrBool" field, would likely want to apply
logic to collapse it into just "OnOffAuto". As such, whether "on" is
parsed as a enum value or a bool value would have no functional
difference in the end. The OnOffAutoOrBool is essentially there to
just make sure we clearly express our input schema.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


