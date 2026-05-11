Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA05BCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSa7-0004Fg-8n; Mon, 11 May 2026 11:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSa6-0004EY-Ah
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSa3-0007TA-Rh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778513402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uh5ML71EGl0rE5kw0U2DO+XZS/2/H1Jb7Q8Xwy5zEwU=;
 b=DqGrFD6jexhzwzqsIQceipP9b7rc3x7eXKwv6nC5XAqb99dH62G5xZH7oElt16fjCPr9AQ
 EiS1h/tRxrHjSV66DTcC/UpAhVFaxKkw7jrq8Wx34YtVsyDgVfS2p6YFRuT04MpSz/gIaF
 VVsCZaivCviQRRSdwbibAIGr0ObhMXE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-tFYftuvFOwGNVtwaWrS-hQ-1; Mon, 11 May 2026 11:30:00 -0400
X-MC-Unique: tFYftuvFOwGNVtwaWrS-hQ-1
X-Mimecast-MFC-AGG-ID: tFYftuvFOwGNVtwaWrS-hQ_1778513400
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b55b5aa8c7so94964086d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778513400; x=1779118200; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uh5ML71EGl0rE5kw0U2DO+XZS/2/H1Jb7Q8Xwy5zEwU=;
 b=Ja07M0QNgcpwkrVJgVnRm/TRvY5G82Ku8diyygkT9dmmVk8cHkNFZCpCOzCSQFSGwq
 GJun0/32dlTjWvcj9/JMVTM/Ovyz7F6cyPZIxUD1o4uyZPJ5a2hyyIxuOYy6i2AOsB2Y
 lvoVdb8+OCnzbxFfBh4NZsN3NONFuKpLfx1iCJvx12chn6lVbcv6A6j7pJswPK7fOZHS
 aIWG5qOnWpIGaa/qb2Zq6VMJwn78MrciGG0Khd25edxVtUy4tE4v7r0cusHLPxTf5Ipe
 mPbcMRqYsnnJqRd+DHVh8am6ag+U97Wjy10uHaijjAIEKjkvr+iqrA9z3G0fsxAhgANA
 c8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513400; x=1779118200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uh5ML71EGl0rE5kw0U2DO+XZS/2/H1Jb7Q8Xwy5zEwU=;
 b=GRTGehLQh496ASqYZLudJwHAAy2RExZ5fOAjKddv6fA4KiZE0QBXRFUUKGcuQHsBXt
 ulTzfcFP03XxeZoxCtTy+0bD7Y7Yetkp2LFRDiP+lwPkPlfwHkV/PO4nH+KpogENo3Mo
 +r8YboIQqOU+iDo2f9veGsOoQlHV1WcUoYHZ+fjV64DdC7npnz1/+d/Pby3R1nIUc+8F
 qgPF28DHLFGT6/nbY4n0xib7A5FJZ92MgnbzhCjzvpPFunhxW76pdesi70DKo74ZPotw
 A2q2mtgC+C7mu/l8FppZodC8fZHGUWLZjtRK/owWSDW/A06lRrUWErDEVFwput+uy1RZ
 FGsA==
X-Gm-Message-State: AOJu0YxLnauhcZbfw6i0gQxguM8Z4OGqxLpNJz7XX3YeHtkYLm0wL3T2
 0bNUnKT7tMeOy2Xea6uwnlss/sMH0G0Q955zv8cU63LcZ/bN4h/NJKdDjGqIa5DaL7KA/x7U5OS
 XefvXiGdwCDuZYngBJqc2RBw+UbeG/d1UJbFbVbU9e4xDQyquot8J7IJP
X-Gm-Gg: Acq92OHh4avoOnXFC2KZmRe5yR1JnjSQXX3g2Zjtg8Nedmh6mU7sJdk/+z2ntq0mXax
 MwY8wGwh92HUzWyp2hFvm1b0ZP4t7JNtguzAbN9DKZHDWKA2QC02qDlxldDilOb5I5HiC/MjgjU
 1LP3yklIys2SLHKaoQAOK1QMzXhluDQsMZ79duYoY7RlLCZsmI2iKpKv5M1tIYwzuaMiCShwzJM
 RFoBLQHUy+g1izYKDm2st/DK/UcKpXHv7SXm/eZt7ddwplTX+nUjE59fUmhEmBG/oPpn1Dni+Xi
 wzyWb3G/D5l2NLYWiyOzgi2D9+F4M6crwP0GpAGSianyjGeaiFvfaywToMyQpppOsaAUeqYVFBK
 GXqnwmI4Z13iUX280uqmfKhf/5LELg3O7oAMfYvBKp210+n0=
X-Received: by 2002:a05:6214:3bc3:b0:8bd:a072:cbc with SMTP id
 6a1803df08f44-8bda07213d6mr318471526d6.3.1778513400020; 
 Mon, 11 May 2026 08:30:00 -0700 (PDT)
X-Received: by 2002:a05:6214:3bc3:b0:8bd:a072:cbc with SMTP id
 6a1803df08f44-8bda07213d6mr318471006d6.3.1778513399487; 
 Mon, 11 May 2026 08:29:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3b0c4c9dsm100779906d6.5.2026.05.11.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:29:59 -0700 (PDT)
Date: Mon, 11 May 2026 11:29:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc
 expected downtime
Message-ID: <agH19jdl3UYZeStj@x1.local>
References: <20260511141049.1293449-1-peterx@redhat.com>
 <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
 <agHs1PcxZYJtba4W@x1.local> <agHzQnXFQbnam-RF@x1.local>
 <CAFEAcA8L_BgfHEUnJhWCJ9-aMPUadbvQWGrF2UAW8vE53JP=6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8L_BgfHEUnJhWCJ9-aMPUadbvQWGrF2UAW8vE53JP=6A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 04:24:24PM +0100, Peter Maydell wrote:
> > This actually fails to fix the ubsan issue and I can still reproduce,
> > because the ubsan issue was a Nan reported, where it seems when Nan found
> > in normal such evaluations it'll return FALSE.  I'll need to use:
> >
> >         if (expected < (double)INT64_MAX) {
> >             return (int64_t)expected;
> >         }
> >
> 
> Hmm, how do we get a NaN ?

When mbps is zero (when it reproduces here).  I have the comment in v2
explaining it.

Thanks,

-- 
Peter Xu


