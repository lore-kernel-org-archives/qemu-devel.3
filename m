Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E36E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSX7-00022p-E3; Thu, 02 Jan 2025 16:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTSX5-00020t-5x
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTSX3-00017X-Nb
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735852503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxp/KcVjywRK6foMv460VmY4UcoWqBCpYwKLnVoWAX0=;
 b=G4hGzkuo4+sY6Nr7Ju/r0AGEnxYJIbd2MMf6/s1PXlw3FohF8QzAhbKMxVeYTNXjmph5f0
 D6yX3rJSOOhvL7eISDC8OJbCKzBzzbMAtIsPsts83hrE5u6R5Mpe8pDu2t6WVX50TDrAJk
 I64l27IA4yr8YtYU0jMKEo3NJzg5wz0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-oF69Hh8oPPG3-aoa6TI3Gg-1; Thu, 02 Jan 2025 16:15:01 -0500
X-MC-Unique: oF69Hh8oPPG3-aoa6TI3Gg-1
X-Mimecast-MFC-AGG-ID: oF69Hh8oPPG3-aoa6TI3Gg
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4675c482d6cso204247201cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852501; x=1736457301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxp/KcVjywRK6foMv460VmY4UcoWqBCpYwKLnVoWAX0=;
 b=C0z15co89W5ZONTxdYhXM9MaPMhQid7OHoStlmSpmMgDg6xRp1vYpIZpCqPqZDJmzP
 WxNiIWo8E4PMhPsXb8lNoEdj6u4HaS1XjPpG38P/YcUBj8SR5b6F/2gnsbaq7b7pbTfP
 lCzC047Uxyxj4YbLtdnu8RW+qnoWD1ZnhQFzIqYB6dhg5f+C9Nd9dFYEqLbZTGnlINNA
 WjF8P2xvTFozcCk1wNIKN5ojgbR3x/QwMuL4DqPAjclNCGGEUmbFjaqwY++s9fRs3f3i
 4gBzof2vL7qENKBmvjr5Mx3v07pAOU4jqVNS+F+iVK/zMoQz1La53KKAebqX8hqpq7p4
 HyzA==
X-Gm-Message-State: AOJu0YxwJKsIv0M8XDzLftI4iv8JIBJILFjFUY4VnO1Sbfw9u1h/M7tf
 WEB7roQSLnA6C7+zNnTUaiQEf2d4aOUtz/rf0Ug2djrivBxG9nlnDQvU9rvLTy69i4Z9niuzBN4
 p/bEggN0Ospbmn3JZC9JjKjpKoGACPqTT+Io2NeqCUSLrUqCOh/bv
X-Gm-Gg: ASbGncuTgeKKYSCdKKuKH0PDympo7z3/nSl6Vg4quUcxQPni1tHIHg+IBTn35ej3vkH
 wBKM2LruLiIoXaNFyMagqaM+W8mJrz4nluyD6bFZTHYONff/7nk/ombEyz1ygqJiBP3+qQC4zsd
 JlbGtSw1OlAR3svMyWiSELQK1bwMzgVkW/Wacsnh3UD3MSNN9TDJMt7RJ1eRjsUn3KwANtx3F3P
 kYTFzLi+owXxQEvqdYY53gYCiC98LG1kyUQ4HJhFU5sCM7XdlRIroZtlKD9O5unq/7omRjSuSgD
 Lk2u/Q5KL7uewtVkjw==
X-Received: by 2002:ac8:574b:0:b0:467:94ca:541 with SMTP id
 d75a77b69052e-46a4a9bebd3mr916693771cf.55.1735852501334; 
 Thu, 02 Jan 2025 13:15:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUAsvLMErocy42MER6TW3+kXD4VpkduDuWh2wKEobEghpY7mEKtYYQgojlwCvJFsXLvBdLrw==
X-Received: by 2002:ac8:574b:0:b0:467:94ca:541 with SMTP id
 d75a77b69052e-46a4a9bebd3mr916693461cf.55.1735852501065; 
 Thu, 02 Jan 2025 13:15:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb30b97sm139008231cf.86.2025.01.02.13.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 13:14:59 -0800 (PST)
Date: Thu, 2 Jan 2025 16:14:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] physmem: fix qemu_ram_alloc_from_fd size calculation
Message-ID: <Z3cB0TehNey27uNZ@x1n>
References: <1735850090-329906-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735850090-329906-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Jan 02, 2025 at 12:34:50PM -0800, Steve Sistare wrote:
> qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
> it uses the existing space and verifies it is large enough, but the
> verification was broken when the offset parameter was introduced.  As
> a result, a file smaller than offset passes the verification and causes
> errors later.  Fix that, and update the error message to include offset.
> 
> Peter provides this concise reproducer:
> 
>   $ touch ramfile
>   $ truncate -s 64M ramfile
>   $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
>   qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
> 
> With the fix, the error message is:
>   qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000
> 

Can have the cc tag here too to be super clear:

Cc: qemu-stable@nongnu.org

> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Please also feel free to attach this patch as the 1st patch when repost
cpr-transfer, it could make dependency easier no matter how this would
land.

Maybe it'll be still easier to go via a migration pull that collects cpr
transfer as a whole. May depend on whether there'll be a memory API pull
before that..

Thanks,

-- 
Peter Xu


