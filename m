Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A444C3600C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 06:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txgYW-0005jl-3I; Thu, 27 Mar 2025 02:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgYK-0005bE-MS
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:17:28 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgYI-0001CK-Pa
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:17:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e8484bb895so174420a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1743056233; x=1743661033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuuFwtGc1wTJWNiUSfx5FQotQNBfT7OLPUZMWsgQFMQ=;
 b=frpHvh6lnDGSEDOH5HnvBhNbffmHRHlZ0vX9mO7eYN6nJsL6wl4K0fhIaGcBmzPOqI
 +q5bpm66NXPsAMLbb+e9kBetMMi1LabDVYVWyz8kaS/77282DSKHD3oU4QPjyPSFKB0v
 n3+ICwpTY8vSSHSnxIalUWz+fqCdKMfC8J42db9SN1SBs09UFA8PM1HBURaZtbz4outF
 s6Pks4tZH3pWCTfu3A3K5cv5j+T2F7wQeTUw2T/2CS1FTYR1jGimdtgg/IpQWh6Q6Gl2
 nEI6gMGyWnY3grVq2STkslKIIecCoRI1AZeLeoP/nqsoUOXlgujYz6Vjoev3PRjzTRJD
 S08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743056233; x=1743661033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuuFwtGc1wTJWNiUSfx5FQotQNBfT7OLPUZMWsgQFMQ=;
 b=L3S7y/4ZNzlp+Z+wyCAheP+iNyIP6Rfq9/VbOpHSi4XQRtl+EhsuMLpyZkedAo3hFJ
 GlEtqJ9n0t/SF6h4aV6s6epteWt3YHH8Sj9lM93P8Qbw2289oxdIo3LxpSF5urPUM1Hj
 ifw/PY+onY+sMyhlj8lB3fZpkL2+3L2gBo3Ar0pUX4TEmkNG4cqX69hwGe5ou6R2qjg9
 PYJr/zOJr3aCbZTU/kIVcbJ1r+MdoxFxfS6/FE8HD0/ic3vQlN/vdITNmh1Ml9nOR7b+
 JUIKyGvtlpKRQ1APGPaD3t1QvkORikfbt5Q2DXv/J+qqmLBtPxCASX4Cyk7MhJ4JF72O
 6G5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU55ikWmH/0pwADZRz28EF76iqsmaR3b45bOkwkKgSpORHC4IvIs7BFerhZV3SP8UhRFiw0ZRYET/pZ@nongnu.org
X-Gm-Message-State: AOJu0YyZDsU4N/Eho+fVQ05AD4RrOvnSVO6jXzG4w9JTKbHXMXCqVUe2
 HWjdG09y7oWwFeW82AkMIp/ymRPDSxYxVQE3gO7bnw1pgMRPI/ZTOoKU1Ju6++55bsaOcD7iYPV
 NEhurQ0feq1ICWyhaYj9NLUhkCSdGDJoTR/VB4Q==
X-Gm-Gg: ASbGncvpdW0HIoT/O5hgHIg9HvBdca0F9DsSqXKQtlyLW4SMBot4ZqdKshCt5tq2SEb
 +YkRvXadMJFRAR1afoNHMfCNCNXpHE24u5KBvDbnXJoknDtf+Xfqt5R9xDskKjRG11CsqQaTN5M
 vuT1MmBKXvYedMQjeL9Io+nBTXV/5kML70RzJCHHqKzoSXQtJNRu+m137D6Gg=
X-Google-Smtp-Source: AGHT+IGPFGl76L560cGnRaa3wRJb/H551LjYMZuKS8FOM/NzEuGsLiso+fOqtUI7gIttSKNMhOQNlOgpMryT9Nwc2dI=
X-Received: by 2002:a05:6402:254f:b0:5eb:ce29:8ed9 with SMTP id
 4fb4d7f45d1cf-5eda03dc6a7mr549581a12.2.1743056233486; Wed, 26 Mar 2025
 23:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
