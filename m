Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838C7D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBJP-0003Nb-7C; Tue, 20 Jan 2026 07:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viBJG-0003I0-9c
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viBJE-0005tL-PF
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768913891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XcJpC/SsM5SB21diMG4bdOKmIF1sLjFTXKYW5m3604A=;
 b=T59m7dtHzPzyDWDoEuBsaxaEErBDGRpcVaXUrG/TneXRSZ4JXzyUHyYhtalsTH5gLNsBUi
 q0s9VYAbKyEHqeFdVozOnRrIjwE2RQ4yjU4iOEdGK1ccZDPw2KUOMXpXsFjFxidUM6YM0p
 ScNUshG7E6AK+v6rmQGyhY/fK5sAd8M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-pbIA2EF1MOORBdVjpNsxBA-1; Tue, 20 Jan 2026 07:58:10 -0500
X-MC-Unique: pbIA2EF1MOORBdVjpNsxBA-1
X-Mimecast-MFC-AGG-ID: pbIA2EF1MOORBdVjpNsxBA_1768913889
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so3119572f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 04:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768913889; x=1769518689; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XcJpC/SsM5SB21diMG4bdOKmIF1sLjFTXKYW5m3604A=;
 b=cIZpaU64ZAQXUyrxfcigfuFMlAY/YyICOjeABc1HXstCHAz/USAPuy8S8Cce3fh51L
 UYqFSoRzVFmyU9bBRZBA9ctpibDdWDv6l1d5BMfZ2aikOwO0KNcaxehLKuoQVPPF/neq
 8Xhn3xNbf8xIZkw5ea39xI3++ePPrQPVOaBu0Ko2FZdWJGPyB1NVqhYDaSbuEkrH99LO
 ha+tDX8OkR5zewn1lDCNEhDmKf3PMUTr5JhkkTTMLNH3lFti2k8Sucnac1uIOBh5irF1
 RxmR0B+oFjCb1jXSQIJihn2YCJwanJHGz5dEdo8SDxmiGRbcyEwfWOIlMOkYfzg2qRHT
 jObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768913889; x=1769518689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcJpC/SsM5SB21diMG4bdOKmIF1sLjFTXKYW5m3604A=;
 b=fC3rNoY27UhZTdbqjGRI+Vc3bQRXOdpK6Z7J4/Uy2Nt0q/k0PZCmknIOwA35+ZQLNH
 MFOwD8FJPksMPt8LGv+zy0gwuUxxB8H2Clp/6RchmVIYVxuLDT1v2JF80LSijyJlwDIt
 vcn1OUJdAeeUvUGUINxMMkg/uPVq+ajAKbsUGEPUw4Zti7ebb3lhGF/voxKKkD92dVew
 glESvLQxrMbXtUP1oSUNojn5r9OeAWF13owUNwVkwWRyVVpQ3Bb5yZuscHJOhhlIa3ck
 xAU8Gg9RnAR1APXnA9wbEupKuyRkwqreKaLWlZmjsPRn31I8cLswaqpy5/o5MzpVp/DT
 WP1A==
X-Gm-Message-State: AOJu0YzM+FcFi6Hg6PlQOZN1E6sgYFC1VkKDgGGYsxMBPMw7nIZVH550
 r3y2QWVcj+gkvRAn37CNKfmmpoFgfOuKWvhLq7zO3nIu8cNWVFGtfX5OuQwAtN3p+k5yKWxAAlT
 Zyt2X/vKGDq1FLAZ66QdifBfx67Acee3z84poBDhWHrZfumQy1Dc1rNXCsWD4oDBh
X-Gm-Gg: AZuq6aLT12FKdBL4ddCn1XdxxCZPcHXSwzsdU2KBQZsdQdDBtGpDK/TeC7Ez6bE+9lB
 xZtcaQ6fjue6tlqbE2ae4uaEOCCXdEnDX2bwl8iHIZpWakp/55T7rVh54aIJrMlukXXmQqkw3ST
 wd+UknzI0ADQaI5pSIaurFlVmD7pLwty4pMNKDzvHn8D1UVOv4QcftDZ+WEkkVm7+wuEMxgPfq4
 bj440KpYDs6i3P1bN0tp5PZsQIMlFARIFczLvDIG6eWkVWRVphvRLYsf/UAHqQDJyPBVuodUuQf
 ByOW6xhPlO79eRmHjvBh7pxXuvUXDARuX1DjiMpIfAnIs1ArD+RlLAbLP549iMDQ1SOmPep5CHi
 1NKyhhunlp+eOaiqkBC5QMQ2RogxafKg=
X-Received: by 2002:a05:6000:2f82:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-4358f887404mr2905249f8f.33.1768913889071; 
 Tue, 20 Jan 2026 04:58:09 -0800 (PST)
X-Received: by 2002:a05:6000:2f82:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-4358f887404mr2905200f8f.33.1768913888514; 
 Tue, 20 Jan 2026 04:58:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm29854795f8f.32.2026.01.20.04.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 04:58:07 -0800 (PST)
Date: Tue, 20 Jan 2026 07:58:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
Message-ID: <20260120075710-mutt-send-email-mst@kernel.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > Implement the part of the virtio spec that allows to notify the virtio
> > driver about terminal resizes. The virtio spec contains two methods to
> > achieve that:
> > 
> > For legacy drivers, we have only one port and we put the terminal size
> > in the config space and inject the config changed interrupt.
> > 
> > For multiport devices, we use the control virtqueue to send a packet
> > containing the terminal size. Note that old versions of the Linux kernel
> > used an incorrect order for the fields (rows then cols instead of cols
> > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> > 
> > As a result, when using a Linux kernel older than 6.15, the number of rows
> > and columns will be swapped.
> > 
> > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > but partially rewritten to fix various corner cases.
> > 
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> >  hw/char/trace-events              |  1 +
> >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
> >  hw/core/machine.c                 |  4 ++-
> >  include/hw/virtio/virtio-serial.h |  5 +++
> >  4 files changed, 83 insertions(+), 3 deletions(-)
> > 
> > [...]
> > 
> > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> > index 60641860bf..bda6d5312a 100644
> > --- a/include/hw/virtio/virtio-serial.h
> > +++ b/include/hw/virtio/virtio-serial.h
> > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> >      bool host_connected;
> >      /* Do apps not want to receive data? */
> >      bool throttled;
> > +
> > +    /* Terminal size reported to the guest.  Only used for consoles. */
> > +    uint16_t cols, rows;
> >  };
> 
> I found a bug: after a migration, the guest is not informed about the
> new console size. I see two ways to fix this: either add the cols and
> rows fields to the migration stream, or always send the console size to
> the guest after migration, even if it might not have changed. Which do
> you prefer?

I prefer not adding a performance overhead to guests without
a good reason. We are already sending too much stuff to guests on
resume, let's not add more to this.

> Modifying the migration stream is somewhat annoying,
> because both versions will have to be supported, and also the device
> still uses legacy save/load functions rather than VMState.


