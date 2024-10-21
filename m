Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4754DD1712A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2y4i-0004mh-Mv; Mon, 21 Oct 2024 15:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2y4h-0004mW-DG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2y4e-00088d-Kt
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729538895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X98Z595kI5lo4x47X1tRFuVxXIilxUW+2m35/lEKFsY=;
 b=H0Dg8tvP5YnEwk5MmBMuZ6hYLplb9yVq0udakOOhx6k0/xMzjSxaGACaqY1XlpC7EXc7aq
 zUr4D9JsjXSKO0mqbJJYEs8ejZppQCOaluFxp5F8YhGLaSLpzK0og+62S9kmBvL7kgm14L
 wCOxsukYNJGkmE8ZvtgzUPbb3bTEeao=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-zhhXITcQMxyBVFNVVDAg4g-1; Mon, 21 Oct 2024 15:28:13 -0400
X-MC-Unique: zhhXITcQMxyBVFNVVDAg4g-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-50d5732d0c7so1054515e0c.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729538893; x=1730143693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X98Z595kI5lo4x47X1tRFuVxXIilxUW+2m35/lEKFsY=;
 b=mQcWgad/eI17uQVLqqvA8I1SU6YIa1L9kU1wMYTB2v2lGgLb8ffVv9TtmWdEbJh8aw
 mMGJOZibcYRwP4f1t10tzh0miqDV/0+4GBBXDCWv0O/CnBAE5U8QYxiQBMdGUaWVFMN3
 NdLbXTvYDiffmcmqYmnhiJltIa8naB4pvxOausXHmayl7OF1QTgYT1RRx5blnQJ86Y6J
 qWT8A4O3T2hCvtQX/vVYOV9AsS6LbgsoDWP59605KMlTU3+ULoEWj1PiWzikZfyyHUhY
 EJr8bQ054RvifWYIaBRJ0Oyjub0y0bNdhR9dQkbHlfkJeweRxiuuZaCFat6oJkzyfLhg
 UTzA==
X-Gm-Message-State: AOJu0Yxs8pl7RAmoEMGf4XlI+keUFGaNRiUIG6gWPD0Jau0tBIPfng9J
 ocQw/3iQ6JDlcMq+/M0XbEFvl/1YkThvPjD3mtl6VaGb3NaI2usZmasLFD7ysYomuzsYtaNqVqB
 1pnfLUDhWN0oXBnaen4rdxBH7oxIi/0erSqEPNv/K0PG9rXmIZSD/
X-Received: by 2002:a05:6122:3d0f:b0:50d:4aa2:fa16 with SMTP id
 71dfb90a1353d-50dda3aaef6mr9353711e0c.12.1729538893272; 
 Mon, 21 Oct 2024 12:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHu2c5FgNYQVVmBwK0+Xa3Q/NHwYSlzkHw1KJ2N1NHpxmpIiwBxMV3+h+9z2XxPp6XEyj8wQ==
X-Received: by 2002:a05:6122:3d0f:b0:50d:4aa2:fa16 with SMTP id
 71dfb90a1353d-50dda3aaef6mr9353678e0c.12.1729538892756; 
 Mon, 21 Oct 2024 12:28:12 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c526sm199582185a.78.2024.10.21.12.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 12:28:12 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:28:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 11/14] monitor: connect in precreate
Message-ID: <ZxarSUBGD7LpK_v6@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Thu, Oct 17, 2024 at 08:14:12AM -0700, Steve Sistare wrote:
> Complete monitor connections as early as possible, prior to
> qemu_create_early_backends, so the user can issue commands during the
> precreate phase.
> 
> Make a list of the chardev's referenced by all monitors.  Create the
> chardevs, then create the monitors.  Exclude monitor chardevs and
> monitors from the later creation phases.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/vl.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 3c592b9..a985ab8 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1939,6 +1939,11 @@ static bool object_create_early(const ObjectOption *opt)
>          return false;
>      }
>  
> +    /* Reason: already created. */
> +    if (g_str_equal(type, "mon")) {
> +        return false;
> +    }

