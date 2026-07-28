Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B56C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolIz-0004hT-Vs; Tue, 28 Jul 2026 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wolIx-0004h3-Um
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wolIw-00019a-7j
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785258560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29oMPSRudY4CFShCzj9uyh/PYhvCWsXeWTrY1kVR6Dc=;
 b=Q6+WPooJ/eLWRDhD+TAo1m3prc4tpWh4fv0JaVgBdyX3fEMOalHmnmRxQvdN2l2E7gugQj
 05M3pjwrZgsgolDoLVULVBiL8XFTqpP9bXghMH0wB0/HzxYWavOILeLubYmPzS1AGyS8C7
 KQ4OBIW1YOaF8eOlFpWTH12rqcqkRn4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-FkAgKMXROIOmGXuTY4S-Ow-1; Tue, 28 Jul 2026 13:09:17 -0400
X-MC-Unique: FkAgKMXROIOmGXuTY4S-Ow-1
X-Mimecast-MFC-AGG-ID: FkAgKMXROIOmGXuTY4S-Ow_1785258556
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so413126d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785258556; x=1785863356; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=29oMPSRudY4CFShCzj9uyh/PYhvCWsXeWTrY1kVR6Dc=;
 b=BEz8suh631fG447ASiwTk9Az3sEMccxl9piykDqhmYt9e2KvIWVxELVNvoqWMcfcpu
 IC3uXybQz5HVQXwIOn4OAq6HGNGc50ed038x0XO2xXn4NBpipN/VulfKV4xYwTyrolsX
 DDWfyoJDtx/Gsq5BRcGJRBcsp/VdlDf3ND+DsEjfOt3h2fjyi/iMg024uWvg+tt7v+O9
 QLbbSe3EmNg0Ofsrfjkdf9Br5crEXrhdq9NUoG1CJoOkAuvm2s+SXo2a03FtHPmTF3pi
 zAAtIJZBba1EkRxqZLwmMo/ZoX2zgYQfdMS5Jr5Dzrx5RRu8q2CxRE/FPgR/uF4MLOoN
 /OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785258556; x=1785863356;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=29oMPSRudY4CFShCzj9uyh/PYhvCWsXeWTrY1kVR6Dc=;
 b=KLeC+0Ma8sLjqi47+Y/M/O/BY2u929XvNAjItscStgx2q3p8XeFa3BPdAXBirgOGNv
 XV4UJ0VxOxbO+rLdeO9sfHw3ZimYbw8Z26HlWNW5s8oOEwBDPWr1/3UWSqyWu4SLD/pW
 t1DaP5w0CfVn8yA48obUyc9vNxOPPpb0kp0CVMIw4HxhWyhBOrO3S5hMJogyUKW5JTYZ
 tb/4zMbNgO0TC/ymI+j/9MjMGcWYK4S3+JL7EGGgisXDXIb9k/BYUgWSzsNXdVyNHx67
 NXpf0LOhR8uS8vSjEYphCYGZ7IdD1sUyZXBnojKGNorsmTGMmx1i7YBQ6AteqsSGSZun
 uBJg==
X-Gm-Message-State: AOJu0YyRZJhTMF6+eXfjXSIPer/W4CVUg3G+0AQ2E91prdzAd/q70h+x
 2k4+0nU6piEiBBOeVXPR1mW5dubYcJhWyTSMFGZhIjJ0paw8SWzcFK2Ge3ppICOl/QX946iIe1w
 0d99I1Jvw3PV5UTY1R6HZbmmvgks52SaHz6wdkHdAd8f01P7NGZXW3ITI
X-Gm-Gg: AR+sD120ow163TnFpr7bkm3MFtAdWHKHbf6e6VH3ShWwLuHE1nRONvsgrikgNX6LXPH
 TXW2SOqch6h8llBpVwzkQhb6z5/OqvIwEFIkai0iKhNaEDfxmFMg4c65F1Ft4CDolXDvE0AO7xB
 FpO/9nNfvY8D2OSdIrO62xWtaHdKymQfFeRL0iNfEckKjpIaoD9zOSef9thJEB28qygS6jVXZ9A
 ZxP+P/SH0V1vFmAwZl1QPsphWt6IYG6UW+BR9A4hcYOaDtSD3m1CxoG5tMnvEEqsbaRa7ofyV3A
 tpsYEvXR7I/8jBuVCjocS3C6AgLKw46WpMGf0QuaNmZFHCFbtWHQCYfPjgAJQMdq352I
