Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFF5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCejr-00010W-79; Thu, 30 May 2024 08:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sCejn-000108-RJ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:18:31 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sCejl-00054X-Cy
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=FRYuLk6xHyiy6h4Rc2gioCyPqIhggKP2nulH2gR4j3I=; b=in2vDQWAyI64WU57
 G1JBgMTIQRNqhj2L9QpmpZLV7A47yN90c08vBFuAAB0KsDdJ9Uypeixs/caofsaw+MV0YD7v7/ehk
 HFGbNJD4n6idm7XwssVwfqkIYALPwFerZW87hc60QxCGpq7lJ/nexLT2q905/pY0hp/N1m4GaOwbe
 8bkFm0dVXPMAF8fJMXMsu68mnaQajAe1/9EXgbLNV69t/ClpSrgegGwr22VahIffAfnwhA28BoxXA
 dgg3Wen1uDPNuIIVLDGTRemMIMtsk50ZUTWQdlWPdQrF3AQMsiu5KQ4/ahQh8aVZkbIlTc10VmIVz
 ZUYAwQggRM3CLJ2Nww==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sCeje-003MKk-33;
 Thu, 30 May 2024 12:18:22 +0000
Date: Thu, 30 May 2024 12:18:22 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH v2 3/4] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
Message-ID: <Zlhuju3qX8nTspaL@gallifrey>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240530095408.31608-4-npiggin@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:17:42 up 21 days, 23:31, 1 user, load average: 0.06, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Nicholas Piggin (npiggin@gmail.com) wrote:
> This test is already starting to bitrot, so first remove it from ifdef
> and fix compile issues. ppc64 transfers about 2MB, so bump the size
> threshold too.
> 
> It was said to be broken on aarch64 but it may have been due to the
> limited shm size under Gitlab CI. Now that it uses /tmp, enable it.

If it does fail, lets see if we can figure out how, i.e. whether it's the
shm size or something else.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/migration-test.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index de380757be..86eace354e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1855,8 +1855,6 @@ static void test_precopy_unix_tls_x509_override_host(void)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -#if 0
> -/* Currently upset on aarch64 TCG */
>  static void test_ignore_shared(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -1865,7 +1863,7 @@ static void test_ignore_shared(void)
>          .use_memfile = true,
>      };
>  
> -    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
> +    if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
>      }
>  
> @@ -1890,11 +1888,11 @@ static void test_ignore_shared(void)
>      wait_for_migration_complete(from);
>  
>      /* Check whether shared RAM has been really skipped */
> -    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
> +    g_assert_cmpint(read_ram_property_int(from, "transferred"), <,
> +                                                   4 * 1024 * 1024);
>  
>      test_migrate_end(from, to, true);
>  }
> -#endif
>  
>  static void *
>  test_migrate_xbzrle_start(QTestState *from,
> @@ -3535,7 +3533,8 @@ int main(int argc, char **argv)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
> +    migration_test_add("/migration/ignore_shared", test_ignore_shared);
> +
>  #ifndef _WIN32
>      migration_test_add("/migration/precopy/fd/tcp",
>                         test_migrate_precopy_fd_socket);
> -- 
> 2.43.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

