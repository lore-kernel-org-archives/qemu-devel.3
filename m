Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC12D7878C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWcti-0001c1-By; Fri, 19 Dec 2025 11:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWctf-0001YO-47
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWctd-0001Qn-73
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766159999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBEQyTp/fMgIfZ3EEcRf1zJohu1FgDb1/+3ChxWDsKU=;
 b=BfVWSfHajCG/7NyLpqNMcdcZu/1sKPEwI0YWlj7FJjpfSGJC2yLtWTp3g0iV6lyeQBP6TW
 Eghwnyf0LPPiIgUWVlaNcIf3gVtHkKT0EO69+rKyTbIn3y360AM18vfDiclfWmwfYUcBgh
 oDaGLwR3mpIADjh0btAXsy6TUDUrhFA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-eGF80f5TNbij5GZM4DglNQ-1; Fri, 19 Dec 2025 10:59:58 -0500
X-MC-Unique: eGF80f5TNbij5GZM4DglNQ-1
X-Mimecast-MFC-AGG-ID: eGF80f5TNbij5GZM4DglNQ_1766159998
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8bc4493d315so490011685a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766159998; x=1766764798; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cBEQyTp/fMgIfZ3EEcRf1zJohu1FgDb1/+3ChxWDsKU=;
 b=G6lMWgCHUH/AhCnRxTKTwQsGfQ8+6eyTmDw5Sn/YhcLBfMYm/Uiglj5xhnxXfOKZsE
 bm1PrDSYHP5PRn8Fo18BLgu1GGLKfBBsuoHD07incJy9kbSuW9fa2EzXM1alhoweII/R
 AUgKY9/H8g/zS/whkaZJ35oeGMvQzpIMZpo+FjX2RaXjKIRIUhOhGRrNWwtfRcmJZLbn
 UgWteeoJv2hshCIJFIbhvwoR4Oa/V8NUikrvuksgfNI30cWqsgvtchoTfwh1jdanMBo4
 s4PV1h5SWy+wiSMrPE7nkW1mRHMNe3Fidp9IE5Leh/TAP7FGicrkPbj1ZDZtAjNg1Aff
 3dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766159998; x=1766764798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBEQyTp/fMgIfZ3EEcRf1zJohu1FgDb1/+3ChxWDsKU=;
 b=WstN8+6usjtZJGqxJUer6aZpcHe1/puJHyuEgzUurOaGXOJENJN5ghyn16wD5DPRgv
 wu6fMD3JRhPqdZLBigtj+OMjRZ5ZX9+10R/XO3aZXPk1KgbC5OKbJ/PByM7FA59DVtTh
 GRsYpURFxxm5KIvMqKY+1qOywMEYmbIgeWHbsUDCEV0uXsjZcNQhY553AadxamNW+gVl
 pv2g9ovSIRY1aiWcHEoe+h+7ieCz5sE44eshksEo97rtOkvYdbu+c0iO3ZSZNFHoE/Bw
 q/9KU+FjRfcDaQm/k49zmlbUyFz4lEPQJDbkk/uddlTPdu3b9q6B3fzCaYJ+/qg80hVw
 p7Yg==
X-Gm-Message-State: AOJu0YxSoqGWdIPpPP5dzeRaFl2IE6Luiikq4yrdHSnJDfd3qX4GYEN7
 FHqcWbbAuf8H+qNycEyQNFL7ToFV/qBgm/MSBghNEte9bkOCaYARb49AbOo97xJ2OPjGubIZyrV
 emnd9L6/mHvlm1NZgmnT+KT2AzpwnRGTQpjbi57C9KDkZs+zA9kGcFweM
X-Gm-Gg: AY/fxX7gc25UfFxLGcYnBlNshIjmctPlwsyZ3cG3P7ckUSPLyh6RiZhnXgiz1lXIWNr
 HWDkob68+NU3v7Vn3tyhWvPeRx3MrKMw0uIAIgljB1gI7Nf5Vmrwp5Rtmd/JaLTjf/Nx0cFiv0V
 a1Mr9hTHs6XKpafeNDJgNPBVDClYJQe6sOvhVyxd8EU2YK4dgIRFHIUVSKwrSBfcgumQ7jxWkHM
 W1q61IzhigzeJltTcS6MV4aFjCXexi5+XhbUVffqAmHnFCyQmhHOVHo78dA12oT+fkBKqHfj2lV
 6NOf0htBiVnsMPFFALJZYqob/QN0zAVv+387ScJKw0fc8lkJHssteUGFZY3MH2frsBCgjf9gE7y
 y5wk=
X-Received: by 2002:a05:620a:46a3:b0:8be:88e0:4722 with SMTP id
 af79cd13be357-8c08fa9f446mr508200785a.55.1766159997564; 
 Fri, 19 Dec 2025 07:59:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQPU+ZvnCFucJCbyG72BjoHohOymUAlLJ971TvwLV8BnyZKHtC/zJ/ALLL7s7FMGSOibYJfw==
