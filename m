Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BEAC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0ju-00076l-J7; Fri, 28 Feb 2025 08:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to0jq-00076F-Rl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:49:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to0jo-0005JE-PH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:49:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F74421166;
 Fri, 28 Feb 2025 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740750545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0DcOKRyX6RCorbU9Qp/m4gNpVnlzFI3j1//TYevXYE=;
 b=p9fjyw9T5aR4h9YCDDW0Kf29r4VDzYLGxtq/D4nFDqLmg8WMftKJkPW+3Iz/3nDLUUXfW3
 LqmHcw5TjURYifKE7ZHgp0oxFZ4leq0v86y2clL6Qsig3sDr5Ks0sR1dyXss1GI39qyO3c
 lTCSEHGfS+2wFm+flljyCjmHWwr0kdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740750545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0DcOKRyX6RCorbU9Qp/m4gNpVnlzFI3j1//TYevXYE=;
 b=74LT7SajghySrYIaEnZtCh1TvVfNGN/BjdKX6mAGbUzNF4/7U9O7FNg6y2B8QetcJSVcPY
 Aiq1DUimKh/5vMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740750545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0DcOKRyX6RCorbU9Qp/m4gNpVnlzFI3j1//TYevXYE=;
 b=p9fjyw9T5aR4h9YCDDW0Kf29r4VDzYLGxtq/D4nFDqLmg8WMftKJkPW+3Iz/3nDLUUXfW3
 LqmHcw5TjURYifKE7ZHgp0oxFZ4leq0v86y2clL6Qsig3sDr5Ks0sR1dyXss1GI39qyO3c
 lTCSEHGfS+2wFm+flljyCjmHWwr0kdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740750545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0DcOKRyX6RCorbU9Qp/m4gNpVnlzFI3j1//TYevXYE=;
 b=74LT7SajghySrYIaEnZtCh1TvVfNGN/BjdKX6mAGbUzNF4/7U9O7FNg6y2B8QetcJSVcPY
 Aiq1DUimKh/5vMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 116BC1344A;
 Fri, 28 Feb 2025 13:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oDi6L9C+wWfiJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Feb 2025 13:49:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian via <qemu-devel@nongnu.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 6/6] migration: Add qtest for migration over RDMA
In-Reply-To: <20250226063043.732455-7-lizhijian@fujitsu.com>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-7-lizhijian@fujitsu.com>
Date: Fri, 28 Feb 2025 10:49:02 -0300
Message-ID: <87ikou2n8x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Li Zhijian via <qemu-devel@nongnu.org> writes:

