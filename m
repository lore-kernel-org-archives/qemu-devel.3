Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E77E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwTK-0001a8-SD; Wed, 04 Dec 2024 15:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwTF-0001ZE-P0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwTE-0007kI-EO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733345979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ruVMgMMv7L+ciADoWUpIMBDbq7xXjqzdGoK/07rCxs0=;
 b=B5MQFerOZ0UIgotNLlRKf3vt+QzChCX8s1oPKqFm1T6If/Ol7Ilqt9WoDmaXD5gRquJ1Xa
 mABu2I9toDYiyDmli81q05Vkjp4dOG+grVn+5X09rHzg+Dzp7dD2vhsQfFTqC5AzH3VFTq
 kZ3Aw4dyvCRVZzXwYzzoFMnyjbgNRig=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-7BbbBWShNJmfFnrqkSXUGA-1; Wed, 04 Dec 2024 15:59:38 -0500
X-MC-Unique: 7BbbBWShNJmfFnrqkSXUGA-1
X-Mimecast-MFC-AGG-ID: 7BbbBWShNJmfFnrqkSXUGA
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a7a1e95f19so1362145ab.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733345977; x=1733950777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruVMgMMv7L+ciADoWUpIMBDbq7xXjqzdGoK/07rCxs0=;
 b=YvhCRewaGagJRTCWIG9gHrlJDeGvFtMw9tQSs5sRqGIwIm/Y1F36bTK03dwH9g5OmV
 M6LDLCZwXPRE9AzJcjCxDmI6Daggeb4KDG3qnQQRlS3AO0ZM0CAypY+p6qa31TzZ/Xle
 J8tRHVEWyRtFDDdVmzMa8CVOqYHFtIEzmlF4etQ7PtwR0vZp7dzDFYFbU4C81k5wsrm4
 Son0Qw542wgMQlfVJwI5XdaRWiDKUEuLCRJGsuojK4gstppldrmkMzPbroFY7BbsqeR3
 PL+Ex9Kw8phlXprUv2I++3ZecZIOkcvtzaGXp4ypVv0gukWbLIdf9h/Ag3iBlsZLXV1P
 lyaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt8KL+KgBPkqBL5fw8wXQQukegOyTb4SNlS4nZuotTG9sevs4cRd3OGwYRi09aZyZM73HBX/7OVrWh@nongnu.org
X-Gm-Message-State: AOJu0Yzou/ztcX0VYvh4oUViRmJuTwk5r3bAnR5KwFZ4vnHErvhITOQR
 hNRY4Zo0IczV3UeAg/ko/GXlLzPtTEbxJ+F6xchyIvwNmpjveoTGwgheA+M8/1dM2K5IPfG/27v
 uR9rkG3pv316lHOJFx7HFD2yOwhKub/9NmzSYwr3L8QW9dRBv0Ufe
X-Gm-Gg: ASbGncvX9UAIcMs9lnL5SJysawj+c9PY//Fwb60/wlr76bWwPAh1es0NWoq14cMImsX
 w38kZx8XGKyJvUuRcdv4jqbcg38jpYUGj2i8jjqTS5jEBPwEcBGSdvJmHg4vtZeU7/TIsc3pYvm
 q8sdxCJLh3pf4xjaCBpHeQ1TSlXBmSyxYc6LMc7fU0A5KrvPiXtEylFZJb5dgkmA5mPqulAevrW
 qDOr0MG/ppqNZ6tozfuV2o8po3FvwBeocy8pGLuWbdryxn1TnVUhgRbeh6Jz+o3by2QH0P4fzE7
 sXy5UUhoDWc=
X-Received: by 2002:a05:6e02:178b:b0:3a7:7558:a6ea with SMTP id
 e9e14a558f8ab-3a7f9a3bb35mr87292115ab.10.1733345977538; 
 Wed, 04 Dec 2024 12:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUZQLhH5wNJVEmOE5gfrk9u3MlVjJveLBVSmbBhWx6eU30lN7WTgjMFsZdttiO+xp+BVIGUQ==
X-Received: by 2002:a05:6e02:178b:b0:3a7:7558:a6ea with SMTP id
 e9e14a558f8ab-3a7f9a3bb35mr87291945ab.10.1733345977201; 
 Wed, 04 Dec 2024 12:59:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808da27fcsm131155ab.19.2024.12.04.12.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:59:36 -0800 (PST)
Date: Wed, 4 Dec 2024 15:59:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1DCtkR-bmJlQLd9@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com> <87ikrzi3m6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikrzi3m6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Wed, Dec 04, 2024 at 05:40:17PM -0300, Fabiano Rosas wrote:
> To be clear, I'm not arguing against cancel. I'm just pointing out that
> it's silly because it's just like pressing C-c in the shell in the
> middle of something. What's the expected end state? Completely
> unspecified. I don't find it at all "elegant" that we treat cancel like
> error and just let the code carry on stumbling and exit
> eventually. Because then we have this C-c arriving at random moments in
> the middle of stuff. The way we do "exiting" in multifd is way more
> maintainable. If that flag is set, then let's exit, otherwise everything
> should work.

If taking the example of C-c, then "migration during postcopy" is exactly
"TASK_UNINTERRUPTIBLE".. :) IOW, "hanging death" the C-c is the correct and
expected behavior for UNINTERRUPTIBLE tasks.

[...]

> > 'yank' is intended to be forceful, letting you get out of bad situations
> > that would otherwise require you to kill the entire QEMU process, but
> > still with possible associated risk data loss to the QEMU backends.
> 
> For migration specifically I don't see much difference. Yank must leave
> QEMU in a usable state enough for a second migration to succeed,
> otherwise it's useless.

Side note: when I said (in the other reply) that we should remove yank
support on migration, I meant, we should probably deprecate that (and then
remove it).

-- 
Peter Xu


