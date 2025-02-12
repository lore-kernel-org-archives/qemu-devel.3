Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ABFC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCn6-00010h-8g; Wed, 12 Feb 2025 08:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tiCn4-0000yD-BD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:28:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tiCmg-0005rz-Ah
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739366889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEj/jK9Mogp0u1xfUJl4Wyrw4QU1gPX8Fw3ds5HAFx0=;
 b=DNKWvy5VokreCSqsoOoO6NdBOoB14Qgs23IbQcYyMZtDgUo+Vgs5rYzXyWagRFd9/QpCFy
 h/Mn0n+9VzOxx3s2B5PJUHQpCEmoGIMkQAbZuR9WVKuRSdofr+VH/a1/Ka4woHOSjdyGhh
 v/5RBy69WUuzmEYvBCym+CgFEx+B9DE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-0XjnnrZYNVWLCDlj8nbhig-1; Wed, 12 Feb 2025 08:28:08 -0500
X-MC-Unique: 0XjnnrZYNVWLCDlj8nbhig-1
X-Mimecast-MFC-AGG-ID: 0XjnnrZYNVWLCDlj8nbhig
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393535043bso4707195e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739366886; x=1739971686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wEj/jK9Mogp0u1xfUJl4Wyrw4QU1gPX8Fw3ds5HAFx0=;
 b=Bq+G/petg0WzY3jMVSevVzoGTxgdJqA+mvVn0gqiMmDzTubLztky7cmJdFII7rmQUs
 mHdHTx0lGrr2UghtDPnHXwJYJ4kJJ/fmD28e/jJP3nHdjl8W18NFZ3hd4PAvw3UZpQmW
 x3ijIfOOxmpCMKgL1RX75oMNJBcSa66h5ew9HIqgg6aWUQkvmA9sMvca/8g3+EdOnWGT
 FOVChEh8AB5lrZscuv90WUrv5XR7df9SRUdQOrwlEOZxhd10Q0IBrDogH+hZ/LGV+CF5
 b/wDGuIcn7GcIB5RzSXkKiMk+9PKiny6bGgKmudTJ35F4Q+TVdIp+KxaVGOa5LB3A7Wq
 mIuA==
X-Gm-Message-State: AOJu0Ywxz2nDsev5C25FEcS51co/INUnPssVWjSw91QIkodUiUupX6Db
 LRBozmL2cjynTLhhTiCM96WBQW8ntfTjmUozxn0g62R9sFwWRAeB9fD8nuXgJPL1QjIWbueEbl5
 DMzjEJG+Ra6axpyBg7a4ULLwhhfEQZbEStzgqS4qqfXLwETUoAeSCMRUCa+kqBhHiqUvUHdwt3g
 3oeqhSgsDQwZUaatI84XyZKVRMqCng7ChusoSLaA==
X-Gm-Gg: ASbGnctps420vrHT5VHTnvU1WqcxTLBSZP43dSmaUWsHG0fzxS+9QBeeL4LdKfe3j3+
 oJPn85GL00aySSZyzWX9DSyJqwzVpbRfLWNpVwF+IqPEVf1gCFwMhsld9qh5QmWtz
X-Received: by 2002:a05:600c:1d9b:b0:438:e2ce:92d2 with SMTP id
 5b1f17b1804b1-439583a8e84mr25021245e9.4.1739366886113; 
 Wed, 12 Feb 2025 05:28:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrGprCFv+uqlSEOrWq74yJsHi/xhcLChDgEDI3Sl4tNSbQd6rC6fxXijOhiImBsBU0PdGFAc3qOKJ0gO7fouo=
X-Received: by 2002:a05:600c:1d9b:b0:438:e2ce:92d2 with SMTP id
 5b1f17b1804b1-439583a8e84mr25020895e9.4.1739366885438; Wed, 12 Feb 2025
 05:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
 <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
 <Z6tqq5jpbDHsVtVw@x1.local>
In-Reply-To: <Z6tqq5jpbDHsVtVw@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 12 Feb 2025 18:57:48 +0530
X-Gm-Features: AWEUYZlUiag1hJyPtaWzV1kvZsryqb_LShfDYZOfNGYyDH22sfiLwJ9T9722FRU
Message-ID: <CAE8KmOwxobOtw0B4UVECFtgTdbMtOU2Sw09WqYryYYzG+d_UJQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On Tue, 11 Feb 2025 at 20:50, Peter Xu <peterx@redhat.com> wrote:
> > * Yes. AFAIU, tls/file channels don't send magic values.
> Please double check whether TLS will send magics.  AFAICT, they should.
===
  * ... Also tls live migration already does
  * tls handshake while initializing main channel so with tls this
  * issue is not possible.
  */
  if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
  } else if (mis->from_src_file
           && (!strcmp(ioc->name, "migration-tls-incoming")
            || !strcmp(ioc->name, "migration-file-incoming"))) {
        channel = CH_MULTIFD;
  }
===
* From the comment and condition above, both 'tls' and 'file' channels
are not peekable, ie. no magic value to peek. The
'migration-file-incoming' check also helps to cover the
migrate_mapped_ram() case IIUC.

> No.  We need to figure out a way to do that properly, and that's exactly
> what I mentioned as one of the core changes we need in this series, which
> is still missing.  We may or may not need an ACK message.  Please think
> about it.

* First we tried to call 'multifd_send_shutdown()' to close multifd
channels before calling postcopy_start(). That's the best case
scenario wherein multifd channels are closed before postcopy starts.
So that there's no confusion and/or jumbling of different data
packets. It did not work, as qemu would crash during
multifd_shutdown().

* Second is we push/flush all multifd pages before calling
postcopy_start() and let the multifd channels exist/stay till the
migration ends, after that they are duly shutdown. It is working well
so far, passing all migration tests too.

* Third, if we want to confirm that multifd pages are received on the
destination before calling postcopy_start(), then the best way is for
the destination to send an acknowledgement to the source side that it
has received and processed all multifd pages and nothing is pending on
the multifd channels.

* Another could be to define a multifd_recv_flush() function, which
could process and clear the receive side multifd queue, so that no
multifd pages are pending there. Not sure how best to do this yet.
Also considering it lacks proper communication and synchronisation
between source and destination sides, it does not seem like the best
solution.

* Do you have any other option/approach in mind?

> Please consider the case where multifd recv threads may get scheduled out
> on dest host during precopy phase, not getting chance to be scheduled until
> postcopy already started running on dst, then the recv thread can stumble
> upon a page that was sent during precopy.  As long as that can be always
> avoided, I think we should be good.

* TBH, this sounds like a remote corner case.

* I'm testing the revised patch series and will send it shortly.

Thank you.
---
  - Prasad


