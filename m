Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34351CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH487-0005y6-Fo; Thu, 06 Nov 2025 12:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH485-0005xo-1w
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH481-0001oy-5i
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762451429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQit1QfXrciKTkMLH6MtH/dQJjKELHFfkDu3E09pJK8=;
 b=am0/+ZD/mRo/wnk1/6wTaTrEHJRki0tlwzFfXHtTEgaJ3jHjnx3xZprMQQsP9KxjXGmy02
 hCuh93KYmgmurNfHfyh1VHohmtoEls7T15DpQNY10PK68ecDkNb1ITRL0soMu1q2vCN7jL
 RDOX2fuvM/0RRpFK8/oZ6FoiPDfJHlE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pmRF_9KkMRiBFSdHFzrBNQ-1; Thu, 06 Nov 2025 12:50:28 -0500
X-MC-Unique: pmRF_9KkMRiBFSdHFzrBNQ-1
X-Mimecast-MFC-AGG-ID: pmRF_9KkMRiBFSdHFzrBNQ_1762451428
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e88ddf3cd0so670751cf.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762451427; x=1763056227; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mQit1QfXrciKTkMLH6MtH/dQJjKELHFfkDu3E09pJK8=;
 b=rI5mZEj47D+zDIfVcROBtz9uABV2Zu3QHbB0WZ7DJ2rPBATHfjt/VC59YbxQ3Ucyj0
 osm3HvV9tmQB63Lc84q8tSY9mYOHmB6qIOuQjqzTVIZaotRT6MseF1QkiRGopKsXhztO
 VyfxYQn3zVS1B+qizrq+EpapujCtBqcucz55xerr7KdsxisqyGDrRWijZbJZG0TQusmT
 26a18SvGw7LXSigoAFEB4G8MrzuFpOjy/m3IhURW6+rXPjeoGlyBNL+S2rMCASRr26B0
 TLs9G2wFQ6lnFJMHdDYfjKXJ4GggFzRotS1SxRcsPTH01nNPkP5daseYv/wJMft21RmC
 E0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762451428; x=1763056228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQit1QfXrciKTkMLH6MtH/dQJjKELHFfkDu3E09pJK8=;
 b=rWShpgmXV8x2QClnSQHn/vb1f+xJBrADdx2yLsOpLTkguoG21PUiNUFkpJ6bk9bVWH
 3dUziAA13k7gPG+zJPWyEnYH52HmkpENDpZnYrd7+YdymU2gbPcYdvPz0Xt+J6cwAr3K
 45QRhTIXmRgz4eXDzeDHjG4DaiyAMnGU77ClC2tvoLAUiXxAY3B5da5HTkqLBrGvYCg+
 xbnXmF0DUp8qHcKGRGTKU29Jz7pln0dYX8wxd7XewTwC5m0sCmKrXtYIqL2aYWyE3BrN
 JabN6g27QhgkQ9UrnO7MsIoiLiYGaTMiIT08mQe+vhbVVgviDQKOtrMLX2yigOkutMkV
 KPJw==
X-Gm-Message-State: AOJu0YzKY8x4lxyuOWgjCT/agEQukxAJg5hNMfvfKugV4S7GMBtt3meC
 83uoonqSbu6H3OsZva+XszTfGisTGV/41lC3C4NLq4KbUqiP2gZn3ws3sX48cMFw/pdHUog+kuv
 ziAQQJSFWUhU6WJSebzCb8RV9x6sWVzvuOcsVEmNvSloFNuPCbrWMJFQ4
X-Gm-Gg: ASbGncvqZMIwLtX0mToJ4fFczsHKNs8lb9si+lsH19W/wRniQozKh4ZtR1hetqqsMVP
 EzUPwWhkUlQPomqICunLRqu3NApSPIUYpHW7c988iTgSycfHNhnrWNsgdoFWDuZN1+xFDyEGeqJ
 sv5me4yJohB1hMdGhFcVrTEOEJy4C3UQavXTcESm/lyd/Wuf5Qoq+7QHJylgUjlloRT8nFiDs7s
 uB5UV3PuB2Bl8TwE8abbaUKijmFjGzp2HqV/odror9EAKln4s1sZmtmikxmBNeX8g34pO02lHlm
 PjdFiF6tiUmgnrurb2QuG/PNwLq3YX5O/jJKDrFbBM7sFvsJZ/Lezo+EPfWbo1IcM6A=
X-Received: by 2002:a05:622a:1a29:b0:4ed:6324:f544 with SMTP id
 d75a77b69052e-4ed94a6904amr596871cf.43.1762451427602; 
 Thu, 06 Nov 2025 09:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYa+y0pD4mo872jVMQYyhnfx/KCrj0V0Fx7qoiJYMmclGDZC9P99GrMTJH/NR1U++ndoSj0Q==
X-Received: by 2002:a05:622a:1a29:b0:4ed:6324:f544 with SMTP id
 d75a77b69052e-4ed94a6904amr596421cf.43.1762451426979; 
 Thu, 06 Nov 2025 09:50:26 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813da43asm21758541cf.27.2025.11.06.09.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 09:50:26 -0800 (PST)
Date: Thu, 6 Nov 2025 12:50:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: Make FlatView root references weak
Message-ID: <aQzf4F6RgkzYWkeM@x1.local>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
> Generally speaking, we will not necessarily "always" get an issue report
> when things went wrong with memory management. A bug in memory management
> may not cause an immediate crash but corrupt the memory state which you will
> find only later. The end result of memory corruption may look random and
> result in a hard-to-debug issue report. A user may not even bother writing
> an issue report at all; this is especially true for this kind of corner
> cases that rarely happen.
> 
> There should have been no such a hazard of memory corruption if the code did
> exactly what the documentation said in the first place. The consistency of
> the code and the documentation is essential, especially for this kind of
> complex and fundamental code.

Do you have encountered such case before?

I wasn't expecting that, because what you were saying looks more like what
Linux kernel would have a bug in mm.  QEMU is still special as it has the
default unassigned MR trapping everything by default, meanwhile normally
what is moving is MMIO / alias regions rather than real ramblocks.  It
means when things go wrong we have much higher chance to trap them
properly.

I also confess though that I'm pretty conservative on fixing things with
hypothetical issues.  In general, I prefer fixing things with explicit
problems, so we know how to measure and justify a fix (depending on how
aggressive the fix is and how much maintanence burden it will bring to
QEMU).  Without a real problem, it's harder to quantify that even if such
evaluation will also normally be subjective too.

Thanks,

-- 
Peter Xu


