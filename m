Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F85CD4F56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 06:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm5il-0005hl-VL; Thu, 05 Sep 2024 02:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sm5ik-0005hH-HR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sm5ij-00009j-0n
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725516710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3D9OSv8MFse/t19mO5y3srm+e7LcPHsmLBhXYkJjrI=;
 b=D0UZy1Z6EqBdM+6JgUBAwaUtgQKLKzYhpIyjmp+QtEMdvMgTSGEv62cRGYh8vpAsxu+2/h
 HJML0GHHULEx26E53fky0TIOxEs3ostiq8Skox9nuEav87BV1haYL4D4nIYwMIG4Rt+6G/
 0FtbUYNKEWM2Lp2oRSJQXaZdJi/64k0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-7Pn_cUuEN_-EZETg_hIy6Q-1; Thu, 05 Sep 2024 02:11:49 -0400
X-MC-Unique: 7Pn_cUuEN_-EZETg_hIy6Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42c7b6358a6so2911595e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 23:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725516708; x=1726121508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3D9OSv8MFse/t19mO5y3srm+e7LcPHsmLBhXYkJjrI=;
 b=ChEBm/U5SlVRnGXzhcnU88sQExylMnR+GsLvwBn2aWlOOhSoQC9yI1h+PGettMqC6K
 gTjLCu45pleyr9H9UoWTtNPdt6Zs/NuAxBvEFB2EmXS4sHX+GUBtXx9kT/Bp70Yb5IOb
 jACM9NvynuNK08oHkpl7clJ7VqZ7/jrSERrfHovb2IOO3yBe9MR/FU/nDF7aGDtDyu+E
 O8kze4uar54QhyDz/KbjL/uQX53dDzQaQmZpwkOUjJd1D8taNAYDtVXrz8WUxE/ApiEa
 OBsP2f3WVij4+q4qbf4vP7qJHNS3hEAlmirAnQ1u0YCrLAaagwJa6nhdSsY0jJP/QTp2
 bfZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJv5UhBJX9FmR0X61em/QkYDMcmNedqTrEEOmCeABZzsq8jYzIXErcSCcbZFjraEayPwCXF+SMKVYb@nongnu.org
X-Gm-Message-State: AOJu0YzGzlQcxKqVVt2T5PSbPlynYWSZy0sing3XRpSllBYYbxgALWJG
 JuTFY989vEdKngPIZHqgxoEIDSCwjm+vB5MoEkI6pXXbT4A2Wil237/tx1wxcQETfbyWGLIz075
 e4rUm3knYerWEhPXfnoS+7e3Y/Qjfos8TaDh8+YL6ggJVSyuDo+1bWvEa/FfObMKuZ/yqYD9KCy
 xcJvrylSyQm2KyNK291w1nThu7p70=
X-Received: by 2002:a05:600c:3b88:b0:429:991:dd71 with SMTP id
 5b1f17b1804b1-42c954500b6mr31616525e9.11.1725516707932; 
 Wed, 04 Sep 2024 23:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzu8fJaXi+VLfE117rxlzG98R8oQ2RihEtyTyPOZyc5axlH2jKPCdG1istMhxWtlvJ5QCLD3KpefMCZKjb88U=
X-Received: by 2002:a05:600c:3b88:b0:429:991:dd71 with SMTP id
 5b1f17b1804b1-42c954500b6mr31616195e9.11.1725516707436; Wed, 04 Sep 2024
 23:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
 <20240830232722.58272-4-yichen.wang@bytedance.com>
In-Reply-To: <20240830232722.58272-4-yichen.wang@bytedance.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 5 Sep 2024 11:41:30 +0530
Message-ID: <CAE8KmOx+yYEKXC2-cgBJK=0kb4dxi=Gxoqvm1WY9faBF9A5f3w@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] migration: Add migration parameters for QATzip
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Sat, 31 Aug 2024 at 04:58, Yichen Wang <yichen.wang@bytedance.com> wrote:
> +/*
> + * 1: best speed, ... 9: best compress ratio
> + * There is some nuance here. Refer to QATzip documentation to understand
> + * the mapping of QATzip levels to standard deflate levels.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> +
...
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> +#

* Should the default compression level be at the median of 1 - 9 => 5
or 6 ? A compression method (QATzip) choosing speed (1) over
compression as default seems contradictory.

Otherwise:
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


