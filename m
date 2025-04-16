Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02440C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ypF-0000gL-1c; Wed, 16 Apr 2025 05:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4yp8-0000dd-BM
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4yp5-0007Kn-0F
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744794764;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRkPwzwUr2ZRm9OT5a1JiPbtfsT1DAMR2Iob30hjX4M=;
 b=fbX/WrEfA2SulLbF98DSXE04HT45mTyeVHvo56GNhsNUtIHZwOo6DJFdm++h+8J2UG1dB+
 65ovELVBcnIzu+xfvjswZrUeY012QPA99E1eJ9rni70UT3J4kFKLwALQHu01gTX6BCeJr6
 EO6r04R6jQ5P1KfnZDSS2HN9LQlpA08=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-ugVE9C-sPe25fbUS6G-e-w-1; Wed,
 16 Apr 2025 05:12:41 -0400
X-MC-Unique: ugVE9C-sPe25fbUS6G-e-w-1
X-Mimecast-MFC-AGG-ID: ugVE9C-sPe25fbUS6G-e-w_1744794759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A581828AA8; Wed, 16 Apr 2025 09:12:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988B01954B05; Wed, 16 Apr 2025 09:12:14 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:12:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>, 
 qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
Message-ID: <Z_90aqNE74sonn8O@redhat.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
 <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 16, 2025 at 11:00:37AM +0200, Paolo Bonzini wrote:
> Il mer 16 apr 2025, 10:29 Daniel P. Berrangé <berrange@redhat.com> ha
> scritto:
> 
> > > -    secs = g_list_sort(secs, sort_secs);
> > > +    secs = g_list_sort_with_data(secs, sort_secs, NULL);
> >
> > I don't see what the problem is with the original code.
> >
> > The commit message says we have a bad function cast, but the original
> > method decl is
> >
> >   GList *g_list_sort(GList*list, GCompareFunc compare_func);
> >
> > where the callback is
> >
> >    typedef gint (*GCompareFunc)(gconstpointer a, gconstpointer b);
> >
> > Our code complies with that GCompareFunc signature.
> >
> 
> The cast is inside glib; g_list_sort casts the function pointer and calls
> g_list_sort_with_data.

Sigh, the commit message should have said that, as it reads like the
problem is in QEMU code, not glib code.

> I suggested this solution to Kohei because it's easy to check that we're
> converting all users and not introducing new ones in the future (see
> poisoning in patch 10).

It is easy to check this /one/ example, but this pattern of bad casts
is typical in glib with likely many more examples, so avoidance in this
way does not feel like a sustainable long term strategy to me.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


