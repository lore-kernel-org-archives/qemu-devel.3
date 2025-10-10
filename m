Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC566CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GEX-0005yp-Kc; Fri, 10 Oct 2025 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7GEV-0005yE-9B
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7GEJ-00042L-A2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760114660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YDyHejTn1jlAetzlkHAFaynnWYwKjOLKrEr7EqSBqxw=;
 b=R7DmyA8cZkXCLSxC/fMCwD6voBHDYOvpiMr6zwsA3WfdM+lhouHNW3nf5G3KPvWV+CEFDk
 fgl9P6EOjtfxLSnzjtpNOE/k//NCLNYuJ6PZ/Y7mN2i8sFRJJ2+zGGLD635+4d/TZ2/5c1
 wlDZWouKN5mrQf3cTEAxSh818C6dTSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-5VW8evxTNmi4tcbT7e8FSA-1; Fri,
 10 Oct 2025 12:44:17 -0400
X-MC-Unique: 5VW8evxTNmi4tcbT7e8FSA-1
X-Mimecast-MFC-AGG-ID: 5VW8evxTNmi4tcbT7e8FSA_1760114654
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC6911800576; Fri, 10 Oct 2025 16:44:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2851B1800446; Fri, 10 Oct 2025 16:44:03 +0000 (UTC)
Date: Fri, 10 Oct 2025 17:44:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, prapal@linux.microsoft.com,
 prapal@microsoft.com, Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
Message-ID: <aOk1kXZlKDk5piir@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
 <871pnahn2f.fsf@pond.sub.org>
 <e1424616-5bac-4809-a70c-63805b1db893@redhat.com>
 <20251010163312.GA2896568@liuwe-devbox-debian-v2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010163312.GA2896568@liuwe-devbox-debian-v2.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 04:33:12PM +0000, Wei Liu wrote:
> On Fri, Oct 10, 2025 at 04:10:43PM +0200, Paolo Bonzini wrote:
> > On 10/10/25 16:02, Markus Armbruster wrote:
> > > > +{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
> > > 
> > > Mirrors query-kvm.  Okay apart from the Since: issues Daniel pointed
> > > out.
> > 
> > Which I swore I had fixed, but didn't.
> > 
> > > Should we have a generic query-accelerator instead of one query-FOO for
> > > every accelerator FOO?
> > If we want it, it should be query-accelerators with return value {"enabled":
> > "Accelerator", "present": ["Accelerator"]}.
> > 
> > The patch is already merged, but it is pretty self-contained so I have no
> > objection to reverting just this one.
> > 
> 
> Using a generic query-accelerator API should be fine.
> 
> As I understand it, We need this to query MSHV support in libvirt, so we
> need to get this correct before the libvirt patches are merged.
> 
> Just let us know how to proceed.

On the libvirt side, we're happy to deal with either query-mshv/kvm/etc
or a generator query-accelerator.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


