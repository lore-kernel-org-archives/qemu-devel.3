Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88E6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjYq-0003it-Lo; Wed, 20 May 2026 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjYn-0003iX-CF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjYl-0004yy-Ur
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779293655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z7hXYWMN20iHkLQicubev7MLYbxw6IRsf+fl4DzA3fY=;
 b=R+dzwep2/mUJTiNeDNS7yW8w3pGlUxp9pPNL4srOmD1GrqPr6io1T3kgzKzUeYEkVnaXLf
 mkAnoQds+IvuLiUbCfzpSM3Bc5GeR3ZLpG1GgY3Hoo/s0shhB441+mKka2ZDcjQru7GuVd
 FMdAEjMHHs/kCJgcod3E2ZzwWPjSUG4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-T3C97fTBNl66rcVFY9MSWg-1; Wed, 20 May 2026 12:14:10 -0400
X-MC-Unique: T3C97fTBNl66rcVFY9MSWg-1
X-Mimecast-MFC-AGG-ID: T3C97fTBNl66rcVFY9MSWg_1779293650
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cc616cd846so6550376d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779293650; x=1779898450; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7hXYWMN20iHkLQicubev7MLYbxw6IRsf+fl4DzA3fY=;
 b=a0SuNXYNkbX2FBNlN+tyL5kv0egmpn1IRrkKlUg9LL6uHipmlOkfjUqTdWUlMjb1Yp
 KhhwkE0D2/aaSrRkesy94uv02RzABjY6kDYp7qvGys001TsXbTclN0xvTUldWlOi3CBU
 rCaxX5ZQ/8RfKZRzBwxvrO3J+MJK30kWud2pko7p/HoIemNluM62omg+PfM59jtg1Qy1
 43ZyO2vR1cjN8drJcYZpqp3hoLB7TtiETx+9/Z00ooyZYxiiKicLJ8ETpI7ZHbcPkGcK
 IHvFQp1oF4ombVmRvfU5DwAvhdDKzHD/XA25m1kR3hIoF2xYohGFbSv61yQcZW02ut81
 v87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293650; x=1779898450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7hXYWMN20iHkLQicubev7MLYbxw6IRsf+fl4DzA3fY=;
 b=mokSrX7TziXxCpNX2NI3+9XO8D/RsTZRt05bWKVxB1oOjjVQ0l83o/twLuHT4pZXAG
 8paB7NMkMqO83ZO7EPuk1s78BzYPneuoJ2R6e74k+YomFEx7M7BrG311DuWl+3DGZdYY
 kVJMq5qFzREMomXfv+X8P+gU41D6Yfnz/ZAQWPp+I6McPK5Gb/wJCx0PXmyWc7R+fAfP
 bR2XZdHFzVwwr4B6XBkVkLg6qTX8Y7NHW4pGcsayw5dgS3rfKKWrV8LmPuEpO6g0+hXo
 3cBfvRu08k0Vx1Uldn9aUQlKXbdrZeeinbhprLXojXQhFT548H9YFLh6ExuaV1gvqgdf
 WI0A==
X-Gm-Message-State: AOJu0YwG32N+KK6OzvsfuDP7Ua1ztbrLkLftk4LrdBDSMZcY82fpCSxL
 oUUEyye1IkIlQF4/1KLG5wJQi9L/r/RqB7A/vTn2ayX/YoDbd2Q6I6YjKH2bHs+YcfMoZdFNrH4
 O0UvbcTlIlD/uYRTiygCAzJSW5t5puQfVzFRfcdxUpK4M81aQMfP1nJwG
X-Gm-Gg: Acq92OFMJ5Z6snzq6p9kuTsgwBWm72OeKcyEYrlnjU/ecoHq5rEpeD6vwOlPTJKhaog
 A0j0pGgtSAHO/NkvgwFeBzxDtq/J3na5WGbeTq6KmA0UjdNCK4+4JQa/1noIUhHQML61a704Gzt
 7FAnPoeYzaJLG/iM1tsSZYswJh9cMVjUY90M3EYxsIaVu2hDovToTOz3GPQ8EhXgCEzKUjON222
 25wNKR+7V+dsVZF7ItZ+mfAInQOZ+4QHd73ScuSCo+bhBl2Msb6qTDHsvL0gdUGrY6kx7J7wiaY
 pKvGFVkXbwcGeUk4PD7+Jv3zZUNB+kst7vLubbrt1ZodxOsB/V34zx716X5nPZ7v7D1v3Iwsy85
 E5htDc7mnFl2YIUcQMjPYkDFtkLK7iQC0wkXTsUd8rmLpyYPC5rmozMsMAA==
X-Received: by 2002:a05:620a:2683:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-911cf9e1f06mr3603906385a.36.1779293649578; 
 Wed, 20 May 2026 09:14:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2683:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-911cf9e1f06mr3603901085a.36.1779293649010; 
 Wed, 20 May 2026 09:14:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83b0f9sm2213612185a.29.2026.05.20.09.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:14:08 -0700 (PDT)
Date: Wed, 20 May 2026 12:14:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 07/15] tests/qtest/migration: Defer by default in
 precopy_common
Message-ID: <ag3dz3w09L3zfGL0@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 01:09:06PM -0300, Fabiano Rosas wrote:
> As a design direction, we're restricting the usage of the command line
> option -incoming <URI>. The alternative -incoming defer should be used
> instead.
> 
> Make all precopy_common tests defer by default.
> 
> Using the defer option means that QEMU will not start the incoming
> migration automatically. Add the incoming QMP command. With the added
> command, the invocation at the multifd_common hook becomes redundant,
> so remove it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


