Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525ACCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNol-0007sD-5a; Wed, 10 Sep 2025 12:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNoh-0007qw-Dn
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNoe-0000JJ-4s
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757522219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IgkosInxAwFZbtna1cBKct9yexaJaomTIjAvlJ5g8I=;
 b=beaIXl58YIYPpkpL19Y9CqkiwOo9xvhIXH9RANdU21crjsAD4nUCQl4e0MUXBu39kchSA4
 Rz2UtItn7zRQ2zHsgehMVjfSLaJrYWWhoZsOEs+7Yit++Yww7m62s8/asQk4BrweoJP9xE
 N9AKwKcd4DL8yLwyDbxa8vfiwfJIRwg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-s5FJfrfROtCZuRwCwpg6Gg-1; Wed, 10 Sep 2025 12:36:58 -0400
X-MC-Unique: s5FJfrfROtCZuRwCwpg6Gg-1
X-Mimecast-MFC-AGG-ID: s5FJfrfROtCZuRwCwpg6Gg_1757522217
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7248ed9f932so87852946d6.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522217; x=1758127017;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8IgkosInxAwFZbtna1cBKct9yexaJaomTIjAvlJ5g8I=;
 b=BeN/Cpw9ZVUIWXyOPeko1cngxkQzuxWHXTDsWn4gIGfTSQQpgmApjldXiT4Wq56u7p
 ZA+V+pFJvyx0kvrX7RtHlHc+IANGWUd/scDwFsiteK1nvFq9PNAfORAWFI/vZ98sVV9n
 oCJjv1u48bqE0kXwKpt5rvhXy5mcD0qs7FlUTbgytJ16BwZg2qLc/hNSEm7RSjLDshAn
 NroMCTsKZ4c4T6LpmRMrj/aZ4S37emAMRs9F+Taipmr/TfgG1Xa19mgs3U9/k8lJ0upN
 O9zIMM8A7eS8wMHVPCt9BTdnDjhSsxXqi7cZaZRo7g2gkERAHe+wmuX3o/XfB1D8iUDQ
 AVRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVat9oNTQNj0yWnEB3TWIjaK24lnyVYPEapfhtw3cG2CRZMdFPO56U7z4Wu+qiFmAVsYIa7rw/SnPEe@nongnu.org
X-Gm-Message-State: AOJu0YzGkavdOGzzFysAJOjh7qVGq8t71O/1NTRKShHMNPsykccpdj/Z
 UXRWxBmVHdQU8TugyG8MGrmW5fq5NQ81scDIF2fytztvRTIHCrh0BzzZSxl+UdDsi5NgvGuiz9M
 lXDjROtlhHClRfJtgHlv4D4qMZmu0P1iAjDS3lbeTIm6cNEjSK5SKLMcW
X-Gm-Gg: ASbGncvXqSLPT5yvQPsazByCb3UiUkbf63s3d6eObPbH2w1xFptRlJz4bB2xZgFSD7Z
 GEZ8dkFYEw8FEZE/SPxDCYtSHkjBaS/mF0PZ1yIFygQxM8uEZkfRcFe/PsPe2HLl95xdvuHvQyR
 FhPbR1bws0i3wO7S0GrdLhlbScvvhlRXUHiM8/13ZF/J9KK1VxmoLvKluaQ3iJZnd/QFN4xXBqn
 TWybTgtokd2BabamCh7yhbcQf09rjxaPTriNKb5ymo1kYug/HtSj2YTK2fhXjB+Qe0xbaY6gUiS
 fV3NoPzaNoXYqN197gneIWumNFbanlKq
X-Received: by 2002:a05:6214:501b:b0:746:9bad:5020 with SMTP id
 6a1803df08f44-7469bad681bmr131948176d6.14.1757522217269; 
 Wed, 10 Sep 2025 09:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcz7yqAXMInlWWTheEIc6mETI7Y8IX9v+mF0R1rnGUn7XhZKjkDE9g7ZP1LSq2eoROmSD0aw==
