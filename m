Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E27C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJb3Y-0000Ys-Vp; Mon, 26 May 2025 12:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJb3U-0000Uy-4F
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJb3R-00032v-HF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748278319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RiK/DV2LcoBhJt46PDdr6ReoA8KaR1GFNX+5XNS7QmI=;
 b=iDkZ8az2dOBO9aLtULAG+T7SIz9D/P98G0FRZoezRNqbQ4YHamkYEzwkIJJxNm3PrDLf7M
 jvzwQnbIJWQZvTVwX9XeROtU3EuyExQ18SqDeemCuW7xIvzKYGUPpQIBUpcbVPaSugHNf+
 dKR2v/SWoGqazgzDYcQP+QsWgqfsGxw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rMlBN1oCOkutKIsAxQT5IQ-1; Mon, 26 May 2025 12:51:57 -0400
X-MC-Unique: rMlBN1oCOkutKIsAxQT5IQ-1
X-Mimecast-MFC-AGG-ID: rMlBN1oCOkutKIsAxQT5IQ_1748278316
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad54ada24ffso226207466b.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748278316; x=1748883116;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RiK/DV2LcoBhJt46PDdr6ReoA8KaR1GFNX+5XNS7QmI=;
 b=BqqGTiEw45Lsg3vaydv+Gs7MLs9a9r6M129m/BnhsFW4CZhDP+HbsHb6zDXPzO/M+Q
 MPHbcZzMpU/3VSHqISmLoRuQcy9byGGXJlqUbOdTp1LZoDYdgMTO9QfM2uVmjPlqxY+u
 SaVUF0XU7KSJb/5hVAvhX/V5NtEpp9iXhCg+BV96O1roWVWxNiX8ovKlRpFJEAjMAfk6
 jeDe5zodwok1Bdoce6ElclcUk4QQjNpQWH4fTH48H9nKCjX9uh4pT13HDS7YIlY0m5m6
 DPJZcqgisuyGFPMYR0RY2WIyjRdwCbq3gzbDyETMRX56SSMvPKcm1fVLyTSNns9JAf5Z
 1DvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYIL6iqseEJDC5/xIxBKA/qXk0cR3HgF08C2jUppwqPxeLLFfi/0xF1HNhfcvhTOHUfSVVip/lxwOF@nongnu.org
X-Gm-Message-State: AOJu0Yz1Sdfgzp8yAxW2dkQHjafLoTJ0xlaS5YX7i54+rE39KjUFyumd
 muwNLCe2wkW10845elcrI1AtYfVxiJ7+9owpdimZ+M1M0SE5Va7WkkJzApXZDfl77Pn8qBykz2D
 56BdppQk+VGz0EAQFj06/FPsu3YNU5IK2zaU0TkcBSNmY1Bw37PD+x3ke
X-Gm-Gg: ASbGncvpYZ+TU/5p2hQQMqy+oLJsfdnE42e7LsqSMPcG3iNV4fG6RZzZguRgjj/WweB
 Bz9+UQdy7VQlodtVkwe7l4fxZ2DVAP4tm7LKC6H+MArNk1GDbruSHSXFQm/agUjcDju6yJD4d0K
 BfkRfiJW5sIu1sYn0gFImyudNkSpTVYH276k1hfJmYXNUGe/P0tbT5jBj21Q9JDr+0zqPdzudJr
 nhLvVbtdr2d0ici3hfhJj6VbjBPyv3qQrnREKE55wsRAPjNiSWha6fpzBjVda38qf/rMbY+R15h
 aYZ4W/WLd5BrZA0n
X-Received: by 2002:a17:907:3f96:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ad85b0e0f05mr780983266b.22.1748278316417; 
 Mon, 26 May 2025 09:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf5/Rd+lOrMXP3AzsqQu1WlSeB/D6xHox72Th7huCa0+jJMyO1X2MxWgBCzzDl2GumOVe7IQ==
X-Received: by 2002:a17:907:3f96:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ad85b0e0f05mr780981866b.22.1748278316026; 
 Mon, 26 May 2025 09:51:56 -0700 (PDT)
Received: from [192.168.182.123] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d441fb5sm1726441566b.108.2025.05.26.09.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:51:55 -0700 (PDT)
Message-ID: <9461fc05-3c1d-4236-a0b7-99f39781f278@redhat.com>
Date: Mon, 26 May 2025 18:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

On 5/26/25 07:29, Akihiko Odaki wrote:
> Changes in v4:
> - Added patch "qemu-thread: Remove qatomic_read() in qemu_event_set()".

Hi Akihiko,

I'm not so confident about putting this patch before the other changes;
I'm referring basically to this hunk:

diff --git a/util/event.c b/util/event.c
index 366c77c90cf..663b7042b17 100644
--- a/util/event.c
+++ b/util/event.c
@@ -48,22 +48,9 @@ void qemu_event_set(QemuEvent *ev)
      assert(ev->initialized);
  
  #ifdef HAVE_FUTEX
-    /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     */
-    smp_mb();
-    if (qatomic_read(&ev->value) != EV_SET) {
-        int old = qatomic_xchg(&ev->value, EV_SET);
-
-        /* Pairs with memory barrier in kernel futex_wait system call.  */
-        smp_mb__after_rmw();
-        if (old == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            qemu_futex_wake_all(ev);
-        }
+    if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
+        /* There were waiters, wake them up.  */
+        qemu_futex_wake_all(ev);
      }
  #else
      pthread_mutex_lock(&ev->lock);


... feel free to resubmit that separately, also because it's missing
a smp_mb__before_rmw().


Also, I'm not sure what was your opinion of the more optimized version
of qemu_event_reset:

diff --git a/util/event.c b/util/event.c
index 366c77c90cf..663b7042b17 100644
--- a/util/event.c
+++ b/util/event.c
@@ -78,6 +78,7 @@ void qemu_event_reset(QemuEvent *ev)
  {
      assert(ev->initialized);
  
+#ifdef HAVE_FUTEX
      /*
       * If there was a concurrent reset (or even reset+wait),
       * do nothing.  Otherwise change EV_SET->EV_FREE.
@@ -86,6 +87,28 @@ void qemu_event_reset(QemuEvent *ev)
       */
      smp_mb__after_rmw();
+#else
+    /*
+     * If futexes are not available, there are no EV_FREE->EV_BUSY
+     * transitions because wakeups are done entirely through the
+     * condition variable.  Since qatomic_set() only writes EV_FREE,
+     * the load seems useless but in reality, the acquire synchronizes
+     * with qemu_event_set()'s store release: if qemu_event_reset()
+     * sees EV_SET here, then the caller will certainly see a
+     * successful condition and skip qemu_event_wait():
+     *
+     * done = 1;                 if (done == 0)
+     * qemu_event_set() {          qemu_event_reset() {
+     *   lock();
+     *   ev->value = EV_SET ----->     load ev->value
+     *                                 ev->value = old value | EV_FREE
+     *   cond_broadcast()
+     *   unlock();                 }
+     * }                           if (done == 0)
+     *                               // qemu_event_wait() not called
+     */
+    qatomic_set(&ev->value, qatomic_load_acquire(&ev->value) | EV_FREE);
+#endif
  }
  
  void qemu_event_wait(QemuEvent *ev)


Do you think it's incorrect?  I'll wait for your answer before sending
out the actual pull request.

Paolo


