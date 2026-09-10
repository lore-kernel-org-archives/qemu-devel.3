Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5214EC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4en5-0000kz-LD; Thu, 10 Sep 2026 09:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x4en1-0000ki-Br
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:26:07 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x4emz-0002s8-8k
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=zvvV8Ur1jBKnm5UOkDyVH7FZzuyNSzHY6H5Ncglqjow=; b=o0xxFukBq+RsUDXv
 xjjWv6jeNuwTAdh4fv8KgPZkHWqt6JR3ulfQBbIsh7TZCeS49sjbifoXmS5P5q/RltEjLX+NYW39x
 I1hE4TEt4u7/Y0X1NhwqZBjt10i+O+7PeBtwlZ/GXk/Iscsx4JEHU79+ghxzJWtLgwR0MovSZSkTW
 55jgBfzY4uMHtn9oPp01QY0n4l63vxopOLOC8VaUdXFr9q4tv9pi6JPUiPCcWklAlZiT0Djc6qKsS
 acLucQ38LEbYJ3yUlOWpNq9+xmd4gBjSaKgOvnsictO1n2CLnQRC9kblfAgtWp58r4YR1f+mPhGLP
 n+9B4Ycd8k3N4lI/zA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x4emw-00000003vXu-0Ou4;
 Thu, 10 Sep 2026 13:26:02 +0000
Date: Thu, 10 Sep 2026 13:26:02 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/18] migration: HMP: Fix bandwidth parameters
Message-ID: <aqKv6rlfrbye-7y2@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-12-farosas@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 13:24:06 up 11 days, 14:45,  2 users,  load average: 0.07, 0.06, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Fabiano Rosas (farosas@suse.de) wrote:
> The max-bandwidth and avail-switchover-bandwidth parameters are
> declared as bytes/second in migration.json and interpreted as such
> throughout the code, except in HMP where they're expected to be
> provided as mebibytes.
> 
> Fix the HMP code to parse the values as bytes.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Makes sense, and shockingly, it means that 'max-bandwidth' and 'max-postcopy-bandwidth'
now have the same units!

Please point this out in the release changelog.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  migration/migration-hmp-cmds.c     | 23 +++--------------------
>  tests/qtest/migration/misc-tests.c |  4 ++--
>  2 files changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 27b38d0e5f..67ea2eea15 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -596,10 +596,9 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
>      const char *valuestr = qdict_get_str(qdict, "value");
>      Visitor *v = string_input_visitor_new(valuestr);
>      MigrationParameters *p = g_new0(MigrationParameters, 1);
> -    uint64_t valuebw = 0;
>      uint64_t cache_size;
>      Error *err = NULL;
> -    int val, ret;
> +    int val;
>  
>      val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
>      if (val < 0) {
> @@ -644,27 +643,11 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
>          break;
>      case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>          p->has_max_bandwidth = true;
> -        /*
> -         * Can't use visit_type_size() here, because it
> -         * defaults to Bytes rather than Mebibytes.
> -         */
> -        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
> -        if (ret < 0 || valuebw > INT64_MAX
> -            || (size_t)valuebw != valuebw) {
> -            error_setg(&err, "Invalid size %s", valuestr);
> -            break;
> -        }
> -        p->max_bandwidth = valuebw;
> +        visit_type_size(v, param, &p->max_bandwidth, &err);
>          break;
>      case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
>          p->has_avail_switchover_bandwidth = true;
> -        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
> -        if (ret < 0 || valuebw > INT64_MAX
> -            || (size_t)valuebw != valuebw) {
> -            error_setg(&err, "Invalid size %s", valuestr);
> -            break;
> -        }
> -        p->avail_switchover_bandwidth = valuebw;
> +        visit_type_size(v, param, &p->avail_switchover_bandwidth, &err);
>          break;
>      case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
>          p->has_downtime_limit = true;
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 04f46d5e81..447fa5e232 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -62,8 +62,8 @@ HMPTestData test_cases[] = {
>      TEST("announce-rounds", "6", "6"),
>      TEST("announce-step", "15", "15 ms"),
>      TEST("downtime-limit", "400", "400 ms"),
> -    TEST("avail-switchover-bandwidth", "2097152", "2199023255552 bytes/second"),
> -    TEST("max-bandwidth", "9876543", "10356305952768 bytes/second"),
> +    TEST("avail-switchover-bandwidth", "2097152", "2097152 bytes/second"),
> +    TEST("max-bandwidth", "9876543", "9876543 bytes/second"),
>      TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
>      TEST("vcpu-dirty-limit", "20", "20 MB/s"),
>      TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

