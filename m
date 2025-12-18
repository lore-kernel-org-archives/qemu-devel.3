Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ED6D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMGd-0001H8-HV; Thu, 18 Dec 2025 17:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWMGW-0001Gp-IG
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWMGR-0006QG-IV
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766096064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bwDdH66VM5JfgZgulo57HsWJKPt71NnK+/2ffC8Jha4=;
 b=Z6jPVFylxEtkrdkMwnsdSDjIHzOeRo932MTnN6OQXCyhqji51aaCD7qStiYr0hlW0qJM6d
 y2Yws3NuV/+xnNlcIYSjwrhJO1pmitnAM2/1v0fwYFCiRePu0fWqHjV+fAy1vyHlbKFhUN
 smX2n4cP1TPE9iHUAPtirrZ9ctZd1mw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-PaQbW5ltN9iMZ0_bWQCB9Q-1; Thu, 18 Dec 2025 17:14:22 -0500
X-MC-Unique: PaQbW5ltN9iMZ0_bWQCB9Q-1
X-Mimecast-MFC-AGG-ID: PaQbW5ltN9iMZ0_bWQCB9Q_1766096062
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee16731ceaso21136191cf.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766096062; x=1766700862; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwDdH66VM5JfgZgulo57HsWJKPt71NnK+/2ffC8Jha4=;
 b=fb4GwqA3XO7/N8D4H9Aw6Sf0duKZa12fuVBEx13GDL2IhLShjjc4vi1t96PVyk4Ixv
 LIzPpr37EqUXtkjVpvZWp4I/DNFP/ZtpyVHa5OSAHPRuxharOOdOqf16nP0yWMvNTxBi
 4yaBuu19UDD6RhssSv1DS7PSdUyUz76OdrxbVJ9D9EqT/UpZS6gtog6UGPBVkN5JzAA5
 Fl42qiSYKcV8gDQ7IQJdo0HOpmFeLD4S1K87Ovu09V7hYIQflcmpekA7738miVUSvAyU
 mfQ9oUlSgZxwovkOmT1cHhHanVrxBuaOOVJZOf2UX5yKlD3PlIAPYGj4THJ3xrqfBARO
 KAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096062; x=1766700862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwDdH66VM5JfgZgulo57HsWJKPt71NnK+/2ffC8Jha4=;
 b=JZBfvF5KyCmgMsGr1PSOQlnHlTE4t6IdJky+u9Htlm4KpRPaxN/szo0UkPTYXaTlaV
 pyXAlpBcwiZA5tVAdkemEx4Fli5rAwO39YYxjbejPJB0iSSnY/ha2JeYmNsTzerTZND7
 W4iveaxoyJ2zNTnxAOxj4CNm1ungT6+gj460LlynxfqkM7TioRSiXrXgNQZtXMLj+B3w
 AOSRInrALY29xF2CIkp2Fp3FWORVD2psC9O32OtviQcILf6bSY8aWq7Eie9FV6VoK1zI
 EQK9CrArqUZlHyDGZVG5b0rP/dUwJG8crJYvXVyLT5T+BVL809IxjVtRCoU9zXRV3yHK
 VrYQ==
X-Gm-Message-State: AOJu0Yyiw20hnwBAcGstbXevpPLtnwwVZwH4IDyt2kuKuxiLMLB4SgKs
 vCpDnMSu3nnF/oybWnkPN7hqdZBYB4Ptu74uJdvCfrOKSkLW3CqioAHc6AVwwzPiiMnGl52y0P6
 /Ygr42smD6Tl8zm0bHpPNInm1NAv0194yl1p+1WCR3w6WTGEKnLjkF6O0
X-Gm-Gg: AY/fxX7cUISAf/XHsTYdcGNFPde84kzz34SrI8p/I2moflqlk/tW2fQ0NVFaM9n/UTb
 RtyP6bVbsGmC+Uz48pbIORdlAZOy0HBvP9gYGzajOalXn5ITWYVHwbK0qduW17QE/XbqqV3Y6c1
 CIpnuZ8xKuk2fv8adIdO/HhmFTSrtzwHSF66/wD0YXKNLO8MkkfhEwfaKSAlb2lXfMmn2wj/Yps
 eRWbJHiHKP1HgtvFrIOwxCJwuaWf/dujI/ywBzGbTvHkrHy0kWYPyv1WUfhgIjesDfxcoeK62Jg
 D6fsLGR8KVqwduVujEc1gv4/RcPBHTlt+iWB/S9/dnTypc1gJreNY0x245PZ+S9Mwb0kHhj1ixu
 on+Q=
X-Received: by 2002:a05:622a:24f:b0:4f1:ddda:9a26 with SMTP id
 d75a77b69052e-4f4abd122a3mr12901211cf.35.1766096061903; 
 Thu, 18 Dec 2025 14:14:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVq3SvTVAAiSaf2QCb1Gy1diAxvb8RrlP8A31mm9X567yblJIfqG1CCwCLV/XTFXXAukGw0A==
