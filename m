Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7ADC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tne20-00050S-SA; Thu, 27 Feb 2025 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tne1i-0004tY-LX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tne1g-0003Il-O2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740663247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+B6L4n6BOi+geOHGCelQa4PK6UgYjAHyRQzVn6Mv8Y=;
 b=ZscCeqjT++bnMw5O0CT2EYXXZOXTptvFaBINqDzwST4MhyOTqFBsAlewoqXkk/VhVXH+GN
 rm8wzLP6MODUwEuXXQ3CoYrQ2uGwJL6K2kkJ0L5PvHVpDxhA1GcLeqKeFAREKz/iIS9WBW
 3W7+iXI9Hoo6lPHspYmsQY+nwAjq3z8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-sMwAFtWMOlO7YY2EGGXFBg-1; Thu, 27 Feb 2025 08:34:06 -0500
X-MC-Unique: sMwAFtWMOlO7YY2EGGXFBg-1
X-Mimecast-MFC-AGG-ID: sMwAFtWMOlO7YY2EGGXFBg_1740663246
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4e47d0b2so400231f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740663244; x=1741268044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+B6L4n6BOi+geOHGCelQa4PK6UgYjAHyRQzVn6Mv8Y=;
 b=C9tMAsMygHorAiOr1PeywNJM7cauE8V8/cm+tB9qjQDNYdMbn64LBlW5uP3cjkIwMB
 Jo8tKu23IPhZJEotAWv8rjyvwqrqXy5EXpm9BgTSYk8hsMPoOBOEBlGP6fcpfq8nATPy
 iE3S+wDK6FvMwaefda62XUQvNXpxQ8wHgBjkZNq/8T+pHDX+WKaXKWFyyBWbCGhoG5t/
 IqU/rOFr69j0O2yhpzuX6OyteTdr/7JtR0IsXxhWq1FvNZRM/nG2oLivvBP9W1mBey/m
 M2KUd7lxEVl33+PqXkAu4QLp3eOiNioWf4Q14lFqGWcBfUP9X/pVNW+QE4IRM6Jp9H53
 cLGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEJCxHIC/WtdtK/Jw4o6O0K/GkFTibWer2u12vvs4nHDWiDH6bZSvGmLQX+OuJmHg6Oqak//XjlNAq@nongnu.org
X-Gm-Message-State: AOJu0Yxl0RAab1R0uaUP9TgC9FZKGxRCkt8PUdEHFHCNbmoE9NHJnAMn
 DUmrAGpOrDWnqzf/7yvYcp9g5o6rcDF+A082jkdQSgExAIr76RzGUCJ3mxrNjvIK77gtsDxJq5N
 UmCUmF4eNbAMfHfa33cEh/sQVpJF5bLIx3osbMr/c63eRnCW/7EXCuCN++tDN
X-Gm-Gg: ASbGnctfFuKWF0XOI7HFT20wcgW4r/xDiKC3o6a9L3qHJtoYFRphsTh2apKVkPEkYDX
 5bX0BNB3/UTDcw2TLMcv4yGW1AhtIHU/ENXd5MV3T6+5fKcqqunGdH2KEZ3uwhdVGy+PDZpGfMT
 VfGOA6m6fo3925MM9nzzcippFyoB6NMFQINKHKRkDDGL4vMlzc1YePLK66LONyHP00mKVchRsvE
 IkqHNQGCwZ3qxvr1LDGQUGtcJp/c0fkv+kCuEKyGQql7gtB/1NPNVBTmnL98VyT8BF6Vx+6EAS7
 MgMCbM96ncxtGIgs5gaihfkSeTna6xVoy6sv5DXGQ4QIlvaXmBX8ckTfL6lioqg=
X-Received: by 2002:a5d:64e9:0:b0:390:e3c2:4638 with SMTP id
 ffacd0b85a97d-390e3c247bcmr2178803f8f.45.1740663244469; 
 Thu, 27 Feb 2025 05:34:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPgXKZGzQZi1RlXVPrwC3mmkAF2LYR36JJd6HlYn8JsxhoUL0knF3kKMZithcftiX65fGmwQ==
X-Received: by 2002:a5d:64e9:0:b0:390:e3c2:4638 with SMTP id
 ffacd0b85a97d-390e3c247bcmr2178773f8f.45.1740663244089; 
 Thu, 27 Feb 2025 05:34:04 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6aabsm2087622f8f.26.2025.02.27.05.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:34:03 -0800 (PST)
Date: Thu, 27 Feb 2025 14:34:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/21] tests/acpi: virt: allow acpi table changes at
 DSDT and HEST tables
Message-ID: <20250227143402.2aae1c20@imammedo.users.ipa.redhat.com>
In-Reply-To: <11f37e677592494c7e73b2ff5fad700e8726205f.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <11f37e677592494c7e73b2ff5fad700e8726205f.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 12:03:44 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> We'll be adding a new GED device for HEST GPIO notification and
> increasing the number of entries at the HEST table.
> 
> Blocklist testing HEST and DSDT tables until such changes
> are completed.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..0a1a26543ba2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,7 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/HEST",
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",


