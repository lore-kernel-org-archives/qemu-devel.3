Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13975D711C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLbx-0004pc-B5; Thu, 18 Dec 2025 16:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLbB-0004j8-Om
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLbA-0000VW-3s
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766093506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fVSAPn4EfWqfBr22z9YSMw1q2F1WSwVXyG71Y88IAyc=;
 b=eGcoDqesIvIuoDS4bm+4yMDow1SFtKL5lgbELKKcLikK8cbPVYnj7Fpabzih4LN62nxFbL
 KqIb4eVimwUndMN3nTQ+IgHTWKVbAGDH2yTNFfd8HXUNgdu4BuOINULSDCfLfhkVqExrJs
 8Ij+Mpl688Nz8dVkxkbHFbC6YR4lZO0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-m-Fsw7voOFWkluuuvfjFTg-1; Thu, 18 Dec 2025 16:31:44 -0500
X-MC-Unique: m-Fsw7voOFWkluuuvfjFTg-1
X-Mimecast-MFC-AGG-ID: m-Fsw7voOFWkluuuvfjFTg_1766093504
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8824292911cso42905676d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766093504; x=1766698304; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fVSAPn4EfWqfBr22z9YSMw1q2F1WSwVXyG71Y88IAyc=;
 b=oUXvJXBZoBtiuHfGe3/tiGzMp5WOUcmj+x5xJfyVe8I81C2eTJl6ErPhvoIRGOk2Uf
 et+pYViU5CG+fo94JNHeO6UdfyUTGyhKOdgd6qQLGLYFIqEShV2jhAcVYDcNgrjYNSLW
 6HeYhEyq7xp7/8sfitD1Z5TfHH6yLx4QJeI6DnDERj78IPmxIMuiVtsc2l2CMeIi/rAn
 vlT7IA6ByglNU0b+r3TLSxgAE9uOH0YvL7S3CnX8IaIArzuvp5/4g+eujvNoGb+uzJRm
 UvjVX8hf84li8mBHYPOruYCXtUEKvCHU9CDCBtzWBD6R9bgV1zhpcehKxJw9HFKwnb+s
 sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093504; x=1766698304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVSAPn4EfWqfBr22z9YSMw1q2F1WSwVXyG71Y88IAyc=;
 b=H/07hN1XipNBc9c8y/OSThrDUx/k+qgNXJvjBLAHbnjmlq4gOXbrmHnu4sfpVmmwcJ
 HRiXKkAc3G8A/+yCr5LP4y2qFHRJ3xvaaqSGbuq1zfq5RwTlRYSpFFONIilGnNkPIODb
 f0/FFo6pdpQ/uCt+hpMQgxlKDXtshAOgFaNXof4bmUA/9Ps0fdSyyWPmy4JvqQyutpSQ
 ed48holFv89c2dMHTId4eLOBwAvKjPZurN0vqAsFR6GEQ1Fgv1Y1RY0LEUZwxyLRAFAA
 SdVx/vuwOTOjEQEhG+BX8c4pURgsupnNgSpEhxFYA5hH8pfleMF7Ad8+o7Tjmb0ea2U3
 +k1Q==
X-Gm-Message-State: AOJu0YyNHtWtNhbLp26gHHwCxrWb3p2UXb3RNfIHKEo1LU6zoTqVjgoO
 X1iYVRCVqDHAkwKmVzpyrFZ0vz7erIXaloHRTKU1FrHiUUGGvV6klN57JzaDDEfgJ4SmA0vJRsq
 2FXJcfpvzNRs0jv1YMCR/8Jjrp3n0fRbaOUVHlD56SJSKDLOb5U66BsMb
X-Gm-Gg: AY/fxX6OxI4eVzh5ruMV6gPWY9vmv0htgUeWzGGmwuJNuoBt4Im90Q1TbFkBx1d7cXc
 w+Z7K0O0XuKOBFTV9Qh8men5fhK0BSXkJA80HaXFTYAgqgUlO2XQui+oCRyxHiVPgWNir7iMbHk
 sxHHHaVy4HoSPTK+eaK08uu31b4vZQERMwFvUar3BJhB3pqP7khOlXRbzaHQZJBshAgkFoHr6HF
 VfbSL5D+aRnVPazfyEmmwiaTHgUUbFPtWR1MeEmfzHuAxvvyKLJzoldJr0+MJSMlalV4NX5eaQj
 wP6nUrTORWVJ0xn31QWNbjcO+FOjskGUEJrN8gA/76/3Dh4xUXLxVxgGfqW6naQK/+mq9IDoHDf
 /558=
X-Received: by 2002:a05:6214:4686:b0:880:4cfb:ab57 with SMTP id
 6a1803df08f44-88d83c64e72mr15308326d6.25.1766093504237; 
 Thu, 18 Dec 2025 13:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETvacSvZ/O26d5ZSg8RI/ssJtH7cJGxQAKOQH4VF61tHbb/qCbv2/iuh22PggqJj3dvsk/3w==
X-Received: by 2002:a05:6214:4686:b0:880:4cfb:ab57 with SMTP id
 6a1803df08f44-88d83c64e72mr15307956d6.25.1766093503758; 
 Thu, 18 Dec 2025 13:31:43 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997ada77sm4474106d6.37.2025.12.18.13.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 13:31:42 -0800 (PST)
Date: Thu, 18 Dec 2025 16:31:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 39/51] tests/qtest/migration: TLS x509: Add
 init/cleanup routines
Message-ID: <aURyvVMQuoXBrUbg@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-40-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-40-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 15, 2025 at 07:00:25PM -0300, Fabiano Rosas wrote:
> Split the TLS x509 hooks by moving out of them any code that doesn't
> need to access the QTestState.
> 
> Aside from making the code harder to follow for no practical reason,
> having extra code in the hooks will soon get in the way of converting
> the tests to use a new API that, unlike
> migrate_set_parameters|capabilities, doesn't require the QEMU instance
> to be already live.
> 
> Move the QTestState-independent code into a normal function and leave
> the hooks only for operations that need the guest machine.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I think I see what you want to do, this looks ok,

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial thing to mention below,

> ---
>  tests/qtest/migration/tls-tests.c | 155 +++++++++++++++---------------
>  1 file changed, 75 insertions(+), 80 deletions(-)
> 
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 8da95dc92a..6a858b766f 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -210,15 +210,57 @@ migrate_hook_start_tls_x509_common(QTestState *from,
>                                     void *opaque)
>  {
>      TestMigrateTLSX509 *args = opaque;
> -    TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
> +    const char *workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);

This introduces a string duplicate with the init() function.

Quick change is we can at least make it a macro so use it in both places
just to be clear that they must match.

Logically we can also make the opaque to be TestMigrateTLSX509Data*
instead, which can add a pointer pointing to TestMigrateTLSX509 (the "Data"
struct is per-test, "non-Data" is a setup, which can be shared).

Either way (the latter will need separate patch), or keep it as-is, you can
keep my R-b.

-- 
Peter Xu


