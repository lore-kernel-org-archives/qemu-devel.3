Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD8FD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBHs-0001Ur-Oi; Tue, 20 Jan 2026 07:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viBHm-0001OA-Sw
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viBHk-0005P7-Id
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768913799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+H1cZls3pILkwGVYIv88oJDl8JEn9ZJu/l9PKUO630=;
 b=V/xz66wmwLDzYc+YPedqckg+ujmZBex7Z/TNWwyxrs5PCeVL5UxFgCHnds2QjYm9GV5/th
 TU2maIsuWedZtTSytOAfHYagTQDzS6bQyEVjZL7NLqmPR4xuJuw4V5KMPLrRKIxGVwwJER
 29MRZ2ckmOzciQTL0FGqWCOA24r3T+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-C6L0rrGFOuG_nQvf8DdVgA-1; Tue, 20 Jan 2026 07:56:37 -0500
X-MC-Unique: C6L0rrGFOuG_nQvf8DdVgA-1
X-Mimecast-MFC-AGG-ID: C6L0rrGFOuG_nQvf8DdVgA_1768913796
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43101a351c7so4938845f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768913796; x=1769518596; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j+H1cZls3pILkwGVYIv88oJDl8JEn9ZJu/l9PKUO630=;
 b=a/MpKa/DIAG9ad5cpyJnu3kbr+T0eZ5J9v/XXEkvaBjwh4AmGak4jy0FNMu8jJYI1J
 /sVjnH4cyuFCcIRn3gujdw9zoCfntklv3XKM/FdXrNt31j4BxLBw0Y39xSL3X2eQGsh8
 uPOdjreqkqXj2Z9xy6mYkZ9YIabVYkOd4IqsRZciYNjO/05opOnZHMToL1TsJyUKJPSY
 kZ0tl8DQgam+MFVPQjT4zqk8I+lttvUFoc6YfQ4b8IEwkngdD7HTYHrsiFODCHUQJgtj
 EJ4KYJ8UJez61YohRMRxoNpro2nF7LT/z5mhNJaq/mvo9m5mOQWtyo1N05ScThdS0xYt
 R/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768913796; x=1769518596;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+H1cZls3pILkwGVYIv88oJDl8JEn9ZJu/l9PKUO630=;
 b=KHW14O7J+m19LBBmdZX9uANTCz47cBqobO5+0QMaSifV3BGHnI0vuY8BYzes9jDqFu
 wygCjTROgwtSfvKGbXYKIwUYSYMIaqVGAtcIxlm8TmsImsjb11cH1PHXY8sMc0u6mcrx
 o01tfXUpxBIZtydsLsCN0nU6Xj0+TpyEmHvvLyQAfAUFHvWF1aHqK2AGjBMHnNzCnGhO
 c2Lw6PgIaOU/4O9EG8CZn789lQkUbto+HQfwlNNzaIa9zUWzVyU2Ukaf1xLgMwSt6thV
 NGRremzTu1A5IBg2bgsU8HHB8vtp5VVVxFMwXgI75rQrQOa/D5M2DgWvqx41MU3IX36R
 J1oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2WOnDGeaIYNoW7p0gpe5Onxrh1307VRfSv2Xffbx7MTQpqYJi2/VoROVS6tuB7jP8u036LgtakYPi@nongnu.org
X-Gm-Message-State: AOJu0YzfrO9IeYa5MehrMw0hF0Hf5BJThWUs70vK4O4u4F1JhLpSbzIk
 0AgaaYkb8HBSZjX06cjWUk/fFsKnSK7iATBGhCc54NWDAJTdxndRsRhzU/A46syeKUl2f3G0Kr/
 JmMvr2nsDFXbJ1RmQ+i1YLqVgL/5XDV3lj3AtqxpW/J2E1S9UvfDY3jYT
X-Gm-Gg: AZuq6aK3/4vPBAY+tSDoYwoQDoV2HZFeMKHedoCvlWn/1UqQeOYPPzR2cM97oZOn9Gi
 L4OlKkBuR4ruB7rrht8HKUVZL8HU5ntrrqfmI8FITLg48TPZp92jyMjrSNcXGLuHA9bL4XSfbw9
 vyyDEuQQpP4A+PMtc4q2li6ubwenBE1SfNkop1WJW8kHxe5Ln6eT7uJPWlSpeXtolF9/hEAy5nt
 vv+PZYZX55aYJI0Oo9EHkSG4UrG1TWXHNgYLPdrltWvcmgUAtSkrxm25dh9udjfzQRsLTdNIBCE
 Wj3Ea9xmNIji8Go90tm9szwckvR+d/oHFO7zg/Q0qiZSeBJmW09Yz/ihSvRCu1ShKGkXBou8Jag
 9WNM3pavDlt+SFfaHJM59/lGsJO50ZTQ=
X-Received: by 2002:a05:6000:4007:b0:435:95c9:687a with SMTP id
 ffacd0b85a97d-43595c96c1bmr1306646f8f.4.1768913795677; 
 Tue, 20 Jan 2026 04:56:35 -0800 (PST)
