Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD6CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6QzN-0005Nm-NU; Wed, 08 Oct 2025 06:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v6QzL-0005Kd-Pu
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v6QzI-0001t6-SE
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759917694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2CUweJhwx2ow90f2OQTEPZN3VqDJRDtpui+jMKPHFI=;
 b=Y82JhGBawL+PoQNSweyUApsvbX9PlY72UzbJWMUqbTGTnaJm2Ooie+pepVcgt9XippzLXQ
 mjRtB9qSPEtnwlTiYw1QcPLzduez1B4i+6ylCtBHHzb7+T7XVNyrO6vpciEGWzvoTtYxLW
 4L1xuv0LqkA31++iD0xbHSqjq/D5eTo=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-gX9E1cnbM42DGyHmr325kA-1; Wed, 08 Oct 2025 06:01:33 -0400
X-MC-Unique: gX9E1cnbM42DGyHmr325kA-1
X-Mimecast-MFC-AGG-ID: gX9E1cnbM42DGyHmr325kA_1759917693
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-8e262d00d99so1163758241.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 03:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759917693; x=1760522493;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/2CUweJhwx2ow90f2OQTEPZN3VqDJRDtpui+jMKPHFI=;
 b=uD1xMzUGtk5vdUwWM2gkbbM0s6ZoET1s+e7Q9O7pO7awg+eefD1fvdv6LLDe58J4hi
 vK05D8hkqHmAp1q8tCZ5/DeMrTzf4TA3/cRpxZ5EQDoTqQU619/lP28NjKIqumqVD6nD
 bfJnHRs7zyKXkULBM4hmrjqyH/S4FGimNeB7vNYo3QBC15pIioFwfGf+eGWV6rZSx6TA
 jBZhLeIaLW5IdUREKoQY0iG0erW0/3omcCs5/eZ3e/V87D/BYry6pj16ghKuVkXMfdyN
 3VLck5TMKWMHPfCYkrcdYOgHHHisI+hRP5Vwa53t8VAMSe/sbuLwJg8qL0HZdtMgPcnO
 R6Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxliOEyMl0p9ZlxYzgN0mYshNzXPzqgZcPOgT6sur2nZyhDU6Gi4aLerT2IXdjxnv73SmpDpG7AuzK@nongnu.org
X-Gm-Message-State: AOJu0YyS9AlXq0NOzm8g+MxQZBEstQsLeR9AixiozE9N5nMFExas7Wi3
 ephAR5WFbGOpqUOIptxUxRdvzq3JPa4xdjVbdnDppRYdYO6GGxFFdWvtIqJWb+ywXF+ZAa1kAfN
 ngZ11Cd2uEPiY5BrRHhJmFpro6/KZ12V6BWfYVVOri+nvVLF4VtX4bHdF
X-Gm-Gg: ASbGncsAu7lXA+qoiW2bIBkXMVB0Xx+MwEV2ba/mWB29smFvwKHlxG085FRWCeoiw6j
 45dB4GanIlvq4dknG/LZjGyC7DUztLuTnRIGlM2xfG0SaVNUsLm2uizvLb2QN9e8nu8pHEwrWl2
 QV9OgS5LOSG4o11W39NlSpPlw1RfkzqGaHDodaJL4FaTiUmMdgltKZ4iuhL3ZmrR3hAH3tgsmly
 NO7aeLm2g5N/XsUG4DJ43d6tOtGPGdXNtzgdT3b0aN77cF8hgoFGQ6R6LLuU5Py6KU5q3+6EGc1
 4YrD777/VrmLtxXF+i6sQqwY+ThyiuLPpYc=
X-Received: by 2002:a67:e8d5:0:b0:528:9956:6a3d with SMTP id
 ada2fe7eead31-5d5d4d8c9bemr2571997137.12.1759917692602; 
 Wed, 08 Oct 2025 03:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGClFK2v5lreAvjjWVEiAnf5AEVAZ3uJ8D2A6jJJiSxhalK39ghhbvcoO6UbvD8hmDwKZL9sg==
X-Received: by 2002:a67:e8d5:0:b0:528:9956:6a3d with SMTP id
 ada2fe7eead31-5d5d4d8c9bemr2571974137.12.1759917691985; 
 Wed, 08 Oct 2025 03:01:31 -0700 (PDT)
Received: from redhat.com ([138.199.52.81]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-92eb4d83c45sm4038067241.4.2025.10.08.03.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 03:01:31 -0700 (PDT)
Date: Wed, 8 Oct 2025 06:01:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Alessandro Ratti <alessandroratti@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 49/75] virtio: Add function name to error messages
Message-ID: <20251008060047-mutt-send-email-mst@kernel.org>
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
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


So as you likely already noticed
I replaced just this patch and updated the tag in the pull.

-- 
MST


