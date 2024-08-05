Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F7EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauuZ-0006JR-1k; Mon, 05 Aug 2024 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sauuW-0006DW-PL
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sauuV-0005dn-46
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722853550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8m2Gg8DorNJmKBlE1ZWL4GQkRu+GOlJ8DnFDUP1Q4A=;
 b=H+uj8+/tLlNcPy+1G+s5IcfpIwv1MyhlHqIv0AuqyzHFZYZeww+oWQ8XXmF5Q8g9OkmzSQ
 V3bnHzOgnj0mJjpPC+L1YHvFa562Yi1EyPTzLtEZWC1iOEayJW6BgIq9B9xbMOLEIKh2O1
 KCvNVA8XGN9vaPQ9F+HieMigezhmCxs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-RAs7wadjMQGGXnKWTL4Eag-1; Mon, 05 Aug 2024 06:25:48 -0400
X-MC-Unique: RAs7wadjMQGGXnKWTL4Eag-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d9a712bcso506307985a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722853548; x=1723458348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8m2Gg8DorNJmKBlE1ZWL4GQkRu+GOlJ8DnFDUP1Q4A=;
 b=m5VHNgc6QyQdyZlci5uYLaMMaWFuEf95iLHEjtQ75d/MT7H4He2DOW5k8uvjeWCzaF
 C1fBd1ToooDtaKy0ozO/Tz41BSQaSi2SY8qWrnJRG/fn7FqwC3xQ0svVAhhpX43olcZw
 grcLgJEtI+aUE3zeKXcDp69lFOKmdyHG5Yke2ZYok0KyQzYlLuQYMLVbnJwq3HOOPwlb
 qkhGepzxY6Crzzgq4Hn39+e93t74PugA1IiVdVwxF9mhB2qe+OCHS5vmSYlBAwOu1XXx
 3OaOhmuV0wAgSBuU9bH3Byv/33Z0zvbJJ7S4rQPDUxM4f+6V5aNCVuuD3R6g5O6bMvS3
 z2rQ==
X-Gm-Message-State: AOJu0Yx5PQMjSrxL2ibo8aHFzSV1D+PeOAx02pnB6Dn3e/N0Zw77tGJI
 UF55MfFYxHYivnEe0CNscdco8UQJ70Zu0q12XJ6QJqEEB/qAN0JEVIdTf160b5keq49C+HI/ryQ
 4d92b0Xjv0et6cul0NhXQf0mKZHNUEJ7uXTPkI/SjBNwgRLWoOzxO
X-Received: by 2002:a05:620a:4153:b0:7a2:2b2:c1f3 with SMTP id
 af79cd13be357-7a34c07f3e5mr2151581885a.21.1722853548133; 
 Mon, 05 Aug 2024 03:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Hi4UMzYfi1Lz1Ncf7/aLkDe2QbtbOdW/Rd2kwMT3KHLg0l1Vz3Ip+RVX10PMPykJ4qUZNg==
X-Received: by 2002:a05:620a:4153:b0:7a2:2b2:c1f3 with SMTP id
 af79cd13be357-7a34c07f3e5mr2151576885a.21.1722853547344; 
 Mon, 05 Aug 2024 03:25:47 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it.
 [82.57.51.79]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a34f78383dsm332795685a.99.2024.08.05.03.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 03:25:46 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:25:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: rewrite vu_dispatch with if-else
Message-ID: <3ah6jmrx7buizqytjgzx2oe5jlyv225pa4dih3tfs4g4ovngyd@t3sdu6mhmghr>
References: <20240804142353.25342-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240804142353.25342-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Aug 04, 2024 at 10:23:53PM GMT, luzhixing12345 wrote:
>rewrite with if-else instead of goto

Why?

IMHO was better before this patch with a single error path.

>
>and I have a question, in two incorrent cases
>
>- need reply but no reply_requested
>- no need reply but has reply_requested
>
>should we call vu_panic or print warning message?
>
>---
> subprojects/libvhost-user/libvhost-user.c | 39 +++++++++++++----------
> subprojects/libvhost-user/libvhost-user.h |  6 ++--
> 2 files changed, 27 insertions(+), 18 deletions(-)
>
>diff --git a/subprojects/libvhost-user/libvhost-user.c 
>b/subprojects/libvhost-user/libvhost-user.c
>index 9c630c2170..187e25f9bb 100644
>--- a/subprojects/libvhost-user/libvhost-user.c
>+++ b/subprojects/libvhost-user/libvhost-user.c
>@@ -2158,32 +2158,39 @@ vu_dispatch(VuDev *dev)
> {
>     VhostUserMsg vmsg = { 0, };
>     int reply_requested;
>-    bool need_reply, success = false;
>+    bool need_reply, success = true;
>
>     if (!dev->read_msg(dev, dev->sock, &vmsg)) {
>-        goto end;
>+        success = false;
>+        free(vmsg.data);
>+        return success;
>     }
>
>     need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
>
>     reply_requested = vu_process_message(dev, &vmsg);
>-    if (!reply_requested && need_reply) {
>-        vmsg_set_reply_u64(&vmsg, 0);
>-        reply_requested = 1;
>-    }
>-
>-    if (!reply_requested) {
>-        success = true;
>-        goto end;
>-    }
>
>-    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>-        goto end;
>+    if (need_reply) {
>+        if (reply_requested) {
>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>+                success = false;
>+            }
>+        } else {
>+            // need reply but no reply requested, return 0(u64)
>+            vmsg_set_reply_u64(&vmsg, 0);
>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>+                success = false;
>+            }
>+        }
>+    } else {
>+        // no need reply but reply requested, send a reply
>+        if (reply_requested) {
>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>+                success = false;
>+            }
>+        }
>     }
>
>-    success = true;
>-
>-end:
>     free(vmsg.data);
>     return success;
> }
>diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
>index deb40e77b3..2daf8578f6 100644
>--- a/subprojects/libvhost-user/libvhost-user.h
>+++ b/subprojects/libvhost-user/libvhost-user.h
>@@ -238,6 +238,8 @@ typedef struct VuDev VuDev;
>
> typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
> typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
>+typedef uint64_t (*vu_get_protocol_features_cb) (VuDev *dev);
>+typedef void (*vu_set_protocol_features_cb) (VuDev *dev, uint64_t features);

Are these changes related?

Stefano

> typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                   int *do_reply);
> typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
>@@ -256,9 +258,9 @@ typedef struct VuDevIface {
>     vu_set_features_cb set_features;
>     /* get the protocol feature bitmask from the underlying vhost
>      * implementation */
>-    vu_get_features_cb get_protocol_features;
>+    vu_get_protocol_features_cb get_protocol_features;
>     /* enable protocol features in the underlying vhost implementation. */
>-    vu_set_features_cb set_protocol_features;
>+    vu_set_protocol_features_cb set_protocol_features;
>     /* process_msg is called for each vhost-user message received */
>     /* skip libvhost-user processing if return value != 0 */
>     vu_process_msg_cb process_msg;
>-- 
>2.34.1
>


