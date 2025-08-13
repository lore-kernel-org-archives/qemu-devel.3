Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D7CCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 20:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umIHk-0008QK-Hf; Wed, 13 Aug 2025 16:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIHi-0008Pj-N8
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIHd-0006Ct-Ej
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755117670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9I5/9kO+POYQrCzOcvY282FuKBPpzVwsQljzdJkB6r0=;
 b=QgM6dEnhr+bTaQJnGKxUe/2huxh1wRnypYyheAg71TZFILHTAcgPGM+/pFrQHdCVMdTAN+
 pR8P6f2yveCsXVXWR0S+JBpy+B0OwGstB34aSkvvcOiyHxurYLBL+LZVBLADUa8LJt05Wa
 THo6pSJKSvJlH1ylBxrbCPrttXZ6lYE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-DsOOWCukOHSn8Aqn6hQg4g-1; Wed, 13 Aug 2025 16:41:09 -0400
X-MC-Unique: DsOOWCukOHSn8Aqn6hQg4g-1
X-Mimecast-MFC-AGG-ID: DsOOWCukOHSn8Aqn6hQg4g_1755117668
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71d60336e0dso4356617b3.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 13:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755117668; x=1755722468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9I5/9kO+POYQrCzOcvY282FuKBPpzVwsQljzdJkB6r0=;
 b=PZfP51ZCKwhIRJQ9e2fjYGAmeSNSD5KGW26oA3ahbGK0r0yOlHcPJQ9Uq/z11wvJwX
 /hcJkCYwYe/NSd6redjOaaT5FzBuYC+v5tUwXDHLoRcE1QpOMisHG61lOjEhrLFVojmq
 v18bhd0LoAtLitvXZIcv2FGQoKxDomIShac97vno++NeOGcbmcZYKRycZrOPjaSMnZ63
 PtcXrooeVN35HlS8ZStJPYI17/Yf/gJLPWZch8pYhaqeAeNW+Vw7OjE1N4ijUPMPY41j
 TAkNrqSLEJQ+ZUtCsahgJdIIwkvERpVIcl565FEI6DHNqC8DDnmm1cwus0SI2Dq4w0ac
 imFQ==
X-Gm-Message-State: AOJu0YwwWi/yGN9pGwqphOTl/pEUOSLZm2KuJTd8zhsdsZrxf7U4VveJ
 df7yGwdVq0YKbfiM9Md02W4/SzJwvRNvYF5SFsne6LYkCdPvXpcRvfMvpAkuQDRqrcIgqsK9Wcs
 Y8BzvEmX90VZ1yY4PHR5peLGc4r9q8vWLJJ0qbMIikr0y7x8pe7zNA3Lz
X-Gm-Gg: ASbGnct2lm+Q+47RccCRJ5wyTmAGclXBH7sgYrQECT3EQ0K+JHbbW5w0rVsM6zsJ4q7
 K0tS/qAqdYnBZwqGuI0JSmcvOZAVwUsINDTmz45Mi/fK/yKaFAJqWA3fRdr8vEITe4ioXqGp2y2
 rtihKzvsaPLQXp0K51dt3C4Z8+YNW8PqkmvQcBVonazCZeB37Y42kOLmRkKHdGFWQS7zuSyZcBa
 vDt3w6gzuRBImcbgrK9zDPc+KV8CZMPXNwD5BZQGsltHsL/UvPHDwVxIPOK0mpIbxgSZGvA7yTM
 T302rfeeTiSnOQfBQmIDUZwjlBv/RaXR
X-Received: by 2002:a05:690c:6904:b0:71a:300c:d17e with SMTP id
 00721157ae682-71d635bcafcmr3975907b3.20.1755117668455; 
 Wed, 13 Aug 2025 13:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD+cbeaQI+8ceMa1JddiwGd3soG1icQGv3t5uJXDLlQYscNFAWI3GcawViC7Q6826j8f9P4g==
X-Received: by 2002:a05:690c:6904:b0:71a:300c:d17e with SMTP id
 00721157ae682-71d635bcafcmr3975687b3.20.1755117668121; 
 Wed, 13 Aug 2025 13:41:08 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d61047c70sm1458867b3.62.2025.08.13.13.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:41:07 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:40:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 15/24] migration: Cleanup hmp_info_migrate_parameters
Message-ID: <aJz4VrNE58fKCt80@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 30, 2025 at 04:59:04PM -0300, Fabiano Rosas wrote:
> Do a cleanup of hmp_info_migrate_parameters() before adding more lines
> into it:
> 
> - Make sure every parameter asserts that the has_* field is
>   set. qmp_query_migrate_parameters should have set them all. (except
>   for block-bitmap-mapping)
> 
> - Remove the if (params), qmp_query_migrate_parameters never returns
>   NULL.
> 
> - Add a macro to encapsulate boilerplate.
> 
> - Line breaks for legibility.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


