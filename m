Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8400E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 21:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGss-0005Vv-Rx; Tue, 07 Jan 2025 16:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVGsq-0005Vj-VI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVGsp-00031S-HF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736284380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FoMSDK/DnfOX/LQ+gOLbRAOlk6bwb0fiSme/0S3NVU=;
 b=KBKZflz+D7xNpX+46acpGKK3Nn/Zt3Y0jguyVReEIJxM+axgMyKInSCNuTxSIyTsnPKuFD
 sTvMS9f6j3+8GoTus+9cPWJXRwrNd7d/IPIAxBlUqVTVSb4YDpXLXHk+s8apzn6CoILMqi
 qxOo89d6+61s1f+xtTg0issg/k2HIHk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Gf2h1ljEOSaHim-Jru1j2g-1; Tue, 07 Jan 2025 16:12:59 -0500
X-MC-Unique: Gf2h1ljEOSaHim-Jru1j2g-1
X-Mimecast-MFC-AGG-ID: Gf2h1ljEOSaHim-Jru1j2g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f8f69fb5so3035496d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 13:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736284379; x=1736889179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FoMSDK/DnfOX/LQ+gOLbRAOlk6bwb0fiSme/0S3NVU=;
 b=Wl067woKyIiRmLGTFZCgH2bkiawzHfuXu9RIkjGIDkFrd3xfSw7iQzuIcQoh+1D1J/
 AUogMQrc2QUr21Q9SwRbRf6ZjlbKIiyvbChGj2eGJr/hi4Ws3FbllbHRY2i4ICwfkhrS
 lgoKvrFopljxEHfKe8v3WKMBgVuYXCScDzVOwXdIMxVj86HqUYy4dOZJz9UdNVzD5PnN
 iXe+Dsgrpr3o+JK45feTGo4FhOA2JnTsP4mw143mQyliK0ELph7fTZy1TCzQiPdyZrYo
 sB+BAmG9ZotfNEtoSh5bSyNrLUWEh4hGjYKtgXncr/5MKGhH8Yb+KhGQGeur4E0w1YmF
 //VA==
X-Gm-Message-State: AOJu0YyQmmwH7aTdK2ojC9rbmUqHymlp+tRQg/QV+OZguvEwIWAKkpTr
 Jesl8GExlObjqhQElCgJKaFGTRXzJETKutuPk/2QkSo72Tuc1W2PxKu6cNgiORjVt9LvTO3xn0b
 26dI6gd3RJoohcFTjzO+U5D5QAlE8IOw8XIMuzMCf/QeNQSzi2nC7
X-Gm-Gg: ASbGncvyBD9dHmT537j65rd5F7hQ5Is0OrE0DRuJcFxoBw8zEEXRXq9m9xADS7BO/fq
 CsU1FTDT0fw8E5yIOhl7waL08prM0Zzbyaerb+pjpf2uzes+C+WyFWhHQRNa4wwCoMhwVx1EUKA
 OGwlfVQR3e/HaJgertBcxJT0jHdA/q2cEtK8GiZNPg8GyjXMIJZq6qkZicdqL87F2y4IsHdTyZK
 IsZ0j+1g+KH6Zj4ZrOUxOxju5r0kYg3jZe87MkV5ivtgJBcY0sW5h7yQgHOxYDtlDOvnFDypiAT
 g6NArSCJg7344QGvmQ==
X-Received: by 2002:a05:6214:29e7:b0:6d9:87d:66f4 with SMTP id
 6a1803df08f44-6df8e7d6555mr73928446d6.8.1736284379108; 
 Tue, 07 Jan 2025 13:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBZxHAsv//7PQV1hkfXtYKkRFm65s9+HGV3FUW8PFRTOtNF8/9sfb8RCgTnDB4T9Krv1y2SA==
X-Received: by 2002:a05:6214:29e7:b0:6d9:87d:66f4 with SMTP id
 6a1803df08f44-6df8e7d6555mr73928246d6.8.1736284378855; 
 Tue, 07 Jan 2025 13:12:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd4194937bsm150479066d6.95.2025.01.07.13.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 13:12:58 -0800 (PST)
Date: Tue, 7 Jan 2025 16:12:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] test/qtest/migration: Use out-of-band execution for
 migrate-recover
Message-ID: <Z32Y2C0iw3gGIkkg@x1n>
References: <20250107163156.310226-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107163156.310226-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

On Tue, Jan 07, 2025 at 05:31:52PM +0100, Juraj Marcin wrote:
> In real use cases, the migrate-recover command requires out-of-band
> execution, because the main thread processing normal commands is blocked
> by a page fault in the guest memory. Tests, however, do not reflect this
> which might result in some bugs not being caught with tests.
> 
> The first patch in the series, adds a new qtest initialization function
> which accepts capabilities the test wants to enable. This allows a test
> to enable the oob capability.
> 
> The second patch then enables the oob capability in migration tests and
> changes the execution of the migrate-recover command.
> 
> Juraj Marcin (2):
>   tests/qtest: Introduce qtest_init_with_env_and_capabilities()
>   tests/qtest/migration: Use out-of-band execution for migrate-recover
> 
>  tests/qtest/libqtest.c                | 18 ++++++++++++++++--
>  tests/qtest/libqtest.h                | 17 +++++++++++++++++
>  tests/qtest/migration/framework.c     | 23 +++++++++++++++++++++--
>  tests/qtest/migration/framework.h     |  2 ++
>  tests/qtest/migration/migration-qmp.c |  2 +-
>  5 files changed, 57 insertions(+), 5 deletions(-)

Looks all good, thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