X-Received: by 2002:a05:620a:46a3:b0:8be:88e0:4722 with SMTP id
 af79cd13be357-8c08fa9f446mr508196285a.55.1766159997031; 
 Fri, 19 Dec 2025 07:59:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968935b5sm211448685a.19.2025.12.19.07.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 07:59:56 -0800 (PST)
Date: Fri, 19 Dec 2025 10:59:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 44/51] tests/qtest/migration: Convert TLS PSK tests to
 use config
Message-ID: <aUV2e2-yGw1clMMl@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-45-farosas@suse.de>
 <aUR8u53VV3ezfFE0@x1.local> <87zf7fza1v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zf7fza1v.fsf@suse.de>
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

On Thu, Dec 18, 2025 at 07:42:36PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 15, 2025 at 07:00:30PM -0300, Fabiano Rosas wrote:
> >> Replace calls to migrate_set_parameters and the usage of args.caps
> >> with the new config object API.
> >> 
> >> The multifd tests are now the same as the "precopy" tests, only
> >> setting some multifd options, so reuse the precopy code.
> >> 
> >> Temporarily, set the use-config key to enable the new method.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration/tls-tests.c | 72 +++++++++----------------------
> >>  1 file changed, 20 insertions(+), 52 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> >> index abd6bf9281..68304a7af3 100644
> >> --- a/tests/qtest/migration/tls-tests.c
> >> +++ b/tests/qtest/migration/tls-tests.c
> >> @@ -73,9 +73,6 @@ static void *migrate_hook_start_tls_psk_common(QTestState *from,
> >>                               "                 'dir': %s } }",
> >>                               args->mismatch ? workdiralt : workdir);
> >>  
> >> -    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
> >> -    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
> >> -
> >>      return NULL;
> >>  }
> >>  
> >> @@ -121,6 +118,11 @@ static void test_precopy_tls_psk_common(MigrateCommon *args,
> >>  {
> >>      TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
> >>  
> >> +    /* temporary */
> >> +    qdict_put_bool(args->start.config, "use-config", true);
> >> +
> >> +    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
> >> +
> >>      migrate_tls_psk_init(args, test_args, data);
> >>      test_precopy_common(args);
> >>      migrate_tls_psk_cleanup(data);
> >> @@ -497,18 +499,11 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
> >>      test_precopy_tls_psk_common(args, &tls_psk_mismatch);
> >>  }
> >>  
> >> -static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
> >> -{
> >> -    migrate_set_parameter_null(from, "tls-creds");
> >> -    migrate_set_parameter_null(to, "tls-creds");
> >> -
> >> -    return NULL;
> >> -}
> >> -
> >>  static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
> >>  {
> >>      args->listen_uri = "tcp:127.0.0.1:0";
> >> -    args->start_hook = migrate_hook_start_no_tls;
> >> +
> >> +    qdict_put_null(args->start.config, "tls-creds");
> >>  
> >>      test_precopy_common(args);
> >>  }
> >> @@ -614,29 +609,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
> >>  
> >>      test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
> >>  }
> >> -#endif /* CONFIG_TASN1 */
> >>  
> >> -static void *
> >> -migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
> >> -                                             QTestState *to)
> >> -{
> >> -    migrate_set_parameter_str(from, "multifd-compression", "none");
> >> -    migrate_set_parameter_str(to, "multifd-compression", "none");
> >> -
> >> -    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_match);
> >> -}
> >> -
> >> -static void *
> >> -migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
> >> -                                                QTestState *to)
> >> -{
> >> -    migrate_set_parameter_str(from, "multifd-compression", "none");
> >> -    migrate_set_parameter_str(to, "multifd-compression", "none");
> >> -
> >> -    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_mismatch);
> >> -}
> >> -
> >> -#ifdef CONFIG_TASN1
> >>  static void *
> >>  migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
> >>                                                   QTestState *to)
> >> @@ -694,39 +667,34 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
> >>  
> >>  static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
> >>  {
> >> -    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
> >> -    args->listen_uri = "tcp:127.0.0.1:0";
> >> -
> >>      args->start.incoming_defer = true;
> >> -    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> >>  
> >> -    test_precopy_tls_psk_common(args, &tls_psk_match);
> >> +    qdict_put_str(args->start.config, "multifd-compression", "none");
> >> +    qdict_put_bool(args->start.config, "multifd", true);
> >> +
> >> +    test_precopy_tcp_tls_psk_match(name, args);
> >>  }
> >>  
> >>  static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
> >>  {
> >> -    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
> >> -    args->result = MIG_TEST_FAIL;
> >> -    args->listen_uri = "tcp:127.0.0.1:0";
> >> -
> >> -    args->start.hide_stderr = true;
> >>      args->start.incoming_defer = true;
> >> -    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> >>  
> >> -    test_precopy_tls_psk_common(args, &tls_psk_mismatch);
> >> +    qdict_put_str(args->start.config, "multifd-compression", "none");
> >
> > Why do we need to start set multifd-compression=none all the time
> > (including all below tests)?  Isn't that the default anyway?
> >
> 
> Because patch 43 removed the hook.
> 
> I haven't thought about it being default, I guess I can just remove it
> then.

Ah yes, you removed the start_hook which used to do it, I got tricked..  It
looks all fine.

-- 
Peter Xu


