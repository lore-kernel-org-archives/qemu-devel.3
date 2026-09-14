Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E5FC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6A4Z-00028y-0n; Mon, 14 Sep 2026 13:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6A41-0001zb-RS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6A40-0000MP-4J
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789405308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUF9F2IXcFINbg6/6ZCehhFhgl2sjcbLQfDeQjrczP8=;
 b=d48guC+VxaKoD64xGpj1I7lZrHX58SguLveIlEdrMw3RWBSI72GvLenKjQeSHG27gMnlLq
 aYmlxWRZp1FcCS+w/QlYx118YKOVnCFSZgDz4dpOxSez6e+GNgp3pRj06rtIQUk7rj1k7L
 g1ppQVMpbXOSiUv6j68zCMgWXOXK3UE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Wzk39c2CN9KxiArW156F9Q-1; Mon, 14 Sep 2026 13:01:45 -0400
X-MC-Unique: Wzk39c2CN9KxiArW156F9Q-1
X-Mimecast-MFC-AGG-ID: Wzk39c2CN9KxiArW156F9Q_1789405305
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1b824e84so274029885a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789405305; x=1790010105; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUF9F2IXcFINbg6/6ZCehhFhgl2sjcbLQfDeQjrczP8=;
 b=hi+AQuOePO/vq0hm3or1MW7Vp2lwYpIbzZSfSDR9kOVvAyEOvRA3z42mjN4ik80Tu8
 adeEgMAHi86AsN8uqwzzu4879FQDkgmMxijjqT6asdx0vd/xyHJgrCHjgVTw1QYheasp
 ZJcUkn7LW4CrY/igtWg3gwmeOVjscJmXh4ZJhf1WRg5YBE/aMEE4QW2V4YugjmXe1Ote
 7bkEeFZ0ZurM7AN0U8sdFHB3LLsasPPYNtDYSxYWHezzD5fzFTJSeAKrdx+qfOeqRqR6
 S+X3/zacBq42cqh19bdw+Rkc6hkDda09FhZ9T8VmkGZJfwMnat+emzAI7b7OPRVFdjHC
 kL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789405305; x=1790010105;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rUF9F2IXcFINbg6/6ZCehhFhgl2sjcbLQfDeQjrczP8=;
 b=WkCjODDAT7/Za4yyssUDMTI9quQd7TE15h818v7uWnk2OND+qqfcvoB3NWmZ/EKxOd
 GpL9zIeYoW3MqOk0L6SFsjnyfX6hMYqEk74yXlzHGYvkc+HWrzDtfSLbiIiALXDusN98
 zO248J+IMMvxhklaP5NxQRZSdY5Axb5Ul35boFICju5AspnVNnpxT56Isrl5WXujL0Uz
 RjqhH7ohNp0zcPcR6qdf5jcntmINFRlGAwwnxmzMkSNZKPfAvaxRgGGlitzpMr+5hXW1
 gJ3Dlr3CHdIL4f8+HnQGlKMM3PcKSjAqJnMtsHZho9HudotugdH6D/tyTrqFt8bt85u7
 +GTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfcy5HK3aG+uJl1XRvtzSD+qbYBiqetYZxgpx6BlTx4YGUn6GFXkE0HUh6VKUrg6HL+EFONIPEtunl@nongnu.org
X-Gm-Message-State: AFuF++n2aTq3+eCDFw/beViTJXKtLb5IwCZvUnkmh8EGRLoPuXpUrfnL
 8wemwhe16MfUWcuyM4zKSmo9WfFuqspO5lmpXnEAv//XOO4Mf4lio7Ykm2lzLqU0mYrIinRH3SH
 2SCdt4cWL5Vp9Gu6c/3ptZPQjo4OOY5CO1W7OaS9ahzKqnY4KKa+UPmsz
