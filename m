Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA41EE77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXg8-0003FY-7X; Tue, 17 Dec 2024 08:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNXg1-0003E8-JJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNXfz-0003x7-J5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734442310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AS8wsaBoSoXXSDOtTG8+RSs7knTZqYH6v63iyVQ1HjA=;
 b=UuMim9ymQZOtH8yi22eg7sM5pEONTD7E7hN3L7QUEHKD8yUhFmtlILldBVCvgMmu6k6si/
 UfzIfNx99f34TB8i2QLVM73f7hAdDzG0/lMbKeETORebSsoG5o0OVos7L5Uuyc2DtB0dqA
 mS989Wg5rUNwo+2BUYGcP1k4QGW883U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-TyHIOo17PXC9bb8HEJnZIg-1; Tue, 17 Dec 2024 08:31:48 -0500
X-MC-Unique: TyHIOo17PXC9bb8HEJnZIg-1
X-Mimecast-MFC-AGG-ID: TyHIOo17PXC9bb8HEJnZIg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436379713baso16547455e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 05:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442307; x=1735047107;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AS8wsaBoSoXXSDOtTG8+RSs7knTZqYH6v63iyVQ1HjA=;
 b=QZ9CtNTmyZd+CUg3+dbGf/8oCOWrSIVDBHtDoqG9J7mxAZ2u1XQ5RN2KCMMNdJP79U
 1LwvKDiEAn1NjN6L8j5VnaXMmwhw07y1K3vzKfdl1AtJCW6yIkf36fnG2ExmDGnBJOjP
 /M6FG9JF2uJvi6bPFtAdtNpYYiYTSa909o5AY9t6MKqNC0hJVwIQ6eNIXOukImowJc9l
 py50k6xBwiYV2juHyD6lYQDxiEFGynoFlsBEC8lLyx3Th6Pd/PcsxdggTFgtRQGyX6eD
 Y1DZTEwocVYlI10TZFMpuQ6CodDS/ut4RKYllR6rFoMSvc2wzOe3GUtIr73HWz8y4/cK
 VraQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbI3HC283n1i1ZMCjHwn73jNyaCoDKy9xpIRh4zhEhuvF1OcldI35FKDnIE4UJBV1qSb7gAEct+54@nongnu.org
X-Gm-Message-State: AOJu0YxwW7xc84iIlqXHWTypsQ9o5Z7hnLtwKdUKikMRgX5I6FCux9v/
 OA/MDBEyvihq1CBtiJt604O7oQmp2IFSfGAwyuVOnUumNmS8TL+o4WW1MbBxnC0AriI5vY2FUpo
 UNcwu+9Aep4lECc+bayDkVHKHWrTysMDlIe67I5tF/g/Wo2yp6oDX
X-Gm-Gg: ASbGncsIEJ6OKo9pRn8qmjOjuLFOy1Z+Pbtrf1QCYXPXNWQW/gzJJFqc7DAbM3rNrqH
 BCHyd4gIWkw/Kv6G4nksqWJ19bvBX8BjJyHI5+dZd35NDIE0QTvoeAGK2+OSpaosbp5Ggm5HE5n
 f+UFWgTTcZO1JJWaWzEX0a/wcyFbPnc24IJvBm1+PbKg+PO8pVIcNsIrfsBJ4gypIoPBjUBSs67
 t0d9nQd/A7dcWZmsokj8s76F3BD+2fHTqqSo86yLqszdS9jugTjPxdGGi83YmEXlyVIjb3eNnbU
 Sfju/bRo/wo8LgxyKfU=
X-Received: by 2002:a5d:584a:0:b0:385:f13c:570a with SMTP id
 ffacd0b85a97d-38880af13d4mr15553135f8f.7.1734442306823; 
 Tue, 17 Dec 2024 05:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfrxT2nMUydEUon+FztE7NPEnDCmRMKpNpPEThP+xbIdvZ/BAx5kNYLrSu/qgniTX9+MOfBA==
X-Received: by 2002:a5d:584a:0:b0:385:f13c:570a with SMTP id
 ffacd0b85a97d-38880af13d4mr15553120f8f.7.1734442306497; 
 Tue, 17 Dec 2024 05:31:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706cc6sm173449485e9.30.2024.12.17.05.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 05:31:46 -0800 (PST)
Message-ID: <e9d36881-947d-46c5-8869-f8db3f089060@redhat.com>
Date: Tue, 17 Dec 2024 14:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] migration: Unexport migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-10-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241216094638.26406-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> After being removed from VFIO and dirty limit, migration_is_active() no
> longer has any users outside the migration subsystem, and in fact, it's
> only used in migration.c.
> 
> Unexport it and also relocate it so it can be made static.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/misc.h |  1 -
>   migration/migration.c    | 16 ++++++++--------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index ad1e25826a..c0e23fdac9 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>   void migration_object_init(void);
>   void migration_shutdown(void);
>   
> -bool migration_is_active(void);
>   bool migration_is_running(void);
>   bool migration_thread_is_self(void);
>   
> diff --git a/migration/migration.c b/migration/migration.c
> index 18ca60af4f..5bb0633e37 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1139,6 +1139,14 @@ bool migration_is_running(void)
>       }
>   }
>   
> +static bool migration_is_active(void)
> +{
> +    MigrationState *s = current_migration;
> +
> +    return (s->state == MIGRATION_STATUS_ACTIVE ||
> +            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +}
> +
>   static bool migrate_show_downtime(MigrationState *s)
>   {
>       return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
> @@ -1637,14 +1645,6 @@ bool migration_in_bg_snapshot(void)
>       return migrate_background_snapshot() && migration_is_running();
>   }
>   
> -bool migration_is_active(void)
> -{
> -    MigrationState *s = current_migration;
> -
> -    return (s->state == MIGRATION_STATUS_ACTIVE ||
> -            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> -}
> -
>   bool migration_thread_is_self(void)
>   {
>       MigrationState *s = current_migration;