In-Reply-To: <20250327021234.264161-1-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 27 Mar 2025 07:17:02 +0100
X-Gm-Features: AQ5f1JphZgONRFo5KrKkpK4U6CHUgJ4IvWrIsQF8kTQCqsRDf52ZOTviu1DOyrI
Message-ID: <CAMGffEnNCDH28ozggR+NUSk2Lu5qYysKf3Hctb-8bNLw0F0eiQ@mail.gmail.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::533;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 27, 2025 at 3:13=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> Recently, we removed ipv6 restriction[0] from RDMA migration, add a
> test for it.
>
> [0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@i=
onos.com/
>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi Zhijian,

Thx for adding the tests. lgtm.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>
> This test is added based on [1]
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/rdma-migration-helper.sh      | 26 +++++++++++++++++++++++---
>  tests/qtest/migration/precopy-tests.c | 21 +++++++++++++++++----
>  2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-he=
lper.sh
> index 019b9ad932..c358392b72 100755
> --- a/scripts/rdma-migration-helper.sh
> +++ b/scripts/rdma-migration-helper.sh
> @@ -8,6 +8,15 @@ get_ipv4_addr()
>          head -1 | tr -d '\n'
>  }
>
> +get_ipv6_addr() {
> +    ipv6=3D$(ip -6 -o addr show dev "$1" |
> +        sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/=
p' |
> +        head -1 | tr -d '\n')
> +
> +    [ $? -eq 0 ] || return
> +    echo -n ["$ipv6"%$1]
> +}
> +
>  # existing rdma interfaces
>  rdma_interfaces()
>  {
> @@ -20,11 +29,16 @@ ipv4_interfaces()
>      ip -o addr show | awk '/inet / {print $2}' | sort -u | grep -v -w lo
>  }
>
> +ipv6_interfaces()
> +{
> +    ip -o addr show | awk '/inet6 / {print $2}' | sort -u | grep -v -w l=
o
> +}
> +
>  rdma_rxe_detect()
>  {
>      for r in $(rdma_interfaces)
>      do
> -        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
> +        "$IP_FAMILY"_interfaces | grep -qw $r && get_"$IP_FAMILY"_addr $=
r && return
>      done
>
>      return 1
> @@ -32,11 +46,11 @@ rdma_rxe_detect()
>
>  rdma_rxe_setup()
>  {
> -    for i in $(ipv4_interfaces)
> +    for i in $("$IP_FAMILY"_interfaces)
>      do
>          rdma_interfaces | grep -qw $i && continue
>          rdma link add "${i}_rxe" type rxe netdev "$i" && {
> -            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_add=
r $i)"
> +            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_"$IP_FAM=
ILY"_addr $i)"
>              return
>          }
>      done
> @@ -50,6 +64,12 @@ rdma_rxe_clean()
>      modprobe -r rdma_rxe
>  }
>
> +IP_FAMILY=3D${IP_FAMILY:-ipv4}
> +if [ "$IP_FAMILY" !=3D "ipv6" ] && [ "$IP_FAMILY" !=3D "ipv4" ]; then
> +    echo "Unknown ip family '$IP_FAMILY', only ipv4 or ipv6 is supported=
," >&2
> +    exit 1
> +fi
> +
>  operation=3D${1:-detect}
>
>  command -v rdma >/dev/null || {
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migratio=
n/precopy-tests.c
> index a137ea9f2c..9f7236dc59 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -102,12 +102,13 @@ static void test_precopy_unix_dirty_ring(void)
>  #ifdef CONFIG_RDMA
>
>  #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> -static int new_rdma_link(char *buffer)
> +static int new_rdma_link(char *buffer, bool ipv6)
>  {
>      char cmd[256];
>      bool verbose =3D g_getenv("QTEST_LOG");
>
> -    snprintf(cmd, sizeof(cmd), "%s detect %s", RDMA_MIGRATION_HELPER,
> +    snprintf(cmd, sizeof(cmd), "IP_FAMILY=3D%s %s detect %s",
> +             ipv6 ? "ipv6" : "ipv4", RDMA_MIGRATION_HELPER,
>               verbose ? "" : "2>/dev/null");
>
>      FILE *pipe =3D popen(cmd, "r");
> @@ -132,11 +133,11 @@ static int new_rdma_link(char *buffer)
>      return -1;
>  }
>
> -static void test_precopy_rdma_plain(void)
> +static void test_precopy_rdma_plain_ip(bool ipv6)
>  {
>      char buffer[128] =3D {};
>
> -    if (new_rdma_link(buffer)) {
> +    if (new_rdma_link(buffer, ipv6)) {
>          g_test_skip("No rdma link available\n"
>                      "# To enable the test:\n"
>                      "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root=
 to setup"
> @@ -159,6 +160,16 @@ static void test_precopy_rdma_plain(void)
>
>      test_precopy_common(&args);
>  }
> +
> +static void test_precopy_rdma_plain(void)
> +{
> +    test_precopy_rdma_plain_ip(0);
> +}
> +
> +static void test_precopy_rdma_plain_ipv6(void)
> +{
> +    test_precopy_rdma_plain_ip(1);
> +}
>  #endif
>
>  static void test_precopy_tcp_plain(void)
> @@ -1189,6 +1200,8 @@ static void migration_test_add_precopy_smoke(Migrat=
ionTestEnv *env)
>  #ifdef CONFIG_RDMA
>      migration_test_add("/migration/precopy/rdma/plain",
>                         test_precopy_rdma_plain);
> +    migration_test_add("/migration/precopy/rdma/plain/ipv6",
> +                       test_precopy_rdma_plain_ipv6);
>  #endif
>  }
>
> --
> 2.41.0
>

