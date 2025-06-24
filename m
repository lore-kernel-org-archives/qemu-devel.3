Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E27DC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4f4-00005M-Q1; Tue, 24 Jun 2025 10:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4ex-0008L6-7k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4ev-0005Lh-9c
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpNtBFjfB26Ws2iRNIWY/S/bkRwf4HfjQVJTt7gzC28=;
 b=LDdbbTjym55tYBbgTAoBksPiTjvNm+Fvo/hV1GUYOwRXtQraEluEbUcWVpp5ZPRlRFFUEU
 nGHpFSFrw/XzXVVhLeaFnmNV3k4bJhVZ4qfRwH8gcPOsEb0qa2uvTh+m2BZpg9pPduG2TV
 ZpR5sGXSoKBrCqH2Zl4xTLqsFtjjdbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-yQHFAUfcNBumM_3fWA1N7w-1; Tue, 24 Jun 2025 10:29:54 -0400
X-MC-Unique: yQHFAUfcNBumM_3fWA1N7w-1
X-Mimecast-MFC-AGG-ID: yQHFAUfcNBumM_3fWA1N7w_1750775393
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so3240445e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775393; x=1751380193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpNtBFjfB26Ws2iRNIWY/S/bkRwf4HfjQVJTt7gzC28=;
 b=hQ+eatYu6o+BN5unfZnwgtNlu57+N7zycvBP+tTrtffSOlG+KC5+8zXwT8FpnN70Hg
 KIEjslX3PJNyxgyW0Qrh/7U70ZQMHs9wDuDtWd9G/4GozIUvswzpTqtnPe0pnHcsoG/j
 rUgwVWl1uXhsTg4cctd+iWccigHHtoXwnF86ZUjd9LdhRtgFPppns/8H0PtCtWH763Hf
 5WgLRMvOh1LKMskeNtp5FK2UGQ+HWFdseE2zADOQHv0g7zeH42rJLVkUvAi1FxoJ7+5g
 s0+nAXbSjtiSDdJRC62dZBRLvE4L/nNEUS4mfP6BUdoERnAr8zsK2WB1fgDxmxyZySRT
 jyrw==
X-Gm-Message-State: AOJu0YxmVfvwlU+vUcCdDvh7QYwkwEok9fFEe7qW2w/qf2ba3KS0tuwy
 G2jWuj2zo3TWoZ8YwtGhC5l1jzxkcHpy2eA3NjhezgGnzNYoUx+irfzTwXfPTKGYADSNosbvA1d
 KqqrBn4ZTtlXEQdmQaXYDyQ8OtFcrOKJrmOGRUpESdj361jnuOYmLKhGj
X-Gm-Gg: ASbGncup063R4tVODjztL+J3yZgzji9rHbQzjWNkK7ujf+rVyp6mTuWw5Sso7IGyjTH
 sq3J2lkIb9ztP78NnHIrMJNKiWVLLDSSy/4Ufe77pmla5QE13XCLe/bs1l4Z6oVqKfvovTt3YjU
 07RcnVPb06g/9c5e4q8J1UQYHch/dH9zO+RFQqE6TtjuYd8uwrTh9PUMs9AKVJxDmGCH9X9EFs3
 PE4QMmn1+ca92vbX14FlNtOTFz8m7JVosXAGfIEPZsg1Kx1a8wNlfBRk+IYdXGypmbun77fRwQm
 E3wu/jSSiNw=
X-Received: by 2002:a05:600c:1910:b0:442:f482:c432 with SMTP id
 5b1f17b1804b1-453654c931amr169503175e9.18.1750775392926; 
 Tue, 24 Jun 2025 07:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqbERU1XEkqmnj3sjU8wUbB4/O7D3yiYGb+e/z5LUuu6X4wJdx1iUTJfSBtx6Zb0wYUJwMVQ==
X-Received: by 2002:a05:600c:1910:b0:442:f482:c432 with SMTP id
 5b1f17b1804b1-453654c931amr169502885e9.18.1750775392553; 
 Tue, 24 Jun 2025 07:29:52 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45374582452sm68444415e9.31.2025.06.24.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:29:52 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:29:50 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/11] migration: Drop save_live_complete_postcopy hook
Message-ID: <sf2anrqpglbflnavo2f2sgg27c7nooi3xfdf32su57qy6lnuas@bsbb5belv23x>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613140801.474264-6-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025-06-13 10:07, Peter Xu wrote:
> The hook is only defined in two vmstate users ("ram" and "block dirty
> bitmap"), meanwhile both of them define the hook exactly the same as the
> precopy version.  Hence, this postcopy version isn't needed.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


