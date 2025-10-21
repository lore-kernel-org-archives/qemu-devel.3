Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A03CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDSE-00008n-8H; Tue, 21 Oct 2025 10:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBDS8-0008Ng-2I
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBDRx-0004sO-SB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761057293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woh6ki8pNpvyG+9OB3bwyV+SBC/8BQw5kJMciGBMvz0=;
 b=P6ZGn8pKd5aw/G/YvNIWAi7olNFO3MyRgsQ2C/nqH8469zCp30xJB7/Pa/0XTWI5W/GRDP
 VvKx1G9mI+d1+7d02/ZMSuDdUqZZ5pPpmC6E9oTpn5RXZqtrffl4lv/IcOJ73Wb9ZftLuH
 XtSrtJo51acrf5vhQdO51BQ2s6ioL0o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-JtPhfk94NzWRnnMIpvFIGA-1; Tue, 21 Oct 2025 10:34:49 -0400
X-MC-Unique: JtPhfk94NzWRnnMIpvFIGA-1
X-Mimecast-MFC-AGG-ID: JtPhfk94NzWRnnMIpvFIGA_1761057289
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-890801794b9so347352285a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057289; x=1761662089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woh6ki8pNpvyG+9OB3bwyV+SBC/8BQw5kJMciGBMvz0=;
 b=rVVEpO/V05yRcNtEYq1/UZtHCV9dGBnc0kbIeTIm+QMzUpajf1qE40QgbHPeSNCKM/
 P3SxKLpJ0LqNBvSZwcpbxz+FCShlbVhDPaniFvzhP8eVmaJGKw+I3SV+25HCa+YRnDex
 pM6T51jws+1OfD/2Fr4Ac/k2XZx8KOZ/Wkie0aVFXYDPElCCkWU6c0aH7avh6IukfxDO
 KJNr4WJ2MR9R7gEbzCB+AW1iBtSEz1F9p4SGwkZ+I0rT3pDGuoIy/9yOMy0lXSgGAvMM
 lIYa6uFTHkhMjDfei/x5PZpxNH5FkxC2T9WSx+AwpOfYFvu+70Yxy9A3DWKgO1soEf6A
 eHOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf4xOTzgU35czRjkCfL/xQdptAkZq0eF4G7yh54ZtnnKDqWTf2ttMoaf7SpZjj9trsOWdIJ4PGsppw@nongnu.org
X-Gm-Message-State: AOJu0Yzn7/ytfgpabeT2Sx0ioqRKWTzrZIkMzfsH/pjyW66wU7/uxakk
 Hb33xcpAAwRrap2j5Ae7mEFlxIzr30NZlzOMM6ahP5iNvl6kMvkC9KLeRNiP5M++Ud/1af34ZMS
 ZUw1HqEHvVoeufZbQL0m/9Z3OsjwBB7euFlYjnEh2oWvinBb7RrswVZvEtl3btFs7
X-Gm-Gg: ASbGncsx/MeVfSV/0yeC4iwH8Q0sgkLuvMfkVFj1mRGc2M7Rx+XqJ0XvwmzTRrmvBB5
 uLbccwCeZg6Gdas3qo5r2STLXmziVg3vMLCLQ46k4a70PdmLa49OPq4oPaneU/o1GhnXKReGsKO
 UNpF3znYpXIiNEJt/7+WzZAbRln0rkqu01i0dThjESX1/LtybBI9ANb2L7gxuhRPGcw85mhoqwO
 T9gU7bBuLAvkwRoE1OCGk6T6i2MQG7HmJ75L3MYsACusWafyp6h8lpraOcn8e7yjv5c20kY9nFT
 DiFhyLsPArr8BnsBXLbS+bkzXLDcRJr/jYt87FZZ8IcLHiaH0Z2pomZnhTYVzDjx4bw=
X-Received: by 2002:a05:620a:c4b:b0:88f:779c:44b0 with SMTP id
 af79cd13be357-8906f06f069mr1977394785a.26.1761057288458; 
 Tue, 21 Oct 2025 07:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYizrcpQ02L4v28uxtCCzu4LBjSBONknlyWUG0Gvd77bKwbGnGjyJjcNNLf0ZYwlu3Hmlg9A==
X-Received: by 2002:a05:620a:c4b:b0:88f:779c:44b0 with SMTP id
 af79cd13be357-8906f06f069mr1977390285a.26.1761057287823; 
 Tue, 21 Oct 2025 07:34:47 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8ab114132sm75319561cf.40.2025.10.21.07.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:34:46 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:34:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] Improve error propagation via return path
Message-ID: <aPeaBNIzrq0Ni4IM@x1.local>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
> Use the return-path thread to send error details from the
> destination to the source on a migration failure. Management
> applications can then query the source QEMU for errors, as
> the single source of truth, making failures easy to trace.
> 
> Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>

+Vladimir, Dan

IIUC we may still need to know whether the src QEMU supports this message
or not.

OTOH, we have introduced exit-on-error since 9.1:

# @exit-on-error: Exit on incoming migration failure.  Default true.
#     When set to false, the failure triggers a :qapi:event:`MIGRATION`
#     event, and error details could be retrieved with `query-migrate`.
#     (since 9.1)

This patch is going the other way.  That feature suggests the mgmt query
the error from dest directly.

We should stick with one plan rather than doing both.

Thanks,

> ---
>  migration/migration.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a63b46bbef..123cffb286 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -87,6 +87,7 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>      MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
> +    MIG_RP_MSG_ERROR,        /* propogate error to source */
>  
>      MIG_RP_MSG_MAX
>  };
> @@ -608,6 +609,17 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
>      return migrate_send_rp_message_req_pages(mis, rb, start);
>  }
>  
> +static void migrate_send_rp_error(MigrationIncomingState *mis, Error *errp)
> +{
> +    const char *rpmsg = error_get_pretty(errp);
> +    if (!mis->to_src_file) {
> +        mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
> +    }
> +    migrate_send_rp_message(mis, MIG_RP_MSG_ERROR,
> +                            (uint16_t)(strlen(rpmsg) + 1),
> +                            (char *)rpmsg);
> +}
> +
>  static bool migration_colo_enabled;
>  bool migration_incoming_colo_enabled(void)
>  {
> @@ -905,8 +917,12 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        error_prepend(&local_err, "load of migration failed: %s: ",
> -                      strerror(-ret));
> +        error_prepend(&local_err, "destination error : load of migration failed:
> +                       %s: ", strerror(-ret));
> +        /* Check if return path is enabled and then send error to source */
> +        if (migrate_postcopy_ram() || migrate_return_path()) {
> +            migrate_send_rp_error(mis, local_err);
> +        }
>          goto fail;
>      }
>  
> @@ -2437,6 +2453,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
>      [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
> +    [MIG_RP_MSG_ERROR]          = { .len = -1, .name = "ERROR"},
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -2667,6 +2684,10 @@ static void *source_return_path_thread(void *opaque)
>              trace_source_return_path_thread_switchover_acked();
>              break;
>  
> +        case MIG_RP_MSG_ERROR:
> +            error_setg(&err, "%s", (char *)buf);
> +            goto out;
> +
>          default:
>              break;
>          }
> -- 
> 2.39.3
> 

-- 
Peter Xu


