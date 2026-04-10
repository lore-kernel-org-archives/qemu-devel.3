Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12174F44841
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB9nY-0001Nv-2x; Fri, 10 Apr 2026 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1wB9nW-0001NY-Oe
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1wB9nU-0004Yf-TS
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775819589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnRpIo7gW6lnSXFxcJWr6x39ZT4Rgc2RfbVSsGPwEZg=;
 b=FtO9V8NWre0rfjTsuCz/7e9HYMTeOsd0sYz20VvKscPbP7CpT3I0205jI8bWww1Rlb9+Xv
 WZv+VvMCkot6qGA1lYL80dVd5OjQAV33oNBb8eQPMfRgpM7PIthVK0f3+HdJJovSMjs1/H
 vCiMnf3ztdM2RY57avawaxKsDvlwPkM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-T62tH-M5MBmGEPXaaTUWOg-1; Fri, 10 Apr 2026 07:13:08 -0400
X-MC-Unique: T62tH-M5MBmGEPXaaTUWOg-1
X-Mimecast-MFC-AGG-ID: T62tH-M5MBmGEPXaaTUWOg_1775819587
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488ac66236bso12206185e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775819587; x=1776424387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pnRpIo7gW6lnSXFxcJWr6x39ZT4Rgc2RfbVSsGPwEZg=;
 b=b2fKq3n3cUppMKqGKHNgkGlPcntsj6xUC6sBbh4CggmIEpjrxfWPE7wuGOI8ia3EdE
 kKlCTRQt0P/2knJJheDTiC9GgY6w/aeLlPXJqx+IVAfcmBFNZMoTYmlvxXu8mCaeIb3Y
 yoVzwn0qtNF/8kOBn2bMQZXa7H4XL4HyaYKetKeh6mt3qzb/Kda7VC/hsmyuKDVvHJAw
 YEB5UMYyVIZK60uHYKtHN5t2cSawAJVXVmqMOtQvdnUuQjdCubi9HgOk9sGnnUY5uAka
 YaJJFg9TrdCbGvs4YRf0AGrgrZyPKMPWGj69kCLh/o5pEHkqHmu2oP9yQhXxqc3E0HZQ
 joZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819587; x=1776424387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnRpIo7gW6lnSXFxcJWr6x39ZT4Rgc2RfbVSsGPwEZg=;
 b=Vhj8uwgF5rc65+446c3LlgQBGeYrioz6dNVe+gYFizX6thW7H/Nna+2yqosICOKiNN
 kEVdvHpYfFKuautAqoq7SzGg7BBgFqCZGFPbXMsT0Q0mA+tEEEIuf3AbNYzyzZL8tGbc
 KnHtzyE3s1QFh39NzDcd7MXNA1Y2oJZV2ZCMkll754PUNFQmcdyNqQyKsE6/TQMZWakk
 YI/Hins0UimSu499J7OAvDcQfJp8kpknaMa+WACT88EkVH5aQoQviUOOOA9LDId2WVOc
 u9Qg5XaXInaQt7fIfVpVdhU76rFZdEEyhRfeKubc2uj6jSm5VgkQR/+pn0pPyijd2OZ8
 AXgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNkt41ulXPnYm8nz4oJTdIW5C2+yWxi/yqga/ppwZMDwETpjxmxH4TX9ERsTGTusp8tnbAsjX68aPl@nongnu.org
X-Gm-Message-State: AOJu0YzM14mNQ+OFpml9xld57xQNqaissgj/mh8brGTKG3e040jM7a/B
 /XY0BPC2Kfcijo5g79ag4gMaEpmLvMafWqfib841YdcqFJ6TSMrHf6FP8L05RD5T5G78aL8+1dF
 4eMq6zqgi3diSkHSDN1fHig+Rla5Tem+tBHl7qOYBKZAupQtg7owT0uRI
X-Gm-Gg: AeBDietyNACIRaXYxJXzT6b6iT3sErXLTBAPqZRAbx70TJD0/D9LgdbEILeu+FI2xUA
 pffWl/8biZc2To2+HXGczUzrt1GReaF0V+h0qaIAUe4xWRy6dxaxXgD2l/P2z2DD65v088yb84R
 eMfJmkdDxePOzeM9wmC6KIgwCAP2BMK4H2Uzfx1cjZl7JOBW/c5A4acUTk6bujoXf/m/98Hmkon
 4CT80h0/nzvz5JAdGpJHle3Fk5BU+OvuILHk/yncJr5E3Pc9wdTFCcCoaI7HE66FNgimSbrXT2r
 cn/h7341dbwCzgd0mIz7LwrvvTGoUyt2kGB8gUMmnYIeC2zk5Hb2MhBwgrHZq/MmHTlZ5R7xuzF
 iYR+r+KLOM1rf
X-Received: by 2002:a05:600c:444b:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-488d6acd9fbmr27978365e9.15.1775819586902; 
 Fri, 10 Apr 2026 04:13:06 -0700 (PDT)
X-Received: by 2002:a05:600c:444b:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-488d6acd9fbmr27977925e9.15.1775819586391; 
 Fri, 10 Apr 2026 04:13:06 -0700 (PDT)
Received: from [10.43.3.236] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ed4dsm63202925e9.4.2026.04.10.04.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 04:13:05 -0700 (PDT)
Message-ID: <4ec35a88-d6b8-4bed-b44e-d76cbf80d3b3@redhat.com>
Date: Fri, 10 Apr 2026 13:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 devel@lists.libvirt.org
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-3-peterx@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <20260408165559.157108-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/8/26 18:55, Peter Xu via Devel wrote:
> This stats is only about RAM, make it accurate.  This paves way for
> statistics for all devices.
> 
> Thanks to Markus, who pointed out that docs/devel/qapi-code-gen.rst has a
> section "Compatibility considerations" stated:
> 
>     Since type names are not visible in the Client JSON Protocol, types
>     may be freely renamed.  Even certain refactorings are invisible, such
>     as splitting members from one type into a common base type.
> 
> Hence this change is not ABI violation according to the document.
> 
> While at it, touch up the lines to make it read better, correct the
> restriction on migration status being 'active' or 'completed': over time we
> grew too many new status that will also report "ram" section.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: devel@lists.libvirt.org
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst |  2 +-
>  qapi/migration.json             | 10 +++++-----
>  migration/migration-stats.h     |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 557a24679a..ccd49b5615 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -699,7 +699,7 @@ was superseded by ``sections``.
>  ``query-migrate`` return value member ``skipped`` (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> -Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> +Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
>  for more than 10 years. Removed with no replacement.
>  
>  ``migrate`` command option ``inc`` (removed in 9.1)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..e3ad3f0604 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -12,7 +12,7 @@
>  { 'include': 'sockets.json' }
>  
>  ##
> -# @MigrationStats:
> +# @MigrationRAMStats:
>  #
>  # Detailed migration status.
>  #
> @@ -64,7 +64,7 @@
>  #
>  # Since: 0.14
>  ##
> -{ 'struct': 'MigrationStats',
> +{ 'struct': 'MigrationRAMStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
>             'normal': 'int',

Libvirt does not store/care about struct names really (only temporarily
when 'flattening' output of query-qmp-schema to see if a command has
certain argument, for instance). So from libvirt's POV:

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal


