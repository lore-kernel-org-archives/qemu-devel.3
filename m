Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5652C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLoc-0004ld-HJ; Tue, 18 Aug 2026 11:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwLoa-0004je-WB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwLoZ-00012n-Cm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787067202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFd+rvbaUh4z/4STu4erFgdblKnEjLNZlC/MxBiusuQ=;
 b=RhOk/vnL40xnnoiC1AgD9kRqLKpwfb0Z7JFNiCtf/NcS4zELXkexLNPYJBXme48zOr2GOX
 MGCT6aSfnCvzgB/7OHAXzIeuiC6AllcX8r5pp1TuHtLy2CHrY58nuaEN64yPE1yHrGNld4
 vg935xGD3hIlJcuk5JEXa+YVqmGkjoo=
Received: from mail-yx1-f71.google.com (74.125.224.71 [74.125.224.71]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-e8QKDuTWP16TiiAnXIdFDg-1; Tue,
 18 Aug 2026 11:31:49 -0400
X-MC-Unique: e8QKDuTWP16TiiAnXIdFDg-1
X-Mimecast-MFC-AGG-ID: e8QKDuTWP16TiiAnXIdFDg_1787067109
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66cc65a15dfso139221d50.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787067109; x=1787671909; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fFd+rvbaUh4z/4STu4erFgdblKnEjLNZlC/MxBiusuQ=;
 b=ZvSc2+JoRKrcfy64304TKp4fqCapf/KXYxe4+XnE1MDz2JjykV4cFPK6E/kSv9HT2j
 TLQJ7HgSLZsU13nmQqQlZHl/H8AQhXBJ9JtW5t0NexcYPjudz4eMyGH/bk7iuxSVCBAt
 1eoOwNOentxrmXxxSHTAG2qKgsQSjQo52j0Y9YgRNeWNyYIS8Y3N8rvGl7eiQuaF07oc
 JH4SIYN0DrJSQJ19KGpYLJbas4EGCt9vZLH8DMQGGokARHpffrEXAdQfoLxf1+ZfsI/B
 HNPgths4eVAuGWggm2b9GA1+1YQdzaKqcL//OmZjvApAgrSqV6NEWP82WCGAI2m9ugDa
 FBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787067109; x=1787671909;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fFd+rvbaUh4z/4STu4erFgdblKnEjLNZlC/MxBiusuQ=;
 b=VfqRvhQOVwUtsTppThRCSx0f30T10LP9ez+qmh7Ldvl0rRajHGpueaNMeSnxPrGzbf
 6KvIeBTpppyc9B8suIcvLv4whsVSeRrb+yYRZd90AKpT9dgBJlCnRvRBew/Who6T4jgl
 vdLz5wMiuKWDQfnvyCIdbhIimKEPAe1aGKPZs/MF7Gcrq7AhjgC/N7g/6Q9DkIEK4SNw
 16PiyOu7BSrvTJwNkMhIi10odzN4PjP6D2GJEgcQb97HKOtWsin8wIvHoCjffjUAsF1e
 BMW1obNkHVVcsZ7W5w4yfwhmE/gw0zvcPL6H0oCMbt74TZHU5aycjqCaocPLenUJLim5
 fGdQ==
X-Gm-Message-State: AOJu0YwOWj5N6ZmOVpW9ZE17K/YRebdkVusWvZZ71DONzwJAKFl3Zbmt
 w4rFAGfrDADoTPOQ/sKLGi77AoLIfPneMrvwc9+Ol0HuHtjv7rwN0DjfkfqPGNdCK2UbGHUWvwZ
 +q7ZytYKc9y/XogU8nOhf8uw6b+6B1TCGCF3eFOTNs6Evk4okWSHRjJwu
X-Gm-Gg: AR+sD13NKs9Lb9fB4ZaOHso75oO/nAdYsHePEQCE+VigthMB31iYbdTQ14pqM5YrG/9
 GpP5TdvUXBOvNT7brjQZB5g6j+Vztzy/0mb0FRlmWWz5lC1pjwsWq25IsvAx0g3Bxp6HEAi9SMk
 63e7jiZW8g83iX67PB45EryKdhPyYm/f7kCzHH0ZVwbVikvD4ykJU1Mpkb3VRuFuDlxw7+e/BOv
 IxYYWdLEXwTjRLSknyENAYC3PXXugjeAZ/7XsiYys2haChJDwdADnK9BGYm32ZSKqCWCrJD7zu+
 ywrNxWqG5DCISqX8fXypOQ4x7MDgIMIUgLZQbvjByYh96ItaTK2GTJnXKZd/c1jAr/IS
X-Received: by 2002:a05:690e:4852:20b0:668:94a6:7543 with SMTP id
 956f58d0204a3-66cb9cb45bcmr2560510d50.13.1787067108903; 
 Tue, 18 Aug 2026 08:31:48 -0700 (PDT)
X-Received: by 2002:a05:690e:4852:20b0:668:94a6:7543 with SMTP id
 956f58d0204a3-66cb9cb45bcmr2560444d50.13.1787067107650; 
 Tue, 18 Aug 2026 08:31:47 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb4233606sm2477046d50.9.2026.08.18.08.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:31:47 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:31:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] system: Define ram_addr_t to be always uint64_t
Message-ID: <aoR619dUn8051pj8@x1.local>
References: <20260814134035.2733355-1-peterx@redhat.com>
 <ae8c473b-770b-4aad-8fe9-8951a856c555@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae8c473b-770b-4aad-8fe9-8951a856c555@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 14, 2026 at 04:26:39PM +0200, Philippe Mathieu-Daudé wrote:
> On 2026-08-14 15:40, Peter Xu wrote:
> > QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
> > least the system emulation part
> 
>   (see commit 372ec46b9f "meson: Reject 32-bit hosts")

The "at least the system emulation part" was almost for cf634dfcd8f that we
re-enabled tools for 32bits.

I'll reference both commit IDs when repost.

> > .  Now it's safe to move ram_addr_t
> > completely over to uint64_t.
> > 
> > It should be almost the same as uintptr_t as before for !Xen, except that
> > on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
> > differently, causing unnecessary compiler warnings when use them in a
> > mixture way.
> > 
> > Hopefully, this change also makes it clear that ram_addr_t is never used as
> > a host pointer in any form, but only an internal QEMU integer based address
> > space for allocating ramblocks.
> > 
> > [1] https://lore.kernel.org/r/d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com
> 
> With the commit sha no need to link to that thread IMO.

I wish to keep this to provide a reference to the MacOS issue I mentioned.

> 
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/system/ram_addr.h | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> > index 129f6b8757..06caca1506 100644
> > --- a/include/system/ram_addr.h
> > +++ b/include/system/ram_addr.h
> > @@ -15,15 +15,9 @@
> >   #define RAM_ADDR_H
> >   /* address in the RAM (different from a physical address) */
> 
> While here we could describe a bit more:
> 
> /*
>  * ram_addr_t - Offset in QEMU's internal RAM address space (not a guest
> physical address).
>  */

Sure!

-- 
Peter Xu


