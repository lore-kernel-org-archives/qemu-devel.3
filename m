Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B34E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3uZ-0005md-0D; Tue, 10 Dec 2024 12:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tL3uX-0005ln-IF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tL3uW-00025y-6D
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733851234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMyB5ySac8N7/C0ll3Jf0icaOOzWpVBnwbAPFt0NS34=;
 b=fgkUavqN9wmq6LplB0nLC8Wv9Tri10TOwOWOCxfLXJ/iDdHHH6kPA8ZdlKjKL5ZgOlvjA7
 ZbsdNNXbEv3EE0EqrB/kaFz+ZQed+eF7MqcHyPIUw1MN1uUgXiufMtxNP3bhP1yEGYQUt3
 tq5QXASyCd/ZiR6bNHMMpEECi77QzFs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-GypGbnLKOWy1T7Bq-V4Dgw-1; Tue, 10 Dec 2024 12:20:33 -0500
X-MC-Unique: GypGbnLKOWy1T7Bq-V4Dgw-1
X-Mimecast-MFC-AGG-ID: GypGbnLKOWy1T7Bq-V4Dgw
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a9d4ea9e0cso24577625ab.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733851232; x=1734456032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMyB5ySac8N7/C0ll3Jf0icaOOzWpVBnwbAPFt0NS34=;
 b=eNUF1yDOUOqTt/g0Ig7AfSYx+mqtUAMy+Ya/2Y81tmgTKjcPwCu0sRgSMpVdEb9pB6
 2Boqort9ve2wnQn88yVe0znvag/y39MSClHe8cgv4ngYjH5vqEdUeTN0eh6XY/S7pJk5
 et1U0qNhHbu6Fe35gU7QFKvbhSI9M+Kxf3c9k4qcOQaVHaQYgQPfs00LiAVAsDZy8QDC
 mYAhIANPZjSL52bPD6IxKRyBdMWtZIrGDzfzLqZEykQP7nxDybQujJOKsmhCp/C4cKNK
 1YXmV0bp3PqpV1eYNCI8brPc31NnfPV0Nb6avfPuGkg8rM1CWvLi3Jfr0M6gxIceMbQ8
 gz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdr1EZlGWHFDIbnUYfmRF/36Yf+QLGySoOIIBwwPKLyELDNXLaXO035zE66sEu6DP61HYwCtjmohUt@nongnu.org
X-Gm-Message-State: AOJu0Yy0r9Fae7KMo1st4xmcj+kwtyUhvYVfpaG42q9T94Wbb0KtPawd
 0Fmm3dCLqbV2ho4SWVoEVTn6iTaOGHs9CkveHiHAInqx6xJaWYBYUysObKuTaHXXeAYiMcUgWNl
 mACKfX0yh+FBVOrElY529vFvPLWg9fbWeFDANMstZUZQZnA0mmAfn
X-Gm-Gg: ASbGncufghaObaHF/b6OPvzl1n9ya7qXCe2YN1blDygEqjuy02gT1BRf9v2id/gW/GE
 dN/XbjWvr3Q78CwnkFCNg6EWkcb31ZM13Iwgn9MrdACK0Nij55Sy/o+0PEA/20PQbDkLFucdXLy
 XmuHM/XG04BcwKvn0rmJF1H9IJUJF2TZOdKH6DerkurVZsk4AQT4+WXFBvgj7aw8QzwEXAMYuRt
 jSAXqe98/X1llLCaaPum/n5qZtx2LStqx+7PizIvWv+VVXWQtFEocxgT0OvGBcb3OiCKypz43FM
 6GIGowbEBUNz+NM=
X-Received: by 2002:a05:6e02:20ce:b0:3a7:c5ca:5f58 with SMTP id
 e9e14a558f8ab-3a811d786e4mr177303425ab.7.1733851232505; 
 Tue, 10 Dec 2024 09:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Rp+3H0tmqeZILV8rxe7nM022OV+FewaEv8Uo4k+1lIX84sBz1n/DYU/DITByzWGYMc+Hbw==
X-Received: by 2002:a05:6e02:20ce:b0:3a7:c5ca:5f58 with SMTP id
 e9e14a558f8ab-3a811d786e4mr177303195ab.7.1733851232197; 
 Tue, 10 Dec 2024 09:20:32 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286221a33sm2858121173.145.2024.12.10.09.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 09:20:31 -0800 (PST)
Date: Tue, 10 Dec 2024 12:20:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
Message-ID: <Z1h4XaKCwfidJLfw@x1n>
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
 <Z1JOpadES2iV_i0v@x1n>
 <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
 <Z1hw7dvTe4jMgXeq@x1n>
 <ddd20bd5-2596-4966-a77f-fb44b651dc6a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddd20bd5-2596-4966-a77f-fb44b651dc6a@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Tue, Dec 10, 2024 at 08:01:08PM +0300, Daniil Tatianin wrote:
> I mentioned my use case in the cover letter. Basically we want to protect
> QEMU's pages from being migrated and compacted by kcompactd, which it
> accomplishes by modifying live page tables and spamming the process with TLB
> invalidate IPIs while it does that, which kills guest performance for the
> duration of the compaction operation.

Ah right, I read it initially but just now when I scanned the cover letter
I missed that.  My fault.

> 
> Memory locking allows to protect a process from kcompactd page compaction
> and more importantly, migration (that is taking a PTE and replacing it with
> one, which is closer in memory to reduce fragmentation). (As long as
> /proc/sys/vm/compact_unevictable_allowed is 0)
> 
> For this use case we don't mind page faults as they take more or less
> constant time, which we can also avoid if we wanted by preallocating guest
> memory. We do, however, want PTEs to be untouched by kcompactd, which
> MCL_ONFAULT accomplishes just fine without the extra memory overhead that
> comes from various anonymous mappings getting write-faulted with the
> currently available mem-lock=on option.
> 
> In our case we use KVM of course, TCG was just an experiment where I noticed
> anonymous memory
> jump way too much.
> 
> I don't think it's feasible in our case to look for the origin of every
> anonymous mapping that grew compared to the no mem-lock case (which there's
> about ~30 with default Q35 + KVM, without any extra devices), and try to
> optimize it to map anonymous memory less eagerly.

Would it be better then to use mem-lock=on|off|onfault?  So turns it into a
string to avoid the "exclusiveness" needed (meanwhile having two separate
knobs for relevant things looks odd too).

Thanks,

-- 
Peter Xu


