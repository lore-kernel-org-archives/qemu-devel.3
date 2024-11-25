Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF15D59D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgAp-00005B-0g; Mon, 25 Nov 2024 15:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgAn-000053-Br
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgAl-0006La-Nh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732568345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtcLutWse9I9QK4GkH1tH2A8/WFcN2gFrae0kYZUmZs=;
 b=DKkJs7CVkXONJxoPtbJO4lpP0jmanXeQmeyOOWYvbK9Bg23gQ/1Jfe6k4DIM637NgcYbLd
 qev4VnAcrpYZktBiAR5PG8YeaahpB0TCp4E3ToYJRBm/sohLHEcXvo/jUsZW9nPqejYqbq
 Mi0tyBf8UiL0DNu4eFub5xYw2goimqs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-9V2yFGTgPDqLZP7PW_Y5Qg-1; Mon, 25 Nov 2024 15:59:03 -0500
X-MC-Unique: 9V2yFGTgPDqLZP7PW_Y5Qg-1
X-Mimecast-MFC-AGG-ID: 9V2yFGTgPDqLZP7PW_Y5Qg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841a54a6603so115883039f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 12:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732568343; x=1733173143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtcLutWse9I9QK4GkH1tH2A8/WFcN2gFrae0kYZUmZs=;
 b=RidEIIF8FVMWAXLsFR+WM8e9fgBMXpNIm7sz1R1P8+cHkJBeSMupkQ4mK/HtmZpBr/
 E3SB3lN5lp5tu8n/MwiCUzrx5w4UCGnEuWqKYVlNl3LzpIP9i0eNBQn+D8iyzUBgvmHQ
 UgylC0pjZjD157Wfie6fZhfJPAohLAk5DCl9uDsHhSfK1xtogw+noAIv3JyRS3O7Cn8o
 koqChgJV6DnqvU88rARJ4AUK8qbDnJ2XE399IVa++htGOGKZSo86lqFA9bNfQJTJNVrh
 Y5H1HxqEyqazRtFcDBQ0JMyWUrMjNZEG+ObmfjqUHjk3ZAHlGUq3TeJQjyaWw22QIqit
 fDJA==
X-Gm-Message-State: AOJu0Yzol7vXpZRiK7Xsr4aT3AmHDetzL2x4KiWZ1Bimg6MGs597JcaK
 orAOGg97y3HxgIRLrRcUIiiCPKd8TjZK8Pu4gn8ep21tbd5BKTEakUeaFyCPF8cvopCsQT6+Ajk
 swFoilCzEiWHPmsp9W2qhFELjV4A3JkR+h2vusYW0Bh4hCTmUPomj
X-Gm-Gg: ASbGnctWoeBgDRntwkAxa4WbQikdo4GxACLs+3SWXeMFpBKhqQMk+mD0iuSy0H6tUBs
 VrZNzzGpstDlrpZ/jzCLaUZqr83Ur0Ux4yAIMtQ40E6JH51AWV3br4X5e+gxc47WqUBPK3ZpdUW
 nrvFujM8qAqgwFRXhub6aNYM0E7Ht+iIJcceyI0IDpvc3JyuaTMeNjgn31fC+oxjP03Fuv2J/lV
 pMKP/KPLKPYp42R08to/cA2RDUeizWkFP+vO3IzbpOI3YnSoI29wlQWumVGh7sXWpvQfrDjabzj
 GUQuSE2l+EM=
X-Received: by 2002:a05:6602:6d02:b0:83a:b7a2:74e6 with SMTP id
 ca18e2360f4ac-83ecdb33633mr1581778439f.0.1732568343261; 
 Mon, 25 Nov 2024 12:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHBy8FOZSnqjKwaVKTXBirH2Q1AKg2HyLp/qpHuQ5rFaYXlGkQpqF8YYFt2G1I/K/gXAqrWw==
X-Received: by 2002:a05:6602:6d02:b0:83a:b7a2:74e6 with SMTP id
 ca18e2360f4ac-83ecdb33633mr1581777439f.0.1732568343003; 
 Mon, 25 Nov 2024 12:59:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26620539f.9.2024.11.25.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:59:02 -0800 (PST)
Date: Mon, 25 Nov 2024 15:58:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 00/22] tests/qtest: migration-test refactoring
Message-ID: <Z0TlE9PNsTR5CWKO@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Wed, Nov 13, 2024 at 04:46:08PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas (22):
>   tests/qtest/migration: Fix indentations
>   tests/qtest/migration: Standardize hook names
>   tests/qtest/migration: Stop calling everything "test"
>   tests/migration: Disambiguate guestperf vs. a-b
>   tests/qtest/migration: Move bootfile code to its own file
>   tests/qtest/migration: Move qmp helpers to a separate file
>   tests/qtest/migration: Rename migration-helpers.c
>   tests/qtest/migration: Move ufd_version_check to utils
>   tests/qtest/migration: Move kvm_dirty_ring_supported to utils
>   tests/qtest/migration: Isolate test initialization
>   tests/qtest/migration: Move common test code
>   tests/qtest/migration: Split TLS tests from migration-test.c
>   tests/qtest/migration: Split compression tests from migration-test.c
>   tests/qtest/migration: Split postcopy tests
>   tests/qtest/migration: Split file tests
>   tests/qtest/migration: Split precopy tests
>   tests/qtest/migration: Split CPR tests
>   tests/qtest/migration: Split validation tests + misc

I'm not sure whether the above chunk could affect people reading the last
four, which is the real meat.

One thing we could do (but you can decide which you prefer..) is you can
respin with the initial 18 patches, then we may get it in in the 1st 10.0
pull.  It may conflict with some other series for sure, but it's
unavoidable with such changes one way or another..  then when it's there we
could repost the last four separately, so it can have a higher chance of
getting some comments.  So I'll leave that to you to decide.

I also wonder whether we could already move migration-test*.c into
tests/qtest/migration/ too.

>   tests/qtest/migration: Add migration-test-smoke
>   tests/qtest/migration: Pick smoke tests
>   tests/qtest: Add support for check-qtest-<subsystem>
>   docs: Add migration tests documentation

-- 
Peter Xu


