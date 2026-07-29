Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1245C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4yj-00089n-R0; Wed, 29 Jul 2026 10:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4yi-00089Y-No
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4yg-0000YP-US
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785334185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zhxvtEf2ypPeHr04SPKwuR0N+TBRVddZoQ3G9WSplDM=;
 b=MHKt/t/eRBYveURclB7grskBW22t1hvdA5hyRGdUVmEEyWklPMe/Cq1DDigFVQhZi78Lj1
 yV/3PelGX7SXS+LDlwH/JkIOxzCJhRBSVcfLGkI6Rp2CpnIWrW4QrN5CGiTZeWlJDLDDRd
 bxklc3aqD3ZCWEk8Urxt8cDZxr0UaDE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-VUUXUR9eMVOkLRZqBRv6OQ-1; Wed, 29 Jul 2026 10:09:43 -0400
X-MC-Unique: VUUXUR9eMVOkLRZqBRv6OQ-1
X-Mimecast-MFC-AGG-ID: VUUXUR9eMVOkLRZqBRv6OQ_1785334182
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39f27a480d1so2934141fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785334182; x=1785938982; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zhxvtEf2ypPeHr04SPKwuR0N+TBRVddZoQ3G9WSplDM=;
 b=kwH9gI9oaUG/KyEjE+CCRVvsQMALMbgYbnStTTNSzQi6k0VTEJe0sNCQG8zx2cdE+b
 X+I9tacR+yzbjGb502aGud6JI2x7/pxECWooChVL7IASjNI4M0xmb8oVxkNe4aYFlJUe
 rU+QXPl60jYxZQoxEecwuhdGVRzs7/HoU8zi88Y16JoQRCv4Beh9cmkUry9BIo8USy8b
 9UZw8NrD/41w4+7KA31+QW/uOLCPo/9r4tMbc4Lrq4f+NvyP97mn/dKMW6LG8l1SrqV4
 PPuhviSSr8B6+6kijd4cNv3OXg9HMPNiZTQ8vywoSTQfYjWjzgqYDaRT8cBOGL3kdrE3
 G+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785334182; x=1785938982;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zhxvtEf2ypPeHr04SPKwuR0N+TBRVddZoQ3G9WSplDM=;
 b=JIA6YWUucHnyeM6FBiTLM16YdsblJDfj9DwIu375Cgpm5ZzH64cmhOHT5q6VJCw3Wl
 7P/S6PQ9MPGQp6lgB+fXSmw7Bh6VOJU4eINVgfSHoLlrgE2n+Wb7lLGgQAxS6RzOJ1IB
 4nKIl8n7pZG2IYkrhLxNf2H+uyIwxGH3L4qwf6TJCEWNuiNn2r2t7H22aoc+seKPLWzs
 1MLPtf+HKzVsvx/fiP5t5ZAsdw7sJiQeZOHdKOt+nhDGZfQwM5sfIn7doIdAQcbd7oXK
 IuBkEFdd4phS+rVhRHWU+OooqvwVW5D0w2IQT7JE2qJruCnKonTVwIP8PLQDjEKsE6b6
 cv4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoejhnIXYJy9ZnoWrmtJm1B8z6mQShTQYIRY3p92YU2fnKsqcLwUZ+uDg3c+Dd7ZhCf2EBREEj8RIiR@nongnu.org
X-Gm-Message-State: AOJu0Yyxxq2c8468dgdtosPZHVqAAGO0ReH22S56CWTuUON9noxXn3uW
 kLJy7Ls+5TbGG0tIMI3AhaDzcnxAlz/pAia/lHR9svKTNG35Gf+lAdoKmMcedWJnnERqtttMgiV
 J5djymBFpS4vXncYHrELj/0xfaQQgFHxI3hPcNlrPPBLuTfbZel7P6gcI
X-Gm-Gg: AR+sD128SQVGqOwekRgdz7VAg2mEKcXfI/Cmq62MLqm1OeZpPRjyxsi++9ISooa8DSQ
 2csQ3ukbGhPsLixLOc3X67OtUQZAZZCxC94CE5n9k3TeIoDSliqj6VbIZ3gfToc3MXecyuDXljL
 xkvDXyu3PcaRBU10HMuzu4mjWVseQ8nP3CTvMlXtLaOWNWyPN/upm4Hc8kVSWu6c39Ad7WJGRaG
 pTA8u8iYYLG/CZiM90m24CHf71i/TYp+KR9zeMDMrqYGZ/tm0IjC955XnM9eNDPKKap3zq4lTg8
 CvX+hOGFXVpo9bINQ4gFhcX1RFinyPShmIu19mML28Ge9yCyepi6DJl+7mTrcDFp8kUkBnotmSR
 GR4e5/o6Ek/mIBs04bi/mYqLaBJc=
X-Received: by 2002:a2e:a984:0:b0:39c:7130:f0db with SMTP id
 38308e7fff4ca-39f51c7ebe9mr15988931fa.6.1785334182290; 
 Wed, 29 Jul 2026 07:09:42 -0700 (PDT)
X-Received: by 2002:a2e:a984:0:b0:39c:7130:f0db with SMTP id
 38308e7fff4ca-39f51c7ebe9mr15988731fa.6.1785334181784; 
 Wed, 29 Jul 2026 07:09:41 -0700 (PDT)
Received: from x1.local (67-208-31-164.ip.tor.radiant.net. [67.208.31.164])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f5d60b218sm4843531fa.10.2026.07.29.07.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:09:41 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:09:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v20 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
Message-ID: <amoJoAyhymPgvyTR@x1.local>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-11-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729091334.1863155-11-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 29, 2026 at 12:12:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> As documented, for "local", the migration channel must be direct
> UNIX socket connection from source to target. We can't check for
> it being "direct", but let's at least check that we deal with
> UNIX socket (fd-passing supported).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/channel.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 1e2935f926b..537673c29e9 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -214,6 +214,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>      trace_migration_set_incoming_channel(
>          ioc, object_get_typename(OBJECT(ioc)));
>  
> +    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
> +        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
> +        error_setg(&local_err,
> +                   "local migration requires a UNIX domain socket channel");
> +        goto out;
> +    }
> +
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
> @@ -241,6 +248,16 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>  {
>      trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>  
> +    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
> +        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
> +        Error *local_err = NULL;
> +
> +        error_setg(&local_err,
> +                   "local migration requires a UNIX domain socket channel");
> +        migration_connect_error_propagate(s, local_err);
> +        return;
> +    }
> +

We only need to touch migration_capabilities_and_transport_compatible()?
It should work for both, and fail QMP commands directly might also be
slightly better.

>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          Error *local_err = NULL;
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


