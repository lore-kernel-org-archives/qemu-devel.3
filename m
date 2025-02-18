Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B286C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkS8h-000458-8d; Tue, 18 Feb 2025 13:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkS8f-00044o-SZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkS8b-0006ww-Pu
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WEDBPU9qVVzrOkHmyijyvoLU8jIBYR+bp1MpJx5cZk=;
 b=Z1fLlZNzH83W0eBclid1bT4kWbG1i8mxjpxktaoFW2EkwcM7pZrduRJX3vYEfWByFYTgcf
 6yNVccJkEq5jQiIpnTayJVXQBFJv6k0mPr8Ka4p/8E61eziTwe3B8t0RhMKMArvPlaqvhi
 Ckg2g6kA2degqFRnDDZ1SlO+3YFs+lU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-ORLhu01KOGaWC5Yg89qTfA-1; Tue, 18 Feb 2025 13:16:02 -0500
X-MC-Unique: ORLhu01KOGaWC5Yg89qTfA-1
X-Mimecast-MFC-AGG-ID: ORLhu01KOGaWC5Yg89qTfA_1739902561
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2bcbd5bfc95so2135154fac.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 10:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739902561; x=1740507361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WEDBPU9qVVzrOkHmyijyvoLU8jIBYR+bp1MpJx5cZk=;
 b=sRrYUEuAVWAqI1qAY99yAQcHT6ApUfg+DoIDZtRBexMu9WCaACu6Ei0H6Z8Js2NdGD
 gfinK+zQRSbEG0Pc26ukIL38ZQen5M8YdHjZjmBPwBgHqeId7vjK4pDN+DECoYhVNoZc
 giLSIjrjQJfM7CGBLGa6uIM4uRZ36uB2Ia4WZQApi2r2WZ7a3C7Ik9cElopdwy0SBdUq
 FwGuSrLPk6F+9+JLXWaZ7G4Itwn5dYMbVkKSzL9MTTud08MYpmUK8O+53xG5IaorQpYq
 9MHvLCwdx2yQQm8gujnwmB0AggaSiaQZ1i07BNZNbWh5CMcYK45PM3jyrXXqmJv4RQ6q
 W8LQ==
X-Gm-Message-State: AOJu0YyvtM9//Ix9BPuxmmzN7sIFz5iF/qoNR14yJcrD6mufh7QzEhts
 GLGp8SVOOoleGlhV1xehIiMERXrDC8ZgGqVcEt9VHq0wH1gvjdCDwuX+g/T1XR4oN10/WNtGAQk
 dMaSyP74E5TJjG1S70VcrGOmpDZ2UcajCoQK/W+HzoYQap2CXOvaC
X-Gm-Gg: ASbGncuJNzKodUtqZHyI91+iNHjwcp4AuQ2z9GFNQSfufHQyJ3iOcfJwMdNa/Y0pWWg
 ZS/TMbyCHPd5d45dPL5wAi2+Z8AGZGgjjuu5M5uaT+CQv+s1oHB8mtJEkKOM1UhbHxwsc5M8thz
 rad6AUVFuTn5JYu1jRy2C2UF9sABQoAejGngJPu3g6u9mJRM1I6ugipOkCqdzHN7Qs+S3KBPGEG
 wsBL64YovPS4ZpaIHbZokxUX0+VD+dpYrFLVGsiFnhLTCjVIcFSyBFa9Jw=
X-Received: by 2002:a05:6870:4985:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2bc99aa8352mr9324367fac.12.1739902561430; 
 Tue, 18 Feb 2025 10:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa1i+krqDrmBHzo3QS1mlkxokX4ZztVLwxAecphtn+L8REhIkoS+NpfJ5N3acsPNXQl4OU3Q==
X-Received: by 2002:a05:6870:4985:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2bc99aa8352mr9324340fac.12.1739902561057; 
 Tue, 18 Feb 2025 10:16:01 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b954820712sm5047776fac.5.2025.02.18.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 10:16:00 -0800 (PST)
Date: Tue, 18 Feb 2025 13:15:57 -0500
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC] migration: Introduce migration throttle event
Message-ID: <Z7TOXfn6BQBhS5uG@x1.local>
References: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 18, 2025 at 10:39:55AM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> When the developer is examining the time distribution of
> the migration, it is useful to record the migration throttle
> timestamp. Consequently, include the migration throttle event.

Would trace_cpu_throttle_set() work too?  That can provide a timestamp and
also the new percentage of throttle.

I don't feel strongly that we must not introduce qmp events for debugging,
but allowing that to happen means we can get tons of events at last.. as
people can start requesting many more events, and we'll need one way to
justify them at last.

One way to justify events can be that it could be consumed by mgmt.  On
that, this one I'm not yet sure.. so ideally tracepoints could work already.

> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/ram.c     |  1 +
>  qapi/migration.json | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 589b6505eb..725e029927 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -524,6 +524,7 @@ static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
>  
>      /* We have not started throttling yet. Let's start it. */
>      if (!cpu_throttle_active()) {
> +        qapi_event_send_migration_throttle();
>          cpu_throttle_set(pct_initial);
>      } else {
>          /* Throttling already on, just increase the rate */
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8b9c53595c..0495065b5d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1393,6 +1393,21 @@
>  { 'event': 'MIGRATION_PASS',
>    'data': { 'pass': 'int' } }
>  
> +##
> +# @MIGRATION_THROTTLE:
> +#
> +# Emitted from the source side of a migration at the start of vCPU throttle
> +#
> +# Since: 10.0
> +#
> +# Example:
> +#
> +# <- { "event": "MIGRATION_THROTTLE",
> +#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
> +#
> +##
> +{ 'event': 'MIGRATION_THROTTLE' }
> +
>  ##
>  # @COLOMessage:
>  #
> -- 
> 2.27.0
> 

-- 
Peter Xu


