Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FD2CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yLX-00083n-Ow; Wed, 15 Oct 2025 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v8yLV-00083N-Ai
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v8yLR-0005fA-SR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760522569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdSIdTxQNirBxzuiZheKaAiqAXxaMLK1jELsCN1JgDk=;
 b=GQT5GIiIom7ZvxMXQuRksIPjX2v+Q8RhSbZktUIDuqYju2jmUVvOoZB5K2aklMo/ChozIj
 xbtX95AmC7wi4lhk57ABeQMQNkUV3l8UvKA3uOgtiSbZ7whxdhusHLR8sMoljQjGTg34hA
 xQYGr8EcOdPIYp8xsTpnUmkJostsYCo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ANE9nl0jP7yZBwxO8HZrmQ-1; Wed, 15 Oct 2025 06:02:45 -0400
X-MC-Unique: ANE9nl0jP7yZBwxO8HZrmQ-1
X-Mimecast-MFC-AGG-ID: ANE9nl0jP7yZBwxO8HZrmQ_1760522565
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78ea15d3548so126157646d6.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 03:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760522565; x=1761127365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdSIdTxQNirBxzuiZheKaAiqAXxaMLK1jELsCN1JgDk=;
 b=t2H/YhXqTMdVVT2EdPLABbEODUtyQ0DQlTUFvA3VRG30sVcmZHAIwkg99BlJjUj2Kb
 uQXULWjTMkNP6H9PsyBtSmGX+pr3fAsJ1a/vUI84lj8/6MAa0i6SdkV+qp6lNigwGBgO
 okW1EdFB/aTyxRBZEZxyi6zWlT0h9TtrlPzy5YD+5hQ+lnf/IJd2CiaKUQKESKZNIROR
 SZHYjhcYITQqOKvuQ8VbDQZ2KI2E62/H97MvFfzfl86ZDnqU73FwBT9X5R1qZEy74KLE
 2+xQm97/ceLZDAV7ayx/6/+w99sg9vZO2zO2qu+kAYtSahu0oCGWh2avXAffK7HoT11G
 plqQ==
X-Gm-Message-State: AOJu0YyKBxz629JqsruqJmtfIgwxFgGJGUYUlyAVwe6GlVVBrUMVl5im
 k9gjrJzk3Qa+U27F/X8lYIgDKFpYeNK/U0gh9B7Y0iI1vB3Hy9cymya5REFkurEQY1j5nOQzxYz
 mXJjUE3nGsFi+z+UQtW0/UFBXvJPm01pDvoX4OCUrqgwkDIs4whwTp2Hq
X-Gm-Gg: ASbGncu2NCSNz9t6lBhZ3oks4MkfI3oJHioUk8s1Xo+2REJbsvHJ3jBQ3kT9bNNGtOQ
 U5yuwyQaaTQMtXodcolieok9R1af6KoWqkProOJZoxVbZJBFRwOW+YkK4MoXZmvKGgM4nu/uOsu
 0apq+GoBEOLZmDc/Y2468DMDw0vO4yo8lNNRJZEM44blHa14CjCMu+FwCPCKbZOM2CaAJWZfDlJ
 aEinC4W5Uj4tyAChrMzwFIja/HbA+zDY0hCxH/qsHLIz1bdZmSOrbiWM21zUVWmkt2/QB7j4rx0
 bvUjbGDdYlXZPRD1TZY3ZvXYI4SdhPm65o3G781c2jt5IgIc0r2m3DRke7hxZjPaFbx363UTvRN
 /eR0xQdMXIwcXMCLh
X-Received: by 2002:a05:6214:ac1:b0:76a:fcee:97aa with SMTP id
 6a1803df08f44-87b2104c13cmr341196676d6.29.1760522564757; 
 Wed, 15 Oct 2025 03:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK6pqWPayCD0KeH9inkS5vwSbAn006bWu2A36kJCt1FrkmJO9t9gz3UYjX8wwaaCjL3jyFlA==
X-Received: by 2002:a05:6214:ac1:b0:76a:fcee:97aa with SMTP id
 6a1803df08f44-87b2104c13cmr341196296d6.29.1760522564255; 
 Wed, 15 Oct 2025 03:02:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0128d7f6sm14849426d6.36.2025.10.15.03.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 03:02:43 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:02:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: fix shared object lookup handler logic
Message-ID: <rkqjxwyd7nvrkklswqkc3mpwopivefjieq5ckbt3jklt43hr5i@4qpv3dx2nogl>
References: <20251015091955.1524800-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015091955.1524800-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 15, 2025 at 11:19:55AM +0200, Albert Esteve wrote:
>Fix vhost_user_backend_handle_shared_object_lookup() logic to handle
>the error path the same way as other handlers do. The main
>difference between them is that shared_object_lookup handler
>sends the reply from within the handler itself.
>
>What vhost_user_backend_handle_shared_object_lookup() returns, depends
>on whether vhost_user_backend_send_dmabuf_fd() succeded or not to send
>a reply. Any check that results in an error before that only
>determines the return value in the response. However, when an error
>in sending the response within the handler occurs, we want to jump
>to err and close the backend channel to be consistent with other message
>types. On the other hand, when the response succeds then the
>VHOST_USER_NEED_REPLY_MASK flag is unset and the reply in backend_read
>is skipped, going directly to the fdcleanup.
>
>Fixes: 160947666276c5b7f6bca4d746bcac2966635d79

Looking at that commit, I honestly don't understand why the reply is 
handled differently for 
vhost_user_backend_handle_shared_object_lookup().
Why can't we handle it here like we do for all the other calls?

If the backend always expects a response for that, can't we do something 
like this? (And of course 
vhost_user_backend_handle_shared_object_lookup() returns the value 
instead of touching the payload.)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..da874c4add 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1790,6 +1790,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      struct iovec iov;
      g_autofree int *fd = NULL;
      size_t fdsize = 0;
+    bool reply_ack;
      int i;

      /* Read header */
@@ -1808,6 +1809,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
          goto err;
      }

+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
+
      /* Read payload */
      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
          error_report_err(local_err);
@@ -1833,6 +1836,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                               &payload.object);
          break;
      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
+        /* The backend always expects a response (XXX: is that right?) */
+        reply_ack = true;
          ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
                                                               &hdr, &payload);
          break;
@@ -1845,7 +1850,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
       * REPLY_ACK feature handling. Other reply types has to be managed
       * directly in their request handlers.
       */
-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+    if (reply_ack) {
          payload.u64 = !!ret;
          hdr.size = sizeof(payload.u64);

Thanks,
Stefano

>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 36c9c2e04d..163c3d8ca5 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1833,8 +1833,11 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>                                                              &payload.object);
>         break;
>     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>-                                                             &hdr, &payload);
>+        /* Handler manages its own response, check error and close connection */
>+        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>+                                                           &hdr, &payload) < 0) {
>+            goto err;
>+        }
>         break;
>     default:
>         error_report("Received unexpected msg type: %d.", hdr.request);
>-- 
>2.49.0
>


