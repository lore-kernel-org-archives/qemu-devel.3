Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0C3D44D46
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dhg-0001RN-Jn; Wed, 06 Nov 2024 05:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8dhc-0001R6-LN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8dha-00007N-QJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGa+O5hTzE7p1eGFtqQJ7pWyvk1sYt+TFbrBvHQHMdg=;
 b=AjFnKFOEM6BzN5U4h0PwOBe849erPwrqkq1TYkuLkrfI9tS0/u/8T34fcXSxedbw74qTKO
 nSgmtpFeGwTl1EEHyaSrYv7ODyYLQ3Us3bvaJWiXsLSKP7hAtLWV6BDUp6paDP4u3KAZrw
 jgPjBoRJ50d2U2WAxoJ5sPocUqG0KTA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-KylMF9KXPRGJSw-1sxlrKg-1; Wed,
 06 Nov 2024 05:55:51 -0500
X-MC-Unique: KylMF9KXPRGJSw-1sxlrKg-1
X-Mimecast-MFC-AGG-ID: KylMF9KXPRGJSw-1sxlrKg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC781956096; Wed,  6 Nov 2024 10:55:49 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C54F3000198; Wed,  6 Nov 2024 10:55:46 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:55:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
Message-ID: <ZytLMCRuezP39qdk@redhat.com>
References: <20240827192751.948633-1-stefanha@redhat.com>
 <20240827192751.948633-2-stefanha@redhat.com>
 <87o75ah3is.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o75ah3is.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 30.08.2024 um 09:29 hat Markus Armbruster geschrieben:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > The QMP device_add monitor command converts the QDict arguments to
> > QemuOpts and then back again to QDict. This process only supports scalar
> > types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> > array of objects) are silently dropped by qemu_opts_from_qdict() during
> > the QemuOpts conversion even though QAPI is capable of validating them.
> > As a result, hotplugging virtio-blk-pci devices with the
> > iothread-vq-mapping property does not work as expected (the property is
> > ignored).

What is the status of this?

This is a bug we certainly want to have fixed for 9.2. It's probably
also something for stable.

> > Get rid of the QemuOpts conversion in qmp_device_add() and call
> > qdev_device_add_from_qdict() with from_json=true. Using the QMP
> > command's QDict arguments directly allows non-scalar properties.
> >
> > The HMP is also adjusted since qmp_device_add()'s now expects properly
> > typed JSON arguments and cannot be used from HMP anymore. Move the code
> > that was previously in qmp_device_add() (with QemuOpts conversion and
> > from_json=false) into hmp_device_add() so that its behavior is
> > unchanged.
> >
> > This patch changes the behavior of QMP device_add but not HMP
> > device_add. QMP clients that sent incorrectly typed device_add QMP
> > commands no longer work. This is a breaking change but clients should be
> > using the correct types already. See the netdev_add QAPIfication in
> > commit db2a380c8457 for similar reasoning and object-add in commit
> > 9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
> > for the time being.
> >
> > Markus helped me figure this out and even provided a draft patch. The
> > code ended up very close to what he suggested.
> 
> Should we discuss the RCU draining issue here?

What RCU draining issue is this?

If I'm reading the patch correctly, it doesn't change anything related
to the RCU logic, but just inlines an existing call for HMP.

> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  system/qdev-monitor.c | 44 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 6af6ef7d66..26404f314d 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -849,18 +849,9 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
> >  
> >  void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> >  {
> > -    QemuOpts *opts;
> >      DeviceState *dev;
> >  
> > -    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
> > -    if (!opts) {
> > -        return;
> > -    }
> > -    if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
> > -        qemu_opts_del(opts);
> > -        return;
> > -    }
> > -    dev = qdev_device_add(opts, errp);
> > +    dev = qdev_device_add_from_qdict(qdict, true, errp);
> >      if (!dev) {
> >          /*
> >           * Drain all pending RCU callbacks. This is done because
> > @@ -872,11 +863,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> >           * to the user
> >           */
> >          drain_call_rcu();
> > -
> > -        qemu_opts_del(opts);
> > -        return;
> 
> The removal of return gave me pause.  It's actually okay, because the
> code we now execute in addition is a no-op: object_unref(NULL).
> 
> Matter of taste.
> 
> >      }
> > -    object_unref(OBJECT(dev));
> > +    object_unref(dev);
> 
> TIL that object_unref() takes a void *.
> 
> commit c5a61e5a3c68144a421117916aef04f2c0fab84b
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Mon Aug 31 17:07:23 2020 -0400
> 
>     qom: make object_ref/unref use a void * instead of Object *.
>     
>     The object_ref/unref methods are intended for use with any subclass of
>     the base Object. Using "Object *" in the signature is not adding any
>     meaningful level of type safety, since callers simply use "OBJECT(ptr)"
>     and this expands to an unchecked cast "(Object *)".
>     
>     By using "void *" we enable the object_unref() method to be used to
>     provide support for g_autoptr() with any subclass.
>     
>     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>     Message-Id: <20200723181410.3145233-2-berrange@redhat.com>
>     Message-Id: <20200831210740.126168-2-ehabkost@redhat.com>
>     Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> About 2 out of 3 callers still pass an OBJECT(...) argument.  Similar
> for object_ref().
> 
> If we believe dropping the OBJECT() is an improvement, we should do it
> globally.
> 
> Suggest not to touch it in this patch.

Is this the only change you want to see before this is merged?

If so, I can fix it up and take it through my tree.

Kevin


