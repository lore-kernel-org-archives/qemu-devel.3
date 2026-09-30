Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D77C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmYi-0000sn-Vg; Wed, 30 Sep 2026 01:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBmYP-0000sO-DC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:08:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBmY3-0004Zn-Uz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:08:11 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68U57nYd003389
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Sep 2026 14:07:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7QnTAUGzpOckXuul5bBLzqL4F9QI8jfA3Wh+5d0jkWc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790744869; v=1;
 b=b4EM0CCn6iwHAepO21AJOeF+xzGKQhpRBeXEV6bhp7PSrSvz/bK9JA6xerk8x+js
 Q1I37v3MceQ0QAS7sehfJu6XkbrDxiyvbbc//sz5aJU1DPPJFw2IIegSpQkxs9dB
 csT366iwwXk4PMnF26+4cQxecaqwPL4JGoM5RhyHEkECeK/yGHSBD5wj4vSZMYrM
 T/xmYZjopAlvniEcGH3oSTCNFRsorfI9AagilBwU/eUvFjE5e883E6Q+AMoM3x+9
 Bjt8F30hzUM+ZJGjpIkrA+cOU2KmMMg7MsDS1HBoS8YP80LXB74PNlARgrXlp6dN
 IfFkbUoTJ6qjYdITrEPCDg==
Message-ID: <b1c2dfb8-8e5d-4677-a97c-62e8f9e3164f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 30 Sep 2026 14:07:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/17] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/30 2:23, Andrey Drobyshev wrote:
> Snapshots are refused whenever a CPR migration mode is set.  Add a test
> which sets each of the CPR modes in turn and checks that 'savevm' and
> 'loadvm' fail with the corresponding error, then switches back to
> 'normal' mode and checks that the error is gone.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qtest/migration/cpr-tests.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 0bec753b4ab..2be0fc8c07e 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -290,6 +290,40 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>       test_cpr_exec(args);
>   }
>   
> +/* Snapshots must be refused while a CPR migration mode is set */
> +static void test_mode_no_snapshot(char *name, MigrateCommon *args)
> +{
> +    static const char *const modes[] = {
> +        "cpr-reboot", "cpr-transfer", "cpr-exec",
> +    };
> +    QTestState *vm = qtest_init("-nodefaults");

This omits -machine and fails on e.g., AArch64: QEMU exits with “No 
machine specified”, then qtest aborts waiting for its connection.

Regards,
Akihiko Odaki

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
> +    g_free(out);
> +
> +    qtest_quit(vm);
> +}
> +
>   void migration_test_add_cpr(MigrationTestEnv *env)
>   {
>       tmpfs = env->tmpfs;
> @@ -300,6 +334,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>           return;
>       }
>   
> +    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
> +
>       /*
>        * Our CI system has problems with shared memory.
>        * Don't run this test until we find a workaround.
> 


