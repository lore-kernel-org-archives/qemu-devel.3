Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D53FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricBu-0001b2-CG; Fri, 08 Mar 2024 10:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ricBm-0001ZX-4m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:31:15 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ricBh-00008i-Tr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:31:13 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a45bdf6e9c2so269487766b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1709911867; x=1710516667; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YH6MlDPdnoLWWPXoTTEpelfujeDTtrM788RsOZVvSv0=;
 b=WONxwXMDk6E7LCigw/BR3neWahDiERIgQTCKucCQmcOoSSm3N3tGw1L8iZE6/pi1eo
 7BV+OcC3HMQ8eelVEwRq7QS7+fdzrhPFfZm/wTupXI6YdOmv509yO2dNR/hOfDPDqmOh
 yODEWQd0IvtTp26K98q9jZ6Sy7XRS16ekijWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709911867; x=1710516667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YH6MlDPdnoLWWPXoTTEpelfujeDTtrM788RsOZVvSv0=;
 b=rQL/ayyoULebkXIlnhZwD353lYNoovcymKA5rY6Sm7ach3BTjH0xPykwR6AoHwUfZl
 EsG3are+ohGpQPssa8BLG2z58D6imIfOn40VYP/KUeQEJOeYhYluWXMGG16EpqkRLt+5
 JnjL0pDqy/1w1E4mCX7eMreY9wH7+/9A5UtLZIKlzlYPsqo5X91WlrnNVaTZeD5JS2vC
 x3iPfVLXkOJLHI95mc0g6vX9AFtDqRvM/4uUBrkMnW4iF/4dTnggHuKzjwCwotVdF8/t
 1wcuhG07amGrycR7q4pqJiWP3f/YodpHjne9T7VnvQ6PRne1B1Etcoz3nBd9n34GrQWB
 GjKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmjY0CKz8FEVsDPxwb383ZN7kjKNSbdvtBym374eF90m8tb+kX920H9cjWstpCBNRbla/ziaPqRuvcHmauxTPvQCzJfk=
X-Gm-Message-State: AOJu0YwXitqH62/OIkiniiuFyXMKOuIE14QOr1wd5dTfBo1UyGoG5ehX
 9kgcQiJASFmJjVN7Y2M5pOj7c3b58Ysv+0zuZ6PpzoOA17YvuugfOzEjJngJt1I=
X-Google-Smtp-Source: AGHT+IEBfIxsts55MLYdgyvsm2syWKaIzZJ/gQRQnI55gvIt3Qc/sVGj1iaCCCcqY8M5YHKD4JUpqQ==
X-Received: by 2002:a17:906:84e:b0:a43:b269:d27f with SMTP id
 f14-20020a170906084e00b00a43b269d27fmr13273755ejd.64.1709911867295; 
 Fri, 08 Mar 2024 07:31:07 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 js18-20020a170906ca9200b00a45be04f00fsm2848497ejb.171.2024.03.08.07.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:31:06 -0800 (PST)
Date: Fri, 8 Mar 2024 15:31:06 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 14/16] hw/char/xen_console: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <521de725-5d13-46ff-94d9-29e09fb90210@perard>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-15-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228163723.1775791-15-zhao1.liu@linux.intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=anthony.perard@cloud.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Feb 29, 2024 at 12:37:21AM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> 
> ERRP_GUARD() could avoid the case when @errp is the pointer of
> error_fatal, the user can't see this additional information, because
> exit() happens in error_setg earlier than information is added [1].
> 
> The xen_console_connect() passes @errp to error_prepend() without
> ERRP_GUARD().
> 
> There're 2 places will call xen_console_connect():
>  - xen_console_realize(): the @errp is from DeviceClass.realize()'s
> 			  parameter.
>  - xen_console_frontend_changed(): the @errp points its caller's
>                                    @local_err.
> 
> To avoid the issue like [1] said, add missing ERRP_GUARD() at the
> beginning of xen_console_connect().
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>      ("error: New macro ERRP_GUARD()").
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

