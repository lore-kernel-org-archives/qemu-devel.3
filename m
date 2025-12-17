Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A368BD6409B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtXf-00010h-3Z; Wed, 17 Dec 2025 10:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVtXe-00010X-0a
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVtXc-0005SA-AE
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765985655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLcS9FRj2VudVCi+SYAbkNN55lgSuO6Dk8Gf2gicwHg=;
 b=I2+e7gS0kDHm9BELl/0PqUC/sTPs1GPZw64iKSaZ5T9+jFYMO3t3izxFS0LLDYUmoZQbbJ
 rPWcxTAFaEqRyC4zKbbTa49Aog3pxPMfy3zly8QvAhhW852VzYbwlcI6uottuBndLl2NxU
 aknNqZloqBK23rzWQA5yjEiKZHWUHFE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-ZI1pHyt1MNqW41b9CgeSWQ-1; Wed, 17 Dec 2025 10:34:14 -0500
X-MC-Unique: ZI1pHyt1MNqW41b9CgeSWQ-1
X-Mimecast-MFC-AGG-ID: ZI1pHyt1MNqW41b9CgeSWQ_1765985653
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7c7957d978aso6170903b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765985653; x=1766590453; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zLcS9FRj2VudVCi+SYAbkNN55lgSuO6Dk8Gf2gicwHg=;
 b=AMuP8y6Rb65ZcGsB13VLrCBWrcdnnV7Rl1dMTI+r4mZpdxNf6al++7pGCpWOqFP/Wa
 i4Po2mhN45+YVzEECMaul12AGJTB8+URWHc97x8952uTd5cyWYtnYMAvSQdcnoKwrymg
 ShnGhaw4TjDbSvf0uHILm04uMYkTZMMWzz2XhPa3tDbaulwt+VCKh1ePwZZsB8M3o1dX
 +H7p4VolbSbXJraJ7FN4BXZ1D+4WEaRmnnPShpx79Q3lARtmObI7F4nTkjm0FSqQ6fp0
 60AKq+fd82mKl74Gv66DXMnXOd03tApsq7bG3zZZXju0MN6JJ714h1hXvepwmrx41Dlp
 GUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765985653; x=1766590453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLcS9FRj2VudVCi+SYAbkNN55lgSuO6Dk8Gf2gicwHg=;
 b=CTANbyK+LwBAqMZGqK/cvfUhsR/DMmfQj2tYWLmS7CI0O0j2wTgBGpVZ1Pncqure3p
 0W/TnRrTjZJ7DWI0geN1BDyIk3h/NRBGlLq5RaQUtbkybWno84cDlvSNRgU2bWzgySPa
 UlRWwNkcVWrTdKFJcjt+uDR7PM5gsw5Ys9VYAEbm7wd9n2v2tBE5z9KSRbM8zI/teGbc
 /fHanYnrXtHOUnl4y8IZK9yjOF9guo86sU1n2SK5M/wK3vPvhzLth+W5elicHt1NLTvZ
 iAgIP6Cgg08at3KgPVatSeYi/Y6ffSt6U9mwi0WPQWYj5iVu33gqG2lVhVTKkWOJLz2T
 A6gQ==
X-Gm-Message-State: AOJu0YxrYpmSB9p6UFcGht1yFXqRqI3UfJr+kBBEy2jNeY71AVqJbYYR
 HCDc2yiXyn4bnM5OWPibOWJ/jywTFZZ0sWEzJal1LrwuNSlIx7SdwyTni1+6TuTnP+d4VURTote
 RTCCRoFDgHSPCFbQw/EIXGMTRJon//XII7/QL9RmuMyLzzpTejRsJSTwh
