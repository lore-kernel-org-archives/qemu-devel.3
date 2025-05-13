Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F704C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEm0o-0005ZI-1b; Tue, 13 May 2025 05:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEm0l-0005Ym-Ns
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEm0j-00041K-Mx
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747128796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FSlig199wVoNbDgW3dvwZUsFQR5bFCcLzhfmn5TmBRM=;
 b=MtzlO7cx/FGWDWlQNnOjzbi3hnmy6IyrSO9+Ugr1YC3tHwIHYVPLtVCwR8WKMn96IV8szy
 UmVb2YNCm/GE2z5CzBG2+rjzIGT6KcrpcBz4QRzVEndlALRUVnoR9BWcwIuiKQfC/1f7S0
 C5WdRgRz8sTr3AlFoHHunhBRV7OklSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-926khPqKNyaih3aDkOWbew-1; Tue,
 13 May 2025 05:33:13 -0400
X-MC-Unique: 926khPqKNyaih3aDkOWbew-1
X-Mimecast-MFC-AGG-ID: 926khPqKNyaih3aDkOWbew_1747128790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF84E18004A7; Tue, 13 May 2025 09:33:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D703730001A1; Tue, 13 May 2025 09:32:50 +0000 (UTC)
Date: Tue, 13 May 2025 10:32:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
Message-ID: <aCMRvH0rWpWlgSNs@redhat.com>
References: <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <eedd1fa2-5856-41b8-8e6b-38bd5c98ce8f@nutanix.com>
 <87ecwshqj4.fsf@pond.sub.org>
 <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Tue, May 13, 2025 at 11:26:31AM +0200, BALATON Zoltan wrote:
> On Tue, 13 May 2025, Markus Armbruster wrote:
> > Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> > > On a related note this also brings us back to the discussion as to
> > > the relationship between qdev and QOM: at one point I was under the
> > > impression that qdev properties were simply QOM properties that were
> > > exposed externally, i.e on the commmand line for use with -device.
> > > 
> > > Can you provide an update on what the current thinking is in this
> > > area, in particular re: scoping of qdev vs QOM properties?
> > 
> > qdev is a leaky layer above QOM.
> > 
> > qdev properties are also QOM properties.
> > 
> > All device properties are exposed externally.
> 
> That was clear but the question was if QOM properties (that are not qdev
> properties) exist and if so are they also exposed? If not exposed it may be
> used for internal properties (where simpler solutions aren't convenient) but
> maybe qdev also adds easier definition of properties that's why they used
> instead of QOM properties?

NB, not everything we expose is a QDev. We directly expose QOM
via "-object" if they implement the 'UserCreatable' interface.
If we want internal properties, that should likely be wired in
to the QOM level directly.

Conceptually you could even say that everything QEMU creates should
live under -object, and no other args ought to need to exist. We have
decades of evolved code making that impractical though.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


