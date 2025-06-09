Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A6C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfh3-0006jP-V5; Mon, 09 Jun 2025 12:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfge-0006i3-QX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfgc-0004VU-DR
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749487764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qIiWTVzNmtq+0HKuzwbMGWs2G2nAd8hdK2q9yH4iPA=;
 b=U1nEvbqaKWWTpmnWQFi/7pVvYCr1MG9lFgHlHKeTlmmvM+M+iQTX4LOOal0zR79xMqofm3
 hyXNv7cx3BvVTp2LLo53YC4oun6NMzyaooDK3JODxdTa3I1WBjPYEAghwalUt+ORg/fs5d
 3BR23J8ETvLrFWjZV1N4dfz22ga/LKw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-vM9SiFBbN9Wn0auk2VLErQ-1; Mon, 09 Jun 2025 12:49:23 -0400
X-MC-Unique: vM9SiFBbN9Wn0auk2VLErQ-1
X-Mimecast-MFC-AGG-ID: vM9SiFBbN9Wn0auk2VLErQ_1749487762
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5d608e703so896303685a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487762; x=1750092562;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qIiWTVzNmtq+0HKuzwbMGWs2G2nAd8hdK2q9yH4iPA=;
 b=wZHpoNiDyzyhqovhoSiO04jL9fHKWgbUWQEyxlXpscM4RymlTSfP6ZqJw1Vn4LmFLS
 pguTTsA8DXFja/sSWHBHpTGbbCSiswLzsCcBf0PJ26wy4TwAzF5Vb4dqNuTpqB8+Fs1I
 PRTYFJ4qDHTuq3rHl94QUlCZcktfABOPweEtTR3E7cHDsvKBEDBETcQIeeJYTVD3COKy
 U7vC8+GjUv66Ork6W+HfC6zQT4CG6cPek8TToqKkzHaQAbUT6bitGy5ccaK+85F1NVYb
 GCKKfQg6puQaH1D2Cm6FlYgmqpsec7lItThFdayoGBZCc2gcwBAVchF9bISpa5koVzES
 0BaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTlNaX5pxkFu9/bGCWH1irl6tDF04MLhYZ4tuyTrZRaSHoDsm8n6stnZ4Z9eVLs08vnwlbOKEXvY2D@nongnu.org
X-Gm-Message-State: AOJu0Yyl/bZc47kTpKozY5/Lt7oMJPSs5RW1qIzn1ILI5U34VZbd1fZn
 TbwhgWl4swW5mmSl5k4GRxG/YIDUVzCnnnA8JZEJGDO8diT3pGqnIZg44kHlVviZae12D7J0TJG
 Mo+b/x4VZes6tWTUOvGcr3wu0gwysAY0YSjbgELNCnyqTu0OtqS3rLHYI
X-Gm-Gg: ASbGncvvNiVFsDT3myYGahzDQCjKXGZDQ9y0yrm/rq1gVU/8eTjwkd9Yx2VJZwWu9ym
 mdTj4nc2rqWZoZK3dmTF7ph9LrABMBBhVT+gwCSQBY7ELJfogN4TBwoGtupKacAwsiipe4hprBI
 8ECWKo2xJWP+cHR+FPJpYlREuKKTHwUZQkcDUPOkLeXC6v6RD6XCqRlIohSJyTL46wLdFYFqqxv
 qTRj1PUPqHFKwT8CIgLQ+grI38zDm9xpvurWeg/AyRrvcQaIZt5PHBwtSgOnk+HbkUStk1UMfni
 vm83hgLgyeAGjw==
X-Received: by 2002:a05:620a:4447:b0:7ca:ca00:735 with SMTP id
 af79cd13be357-7d2298ec39fmr2052762685a.41.1749487762605; 
 Mon, 09 Jun 2025 09:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWsBwPHN9mQnL3yS+Fb2gTR9w1TXs3GIHzr1EfHplZNyQIaUob1jv5LSZ7lueP+t1i5z0vQ==
X-Received: by 2002:a05:620a:4447:b0:7ca:ca00:735 with SMTP id
 af79cd13be357-7d2298ec39fmr2052759285a.41.1749487762264; 
 Mon, 09 Jun 2025 09:49:22 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a59321asm563530185a.52.2025.06.09.09.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:49:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 12:49:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcQj_XLnnnS9FKv@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <87y0u1ugkx.fsf@suse.de>
 <aEcC9X5i6eV4N7An@x1.local> <aEcIDNpXJHGAhwmK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEcIDNpXJHGAhwmK@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

(I had a reply in the other thread, that might have covered most of the
 points but maybe not this one..)

On Mon, Jun 09, 2025 at 05:13:00PM +0100, Daniel P. Berrangé wrote:
> Even if only a single mgmt app is involved this is still beneficial
> because the migration infrastructure is used for distinct use cases
> inside QEMU - live migration, CPR, save/restore, and savevm/loadvm.

I assume CPR is save/restore, so indeed we have 3 ways to use migration
core.

> Any time code any one of those uses cases starts using a new parameter,
> apps have to make sure they don't inadvertantly have its effects apply
> to the other use cases.

AFAICT, that's not affected by "whether we allow global settings", that is
still a concern internally as long as they use migration core.

One thing to mention is CPR is really a fine citizen here, AFAICT it is
exactly live migration using all the proper caps/params.  We _could_ split
it as many things do not apply like postcopy, but we could still just reuse
everything and ignoring the rest.  It'll be again a cleaness issue to me,
and even if CPR reuses everything it looks still clean enough, especially
comparing to savevm/loadvm.

savevm/loadvm is another story.. however afaiu if we want to decouple it,
it should be done not from the interface level, but internally first.
E.g., we should allow taking parameters as a temp pointer passing to
migration core, so that will be passed over by savevm setting all caps off,
for example, ignoring the global config.  The interface alone should, IMHO,
be done only later.

Meanwhile, even if that, IMO we can't avoid the need to think any new param
affecting savevm, as long as it's still using migration core.  I don't know
whether we need to do that one step even further to decouple savevm: I
would think the other way round to obsolete savevm completely if necessary
when we have fine "file:" migrations now, especially with mapped-ram.

Thanks,

-- 
Peter Xu