X-Received: by 2002:a05:6214:501b:b0:746:9bad:5020 with SMTP id
 6a1803df08f44-7469bad681bmr131947556d6.14.1757522216666; 
 Wed, 10 Sep 2025 09:36:56 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-73fc2cdc577sm80793246d6.66.2025.09.10.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:36:56 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:36:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMGpHBGth05JY2hl@x1.local>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMEkY3N9ITwH_Y8Z@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 10, 2025 at 08:10:57AM +0100, Daniel P. Berrangé wrote:
> On Tue, Sep 09, 2025 at 05:58:49PM -0400, Peter Xu wrote:
> > On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> > > On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > 
> > > > Usual system defaults for TCP keep-alive options are too long for
> > > > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > > > before it starts checking if the connection is not broken.
> > > > 
> > > > Now when InetSocketAddress supports keep-alive options [1], this patch
> > > > applies migration specific defaults if they are not supplied by the user
> > > > or the management software. With these defaults, a migration TCP stream
> > > > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > > > second interval before considering the connection as broken.
> > > > 
> > > > System defaults can be still used by explicitly setting these parameters
> > > > to 0.
> > > 
> > > IMHO this is not a good idea. This is a very short default, which
> > > may be fine for the scenario where your network conn is permanently
> > > dead, but it is going to cause undesirable failures when the network
> > > conn is only temporarily dead.
> > > 
> > > Optimizing defaults for temporary outages is much more preferrable
> > > as that maximises reliability of migration. In the case of permanent
> > > outages, it is already possible to tear down the connection without
> > > waiting for a keep-alive timeout, and liveliness checks can also be
> > > perform by the mgmt app at a higher level too. The TCP keepalives
> > > are just an eventual failsafe, and having those work on a long
> > > timeframe is OK.
> > 
> > For precopy it looks fine indeed, because migrate_cancel should always work
> > on src if src socket hanged, and even if dest QEMU socket hanged, it can
> > simply be killed if src QEMU can be gracefully cancelled and rolled back to
> > RUNNING, disregarding the socket status on dest QEMU.
> > 
> > For postcopy, we could still use migrate_pause to enforce src shutdown().
> > Initially I thought we have no way of doing that for dest QEMU, but I just
> > noticed two years ago I added that to dest QEMU for migrate_paused when
> > working on commit f8c543e808f20b..  So looks like that part is covered too,
> > so that if dest QEMU socket hanged we can also kick it out.
> > 
> > I'm not 100% sure though, on whether shutdown() would always be able to
> > successfully kick out the hanged socket while the keepalive is ticking.  Is
> > it guaranteed?
> 
> I don't know about shutdown(), but close() certainly works. If shutdown()
> is not sufficient, then IMHO the migration code would need the ability to
> use close() to deal with this situation.
> 
> 
> > I also am not sure if that happens, whether libvirt would automatically do
> > that, or provide some way so the user can trigger that.  The goal IIUC here
> > is we shouldn't put user into a situation where the migration hanged but
> > without any way to either cancel or recover.  With the default values Juraj
> > provided here, it makes sure the hang won't happen more than a few minutes,
> > which sounds like a sane timeout value.
> 
> Sufficient migration QMP commands should exist to ensure migration can
> always be cancelled. Short keepalive timeouts should not be considered
> a solution to any gaps in that respect.
> 
> Also there is yank, but IMHO apps shouldn't have to rely on yank - I see
> yank as a safety net for apps to workaround limitations in QEMU.

The QMP facility looks to be all present, which is migrate-cancel and
migrate-pause mentioned above.

For migrate_cancel (of precopy), is that Ctrl-C of "virsh migrate"?

Does libvirt exposes migrate_pause via any virsh command?  IIUC that's the
only official way of pausing a postcopy VM on either side.  I also agree we
shouldn't make yank the official tool to use.

OTOH, the default timeouts work without changing libvirt, making sure the
customers will not be stuck in a likely-failing network for hours without
providing a way to properly detach and recover when it's wanted.

Thanks,

-- 
Peter Xu


