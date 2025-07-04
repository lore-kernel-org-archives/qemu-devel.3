Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98422C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiYy-0000Dw-JK; Fri, 04 Jul 2025 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiYw-0000D5-Lo
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiYv-0002Cd-1H
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751643771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vN3Qy+2CzqPMk14+DcBa4jEinTFhmhZCjHPDScPCkSI=;
 b=Y4QvQDwV9zX21yYtf81k+DlV2xarZsF9bXR4k7KNpbAKi29IfjNfCLtENnOBVZm1IkDQZr
 RxVLiI3F1S1RAhPEraefNInYgLdH5ENw2CeelOj5u/znNkvhvRxh3mZ16eT1MEsVt4DS4h
 FPghB8kkRxgJPhg2qmMBvkJm/J2zA+I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-4P5LsanRNPGpA5HezZxMqQ-1; Fri, 04 Jul 2025 11:42:50 -0400
X-MC-Unique: 4P5LsanRNPGpA5HezZxMqQ-1
X-Mimecast-MFC-AGG-ID: 4P5LsanRNPGpA5HezZxMqQ_1751643770
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7d44d773e23so277962685a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643770; x=1752248570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vN3Qy+2CzqPMk14+DcBa4jEinTFhmhZCjHPDScPCkSI=;
 b=bKEMIPJK5oqcm00nsvs6GoUtE3Q+HCeB3hBafHiwEWCDr5kfPkH9/1N/EdxABl+Bmt
 AO7Z0HdaTW/+jPNUICmFA9ERWrqNliBjiPMSBDcwlPwq+WzLXWxlVx49lzdg7cGVB13H
 P5EceXxOMhG46J3TqLCTfUhf0gg5EMJd6+we9rOwPq5S+9JcR6Ak+9kJFIoS/5Nofu/V
 9t93U67DEm3hwPVoouJXtbB2mUSrxXwPI3zcYLCpVRB0cZDmd+tqubmDSESUDCh/s8vz
 1LL6yYsccExqIdvBNO5e6No9R1Dy0Bp67oSGjVSFtYjwvDIv93lwo4mlBov8mFPCf83r
 Gr2w==
X-Gm-Message-State: AOJu0YwM/UpHY6hRpbWwCchp8AQfSHndlmPUYNFFCKeriT/mg7OUqe8x
 jcwZfpiuAu7jsIs1h4ZS0TCak2tSSfMNQw3H4DJbMBAomty08NBowHgqIeDaqKD/Pt7VjmeJrpS
 z4fH0WStOQq6+pnTELIIx4xTOeon2MypjcJIU8GOvNKoOSMRbkMC8oY0Z
X-Gm-Gg: ASbGnctpQRMUsJYIC+p4e0IeleVxtxWyFjVxtYEh0rgqCOGPqH9aTngEYD1e4/L4KPC
 aXrXC8GV5nZjZU/S0x5fl9JlKJKeaI/oYlAxHT5EFsSy3w5A/ERtmauxNzDIAOidFw27O876rmY
 9+Wgnawg8sgUHw/LKXg1y7KpoxlRtH7sz9BGBXTaREAleh8VP2W1GHHHzOpwAMa8BFO6/FMWY7v
 yKKK7a4bdHWOpDQWOQq3jEKjh0d/bkCulqkJEAbzp4nBwYIzMeEuCGIcDBGo4TOr0p3Fx8HNKo9
 XazOZDpNe9edZg==
X-Received: by 2002:a05:620a:28c5:b0:7d4:441e:f35 with SMTP id
 af79cd13be357-7d5dcc48b90mr487202185a.11.1751643769990; 
 Fri, 04 Jul 2025 08:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVAAGb1Z/n3etjE5lnN98FMXGpzl0oEaNVgQjkg07CYgrz64ujoJaFeGQh2ickVnOvbtpWXw==
X-Received: by 2002:a05:620a:28c5:b0:7d4:441e:f35 with SMTP id
 af79cd13be357-7d5dcc48b90mr487200085a.11.1751643769616; 
 Fri, 04 Jul 2025 08:42:49 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a7a6c6sm16209711cf.43.2025.07.04.08.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:42:49 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:42:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 07/24] migration: Add a flag to track
 block-bitmap-mapping input
Message-ID: <aGf2dlumKySlANEl@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 30, 2025 at 04:58:56PM -0300, Fabiano Rosas wrote:
> The QAPI converts an empty list on the block-bitmap-mapping input into
> a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
> for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
> Fix block_bitmap_mapping migration") started using the
> s->parameters.has_block_bitmap_mapping field to tell when the user has
> passed in an empty list vs. when no list has been passed at all.
> 
> Using s->parameters.has_block_bitmap_mapping field is only possible
> because MigrationParameters has had its members made optional due to
> historical reasons.
> 
> In order to make improvements to the way configuration options are set
> for a migration, we'd like to reduce the open-coded usage of the has_*
> fields of the global configuration object (s->parameters).
> 
> Add a separate boolean to track the status of the block_bitmap_mapping
> option.
> 
> No functional change intended.
> 
> (this was verified to not regress iotest 300, which is the test that
> 3cba22c9ad refers to)
> 
> CC: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


