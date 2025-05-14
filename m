Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025F6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 00:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF0L4-000843-WB; Tue, 13 May 2025 20:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uF0L2-00083s-BL
 for qemu-devel@nongnu.org; Tue, 13 May 2025 20:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uF0L0-0006jt-4l
 for qemu-devel@nongnu.org; Tue, 13 May 2025 20:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747183866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eB1mz2B6MuYyHj38uzQHqoS/rBeicJhJRy3aXQPwHec=;
 b=FmGm1IvgoMMoA73882DCNiJv/Oy/tC4Gd7aFlWif4BhbRnYFNdvLGa3x8smesLGlYxqYlm
 6d+ukeTyKSBzyg9eYK2D99ocCHWFKFCYYuYCDoqhRdEAuk3xqB6BtlJ7Sax/HKIs9DBJT8
 LZJ3coFL3QEnIR6ihzDboWpQgVFSJ4c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-KPOYdEnaOVS3uxSAFHx48g-1; Tue, 13 May 2025 20:51:05 -0400
X-MC-Unique: KPOYdEnaOVS3uxSAFHx48g-1
X-Mimecast-MFC-AGG-ID: KPOYdEnaOVS3uxSAFHx48g_1747183864
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f6e5d2f612so105349806d6.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 17:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747183864; x=1747788664;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eB1mz2B6MuYyHj38uzQHqoS/rBeicJhJRy3aXQPwHec=;
 b=pzHZ7/PN12uxIyZWHcW0nad9AUX3/C9xoSCXMjHmZSBaeJ/QvVASIdk3Gri+SZv2yh
 fy44AMhNrs2ySLwpMUG+wR8CmMLkX+xaUMzwzk/THJ/WMhLEgyx/6yzvPincFR6x6z/i
 dpn+HCmBRsHtKTHBmJ/lwdHCGFD8pq7BMduwD4zXL4g2GGFGUmbhgGECpRt9RSN9ulT/
 7Z+FSVlEYxWFRMm3ZqN8ZeJkZsqzvRvuZyvunODcDfgUhQUJX8kYvflEQ4m4PsKQ+XCo
 oK9ui3BpSYgf5sNg7njzx4oOcTRP1q/5o0PVRqfKa6cJyoWFH50r6UfDo0rsIDe0H3QM
 3RLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcjpjg4Gmw+2iFOOMyUwzpCz2ebyRwhiSIwMtY3/4wCevEbqXgGVdqoKXzhGd4JOv8TLxiHZKOzhmF@nongnu.org
X-Gm-Message-State: AOJu0YwtXodJq5XNx8yJVncH7w1F2OsdiyMNW0WgWtI53ir87rFUBrhy
 lq38PeyKXiLOaklX0QulSXFGvQQcpr1KtfSCv+83L+ezDtEcWnsDw2cJbO6HomwqB53sUDCYr0q
 UZOeBcStwucC8mzWzln6Hg028KqsYY1aT4V+KIan++bbjRl/yFrpy
X-Gm-Gg: ASbGncu4ADuyMFA+MsiSIVnctkHUnIO0f56EY/1gMjobGzheXSRXxaqfvywjDh0OTOu
 ix5GeYvsuU2AqrbCp+Ht8cBiZeQ6+9AlefhErZOn0sQLAs9ngDCaslmRLL8p47OA0FHHGbhoq2j
 g7pFD7KbVvlBKTRzPvgJzNUJXvQ4NaB6Zpgpy0J0P5aSNjbAAJSAgUT7UHIU0OXoYPcMjKR0yNq
 88DMpSJyEkM3uHuhxDuQVp3fdGO57zURVTOkrwtJoyRUGHVBUxJkHAWY/+1W4G9njXmMrqFgAQw
 ngE0WMXZzkEM9JJH1w==
X-Received: by 2002:a05:6214:dad:b0:6f5:4711:2985 with SMTP id
 6a1803df08f44-6f896e0d587mr26746856d6.10.1747183864458; 
 Tue, 13 May 2025 17:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXLHzplA2pGeQKqAaQZbkI7MHICiZh9lu+QLLIQRP+PBHjw260RijVS7Mg+AdUR8YGEpTmiA==
X-Received: by 2002:a05:6214:dad:b0:6f5:4711:2985 with SMTP id
 6a1803df08f44-6f896e0d587mr26746556d6.10.1747183864068; 
 Tue, 13 May 2025 17:51:04 -0700 (PDT)
Received: from [192.168.21.214] ([69.164.134.123])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f6e39e095esm73294746d6.3.2025.05.13.17.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 17:51:03 -0700 (PDT)
Message-ID: <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
Date: Wed, 14 May 2025 02:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250511-event-v3-4-f7f69247d303@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/11/25 08:08, Akihiko Odaki wrote:
> @@ -387,12 +365,17 @@ void qemu_event_set(QemuEvent *ev)
>       assert(ev->initialized);
>   
>       /*
> -     * Pairs with both qemu_event_reset() and qemu_event_wait().
> +     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
>        *
>        * qemu_event_set has release semantics, but because it *loads*
>        * ev->value we need a full memory barrier here.
> +     *
> +     * qemu_event_wait() do not have a paired barrier on non-Linux because
> +     * ev->lock ensures ordering.
>        */

