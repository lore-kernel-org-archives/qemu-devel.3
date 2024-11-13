Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3DD637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHgx-0006AY-8t; Wed, 13 Nov 2024 13:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBHgv-0006AN-LO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBHgu-0000F7-5N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731520927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cd9W7NdOkWPHgVLncWqA/74AoCFkHE0xMaRdT1CLouw=;
 b=SAxwChZgjGjOhQ1/XunBAyBSOGfUXy685wncpcpNKGELU8FzSq5grVMXRXV0G7k3K5mHol
 7wG7E1lMvIlsm5s0m1MgwFJMDFAn9XXx3gLDB49MILFD8DpzrB8zzpqGOBTdc5dznvCpTZ
 BlOwCuXAEGDxHBCP1MZLKZBXOUYvQl8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-g8L8KcbwMD-m6KSAoMbrkw-1; Wed, 13 Nov 2024 13:02:03 -0500
X-MC-Unique: g8L8KcbwMD-m6KSAoMbrkw-1
X-Mimecast-MFC-AGG-ID: g8L8KcbwMD-m6KSAoMbrkw
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7cd9ac1fa89so6912091a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520922; x=1732125722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd9W7NdOkWPHgVLncWqA/74AoCFkHE0xMaRdT1CLouw=;
 b=Jotc1OmZME2X7EdaJVHfzz4rYflUG151BkNLGPbs8KBWe+jMBNjYX90eVeVnJpKa41
 khw7JOOlB/NxWT5fkwS7sjeRSGwHdpFDnzjtRBkPA4oBtnogrz7uDLEaZTVRehtbyhF1
 DqhFujG2nbLVgpbLEfzD7kylMy0QfpE405ev+yR9fh948x/sdOIiXWmMbp2iYaA2tuoW
 9rfqwX+q4Uupuc4tn7ugnFZCb8CiqLJUYzRlblk1qpoVebrEYq4WFUF+o1g/VDaZb9KJ
 ZHMZ910HopoHT5iMZOQLSUoeBAkTaAdkgSgj5fwmZbpf1K8EHNW6+8i4gHdbo2rqz8j4
 KS+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFbN35q9iD/aiZPGWkMIHcbfa1XMpG5UHeVihyDPPmQfnVRgtRkyvQ/8PzVf7V3RHIrYD4B1jk/yRb@nongnu.org
X-Gm-Message-State: AOJu0Yzou+2va9BqwqZhKNTye5z7eqF7l36ILQ8NwNLvhIQVUrgObWvB
 /GVBwxLjMmHyJHiQyiYbJ0QwMJEBDthmzo0GzYQOuM2u+4eUZ7we5KZdskEJ2USezGMabThRaKx
 7wotUe96hvMGRnjoKK7CSi5EpK4yrDHzlulrO0Mu4sABCxuEQLFmO
X-Received: by 2002:a05:6a20:9150:b0:1db:eeb3:d06d with SMTP id
 adf61e73a8af0-1dc229b02e9mr27513686637.21.1731520922636; 
 Wed, 13 Nov 2024 10:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDWEuA1JojwpsMg/dZZwuLi+bPyTta799LWQQZBSp2DVxO3JwvrUc/RJdRL9Io1s41l1v0hw==
X-Received: by 2002:a05:6a20:9150:b0:1db:eeb3:d06d with SMTP id
 adf61e73a8af0-1dc229b02e9mr27513639637.21.1731520922324; 
 Wed, 13 Nov 2024 10:02:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d6778sm90927851cf.89.2024.11.13.10.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:02:01 -0800 (PST)
Date: Wed, 13 Nov 2024 13:01:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: farosas@suse.de, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: fix-possible-int-overflow
Message-ID: <ZzTplxAevuEhJi82@x1n>
References: <20241113140509.325732-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113140509.325732-2-frolov@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 13, 2024 at 05:05:01PM +0300, Dmitry Frolov wrote:
> stat64_add() takes uint64_t as 2nd argument, but both
> "p->next_packet_size" and "p->packet_len" are uint32_t.
> Thus, theyr sum may overflow uint32_t.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4374e14a96..498e71fd10 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -623,7 +623,7 @@ static void *multifd_send_thread(void *opaque)
>              }
>  
>              stat64_add(&mig_stats.multifd_bytes,
> -                       p->next_packet_size + p->packet_len);
> +                       (uint64_t)p->next_packet_size + p->packet_len);

IIUC this will never overflow due to the hard limits on both
variables.. but it turns out this is the only place anyway to have such
concern, so no harm to have this if it helps quiesce some warnings indeed..

Queued, thanks.

>  
>              p->next_packet_size = 0;
>              multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
> -- 
> 2.43.0
> 
> 

-- 
Peter Xu