X-Gm-Gg: AY/fxX71igLw8G+VNGA/fGEUaYDMdUBpHXIw9z4CUaxK2oszBB4P5NoJx34BFSQosg5
 Ns4HEiWzxOTwnsZi8l7+JNDVh9i4L6/yCpbV9vQjjPn1NZegNX6PzWZFizWLXGqxCg3XERI1AK+
 iyRF/sEuV7CdKkfS1XHZbslLw9ZRRU49UQnahe9JtLSwSytBzL+UFctbGBLGfHMjn0ykHFgNeGY
 fmzaaVrp49UzrOXUz9DA9gtYhG4H3T+8y/UaljjyUdJG9LsESRNrVU9rX5I2u/JnAgOycnuK2nf
 WHeIe/syn7n3JicEa1yC9zVFLj0SRsfpHVkuDhdQ+vTq8YPWo9fBydosotv/pC4PfE51l5+Y+dc
 J0s4=
X-Received: by 2002:a05:6a00:6ca4:b0:7ac:69cd:ea0d with SMTP id
 d2e1a72fcca58-7f667d182afmr15477463b3a.19.1765985652843; 
 Wed, 17 Dec 2025 07:34:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdIoUBvAzXpgPyv7XinpL/hCs1b2E2B+wwQTbKNUD2lP1HooSL8DxPzUPW4LgLUZ+9jOxRcA==
X-Received: by 2002:a05:6a00:6ca4:b0:7ac:69cd:ea0d with SMTP id
 d2e1a72fcca58-7f667d182afmr15477436b3a.19.1765985652392; 
 Wed, 17 Dec 2025 07:34:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcb8b2f66dsm3105751b3a.15.2025.12.17.07.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 07:34:11 -0800 (PST)
Date: Wed, 17 Dec 2025 10:34:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 24/51] migration: Allow incoming cmdline to take config
Message-ID: <aULNbapP47hK1ApN@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-25-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 15, 2025 at 07:00:10PM -0300, Fabiano Rosas wrote:
> When -incoming "defer" is not used, the incoming migration is invoked
> directly by the command line parsing code in vl.c. Allow the migration
> config to be passed via the -incoming command line option so that
> invocation of qmp_migrate_incoming() can receive it.
> 
> E.g.
> -incoming '{"tls-creds": "tlscredsx509server0", "tls-hostname": "qemu.org"}'
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> This is useful for the tests. If we want to declare that
> config-passing only works with -incoming defer, that's fine with me.

This can also be done with -global migration.xxx, right?  Except that
-global can also work for either src or dest, I thought that was a bonus as
more flexible.

Maybe I overlooked some reasons from testing side?..