X-Received: by 2002:a05:6214:3f8c:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-9081704c3abmr33932016d6.21.1785258556163; 
 Tue, 28 Jul 2026 10:09:16 -0700 (PDT)
X-Received: by 2002:a05:6214:3f8c:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-9081704c3abmr33931496d6.21.1785258555429; 
 Tue, 28 Jul 2026 10:09:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dc68182sm3465756d6.11.2026.07.28.10.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:09:14 -0700 (PDT)
Date: Tue, 28 Jul 2026 13:09:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amjiLyOJF92okvik@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com>
 <amjXxDH73ah-dUGE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjXxDH73ah-dUGE@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 05:24:36PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 28, 2026 at 11:52:46AM -0400, Peter Xu wrote:
> > In an unlikely case, when a migration stream is attached to the destination
> > QEMU and only send <4 bytes to the channel as magic, it's possible that
> > migration_channel_read_peek() may spin forever without yielding in the main
> > thread causing two unwanted consequences:
> > 
> > - CPU will spin 100% waiting for the rest bytes until it reaches 4
> > - (more importantly..) Main thread is stuck during this process as the qio
> >   operation won't really yield the coroutine
> > 
> > Fix it by consuming the bytes that arrived.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 1e2935f926..28fe1d2906 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >              return -1;
> >          }
> >  
> > -        if (len == buflen) {
> > +        if (len == iov.iov_len) {
> >              break;
> > -        }
> > +        } else if (len == 0) {
> > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > +        } else {
> > +            ssize_t received = len;
> >  
> > -        qio_channel_wait_cond(ioc, G_IO_IN);
> > +            /*
> > +             * Partially arrived, read out to make qio_channel_wait_cond()
> > +             * won't return immediately, causing an unwanted spin on this
> > +             * CPU.
> > +             */
> > +            iov.iov_len = len;
> > +            len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL, 0, errp);
> 
> Sure this breaks the API behaviour that the caller is expecting to
> see.
> 
> migration_channel_identify will call migration_channel_read_peek
> to match the magic bytes.
> 
> But something later in the flow will actually try to read the magic
> bytes.  By consuming them in this migration_channel_read_peek
> method, surely we're breaking the code that wants to read the bytes
> later.

Ah right, stupid me.  The best then is for partial read we apply a manual
wait.

I can also revert 604bb1badc ("migration: Properly wait on G_IO_IN when
peeking messages"), looping with 1ms interval for data isn't too bad.  But
the best is we only do that for partial, so:

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..88f89521f8 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -296,9 +296,19 @@ int migration_channel_read_peek(QIOChannel *ioc,

         if (len == buflen) {
             break;
+        } else if (len == 0) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+        } else {
+            /*
+             * When partially ready, we can't use qio_channel_wait_cond()
+             * because it will return immediately.  Apply a manual wait.
+             */
+            if (qemu_in_coroutine()) {
+                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
+            } else {
+                g_usleep(1000);
+            }
         }
-
-        qio_channel_wait_cond(ioc, G_IO_IN);
     }

     return 0;

Any preference?

Thanks,

> 
> > +            /*
> > +             * QIO_CHANNEL_ERR_BLOCK also shouldn't happen, due to the
> > +             * prior peek just happened.  We should be pretty sure we will
> > +             * read what we peeked, or the channel was broken.
> > +             */
> > +            if (len != received) {
> > +                return -1;
> > +            }
> > +            iov.iov_base += received;
> > +            iov.iov_len = buflen - received;
> > +        }
> >      }
> >  
> >      return 0;
> > -- 
> > 2.54.0
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 

-- 
Peter Xu


