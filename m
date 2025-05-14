Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFJAm-0003GL-KE; Wed, 14 May 2025 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFJAj-0003FP-RP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFJAi-00029o-79
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747256266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFn8AxKFU5PMi45r2uGBKMnJEO4ITqfv63hOHJWbXfk=;
 b=XCqc2W5jl0wD3pVizeorsAhCap7JLK6iCl+FgERyRYyia0YfbUsYn4ROd4zmdQDP4t1Qw1
 r7Cg9kTzVHeIfZps7tptR4bzqv51mON9bWnBEHFggq4cc9TyyTpkzAZUE1PK1BLyl+AFaB
 Npo1Qn3/I8/I1hzTHFnDQ2ouWwUYsQA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-W7x0f2rsPwu8OphrKiF23w-1; Wed, 14 May 2025 16:57:45 -0400
X-MC-Unique: W7x0f2rsPwu8OphrKiF23w-1
X-Mimecast-MFC-AGG-ID: W7x0f2rsPwu8OphrKiF23w_1747256264
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5f3b94827so37981785a.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 13:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747256264; x=1747861064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFn8AxKFU5PMi45r2uGBKMnJEO4ITqfv63hOHJWbXfk=;
 b=CDjcOh16cWXHTkAmOWJ3JC8+tKdiQTM/L0EUSKzbC6ZJd3SscvAlnQvvd5q2J3AiH8
 zah7qEBWQTJz5cgoPLSeWKYxiq0irdRE0Fdp4A7rUsuo8zh/q5onz5S8V6cOvvVEWzfz
 vqzAn344hlcvMm0yHwJ9BBrlL32MXLLsmxXY2VDfhS7MXsJmQ2ZCsJuT+8mszwI42fA0
 Rvd2fSBPFhSR08ucaA+YRgIcMutf88tnD/W++yJf9OyVtnXjr7LKs1lcADl+frd+6Zls
 2G+sE/jBAM92VwyQYQ+qQmJKgOi8u1c20ktBn1BZNBOpPl+19rJAfAnSy1obiClxPxbO
 CpYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjwqyu17bXhKiCcRhZViT88T9dEbxUUZwUf6rNtjbGWceU8dRrSQ1Wtuqo+BVF2YMniZ6DgqBR+Sz6@nongnu.org
X-Gm-Message-State: AOJu0YwF9QCG/5X13scKfh/QU35lEDeNOciAZelJ4tLAjk3TiWW1yhXd
 7++eoKpIebQJMnkt8Wb5A9GN8cCIllR3DJ1Cd0hbm9aNY+nArNyCXsgBma6+PcF+yyiTjMs/CFF
 JT8GSbtw8KBcTnkews5FaxXE1soFXN/VjWo9rrypCCOLvvEkQqMC+
X-Gm-Gg: ASbGnct741UTjT/YQzMVR9URCrHQgszFDXo9hdxC8paov/3l25cMFuwr5Yp30bpNeRz
 sW511uZU6H6DG8W/i/kMiKndy4gecCWY9ReR3J1MuzaipqxDB1tjAwYMoATwNIaI0y+vsfXRBxo
 hOn0dJRJH730byQ2ml+wfh/dYopd7tgNRRYGDWgSUyb1A3042rKJo0AlSR4wknXf/lecj7CDFqf
 a0F6w3rVXJyYrfw9BQ5rkNVvw3S9R7VtsibjAMSoMMj2RbfJ0Yj0k+JCL6Sgdf/doUHGhsstucr
 SRo=
X-Received: by 2002:a05:620a:2490:b0:7ca:de42:4ae5 with SMTP id
 af79cd13be357-7cd2885d16fmr845335885a.55.1747256264427; 
 Wed, 14 May 2025 13:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJhok34A6D1DZytUnoSTQk7/x323qMT3bTuc/XGi+tjc4lgOet1go0qPDTDYb8UsJ6dnr5qg==
X-Received: by 2002:a05:620a:2490:b0:7ca:de42:4ae5 with SMTP id
 af79cd13be357-7cd2885d16fmr845332985a.55.1747256264078; 
 Wed, 14 May 2025 13:57:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f9af25sm895281385a.63.2025.05.14.13.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 13:57:43 -0700 (PDT)
Date: Wed, 14 May 2025 16:57:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org,
 venture@google.com, pefoley@google.com
Subject: Re: [PATCH] system/physmem: Fix UBSan finding in
 address_space_write_rom_internal
Message-ID: <aCUDxEQVACn5CY8f@x1.local>
References: <20250505222236.1616628-1-komlodi@google.com>
 <CAFEAcA_65vRzAp1DzcZSDPWG+vX1C6xuh_2afdHqmXVFKZADmg@mail.gmail.com>
 <aB4dohpeqnWlmurA@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aB4dohpeqnWlmurA@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Fri, May 09, 2025 at 11:22:10AM -0400, Peter Xu wrote:
> On Tue, May 06, 2025 at 02:21:08PM +0100, Peter Maydell wrote:
> > On Mon, 5 May 2025 at 23:23, Joe Komlodi <komlodi@google.com> wrote:
> > >
> > > address_space_write_rom_internal can take in a NULL pointer for ptr if
> > > it's only doing cache flushes instead of populating the ROM.
> > >
> > > However, if building with --enable-ubsan, incrementing buf causes ubsan
> > > to go off when doing cache flushes, since it will trigger on pointer
> > > arithmetic on a NULL pointer, even if that NULL pointer doesn't get
> > > dereferenced.
> > >
> > > To fix this, we can move the buf incrementing to only be done when
> > > writing data to ROM, since that's the only point where it gets
> > > dereferenced and should be non-NULL.
> > >
> > > Found by running:
> > > qemu-system-aarch64 \
> > > -machine virt \
> > > -accel kvm
> > >
> > > When built with --enable-ubsan.
> > >
> > > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > > ---
> > >  system/physmem.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 16cf557d1a..ccd2b50da3 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -3204,6 +3204,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
> > >              case WRITE_DATA:
> > >                  memcpy(ram_ptr, buf, l);
> > >                  invalidate_and_set_dirty(mr, addr1, l);
> > > +                buf += l;
> > >                  break;
> > 
> > very minor, but I think the buf += l would be slightly better
> > one line up, next to the memcpy(). That way we keep the
> > "copy more data from buf" and "advance buf the corresponding
> > amount" next to each other, rather than separating them by
> > the set-dirty operation on the MR.
> > 
> > Anyway
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I'll adjust that when sending a PR.  Thanks!

Unfortunately, this patch (with/without the touch up..) breaks ppc32 on the
boot-serial test..

Reproducer:

$ QTEST_QEMU_BINARY=./qemu-system-ppc ./tests/qtest/boot-serial-test -r /ppc/boot-serial/mac99

I think what happened is the ROM writer in that test can provide a "buf"
pointer over some range where memory_region_supports_direct_access() can
sometimes return true, but not always, in a WRITE_DATA request.

In that case, "buf" needs to be properly incremented in all cases, because
in that case only some part of "buf" is copied, and only copied if the
guest mem is directly accessible.  We'll need to increment "buf" properly
even if it's looping over some range of indirect memory.

I'll drop it as of now, please feel free to have a closer look..

Thanks,

-- 
Peter Xu