> This qtest requires there is a RDMA(RoCE) link in the host.
> In order to make the test work smoothly, introduce a
> scripts/rdma-migration-helper.sh to
> - setup a new Soft-RoCE(aka RXE) if it's root
> - detect existing RoCE link
>
> Test will be skipped if there is no available RoCE link.
>  # Start of rdma tests
>  # Running /x86_64/migration/precopy/rdma/plain
>  ok 1 /x86_64/migration/precopy/rdma/plain # SKIP
>  There is no available rdma link to run RDMA migration test.
>  To enable the test:
>  (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test

sudo scripts/rdma-migration-helper.sh setup
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test
--full -r /x86_64/migration/precopy/rdma/plain

# {
#     "error": {
#         "class": "GenericError",
#         "desc": "RDMA ERROR: rdma migration: error registering 0 control!"
#     }
# }

>  or
>  (2) Run the test with root privilege

This one works fine.

>
>  # End of rdma tests
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  MAINTAINERS                           |  1 +
>  scripts/rdma-migration-helper.sh      | 41 +++++++++++++++++
>  tests/qtest/migration/precopy-tests.c | 64 +++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100755 scripts/rdma-migration-helper.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3848d37a38d..15360fcdc4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3480,6 +3480,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
>  R: Peter Xu <peterx@redhat.com>
>  S: Odd Fixes
>  F: migration/rdma*
> +F: scripts/rdma-migration-helper.sh
>  
>  Migration dirty limit and dirty page rate
>  M: Hyman Huang <yong.huang@smartx.com>
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
> new file mode 100755
> index 00000000000..66557d9e267
> --- /dev/null
> +++ b/scripts/rdma-migration-helper.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +

I'd prefer a command -v rdma check around here. With the way the script
pipes commands into one another will cause bash to emit a couple of
"rdma: command not found" in case rdma command is not present.

> +# Copied from blktests
> +get_ipv4_addr()
> +{
> +    ip -4 -o addr show dev "$1" |
> +        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
> +        tr -d '\n'
> +}
> +
> +has_soft_rdma()
> +{
> +    rdma link | grep -q " netdev $1[[:blank:]]*\$"
> +}
> +
> +rdma_rxe_setup_detect()
> +{
> +    (
> +        cd /sys/class/net &&
> +            for i in *; do
> +                [ -e "$i" ] || continue
> +                [ "$i" = "lo" ] && continue
> +                [ "$(<"$i/addr_len")" = 6 ] || continue
> +                [ "$(<"$i/carrier")" = 1 ] || continue
> +
> +                has_soft_rdma "$i" && break
> +                [ "$operation" = "setup" ] &&
> +                    rdma link add "${i}_rxe" type rxe netdev "$i" && break
> +            done
> +        has_soft_rdma "$i" || return
> +        get_ipv4_addr "$i"
> +    )
> +}
> +
> +operation=${1:-setup}
> +
> +if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
> +    rdma_rxe_setup_detect
> +else
> +    echo "Usage: $0 [setup | detect]"
> +fi

What happened to the cleanup option? I think I missed some discussion on
this... We can't expect people to know how to clean this up without any
hint.

> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index ba273d10b9a..bf97f4e9325 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -99,6 +99,66 @@ static void test_precopy_unix_dirty_ring(void)
>      test_precopy_common(&args);
>  }
>  
> +#ifdef CONFIG_RDMA
> +
> +#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> +static int new_rdma_link(char *buffer)
> +{
> +    const char *argument = (geteuid() == 0) ? "setup" : "detect";
> +    char cmd[1024];
> +
> +    snprintf(cmd, sizeof(cmd), "%s %s", RDMA_MIGRATION_HELPER, argument);
> +
> +    FILE *pipe = popen(cmd, "r");

This needs to be silenced, otherwise messages from the script will break
TAP output. I suggest:

    bool verbose = g_getenv("QTEST_LOG");

    snprintf(cmd, sizeof(cmd), "%s %s %s", RDMA_MIGRATION_HELPER, argument,
             verbose ? "" : "2>/dev/null");

> +    if (pipe == NULL) {
> +        perror("Failed to run script");
> +        return -1;
> +    }
> +
> +    int idx = 0;
> +    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
> +        idx += strlen(buffer);
> +    }
> +
> +    int status = pclose(pipe);
> +    if (status == -1) {
> +        perror("Error reported by pclose()");
> +        return -1;
> +    } else if (WIFEXITED(status)) {
> +        return WEXITSTATUS(status);
> +    }
> +
> +    return -1;
> +}
> +
> +static void test_precopy_rdma_plain(void)
> +{
> +    char buffer[128] = {};
> +
> +    if (new_rdma_link(buffer)) {
> +        g_test_skip("\nThere is no available rdma link to run RDMA migration test.\n"
> +                    "To enable the test:\n"
> +                    "(1) Run \'" RDMA_MIGRATION_HELPER " setup\' with root and rerun the test\n"
> +                    "or\n"
> +                    "(2) Run the test with root privilege\n");

g_test_skip() needs a one-line message, otherwise it breaks TAP
output. You can turn this into a g_test_message(), put it under
QTEST_LOG=1 and add a g_test_skip("no rdma link available") below.

> +        return;
> +    }
> +
> +    /*
> +     * TODO: query a free port instead of hard code.
> +     * 29200=('R'+'D'+'M'+'A')*100
> +     **/
> +    g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
> +
> +    MigrateCommon args = {
> +        .listen_uri = uri,
> +        .connect_uri = uri,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +#endif
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -1124,6 +1184,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
> +#ifdef CONFIG_RDMA
> +    migration_test_add("/migration/precopy/rdma/plain",
> +                       test_precopy_rdma_plain);
> +#endif
>  }
>  
>  void migration_test_add_precopy(MigrationTestEnv *env)

