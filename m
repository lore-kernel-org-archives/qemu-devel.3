Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B51C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAGO-0004eX-5y; Tue, 26 Mar 2024 13:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpAGI-0004cV-EC
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:06:59 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpAGF-0005Oa-Hz
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:06:58 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so64861691fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711472812; x=1712077612; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Lil4XHHupH9pVMZOy3d4NrDmD8ftMIDsaMKq9dwcYo=;
 b=CzN/vMQNxjovZyFNnKld3X8fhSpnuX9zxeoUJfd98MuvIbI//bEzI4Rrz4ClSVU/T2
 ONlYZp4noayenBs6komyHGCbQWTtX2NGl+madYY0zJDW9LtgF0qPcifqwI+0jWX47r5s
 OE2vD3orxB+n1eQYifnNSIjMUdeYvLyHJyQzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711472812; x=1712077612;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Lil4XHHupH9pVMZOy3d4NrDmD8ftMIDsaMKq9dwcYo=;
 b=EIiDmhBgHpl8oiSDZF0Q1+dvxI3ZZ5esixI9MXzXNN8czGsDFK3F6lllx4benyQFss
 QFPlGpAGj/O9LARPJOaGhKkRbs4vk5jK6/B3x6Db4zhRN/zdj7hxDuTsIi811ewJA0oq
 aqi83RBFBce9ETxLZYg8jh+XdyH0OL+Xrpsy8RxPTvMhtCkRA82T/V6Unp2IjaptIapd
 Pq2qEvo0brp0GaSToZptKrNY9Z2Mv7xdk8wLd7EpdYPa4XrWEC1xsSncw8iHBP/Ci5QS
 BhvBZ1mREtu2i6rs4qwUe+l7p2UfxklCHXE2GUI/cCcA9TKP3YsyS/9KSG92BgzlHcMs
 zbmA==
X-Gm-Message-State: AOJu0YxItAI+Nd0eK14N4B2u8pR2xlE/gyWAPW91Uv3ho4yQnAAqr9v3
 Jxd+Cj1slEOmCfunNnZuGZqx2Oj6AdRDtR31/hcJr3Lx0/bnD6ux/0ywnVbSgBLky2dTVWH+qqT
 7
X-Google-Smtp-Source: AGHT+IHv4uNFDY0BUyZmHrj5BK8Xw5p0BQXHUgMeT4rCoeC67uEPB3r/L3ngTN3jBvyPa6LPOwQjKA==
X-Received: by 2002:a05:651c:1502:b0:2d2:c8ff:d2b6 with SMTP id
 e2-20020a05651c150200b002d2c8ffd2b6mr3155025ljf.1.1711472812034; 
 Tue, 26 Mar 2024 10:06:52 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c138200b004146bcdde06sm12186029wmf.6.2024.03.26.10.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 10:06:51 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:06:50 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/2] hw/xen: detect when running inside stubdomain
Message-ID: <a6345b81-5c67-4c05-acff-f73ceea904ad@perard>
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=anthony.perard@cloud.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 05, 2024 at 08:12:29PM +0100, Marek Marczykowski-Górecki wrote:
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 124dd5f3d6..6bd4e6eb2f 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -603,6 +603,20 @@ static void xen_set_dynamic_sysbus(void)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
>  }
>  
> +static bool xen_check_stubdomain(void)
> +{
> +    char *dm_path = g_strdup_printf("/local/domain/%d/image", xen_domid);
> +    int32_t dm_domid;
> +    bool is_stubdom = false;
> +
> +    if (!xenstore_read_int(dm_path, "device-model-domid", &dm_domid)) {
> +        is_stubdom = dm_domid != 0;
> +    }
> +
> +    g_free(dm_path);
> +    return is_stubdom;
> +}
> +
>  void xen_be_init(void)
>  {
>      xenstore = qemu_xen_xs_open();
> @@ -616,6 +630,8 @@ void xen_be_init(void)
>          exit(1);
>      }
>  
> +    xen_is_stubdomain = xen_check_stubdomain();

This isn't really a backend specific information, and xen_be_init() is
all about old backend implementation support. (qdisk which have been the
first to be rewritten doesn't need xen_be_init(), or shouldn't). Could
we move the initialisation elsewhere?

Is this relevant PV guests? If not, we could move the initialisation to
xen_hvm_init_pc().

Also, avoid having xen_check_stubdomain() depending on
"xen-legacy-backend", if possible.

(In xen_hvm_init_pc(), a call to xen_register_ioreq() opens another
xenstore, as `state->xenstore`.)

(There's already been effort to build QEMU without legacy backends, that
stubdom check would break in this scenario.)

Thanks,

-- 
Anthony PERARD

