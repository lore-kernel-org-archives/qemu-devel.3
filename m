Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7689CD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7L8-0006WK-8c; Tue, 20 Jan 2026 03:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7Kx-0006T0-K3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7Kv-00065t-2x
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768898619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9rYAnuI2D6CzenVBNuzt4D6z1Q5UkhdyMZqttexzdQ=;
 b=FzZqk44D4E7ENPkExYZW7iNPlYzerhQnGv0Q0XELpwT+QazIX19nY7nED7ADsb5l2X7KNW
 UXBIBMI0tOYCNKgbucJLzLEg4z+qoJjqEFdFuDJATwA1UAqHKbJztWCAFvOEQYZ8Pt9ixq
 X3WskCdXpbDFgL4ZXw9ZROOQPtYmrDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-CSTOcBG5NciSpNkOP1SGWA-1; Tue,
 20 Jan 2026 03:43:36 -0500
X-MC-Unique: CSTOcBG5NciSpNkOP1SGWA-1
X-Mimecast-MFC-AGG-ID: CSTOcBG5NciSpNkOP1SGWA_1768898614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5611C1800451; Tue, 20 Jan 2026 08:43:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 245D718001D5; Tue, 20 Jan 2026 08:43:29 +0000 (UTC)
Date: Tue, 20 Jan 2026 08:43:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
Message-ID: <aW9AEjN3TDov1jLj@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <aW37oZ1X_7O6AXvo@redhat.com>
 <20260119044148-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119044148-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Jan 19, 2026 at 04:43:21AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 19, 2026 at 09:38:41AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Jan 19, 2026 at 04:27:51AM +0100, Filip Hejsek wrote:
> > > Implement the part of the virtio spec that allows to notify the virtio
> > > driver about terminal resizes. The virtio spec contains two methods to
> > > achieve that:
> > > 
> > > For legacy drivers, we have only one port and we put the terminal size
> > > in the config space and inject the config changed interrupt.
> > > 
> > > For multiport devices, we use the control virtqueue to send a packet
> > > containing the terminal size. Note that old versions of the Linux kernel
> > > used an incorrect order for the fields (rows then cols instead of cols
> > > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> > > 
> > > As a result, when using a Linux kernel older than 6.15, the number of rows
> > > and columns will be swapped.
> > > 
> > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > > but partially rewritten to fix various corner cases.
> > > 
> > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > ---
> > >  hw/char/trace-events              |  1 +
> > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
> > >  hw/core/machine.c                 |  4 ++-
> > >  include/hw/virtio/virtio-serial.h |  5 +++
> > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > 
> > 
> > > @@ -1158,6 +1228,8 @@ static const Property virtio_serial_properties[] = {
> > >                                                    31),
> > >      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> > >                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> > > +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> > > +                      VIRTIO_CONSOLE_F_SIZE, true),
> > >  };
> > 
> > Given the horrible mess with the kernel intentionally changing its
> > behaviour after 15 years, I don't think we can we set this to be
> > enabled by default.
> > 
> > The recent behaviour change is never going to be backported to enough
> > stable distros that we can rely on the new behaviour, and thanks to
> > the change we can't rely on the old behaviour either. We're doomed no
> > matter what ordernig we use.
> > 
> > Thus, IMHO, this has to stay set to false indefinitely.
> 
> Not sure. But what we can do is add another flag to detect new kernels.
> I'll try to think of a good name but suggestions are welcome.

How can we detect the kernel ? There's no feature flag that can be
negotiated or detected to report the changed kernel behaviour
AFAICS. We have no visibility of kernel version, and even if we did,
the possibility of backports would make that unreliable too. The
inability to auto-detect anything is what makes the kernel behaviour
change so awful.

We can add a nother qemu flag "console-size-inverted" to flip QEMU
between the 2 behaviours, but that still won't let us be able to
enable 'console-size' by default without guaranteed regressions.
The 'console-size-inverted' flag would merely flip the breakage
between different groups of guest OS.

> > >  static void virtio_serial_class_init(ObjectClass *klass, const void *data)
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 6411e68856..50554b8900 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -38,7 +38,9 @@
> > >  #include "hw/acpi/generic_event_device.h"
> > >  #include "qemu/audio.h"
> > >  
> > > -GlobalProperty hw_compat_10_2[] = {};
> > > +GlobalProperty hw_compat_10_2[] = {
> > > +    { "virtio-serial-device", "console-size", "off" },
> > > +};
> > >  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
> > >  
> > >  GlobalProperty hw_compat_10_1[] = {

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


