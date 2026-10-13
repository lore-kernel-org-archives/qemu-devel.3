Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B112CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGf4D-0006o9-K2; Tue, 13 Oct 2026 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1xGf4B-0006nY-9n
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1xGf48-000185-P6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791907762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yP83XJvp4VLaagwHMHEe8pZfBYpfSoP3EcYHgdEhKEc=;
 b=WowLcSpjTgCKvhQlus+PBfmaO6ZyAadf83jMgK5XrFPJd9xTmsUEnQ1QPpoCf//cp4dDBx
 bc9N0Ik8FruTTMwD8RPyLUAdwfTb+RLJ0qygPsuzVLAP8Pnl9eWFSiDPKog0VQ9xJt4Hi6
 41q20wP+HL6JwaeODbKprzhEO4VyUJ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-90tBHKLgM2-K3OLbdSFNEQ-1; Tue, 13 Oct 2026 16:09:20 +0000
X-MC-Unique: 90tBHKLgM2-K3OLbdSFNEQ-1
X-Mimecast-MFC-AGG-ID: 90tBHKLgM2-K3OLbdSFNEQ_1791907760
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so918185e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791907760; x=1792512560; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yP83XJvp4VLaagwHMHEe8pZfBYpfSoP3EcYHgdEhKEc=;
 b=tfJ2lfe/MJyIEZkryYnDHnLaWViMymwjygFW9ZfMh+V/Pb3+47/65B4xwKmEe1HouR
 VmmS6h8mymSWE3vxykmreyEnWC4M8gVyMMCPYHdIAfXzrmg9t2j7Ne+/HgqbGQjjyUqb
 NbgxkYyCnwENPjRDKeu2hNGWikZXRx8dn26NFJcZKCr2W6j32lCkRPts59tuYzQs/BHf
 I9cfyglZeg+wD+UCTS0FQXU73MGhtNZDoONGldDegrInHr1UifR/3X5+5A1/5mhzLJBr
 zRbtOCO4ZkMBDihoLNdYQul0wJ8RzeGvg2Y3ttjt3tEPM9YHfMwsKzLiSEidae7onuNc
 HQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907760; x=1792512560;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yP83XJvp4VLaagwHMHEe8pZfBYpfSoP3EcYHgdEhKEc=;
 b=mMpUMhfC7XvkFOYaIVuGC3hBkQKBNCZh65wAIEg6d0h+cst0dWtEwaxES4A2kh6ePg
 NW8VYovDxN64sKkIR6qA4+5dLXqVWH9cgptfVLb2hfwTgXxq/rC/zIlx6AX4ztjmw4bz
 /pJR0x5Xkt9tsTPyQUeI+5pOSmwLDAsGF4pkAku4GZ+MMLQGSVs1iP2hogx3m71vOCYC
 YA5XPy8QxAA9Pivf1jszxO7N2tT+b5X9gO4f8hmKkTQ6X1N8minjp0OGGDVImPfrT9yr
 cYmPe/bsTa80vcdYz79vdpsW+X35TCz7RFThbznG/w0d02vqPpaKjmP94q/UyoSuaY5F
 oM1w==
X-Gm-Message-State: AFq9FYIrY9C/4XQLABZPMwdKz0qmuhOX6bFk+7Hc2bD8MWFHpZICgs/A
 rXPk0Z8UCimk0DdGheDfWfGsKncjbu3PQhxpiBWzXc8XxNPoPXCu8YobUOfaB1yyGUE8vB5PNFX
 oU5NZ1o/OCqkKSUV0lVqN/aDKug61T+zJ/ffuCQpcNUIHRCTfKiDGOkUKddIkXjP2nME=
X-Gm-Gg: AYBFou3jl2itL9AGEWb87qgNaqXt/KgDXyGgyFprWZnhDbeV2aW0MUyN6nnXnY4ujaC
 9zrKG+ASPxMCzLQxM9BXwA2Pf946wxgo3tvrCMD3TRsNBaaL2jNvjNfqrC+xPnsqIOampcs13kc
 aTuXJP3yC+pTDZ35kVWRNt7p3HRHly3GAjS4u8GvgVSo20m8Q9uVmaLQDpANkWoWnbxWum2a/E8
 6wXXgvNc9sjQoMjPmT5ys2S1Wai3Yrs8NbEZRaM5PqzuwcNS1psDa5N3FTOuc8gaQXtCg7i+S+o
 eX/hxBzGSHHQmiPIDF75hjfWiEONHWrCa4McRMJywqg88DwIeumNoJ7JT3MnmDaxEHviCwDn6tj
 g1wV1Hq0LYUTi3w==
X-Received: by 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr259997175e9.20.1791907759610; 
 Tue, 13 Oct 2026 09:09:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr259996635e9.20.1791907759191; 
 Tue, 13 Oct 2026 09:09:19 -0700 (PDT)
Received: from jmarcin-thinkpadt14gen5.tpbc.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2e0dbsm396395115e9.11.2026.10.13.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 09:09:18 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:09:15 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration/postcopy: answer the package-loaded ping
 from the run BH
Message-ID: <as5XFTYFvjN1Q3dI@jmarcin-thinkpadt14gen5.tpbc.csb>
References: <20261002110258.1835979-1-den@openvz.org>
 <20261002110258.1835979-5-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002110258.1835979-5-den@openvz.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-10-02 13:02, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") keeps
> the source in POSTCOPY_DEVICE until the destination answers the
> QEMU_VM_PING_PACKAGED_LOADED ping packaged right before
> CMD_POSTCOPY_RUN. The destination answers it from the generic
> MIG_CMD_PING handler as soon as it reads it, so the source's
> postcopy-active means the device state is loaded, not that the
> destination has left RUN_STATE_INMIGRATE. Management acting on the
> destination once the source reports postcopy-active can still race
> with loadvm_postcopy_handle_run_bh().
> 
> Record the ping in the MIG_CMD_PING handler instead of answering it,
> and send the pong at the end of the run BH, after the run state change.
> 
> The wire format is unchanged: the pong only arrives later, and an
> older destination keeps answering at once, so mixed versions
> interoperate. The cost is that the source stays in POSTCOPY_DEVICE for
> the duration of the run BH, including block layer activation when the
> destination autostarts.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 1 +
>  migration/migration.h | 2 ++
>  migration/savevm.c    | 8 ++++++++
>  3 files changed, 11 insertions(+)

I have tested the patch and it does fix the issue where source becomes
unrecoverable if destination dies in CPU sync, that I tried to fix.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Tested-by: Juraj Marcin <jmarcin@redhat.com>