> ---
>  system/vl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 12 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index d09dc9a61c..ac44933a11 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -169,6 +169,9 @@ static const char *mem_path;
>  static const char *incoming;
>  static const char *incoming_str[MIGRATION_CHANNEL_TYPE__MAX];
>  static MigrationChannel *incoming_channels[MIGRATION_CHANNEL_TYPE__MAX];
> +static MigrationParameters *migration_config;
> +static Error *migration_channel_err;
> +static Error *migration_config_err;
>  static const char *loadvm;
>  static const char *accelerators;
>  static bool have_custom_ram_size;
> @@ -1825,28 +1828,102 @@ static void object_option_add_visitor(Visitor *v)
>      QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>  }
>  
> -static void incoming_option_parse(const char *str)
> +/*
> + * Either "defer" or a proper uri, whether plain string or a json
> + * representation of MigrationChannel.
> + */
> +static bool incoming_option_parse_channels(const char *str, Error **errp)
>  {
>      MigrationChannelType type = MIGRATION_CHANNEL_TYPE_MAIN;
> -    MigrationChannel *channel;
> +    MigrationChannel *channel = NULL;
>      Visitor *v;
>  
> -    if (!strcmp(str, "defer")) {
> -        channel = NULL;
> -    } else if (migrate_is_uri(str)) {
> +    if (g_str_equal(str, "defer")) {
> +        incoming_str[type] = str;
> +        return true;
> +    }
> +
> +    if (migrate_is_uri(str)) {
>          migrate_uri_parse(str, &channel, &error_fatal);
>      } else {
>          v = qobject_input_visitor_new_str(str, "channel-type", &error_fatal);
> -        visit_type_MigrationChannel(v, NULL, &channel, &error_fatal);
> +        if (v && !visit_type_MigrationChannel(v, NULL, &channel, errp)) {
> +            visit_free(v);
> +            return false;
> +        }
>          visit_free(v);
> +    }
> +
> +    if (channel) {
>          type = channel->channel_type;
> +        /* New incoming spec replaces the previous */
> +        qapi_free_MigrationChannel(incoming_channels[type]);
> +        incoming_channels[type] = channel;
> +        incoming_str[type] = str;
>      }
>  
> -    /* New incoming spec replaces the previous */
> -    qapi_free_MigrationChannel(incoming_channels[type]);
> -    incoming_channels[type] = channel;
> -    incoming_str[type] = str;
>      incoming = incoming_str[MIGRATION_CHANNEL_TYPE_MAIN];
> +    return true;
> +}
> +
> +/*
> + * The migration configuration object in JSON form.
> + */
> +static bool incoming_option_parse_config(const char *str, Error **errp)
> +{
> +    MigrationParameters *config = NULL;
> +    Visitor *v;
> +
> +    v = qobject_input_visitor_new_str(str, "config", &error_fatal);
> +    if (v && !visit_type_MigrationParameters(v, NULL, &config, errp)) {
> +        visit_free(v);
> +        return false;
> +    }
> +
> +    if (config) {
> +        /* later incoming configs replace the previous ones */
> +        migration_config = config;
> +    }
> +
> +    visit_free(v);
> +    return true;
> +}
> +
> +static void incoming_option_parse(const char *str)
> +{
> +    /*
> +     * Independent Error objects because we don't know whether the
> +     * input is meant to be the channels or the config. The parsing
> +     * may fail for one and succeed for the other.
> +     */
> +    g_autoptr(Error) channel_err = NULL;
> +    g_autoptr(Error) config_err = NULL;
> +
> +    /*
> +     * Skip if there's already an error for a previous -incoming
> +     * instance.
> +     */
> +    if (migration_channel_err || migration_config_err) {
> +        return;
> +    }
> +
> +    if (!migration_channel_err &&
> +        incoming_option_parse_channels(str, &channel_err)) {
> +        return;
> +    }
> +
> +    if (!migration_config_err &&
> +        incoming_option_parse_config(str, &config_err)) {
> +        return;
> +    }
> +
> +    if (channel_err) {
> +        migration_channel_err = error_copy(channel_err);
> +        error_prepend(&migration_channel_err, "-incoming %s: ", str);
> +    } else if (config_err) {
> +        migration_config_err = error_copy(config_err);
> +        error_prepend(&migration_config_err, "-incoming %s: ", str);
> +    }
>  }
>  
>  static void object_option_parse(const char *str)
> @@ -2537,6 +2614,16 @@ static void qemu_validate_options(const QDict *machine_opts)
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (migration_channel_err && !incoming) {
> +        error_report_err(migration_config_err);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (migration_config_err && !migration_config) {
> +        error_report_err(migration_config_err);
> +        exit(EXIT_FAILURE);
> +    }
> +
>  #ifdef CONFIG_CURSES
>      if (is_daemonized() && dpy.type == DISPLAY_TYPE_CURSES) {
>          error_report("curses display cannot be used with -daemonize");
> @@ -2824,13 +2911,14 @@ void qmp_x_exit_preconfig(Error **errp)
>  
>      if (incoming) {
>          Error *local_err = NULL;
> +
>          if (strcmp(incoming, "defer") != 0) {
>              g_autofree MigrationChannelList *channels =
>                  g_new0(MigrationChannelList, 1);
>  
>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> -            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
> -                                 &local_err);
> +            qmp_migrate_incoming(NULL, true, channels, migration_config, true,
> +                                 true, &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);
> -- 
> 2.51.0
> 

-- 
Peter Xu


