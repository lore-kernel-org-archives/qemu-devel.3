Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3D6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadJM-0007aZ-G8; Wed, 22 Jan 2025 11:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tadJK-0007Zh-ID
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tadJD-0006W3-Sk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737562226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAk+xgWXk42/HwL0NsFDJLCViwM0MQ8bDCDs3okiySc=;
 b=HEU/1AfsK29QGjxSMJ/L50XUtHloX+A/5YLfSQwyv4YTdhJbjV1KxYQRhp7X0v8dZ4HviP
 C8OZ+F7m5S37mUifCfQrPbjPV/WDzA2ABpJLy0EXRTi8ccEiI7+kd8r8nQGci6qz2FSRqI
 BRT1Cql4McuO20999alq3rpJUPwH2Vw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-SLZpB7LBNgidQMFEtLVX3Q-1; Wed, 22 Jan 2025 11:10:25 -0500
X-MC-Unique: SLZpB7LBNgidQMFEtLVX3Q-1
X-Mimecast-MFC-AGG-ID: SLZpB7LBNgidQMFEtLVX3Q
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6f1595887so1061549385a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562224; x=1738167024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAk+xgWXk42/HwL0NsFDJLCViwM0MQ8bDCDs3okiySc=;
 b=qtLg36dPIp09/tK2/MOnZWs2qbDkPHJ7vaa/Wg3omXFb35J+DGi5S3sSqdS3GOdHUt
 W8QYFOOBeDATCYJK6jGSj5kruRivHZrYQL5g24trC3kDn4GEQ5kz1S68wmJpPX/1fypP
 Un8KKXnGX6mYb7BCIiiWApSHWwWRTT6JuSHKRGNGnA4O80ffjnjxRARx0XSdkmc/mjf0
 GGSM5OpkkNmATjT47bXaSmhxmdOoKsFi2ahLQLC/jdw6UWGcbDcLr/JbhA9M9d/JeNxE
 U2ZwOvzmPRsaqA8PxSeOsCnwOPWBbe6TAUvaJaNFyYGUzvVfxkmhkXJplE477ZJfYiCg
 gxeg==
X-Gm-Message-State: AOJu0Yz0x3rYjmrWIEKG/rOq3kJ+VmhKYp6eQsybrv1P669rVHoPO1o4
 VaLtWy74CzKGSSUdce0LMQ0wKH1G7jXQVaQIyPKN0yuwmKcRG8iPYwyn+VP8fyGsalu78HnvCk8
 9ifrZwCMo86tA7AXXshbz/b/GjcQNYvY9anLzsbnVT3mGMX946eIf
X-Gm-Gg: ASbGncshjvoc/aKEcWRYwFAdoaSBfH89a6RFghrKZIWMP+JDChqPlLI/MO+LKI9dyVu
 gcIlwi16s8HwjlzOzokUCPPvUO7hHQnRkCm+1xHzyquXN+GnNq6SNmW8ePfzU+twxxuPJk69avB
 duf0Ndj7bjK78zPLdpS2lGPUQO4c0osO7eGJWrx4PqUQx0fzmz4A8aA3O9g4TFngPUmdaFCBYgU
 62xDyDkmkgl2KIlAXeEfyJefkH8HzmDvbIsO+8u/sVRIcmzauyO8bRl9YTrhSrAOCsU5/9w6QY5
 +WgestH6juaiPDXKBPqRK08nTzYjgBQ=
X-Received: by 2002:a05:620a:1b8d:b0:7b1:161c:ef58 with SMTP id
 af79cd13be357-7be6323ef52mr3004430285a.28.1737562224660; 
 Wed, 22 Jan 2025 08:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ+x5Sm2iH/W/aw2unuiWY/B2DfDh6uZShEEnZ217eVaST3yYzycP44x3O0gqcdTfh1ECSmA==
X-Received: by 2002:a05:620a:1b8d:b0:7b1:161c:ef58 with SMTP id
 af79cd13be357-7be6323ef52mr3004425685a.28.1737562224239; 
 Wed, 22 Jan 2025 08:10:24 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be7497e48bsm428202685a.16.2025.01.22.08.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:10:23 -0800 (PST)
Date: Wed, 22 Jan 2025 11:10:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
Message-ID: <Z5EYbBXkjTu98rHk@x1n>
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
 <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 22, 2025 at 01:26:21PM +0530, Prasad Pandit wrote:
