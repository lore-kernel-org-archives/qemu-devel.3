Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8EC1061B15
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7GSC-0003F4-7T; Mon, 30 Mar 2026 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7GRo-0003EJ-01
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7GRl-0004Ji-3f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774891839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tr0d1X0tAI5Jm8VGPCg93bMytwvGFsi7JB0t4XpbKJs=;
 b=QQjuNDC1UNkqbKjHmgkvMeZn0U8PLbjLc4z1OUiorvtWKv/ZjhSnZndZll28VKZfAv0vui
 89nfXtht614iiDJ3x1TNxRceUlFpNkmMSgSEwBxlJdUTpTKPHHoQAof36EmCZGq0bjZM5d
 dTMQTAGwK9HibE08EuLzUngwESqxA/o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-IWi0qRyePE2m-zDc5mr6ig-1; Mon, 30 Mar 2026 13:30:38 -0400
X-MC-Unique: IWi0qRyePE2m-zDc5mr6ig-1
X-Mimecast-MFC-AGG-ID: IWi0qRyePE2m-zDc5mr6ig_1774891837
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd80bea54dso1205880085a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774891837; x=1775496637; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tr0d1X0tAI5Jm8VGPCg93bMytwvGFsi7JB0t4XpbKJs=;
 b=dG4NxunMaKNyL4yGxBg7Nlr4MD60FUvwGGMQuEk8IMAYfyGhIri6kO8HYR/1mxXNbC
 JNPfA8Df7jtkm3IDd70+fM1ErSAevNbb/QZj8tw0lNN9uDzzD1Jieqs4BsM47DQVJaOo
 cqETogLpoKAx5MTFNY79e182CweFT+DCMCBFPKGC6V1ImTU/Prst5usT5Gm6cG3+M24q
 cYhG3Tf0eKl5z17V6L9im2QC+zy3MDmuNUezkp6X9U0iZAgFs0Gp5w95ijEhMKv/rF7E
 kLHG8OTEXgBXTLf4q3fw3TEkx4is5a83VBH+tIYI5UFaa9RdW13g9XmyQis0ZxqQCFPi
 389g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774891837; x=1775496637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tr0d1X0tAI5Jm8VGPCg93bMytwvGFsi7JB0t4XpbKJs=;
 b=Rmu3JS6ggOzp2GF8iGSZQ0rn5Yii3y5N3/Qby3yn8KcDBnyAKnyDrFZZj2Mb4o6Ubv
 U+Tx65fSwWduniSw4C7AJeq2X/zmBoLopuHRK61Bw8GMZr0lEMe55Mr2W/0y+4lJRZ4n
 D9IfPZZa1TgBA5RuS7Og+d9HBA22QIMmhrSewu3o2BFNa4yKkB1dWSnHGC4EDxuOeH6A
 tQZX743UfNB7J0fk13nxomZ2JFFZEoa63awKMGXZTVCpqxdOiH0AJ4XPtC93CIcJCM8u
 +K/Fa/Cok1vNItHM41+UtLLnr8aM8TX9cZlhNY/ubH9mSKscB5ERYlsE3LSY9WAycSzd
 W8wQ==
X-Gm-Message-State: AOJu0YyCivoeAXXGJ4/iZduulaL3SUUUArpebNFzX0JkaPeeA3wgdwvN
 ihtWPM/PNQN+mbU7d83oalWKn7aIokle0pJawQ/Bsq6Xyvbing2qn52oHXCGBJj6MihPGpquzg3
 N10qZHAyJEhLbavJ8waHTtDE5x5oMunzUKfRzawxl3imUbAX0b1mNWjTo
X-Gm-Gg: ATEYQzxgovfyc5ihqcdK+quoG/N2kcN+gBt+uAUgr0jvi9U6cPRKuMI9IFnwrCM08Li
 J2RoMdMf+VXMb3YwSbUw5Tyskj2x9rWt32L5ZYNPJfPUr968Vqlxq6N9ohlHX2xQhIQzOY0xUAV
 oLDjXqRZM09z/Npvxrnkju3F/pOaEFxVcId0ZQ1yRfEfvsv1IySD2ntg3RTeY9TR2cPHq7Ve7mx
 kiiKLB7BY/ms3c7a2rmmH8Lb6RhgT3h8WqHk4vNXlzN7I/uoqbKmZmY4GgzQ4kcb3WXL3GLnbIP
 CqirbtmSYdqpXwqHOaJmpHWNe82CZzxYeW2Kl3Hg4/C/rElcDN+ED4nKgUbrUs206oOW6HsHyFf
 sFpy/7q4SZXA9ow==
X-Received: by 2002:a05:620a:19a6:b0:8c7:1119:2994 with SMTP id
 af79cd13be357-8d01c7fdfe6mr1871716085a.64.1774891836805; 
 Mon, 30 Mar 2026 10:30:36 -0700 (PDT)
X-Received: by 2002:a05:620a:19a6:b0:8c7:1119:2994 with SMTP id
 af79cd13be357-8d01c7fdfe6mr1871696185a.64.1774891835380; 
 Mon, 30 Mar 2026 10:30:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d027edb8e0sm778515685a.8.2026.03.30.10.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:30:34 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:30:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: validate page_size in mapped-ram header
 before use
Message-ID: <acqzOqkSC3oXSznV@x1.local>
References: <20260328072424.10611-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328072424.10611-1-vikingtc4@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Mar 28, 2026 at 04:24:24PM +0900, Trieu Huynh wrote:
> mapped_ram_read_header() reads page_size from the migration stream and
> stores it in MappedRamHeader, but does not validate that the value is
> non-zero before it is later used in parse_ramblock_mapped_ram():
> 
> num_pages = length / header.page_size;
> 
> If a corrupted or malformed migration stream provides page_size = 0,
> QEMU unexpectedly crashes.
> 
> Add validation in mapped_ram_read_header() to reject zero page_size
> values early and return an error instead of continuing with an invalid
> header.
> 
> Steps to reproduce:
> 
> Create a migration snapshot with mapped-ram enabled:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
> Modify the snapshot so that MappedRamHeader.page_size becomes 0.
> Restore the snapshot:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate_incoming file:/tmp/qemu-bug-test/snapshot.bin
> 
> As-is: qemu crashes immediately
> (qemu) Floating point exception (core dumped)
> To-be: qemu continue running
> (qemu) qemu-system-x86_64: Migration mapped-ram header has invalid
> page_size of 0
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..2a7e958e87 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3088,6 +3088,11 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
>      }
>  
>      header->page_size = be64_to_cpu(header->page_size);
> +    if (header->page_size == 0) {
> +        error_setg(errp, "Migration mapped-ram header has invalid "
> +                   "page_size of 0");
> +        return false;
> +    }

Thanks for the patch.

When at this, one more thing we could do is verify the value is exactly
target psize; afaict that's the assumption across the whole mapped-ram
feature.

>      header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
>      header->pages_offset = be64_to_cpu(header->pages_offset);
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


