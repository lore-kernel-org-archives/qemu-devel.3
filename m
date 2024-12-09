Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD86E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjqe-0004AP-Id; Mon, 09 Dec 2024 14:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKjqc-0004AD-Aw
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKjqS-0006ul-BA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733774101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FQdyOP/9wOB7kZzoK1aXKChYaS1ZobY7zYsdxsMdZk=;
 b=ETi56BvECAblx+UEp70PaQY5pb2gWfvK0nX42tNXsbgRX7Je8oME4d+gX7ZVDNnb7Ylppr
 GS+15MjMrjyUIOcUDBHwaQpakUag91xLputJQc1XwsKfxTcVY9NlMT2E/sx6HAPEy9BKtd
 Wlr+3yxvhZBWvm/epZ3/vxfp9AFhNok=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-uW9eWivsM6mhEaVWhRevZw-1; Mon, 09 Dec 2024 14:55:00 -0500
X-MC-Unique: uW9eWivsM6mhEaVWhRevZw-1
X-Mimecast-MFC-AGG-ID: uW9eWivsM6mhEaVWhRevZw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6d23e553cso225651585a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 11:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774100; x=1734378900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FQdyOP/9wOB7kZzoK1aXKChYaS1ZobY7zYsdxsMdZk=;
 b=eX73lYezqpY2tDYbqp302AR1AyqeTWrla5E8Cvi8kUAej4sFxBYB3mzJWCbpebhd1H
 YF2Zxp6Z4CKgQLNhs6e8fJh76Be9vmaqgbJ5KHVI0nR0TT0Bbmz1U8EnO5Ro0/21GN0L
 3L/uk6wZuqHQrJ0Rxt0sOl+IHCSRAAEvISHqvZA66hlozvaqH1EULDDINClyTAwrL8iW
 puAOSemzt10z3URmIlpWePIY8HSgnWIjD38BStfSGBKy8dO3x7zFdHcde4zM6fngLHVU
 5LlxZ8dVBN4rybC1ec5Uivay382UMrnlFblSvWG1cGPIEHXiItFTt8YyF18HWmAGXp1O
 xckg==
X-Gm-Message-State: AOJu0Yyx/hRM3XDO6buJO5AJUgBtT2+kub786KZ5kZlJ6GUQ0N/WD7GI
 i5o7KVV23xd0LXVA2QItKhVIIEf0aaP5NsBUNxHv8Vr8WpuzNqBKv9F1hTAm0556BJr57S0niN+
 fRP9B+bIcJlAcUyj9WqwuLkhW+DiCgs5F9DcuJzESYmOo32LGKrBb
X-Gm-Gg: ASbGnctLC35iEzVJfNE040k5WuzYN1oeOXNwLBk5zTY3eLJjEFv3grrCjxQiFRjr5ls
 DbHPbElf/2YbMklBK66rf2/8ZoZbgufxAkrQqcaS6GPvU+e7mpcMNFv2Evw7DtKp8xBFgtJoNOR
 z1cjpTUu2YMoPf8cdi0LqctOKbAeaeBYjJ0lpTe2q+9HpzYt5NSQYhRX8kUW4elGQAEGpEK7VUd
 C+8HJHjzbStAEst3yvL2JWTJbhiz3eZSBYkacL5lPtjkW0hj6lKqxU47Cddt4fyiSR/jWBEcKmy
 jYkyrIS2gwjXF2I=
X-Received: by 2002:a05:620a:8089:b0:7b6:73f5:2868 with SMTP id
 af79cd13be357-7b6dce80c07mr266397785a.42.1733774099808; 
 Mon, 09 Dec 2024 11:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXPK0UoiGhcApJeeXkIi3BEYhpZEp9fg/sl3WidJnbQv1iAOFtQbC3drg9rvcZu6eBA1baNg==
X-Received: by 2002:a05:620a:8089:b0:7b6:73f5:2868 with SMTP id
 af79cd13be357-7b6dce80c07mr266394485a.42.1733774099555; 
 Mon, 09 Dec 2024 11:54:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6dd1b6cd6sm33719585a.64.2024.12.09.11.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:54:58 -0800 (PST)
Date: Mon, 9 Dec 2024 14:54:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
Message-ID: <Z1dLECXaEv4Q0BO6@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 02, 2024 at 05:19:56AM -0800, Steve Sistare wrote:
> diff --git a/system/physmem.c b/system/physmem.c
> index 36f0811..0bcb2cc 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2164,6 +2164,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      new_block->flags = ram_flags;
>  
>      if (!host && !xen_enabled()) {
> +        if (!share_flags && current_machine->aux_ram_share) {
> +            new_block->flags |= RAM_SHARED;
> +        }

Just to mention that if you agree with what I said in patch 2, here it will
need some trivial rebase change.  IOW, IMO we shouldn't special case xen
either here, so it should also apply to xen if one chose to, changing aux
alloc to RAM_SHARED.

Frankly I don't know whether xen respects RAM_SHARED at all for anonymous,
but it's a separate question to ask..

Basically what will happen later is in cpr-transfer migrate cmd, it'll fail
for xen properly seeing fd==-1.  That'll be fine, IMHO.

>          if ((new_block->flags & RAM_SHARED) &&
>              !qemu_ram_alloc_shared(new_block, &local_err)) {
>              goto err;



-- 
Peter Xu


