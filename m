Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29949E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGdL-0005EY-DQ; Fri, 10 Jan 2025 10:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tWGdJ-0005EN-Ki
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tWGdI-0003Ne-7R
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736521746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xj1dKyhdWuYTz6cGEjiYWamxJu9Nh0m0w7zvbR4G+Zw=;
 b=RWPkj1TgjiZJajHYmiId3V+ifZ0pEJ4nE8Z7kptA3pPMdueMSPYMQz4u7wdo5JyqkhaZc6
 QZxbgqGUrvhx3X5ZPcym3XR/AHATAoNSsYEBSbelGMD+GWR+VnZ3o8XYqwrku0HABXrQ+S
 fdO0RpM38yUPKyEPAxXuibFC1Ml4odo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-5tpEdRL8PsucemqQjmFysA-1; Fri, 10 Jan 2025 10:09:03 -0500
X-MC-Unique: 5tpEdRL8PsucemqQjmFysA-1
X-Mimecast-MFC-AGG-ID: 5tpEdRL8PsucemqQjmFysA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f943f59dso349626385a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736521743; x=1737126543;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj1dKyhdWuYTz6cGEjiYWamxJu9Nh0m0w7zvbR4G+Zw=;
 b=gKiipisYDIGVLdsMn66DFqwifcwZ7bvzDGxfNTgeWFPgOmqydOdmP9FRZoNthU9BDt
 msxOvs3rma/YhJZB92qUWcYRE4QOHbajvg2+ZpamB3JnXxMlv0ORN3DaJ9mS7Hnu55mA
 k08mtzVpm//kx7L16neA3aSFHyY0C2e/eWrkIc7km0c0FVXsOixR3BQbPp3NjdmP5Pgm
 7VKgI45M+76rGU78R1d8n41oqRXxINRBE4y2tEnqxWyqdHz22cX7lMRolY8JLmQqHO4V
 WEm76S38p+xv9Bg0B4+kvHvUxVXsbB47iffUgiGYE0F0GUrT0dl8MIZmyZKJH3Qp0J0Z
 Lrvw==
X-Gm-Message-State: AOJu0YythNjwyP7Ll/XDst2hX8azfjErkmYTf0EbEeDyPfz+yav2iUmw
 ZQ9gcryhao1AtOmu8T92fpTWb/gzEDLOxUxKNCnbU6ItkiPcYFIcz220WaLgyfvQrSu+DPPR2D2
 h3hdnm68QNnk+7I0y2W3uhGXx2m3TxYznkvdCEiRqV04HgMgp3K3X
X-Gm-Gg: ASbGncv/Asi9WoZ6hkAHOXT1EMaXbVGR3fe/UqDdYU+U9IlQXK+QaaA2rnVuNtN4up9
 w85KSpth/J3R1s7s0269k0db3k//gKOFidgLV29nR1aWcDfsi0fFRW44u9G58PXEeOBDfBORSym
 rrpBEdnzterVXbuSmNyeFUr8QDa1r3k5uPrnvQpDD5RDdeTk0NQnADVEoVHC3jboneUd79+gFpp
 WY6FPtzu3IFHhHx8XSqJQWVsvUDclehcnKo0Bko6KIKjBOZFMEJbQnXfu3R+b5yauHCWddTHPVi
 YMjSkEQHRCbH/o8jiA==
X-Received: by 2002:a05:620a:4613:b0:7b6:edd0:d752 with SMTP id
 af79cd13be357-7bcd97279d9mr1943305485a.5.1736521743237; 
 Fri, 10 Jan 2025 07:09:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJLfjhdbTQrAh1pMGgg/uFclRhBol1DnVNCtlTmi9GvDJZZaglW5E1xk0RQ6caag8zgNfYuQ==
X-Received: by 2002:a05:620a:4613:b0:7b6:edd0:d752 with SMTP id
 af79cd13be357-7bcd97279d9mr1943300085a.5.1736521742631; 
 Fri, 10 Jan 2025 07:09:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade73406sm9949676d6.78.2025.01.10.07.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 07:09:02 -0800 (PST)
Date: Fri, 10 Jan 2025 10:08:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z4E4Cx0DRFyCVXog@x1n>
References: <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
 <Z1MpY7ZIAAoBDbZU@x1n>
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp>
 <Z1oYIn5cMZeA4tes@x1n>
 <1ab0a747-e2c4-4545-bae9-31e19c77bd75@igel.co.jp>
 <Z1sFUxCiQp3Nziu_@x1n>
 <2e2dba3c-2bfc-478a-988d-fbf2e58cc293@igel.co.jp>
 <Z36su8G_hlkdBFy6@x1n>
 <6a4dd6ef-9d0c-4f1f-81eb-0d55fa32daf5@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a4dd6ef-9d0c-4f1f-81eb-0d55fa32daf5@igel.co.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 07:11:27PM +0900, Tomoyuki HIROSE wrote:
> > > MR implementation to be safe when unaligned accessing (current xHCI
> > > implementation does not handle unaligned accesses but the spec allows
> > > unaligned accesses).
> > > 
> > > In addition, maybe it would be better to document the constraint that
> > > the situation where 'valid.unaligned = true' and 'impl.unaligned =
> > > false' is not supported.
> > Do you perhaps mean this instead?
> > 
> >    valid.unaligned = FALSE && impl.unaligned == TRUE
> > 
> > If so, I agree.  I think we could even consider adding an assertion into
> > memory_region_init_io() to make sure it won't be set.
> > 
> > Thanks,
> > 
> 
> I'm sorry if I've misunderstood, but are the following understandings
> correct?:
> - Need to merge my patch that converts an unaligned access to aligned
>   accesses.
> - Need to add 'impl.unaligned = true' in the following two places.
>   - hw/xtensa/mx_pic.c
>   - hw/ssi/npcm7xx_fiu.c
> - Add an assertion that to check for invalid patterns, additionally.

Yes, all these sound good to me.

Thanks,

-- 
Peter Xu


