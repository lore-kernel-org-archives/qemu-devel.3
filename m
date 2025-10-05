Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF337CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5VHG-0003Po-8w; Sun, 05 Oct 2025 16:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VHE-0003Pd-Bj
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VHC-00066z-J8
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759695851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9Qz4VuaDnMh5XHog06MsfZ7VH+YVpsbTJuaSj4UdGc=;
 b=PXjCwZ2JBMQscEPU+C+7cO2IZR0Cq1jmBFG0xz0HQ0Cjq7nBNvIO8jPDf93urMhUOrhmu6
 1J1F2822NAOnB1eXjbWJFpaLAQbrifVwCtY/0hrNJIv6tFRteFOxgnH1FwIU8LCaZ53h7g
 GnVtMv2BUBbKFPtfo0Yp//vbstbHae0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-A7BP-tM_M56zm-RMtd1tlA-1; Sun, 05 Oct 2025 16:24:10 -0400
X-MC-Unique: A7BP-tM_M56zm-RMtd1tlA-1
X-Mimecast-MFC-AGG-ID: A7BP-tM_M56zm-RMtd1tlA_1759695849
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e4335fa87so21093695e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 13:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759695849; x=1760300649;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t9Qz4VuaDnMh5XHog06MsfZ7VH+YVpsbTJuaSj4UdGc=;
 b=ZKMb4W0Wj6KJuOKbR23kN81BbSMoyxyCAPecjBrIOFP7As3oaaNib8vIl/cq113gPQ
 RD4RzVdXEzMHK+/N+5r/IaT01y/tiIjv8CUw1+GoK5UXT2GecNg8Hf0HKVi3UTxJ2oM9
 RI1HSvPyLJAmoKB2/WOLqTlLimXFC6vryRRwVtLQRcyfYIWp58WPRIc33DTtlwCeTEVI
 bz1sDzlLsWoGRKd1PrI0JeaGvT6d4k+Hwf/0o1Bj4NkmSvXtLglcCBO228knxAzqaYXm
 YI6i3rEjd5CYnhQQcH5+jSQkWTQeDn1nCCbWho1svSvp93sbfELszzFkLwGRPgimHgPz
 5wkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX826760IJzlhR631sUSDd5zwNSuD/hhQHDAun5JD4BFmEZC03ONOROnlrSSaJAqQhvzbb0By4oEEaV@nongnu.org
X-Gm-Message-State: AOJu0YyTWhl+ZU5rmXz5Bu/8GP535fhmIn2GmXKO8gZ0N+iaCkd7Y34m
 hXK77ggiidKeGw5vD/zDOWQsIzVgMxwn7TRNkyGgPZd5eSX93y5T61ghUOH2mHjy/Fp3eBrRYfa
 Gzarr62nH6IjcbC7OI3Tczgm6b8FITY6xXChGMRw0w/M6blsfoviErHX3
X-Gm-Gg: ASbGncuV+PG6otgneSdk+IgiMRCloIucRzE0kGed+R+jznqeHKuBfIDJMjpfmKgGSsC
 CW6o2hZb3zVwE7em9kum2TePyMUfhT6+yfNDayuNRlxDXu1yft2TaVk+ku3R9bPAwr43yOKOC8i
 wx8mh2qEpfH7k8ySrxUxX5iBLcci6nkDQnxCEHVTWpUyXsQ7GBjjLklo8DimnMvtTXOBxibFLUz
 7htq7lpZQ5SGBfkCN0XFdtxrjBaentFmPyML8muOzxGrN8gzvHIVQkAb4feikyMupYoEacr0o3+
 4Ofi0ni+AWjIrEPgCgB95GIDSJgjNEmQbVFDkgE=
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e7110c3d5mr87865595e9.16.1759695848903; 
 Sun, 05 Oct 2025 13:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VPymAX3Qgnv6DFSQbsaN82rp2oB8jXzdsOpkGwVYKbX/LXt1HZR5juizctWvvt9eSAzjLw==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e7110c3d5mr87865485e9.16.1759695848404; 
 Sun, 05 Oct 2025 13:24:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a16e13sm226644345e9.15.2025.10.05.13.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 13:24:07 -0700 (PDT)
Date: Sun, 5 Oct 2025 16:24:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Alessandro Ratti <alessandroratti@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 49/75] virtio: Add function name to error messages
Message-ID: <20251005162310-mutt-send-email-mst@kernel.org>
References: <cover.1759691708.git.mst@redhat.com>
 <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
 <CAKiXHKeXZBS3Zhn+snXi3sxG0r0cmoUW-ekeXHrQS64T10FJPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKiXHKeXZBS3Zhn+snXi3sxG0r0cmoUW-ekeXHrQS64T10FJPQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Oct 05, 2025 at 10:13:57PM +0200, Alessandro Ratti wrote:
> On Sun, 5 Oct 2025 at 21:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Alessandro Ratti <alessandro@0x65c.net>
> >
> > Replace virtio_error() with a macro that automatically prepends the
> > calling function name to error messages. This provides better context
> > for debugging virtio issues by showing exactly which function
> > encountered the error.
> >
> > Before: "Invalid queue size: 1024"
> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
> >
> > The implementation uses a macro to insert __func__ at compile time,
> > avoiding any runtime overhead while providing more specific error
> > context than a generic "virtio:" prefix.
> >
> > Also remove manual __func__ usage in virtio-balloon to avoid duplicate
> > function names in error messages.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-ID: <20250915162643.44716-2-alessandro@0x65c.net>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/virtio/virtio.h | 4 +++-
> >  hw/virtio/virtio-balloon.c | 2 +-
> >  hw/virtio/virtio.c         | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index d97529c3f1..695bb56186 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -253,7 +253,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size);
> >
> >  void virtio_cleanup(VirtIODevice *vdev);
> >
> > -void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> > +#define virtio_error(vdev, fmt, ...) \
> > +    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
> > +void virtio_error_impl(VirtIODevice *, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> >
> >  /* Set the child bus name. */
> >  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index db787d00b3..e443f71c01 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -697,7 +697,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
> >      case PRECOPY_NOTIFY_COMPLETE:
> >          break;
> >      default:
> > -        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
> > +        virtio_error(vdev, "%d reason unknown", pnd->reason);
> >      }
> >
> >      return 0;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index de89e8104a..0f33ca5d90 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3968,7 +3968,8 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
> >      vdev->bus_name = g_strdup(bus_name);
> >  }
> >
> > -void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> > +void G_GNUC_PRINTF(2, 3)
> > +virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...)
> >  {
> >      va_list ap;
> >
> > --
> > MST
> >
> >
> 
> Hi Michael,
> 
> Thanks for picking this up.
> 
> It seems that the version currently queued is actually the initial
> submission, which had previously been rejected following feedback from
> Markus Armbruster.
> I later submitted a corrected version ([v3]) which:
> 
> * Addresses all the feedback (including from Markus Armbruster and
> Daniel P. Berrangé).
> * Has Daniel’s formal Reviewed-by:
> 
> Patch: https://lore.kernel.org/qemu-devel/20250924093138.559872-2-alessandro@0x65c.net/
> Reviewed-by: https://lore.kernel.org/qemu-devel/aNO7J7Y6wsk1-wyw@redhat.com/
> 
> Would you mind updating the queue to reflect this version instead?
> 
> Thanks again for your time and all the work you do maintaining virtio!
> 
> Best regards,
> Alessandro


Oh right. The weird thing is that I reviewed v3 but because it was
a reply when i applied it using b4 it actually picked up original one.
Not good! pls start a new thread each time.


