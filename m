Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07317CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJb9z-0005bq-Pp; Thu, 13 Nov 2025 12:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJb9r-0005Yt-Au
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJb9p-0004MP-De
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763055050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sfb9rDcsR549HIBKdlZi74Kzx0c2W0GF1kOQc/lOnRw=;
 b=HR+c/KCGQzRCj9Vxn6bPjyXSJqmvXREtJU++BoJtksyGVWsLaxLS2yo8eMKddD6yzosw5o
 DX32Byoqa99/pk9ucNxDACJsgUHUgn91fo+ojouFq7aWdPYBauWak7fySxC4a+SbszN6dw
 AV9bykdj2Ebd0K8UtpuNka+xbgKFstI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-pYJhKr9iO2qWJ7PlTUv0Jg-1; Thu, 13 Nov 2025 12:30:49 -0500
X-MC-Unique: pYJhKr9iO2qWJ7PlTUv0Jg-1
X-Mimecast-MFC-AGG-ID: pYJhKr9iO2qWJ7PlTUv0Jg_1763055049
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a5b03118f4so667950585a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763055049; x=1763659849; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sfb9rDcsR549HIBKdlZi74Kzx0c2W0GF1kOQc/lOnRw=;
 b=SxIvRT2X2GGYRepBMye5ZzUH7i+ZiD7MT3GDB3MOLcsKXmGdsuT+HXu5XVf/E1B+67
 3Df2tadWlOqwi9Kt5ubrik8jjpgxrpzyLi/KEK1NVX9yRkCbEir/ByEeLVxy3oqvrOV6
 xuhfpDWyvkbiSnqyU3gtqFEeV99ICJYrrCf9sXoNxRXdTcEd5nm9SpFiARslIhFGtkX2
 W+usvE69KxI0SncVdUDq/mlxvnvs5tAiOieaQF5BedOOKyiwL5JaNjC23yj+KQ7+M9uo
 byCER/y11My4JxtTT20rkjJxN8B3EzaGVg6AfpWX94NZHF9EhPc43r4wPqiEpMnQrt3f
 mXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763055049; x=1763659849;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sfb9rDcsR549HIBKdlZi74Kzx0c2W0GF1kOQc/lOnRw=;
 b=T8CbfN0rGdhwZzhH97N3ceGmvTyEhm3Al01yHRyRHk9thkXTvWTTzSKw0yA2saALr3
 h6Ce6DT3P2HO6Sla/EtZS+/ZiyvIH3dhzAdO0DsDnCh1Xq53sxZCBwOTMA5+3yrMeV+L
 NIk/e6E+fMg2mf22SmG8MMci3EK9G4wCOSXLONMOJ1cV80zd2VJySFFuaYFZVEKB3wAX
 UqV1HZoLaxupj5Ahb/NMGpLcXypY6Z7bzSU75/lHL6MadN4x80/vtN0pnJJREB9XPetN
 bddOYnsrfwVmXVV0wN5h9Zhy9sakeQFvNnRaKBKSeEqUUbz6l5Dm41rCJKbluCXk6XR+
 cyTg==
X-Gm-Message-State: AOJu0YymHiNljfiY8blCy9WmdSQJwLxUOCdWYwVvH90m4HR7xXYdIekY
 W+qevvOERDzdjMA4RTi/NmzsHjhBtE5uD10kx4C5D42EUUrIYUPi4rqGhxbaL7yXcxop43Lf3I+
 Yp4maAsKnTlPUg1SckktyBhVmTGPviaWZsDhdYhJRG2VCigxkW3yaCxK7
X-Gm-Gg: ASbGncu1UR3/gtbZVtWJ0CzvTR5f+29u9mAS2hgsydKIWbVxaP7tc7MKG9ofqrmqzLo
 wVx0lcCFCdnltCgm5G+JW3cPi93CFdV63Cjgw2g+fhcuS7C6sPMYCdrltCC/gY8+AfDRLDhl7us
 O7UUEhrGx2ehvhAyp2Ds0sF5ZqNuN8GYianCKYvX1v/Y781fkxsL07NicJK3aMhwKDvJyRHK/Sl
 QYYXkk8mE++UCVDOX4T2cDfVE9Ir2e9LgEeoN23OY+PceVpHM98NeNtrFAFoPI/jOYn6AIaPYqN
 8iJEG4XHHo0yCuBJB4b1iu+8ClkQl8xepMZD+ncav1L+7i4OX8uG5FJKQyy+kxa43W8sGPlNS4d
 MRw==