X-Received: by 2002:a05:622a:24f:b0:4f1:ddda:9a26 with SMTP id
 d75a77b69052e-4f4abd122a3mr12900851cf.35.1766096061375; 
 Thu, 18 Dec 2025 14:14:21 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac62fa56sm3364421cf.17.2025.12.18.14.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:14:20 -0800 (PST)
Date: Thu, 18 Dec 2025 17:14:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 44/51] tests/qtest/migration: Convert TLS PSK tests to
 use config
Message-ID: <aUR8u53VV3ezfFE0@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-45-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-45-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 07:00:30PM -0300, Fabiano Rosas wrote:
> Replace calls to migrate_set_parameters and the usage of args.caps
> with the new config object API.
> 
> The multifd tests are now the same as the "precopy" tests, only
> setting some multifd options, so reuse the precopy code.
> 
> Temporarily, set the use-config key to enable the new method.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/tls-tests.c | 72 +++++++++----------------------
>  1 file changed, 20 insertions(+), 52 deletions(-)
> 
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index abd6bf9281..68304a7af3 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -73,9 +73,6 @@ static void *migrate_hook_start_tls_psk_common(QTestState *from,
>                               "                 'dir': %s } }",
>                               args->mismatch ? workdiralt : workdir);
>  
> -    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
> -    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
> -
>      return NULL;
>  }
>  
> @@ -121,6 +118,11 @@ static void test_precopy_tls_psk_common(MigrateCommon *args,
>  {
>      TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
>  
> +    /* temporary */
> +    qdict_put_bool(args->start.config, "use-config", true);
> +
> +    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
> +
>      migrate_tls_psk_init(args, test_args, data);
>      test_precopy_common(args);
>      migrate_tls_psk_cleanup(data);
> @@ -497,18 +499,11 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
>      test_precopy_tls_psk_common(args, &tls_psk_mismatch);
>  }
>  
> -static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
> -{
> -    migrate_set_parameter_null(from, "tls-creds");
> -    migrate_set_parameter_null(to, "tls-creds");
> -
> -    return NULL;
> -}
> -
>  static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
>  {
>      args->listen_uri = "tcp:127.0.0.1:0";
> -    args->start_hook = migrate_hook_start_no_tls;
> +
> +    qdict_put_null(args->start.config, "tls-creds");
>  
>      test_precopy_common(args);
>  }
> @@ -614,29 +609,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
>  
>      test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
>  }
> -#endif /* CONFIG_TASN1 */
>  
> -static void *
> -migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
> -                                             QTestState *to)
> -{
> -    migrate_set_parameter_str(from, "multifd-compression", "none");
> -    migrate_set_parameter_str(to, "multifd-compression", "none");
> -
> -    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_match);
> -}
> -
> -static void *
> -migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
> -                                                QTestState *to)
> -{
> -    migrate_set_parameter_str(from, "multifd-compression", "none");
> -    migrate_set_parameter_str(to, "multifd-compression", "none");
> -
> -    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_mismatch);
> -}
> -
> -#ifdef CONFIG_TASN1
>  static void *
>  migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
>                                                   QTestState *to)
> @@ -694,39 +667,34 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
>  
>  static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
>  {
> -    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
> -    args->listen_uri = "tcp:127.0.0.1:0";
> -
>      args->start.incoming_defer = true;
> -    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>  
> -    test_precopy_tls_psk_common(args, &tls_psk_match);
> +    qdict_put_str(args->start.config, "multifd-compression", "none");
> +    qdict_put_bool(args->start.config, "multifd", true);
> +
> +    test_precopy_tcp_tls_psk_match(name, args);
>  }
>  
>  static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
>  {
> -    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
> -    args->result = MIG_TEST_FAIL;
> -    args->listen_uri = "tcp:127.0.0.1:0";
> -
> -    args->start.hide_stderr = true;
>      args->start.incoming_defer = true;
> -    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>  
> -    test_precopy_tls_psk_common(args, &tls_psk_mismatch);
> +    qdict_put_str(args->start.config, "multifd-compression", "none");

Why do we need to start set multifd-compression=none all the time
(including all below tests)?  Isn't that the default anyway?

> +    qdict_put_bool(args->start.config, "multifd", true);
> +
> +    test_precopy_tcp_tls_psk_mismatch(name, args);
>  }
>  
>  static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
>                                                      MigrateCommon *args)
>  {
> -    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
> -    args->listen_uri = "tcp:127.0.0.1:0";
> -
>      args->start.incoming_defer = true;
> -    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> -    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
>  
> -    test_precopy_tls_psk_common(args, &tls_psk_match);
> +    qdict_put_str(args->start.config, "multifd-compression", "none");
> +    qdict_put_bool(args->start.config, "multifd", true);
> +    qdict_put_bool(args->start.config, "postcopy-ram", true);
> +
> +    test_precopy_tcp_tls_psk_match(name, args);
>  }
>  
>  #ifdef CONFIG_TASN1
> -- 
> 2.51.0
> 

-- 
Peter Xu


