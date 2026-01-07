Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0F1CD5854
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRJI-0005Qv-S5; Wed, 07 Jan 2026 06:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRJ9-0005D1-8G
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRJ2-0004dL-PC
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767783738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciWNXoT4vcULZeQ1qcTLKQynEbhiZCtD+3PeRPcjlew=;
 b=STaauEomvL9UcCVO/5gXJeA0w6TXGm1B63ceM59zID0lKINVUkA/IjEjbYpn4ppwHRFveu
 TqAW8U9ndRHzITqPqFY+Cx3nH+eYg0bCzfwyyeiOtVLQy2XNNHbw7kd1cDGp6XeezmA5yB
 eDGzgVM4Bhi5p/PCAvHmM5QYZNRY4Ec=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-fVxVS8NqNWuZ9_2XdkISAg-1; Wed, 07 Jan 2026 06:02:15 -0500
X-MC-Unique: fVxVS8NqNWuZ9_2XdkISAg-1
X-Mimecast-MFC-AGG-ID: fVxVS8NqNWuZ9_2XdkISAg_1767783734
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso13182005e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767783734; x=1768388534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ciWNXoT4vcULZeQ1qcTLKQynEbhiZCtD+3PeRPcjlew=;
 b=mswVBdPN1gTD4FDjQ+dv5fAJPqYMjd/ohg7MbztYFr6gmNb1OkbzQTrgo//tFYLmkx
 qCXB0cL8phZc7WKL5rURq9bS5NPyAx1ZNX8w08qf90jNvrHhGvN8ox3wnGXWHB9NIhvD
 PCv8EH6GXdUtn3aTfXDKnTSIQ/rFAFxouXt+cCDuzm59EzPZ4QPGpQ7iVi5g7XF9EiiS
 Hdmq1SAWRrUVw76eQrMtczrgendv8O764v+LJcBVXWIM4Y1ceyUprxIKCjlZVGX/KrsR
 1c/q8vRcFwf4CCB0GHKkELwTGPMjxDSSAXk6BAExShaz3PllxKpiQynMphfESaFAplDR
 0zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767783734; x=1768388534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciWNXoT4vcULZeQ1qcTLKQynEbhiZCtD+3PeRPcjlew=;
 b=Iq41kjn3KHZR9B3e3yA91Y6WTz1vfkJf9lVLVdV0qDL1M7TKVRMrM7Iz8z5NSCRfLz
 JnvnimVabCnSza2CXOFQnsL0CQtMpKPNlF7U/vl9s+QsBI/kn3Uq1zuYyf/qLLNTWzLl
 RebVXFn1duYuf3Ia2b6adKPtlJ2/h3HhRJrR70sXqtsqPR1/0QfDK0ea1n9bGcnh3EdV
 k6BWvuzUO8kZpoWMItdeZVTH8esh+WbJgb40S3FQpe+97RNtiHhKrKszACMkmBpY9hjj
 4pPcjXveoVy2WF0KNyolwF26NudlLehrmQv7DQsACQIW1HcInOZ3OADideKsDzZLScXr
 g82w==
X-Gm-Message-State: AOJu0YyYX2B7UXnxaskCJ2iv1G3Yc9U63SfrSNWw0hpMZQA/uPB6ikU+
 8v9X4FLXS2981Wd7BfEu827ByaBnlrpQhyN6ufbZz20qc0nKMsHqnr5Qf8rjx6od0uzfNGnu2tY
 U0PcP/g81Px0GP6tjPKrxUAFtx+TXmWODmc+Obiyh9gycPJ8qXAdGXAYlt5haL7NMl4IKIpOajj
 BRj1AtPUTvoZR2RpPFVRausjpTY7L6UGA=
X-Gm-Gg: AY/fxX5QAT34vCO7HjD6m/LcolHSp+3b2XvYHB/tZIiuQxJDlaIo3RoVBBvjYItxEEM
 cepAHYZlT/U4R1d9XhLiXqhS1fZ6ZETpaOZp1iY6g9QEZ9wUS6YGu8IUjDV3qSygsDjGduh2mrn
 CiS6W8cSVvJBwoeGSSwLNLAWDOtOxvnjqVYkgiLm9ojQCuoo3nwUZ5wSH1/weOwXn2hHY=
X-Received: by 2002:a05:600c:c4a5:b0:477:1ae1:fa5d with SMTP id
 5b1f17b1804b1-47d84b32f5amr21366905e9.20.1767783733551; 
 Wed, 07 Jan 2026 03:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVxu7mpLwhOG6Eln94curikTMTPUka/lV2XINk9Sw4+347B2vCdVuYa9Tv1ro0S886neOr78nRRPDEPDZDDbg=
X-Received: by 2002:a05:600c:c4a5:b0:477:1ae1:fa5d with SMTP id
 5b1f17b1804b1-47d84b32f5amr21366525e9.20.1767783733156; Wed, 07 Jan 2026
 03:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local>
 <CAE8KmOwnPYoK0i53LB8nO95gC53QK4FoNvMrbb9anR3OB+RS4Q@mail.gmail.com>
 <aV0o-EYEC-4rvdSz@x1.local>
In-Reply-To: <aV0o-EYEC-4rvdSz@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 7 Jan 2026 16:31:54 +0530
X-Gm-Features: AQt7F2qkF4yQYGiKPQ5I4MnicvaGX1az14pe_PwmdoHcSXyP2N6JOjsBCsZdqUA
Message-ID: <CAE8KmOyh+vku1bnbHfmmek9Uru7AaF-mc0q34807SE+_r5QT3w@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 6 Jan 2026 at 20:53, Peter Xu <peterx@redhat.com> wrote:
> Yes, something like this would be more than welcomed, thanks.  You can
> provide a simplified version in the commit log when repost.

* Okay.

> Note that I'm not reading carefully into each of them, because we have
> concurrent changes from Fabiano recently, essentially it'll change when
> migration_cleanup() will be used in above examples:
>
> https://lore.kernel.org/r/20260105190644.14072-12-farosas@suse.de
>
> So we'll need to be careful landing these two changes.
> Considering that the other series was close to landing, IMHO it might be
> good idea to have your patch (when reposted) based on that series.  Please
> have a look.

* Yes, I see it is changing the same code areas. I'll wait for
Fabiano's series to merge upstream. Will it happen this week? @Fabiano
Rosas?

> I still think FAILING isn't such a huge change so it needs to be split into
> multiple patches.  It's a new status and we need to review every spot of
> FAILED status change, in which case one patch is very well self contained.
>
> Even in a backport I think we should backport all relevant changes about
> FAILING when necessary.  We should not backport part of it, causing FAILING
> status to behave different over different paths.

* Adding a new interim state to the .json file is not going to break
anything. But other places where we start using it via a bulk change
might break things we don't know. So far we've only tested it in a
live migration use case. We have not run snapshots
(bg_migration_iteration()) OR the same host migration use case.
Hopefully it might work fine there, without any breakages.

Thank you.
---
  - Prasad


