Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD2C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuDAP-0008Oo-BU; Wed, 12 Aug 2026 13:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuDAM-000872-Vk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuDAK-0001gj-J6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786557299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnBcQcrgdhK9pwVFhzAD66Q1YAcR5Nb4snLpGOgei3I=;
 b=bczhueKdlHKWnVQf9FJ1qfvo+gnXXxxaOYf4vS6FQVx4nAubH5vyRY9h9GSr7fCrZ9yW7C
 LSgqi6TyxjTMOHVt83OQawnEupd3xLEdDzQHCpD4k1F0OnDQDy/v7xCKAe+EMCyaLbPCPI
 vGp4TecnFBMZTa+9UK7RJM2Ds9EEb14=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-qexGrIifM8qOAThApGkgKw-1; Wed, 12 Aug 2026 13:54:57 -0400
X-MC-Unique: qexGrIifM8qOAThApGkgKw-1
X-Mimecast-MFC-AGG-ID: qexGrIifM8qOAThApGkgKw_1786557297
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93494527488so223539385a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786557297; x=1787162097; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnBcQcrgdhK9pwVFhzAD66Q1YAcR5Nb4snLpGOgei3I=;
 b=H39O1dtW+s47lAUYagXTpv+MjxyFU6kcQrvoiBwShQJj4EtXGzQ8d4T+zX2v5+Hr3x
 f1LnctxbCOyAbbH5LECRDCG5Jel0su0R+UkMwnd2ojJP8AfhfZTCAkUEBkeYTxkRM3cP
 OjwwazD1hg4qMI1gtltVH0Oi09o+8+ySS0G02YaVdLOPKwic1JkFepmFG+YJUKACQmq8
 hO9nCy5VcMSdCLNzs0RtG+ZKFqYMm5Q1YCbws4UJe0heN4eymuSJdFpM8sGEpgTuJNFA
 tX2vLg8rZ+7yT4SC4uar0LjF7qd4Zew4P5jzClmd5clhA+5PGl0AvY8YNilhOqVsSblv
 2BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786557297; x=1787162097;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZnBcQcrgdhK9pwVFhzAD66Q1YAcR5Nb4snLpGOgei3I=;
 b=Hj2hq+j0umGv/xWEPpVmEHe/lAAHuvQKAqMM/Cy87cZG84sAmbLPBNryHW/o8j9E6e
 8mVA5d6hPWFI6UBW0dmzSd5c45lENdjF9X8QqX+yb67e65hKkP3W0azhr9rbgQCJQG5K
 8+Wqi81h1t+7JWIh/Ig21+ARAIA32AgNIHqXM77xG0e7ckKNlbbN619X9SNTlDwk2QAZ
 AeFBqB6XnA/3eWj8l07VUMnQRuNVnbtU7fg/gTyPSeE1+NJ9mIzsoELXvN8mkkFyxP5B
 JOmKJe4FCmMMMEGJAVCmEHnmF+DiSIGn4a25jToVo5NAoyf/omQaV4pzD2wdAe7Wrr5V
 X2Nw==
X-Gm-Message-State: AOJu0YyEIGRlHrN1CntD6eJ7hcUkKggaSMiQVNltvU4d0tRNFjqUvZhH
 p/S/tY6HVhxceUgNh5DP8zfhAgU9+lKTA5qL9pYCIk2farWum6IzxzpsNWFzZzmM56fAF1b0vLV
 5RZY49sMNak1T77w2OL+8qdp8n9SpG66u+hyUa/GRgGN60dKe5drP2t3L
X-Gm-Gg: AR+sD125BPwQDKoCucynSWkhL+XrKpc8nW1VbHlNM+/Oh/kGTnElUsq/xbkuePkqYSv
 Vo1++Emc6qjbx2a3FnuLrZWbAgKm4qgqiOaIuMXN/s/0CK1ChfBoFeSj4KWOWUYKmZHygJrPePQ
 JT/4K63BvRRjHQdagjjbYAj0ZIEyss51NS+y72c+xUGinVcJbohqCNjIOQu65x7cZ7H6qLAI+Mb
 42d7u9ahxPk+3rP5kw9XLN86GbktG829nKmQvePRJWLgMwch5wlX9X1dXjGXwrr52ZharLAbipV
 587kGgW9Zj83Pk3Q6kRTWUVbx7Irp8Bq2GLo7L60rs2bZWt1ecsClrovpIFzcLp9ZKylomf612X
 GYjaGzdZsI4BlzaqjV9FKeDTSIQDZ9kqQA/TEmomUv+WLJi0YxnXm52WrTCw=
X-Received: by 2002:a05:620a:700e:b0:932:ddff:123d with SMTP id
 af79cd13be357-936b3d49b4dmr615683985a.29.1786557296717; 
 Wed, 12 Aug 2026 10:54:56 -0700 (PDT)
