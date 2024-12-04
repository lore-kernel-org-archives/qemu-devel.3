Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C68E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 18:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuN0-0005GB-4r; Wed, 04 Dec 2024 13:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuMy-0005EF-6g
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:45:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuMw-0008AI-RD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733337901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOrtnZulh0GEYD1WppxtckLAjoFd+f5RTEN64bYQ6uE=;
 b=OeLEU4Rxpz1OQKLePA+dEQXIJHCjwzVcLuNKG6eUqCJzaKYwXoSCCaJNbZQcrlIdwK2U+K
 Lap3O2VFmABa2Tu4tnskbYq8hgeIudiqoSDVs3LQS9n55Gj7MsuCZ7j8lDTAqxfI3H7Jmt
 B3U8/ZvsFC+EUDB3yTvT3vi+EG+sgQs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-czENFcLNM_Kj-MhjWf8IfA-1; Wed, 04 Dec 2024 13:45:00 -0500
X-MC-Unique: czENFcLNM_Kj-MhjWf8IfA-1
X-Mimecast-MFC-AGG-ID: czENFcLNM_Kj-MhjWf8IfA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6773705c9so4848085a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 10:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337899; x=1733942699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOrtnZulh0GEYD1WppxtckLAjoFd+f5RTEN64bYQ6uE=;
 b=quTF0Eau/fbJLQFiatsLNdGeo1lJqh6BhnH3Yci5AXN7jlxDz+LpigE1icLiDGoAw5
 +SMwQtddraLC/EX22hlwDCSTDG8IHADoxc+iEpqwMWgSH70TRfDInv4/i3LqFibtXhSr
 lSrDgy33e97KZoa6oyhXlSu4MZVWRC8xnYSVhYnGoDKyH6PV16yfrxlIIM72iUdB6DN/
 NOYuS3DPnfBI+KyChno1tUe0EdrfJxHS7sw0ylfr662EnRFrCDkxN97OxgMFCJLy7flV
 bXjjcNYwHX7cfodK4/MOREzACm6GtYOmtpBcdNMo9jHYYutvU21jo7g0YukFz8ni2969
 B1/A==
X-Gm-Message-State: AOJu0Yz8RBCWVdDs/AXBrUwjNFf4ATxk709ACHpynFqGS3hTzxRqHrFg
 3+1SapNC4f0wNpN/WxI406pIMP5w12ZNXBH8o7qytLQ8OlzqxapNYVq3QF1hlJyvGVVfjiiCbJy
 wHaCp8ZbME0tp+cSoNYX9P4XdWE0r6s7Tgyx6TH2YV+f6Xym8FD1po2ptdaIP
X-Gm-Gg: ASbGncvRlfDmyyXL5IXrmFd/bJ92xjL9F1DRAswLBIVdqFcOuZHzjRWGW8zlsoxrCD7
 w17156zofFMZyYjfG374sC/BIJzQl41ImGml1msm3UVI/14jnDx7I4Sz0VOfvim9eS0o+pP5GMq
 nhW63kD2NU26ajo5LcGwXRcR7ZuFp7+zYwTv6ZzldUkwMR+JLXO8AhLu744UW+yi4gKGxcU1Kbc
 egw4rN9mASynvg+yEnyDxqLs+Vm64CuxsJOvdohPKnyDEaepS12871+f5gRHDfao6xUJRb6nP/Q
 oZ5+uA0ZAHA=
X-Received: by 2002:a05:620a:248a:b0:7b1:4579:80fc with SMTP id
 af79cd13be357-7b6a6210882mr974978385a.60.1733337899605; 
 Wed, 04 Dec 2024 10:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9q1fOS8611lg6ZcBAjDFAYN0K4CR9E1Yr5c5yVT4iAAhQFXC4jksnTmL6l08V4LMCLUAhrw==
X-Received: by 2002:a05:620a:248a:b0:7b1:4579:80fc with SMTP id
 af79cd13be357-7b6a6210882mr974975685a.60.1733337899349; 
 Wed, 04 Dec 2024 10:44:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849aaea1sm635765785a.75.2024.12.04.10.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:44:58 -0800 (PST)
Date: Wed, 4 Dec 2024 13:44:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 1/6] tests/qtest/migration: Introduce
 migration_test_add_suffix
Message-ID: <Z1CjKWlDcqtm4vU2@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202220137.32584-2-farosas@suse.de>
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

On Mon, Dec 02, 2024 at 07:01:32PM -0300, Fabiano Rosas wrote:
> Introduce a new migration_test_add_suffix to allow programmatic
> creation of tests based on a suffix. Pass the test name into the test
> so it can know which variant to run.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


