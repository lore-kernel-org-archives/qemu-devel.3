Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E17C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpPe-0005bq-6n; Mon, 20 Jul 2026 10:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpPc-0005as-1n
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpPZ-0006bv-IW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784559364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/dNhP/hlenTslbWVq/aK+TWpphzb5rLSJeofrkfasts=;
 b=UIoym0Qe+6gmcWAxtdnMHLoCg8G2IlDuPpvewPltvoqqdomvZxHZ5j+8cXICwnwEoNQryw
 6rhI56wOL0/PL05Ns963HYyiKHIYdtPX+RGsrpGr9TtFsWDw5vPdd0wc9nLRXMgSw0FbDR
 OwjrQlvIjz7hFHWPHeP8/NhgBGHYjU8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-n5zDQVUCMhO_NSN-apC5PA-1; Mon, 20 Jul 2026 10:56:02 -0400
X-MC-Unique: n5zDQVUCMhO_NSN-apC5PA-1
X-Mimecast-MFC-AGG-ID: n5zDQVUCMhO_NSN-apC5PA_1784559362
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930dda91cbdso185363185a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784559362; x=1785164162; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/dNhP/hlenTslbWVq/aK+TWpphzb5rLSJeofrkfasts=;
 b=Ns287bmiku4ymOZ5J77rzzfj1DqkXsh/Q/SCpfzpoGnSEUGw1zIdXCLxS9YEq47Y+H
 iLX611s//rXcTqkTAU9vH1uaKxSdEIg/3NBtPUCtOuwTk9/tjV3qXubj0h+TVG6YWMpO
 Hg+4ucLNZ2FDHWq/PuFO7ORMIy5peciKKSD///K5myu+cK6FjMhNT6lDhdb46/6vHiFT
 GKSIS87mGstwbLeBzyyWJRw2VMhjEmtASYltKamV0O9ARE4BfDD7b4Ih3SU/Kbdelhcz
 HVpBmTcClyKiyzKKEIH/zMtgooH1JPnJq80B6feIZuaFGNnLth7quyMS0OokhxxAjzZQ
 ceNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559362; x=1785164162;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/dNhP/hlenTslbWVq/aK+TWpphzb5rLSJeofrkfasts=;
 b=BpCKVHpTtHucWvZFLqNOBcdP/Ifv1P88fIivCs4dqQ2nJpVDj1IMOQNt3HKFhrAnRL
 qII/zKAhM36Pn1oO3lRaqDEfYqf9KE1YNbPfv3Mw+hJpiV3RIUwpgs4DhDcNsERO0XNv
 vHWBOzfHnSARL88DJE72Ng7vGtYeueUt5cJjWuB1YyGTwD20AoF3yzX6LkJEABxjmUmr
 3oHssNEOb37Pvtfs5Ye5htgodKgePuomRxSIB5n/KIGT5dih3c3GBZ8CWxxHQiQzpbWk
 LdnWOdC26l5GaUdYu0tqGPPI4gGNlwZUg3WVcCXjaUL7NIshxnEoUFVR8yeFm0Yq2NTg
 mbRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpl11lwouG6vKWCizXvGOsfBWKCdkYX7oT74km+0Y1kDNcfsQIuyoC1do8daRYn7qD7EM2WQMXL/eEc@nongnu.org
X-Gm-Message-State: AOJu0Yz2WBYP80xShgxY3VRskjQxJINHX1WlrUb97NDyierBN0WNrMeK
 mHJHrQeR77INsK6qvYX4GJZ8Td9PVyjSns6J2IFI7wGi5B/ioap3NoKsr9DxOi5xolWK/9Jy425
 cv0EJ15vzfuI6ShbRd/CBQ04yrWEtOtT/Rrc3Ue6C3sABmyDSUwDALYeQ