X-Received: by 2002:a05:620a:390e:b0:84b:7b84:4ec with SMTP id
 af79cd13be357-8b2c046ede1mr62279085a.22.1763055048757; 
 Thu, 13 Nov 2025 09:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZfr16TVA59UEv/smsYBxEZO55ioY2Si7XCbjgDYHe4Ui5ch8XmJRntn7oXhjdP1vNVE+cKA==
X-Received: by 2002:a05:620a:390e:b0:84b:7b84:4ec with SMTP id
 af79cd13be357-8b2c046ede1mr62271785a.22.1763055048129; 
 Thu, 13 Nov 2025 09:30:48 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aeeaf78bsm170216885a.15.2025.11.13.09.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:30:47 -0800 (PST)
Date: Thu, 13 Nov 2025 12:30:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aRYVw1ydTbZr0OEH@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <1b318ad8-48b3-4968-86ca-c62aef3b3bd4@rsg.ci.i.u-tokyo.ac.jp>
 <7c49d808-ccb8-4262-ae6c-2ac746b43b80@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c49d808-ccb8-4262-ae6c-2ac746b43b80@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Hi, Akihiko,

I found that you replied to me and forgot to cc all, I added all of the
people back.

On Sun, Nov 09, 2025 at 06:05:00PM +0900, Akihiko Odaki wrote:
> On 2025/11/08 10:45, Akihiko Odaki wrote:
> > On 2025/11/07 6:52, Peter Xu wrote:
> > > When I was having a closer look, I found some other issues, I'll list it
> > > all here.
> > > 
> > > 1. I found that rcu_gp_event was initialized as "true".  I'm not sure
> > >     whether it should be false.  This has nothing to do with your
> > > series as
> > >     well, only some observation of mine.
> > >      qemu_event_init(&rcu_gp_event, true);
> > 
> > Indeed it makes more sense to initialize it with false.
> > 
> > rcu_read_unlock() sets the event only in grace periods, and
> > wait_for_readers() always reset it when ending those grace periods. By
> > initializing it with false, the event will be false whenever outside
> > grace periods, improving consistency.

Thanks for confirming this. AFAIU this isn't a huge deal, as
wait_for_readers() should be tolerant of false positives.  So I'll leave it
to you on whether to touch it together.

> > 
> > > 
> > > 2. It looks to me your patch here checked the wrong retval of
> > >     qemu_event_timedwait()..
> > > 
> > >          } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> > >                     !sleeps || qemu_event_timedwait(&sync_event, 10)) {
> > >                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > >     should it be "!qemu_event_timedwait(&sync_event, 10)"?  Side
> > > note: maybe
> > >     we should cleanup all _timedwait() for QEMU's eventfd, sem, cond,
> > >     ... because they don't return the same retval.. but if you think
> > > sem is
> > >     good, then we don't need eventfd's timedwait() in this series (your
> > >     initial two patches).
> > 
> > You are right here too. This is a stupid mistake.
> 
> No, the original patch is right. qemu_event_timedwait(&sync_event, 10)
> returning true means that the forced variable was set before timing out,
> hence the we need to enter the force quiescent state.

You're correct.  I got misleaded by the comment here:

            /*
             * Now one of the following heuristical conditions is satisfied:
             * - A decent number of callbacks piled up.
             * - It timed out.                <--------------------
             * - force_rcu() was called.
             *
             * Force a quiescent state.
             */

I'm guessing you got misleaded too when I raised the question and when you
were looking.  Maybe it means it would be good to change that line of
comment into:

             * - It timed out continuously 5 times (causing sleeps==0)

> 
> > 
> > > 
> > > 3. I doubt if malloc_trim() feature is broken with your current patchset,
> > >     because now the loop looks like:
> > > 
> > >          for (;;) {
> > >              qemu_event_reset(&sync_event);
> > >              n = qatomic_read(&rcu_call_count);
> > >              if (n) {
> > >                  break;
> > >              }
> > > #if defined(CONFIG_MALLOC_TRIM)
> > >              malloc_trim(4 * 1024 * 1024);
> > > #endif
> > >              qemu_event_wait(&sync_event);
> > >          }
> > > 
> > >    I don't know if n can be zero here at all.. if you use the sem change
> > >    this might trigger but it's not designed for it.  When using sem
> > > we may
> > >    want to periodically trim.  But I'd like to know how you think in
> > > general
> > >    on the sem idea first (e.g. do we need to be prepared for high
> > > freq rcu
> > >    frees).
> > 
> > malloc_trim() is triggered when the RCU thread is idle, and that is not
> > changed with this patch.

You're right, I read it wrong.  Please ignore this comment.

Thanks,

-- 
Peter Xu


