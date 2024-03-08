Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB42C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUmr-0002nx-W5; Fri, 08 Mar 2024 02:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUmq-0002ni-Jl
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUmp-00078g-4D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709883418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60fpAYJhgWjnQBzbhQo5ksoUi2CHjomo4docI3TtOf4=;
 b=DhVW8jf2Y8mEkh35JDXw4wx5iMsMcF9ZIvAeOo9DzcjEaECrifGzKGBMieGBB+UI+QvxJY
 MxgFlA3WcebcqNt4xPsfFBiY9pe+VtuxBWJxppaJw0YmQ+DvWLe1CtxZgUi2cCvrCVP5yk
 ZNFHa1VnIEuxlUXJzUqqK7ttHV1KZgQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-FFu0j4euPqah7psBN38hhg-1; Fri, 08 Mar 2024 02:36:56 -0500
X-MC-Unique: FFu0j4euPqah7psBN38hhg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-299180d546bso448961a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883415; x=1710488215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60fpAYJhgWjnQBzbhQo5ksoUi2CHjomo4docI3TtOf4=;
 b=UovIS4tV3XWU2Tbm0lldoUCvQP7dlDly61U/RUaH+9uwjchT0SGNcQXEwVs0enS9RU
 t+3S6IkkVgv3ap30ZScluPZvWyalwWrjojn8XLVgdE6hkslsT04kbtkeAV5W1bMImM6O
 3VNjl+1tjDqlvgMOSOCyMbxXhOVdzyXhG/Ja8iaPCc9Nd7xM8Zuvzzu+UNGBQm1iZtL8
 ruFD3QS3rGb8+c4n9XmIbbxxY8Msx6u4hxfeF4KSWI40LIBU5uLMCM3LZcoz2xeVsjvN
 M2lRwpnHKf4DW3d/qZE/IsNvcC0j/et35yx1Gi16IK+UTgbxUJgo0cki5YBLpvkEnno5
 X2sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz3R4GAHaCFfzntWRiP0GOa8mrMIV0jcKYWgUkpJEsMlhgS6qJAlacBz7ZrjRcFju1YG8DQxstKSw18r4y6z4uMen/20I=
X-Gm-Message-State: AOJu0Yw8DDe/bKOM4d2/cb4eeCs7vLesqLOk28cEURH3Snk2wXMIPMd9
 FvtUEYSb0yIBeLTUGvx3cwh5LIBZlMD00BsRh35quuzrIrGYl1ASSvASzi/9k0rTywYorxpwKM4
 qMxsZBWHtIKMQWRSlO0jM9Y+gcmBdkpNZMHT5oeHpr8mxq1x16DLR
X-Received: by 2002:a17:902:ed54:b0:1dc:c28e:2236 with SMTP id
 y20-20020a170902ed5400b001dcc28e2236mr1427882plb.2.1709883415037; 
 Thu, 07 Mar 2024 23:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfbsbQDGS8GA72YUk7TjazH+Tj71MMHL7CiLzaqYcxrhFL4MNB4J7URiBnmdsvcw0YBjK51g==
X-Received: by 2002:a17:902:ed54:b0:1dc:c28e:2236 with SMTP id
 y20-20020a170902ed5400b001dcc28e2236mr1427872plb.2.1709883414601; 
 Thu, 07 Mar 2024 23:36:54 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p8-20020a63e648000000b005d68962e1a7sm13915832pgj.24.2024.03.07.23.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 23:36:54 -0800 (PST)
Date: Fri, 8 Mar 2024 15:36:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/4] physmem: Fix MemoryRegion for second access to
 cached MMIO Address Space
Message-ID: <ZerADmIeh6XnbOkG@x1n>
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 07, 2024 at 03:37:06PM +0000, Jonathan Cameron wrote:
> v2: (Thanks to Peter Xu for reviewing!)
> - New patch 1 to rename addr1 to mr_addr in the interests of meaningful naming.
> - Take advantage of a cached address space only allow for a single MR to simplify
>   the new code.
> - Various cleanups of indentation etc.
> - Cover letter and some patch descriptions updated to reflect changes.
> - Changes all called out in specific patches.

All look good to me, thanks.  Having the new functions' first argument as
MemTxAttrs is slightly weird to me, but that's not a big deal and we can
clean it up later if wanted.  I guess it's good to fix this in 9.0 first as
it's a real bug even if not trivial to hit.

I queued it in my migration tree (with my "memory API" hat..).

I won't send a pull until next Monday.  Please shoot if there's any objections!

-- 
Peter Xu


