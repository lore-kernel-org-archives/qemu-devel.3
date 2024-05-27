Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47DEC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhe2-00044m-8l; Mon, 27 May 2024 17:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhdz-00044A-58
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhdw-0002rJ-Vq
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716844351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scH4Xy9bRVshxQLySLQElCdZNUAUQKLXlxjLv9amM10=;
 b=AVlvwcK2apiKi7mArbJ/Jq4IA5B5hHX8TCDvQndeCj5O+stMgam9e5jrVr7a3XaI12VumH
 zTFAbYXaJo+EF70HROSiNgnw1I/+YoiGWbeJ6fI8f2pT01fRKoj3SWI7UfEJzm7gmeUune
 1xTCh+umMfb7/xwjeQZZbpTGj5t8jDY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Jm7sCvXzMuKOlLllwGgsrQ-1; Mon, 27 May 2024 17:12:30 -0400
X-MC-Unique: Jm7sCvXzMuKOlLllwGgsrQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792ed3a15ceso135185a.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844349; x=1717449149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scH4Xy9bRVshxQLySLQElCdZNUAUQKLXlxjLv9amM10=;
 b=MKuV7rXwj+7RL6atyL3dnoiRHt35Zv6LOUFoSVtVa4vOFQ5sogWpyNZR5Zeckhd+AN
 qadjHmRUS8NanPZpcsZy/IHTnc2SzwjS4VF+0Zi/arsqcsYisFXAQmTwXWGTGaHuliDZ
 wlBLe5NxtvTgRvO1jlrdFTbmlkabSXC/ZxcfXxpk+7oGkdd9XfGA353Pnh97H2vCACjs
 wo0YUg/Ku9slL+WASnRcy9tsJ6+B2aduN/o8bLAbH6AMPO2QzozQytG17cDqDIcTbZys
 TQ3OJpXwEXiUnGiUpolLon0NvPqdrY8t6GkaQBVKHGnO45XGAXykvJKl2p7uU7bUV/7Q
 aLCg==
X-Gm-Message-State: AOJu0YzYJs6eDk+FSFzLAQk1BZUGzvYlGB7znBrhbuCi/72yaM6Kxqvs
 gpU1d/SnlLIoIBwscgx+UdYdPYHUcKYYi2nsvjsSBGhZU2Mr97Z5HPtwiVrlaIaN48SvHiU0Jrk
 leFNDHO0O0QkpJ1i4Lc6THA8WnL7LyXO6ERHISujkxRnSLmPbZeDh
X-Received: by 2002:a05:620a:410a:b0:794:c6a0:258a with SMTP id
 af79cd13be357-794c6a02ef6mr305193085a.4.1716844349136; 
 Mon, 27 May 2024 14:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb23n85XrX9tYz/6r5vQ4tid2hz3LaDYdXqAwwzdgzV5S67Snzn/X+1C6+/JM+V0dAf57lpQ==
X-Received: by 2002:a05:620a:410a:b0:794:c6a0:258a with SMTP id
 af79cd13be357-794c6a02ef6mr305189885a.4.1716844348304; 
 Mon, 27 May 2024 14:12:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcdbc69sm325871585a.68.2024.05.27.14.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:12:27 -0700 (PDT)
Date: Mon, 27 May 2024 17:12:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/4] tests/qtest/migration: Add support for simple
 device tests
Message-ID: <ZlT3ORBU6-FbRXda@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523201922.28007-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 23, 2024 at 05:19:21PM -0300, Fabiano Rosas wrote:
> The current migration-tests are almost entirely focused on catching
> bugs on the migration code itself, not on the device migration
> infrastructure (vmstate). That means we miss catching some low hanging
> fruits that would show up immediately if only we had the device in
> question present in the VM.
> 
> Add a list of devices to include by default in the migration-tests,
> starting with one that recently had issues, virtio-gpu. Also add an
> environment variable QTEST_DEVICE_OPTS to allow test users to
> experiment with different devices or device options.
> 
> Do not run every migration test with the devices because that would
> increase the complexity of the command lines and, as mentioned, the
> migration-tests are mostly used to test the core migration code, not
> the device migration. Add a special value QTEST_DEVICE_OPTS=all that
> enables testing with devices.
> 
> Notes on usage:
> 
> For this new testing mode, it's not useful to run all the migration
> tests, a single test would probably suffice to catch any issues, so
> provide the -p option to migration-test and the test of your choice.
> 
> Like with the cross-version compatibility tests in CI and the recently
> introduced vmstate-static-checker test, to be of any use, a test with
> devices needs to be run against a different QEMU version, like so:
> 
> $ cd build
> $ QTEST_DEVICE_OPTS=all \
>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
> 
> $ cd build
> $ QTEST_DEVICE_OPTS='-device virtio-net' \
>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 2253e0fc5b..35bb224d18 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -71,6 +71,13 @@ static QTestMigrationState dst_state;
>  #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
>  #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
>  
> +/*
> + * The tests using DEFAULT_DEVICES need a special invocation and
> + * cannot be reached from make check, so don't bother with the
> + * --without-default-devices build.

What's this "--without-default-devices"?

Other than this it looks all good.. thanks.

-- 
Peter Xu


