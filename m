Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668A5C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxkT-0005b3-I5; Wed, 20 Mar 2024 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxkS-0005al-77
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxkQ-0001T0-9I
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710948057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dF9CCaaEdhClCGSB3+SIvhPc8jonNw0nYKj1rBybd68=;
 b=BgXRF0FudtOTp1TSQroNjQ2gOhJJ/lJ5JZRp4QRZuUeAxWEFoMaX1ll/KnkZHHC/2R+dy2
 Uuz5R5k/m/fcKQJlmVyEAA0+lCzyH3VGAoFXFrsvOG+JgvkAvrKT5tvwbmcgeYIHl4vFEF
 iGmafHFSV0/WtkbOPk4IWtji/8P+SUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-KuGOTxGnOLKNBaI1Bw7kqA-1; Wed, 20 Mar 2024 11:20:53 -0400
X-MC-Unique: KuGOTxGnOLKNBaI1Bw7kqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64EA8101A523;
 Wed, 20 Mar 2024 15:20:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4032B10E47;
 Wed, 20 Mar 2024 15:20:51 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:20:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <Zfr-zT4eTi64TwiV@redhat.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com>
 <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 03:02:59PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: Wednesday, March 20, 2024 6:42 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: peterx@redhat.com; farosas@suse.de; qemu-devel@nongnu.org;
> > hao.xiang@bytedance.com; bryan.zhang@bytedance.com; Zou, Nanhai
> > <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
> > qpl compression
> > 
> > On Wed, Mar 20, 2024 at 12:45:25AM +0800, Yuan Liu wrote:
> > > the qpl initialization includes memory allocation for compressed
> > > data and the qpl job initialization.
> > >
> > > the qpl initialization will check whether the In-Memory Analytics
> > > Accelerator(IAA) hardware is available, if the platform does not
> > > have IAA hardware or the IAA hardware is not available, the QPL
> > > compression initialization will fail.
> > >
> > > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > > ---
> > >  migration/multifd-qpl.c | 243 +++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 242 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > > index 056a68a060..6de65e9da7 100644
> > > --- a/migration/multifd-qpl.c
> > > +++ b/migration/multifd-qpl.c
> > > @@ -9,12 +9,253 @@
> > >   * This work is licensed under the terms of the GNU GPL, version 2 or
> > later.
> > >   * See the COPYING file in the top-level directory.
> > >   */
> > > +
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/module.h"
> > > +#include "qapi/error.h"
> > > +#include "migration.h"
> > > +#include "multifd.h"
> > > +#include "qpl/qpl.h"
> > > +
> > > +typedef struct {
> > > +    qpl_job **job_array;
> > > +    /* the number of allocated jobs */
> > > +    uint32_t job_num;
> > > +    /* the size of data processed by a qpl job */
> > > +    uint32_t data_size;
> > > +    /* compressed data buffer */
> > > +    uint8_t *zbuf;
> > > +    /* the length of compressed data */
> > > +    uint32_t *zbuf_hdr;
> > > +} QplData;
> > > +
> > > +static void free_zbuf(QplData *qpl)
> > > +{
> > > +    if (qpl->zbuf != NULL) {
> > > +        munmap(qpl->zbuf, qpl->job_num * qpl->data_size);
> > > +        qpl->zbuf = NULL;
> > > +    }
> > > +    if (qpl->zbuf_hdr != NULL) {
> > > +        g_free(qpl->zbuf_hdr);
> > > +        qpl->zbuf_hdr = NULL;
> > > +    }
> > > +}
> > > +
> > > +static int alloc_zbuf(QplData *qpl, uint8_t chan_id, Error **errp)
> > > +{
> > > +    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
> > > +    uint32_t size = qpl->job_num * qpl->data_size;
> > > +    uint8_t *buf;
> > > +
> > > +    buf = (uint8_t *) mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -
> > 1, 0);
> > > +    if (buf == MAP_FAILED) {
> > > +        error_setg(errp, "multifd: %u: alloc_zbuf failed, job num %u,
> > size %u",
> > > +                   chan_id, qpl->job_num, qpl->data_size);
> > > +        return -1;
> > > +    }
> > 
> > What's the reason for using mmap here, rather than a normal
> > malloc ?
> 
> I want to populate the memory accessed by the IAA device in the initialization
> phase, and then avoid initiating I/O page faults through the IAA device during
> migration, a large number of I/O page faults are not good for performance.

Does this mmap actually make a measurable difference ?

If I've followed the code paths correctly, I think this
alloc_zbuf method only gets called during initial setup
of each migration thread.

So this use of MAP_POPULATE seems to only make a difference
between faulting in before starting sending data, and faulting
in on first bit of data that's sent. I'm surprised if that's
noticable as a difference.


> This problem also occurs at the destination, therefore, I recommend that
> customers need to add -mem-prealloc for destination boot parameters.

I can understand mem-prelloc making a difference as that guarantees
all of guest RAM is faulted in.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


