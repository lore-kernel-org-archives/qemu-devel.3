Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4EDD3B993
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3mY-0006hv-G2; Tue, 09 Dec 2025 14:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT3mV-0006hY-L2
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT3mU-0007TA-62
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765310033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBLM/rx27rkgdgnT00r4tb0/sBX77t9eAorLWI51H2A=;
 b=Hy87iQ2a/OxKbNBLe0YYatBe9Ubvrv+X+IxWCMJRP9SbPaZrtwbiTtxBR8nXetZjMI95R2
 YopKBKu1cuTQTX+IE5+UGFn2QfztgHeP+eMN4n8KYWQuLLbqxKfXBT3RlqvFMugJZ1mPNX
 Z/SxG4C20BhudiaQ4/osGWv/dHeoYoo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-iXyMC7pbNSKXaj-op-lp2A-1; Tue, 09 Dec 2025 14:53:51 -0500
X-MC-Unique: iXyMC7pbNSKXaj-op-lp2A-1
X-Mimecast-MFC-AGG-ID: iXyMC7pbNSKXaj-op-lp2A_1765310031
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b9fa6f808cso147577785a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765310031; x=1765914831; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vBLM/rx27rkgdgnT00r4tb0/sBX77t9eAorLWI51H2A=;
 b=RhsTPdIkzVSa2pR99bskHVdMFj7WJxtqjYYS+1ywXGzKCx9nggoIO9HEb6rUnWyaF6
 KBuFBUu2aIMeyfIbK21L3s5Fb21humeSC95i+bG/kFfPE8BrIcuT+g6155en+R2a+hRL
 EYaeD0QEfWzyqptS97MtUN78mbMp7yVwL8UXxcx1uhF1WvJy4mqrSZ7oNxVDBBVVke7b
 qE20VO8OxwD5zy9O9M1SKRGISB4MbN01cmTa9aoBVxYmgwnt1Kjqxn+oOz7rrBoewCLC
 lZJh2981JyXohgm/1TsUgg/4L7cEkDn3OMGr3lwTSuEMnX0xHBwNSdchSomVRXG3zJ2Q
 MnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310031; x=1765914831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vBLM/rx27rkgdgnT00r4tb0/sBX77t9eAorLWI51H2A=;
 b=PB98UMTxk5sNmqNDFMCWeUg92PwEuzeSR8y8kTd+ZjRlx5QgKWZt1AQxutj3Sf3phk
 htk7xpfVuQU80ddOVMRJAv+6MP7x4GD1x/3++DZiFliJN/svfLb1BhBd4CfbW1eLYbiP
 uRbaT0s00SPgp2lItPfOr5NIdFB0hq7lxW9OcQzU0CQvr2/yEtIlfZyFv3FhHsuNYiMl
 hnMGv3XmATJrF+G9Pf5d2LyUVHk5EVvRHdDVv4h1FqLxg2JyxcI5RRtPkdYJzDyCoIGX
 IVIsf2tWP9sVtZhr/HOOgQveD1QAfjbpBNmigRapcVkcJRbdGf2ui4nlD2wCuE9eNcPJ
 a2sw==
X-Gm-Message-State: AOJu0YxW2UQRx1u2UkMSgE+0S2bzbE+Jxr+vYN8575xb6kO0hWpJQTNE
 IU2pqwDNZbibzWEFhZLxrt3bXSebZ9zClt9NZr1e3BBg60X3U0LOxU45VlZqLl0nfC4wXgRu7Ol
 D+0snJuIBYfAw103sgEk1IjlWcGEWwZfyCneih5o6j91oE1SIw9P2r83w
X-Gm-Gg: ASbGncvJfJJDM5EKd9g1BWuhD2ML8kA1MfyzOTRC1VaaEYCmlaEuVBcagwQKxqelySk
 MoxeRKiFdkLCgRHwQiBXHXsAKQwDu7TBDq33wNPOQJEBHyxfvzsJULt71MINbXnVyGAqQLKZRcg
 XLTTPcayb6+wyUxFR+o1EdobOAA/RpbmW3hq8WYwOhQiz0+c0IBU5X2BpV0a78cvO76V9BrqFqH
 myFDh+lc+BtJA8apFwX+JYMmLv+WlYfxgxNlDnnKtsUETghkhSpfIKsPIG/41SowzRLZE6T8Jic
 ii6Mx0UEHMUClK6IfPi0/xXJ/hwLZ9o1Tr8jdr/tq2CaCS3JgspvuNvFfTJHebfjcYp5boMIL6L
 CyGQ=
X-Received: by 2002:a05:620a:4620:b0:88f:265f:a8df with SMTP id
 af79cd13be357-8ba3ad34c10mr26432185a.85.1765310031214; 
 Tue, 09 Dec 2025 11:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoWRRgK9aV6CCdDnhcDnCQAyTO2eAW2ZfJGxWQO7LPVZLDFnw5dQKUSOmEfpwmascXzmA9NA==
X-Received: by 2002:a05:620a:4620:b0:88f:265f:a8df with SMTP id
 af79cd13be357-8ba3ad34c10mr26429785a.85.1765310030711; 
 Tue, 09 Dec 2025 11:53:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b627a88115sm1366301385a.41.2025.12.09.11.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 11:53:50 -0800 (PST)
Date: Tue, 9 Dec 2025 14:53:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Weil <sw@weilnetz.de>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2] migration: Fix order of function arguments
Message-ID: <aTh-TUbyMRCfkbS5@x1.local>
References: <20251209195010.83219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251209195010.83219-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 09, 2025 at 08:50:10PM +0100, Philippe Mathieu-Daudé wrote:
> From: Stefan Weil <sw@weilnetz.de>
> 
> This fixes a compiler error when higher warning levels are enabled:
> 
> ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
> ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>  1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>       |                                                  ^~~~~~~~~~~~~~~
> ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
> 
> Avoid also a related int/unsigned mismatch by fixing the type of
> two local variables.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [PMD: Replace g_malloc0_n() by g_new0()]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