X-Gm-Gg: AYBFou19ha428QVgBkek7lqdXbnaNspiM9Ee4xHKPLHfK9q9kbgcPk4IOM/O7jBP8Mr
 zAqihM9vc0EA9lnbWaOjPm7nHTKMkdfJAHoUlB5dxAlGfec5n5NjhZfUeomU8Un5lZrPMVhn97j
 4OSLvG7YmhEYFUUHhHPadq3dAfPU/3hxTFA7xkIcJxHgsK1c5cxJQsoUv8DGio0yTfLDWn1s8GE
 OxG6Hhup6VIM6Rc2iEfi5TB0AC3KZWD+0Bgw0ClBweOecmh8jo3AUMFpUuDiNmisBeftBBVE+Hb
 uG+H2MCwTplKNO6m8o8zyEswCwGKQCQQS8s5x/zXHO1eGFTs5fnjksHHNX17YqgVvS/2h/Szlu8
 9nnI+vXlyFSNRxADrgAfNo4itbfV5sV1GWq/bzrE4kgQdhkX41k8qBvfTP9E=
X-Received: by 2002:a05:620a:6489:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-93a297cb56cmr466623285a.21.1789405305186; 
 Mon, 14 Sep 2026 10:01:45 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-93a297cb56cmr466616785a.21.1789405304550; 
 Mon, 14 Sep 2026 10:01:44 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939ebda519bsm996273285a.26.2026.09.14.10.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:01:43 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:01:42 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Cam Miller <cam@linux.ibm.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] system/ram-discard-manager: fix
 offset_within_address_space in replay_by_populated_state()
Message-ID: <aqgodgDLGSSbkTXL@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com>
 <CAJ+F1CL4q0hbZGpdkzcMG9EgqbhrWaGQODCH819c13hS8ZLecA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL4q0hbZGpdkzcMG9EgqbhrWaGQODCH819c13hS8ZLecA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 14, 2026 at 07:54:44PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Sep 14, 2026 at 7:35 PM Cam Miller <cam@linux.ibm.com> wrote:
> >
> > Fix bug inside replay_by_populated_state() that forgets to initialize
> > MemoryRegionSection field offset_within_address_space. Follow the
> > established pattern of calling memory_region_section_intersect_range()
> > to accomplish this task.
> >
> > Prior to commit cc9c77f4ddf0 ("system/memory: implement
> > RamDiscardManager multi-source aggregation"),
> > replay_by_populated_state() had called
> > memory_region_section_intersect_range() in order to initialize
> > interdependent fields offset_within_address_space, offset_within_region,
> > and size together, as shown below.
> >
> >     s->offset_within_address_space += start - s->offset_within_region;
> >     s->offset_within_region = start;
> >     s->size = int128_sub(end, int128_make64(start));
> >
> > cc9c77f4ddf0 reimplements replay_by_populated_state() initializing the
> > fields of the given MemoryRegionSection instance by hand instead of via
> > memory_region_section_intersect_range(). In doing so, it leaves
> > offset_within_address_space uninitialized for some reason, as you can
> > see below.
> >
> >     MemoryRegionSection subsection = {
> >         .mr = section->mr,
> >         .offset_within_region = offset,
> >         .size = int128_make64(MIN(granularity, end_offset - offset)),
> >     };
> >
> > Consequently offset_within_address_space defaults to GPA 0x0, which is
> > incorrect. For example, on s390x, base RAM begins at GPA 0x0 and it is
> > problematic to report that a virtio-iommu MR section lives there
> > instead.
> >
> > cc9c77f4ddf0 deliberately calls memory_region_section_intersect_range()
> > from other related code paths inside the same file, namely
> > replay_source_by_state() and rdl_populate_cb()/rdl_discard_cb(). It is
> > unclear why the new replay_by_populated_state() implementation does not
> > conform to this same pattern.
> >
> > The effects of the bug include qemu crashes on multiple architectures.
> > The following assertion failure occurs when driving the
> > guest_phys_blocks_append() code path, for guests with virtio-mem device
> > that has some memory plugged.
> >
> >     DBG: guest_phys_block_add_section: predecessor->target_end=280000000 target_start=0
> >     **
> >     ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> >     Bail out! ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> >     2026-09-11 16:03:57.405+0000: shutting down, reason=crashed
> >
> > This crash can be triggered on x86 via the dump-guest-memory QMP
> > command. The same crash can be triggered on s390x by restoring VM State
> > that has been migrated to a local file. (I used libvirt to manage this
> > migration restore operation, namely command virsh managedsave then virsh
> > start.) Applying the fix resolved the crash on both platforms.
> >
> > Fixes: cc9c77f4ddf0 ("system/memory: implement RamDiscardManager multi-source aggregation")
> > Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> > Signed-off-by: Cam Miller <cam@linux.ibm.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

queued, thanks.

-- 
Peter Xu


