Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BD5C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRSI-0007i8-2n; Thu, 30 Jul 2026 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpRSG-0007ht-7b
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpRSE-0003EL-4P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785420583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DnzRHNzrhlYGDwQ2lu++Ed97HfCVK19hhCSBk4oSxNI=;
 b=ddNMNU7TRNg3Krpa9uFLtBTajwra+CTgvmKEBtW/YEP9sUIdTqMgvzi8dotzOan355AUsp
 eDjSbuRLwwulEdRD/vSPk4SbvyHjIbntEPsuBDTR5wele21gbDtBr7f4tIMpOHNX+PifBe
 buGzt7e3WhBeysPyfesE8Ru6cmI711Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-yZ7DJeA2O82XfxQ9QYe4tA-1; Thu, 30 Jul 2026 10:09:41 -0400
X-MC-Unique: yZ7DJeA2O82XfxQ9QYe4tA-1
X-Mimecast-MFC-AGG-ID: yZ7DJeA2O82XfxQ9QYe4tA_1785420579
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b2a35b9306so1311956e87.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785420579; x=1786025379; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DnzRHNzrhlYGDwQ2lu++Ed97HfCVK19hhCSBk4oSxNI=;
 b=k95YxoTDhSHt2LcXIhCZgQyFIF7DTS0s8/Qg7VWLoP9OE8JHV71lHVxjIqjXCHeE43
 vw11hJib3IarP/p60v++oWcXTytEy/rH1SASDg43m7IVyT+ZA6p6dcECqw9Wp6g+LcJP
 MftCQ+xFiCdOgOCD4b+7gZjtCcQhigPUKQ45wpj4CrKHRZZIITcrz/fg8b1LqR0m9p7G
 6aeQ6VF7wzHSp0Tqb8f1QlJNdMiELPtVAQaXfkeLk2Bhl6mkbJdx7prEnCdvdWTzric/
 cn1HgH2r5cmqrRpwYNuj06W6IU+63XjKCsqGZ0UWuELSx0FTlaCRM9DK2JfFnJyYD2C9
 iLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785420579; x=1786025379;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DnzRHNzrhlYGDwQ2lu++Ed97HfCVK19hhCSBk4oSxNI=;
 b=PWheI5B/tb5kdTwpuOY7D4yBoNPqbXFKPDoe7WIO3fnCj5d8NnVjAC2VwBpLmavU4o
 gERPvJ/b/zpCvG+dO7i1dIQBhZntVYrriMoqL0x6fr/T+dYGjI9qTpYNkoc3Kt43YYEB
 hk781e5fJ/AH/gXd56AMsdyFvsxxDXxuYKQ/XtS3y78x/BuC19XFbZghTgJMYonmMIAv
 BifzXE8BFSfSMNtrI58c3s7nAUQAVNgOKbPF4OquftGcikmrYi0E1M95Nxvq2lV6BFvN
 M7aFw8hHPFcuBfPVpIqy8Xam2BCwn48xA0R7sxrVGej9kb8pR41adB2nAlU+hjhFxfO6
 CCrw==
X-Gm-Message-State: AOJu0Yxiu3fIB0w0plVEGu8uLnTYf1U7cuwCdBFfHsjLksbMB0DgKmxV
 gTURVuz6JqyXwrCOF7QcYpDf5LtySsPIlPJ9hEz+7Iiobk/5A2Wy7s6Op1aDvc/PJrLpgkPXD1j
 Y/5yGTOrlMhIBLRV3dyxHcCxmDGZR/J40HGM0thAdcOsmsndRQLGGgbp7
X-Gm-Gg: AR+sD10wHa2REGFcRsmiO/E6F3sMc82d5nE2HGQNNta0IhYrJEpkScCtjKpqnPbOndP
 gp2B1Yk6zCFnwP/yG+SbuHjTHfqvcClyl3CDs3HoHgyTt7fv4Dv0DBBMmyYmI9ytXO7Yqrq6afI
 /c1+AATtlpFzLoIqbZHkaz5tYBIx2QT45MQCyoknF+SEmYfcfMLaop7Doz9tkWF286qmif0jHbi
 BlApoQAWH6i3p+aC2zY4qtOeMtPrvU/As52IUMXOYuEqTQ5mJIoakRNiT5APBF1OF10U8Xom1zX
 4W1yLKkStKgAX9UF51JK3gaj2VJzrd7H7XW6VYxcqmDcAwKOdayVVw==
X-Received: by 2002:a05:6512:1082:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5b2db3529d0mr581700e87.25.1785420578571; 
 Thu, 30 Jul 2026 07:09:38 -0700 (PDT)
X-Received: by 2002:a05:6512:1082:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5b2db3529d0mr581678e87.25.1785420577770; 
 Thu, 30 Jul 2026 07:09:37 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db9ba7a3sm363015e87.40.2026.07.30.07.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:09:36 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:09:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
Message-ID: <amtbGkfKvPCJgDec@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729225227.1170574-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
> Hi, this is basically what I ranted about in:
> https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> 
> I'm replacing the per-integer-size type checks with a single "int that
> fits in 32bit" check. This allows several lines of duplicated code to
> be removed.
> 
> I haven't changed the macro names in the device code yet. If this
> series gets positive feedback then I'll send per-subsystem patches
> doing that.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> Also tested:
> - migration-test --full --thorough
> - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> - s390x compat run forwards and backwards for previous 2 QEMU releases
> - ppc64 compat run forwards and backwards for previous QEMU release
> - migration-test smoke ASAN/UBSAN run
> 
> Fabiano Rosas (4):
>   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
>   migration: Introduce VMStateOffset
>   migration: Remove redundant flags
>   migration: Remove duplicate vmstate macros

Nice work!

I think I was only looking at VBUFFER side and I thought it was fine
sticking with 32bit even signed or not, not a huge deal.  But cleaning up
VARRAY whole thing together looks definitely an improvement.  I definitely
like your version here.

I assume with your series I can drop both of my patches here, right?

  [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
  https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
  (I'll still respin with the rest)

  [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
  https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com

The only missing piece would be an multiply overflow check in
vmstate_handle_alloc(), if you could add that check too while rewritting
that in patch 1 then I think it'll cover all.

Vladimir's ask in the separate email makes sense: I wonder if we can also
do one step further and merge VBUFFER into VARRAY.

The other trivial thing is, while looking, I found one trivial macro
VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.

-- 
Peter Xu


