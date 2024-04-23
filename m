Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFI7-0001MK-2b; Tue, 23 Apr 2024 08:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzFHq-0001LF-KQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzFHn-0001py-Bl
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713875409;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5YmGgbKI3nqiIt1WA82Fe5RFo8wRLu+Nl7AH7k4mj0=;
 b=XRTHw1wDGFiFZQG3lwGxwUrrnKyQpJQfO+nxsLJg2WQNrk3qAdaMj2u37ZLBmqFgTADpHr
 9/IaWfsQsUBsyxQlqvc25Hy9Ib8xy5wr36mAHPzbRmvwOHbNMxsxc4IlP1esadcKvnsuc0
 o4faVH47QDfk93LNvomp0OvXS6kMhqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-SVEwI74BMd-2fQMR7lLMGQ-1; Tue, 23 Apr 2024 08:30:06 -0400
X-MC-Unique: SVEwI74BMd-2fQMR7lLMGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85FE918065AE;
 Tue, 23 Apr 2024 12:30:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 098E4492BC6;
 Tue, 23 Apr 2024 12:30:02 +0000 (UTC)
Date: Tue, 23 Apr 2024 13:30:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 14/22] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
Message-ID: <ZiepyDp4LasLicJU@redhat.com>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-16-jean-philippe@linaro.org>
 <CAFEAcA_0wi_Ujt5vjbcUFacNqxktmbF7Kma8uEw+pOUp==W0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_0wi_Ujt5vjbcUFacNqxktmbF7Kma8uEw+pOUp==W0oA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 23, 2024 at 01:20:20PM +0100, Peter Maydell wrote:
> On Fri, 19 Apr 2024 at 16:59, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > The Realm Personalization Value (RPV) is provided by the user to
> > distinguish Realms that have the same initial measurement.
> >
> > The user provides up to 64 hexadecimal bytes. They are stored into the
> > RPV in the same order, zero-padded on the right.
> >
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Eduardo Habkost <eduardo@habkost.net>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v1->v2: Move parsing early, store as-is rather than reverted
> > ---
> >  qapi/qom.json        |  15 +++++-
> >  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 125 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 623ec8071f..91654aa267 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -931,6 +931,18 @@
> >    'data': { '*cpu-affinity': ['uint16'],
> >              '*node-affinity': ['uint16'] } }
> >
> > +##
> > +# @RmeGuestProperties:
> > +#
> > +# Properties for rme-guest objects.
> > +#
> > +# @personalization-value: Realm personalization value, as a 64-byte hex string
> > +#     (default: 0)
> > +#
> > +# Since: FIXME
> > +##
> > +{ 'struct': 'RmeGuestProperties',
> > +  'data': { '*personalization-value': 'str' } }
> >
> >  ##
> >  # @ObjectType:
> > @@ -1066,7 +1078,8 @@
> >        'tls-creds-x509':             'TlsCredsX509Properties',
> >        'tls-cipher-suites':          'TlsCredsProperties',
> >        'x-remote-object':            'RemoteObjectProperties',
> > -      'x-vfio-user-server':         'VfioUserServerProperties'
> > +      'x-vfio-user-server':         'VfioUserServerProperties',
> > +      'rme-guest':                  'RmeGuestProperties'
> >    } }
> 
> This list is in alphabetical order. Are we obliged to add new
> items to the end for some compatibility reason, or should this new
> item be filed in its correct place with the other 'r's ?

Ordering has no bearing on compatibility, so this should be at the
correct alphbetical position.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