X-Gm-Gg: AfdE7cnE+tPZRRNAYtHtq/ksv7QzKrCAEouDmYXukINqK4V6/Ix0tax8tiwWlYbHV2w
 BBnNsM5lxDZVPEOUcyLLhWEHnRKDV4+M+gGxP7mTuCic4+1mlI0yK5Mzb8y1BFR0t4Dhk8MzpaP
 bftqvUuKkefZRK26jBwAWn+OHTbS4ThIxUcrqY6HAuhiSj+uwd6JzqrsHBhsLdt7kZqd6JIJXo0
 0CQ7ZZ0v7uXcunYhPFk3ivHbTOtJ8XEztNMWwevZMkb6OJP3b8aBdqO5W3PCR7oaEOuoX8na3VK
 MXcKOuHbjIoL/ipKANGsGuqdHXOLgVA+IDoCX1Pi1WdYRmE3YSjPk7TmR0iwL6/rry6ujbo8QLq
 m47QPv8gcHw9mNMk0TuxqUTiOwrnM3MKzAiuA30fS3iqu15k1swS5VtcpjT8=
X-Received: by 2002:a05:620a:a416:20b0:92e:70a4:2c5b with SMTP id
 af79cd13be357-930b4336072mr1059782385a.69.1784559362084; 
 Mon, 20 Jul 2026 07:56:02 -0700 (PDT)
X-Received: by 2002:a05:620a:a416:20b0:92e:70a4:2c5b with SMTP id
 af79cd13be357-930b4336072mr1059779785a.69.1784559361615; 
 Mon, 20 Jul 2026 07:56:01 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b542dd27sm891967885a.29.2026.07.20.07.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:56:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:55:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <al42_qzCLAjE-Mch@x1.local>
References: <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
 <akvWlciUvxjDbBBZ@x1.local>
 <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
 <alZssI9OmGJyD-rc@x1.local>
 <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
 <alenmdWqD-x3bYll@x1.local>
 <5513c20b-0f5c-4bf2-93fc-d1619e3319c1@maciej.szmigiero.name>
 <aljc2-4XfpSkX_ay@x1.local>
 <cb1bdf37-58e8-4498-bc56-d65c4fcc3fa0@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb1bdf37-58e8-4498-bc56-d65c4fcc3fa0@maciej.szmigiero.name>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 04:31:32PM +0200, Maciej S. Szmigiero wrote:
> Inside the VFIO code such sync point for VFIO devices could/should indeed
> be created, but then it's not available for these other (non-VFIO) devices
> for the purpose of avoiding the regression from the previous paragraph.
> 
> However, replacing the order priority/adjustment mechanism from patch 1
> with the "pre" and "post" handlers I described above would avoid having
> that regression (and help fix the vhost-net case too).

I'm not sure I fully get the pre/post handlers idea, I think it sounds
working, but in all cases I want to decouple it with patch 1: I don't think
it requires patch 1, am I right?

Now if we want to avoid this "theoretical regression" and solve both things
together.. I think we may need to refactor the notifiers mechanism.

Firstly, I hope we're on the same page that essentially prepare_cb() is the
priority mechanism here, we only have HIGH and NORMAL priority, where cb()
is the NORMAL priority.

We also need to persist depth concept per-notifier, I think we should start
by renaming VMChangeStateEntry.priority to depth, add a comment explaining
it (on different order of invokations on VM start/shutdown).

But then, I don't think we need anything as complex as pre/post hooks with
hashes.  I think you're right then we need SYNC point which can be
essentially a priority notifier that is in the middle of HIGH and NORMAL.

Hence, I want to see if below should be the easiest:

  - Rename VMChangeStateEntry.priority to depth

  - Normalize prepare_cb() into VM_CHANGE_NOTIFY_PRI_HIGH, making cb() to
    be NORMAL, OTOH.  With this, prepare_cb() needs to be registered
    separately with qemu_add_vm_change_state_handler_prio_full().  The
    function now should drop prepare_cb() but instead take a real
    "priority" value of VM_CHANGE_NOTIFY_PRI_*.

  - Introduce VM_CHANGE_NOTIFY_PRI_SYNC, in the middle of PREPARE / NORMAL.

  - VFIO can now register its 3rd notifier against SYNC.

All rest devices will need to shift part of its logic into PRI_HIGH to
either quiesce DMA or enable the backend to accept DMA (when on dest QEMU).
None of them will need SYNC only if they'll also switch to an async thread
model.

Thanks,

-- 
Peter Xu


