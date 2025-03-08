Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB7EC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 06:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqnEb-0006YH-Eo; Sat, 08 Mar 2025 01:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqnEZ-0006Xg-Qt
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:00:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqnEX-00008n-N0
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:00:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-391342fc148so839500f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 22:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741413624; x=1742018424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpYPg8mAkESvm8njY8TLL50K+gnM+q6KVMRyTY2NOl8=;
 b=cUeMo8a6ny1qtpVUbRYYHsGx7B22v78lmZh7MkvaC+dlYm6XYilyq/Jxbp9G+5080q
 fQ3gtS4k6nY9UjXeYtOTqXJmXhLHieLB42qdlTXBx54ooflPPyq+5CtRyUbUnYFRINd5
 b8r4GDij3ZLZOSfbAv++8k62Dll6v4GCn0UncsphPZbUCZ6uJYvz80zHUKTHsHEzbB+U
 FK/Fqe/kdY2k8K0gsjYU5I/KujNmf7Ln7JLzv8Pt254KOU5BHEOedTGnY58rfC/D4wXK
 sl3+HRXvWdZygzOd2WlEI1g09GWWGN/dqNijng7+Ki0ZwjScpVeUMYkhHE6H7m5Y0gn6
 parg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741413624; x=1742018424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rpYPg8mAkESvm8njY8TLL50K+gnM+q6KVMRyTY2NOl8=;
 b=mDAlL0CsrAeQ91rWa453M6e+Uq7IfhdeXSrb6RVcfKCQry0REXnPDrvx70yMB6ZBSx
 bDjmCwgwRNU9rnbHxXrr3u9K62tgHtuqrsaO4Pu84v4N2mg5dbpksS+xdpRMs97IU7C2
 1dYSEtae88QMH5Zqbjb+ARYBMqj0D6OK1PK8MFx9Ugu4nekejvAsHdHBFXtjl53cwjeu
 cNb/x4PhwqJMz7uTeUZi28hv9q9aT0M/GPasLTtyq/8/GXm6XmhZrMdqCKgF8+TMSuWj
 ofdg8zRh5T2Yy1TUvM7OYdwM64YbMXck5qWWJ2w/bSAnaqWMGJ1+2tKDAzgNWqRPOaen
 pFUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE5Us3j+IByQs52ojooinDCm/0NZRMERGnzFTteRD4W8ME5ZEKt1ZcAz/AHyznaA0hdSnHvhQSw0Nd@nongnu.org
X-Gm-Message-State: AOJu0YyCTZtFc2UFtX5x/kqpH2kcqwB08uzpuIyCotEE8c6lQ7yeT7wG
 YorvGgyKu4P2YveLHY3aSZlku1n724I5it41b18wfeOv2ZND6laF2i7rfFiOCUYeRT9Yd0skqlJ
 MCwg=
X-Gm-Gg: ASbGncuKp9yCSU315qPYfy+H9oqosJvYc1ai4fZip+wHXYUhLTrNXg1P0kcae4Wh2sF
 Z0OyKQppx3mbClEspw8Za6R9nGHWQgnUBpB3u1a+BK0K5GERTouw7PdZ7oo/+MILzgjt6Jg+aFL
 /vQzYvhNEVh/oMiuoRiQIPn3+sB1mDAvtsI6ZYhWOW8ErwcXt/fD2s6/Sh3HZZh8vj/n7zupES9
 osH6xPpBv9OzP3Tf3C8X3mJZesUrhf/IxjmMJgEwI9g2iwcAVxgWjoXorJIDeNrKz1r2YBT5Esn
 jLGoQzGZ69WkuqPRBdZVEn+Qvj34W5cZJvdTn4hbijNhKqiv9A4Wa1XUECTs3K1gq7NUQwSnDwd
 IMLOunsYIxDLf
X-Google-Smtp-Source: AGHT+IFKV9feeoXmxiYCF+OVz1eib4K90HY95QAvxCy6GyfnC+s+O39GYi5e2bLjJNXq/5UbYAn48A==
X-Received: by 2002:a5d:5846:0:b0:390:efe7:20fa with SMTP id
 ffacd0b85a97d-39132de1bd2mr3008331f8f.47.1741413623658; 
 Fri, 07 Mar 2025 22:00:23 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c019557sm7917247f8f.50.2025.03.07.22.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 22:00:22 -0800 (PST)
