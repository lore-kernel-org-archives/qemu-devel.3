Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D9C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBxA-0001n4-QC; Mon, 17 Mar 2025 11:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tuBx6-0001cb-Nr
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tuBx0-0007Jt-1j
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742223618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTIOhd61LOxkaZXTItSVq9gn3qbDZ7fjgPiPKgRQI0A=;
 b=KQ2GOyisI+TzvBcN6hVCO4cT218i8DWl22iMNWjN6dpqaf6yDpZ0Rtt0TvL/0j5Zuexkqd
 t7LoGMmciXpGy9trKpCD7RKqop8W3LV0Eo55cRYn6KZv7xhq6sBuyWKzP1oxZU2mhOlKYE
 U6Jxz+qqwLj6sI3J69RNRRq3sgvO1XA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-d61eIX6RObOH0-Z2WLKmEQ-1; Mon, 17 Mar 2025 11:00:17 -0400
X-MC-Unique: d61eIX6RObOH0-Z2WLKmEQ-1
X-Mimecast-MFC-AGG-ID: d61eIX6RObOH0-Z2WLKmEQ_1742223616
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8fae3e448so111904136d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223616; x=1742828416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTIOhd61LOxkaZXTItSVq9gn3qbDZ7fjgPiPKgRQI0A=;
 b=j+d8mdF53U/Tms5jZhArQFAFln0VZ5JAa0+8nFRt+ohsbDiNkOv2acXukPlbr29u79
 Wyx5L6X7bCn6fUhRvh+TJv7iBtiG5aNjQkxIS8cS5gRy0wyuYiOZD3YvIbKMG5l/rU8T
 vpX4RvivHsL8DwAki3d7U+dEAqcHoieZON7SRZLbGmH9+LLNgBn75s7L+3B1nlxPdJSl
 7/IxmoSk8SykXelpig40Om6hAqPNPJOKtKs3GAv9hwrv8XFaHzQKXd1HrxAVE5vh3Jdo
 RG4KuC7N5Dts3lA1w8RrpXPNBt8KfBFFHLmPSqMK/vFqNWRw8OBr0OIvmGWueowEKwqh
 KFlA==
X-Gm-Message-State: AOJu0YyCTUKQf8svKAr+7a97vrlE09QU3g8kCdSXI9J+Ny3TDkVfIwDB
 38/jFcCCFh5igLeVt8JWn7nKBCGwMAGZn11wdxj+8sGpMdcQvDC/YfZfn74yJ5SHtVyEDHLeK/0
 KjIfOB+ZS24r9DF+vSxcHuVo1/4wtdoNlTw4R4buxJq2ASmgkAATO
X-Gm-Gg: ASbGncuBUPSAmHMBp7cbTejxhKODn/co7VseiUcg+C/hB4TRDLMBQHMQHMajtcx4gHC
 7o2wnZ2m+7Ks3lJkH4XSuoN89CNMO33/eZ7ZS3kYFu6twSlWgO0eqeZ2lmmpe3EhPvZF2CUzp9e
 e6k3hAw41/OhEs0H6f/pNKrSieZzqtabnS4JnNPZevkH3Xb5O1O5qTq2kLP4xVf8SOq55L8Pyfg
 q6zkwvYuknQTU0xr32wl8o7a+NTgsvXUSONcp+7FIyl0zldtZX+x4VZlFyacDd0MotQibt52k9O
 f47Ngo8=
X-Received: by 2002:ad4:5ecb:0:b0:6ea:d629:f48b with SMTP id
 6a1803df08f44-6eaeaa5d9f3mr182689416d6.19.1742223615961; 
 Mon, 17 Mar 2025 08:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRvqiJuM9ohbHscD3aOb7IdrsGEiVeOGg74kOJOwkdTWvHz1nD+LTt7UXWq8aA5c7Onalxlw==
X-Received: by 2002:ad4:5ecb:0:b0:6ea:d629:f48b with SMTP id
 6a1803df08f44-6eaeaa5d9f3mr182688706d6.19.1742223615465; 
 Mon, 17 Mar 2025 08:00:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade35c8d2sm55486326d6.124.2025.03.17.08.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:00:14 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:00:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z9g4-8BDmOwYpxgp@x1.local>
References: <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t3uKo54T_Xls_O@x1.local>
 <CAE8KmOwdLk4oZg8TAt0z6rd27f0MpbSS54TWNDshZFU7WPxk-Q@mail.gmail.com>
 <Z9M7MYUPqHFIQPuV@x1.local>
 <CAE8KmOwcgvZekToHbznDWAidXM2L_4Aoszz6j19bSC4U8f4oRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwcgvZekToHbznDWAidXM2L_4Aoszz6j19bSC4U8f4oRg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 17, 2025 at 06:00:14PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Fri, 14 Mar 2025 at 01:40, Peter Xu <peterx@redhat.com> wrote:
> >+        save_section_header(f, se, QEMU_VM_SECTION_PART);
> > +        ram_save_zero_page(f, se->opaque);
> >I'll stop requesting a why here...
> 
> * Earlier in this thread you mentioned 'We need a header'. I took it
> as a 'RAM page' header, not save_section_header(). Section type

The question is not about the header, it's about the zero page, and why we
send this zero page out of blue.

IIIUC it can corrupt a page if it uses whatever cached in the previous
round in the pss, and if it used to be a non-zero.

> (QEMU_VM_COMMAND) was sent by qemu_savevm_command_send() as well.

But it should be for generic VM operations.  We have a few outliers but
they're too special.  For this case we'd better not add more outliers,
because neither it is special, nor necessary.

Thanks,

-- 
Peter Xu


