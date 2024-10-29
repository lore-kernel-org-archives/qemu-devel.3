Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D97D3A699
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5swE-00065D-8s; Tue, 29 Oct 2024 16:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5swC-00064y-Qw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5swA-0003Ev-Kq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730234132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+GzwjzWPUoQYDM3pqnwqrbMw+r1C8GBJWqD9OzRRt14=;
 b=iowJeyZVS5viZTrmovqgvSVXFTpbiqqYxv1dFtKKb50nUqXOovy2yl4OJUwYuoY7y/vC5G
 rDaOZ+f8l/yP3DRz9ukqOFrQEz9JLtu1C9uRqA90n38tZ/fIaSfTo3mXKtplMtSz4x3M0P
 dSXlZbfRp310KruCvmjbw/A5+WST9AY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-d7R2A1hpMLCHIQAlLhrMOw-1; Tue, 29 Oct 2024 16:35:31 -0400
X-MC-Unique: d7R2A1hpMLCHIQAlLhrMOw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b1473a4640so79972385a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730234131; x=1730838931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GzwjzWPUoQYDM3pqnwqrbMw+r1C8GBJWqD9OzRRt14=;
 b=OuhxJt49OixJmM9ESQHCgOHUPTjR592rJuOE3PR/vJVsGi3rtw6tb7Ec26yerh5kQ8
 HOBFpg+tMsPCN/QrERys2tjBdNN9tMAGFXUruFBnOZErAg7jeLJyWphiMstoPyq4wvKO
 +mb3ZtpNRSK7KQFfy1oUNF6Zzqom7Pd3CuLQtdu9a2w+sOG6N/d3J2l5Yv2hrZLHIQ9x
 pAHP43OmMMbj2XE72GCs+ud9mf6rFt+XBW7dfloY17eqO8apo3uXn+PXDoUtnH4i5IC0
 PLUxSZ0jfDT0oogmHj459A8X2eWlhKiaR+Qk+Aof8e2OrUQmUYd4DugMbCICLqvqi6Ij
 I6vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5L2RwBSlzwSxGPAGR1yPy/VZcbgNbDBbNRMXKZxTr0b9ubv6aY7JH2Te0nx3dtDYbKJjp69NB/dz3@nongnu.org
X-Gm-Message-State: AOJu0YyAIpfFQlV0n6HXN04RRmGvCGdArG6ipTf3JAt+SvV2+TN3ER8o
 wfnZ/yL4DoFPHHC6hFd7ByoKjP8oNd6nKn270rknixraocON4bPlzvAFnxEyJtRubv2Amo1iyy0
 07OwH6kJHZpsNfr6orOWmZV1J4a7lpUigWBgc8/dJmATQmiAFXRJW
X-Received: by 2002:a05:620a:45a0:b0:7b1:49cb:5852 with SMTP id
 af79cd13be357-7b1b06a234bmr4942485a.32.1730234130679; 
 Tue, 29 Oct 2024 13:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLDX09YGNmTMkE6rlOAnq1/A9FsgoFZi2vkb8lt6Att0o81AohZucq3Cc7vDj1lgKTOGGulw==
X-Received: by 2002:a05:620a:45a0:b0:7b1:49cb:5852 with SMTP id
 af79cd13be357-7b1b06a234bmr4940285a.32.1730234130375; 
 Tue, 29 Oct 2024 13:35:30 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d2aaeb5sm449957485a.63.2024.10.29.13.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:35:29 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:35:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] migration: Document the BQL behavior of load
 SaveVMHandlers
Message-ID: <ZyFHEOVShZUp-RvO@x1n>
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 29, 2024 at 03:58:16PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Some of these SaveVMHandlers were missing the BQL behavior annotation,
> making people wonder what it exactly is.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/migration/register.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index f60e797894e5..c411d84876ec 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -210,6 +210,8 @@ typedef struct SaveVMHandlers {
>      void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>                                  uint64_t *can_postcopy);
>  
> +    /* This runs inside the BQL. */
> +
>      /**
>       * @load_state
>       *
> @@ -227,6 +229,8 @@ typedef struct SaveVMHandlers {
>       */
>      int (*load_state)(QEMUFile *f, void *opaque, int version_id);
>  
> +    /* The following handlers run inside the BQL. */

If above also requires BQL, why not move this line upper?

OTOH, I think resume_prepare() doesn't require BQL..

> +
>      /**
>       * @load_setup
>       *
> 

-- 
Peter Xu