X-Received: by 2002:a05:6000:4007:b0:435:95c9:687a with SMTP id
 ffacd0b85a97d-43595c96c1bmr1306574f8f.4.1768913795079; 
 Tue, 20 Jan 2026 04:56:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm29384021f8f.28.2026.01.20.04.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 04:56:34 -0800 (PST)
Date: Tue, 20 Jan 2026 07:56:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
Message-ID: <20260120075558-mutt-send-email-mst@kernel.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <aW37oZ1X_7O6AXvo@redhat.com>
 <20260119044148-mutt-send-email-mst@kernel.org>
 <aW9AEjN3TDov1jLj@redhat.com>
 <ef45a24d7052d685f4951aaa6d37ce55b0746698.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef45a24d7052d685f4951aaa6d37ce55b0746698.camel@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 20, 2026 at 10:16:08AM +0100, Filip Hejsek wrote:
> On Tue, 2026-01-20 at 08:43 +0000, Daniel P. Berrangé wrote:
> > On Mon, Jan 19, 2026 at 04:43:21AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Jan 19, 2026 at 09:38:41AM +0000, Daniel P. Berrangé wrote:
> > > > On Mon, Jan 19, 2026 at 04:27:51AM +0100, Filip Hejsek wrote:
> > > > > Implement the part of the virtio spec that allows to notify the virtio
> > > > > driver about terminal resizes. The virtio spec contains two methods to
> > > > > achieve that:
> > > > > 
> > > > > For legacy drivers, we have only one port and we put the terminal size
> > > > > in the config space and inject the config changed interrupt.
> > > > > 
> > > > > For multiport devices, we use the control virtqueue to send a packet
> > > > > containing the terminal size. Note that old versions of the Linux kernel
> > > > > used an incorrect order for the fields (rows then cols instead of cols
> > > > > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> > > > > 
> > > > > As a result, when using a Linux kernel older than 6.15, the number of rows
> > > > > and columns will be swapped.
> > > > > 
> > > > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > > > > but partially rewritten to fix various corner cases.
> > > > > 
> > > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > > ---
> > > > >  hw/char/trace-events              |  1 +
> > > > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
> > > > >  hw/core/machine.c                 |  4 ++-
> > > > >  include/hw/virtio/virtio-serial.h |  5 +++
> > > > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > > > 
> > > > 
> > > > > @@ -1158,6 +1228,8 @@ static const Property virtio_serial_properties[] = {
> > > > >                                                    31),
> > > > >      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> > > > >                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> > > > > +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> > > > > +                      VIRTIO_CONSOLE_F_SIZE, true),
> > > > >  };
> > > > 
> > > > Given the horrible mess with the kernel intentionally changing its
> > > > behaviour after 15 years, I don't think we can we set this to be
> > > > enabled by default.
> > > > 
> > > > The recent behaviour change is never going to be backported to enough
> > > > stable distros that we can rely on the new behaviour, and thanks to
> > > > the change we can't rely on the old behaviour either. We're doomed no
> > > > matter what ordernig we use.
> > > > 
> > > > Thus, IMHO, this has to stay set to false indefinitely.
> > > 
> > > Not sure. But what we can do is add another flag to detect new kernels.
> > > I'll try to think of a good name but suggestions are welcome.
> > 
> > How can we detect the kernel ? There's no feature flag that can be
> > negotiated or detected to report the changed kernel behaviour
> > AFAICS. We have no visibility of kernel version, and even if we did,
> > the possibility of backports would make that unreliable too. The
> > inability to auto-detect anything is what makes the kernel behaviour
> > change so awful.
> > 
> > We can add a nother qemu flag "console-size-inverted" to flip QEMU
> > between the 2 behaviours, but that still won't let us be able to
> > enable 'console-size' by default without guaranteed regressions.
> > The 'console-size-inverted' flag would merely flip the breakage
> > between different groups of guest OS.
> 
> We could add a new virtio feature flag, and by default only enable
> resizing when the guest supports this new flag. Kernels that support
> the flag would work by default, and kernels that have the correct order
> but don't yet support the flag would require manually enabling the
> feature.

Right. For now. In X years when we see downstreams backporting the
feature, things can change.


> In any case, we will probably need to add some documentation for the
> property. I'm trying to find a good place for it, but it seems that the
> virtconsole and virtio-serial-bus devices are not actually documented
> anywhere at all. They should probably be documented in the man page,
> right?
> 
> > 
> > > > >  static void virtio_serial_class_init(ObjectClass *klass, const void *data)
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 6411e68856..50554b8900 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -38,7 +38,9 @@
> > > > >  #include "hw/acpi/generic_event_device.h"
> > > > >  #include "qemu/audio.h"
> > > > >  
> > > > > -GlobalProperty hw_compat_10_2[] = {};
> > > > > +GlobalProperty hw_compat_10_2[] = {
> > > > > +    { "virtio-serial-device", "console-size", "off" },
> > > > > +};
> > > > >  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
> > > > >  
> > > > >  GlobalProperty hw_compat_10_1[] = {
> > 
> > With regards,
> > Daniel


