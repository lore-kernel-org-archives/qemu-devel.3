Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE874D58D71
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcu0-0004fi-F3; Mon, 25 Nov 2024 12:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFctx-0004ex-Kj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFctw-0005nb-AJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732555771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SERqubPw6ULTSpLkjIr5ajg0vv301kyVivbXw2DRHzo=;
 b=gTRiIuP9giilwWTwpMLP+lPmvPKj2kIlgpuINRObWfCLwDUxrRGckuhHxsNtZRdp3mrlhw
 8eQAPBNpYzLbepPdbzLWQOf65Oz3QhOA51PmT3lDkScZzoGb8E6GEbp84fvGULaeHX1h9G
 fMmeLlg3fWWhbxpjA0yLTSkB8CgU4zU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-vxteu4wZO-qeDbqyXKpKXA-1; Mon, 25 Nov 2024 12:29:30 -0500
X-MC-Unique: vxteu4wZO-qeDbqyXKpKXA-1
X-Mimecast-MFC-AGG-ID: vxteu4wZO-qeDbqyXKpKXA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841a4a82311so84316239f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555769; x=1733160569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SERqubPw6ULTSpLkjIr5ajg0vv301kyVivbXw2DRHzo=;
 b=wFqjjzg+AsaUHWVEkzmDZREJUI5J7is3llRbCXOKX6YNzSf1So7OyUP7ROEf3dDm5V
 OLlREbn/SX4gZciJVoGw/+n1TW5TVh6c6lRnRtDzsm9gd7RwkaSgnQLtppL+VLjn0X1u
 swQynZe8kFTf7EelnYI/tbypS+EQIa4AkrGmT24S3r/GXHT5XFHJvDKzVjtGcOZ6yRjY
 8dl+hNjX0jFBrlQb7i05K4iugh4/unyBS6HVKKuXd5Qa3nTy0Yqk3kpmbinWYNpINeTL
 ZZAqrA2MWfoqyBVb0uEcpLeGdMAoyjvi8iOnJR1fQ761je8vbclh5wA0hbbdNkynHV3G
 9ISg==
X-Gm-Message-State: AOJu0Yz6gv6S/9p1XM6M0BcKOy/NkcCWOCrKzKO7Y0zXSo9aIcett0ve
 4nO0id307dvANSJAxDvLEUIPlLPlYb6TqJmUNxAdr3nzmDmB/w4bKVFhvJNY7yXMa8EYFbP+B8y
 VXlfaaTdMg7bXtTjAHEOlPIyL/XVCVjq8p3WrXXP6+kEmVHXeSjW89Uc7sgie
X-Gm-Gg: ASbGncvrfL051WTgTYZKX6xE4uEJKkt+a+fVVOiaNIZEJUrdw4r/NT92lgsUm1tMN+U
 JwX1elayyXZFv8+Gw786ThY+NZtKHcNYy23zhbeeA4lsxesCzXolTlQtgww/KFCTpSGWm/9K6jh
 6RBV4pQuujhRQmCLva3S+xMOajAzI/GWzPTMaSVxUN0yAV7/fpjQcIZnrceCsLyukBHdgYpNHAS
 rzEePH95OagZA9wc8qMIAH31E8/lwZj8/bSSOcHnivQXt3OnQQgb3o2RUqdCoDRuhOw8sSbaqCA
 98B0Ojyl+uk=
X-Received: by 2002:a05:6602:14d3:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-83ecdc671e1mr1479578139f.5.1732555769731; 
 Mon, 25 Nov 2024 09:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM3tj3rh7HSKPNMUh5Zb9k1TuDi1hh3oT25XxMycAvZ5O1pNP+EJ/Q75wC5tCbH/OWDC7Vgw==
X-Received: by 2002:a05:6602:14d3:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-83ecdc671e1mr1479575839f.5.1732555769407; 
 Mon, 25 Nov 2024 09:29:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8419a5eb3c9sm49571639f.24.2024.11.25.09.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:29:28 -0800 (PST)
Date: Mon, 25 Nov 2024 12:29:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 10/22] tests/qtest/migration: Isolate test
 initialization
Message-ID: <Z0Sz9qQJPkwwKJiv@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-11-farosas@suse.de>
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

On Wed, Nov 13, 2024 at 04:46:18PM -0300, Fabiano Rosas wrote:
> We currently have some environment validation to perform and flags to
> set during the initialization of the tests. To be able to add more
> migration test binaries, we'll need these tasks to be in their own
> function so they can be called from more than one place.
> 
> Move the initialization code to a function and introduce the
> MigrationTestEnv structure to hold the flags that are accessed during
> test registration.
> 
> Make the env object static to avoid have to change all the code to
> pass it around. Similarly with the tmpfs variable, which is used
> extensively.
> 
> Note: I'm keeping the new functions in migration-test.c because they
> are going to be moved in the next patch to the correct place.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


