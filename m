Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4414EFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHG0y-0006lk-Tm; Mon, 27 Apr 2026 03:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHG0s-0006lB-15
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHG0n-0000E3-Vx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777273447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMkgB/SzlqC3Xn2F+fuxHgKBv3obhjc1et7lXHOBh+g=;
 b=Ls66EjjWJCSc/b8w31Ia1WCG1WwkgEN7B/2h8RrrONvBlOp2pJqa+sranIFSLVuCCpjT05
 30yRV1A+FFNK2HTWuqg7BxoeOlK8/HwaDT5RIG5QC9dv8UZy+NsuNRq/g7lE2CwboPL0t/
 l/2ZYN5a/N5W+5Wj8S1K/rAKPbewQ+A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-PtzZVlW7Mi6tri5DWQG09g-1; Mon, 27 Apr 2026 03:04:06 -0400
X-MC-Unique: PtzZVlW7Mi6tri5DWQG09g-1
X-Mimecast-MFC-AGG-ID: PtzZVlW7Mi6tri5DWQG09g_1777273445
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-440d12a472eso7006789f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777273445; x=1777878245; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UMkgB/SzlqC3Xn2F+fuxHgKBv3obhjc1et7lXHOBh+g=;
 b=Fl/br3FAMD2Zrrle5iXxlQw2p8delyRA+h7QuCQXFsJvL/mzj2y1lq1sI6YCLtKcmH
 iyIaFdVw+qQvMFd4Cxxi4ebaP0sGHwWXSerTVaM+ug9UHc9vUqe8BJd1yaLc352bgLFk
 xQHMMYBsIAW7O3P2PXaB5W2/MYOZKI8JxoAGqcUJ4ldwohp/HRncwtfq+XfLlPRfFvOH
 loy1VO4HLs75KDjtMk2tiqXhjz/SiML32Z5YAbzhroC9B0NTvEa6THip2Tsy/VfNJdno
 4StgrW/MWc8fhoV1r373pmpeHpiFONrHXBoKUv3uQdtPwjPs40IJd8KchvRS/SEgjuaZ
 R6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777273445; x=1777878245;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMkgB/SzlqC3Xn2F+fuxHgKBv3obhjc1et7lXHOBh+g=;
 b=Ks2VktWgpu2PXox4Loxw7/C/t2IfQczvhHM9/uENBrA7eRj8Te7nfNrhdRVRcOYg5F
 UQAuTvxAGp/lCus9Ax0zOYMJ3MMZCWfEmRCv4WlIg04WYAL6fDGhDxYeK5KD9ximggHX
 Z9cQByOrv18xKELwx0GjGBzHuAbVolhLQEnyNPzR3STIF1Fbp74NgbbeKg8n6ZAGmeAo
 Qj/4lSkdSKsQRpGxpBnK0wSANy4TwG9NUClFn+k2Cnx/AOMYG/R8rrGv6wqqQBHw5wQc
 5fY3F3hP/VRol37GCa7vMFo1dz25zH7I/xE0fxegREvA39Ylz3J/IDz+TPAdOetbrPaW
 O/qw==
X-Gm-Message-State: AOJu0YwsGzcFRalTpKamWpzG9ouAxoxWzFYB5qbIDyPLx1U7Ur5XB/UB
 8PmHyim2CVqVfvtB6HKZJYjYCEU3GApRY5ZTU4KWJdloAx9IzDsDBT+zaYaYITlH60rsC3r4Kji
 Q3JrsrenkKIFHPn9ZvOKDpQ393I1db7USt2eqbYqP4wSxb5LV/WFW7Kk3
X-Gm-Gg: AeBDietROYktIBNqeptmp7FxvQB5SRskjDyYNB92Nb8Chi0HF/s8ghmB5wEN2697f1+
 tIk9nsMPT7xiUOutzoLcq6MsBdmF21XN4w+29lu1MdXtfwr3M9Dw0ZmlijIJlx/NW0UcPK7Ba0G
 BkNz9fifT/kU4ioA+LLw0ztnkQbh3M7/9tc0GGmqsBnNbLjJ3rdUE9QeM07jqpuO138hxbfLwYm
 SV93pbu55EnhwXx0X6BuBZLY7Oaa0pxPVVtfUKs+wkmVhXCi/ZU6sRJMlyF5urrR+izkShLEu9a
 Zd99eWPYn8qufWnLOkOD7YsAjoXy6rGVzWMeJzgqn/VOyCbqHgvWnNbnC9mH7qRR+AaVtphSYNS
 hnRgbADZJXBparG8/9k9cn+DJ5H9nAHM=
X-Received: by 2002:a05:600c:4fd2:b0:488:e192:6fbd with SMTP id
 5b1f17b1804b1-488fb790869mr579594085e9.30.1777273444951; 
 Mon, 27 Apr 2026 00:04:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd2:b0:488:e192:6fbd with SMTP id
 5b1f17b1804b1-488fb790869mr579593505e9.30.1777273444351; 
 Mon, 27 Apr 2026 00:04:04 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm82388720f8f.25.2026.04.27.00.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:04:03 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:04:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/17] monitor: turn QMP and HMP into QOM objects
Message-ID: <ae8KYGqPRV_eZ8jL@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <87lde8lxky.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lde8lxky.fsf@pond.sub.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 08:35:41AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Conceptually -object and object_add/object_del should be sufficient
> > for essentially all QEMU configuration....if only we ported all our
> > internal custom backends/devices/etc to QOM. That is of course a big
> > job which is why it hasn't happened.
> 
> In addition, we'd need a more unified object life cycle.  See "Problem
> 5: QOM lacks a clear life cycle" in
> 
>     Subject: Dynamic & heterogeneous machines, initial configuration: problems
>     Date: Wed, 31 Jan 2024 21:14:21 +0100
>     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> > This series started with the premise that the monitor is one of the
> > easier areas to convert since we have no more than three classes,
> > a common base, and QMP and HMP subclasses. So why not give it a go
> > and thus unlock the ability to dynamically create/delete monitors
> > in QMP/HMP.
> 
> Makes sense.
> 
> > This series does the conversion in as many small steps as I could
> > achieve. At the end it is possible to create HMP and QMP monitors
> > with -object and object_add.
> 
> I'll try to squeeze in review.

Don't review this v1 yet. I've got a v2 I'm finishing off to send
real soon.


