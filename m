Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6150CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBctH-0000O8-EQ; Tue, 29 Sep 2026 14:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBctF-0000Ns-O1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBctE-0002V3-3P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790707757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+vgwgCBTFU8SVZ/W77A0C1r3JhWh8dvQAXJf0woBnjk=;
 b=dyok0M01/6Rp3wVaf1t+8p6wcvCH8/TtWqa1EHZnK6vYwcUP5Afw6zs69jvN3rA+e5PzMD
 Qu1UW3gsAYOeSysdaXRMmejKo48Dug1pzSI96p8bR3r/1v5WikroSPq4dp8ajzwmexQ0G7
 1z1oNvLBlNo3kvPm/P1bSjQZZbQDEqE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-VJh0lwk3MVy6Rz4aPGoIUQ-1; Tue, 29 Sep 2026 14:49:16 -0400
X-MC-Unique: VJh0lwk3MVy6Rz4aPGoIUQ-1
X-Mimecast-MFC-AGG-ID: VJh0lwk3MVy6Rz4aPGoIUQ_1790707755
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so216953385a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790707755; x=1791312555; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+vgwgCBTFU8SVZ/W77A0C1r3JhWh8dvQAXJf0woBnjk=;
 b=SegW0w1S/843SH2CoE08gJ+Mmt28WP3Lr8deIXAEjAjWKtwLR/re92WKTgurwUEbpj
 jRAHa0/H5mz17pu12tOx9i7UZgxl5mCssls+XauHZ/wQbbnmyLisiyAQYcaX0iQr2a1m
 kxC9DlIOmsCQN+SKMShETk/etpxgkYy/GrcNTrVbGMYDaEVunRknZW9K9NwMrStQgUB5
 diEAGW4PBjelDMfLoIHW9zLf3KjUw8Q1eSKmtWb0dE83DqjtHh2RDeg/Lhj/Ygh4oQ0U
 +3h6z2mfazAVwK01tHbgUHW88Z6S5F8fmVVcf9XTdgLgecKJMYDw17aveiRi1tGV2W0l
 WJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790707755; x=1791312555;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vgwgCBTFU8SVZ/W77A0C1r3JhWh8dvQAXJf0woBnjk=;
 b=vuvNPRFGi7Zf/Qdk3Ah5LH+jk6MHbjiHoW77JEUtoPfOsfb29YtLRVfHcasfJTzuwF
 +Ilo6EKy9qHs2ScIEskvLHH/pT7W8cea40r1olMwhpA+XKpefd1ZZ3pSS8srjiSTVM+P
 cyJk4cilfbtU7nxUvfPxN/115jkDBsiyGyTqHCL0k71xB3l9gOMrn6nSJ0leYkN4NrVe
 NI7qUPFnprOKl82NNhWwItM/1tlYl++tJnLq5smeVMAB/CrraseReQnmUoXrlTgeO7Go
 WTalyeJ2PR3tdE/YQ/81ZfrAtKCuhF+GZWqr64dicuUhoyCUWktPV5BnG2exH7+8lyDE
 iXLA==
X-Gm-Message-State: AFuF++mE9xXOdUajZzzyXav6DgtkkahiRIxqyjtxxmgB+5pNWeeY3mKf
 /WmARUVmBwcPNRt2i0CZ/BlJcHsVvSNtzupCeUsQsVpCtbm4QOuGFzxmK8bcFGNTf5ujgJfZSt3
 msK5nDlmj+0H7inngaowBOtQfu3YWDu792f7oEuLsLIkmRnMD1OurJhib
X-Gm-Gg: AYBFou0V92EaMC8y7tIy6URKE7x8zZilrwZcnEt5oPmPViQHxlnr09xxxY7scKI3cSb
 EwZJ8cxBC3RPNIVtB8hTHBT8i818pzhgldemKLawEYlYwwElLDgz3saWZKnesxky8CPm5FI0l01
 W1c6zXoM7e42adERBf2aFPA6d5RSU8pJaNmqfOKZhsEBrqkhvpKrLNJBSG/B+xu8xVpf2Vk87Dg
 A8/lCJjg5Si36VMHmsEsXPo7gADyOsYF38ojCkWZ/LX17IemaYJBvjz+BzMs9UI36FRJjUZ6eLY
 nd9Ai0keLFdZ/dn1u8JWMUavfriaKDoyBneckBOPfh0zh1ZJ6dD6rT2eCeOyf2cCiez+Mdg=
X-Received: by 2002:a05:620a:bc8:b0:939:a8b4:8ae6 with SMTP id
 af79cd13be357-93c9f9db694mr84625385a.17.1790707755321; 
 Tue, 29 Sep 2026 11:49:15 -0700 (PDT)
X-Received: by 2002:a05:620a:bc8:b0:939:a8b4:8ae6 with SMTP id
 af79cd13be357-93c9f9db694mr84618685a.17.1790707754678; 
 Tue, 29 Sep 2026 11:49:14 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f4bfdd4sm35967985a.23.2026.09.29.11.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:49:14 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:49:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v8 05/17] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Message-ID: <arwIKeh92voz6Bhw@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Tue, Sep 29, 2026 at 08:23:24PM +0300, Andrey Drobyshev wrote:
> Snapshots are refused whenever a CPR migration mode is set.  Add a test
> which sets each of the CPR modes in turn and checks that 'savevm' and
> 'loadvm' fail with the corresponding error, then switches back to
> 'normal' mode and checks that the error is gone.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One thing to mention below..

> ---
>  tests/qtest/migration/cpr-tests.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 0bec753b4ab..2be0fc8c07e 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -290,6 +290,40 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>      test_cpr_exec(args);
>  }
>  
> +/* Snapshots must be refused while a CPR migration mode is set */
> +static void test_mode_no_snapshot(char *name, MigrateCommon *args)
> +{
> +    static const char *const modes[] = {
> +        "cpr-reboot", "cpr-transfer", "cpr-exec",
> +    };
> +    QTestState *vm = qtest_init("-nodefaults");
> +    char *out;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +        g_autofree char *expected = g_strdup_printf(
> +            "Snapshots are not compatible with migration mode %s", modes[i]);
> +
> +        migrate_set_parameter_str(vm, "mode", modes[i]);
> +
> +        out = qtest_hmp(vm, "savevm snap");
> +        g_assert_nonnull(strstr(out, expected));
> +        g_free(out);
> +
> +        out = qtest_hmp(vm, "loadvm snap");
> +        g_assert_nonnull(strstr(out, expected));
> +        g_free(out);
> +    }
> +
> +    /* Back in normal mode the mode check no longer fires */
> +    migrate_set_parameter_str(vm, "mode", "normal");
> +    out = qtest_hmp(vm, "savevm snap");
> +    g_assert_null(strstr(out, "not compatible with migration mode"));

What it looks like is it tries one more time with normal mode then a
snapshot should be correctly taken.  In reality, behavior with current
qtest_init():

{"return": "Error: no block device can store vmstate for snapshot\r\n"}

So yes, the check is working, but slightly obscure on what is expected to
happen.  Maybe worth a comment if there's a repost.  It also answers why
there's no "snap" snapshot leftover not cleaned up.

> +    g_free(out);
> +
> +    qtest_quit(vm);
> +}
> +
>  void migration_test_add_cpr(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -300,6 +334,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>          return;
>      }
>  
> +    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
> +
>      /*
>       * Our CI system has problems with shared memory.
>       * Don't run this test until we find a workaround.
> 
> -- 
> 2.47.1
> 

-- 
Peter Xu