Thanks for trying to write down the idea.  This works, but there's
still room for improvement. :)  The insight is that the logic becomes:

   if (done == 0) {                  done = 1;
     <read ev->value>                ev->value = EV_SET;
     ev->value = EV_FREE;
     if (done == 0) {
       pthread_cond_wait();          pthread_cond_broadcast();
     }
   }

which is a lot simplified compared to the futex case because all the
differences between EV_FREE and EV_BUSY are replaced by the condition
variable.  In order to avoid the slow path, all that's needed is to
ensure that if qemu_event_reset() sees EV_SET, the caller also sees
done == 1 in the second "if".

The futex case needs qatomic_or() because there can be a concurrent
EV_FREE->EV_BUSY, and a smp_mb() because qemu_event_set() needs to
*read* ev->value.  The non-futex case instead it can do this:

   if (done == 0) {                    done = 1;
     v = load_acquire(ev->value); <--- store_release(value, EV_SET);
     ev->value = v | EV_FREE;
     if (done == 0) {
       pthread_cond_wait();          pthread_cond_broadcast();
     }
   }

where load<---store indicates that the load on the left reads the
value that the store writes, and the store "happens before" the load.
In other words:

- because v reads EV_SET, everything before the store_release is ordered
before everything that follows the load_acquire

- therefore if v reads EV_SET, the pthread_cond_wait() won't be reached
and there's no possibility of a hang (I think :))


This becomes the following patch:

diff --git a/util/event.c b/util/event.c
index 20853d61a7c..489cec08de7 100644
--- a/util/event.c
+++ b/util/event.c
@@ -47,18 +47,14 @@ void qemu_event_set(QemuEvent *ev)
  {
      assert(ev->initialized);
  
+#ifdef HAVE_FUTEX
      /*
-     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
-     *
+     * Pairs with qemu_event_wait() and qemu_event_reset().
       * qemu_event_set has release semantics, but because it *loads*
       * ev->value we need a full memory barrier here.
-     *
-     * qemu_event_wait() do not have a paired barrier on non-Linux because
-     * ev->lock ensures ordering.
       */
      smp_mb();
  
-#ifdef HAVE_FUTEX
      if (qatomic_read(&ev->value) != EV_SET) {
          int old = qatomic_xchg(&ev->value, EV_SET);
  
@@ -71,7 +67,8 @@ void qemu_event_set(QemuEvent *ev)
      }
  #else
      pthread_mutex_lock(&ev->lock);
-    qatomic_set(&ev->value, EV_SET);
+    /* Pairs with qemu_event_reset()'s load acquire.  */
+    qatomic_store_release(&ev->value, EV_SET);
      pthread_cond_broadcast(&ev->cond);
      pthread_mutex_unlock(&ev->lock);
  #endif
@@ -81,6 +78,7 @@ void qemu_event_reset(QemuEvent *ev)
  {
      assert(ev->initialized);
  
+#ifdef HAVE_FUTEX
      /*
       * If there was a concurrent reset (or even reset+wait),
       * do nothing.  Otherwise change EV_SET->EV_FREE.
@@ -92,6 +90,28 @@ void qemu_event_reset(QemuEvent *ev)
       * Pairs with the first memory barrier in qemu_event_set().
       */
      smp_mb__after_rmw();
+#else
+    /*
+     * If futexes are not available, there are no EV_FREE->EV_BUSY
+     * transitions because wakeups are done entirely through the
+     * condition variable.  Since qatomic_set() always writes EV_FREE
+     * the load seems useless, but in reality its acquire synchronizes
+     * with qemu_event_set()'s store-release: if qemu_event_reset()
+     * sees EV_SET here, then the caller will certainly see a
+     * successful condition and skip qemu_event_wait():
+     *
+     * done = 1;                 if (done == 0)
+     * qemu_event_set() {          qemu_event_reset() {
+     *   lock();
+     *   ev->value = EV_SET ----->     v = ev->value
+     *                                 ev->value = v | EV_FREE
+     *   cond_broadcast()
+     *   unlock();                 }
+     * }                           if (done == 0)
+     *                               // qemu_event_wait() not called
+     */
+    qatomic_set(&ev->value, qatomic_load_acquire(&ev->value) | EV_FREE);
+#endif
  }
  
  void qemu_event_wait(QemuEvent *ev)


You don't need to post v4 (which would include the above diff in
this patch, in qemu-thread-posix.c); I can post the above change
as a follow up too.  What you have now is not wrong, it's only the
explanation that isn't too precise.

Paolo