Why monitor are part of "object"s?  I thought it was only registered on
qemu_find_opts("mon").

Same question to object_create_late() below.

> +
>      return true;
>  }
>  
> @@ -1956,6 +1961,68 @@ static void qemu_apply_machine_options(QDict *qdict)
>      }
>  }
>  
> +typedef struct NamedElement {
> +    char *name;
> +    QTAILQ_ENTRY(NamedElement) next;
> +} NamedElement;
> +
> +static QTAILQ_HEAD(, NamedElement) monitor_chardevs =
> +    QTAILQ_HEAD_INITIALIZER(monitor_chardevs);
> +
> +static void chardev_add(const char *name)
> +{
> +    NamedElement *elem = g_new0(NamedElement, 1);
> +
> +    elem->name = g_strdup(name);
> +    QTAILQ_INSERT_TAIL(&monitor_chardevs, elem, next);
> +}
> +
> +static bool chardev_find(const char *name)
> +{
> +    NamedElement *elem;
> +
> +    QTAILQ_FOREACH(elem, &monitor_chardevs, next) {
> +        if (g_str_equal(elem->name, name)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static int monitor_add_chardev(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    g_autofree char *chardev = NULL;
> +    int ret = monitor_chardev_name(opts, &chardev, errp);
> +
> +    if (!ret && chardev) {
> +        chardev_add(chardev);
> +    }
> +    return ret;
> +}
> +
> +static bool option_is_monitor_chardev(void *opaque, QemuOpts *opts)
> +{
> +    return chardev_find(qemu_opts_id(opts));
> +}
> +
> +static bool option_is_not_monitor_chardev(void *opaque, QemuOpts *opts)
> +{
> +    return !chardev_find(qemu_opts_id(opts));
> +}
> +
> +static void qemu_create_monitors(void)

Would be good to add some generic comment on why monitors' chardev can be
created earlier before the rest.

PS: I'm not yet sure this is required for the initial support for
cpr-transfer, as there's no chardev fds involved yet?  IOW, I am curious
what happens if this code init all chardevs instead of monitor-only.

> +{
> +    qemu_opts_foreach(qemu_find_opts("mon"),
> +                      monitor_add_chardev, NULL, &error_fatal);
> +
> +    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
> +                      option_is_monitor_chardev,
> +                      chardev_init_func, NULL, &error_fatal);
> +
> +    qemu_opts_foreach(qemu_find_opts("mon"),
> +                      mon_init_func, NULL, &error_fatal);
> +}
> +
>  static void qemu_create_early_backends(void)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
> @@ -1994,7 +2061,8 @@ static void qemu_create_early_backends(void)
>      /* spice must initialize before chardevs (for spicevmc and spiceport) */
>      qemu_spice.init();
>  
> -    qemu_opts_foreach(qemu_find_opts("chardev"),
> +    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
> +                      option_is_not_monitor_chardev,
>                        chardev_init_func, NULL, &error_fatal);
>  
>  #ifdef CONFIG_VIRTFS
> @@ -2020,6 +2088,11 @@ static void qemu_create_early_backends(void)
>   */
>  static bool object_create_late(const ObjectOption *opt)
>  {
> +    /* Reason: already created. */
> +    if (g_str_equal(ObjectType_str(opt->opts->qom_type), "mon")) {
> +        return false;
> +    }
> +
>      return !object_create_early(opt) && !object_create_pre_sandbox(opt);
>  }
>  
> @@ -2045,9 +2118,6 @@ static void qemu_create_late_backends(void)
>          exit(1);
>      }
>  
> -    qemu_opts_foreach(qemu_find_opts("mon"),
> -                      mon_init_func, NULL, &error_fatal);
> -
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>          exit(1);
>      if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
> @@ -3730,6 +3800,9 @@ void qemu_init(int argc, char **argv)
>  
>      accel = configure_accelerators(argv[0]);
>  
> +    os_setup_signal_handling();

Didn't immediately see why this line.  Some explanations / comments could
be helpful..

> +    qemu_create_monitors();
> +
>      /*
>       * QOM objects created after this point see all global and
>       * compat properties.
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


