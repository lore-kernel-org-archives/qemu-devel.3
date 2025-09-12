Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA78CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzYY-0000vn-3s; Fri, 12 Sep 2025 04:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwzYW-0000vM-Fg
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwzYU-0007PW-8v
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757667290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh+3qk0Afx0QKtZwZuUgwTJXQ7swY8hQMOa0ZOJ45R8=;
 b=ZHu16tTLTtJGkyOjOJ4OukPL7aYakd/jQVLiXTGp5RL5AT2dGOf7gV8di6F7RcRD7EFn1R
 X/IQS4ajcLoniOyXqKu50qR1+vcZPJ1xIHU+mDQUSib0FbnBee93WGHkET0dMT+N5/0kNj
 YSeczRD+o8tygq6nnXiPKCmi+chEeqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-6MCqfphfOQaI8-wxpbTLzw-1; Fri, 12 Sep 2025 04:54:49 -0400
X-MC-Unique: 6MCqfphfOQaI8-wxpbTLzw-1
X-Mimecast-MFC-AGG-ID: 6MCqfphfOQaI8-wxpbTLzw_1757667288
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b986a7b8aso13248345e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 01:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757667288; x=1758272088;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jh+3qk0Afx0QKtZwZuUgwTJXQ7swY8hQMOa0ZOJ45R8=;
 b=tcp/HuJ+idnCjNE9NVstXK2Uwn3PdU7zwdosN4U+wFXOFO8UqFsWBkBQ3aEyGovJZY
 nztZFamDxnr1zOSGTJ8qfqPzxe1mq6jOQDVihKUh+BOJlUIkQNQAzaVTCCWM6UZBC1SX
 mSTGk/gdcMO2aNMyzJOs4mWxjFhvMvYxWMZ+uvSzL6HYNpHhjGaLNdzvRIHEaz3Vtpsq
 nHYYKzAkQnLdo5iCESgN+u9R3JpxwDVcBiZt2GqGEFjdR6HUp2RFYPrTmkG6EjN5SdQD
 mYS3Pdhba56si9Orc3YsLrDsfu90zhl4STViane8EzxuARFjxFQ90k31WX14FsmToumv
 o92g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX3wdV6qEIXYj824nfe4jqnWFuDFoPvxGXWGM4J/9k55XlCKEb/kjAG6XnkTdDjTT1WJOvN11/3NRa@nongnu.org
X-Gm-Message-State: AOJu0Ywvui2+jOth66YMcFDJ+KOOI2h6jrBz/ED7Kdw/7k1M61WKBBqo
 A6CiADsoUBHFHv1ZJa/v1Yf0bGsxNGx1QqHGEDhcMCtl+0KP7FB1ht+Wq/Pxbcb3ncupO9/TH/Q
 /gUglIj8MfsXbQitQHiZxupZt+QFA5uWnLtOfgbLfir51V6o1ZbO38tsm
X-Gm-Gg: ASbGncvPAj3oj+m+xuK39mjcte4hSAwEs8byo0FYwJCjVL0UjRXIbpRfgmRK332HpJX
 dTHFp8e5J5jk/muARpMLSqD0S8kN0exol+jn7x2S+sQLfFAXO7LtqSDPxGPnBP+5dXLqIbMlFaS
 wldbwJDjzjr8huDBqEwAsOfKh1hOV5G0lO9wpSOGSTMnedJAgsPat7cPMHmOPxE2i35+D0Kz3d7
 RCW36YimPDnhyZblQ6ed/oFXt8Xc6bTdnrLLAeWBGnO8YC7dYokS9p8F2lZ+CK/0rwVaCAH+ABB
 iUawv+OxnZ6hE3mIKWV+udciEsKcS97H
X-Received: by 2002:a05:600c:6d45:b0:45d:e326:96ca with SMTP id
 5b1f17b1804b1-45f21205905mr15711905e9.36.1757667287654; 
 Fri, 12 Sep 2025 01:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuXlI9sah1aX4lSvXyoFu/rcUPaCWpDuEamV7X4Zn3eEv4jEscffwb2WpFPPqJ0QDlKOP7lw==
X-Received: by 2002:a05:600c:6d45:b0:45d:e326:96ca with SMTP id
 5b1f17b1804b1-45f21205905mr15711695e9.36.1757667287140; 
 Fri, 12 Sep 2025 01:54:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e01512379sm57447435e9.0.2025.09.12.01.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 01:54:46 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:54:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
