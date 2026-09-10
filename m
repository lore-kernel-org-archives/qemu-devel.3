Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB36C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ih0-00039H-1M; Thu, 10 Sep 2026 13:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4igw-00037q-F1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4igu-0004MR-1M
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789061762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ekUFRkLRYXP2jvnFX43Zu8if8c8ijd8QEj5newnj+A0=;
 b=Zx68T9jOS6DdZ0CiKUwELRhf8TvS8AyAEtwH0p/Mt6+yPCMVRY7/gITSkURdzOLGDmqBRU
 HR/YZ64XrznPSjKBh4hf7TmBzgSDuoq9lEdNJgussl5ROG0q1bFYOjDTSHthbU7t6d2rwz
 NQOj9M29Fqva6I3X8G4zgfxtF05/Wus=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-QS4SI5kjPnackrpKN6-M2A-1; Thu, 10 Sep 2026 13:35:58 -0400
X-MC-Unique: QS4SI5kjPnackrpKN6-M2A-1
X-Mimecast-MFC-AGG-ID: QS4SI5kjPnackrpKN6-M2A_1789061758
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9394ad7f64aso1149848985a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789061758; x=1789666558; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekUFRkLRYXP2jvnFX43Zu8if8c8ijd8QEj5newnj+A0=;
 b=X9NXmq9TX+WArOjwbDAilne3E2jWFXh/FdnMY5gpUQnCLJRy7h5S4g5bhJrhzPv3hR
 CZpfLZWYf062VCx7RUleNsivgaFPxYPXc4SzVLa7XznRqpvXBBHltXs8WFSwCQl5yrD+
 jpnu7vvwStFtcXViHzplnwDp8A7lV6j4AAuz+P/mWvpA/hfPy7QWP9TWaL/NzI+pZVV/
 Af7J+6rnQixOPUoH0kFcROW2nkZR+CCGYC6BbjcIo6DTXuXG8R4naZdEUdZ7iz4Z3PU9
 M6qutmkiOwW1L5Euv6qcd+pITPLoKkkxkWwh0MB2mh8E/hxjG5Hp7P8QqXEQvp8UXlAu
 /pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789061758; x=1789666558;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekUFRkLRYXP2jvnFX43Zu8if8c8ijd8QEj5newnj+A0=;
 b=MrR/y/ZpcBIt9UASWrZkhrK7QdBRF/FKaRLcHXcGiMzlJoCh6SlswYTNA5Nw1z8IHM
 UCRO4NAvZXN3bhROHFbkPp38fpHNZnv2HXJmE6iKDtrevloHYkiWYuJyZCWgiDLKZDK4
 CoQZB/i8bKDcN4/eWTxH5QgFS3JxUHMcon2aFaz+uWJcz4zv9jhvpoWEJ0p9A9cg5Y0O
 knH40P1vg3AQshwqwabKCVkfjUO+xo9E/CCWNx55QgNaXWJnDaVDZAwXbOOr7OuX9UWN
 WonQkM3dxnxl/nL7I85nkLitz7pzEKVHdjwtCTXCz6jBSKC530ddg7GclbBZ3E7gpXoQ
 mCyQ==
X-Gm-Message-State: AFuF++mO/1gjvktk9tkB52xH9ndeSUOX6mH6StvIYw36fpYafEXgLK9f
 aroemsxHDHHSOoGsN16WTa/tjJiYXKfOitHvUWB3PkvLxoIYf5q898UHbS8bV/XvEO5ysHViMDW
 qNRpfWM/l7GQ0cVzy8y6TcviAbn1h+5veI8vAgEkNUMA6eGb0HMIsT18b
X-Gm-Gg: AYBFou0z9iRHoqk1ePh8WaY8IlgTNncoGer4xhfq/yIp0ZxF8VrML50thFPKTju5UAD
 gBL0uuQtBprBkDARb5xcGxrTMvI4x7k6itpa2uHYXO/+0XsOO/dozz7RlcCoTpdWzaCnI9rweb0
 rB12ee95Xm2XxdIzfAjt2zvfRim8dMT4LyUsszHnyC+w5Y/WoDXeuJumxKP2oX5dyRuC4rH9ElF
 K5Sa0RNpOW330tHHDyELLEb/SCPRHDfq5SppXgEecywCCAT5NxcsNjnJ5+syGHxNZ+4Ewrae1eZ
 K3BbWQhC38j6gUXLVAaT84zPTuFFvMmS3JeWxVdiWXfd3WHkq6Ca1PnLdNLoPpDttiEsDm7r8b0
 /yOttbk3uGqiHagNCyy8vrWcqDwFUjm91Ow56Lcei1a1mCLNdlKLVvHRwv7w=
X-Received: by 2002:a05:620a:6842:b0:939:6de6:9517 with SMTP id
 af79cd13be357-939d4ac1bc3mr1410974185a.46.1789061758164; 
 Thu, 10 Sep 2026 10:35:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6842:b0:939:6de6:9517 with SMTP id
 af79cd13be357-939d4ac1bc3mr1410965385a.46.1789061757461; 
 Thu, 10 Sep 2026 10:35:57 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80bbab7sm31805485a.34.2026.09.10.10.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:35:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:35:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 00/18] migration: MigrationParameters changes
Message-ID: <aqLqe4jmPuHL7OeL@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 09, 2026 at 06:44:50PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas (18):
>   checkpatch: Fix checking of newlines in error messages
>   migration/options.c: Don't export migrate_tls_opts_free
>   migration: Rename variables in qmp_migrate_set_parameters
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
>   migration: Merge parameter structs instead of assigning one by one
>   migration: Open code migrate_params_apply
>   migration: Stop freeing s->parameters members individually
>   migration: Use migrate_params_free during finalize
>   tests/qtest/migration: Add a test for HMP
>   tests/qtest/migration: Add a test for HMP completion
>   migration: HMP: Fix bandwidth parameters
>   migration: Change HMP 'info migrate_parameters' output
>   migration: Use keyval input visitor in HMP set command
>   migration: Use output visitor in info command
>   migration: Rewrite migrate_set_parameter_completion using QDict
>   migration: Add capabilities into MigrationParameters
>   migration: Remove s->capabilities
>   qapi/migration: Deprecate capabilities commands

The new HMP test may fail when ran without userfaultfd privilege.

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/hmp
TAP version 14
# random seed: R02S0ff0d2920ac5e3bffdb3b5a776110e91
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-219499.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-219499.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine none  -accel qtest
# Skipping test: userfaultfd not available
# Start of x86_64 tests
# Start of migration tests
# Start of hmp tests
# Running /x86_64/migration/hmp/parameters
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-219499.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-219499.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel tcg -nodefaults -S  -accel qtest
# HMP command failed:
# 
# Error: Background-snapshot is not supported by host kernel
# 
**
ERROR:../tests/qtest/migration/misc-tests.c:376:assert_hmp_success: code should not be reached
not ok /x86_64/migration/hmp/parameters - ERROR:../tests/qtest/migration/misc-tests.c:376:assert_hmp_success: code should not be reached
Bail out!
Aborted                    (core dumped) QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/hmp

We can either fix it (but I don't see easy way to wrap some TESTs to run
conditionally), or drop the verifications for background-snapshot cap for
now.

-- 
Peter Xu


