Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC97FC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfqH-0003v7-SP; Thu, 29 Aug 2024 10:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjfqF-0003tc-Py
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjfqD-0006Ty-2N
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724940575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/FD/bZfHw9T/rToIRbFHSh6U7e7kCSfRZzGfrMoUdg=;
 b=MsKx4byEY8V6OE3uq/Fcd0WdwSOw43ecYsk+IgdK+Qur9fHW3vOOtEyQunpOglrXS/YAvI
 eombg4ArG6iBr/nO4uKqvUeTv4XoaU9aZcV3/6ecnMJLtct/kp6l+KfJRBtoZ4lERp88BP
 n+1eE9fk1Qg4g6ULXLer1VTUhmAXaio=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-RDnfFMgiMGGzgzGYEbW89A-1; Thu,
 29 Aug 2024 10:09:31 -0400
X-MC-Unique: RDnfFMgiMGGzgzGYEbW89A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93D981955BF6; Thu, 29 Aug 2024 14:09:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D311956048; Thu, 29 Aug 2024 14:09:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 699E221E6A28; Thu, 29 Aug 2024 16:09:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  pkrempa@redhat.com,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
In-Reply-To: <20240812180706.GB69160@fedora.redhat.com> (Stefan Hajnoczi's
 message of "Mon, 12 Aug 2024 14:07:06 -0400")
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <20240801140552.1021693-2-stefanha@redhat.com>
 <875xsj73qn.fsf@pond.sub.org>
 <20240812180706.GB69160@fedora.redhat.com>
Date: Thu, 29 Aug 2024 16:09:27 +0200
Message-ID: <87plprju94.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Aug 02, 2024 at 10:01:20AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > The QMP device_add monitor command converts the QDict arguments to
>> > QemuOpts and then back again to QDict. This process only supports scal=
ar
>> > types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
>> > array of objects) are silently dropped by qemu_opts_from_qdict() during
>> > the QemuOpts conversion even though QAPI is capable of validating them.
>> > As a result, hotplugging virtio-blk-pci devices with the
>> > iothread-vq-mapping property does not work as expected (the property is
>> > ignored).
>> >
>> > Get rid of the QemuOpts conversion in qmp_device_add() and call
>> > qdev_device_add_from_qdict() with from_json=3Dtrue. Using the QMP
>> > command's QDict arguments directly allows non-scalar properties.
>> >
>> > The HMP is also adjusted since qmp_device_add()'s now expects properly
>> > typed JSON arguments and cannot be used from HMP anymore. Move the code
>> > that was previously in qmp_device_add() (with QemuOpts conversion and
>> > from_json=3Dfalse) into hmp_device_add() so that its behavior is
>> > unchanged.
>> >
>> > This patch changes the behavior of QMP device_add but not HMP
>> > device_add. QMP clients that sent incorrectly typed device_add QMP
>> > commands no longer work. This is a breaking change but clients should =
be
>> > using the correct types already. See the netdev_add QAPIfication in
>> > commit db2a380c8457 for similar reasoning and object-add in commit
>> > 9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
>> > for the time being.
>> >
>> > Move the drain_call_rcu() invocation into qdev_device_add_from_qdict()
>> > so all callers benefit from it automatically. This avoids code
>> > duplication.
>> >
>> > Markus helped me figure this out and even provided a draft patch. The
>> > code ended up very close to what he suggested.
>> >
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> >  system/qdev-monitor.c | 56 ++++++++++++++++++++++---------------------
>> >  1 file changed, 29 insertions(+), 27 deletions(-)
>> >
>> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>> > index 6af6ef7d66..8a756b1a91 100644
>> > --- a/system/qdev-monitor.c
>> > +++ b/system/qdev-monitor.c
>> > @@ -725,6 +725,17 @@ err_del_dev:
>> >      if (dev) {
>> >          object_unparent(OBJECT(dev));
>> >          object_unref(OBJECT(dev));
>> > +
>> > +        /*
>> > +         * Drain all pending RCU callbacks. This is done because
>> > +         * some bus related operations can delay a device removal
>> > +         * (in this case this can happen if device is added and then
>> > +         * removed due to a configuration error)
>> > +         * to a RCU callback, but user might expect that this interfa=
ce
>> > +         * will finish its job completely once qmp command returns re=
sult
>> > +         * to the user
>> > +         */
>> > +        drain_call_rcu();
>> >      }
>> >      return NULL;
>> >  }
>>=20
>> Moving this from qmp_device_add() adds RCU draining to call chains not
>> going through qmp_device_add().
>>=20
>> Can adding it hurt?  I guess it can't.
>>=20
>> Can it fix bugs?  I don't know.
>>=20
>> Let's review the callers of qdev_device_add_from_qdict():
>>=20
>> * qdev_device_add()
>>=20
>>   - called from qmp_device_add()
>>=20
>>     No change.
>>=20
>>   - called from device_init_func() called from qemu_create_cli_devices()
>>=20
>>     See below.
>>=20
>>   - called from usbback_portid_add() called from usbback_process_port()
>>     called from usbback_backend_changed()
>>=20
>>     =C2=B7 called from usbback_init()
>>=20
>>     =C2=B7 called as XenDevOps method backend_changed()
>>=20
>>     This is Xen.  We now drain pending RCU callbacks.  Impact?  Beats
>>     me.
>>=20
>> * qemu_create_cli_devices() called from qmp_x_exit_preconfig()
>>=20
>>   - as QMP command with -preconfig, phase must be
>>     PHASE_MACHINE_INITIALIZED
>>=20
>>   - called from qemu_init() without -preconfig
>>=20
>>   We now drain pending RCU callbacks.  Can any be pending at this
>>   early point?  If not, the change is a no-op.
>>=20
>> * failover_add_primary() called from virtio_net_set_features() called as
>>   VirtioDeviceClass method set_features()
>>=20
>>   This is virtio-net failover.  We now drain pending RCU callbacks.
>>   Impact?  Beats me.
>>=20
>> My gut feeling is "improvement, possibly even a bug fix".  It deserves
>> its own commit, doesn't it?
>
> I thought I'd checked it, but now that I have reviewed the functions you
> looked at, I no longer think it's safe to move drain_call_rcu() into
> qdev_device_add_from_qdict(). drain_call_rcu() drops the BQL and must
> not be called from non-reentrant multi-threaded code paths.
>
> For example, if drain_call_rcu() is called from device emulation code
> then another vCPU thread could execute that same device's emulation code
> while the BQL is dropped. That's usually unsafe because most device
> emulation code only expects to run in one thread at any given time
> thanks to the BQL.
>
> Here are the cases:
> - qemu_create_cli_devices: safe because this happens before device
>   emulation runs in vCPU threads
> - Xen: safe because there are no vCPU threads when QEMU just provides
>   device emulation in a normal Xen system. But I'm not sure if usbback
>   can also be used in a QEMU's Xen HVM guest mode where KVM handles
>   vCPUs, it might be a problem there.
> - virtio_net_set_features() -> failover_add_primary() is unsafe. Another
>   vCPU thread could enter virtio-net emulation code while the thread
>   running virtio_net_set_features() drops the lock.

I see.

Can you make an argument why the reason for RCU draining does not apply
in failover_add_primary()?

If it doesn't apply, capturing the argument in a comment would be nice.

If it does apply, a FIXME comment seems in order.

Also, RCU draining / BQL dropping vs. non-draining/dropping behavior of
non-static functions should be documented in function comments.

All this can be done on top.

> I think it's better to duplicate drain_call_rcu() into hmp_device_add()
> than to risk breaking the other code paths.

Makes sense.