Message-ID: <20250912045228-mutt-send-email-mst@kernel.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912042910-mutt-send-email-mst@kernel.org>
 <aMPe1vB3cZAlNBq1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMPe1vB3cZAlNBq1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 09:50:30AM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 12, 2025 at 04:41:02AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 12, 2025 at 05:39:45AM +0200, Filip Hejsek wrote:
> > > The goal of this series is to have a resizable terminal into a guest
> > > without having to set up networking and using, e.g. ssh.
> > > 
> > > The virtio spec allows a virtio-console device to notify the guest about
> > > terminal resizes in the host. Linux Kernel implements the driver part of
> > > the spec. This series implement the device part in QEMU.
> > > 
> > > This series adds support for a resizable terminal if a virtio console
> > > device is connected to the stdio backend.
> > > 
> > > This series also introduces resize messages that can be sent over QMP to
> > > notify QEMU about the size of the terminal connented to some chardev.
> > > In the libvirt setting, it will allow to implement a resizable terminal
> > > for virsh console and other libvirt clients.
> > > 
> > > This patch series was originally authored by Szymon Lukasz and submitted
> > > to qemu-devel about 5 years ago. The previous submission can be found at
> > > <https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09591.html>.
> > > I have updated the patches to be compatible with latest master and made
> > > a few small changes of my own, including the addition of Windows support.
> > > 
> > > Probably the most important change I made is the swapping of rows and
> > > cols fields in resize messages. I would like to hear some feedback on
> > > this change from reviewers. The problem is that for a long time, the
> > > Linux kernel used a different field order from what was specified in the
> > > virtio spec. The kernel implementation was apparently merged around 2010,
> > > while the virtio spec came in 2014, so when a previous version of this
> > > patch series was being discussed here on this mailing list in 2020, it
> > > was decided that QEMU should match the Linux implementation, and ideally,
> > > the virtio spec should be changed.
> > > 
> > > However, recently, the Linux kernel implementation was changed to conform
> > > to the spec: <https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c7056ddd>.
> > > As a result, to be compatible with latest kernel releases, QEMU needs to
> > > also use the field order matching the specification. I have changed the
> > > patch to use the spec-compliant order, so it works correctly with latest
> > > kernels now.
> > >
> > 
> > Well this is not in any release yet. If you want me to revert that
> > one, let me know ASAP. Maximilian?
> > 
> > > That leaves the issue of older kernels. There are about 15 years' worth
> > > of kernel versions with the swapped field order, including the kernel
> > > currently shipped in Debian stable. The effects of the swapped dimensions
> > > can sometimes be quite annoying - e.g. if you have a terminal with
> > > 24 rows, this will be interpreted as 24 columns, and your shell may limit 
> > > line editing to this small space, most of which will be taken by your
> > > prompt. The patch series in its current form provides no way to disable
> > > the console size functionality,
> > 
> > Well I see the console-size property, no?
> 
> At least in the case of libvirt managed VMs, this series does
> nothin by default, as they won't be using the 'stdio' chardev,
> they'll require libvirt to first wire up the new QMP command,
> and then apps using libvirt to call it. So in that sense, it'll
> take a while before the effects are seen by users.
> 
> > > so users may end up worse off than if
> > > the functionality were not implemented at all.
> > 
> > If we want to keep the Linux patch, the straight forward way is to send
> > the fix to stable@ then poke at Debian at al to fix their kernels.
> > 
> > Another option is to make the property default to off, have
> > management turn it on when guest is up to date.
> > 
> > But it really sounds like we should revert that Linux patch.
> > I posted a revert, pls comment.
> 
> What about other non-Linux guest OS that may have correctly
> implemented the virtio spec ?
> 
> At least FreeBSD appears to /not/ implemenmt resize at all:
> 
>   https://github.com/freebsd/freebsd-src/blob/main/sys/dev/virtio/console/virtio_console.c#L884
> 
> Do we have a Windows impl of virtio-console with resize support ?

Windows seems to ignore it:

        case VIRTIO_CONSOLE_RESIZE:
            TraceEvents(TRACE_LEVEL_INFORMATION, DBG_PNP, "VIRTIO_CONSOLE_RESIZE id = %d\n", cpkt->id);
            break;



> Any other places we should check ?
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


