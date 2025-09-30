Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97365CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bs3-0006J9-Mf; Tue, 30 Sep 2025 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3brz-0006Io-Py
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3brr-0005lq-EG
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759244526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0U5UppV6f2aSO0jFJRrxKtR3kI0t22R8/MTw8s+100=;
 b=YPGBxc4ON4hNX/ac/K3u0WLOXVu9I0UwgTmySUoTvoV939P7ZEHqc7pjf3FOGOAxWDkNWV
 ujjknQtIRS7JcN/lm6IXbv+6VOI0RdFT5pExgpYOFvI1ZRo0AAjfCWMfLO47ObJyB2bW8S
 0+uqpPpN7npZV/THcQ6o0E1GWaXoPM0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-pYHLwEyWMZaUQo5WtbYV5g-1; Tue, 30 Sep 2025 11:02:05 -0400
X-MC-Unique: pYHLwEyWMZaUQo5WtbYV5g-1
X-Mimecast-MFC-AGG-ID: pYHLwEyWMZaUQo5WtbYV5g_1759244524
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-859b89cd3f2so1313047585a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 08:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244524; x=1759849324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0U5UppV6f2aSO0jFJRrxKtR3kI0t22R8/MTw8s+100=;
 b=lddHyyYpqXiz6LTnXwAU48ZEikoG4FOospL90epqSIthYLjiRVHh8kNTdlDAYmtVmx
 XnOttuVmKcDI/5uDcGRzI3gOMGHvu++3+E3RQsbAgwCNmIKgHJ4GGxT3kN10LSmu1ooy
 l0gx/VqOeNodb7X8wYv5mH6gEViZwwT1K2ONmccIWCS5hkzP/s8NPI4egDj5UN5QNha5
 mljDaffzKiIE6YHbAH+EqnWUgFKyPfWnHb+6nlBNmv5c0TDkyGzf2gq1+o8Jl64oTqoU
 wajFtKepMxU+ajXndK/PMXigzuOe+a7WEza9bq4yqXQLGtmwdWkHdI/vf/qFesfFDdFM
 PJ9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUspiHbT5sOM3QPHkZgwyvVB0mIoqH3J+FHzK+SF1gWW+253KL2gn617ngRVvgYm6OpONlGQy8e5Te6@nongnu.org
X-Gm-Message-State: AOJu0Yx7hIwHWWIAomGs2t37SDgAgKxYoUyOYtvvFfoNIHQgFC2awq+N
 ESZm7EyDE7DNSOBX3dm+ChZ2Ib0plOZSLyRLMt/Ojt8oOhCIZbuCbf/n/WzetdJUwglG1rN9PW+
 OtzuN5seBbs2ee9xDedj6skIbkZwg2wEQvx2f5E5GjF06rtNzkcXMYJ6S
X-Gm-Gg: ASbGnctLp+WLwWI7jTtVd8YmwQN260tj4rYRjsqkZZP8RLUfPfYeTM8Ce1UDb+JGLcP
 QEdi9XggNxAWcmZcmYgoMdOmLVFgYkDyzU2216DXtiy3CXsfpqklJnEzJLKsujUubKDSyzFOoZC
 ReHn+orfDpWVbQIvbDycdg/FT8YKtbLcRDdZLsIbRwEK2RSHNwwgplsYg/agers7lGG/BSzdah1
 xAV4AO/9pUbgX1qkuy0HLWIN/CTKz7n27K0tkJwlI9ToWz5r/+MW+nTrpGB7VuM9n2O0d+rODCe
 CJDocBQxwtH8EqGypP+mbQJSec1qtkqoIX5KMw==
X-Received: by 2002:a05:620a:3950:b0:849:27b:fafa with SMTP id
 af79cd13be357-87371639b8amr9289285a.24.1759244524384; 
 Tue, 30 Sep 2025 08:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX4Fac23mDAag+YT30plMtwAX/CAl25w/CBNZ1MwIdw5Aem9RwhkLVeRY5EHRaUj7olwVHVg==
X-Received: by 2002:a05:620a:3950:b0:849:27b:fafa with SMTP id
 af79cd13be357-87371639b8amr9267885a.24.1759244522212; 
 Tue, 30 Sep 2025 08:02:02 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28a89bd4sm1067948885a.19.2025.09.30.08.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:02:01 -0700 (PDT)
Date: Tue, 30 Sep 2025 11:02:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] tests/qtest/migration: Fix cpr-tests in case the machine
 is not available
Message-ID: <aNvw6Kab4q02sqP5@x1.local>
References: <20250930090932.235151-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930090932.235151-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 30, 2025 at 11:09:32AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When QEMU has been compiled with "--without-default-devices", the
> migration cpr-tests are currently failing since the first test leaves
> a socket file behind that avoids that the second test can be initialized
> correctly. Make sure that we delete the socket file in case that the
> migrate_start() failed due to the missing machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

queued, thanks.

-- 
Peter Xu


