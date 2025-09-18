Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C030CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzMT5-0007nx-6L; Thu, 18 Sep 2025 17:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzMSy-0007nM-JG
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzMSx-0001CI-31
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758232017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpt2drOm7EGrzNcCmtmhb3hfBq4th4EbCCrex1nM/gQ=;
 b=ZImZiiRgGeYWlw6NN8MWTdjX1pW2ARZzub2JXp4KIHWR7ws45Ku9eDaTfKWW6PtGxh1zh4
 pD9yWaV2mQ7sXnsIdYgh5CcuGOqSW3C/JMX6J+Ut+J5kPF+NyjSajSmfjuemFLUwKF8sG/
 ktL9oohiZBsFjpoBD3e2CChJWbl9xIQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-6gtxDW4xOM-d1DdIByUUgg-1; Thu, 18 Sep 2025 17:46:53 -0400
X-MC-Unique: 6gtxDW4xOM-d1DdIByUUgg-1
X-Mimecast-MFC-AGG-ID: 6gtxDW4xOM-d1DdIByUUgg_1758232013
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78ea15d3548so13948066d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 14:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758232013; x=1758836813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpt2drOm7EGrzNcCmtmhb3hfBq4th4EbCCrex1nM/gQ=;
 b=Tne3wviEXwJD/PtuY7wNBNw/XNcnPLz47Kkb3pzREp1AlLxcp/wr2EanBjCrs+hHS8
 8t1+2JqAHNSFbD7nUZKaNY4RjhYd5tVI45EuMI6OrG/adfXXgMD5HgeOTSVBbfnq2egF
 r/Nbv2N7hqksGM7qKsXhKI0tLTz3wpkl3bJOhve1gmTSGVuzyqV76NGZep7sOXHOCowO
 /aTn0PmHWBrsGP2w1kXgEctMUgOqIZ07nuJWZr3iIZNwEiZwR3t3fCOqvz233pXYtUM3
 QVr778IDKdVOnhE67/LoC79qrGFfNhi/xP3lqzqjBZLW8dpTevBHrbmnVxe9Dffaf2iR
 GQUA==
X-Gm-Message-State: AOJu0YwlPmeVZBmCxvmOrXqpletosoaKdvFYz8OqrWjWSMjb5nMP0Eq3
 Ptoj++CW6gKFYtqEkPNJJREQgqyee/o4psIruPvDT77CJS5BjPwWMOEkfKE2KV634DdjUzlFftU
 r+xfH8M651CkMIf1YueLMXGRKU+aQ5sBOd9xkh29Ovy8tOerGdXVZI3EV
X-Gm-Gg: ASbGncvwmvPG9+DxFrCRnwFhg0jeMTTvV2Lttkr7SSjdsBvLoSssStw3/XAsP0IHGoU
 2p7kul31Stxq78LAiYZUtdFdP3MjtN6X8bG3Le+S67W1q96uHTwtAOk1iqI8bU4KaWfq1fFTfMe
 Xi3UJH/+lORCxBDdbOYjA2mOdMnRiSrySASGGGx8NKlLhuJJJZ+psVfj3IxZy9ldCK59tXoLa1f
 WMdaU2LyqcScm+REfJz4PM+cORsubH7qRHX5uicDfHykeHJEAe0GPFRMCCqsGyIfoCYQckVu3mi
 575+coF2myIuvCnukCO/IBr6JAORD/fSfT9CDjbiY7qJPGZm+B1G7nKquxD5qm4Z1fdxg7peeXG
 UaZnBw73gjZ7by5juEormkg==
X-Received: by 2002:a05:6214:5289:b0:76a:7ff4:cb85 with SMTP id
 6a1803df08f44-79914920336mr14546166d6.19.1758232013251; 
 Thu, 18 Sep 2025 14:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWJRGyYgS+ZxZ6LMsg5ebPfutqD1M4SWCKtwZXnYUz9+GQeSca8hnoBO8PFZ1Op63vBC0SGQ==
X-Received: by 2002:a05:6214:5289:b0:76a:7ff4:cb85 with SMTP id
 6a1803df08f44-79914920336mr14545986d6.19.1758232012869; 
 Thu, 18 Sep 2025 14:46:52 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793446acfa6sm19288186d6.14.2025.09.18.14.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 14:46:52 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:46:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
Message-ID: <aMx9yi628fuXr_gH@x1.local>
References: <20250918203937.200833-1-peterx@redhat.com>
 <875xdfv4su.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xdfv4su.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 18, 2025 at 06:17:37PM -0300, Fabiano Rosas wrote:
> > ============= ABOUT OLD PATCH 2 ===================
> >
> > I dropped it for now to unblock almost patch 1, because patch 1 will fix a
> > real warning that can be triggered for not only qtest but also normal tls
> > postcopy migration.
> >
> > While I was looking at temporary settings for multifd send iochannels to be
> > blocking always, I found I cannot explain how migration_tls_channel_end()
> > currently works, because it writes to the multifd iochannels while the
> > channels should still be owned (and can be written at the same time?) by
> > the sender threads.  It sounds like a thread-safety issue, or is it not?
> >
> 
> IIUC, the multifd channels will be stuck at p->sem because this is the
> success path so migration will have already finished when we reach
> migration_cleanup(). The ram/device state migration will hold the main
> thread until the multifd channels finish transferring.

For success cases, indeed.  However this is not the success path?  After
all, we check migration_has_failed().

Should I then send a patch to only send bye() when succeeded?  Then I can
also add some comment.  I wished we could assert.  Then the "temporarily
changing nonblock mode" will also rely on this one, because ideally we
shouldn't touch the fd nonblocking mode if some other thread is operating
on it.

The other thing is I also think we shouldn't rely on checking
"p->tls_thread_created && p->thread_created" but only rely on channel type,
which might be more straightforward (I almost did it in v1, but v2 rewrote
things so it was lost).

-- 
Peter Xu


