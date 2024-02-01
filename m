Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5683AC47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 02:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVNFw-0008CC-Vg; Wed, 31 Jan 2024 21:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVNFt-0008Bw-Rk
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 21:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVNFs-00082A-Cn
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 21:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706756203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jKi8/XIw9hAyaHEYNFNIVgGNgyrD8Np/zamw5fJ8Ru8=;
 b=ht3q/sxnLFeJSmruhtDnZX++HOigKRbzQwxauHtuUljk0SNwUilDSE8TjsUPjHk2MDwPxe
 6sapsn+FD1+k+NW9cFIIotJXlQdZ3UcSjFkKhqsnajqSlIudHgQuMeLAhHXxOe9IldG0To
 68D25T9UBj/K5DjKsRYTv92V51xGT/I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-8LtXEkmZNcmecsDfoir_fQ-1; Wed, 31 Jan 2024 21:56:40 -0500
X-MC-Unique: 8LtXEkmZNcmecsDfoir_fQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6dde498715fso58205b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 18:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706756199; x=1707360999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKi8/XIw9hAyaHEYNFNIVgGNgyrD8Np/zamw5fJ8Ru8=;
 b=fSW+KOmA824whBr8Z/czmKlXFazcszn5Jr0mLuo+iXuSt6solEK5dTS7M7t5W7ZkEG
 Rd+1uyTby8D9JBc+bhTmaY8p2XtiX0vGf2pjGlHxM4D3TgeFL7mIPJrv8WLNjei8jINn
 M3YU3aVO8kemfCEC+mj0OrhB2IOBGmHuYWjDAAWB2myN+tZSnFjjXSAFb8N+WKmf3SOO
 HbI0Ksk1Gufl2tZsy9/o2Dwqgzfhqpf4Z1rqZtimVtzQ8Ru4qjr87a1Wc0iquf7I1a7y
 v1qDb3TjBR50KOkttSYgQDQ/SE62GbjqhAO1zelZ1DeK+Ep1Bj10zHiP6Yn3bMvC1vc+
 Z5HQ==
X-Gm-Message-State: AOJu0Yy7wDvlgVwD4F9Na/5lxtr30SRKzuBIBop860ddiSvI/DGM2mmD
 Gxdd/4iYrpNjeY1zP3gPY3z++6IyxREZKb0v9RdYCW2ni64tjrr21Bw2HrLjkacuB4EzzHOWUCT
 9c0h++gsOTaZMzUjV8kF4TDRK2s4GCjfvt0TK6K3sYQ8tyB+kijekGS3TOl/tCRM=
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3390:4a42 with SMTP id
 v12-20020a056a207d8c00b0019e33904a42mr1414306pzj.3.1706756199611; 
 Wed, 31 Jan 2024 18:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUprg4ub1ydaklmz0bCu9z9Mxn9V7xJ+/hJ+Mwm7hjJlqKFJ2foP2G3+nNfrrSvnEAouKg2w==
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3390:4a42 with SMTP id
 v12-20020a056a207d8c00b0019e33904a42mr1414299pzj.3.1706756199260; 
 Wed, 31 Jan 2024 18:56:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXiON8FoJqDOAB/0mUlmyiUp5MQamwjOizdOfkVr0wH9CKbhRGpNrEHqMwve0Vj0WSei68nVuMQ1vCCcuotuUdps1Lbn88TsoE6NgMZXGfM4heMpz1Ik+YhURptlOh/7g==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o18-20020a17090323d200b001d8cb103327sm7205999plh.215.2024.01.31.18.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 18:56:38 -0800 (PST)
Date: Thu, 1 Feb 2024 10:56:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZbsIYKJ5fYG6zsVi@x1n>
References: <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n>
 <87sf2ge3qu.fsf@suse.de> <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de>
 <ZbnG3qkMBPdsQxan@x1n> <878r45lkeb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r45lkeb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 10:09:16AM -0300, Fabiano Rosas wrote:
> If we ask for KVM and it falls back to TCG, we need a cpu that supports
> both. We don't have that. I've put some command-line combinations at the
> end of the email[1], take a look.

Thanks a lot, Fabiano.  I think I have a better picture now.

Now the question is whether it'll be worthwhile we (migration) explicitly
provide code to workaround such issue in qtest, or we wait for ARM side
until we have a processor that can be both stable and support KVM+TCG.

I actually personally prefer to wait - it's not too bad after all, because
it only affects the new "n-1" migration test.  Most of the migration
functionality will still be covered there in CI for ARM.

Meanwhile, AFAIU we do have a plan upstream to have a stable aarch64 cpu
model sooner or later that at least support KVM.  If that will also be able
to support TCG then goal achieved.  Or vice versa, if we would be able to
add KVM support to some stable TCG-only cores (like neoverse-n1).

Do we have a plan in this area?  Copy both Peter & Eric.

If we can have that in 9.0 then that'll be perfect; we can already start to
switch migration tests to use the cpu model.

As of now, maybe we can (1) fix the gic-version in migration-test.c to be
stable; this seems a separate issue just to get prepared when a new model
comes, then (2) document above decision in migration-compat-aarch64 test in
.gitlab-ci.d/, if we can reach consensus.  Then we only rely on x86 for
"n-1" migration tests until later.

-- 
Peter Xu