> Hi,
> On Tue, 21 Jan 2025 at 21:17, Peter Xu <peterx@redhat.com> wrote:
> > https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/
> > Would you please add all the tests mentioned there?
> 
>     /x86_64/migration/multifd/file/mapped-ram/
>     /x86_64/migration/multifd/tcp/uri/plain/none
>     /x86_64/migration/multifd/tcp/plain/cancel
> 
>     /x86_64/migration/postcopy/plain
>     /x86_64/migration/postcopy/recovery/
>     /x86_64/migration/postcopy/preempt/
> 
> * Of the tests you suggested above, I'll try to enable multifd
> channels for 'postcopy/recovery' and 'postcopy/preempt' tests. For the
> 'multifd' tests above, how do we want to modify them? Enable
> 'postcopy' mode for them?

Right, that implies a migration with both features enabled but finished
even before postcopy starts.

We have some tricky paths that may go differently when different feature
enabled, especially when it's relevant to postcopy and multifd.  Adding
these tests could make sure those corner cases got covered.

And btw, some of my above lines are not a single test, but a set of tests.
E.g., "/x86_64/migration/postcopy/recovery/" is not a single test but:

        # /x86_64/migration/postcopy/recovery/plain
        # /x86_64/migration/postcopy/recovery/tls/psk
        # /x86_64/migration/postcopy/recovery/double-failures/handshake
        # /x86_64/migration/postcopy/recovery/double-failures/reconnect

Let me list all the tests that is relevant to the two features to be
explicit..

        # /x86_64/migration/postcopy/plain
        # /x86_64/migration/postcopy/suspend
        # /x86_64/migration/postcopy/tls/psk
        # /x86_64/migration/postcopy/recovery/plain
        # /x86_64/migration/postcopy/recovery/tls/psk
        # /x86_64/migration/postcopy/recovery/double-failures/handshake
        # /x86_64/migration/postcopy/recovery/double-failures/reconnect
        # /x86_64/migration/postcopy/preempt/plain
        # /x86_64/migration/postcopy/preempt/tls/psk
        # /x86_64/migration/postcopy/preempt/recovery/plain
        # /x86_64/migration/postcopy/preempt/recovery/tls/psk
        # /x86_64/migration/multifd/tcp/tls/psk/match
        # /x86_64/migration/multifd/tcp/tls/psk/mismatch
        # /x86_64/migration/multifd/tcp/tls/x509/default-host
        # /x86_64/migration/multifd/tcp/tls/x509/override-host
        # /x86_64/migration/multifd/tcp/tls/x509/mismatch-host
        # /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client
        # /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
        # /x86_64/migration/multifd/tcp/plain/zstd
        # /x86_64/migration/multifd/tcp/plain/zlib
        # /x86_64/migration/multifd/tcp/plain/cancel
        # /x86_64/migration/multifd/tcp/plain/zero-page/legacy
        # /x86_64/migration/multifd/tcp/plain/zero-page/none
        # /x86_64/migration/multifd/tcp/uri/plain/none
        # /x86_64/migration/multifd/tcp/channels/plain/none

(I used to reference mapped-ram for multifd, but I just remembered it can't
be enabled with postcopy, so I dropped them)

I believe many of the tests can be avoided, but still below is a list of
minimum tests that I think might still be good to add:

        # /x86_64/migration/postcopy/plain
        # /x86_64/migration/postcopy/recovery/tls/psk
        # /x86_64/migration/postcopy/preempt/plain
        # /x86_64/migration/postcopy/preempt/recovery/tls/psk
        # /x86_64/migration/multifd/tcp/tls/psk/match
        # /x86_64/migration/multifd/tcp/plain/zstd
        # /x86_64/migration/multifd/tcp/plain/cancel

I kept almost tls relevant ones because it has the most code path coverage,
and I suppose tls should also be an emphasis in the future for migration in
CoCo environments.  I removed most of the trivial test cases, like postcopy
double failures etc. which can be too hard to trigger in real life.

Feel free to comment on whether you think the list is suitable to you.  If
you want to add some more into the list I'm also ok with.

IMHO we can have a specific path "/x86_64/migration/multifd+postcopy/*" for
all above new tests, that have both features enabled.

Fabiano, you're rethinking the test infra, please comment if you have any
thoughts on above too.

Thanks,

-- 
Peter Xu


