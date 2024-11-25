Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8864D58D71
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcwM-0005U1-HY; Mon, 25 Nov 2024 12:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcwK-0005TL-2X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcwI-0006TS-9h
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732555917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tGfHG9rw/y8mFkGxTEzAIGADPuMvMHGqvh3DKZN7do=;
 b=XaK15H3tfo6uXl05x8zskFAFTh/IWxecc76JvtQyVeSI9ueDmJqQF6xcA6UAUFRGw3RHiC
 WxCu9UEPA8Jb8543bMA8ngWN9HhHhhn6sD1P3fOtRuxyk9TXlPLHAjxdWMBVS29B3xdRDc
 NxvlCTxwPPRijfUWGvGly5n8HDjDU34=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-CUVYG0WuOq2vcZx6Tq4NeA-1; Mon, 25 Nov 2024 12:31:55 -0500
X-MC-Unique: CUVYG0WuOq2vcZx6Tq4NeA-1
X-Mimecast-MFC-AGG-ID: CUVYG0WuOq2vcZx6Tq4NeA
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71d4d832305so821427a34.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555915; x=1733160715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tGfHG9rw/y8mFkGxTEzAIGADPuMvMHGqvh3DKZN7do=;
 b=KcYiNLitlLdpOHlBkdiaXtcPHw/rqlb6bplwKJu6FJEUeqVLm8BOCLvPekICM98gcP
 F0GM7kZlc3g54XsEZYOq6N3DA6O37YsYfOe7SLLZGpYu5xXk+XI8U0jjscCvW6y6XQB+
 UcxZufNGRiVD8oHoCQb2LQBZK23lsM9uzRoYiNGrOrgMTFSRPrqkJI1CEUlbYNLptIrs
 KODDe0nWq1RGDwsHHope2NVjNGoLJZ2Znouie1ijkX/rGAQ1PjlkEZfCkvv+YD2fDCek
 Xuo+wGUUDaiS8zG5o7AMRVcPaNKUfzAddizNuKU98WT/Tzhu7CHkTK516xHQhv9BIPOt
 HTmw==
X-Gm-Message-State: AOJu0YxtWq2AJxbCkRKa6Hc4nuTg5qPE+kxrFmJpowI7mU0WaVmXJu5f
 oa+2xPNVrIFGT0IDkQRdqoS40Xk03/ANSToaG5OsXU2+3IdJSklZK61FNk3FAFrBSU8Fj7W6a8g
 6MOB39ywimA+HHmdgPbwoGGwWeOi3Tr/V2r9NmPV7xUNJwcejqWXx
X-Gm-Gg: ASbGncuuYT5SnQt4clnJ0WeqIScmxfmMeiv3QgYj6iHtEdKfU0M+6uONEuC9S9Qi0sK
 +e/irCPtIzp7bNcA8KU50PEO4+morpJ8Guuxxwr0xAtXXS/fW/XinHsCSKA3dmhqghYtlfgovsn
 GkuC8Pkw6vNyfsuoOOgd41ox4sygEgjEBVy9FCDrkNsZeYEsDNN8UIRQprG+bNzvIpyWrLbuBY6
 C+ia+ritFq4Qc8qRqLpYqvHF9wtjj/y2f8g2eStqVEigH36hEwP3DxZyFUHgTx30c2i4fvL/AEr
 6VeziktsLwA=
X-Received: by 2002:a05:6830:65c6:b0:71d:4150:9e5e with SMTP id
 46e09a7af769-71d4150a358mr6535865a34.2.1732555914822; 
 Mon, 25 Nov 2024 09:31:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6eT7SM6qsXBta5H5TcuYEZuMcAK+Qj2maspSikyD+NMJvaVpq42EwteDSUaN7vP6lILgu7w==
X-Received: by 2002:a05:6830:65c6:b0:71d:4150:9e5e with SMTP id
 46e09a7af769-71d4150a358mr6535848a34.2.1732555914573; 
 Mon, 25 Nov 2024 09:31:54 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfee836esm2243555173.106.2024.11.25.09.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:31:53 -0800 (PST)
Date: Mon, 25 Nov 2024 12:31:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/22] tests/qtest/migration: Move common test code
Message-ID: <Z0S0iMbqsjoup5vh@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-12-farosas@suse.de>
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

On Wed, Nov 13, 2024 at 04:46:19PM -0300, Fabiano Rosas wrote:
> The migration tests have a set of core infrastructure routines. These
> are functions that are called by (almost) all tests and centralize the
> common operations of: starting migration on both sides, waiting for
> guests to boot, performing guest initialization and teardown, guest
> memory validation, etc.
> 
> Move this basic framework code (and a few static helpers) into a
> separate file. Leave only individual test functions (and their own
> static helpers) in migration-test.c.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                |    1 +
>  tests/qtest/migration-test.c           | 1140 +-----------------------
>  tests/qtest/migration/bootfile.c       |    2 +-
>  tests/qtest/migration/bootfile.h       |    2 +-
>  tests/qtest/migration/test-framework.c |  969 ++++++++++++++++++++
>  tests/qtest/migration/test-framework.h |  216 +++++
>  6 files changed, 1201 insertions(+), 1129 deletions(-)
>  create mode 100644 tests/qtest/migration/test-framework.c
>  create mode 100644 tests/qtest/migration/test-framework.h
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b9f70ac32f..bdb9512510 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -332,6 +332,7 @@ tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
>  
>  migration_files = [files(
>    'migration/bootfile.c',
> +  'migration/test-framework.c',

Nit: considering your previous ways of renaming things (where you tend to
drop "test" prefixes all over the places), maybe framework.c suites more.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


