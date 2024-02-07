Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2192C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoRa-0007Ht-DF; Wed, 07 Feb 2024 15:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoRY-0007HU-7L
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:22:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoRW-0007yq-RD
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:22:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41008ab427fso9900875e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337369; x=1707942169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfvgAgvoD4FPciKwUdeAt/MZ5QTDlIThQETS6IgCz18=;
 b=jWHvzBIyk5iBWaPsQx88KZreA7ok1zkIlefnD0EnBSgpemGTGfGtDqFTI3jGEM+bgR
 upnF53V9gJcO/WkyPPp99c71Z8zPY7yEbxSVy+g8onuD9rHC9hBx3x6KHXcANxAXD2h7
 5mKEaFZzNhp8sKB5mb0O5ZfH8ptQzgiZx9a1h1HEDprW0uzIgcrDA+ozv5DFeLZqIiNU
 hK9e2ImhAnzCyDfb3Ic5yflMnD3/O3lk2wTnAiW1oarhisiMQLfY0poZ0CNeZeLZEaKu
 YyvtJ7/ABuc3nU8bsc5FNg/YECEvi+CX0IN99PDRLTEiJJOV7Vh71oZQ8k8ws9Yy9tUT
 63Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337369; x=1707942169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AfvgAgvoD4FPciKwUdeAt/MZ5QTDlIThQETS6IgCz18=;
 b=gQgtGDrSzaq9BKssQsXoE7Ip1SvhiC1IyfP63bnclhBRS5tkiL7WoVsJ4CX+L1BS0p
 v/KdWfPCgezNXsXdfDxy55Y6B0xA9wDgl7H1l38RG6408YjMjQb6kP6+CQRFvdEpagZk
 osvy86SwIEXIEE14qcksCBqqwR4Ep3VI9xPexgEpAR4IKotSXH6IoPVw71fvNjnqsCDz
 Z4JkC55lVU0pSFQMZ5GKk3Ka5gn8j7SovArlxedRklbHoE+8gH/jiBR5QD8zvGpTVOnZ
 GBMus1cQWMMLkrFNfvb8NelJHHbvJBFdHLYAbKuguVCVo4VMxbRoWImv1XyhO8ZQWk34
 F54g==
X-Gm-Message-State: AOJu0YyUnupFYUnPeJ7p8cKf7XGiHHUjf/OqJ0z4lLDgnVXld3jYU+id
 3sQ3djbs8xmZb8q8BqEKJcge/lExK/MCB0CCS/M72ruM2uw0clhaXXCZ8oShAnY=
X-Google-Smtp-Source: AGHT+IFb0fJSdAtbIYGEC0SdpxlY5JbCqaWGMj9h2YudywyahpcO33Ts6LnDDw5Yv4qeklLZDJCQOw==
X-Received: by 2002:a05:600c:35cf:b0:40f:cd21:40d4 with SMTP id
 r15-20020a05600c35cf00b0040fcd2140d4mr5412847wmq.25.1707337369120; 
 Wed, 07 Feb 2024 12:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWvPON2oOD/yaK8FL4GAMi9SJ7MPQetOWCPEUfNl3BFJo2YLvHIQsdCoFvo1edVvxTHBPIKIQRlPwY4lVBgqMO3b4prrwU8XMqIVQQm0iyaHRqhltyxRnahGPiX/rjdhIlcyUXY+MmJmQdene7QjLKmh3k=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c4f4400b0041007731a52sm3104298wmq.11.2024.02.07.12.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:22:48 -0800 (PST)
Message-ID: <55b0398c-0713-4c5a-a39f-506ea21d08fb@linaro.org>
Date: Wed, 7 Feb 2024 21:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio: Add Error** argument to .vfio_save_config()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-10-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 +-
>   hw/vfio/migration.c           | 18 ++++++++++++------
>   hw/vfio/pci.c                 |  5 +++--
>   3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9b7ef7d02b5a0ad5266bcc4d06cd6874178978e4..710e0d6a880b97848af6ddc2e7968a01054fa122 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,7 @@ struct VFIODeviceOps {
>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>       void (*vfio_eoi)(VFIODevice *vdev);
>       Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);

Worth a one-line docstring?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };


