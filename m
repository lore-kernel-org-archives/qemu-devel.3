Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC79C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmeYk-00021q-1I; Mon, 24 Feb 2025 14:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmeYh-00021f-P6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmeYe-0006jM-Vo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740426962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QACTOXTWi0pEEqgA1eFjniN0X1Ka1TMKejL1+gIoito=;
 b=O5GCHtIKqDZcd1UgBKQKMbHh3LLjlj42MDGm/p4YtIDaA4Cmic8BgOZ6jrvtaT2j3Q9DT8
 Q5961G/t6W0SN5iODQ7faPDl87awxJqWRYDZYnB0ZBi9xWnXjGhhKGme/oCN3dMcAcZoK4
 7ae+FDk3/vXjPWeuLZx/UZ5K2l5BziU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-93UvYG6mOLGYhBucc5tXYg-1; Mon, 24 Feb 2025 14:55:58 -0500
X-MC-Unique: 93UvYG6mOLGYhBucc5tXYg-1
X-Mimecast-MFC-AGG-ID: 93UvYG6mOLGYhBucc5tXYg_1740426958
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47222600a5bso39946631cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740426958; x=1741031758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QACTOXTWi0pEEqgA1eFjniN0X1Ka1TMKejL1+gIoito=;
 b=vonzGOvVkZNfWGXdLT8h32S6VtYvKEOHgLcyC2nee9yPPuO3vpKh/ygIhPpKGEj0rU
 L0v5iz5+WLbY1e41ms8u1UEfPyAv84Trpmu7ixE66q45fQhyJDl3/PQNRy+iNiWffz5L
 hUHoU1/sxwUY4b8Bh9B76MvjZvRFLq/AcrMkAqEJ8uC7YCqX6vdYg+vZ6pZMPtUDFeJj
 zPkd+vb4qJQdU/akpbTN/w1sRi0HINNzarV/4ujLZaiGP8hrdqR+XNuwHogqAdynoqHC
 Jql7fHP8ArC+Y+0/9YW/RFim/fwfbP2TTeN4WRvPLX7Rpi8gS+6/9YzxdyhU6VGZiNgG
 xxNQ==
X-Gm-Message-State: AOJu0YyovThjxEIB9JqWYCW783UuwI2Lb2PPemRFXDBRAuDuVahSBIeQ
 RMvsfWx4x1S486Z87XGNR9DcQsV0YjHdMbk5H2KbqaLUEETOT7xulKnk5tGP51I4Hit3kmppS9G
 KSqZ5IJOYxmDqY70yv64hUO9gnTlYNjfEjjlFe9pQxMp96eQ57akq
X-Gm-Gg: ASbGncvmOvItZnf1cUJNbCxbV2EBaUNMYN19YtDBhuCPiO2d/t8fBo/uKrmLS8H1i8I
 h88pZQ+gg5UsMc3Ejs9Urk2OsWAHeBv+iYbU0gNZGKoS87fVAYwQwbaC1C/lvBe5l01HMtLXXV8
 s4Z/s3ExrqNerSbEV22xPD6/6RA9l84OnWWkKOyhuY4akIKwCxMplAPGkND3hgjbK65Nftoi3m0
 djSZ0NA3IWRRxutQCaPnu4f+C3JNTuri3+0+vqCBDtSf+3Qbohb/JaR/IZFYcNU3DCs4w==
X-Received: by 2002:a05:622a:1a88:b0:471:9721:db91 with SMTP id
 d75a77b69052e-4722295d9dcmr156996981cf.51.1740426957856; 
 Mon, 24 Feb 2025 11:55:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJGPhEXeBRzAArAxhLlRlTS68QXUsXql8hol+zcMeEKp/C4aN+53Z+n2PTAWRB/Vw5VIGlwA==
X-Received: by 2002:a05:622a:1a88:b0:471:9721:db91 with SMTP id
 d75a77b69052e-4722295d9dcmr156996741cf.51.1740426957502; 
 Mon, 24 Feb 2025 11:55:57 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e071e1sm351011cf.7.2025.02.24.11.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:55:57 -0800 (PST)
Date: Mon, 24 Feb 2025 14:55:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/8] migration: Prioritize RDMA in
 ram_save_target_page()
Message-ID: <Z7zOydkedkVuwqDj@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-2-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063612.695909-2-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 02:36:05PM +0800, Li Zhijian wrote:
> Address an error in RDMA-based migration by ensuring RDMA is prioritized
> when saving pages in `ram_save_target_page()`.
> 
> Previously, the RDMA protocol's page-saving step was placed after other
> protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
> failures characterized by unknown control messages and state loading errors
> destination:
> (qemu) qemu-system-x86_64: Unknown control message QEMU FILE
> qemu-system-x86_64: error while loading state section id 1(ram)
> qemu-system-x86_64: load of migration failed: Operation not permitted
> source:
> (qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
> qemu-system-x86_64: rdma migration: recv polling control error!
> qemu-system-x86_64: warning: Early error. Sending error.
> qemu-system-x86_64: warning: rdma migration: send polling control error
> 
> RDMA migration implemented its own protocol/method to send pages to
> destination side, hand over to RDMA first to prevent pages being saved by
> other protocol.
> 
> Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


