Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0EBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXg5-0003Cy-5v; Tue, 17 Dec 2024 08:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNXft-0003CK-R3
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNXfm-0003w2-2i
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734442295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CvJBi2i7np08zuRfPakpGnbBsNstsXp3GeCSjrYvIas=;
 b=D5iRqCwN6i9cpbYiHMJ+uFssr/KxJ0pACBrRMgvDJgu0meS5fQmrgNXDoRKSnDVB1hEP5i
 64NaYxTtfkWtNSHJNX5OAY7dGPkvu/bEtAXC0W3CSJEmYsD0dvTjYDeKKC5Bl9lgANRQrT
 Rlysq0UOTzSqogcUnkxMm59u3I3l2j4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Irhr5mvaOnu_uTcpY6q_Lw-1; Tue, 17 Dec 2024 08:31:34 -0500
X-MC-Unique: Irhr5mvaOnu_uTcpY6q_Lw-1
X-Mimecast-MFC-AGG-ID: Irhr5mvaOnu_uTcpY6q_Lw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862f3ccf4fso1987106f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 05:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442293; x=1735047093;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvJBi2i7np08zuRfPakpGnbBsNstsXp3GeCSjrYvIas=;
 b=sgYk5/XwlHCzxAtIeno9lAMDXAS3il/2GXNWLeBTJpFtFNMt5pEcs/WEJy7S1rC3/p
 2/HZEuB/wepNDf/5W07V07BZTCC4XFZZThp3LVJcuvz9UjTgWDE9vbp1qMt2Bo7BccxX
 M2a89HqJNf5EpQn16tJpErLjhH+r4UovwomBijFwcgURu43EkY5vuDe2wEBEKfdlkk1R
 BJ9Fb45nkU7Ge4a5vUa0IYEPBnBs1oV0cNJ9IHqis12rE529qkTzfT7XaOBtgvYDnJJi
 k64AHSZbC5S4QqTZTst6eos3WKHDKPVT1zC6Y9EeD3VYmYzkXjCFGtxmJ04EIVOydGAl
 Ed7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpW8ewcM75KYLT9/TD6Z3KMf5UzWQbCW5PuLub5dknSu1hdU0ch9Ak6hS0xuSZnxJ9ed1HfuKaNe8U@nongnu.org
X-Gm-Message-State: AOJu0YxGFsCYO6LCnqC9lP1npRAkxD81/xOXV0LjLEa0oeiDfJci1g6I
 q0T+pOE/AXM2teiJBt15WUYextAWxKiQwe+eX3x6UbpJYB/2Ro5H84K5mNooUYTV4Ccfsm0ICJB
 pYdmqsQGn10a1twI59pNNOuXF0YeOlZfD4nO9wp1i6U/Uim6Y+zVU
X-Gm-Gg: ASbGnctzIgKarU3RhMW2SFOotLGW0xYWdBJQeI3wprv8cO66vQu+voIpcTlWsSAPnrB
 jLQM4mZ2H0NTVjRIe6vY1V9+K/5t+/w43H4jLDobaxamJuLj/hlPam3NxJgAQmLN1MUP+5WqwF9
 nM7wtR3KHBPAOmp50SnG7QZCdPWLXED6R3wmhGNo9kTHP335ZRi8rBIvhXl4uSgOAcbgXbobD8f
 GYDQfvn13AoabJC6A76Z2ohwcy/Qge7PYn4PctNav+jSe4zsELlTGkfgoKGGD/j7ew+Uh+YDMY1
 eBnRiG3iXtz3QuAGs88=
X-Received: by 2002:a5d:598b:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38880adaaadmr11096127f8f.31.1734442293075; 
 Tue, 17 Dec 2024 05:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6ZFe6g1brcnOFe1gflXleyD8mSKh5LbZMLSXSagI/lGIDbRZr649TftvYH35FliE774SiYA==
X-Received: by 2002:a5d:598b:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38880adaaadmr11096100f8f.31.1734442292668; 
 Tue, 17 Dec 2024 05:31:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm10997300f8f.98.2024.12.17.05.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 05:31:32 -0800 (PST)
Message-ID: <9c1770fd-d8b8-4799-a8d4-0c291e8213ef@redhat.com>
Date: Tue, 17 Dec 2024 14:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] migration: Drop migration_is_device()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-9-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241216094638.26406-9-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/16/24 10:46, Avihai Horon wrote:
> After being removed from VFIO, migration_is_device() no longer has any
> users. Drop it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/misc.h | 1 -
>   migration/migration.c    | 7 -------
>   2 files changed, 8 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 804eb23c06..ad1e25826a 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -54,7 +54,6 @@ void migration_object_init(void);
>   void migration_shutdown(void);
>   
>   bool migration_is_active(void);
> -bool migration_is_device(void);
>   bool migration_is_running(void);
>   bool migration_thread_is_self(void);
>   
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c5bd0a75c..18ca60af4f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1645,13 +1645,6 @@ bool migration_is_active(void)
>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>   }
>   
> -bool migration_is_device(void)
> -{
> -    MigrationState *s = current_migration;
> -
> -    return s->state == MIGRATION_STATUS_DEVICE;
> -}
> -
>   bool migration_thread_is_self(void)
>   {
>       MigrationState *s = current_migration;