X-Received: by 2002:a05:620a:700e:b0:932:ddff:123d with SMTP id
 af79cd13be357-936b3d49b4dmr615678585a.29.1786557296089; 
 Wed, 12 Aug 2026 10:54:56 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5e35979sm189572285a.21.2026.08.12.10.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:54:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 13:54:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 07/11] migration: add support for fault thread to load
 pages from disk
Message-ID: <anyzbkQxrIuAo2Jf@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-8-aadeshveer07@gmail.com>
 <CA++cPvLsRpqcqhPg4fY_uhnZqeET0OpdxDDM1i4_rGFuR_4Hag@mail.gmail.com>
 <annw8X51cEa6yvdp@x1.local>
 <CA++cPvJ=nx=4EWHQX5yYO46Dq2Ng7-EjG5J6bhWapTtumeXdPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++cPvJ=nx=4EWHQX5yYO46Dq2Ng7-EjG5J6bhWapTtumeXdPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 12, 2026 at 10:08:38PM +0530, Aadeshveer Singh wrote:
> On Mon, Aug 10, 2026 at 9:10 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Aadeshveer,
> >
> > Thanks for looking into this problem.  Below solution should work in
> > general, but there's still one problem..
> >
> > On Sat, Aug 08, 2026 at 10:04:48AM +0530, Aadeshveer Singh wrote:
> > > A subtle concurrency bug exists in the current patch; this small patch
> > > should fix it.
> > >
> > > Current patch uses bitmap_test_and_clear_atomic assuming it performs
> > > an atomic operation over a range, which as pointer out by Peter is not
> > > the case. It performs atomic word by word operations making the
> > > overall operation unsafe.
> > > Therefore, keeping the same bitmap would require protection by a mutex
> > > lock which might not be as efficient. Hence this small patch resizes
> > > the pending_bmap to have exactly one bit per load operation(loading
> > > the larger of host page and guest page).
> > >
> > > Thank you,
> > > Aadeshveer Singh
> > >
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index e01ac628f5..0bf0f837ad 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -1031,9 +1031,13 @@ static bool
> > > postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > >      host_page = rb_offset / qemu_ram_pagesize(rb);
> > >      page = rb_offset >> qemu_target_page_bits();
> > >
> > > -    if (bitmap_test_and_clear_atomic(
> > > -            rb->pending_bmap, host_page,
> > > -            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
> > > +    /*
> > > +     * pending_bmap needs the index of host or guest page based on which is
> > > +     * larger. As page index is inversely proportional to page size we use the
> > > +     * minimum of both.
> > > +     */
> > > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, MIN(host_page, page),
> > > +                                     1)) {
> > >          if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, page) ==
> > >              page + guest_pages_to_load) {
> > >              /* It is efficient to use UFFDIO_ZERO if all pages are zero */
> >
> > Consider the case where guest psize > host psize, here the current code
> > will invoke postcopy_place_page_zero() or postcopy_place_page() only once
> > for each guest page. But IIUC that's not enough: we'll need to loop over
> > the few host pages that is covered by the same guest page.
> I believe I missed it, confusing the page sizes. One of the solutions
> can be a loop or a cleaner solution might be to give larger length to
> ioctl command to handle multiple pages at once. This should be
> efficient but might require some changes to basic postcopy code as
> most of it hardcoded length as page size to most userfaultfd_ioctl
> calls.

Yes the helpers were for one host page only.

Since you mentioned, I found that maybe the generic postcopy code has issue
with such special psize setup too.. see qemu_ufd_copy_ioctl() where it has:

        ramblock_recv_bitmap_set_range(rb, host_addr,
                                       pagesize / qemu_target_page_size());

Here pagesize should be host psize, which means if guest psize is larger
then it'll have nr==0, so QEMU is not properly updating the receivedmap in
postcopy phase.  It's highly likely nobody ran postcopy with such setup
before.

> >
> > I confess this is really a rare corner case..  so you can decide how to
> > "fix" it.  There's always the option to disable this feature for now when
> > guest psize is larger than host psize (OTOH, host psize > guest psize is
> > much more common, because that's normally how huge page backed VMs work on
> > linux systems).
> >
> > Or just provide the loops over host pages, I think it will start working
> > and IIUC it's indeed the most efficient.  But then, to make it slightly
> > easier to future readers (I still think the bitmap definition will be
> > slightly hard to grasp for future readers.. your comments all over
> > hopefully will help), maybe we can also rename "page"; it implies guest
> > page index but it's not obvious.  We can make it "guest_page" to match
> > "host_page".  The "haddr" seems fine.
> I believe it should be simple to implement using direct syscalls,
> however for a cleaner solution current functions need to be made more
> modular. I will try the latter and if the changes go out of hand might
> resort to direct syscalls or loops.

Let's avoid direct syscalls; it's not good for long term maintenability.

Please try to see if it's easy to fix this problem.  If it's time
consuming, let's fallback to fail the enablement of postcopy when guest
psize is larger, and leave it for later; such breakage should apply to
remote postcopy too.

Thanks,

-- 
Peter Xu