Message-ID: <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
Date: Sat, 8 Mar 2025 07:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 8/8] migration: Add qtest for migration over RDMA
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-9-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307181551.19887-9-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

On 7/3/25 19:15, Fabiano Rosas wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> This qtest requires there is a RDMA(RoCE) link in the host.
> In order to make the test work smoothly, introduce a
> scripts/rdma-migration-helper.sh to
> - setup a new Soft-RoCE(aka RXE) if it's root
> - detect existing RoCE link
> 
> Test will be skipped if there is no available RoCE link.

Is it? Runing as user I'm getting:

   RDMA ERROR: RDMA host is not set!

Apparently called via:

qemu_start_incoming_migration()
   -> rdma_start_incoming_migration()
      -> qemu_rdma_dest_init()

>   # Start of rdma tests
>   # Running /x86_64/migration/precopy/rdma/plain
>   Command 'rdma' is not available, please install it first.
>   # To enable the test:
>   # (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test
>   # or
>   # (2) Run the test with root privilege

Could this might be the issue, should we skip if not root, as calling
the script in "detect" mode makes the new_rdma_link() method to succeed.

>   #
>   ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link available
>   # End of rdma tests
> 
> Note: Remove the newly added RXE link by executing 'modprobe -r rdma_rxe'
> or by specifying 'clean' within this script.

qtest_add() provides both setup() / teardown() methods.

Test leaving system in different state seems bogus to me.
More even if the information is buried in a commit description...

We shouldn't merge this patch as is IMHO.

Regards,

Phil.

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Message-ID: <20250305062825.772629-7-lizhijian@fujitsu.com>
> [reformated the message to be under 90 characters]
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   MAINTAINERS                           |  1 +
>   scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
>   tests/qtest/migration/precopy-tests.c | 69 +++++++++++++++++++++++++++
>   3 files changed, 118 insertions(+)
>   create mode 100755 scripts/rdma-migration-helper.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5df6020ed5..56e85adcfb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3517,6 +3517,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
>   R: Peter Xu <peterx@redhat.com>
>   S: Odd Fixes
>   F: migration/rdma*
> +F: scripts/rdma-migration-helper.sh
>   
>   Migration dirty limit and dirty page rate
>   M: Hyman Huang <yong.huang@smartx.com>
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
> new file mode 100755
> index 0000000000..08e29a52eb
> --- /dev/null
> +++ b/scripts/rdma-migration-helper.sh
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +
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
> +command -v rdma >/dev/null || {
> +    echo "Command 'rdma' is not available, please install it first." >&2
> +    exit 1
> +}
> +
> +if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
> +    rdma_rxe_setup_detect
> +elif [ "$operation" == "clean" ]; then
> +    modprobe -r rdma_rxe
> +else
> +    echo "Usage: $0 [setup | detect | clean]"
> +fi
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index ba273d10b9..f1fe34020d 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -99,6 +99,71 @@ static void test_precopy_unix_dirty_ring(void)
>       test_precopy_common(&args);
>   }
>   
> +#ifdef CONFIG_RDMA
> +
> +#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> +static int new_rdma_link(char *buffer, bool verbose)
> +{
> +    const char *argument = (geteuid() == 0) ? "setup" : "detect";
> +    char cmd[1024];
> +
> +    snprintf(cmd, sizeof(cmd), "%s %s %s", RDMA_MIGRATION_HELPER, argument,
> +             verbose ? "" : "2>/dev/null");
> +
> +    FILE *pipe = popen(cmd, "r");
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
> +    bool verbose = g_getenv("QTEST_LOG");
> +
> +    if (new_rdma_link(buffer, verbose)) {
> +        g_test_skip("No rdma link available");
> +        if (verbose) {
> +            g_test_message(
> +                "To enable the test:\n"
> +                "(1) Run \'" RDMA_MIGRATION_HELPER
> +                " setup\' with root and rerun the test\n"
> +                "or\n(2) Run the test with root privilege");
> +        }
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
>   static void test_precopy_tcp_plain(void)
>   {
>       MigrateCommon args = {
> @@ -1124,6 +1189,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>                          test_multifd_tcp_uri_none);
>       migration_test_add("/migration/multifd/tcp/plain/cancel",
>                          test_multifd_tcp_cancel);
> +#ifdef CONFIG_RDMA
> +    migration_test_add("/migration/precopy/rdma/plain",
> +                       test_precopy_rdma_plain);
> +#endif
>   }
>   
>   void migration_test_add_precopy(MigrationTestEnv *env)


