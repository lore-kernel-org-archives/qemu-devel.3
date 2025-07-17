Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF25FC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQhI-00063r-J6; Thu, 17 Jul 2025 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucOif-0004CQ-9z
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucOia-0005S6-RQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752759131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eNBVz6pyTzXbqUirtLvfILjSOroKFt9aKYasabteA/k=;
 b=EkUDrXenhBP/pt6+Zwng3A5inGndPpHrsKblLuWx0L7vf011vuyL6+Z5yuKByqUDA142zp
 YeWuZPB9WOun7y/6UlZa5ui4/IS3hFSbsf8dkhhqjhCOB9QyMA4yLLHPdr52EO1i3SAYAT
 mgpi0qhhZ1ZEqy6DqIFr2niPEj+gKV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-qUCEYu6sMISrP6Sh0mWk6w-1; Thu,
 17 Jul 2025 09:32:05 -0400
X-MC-Unique: qUCEYu6sMISrP6Sh0mWk6w-1
X-Mimecast-MFC-AGG-ID: qUCEYu6sMISrP6Sh0mWk6w_1752759124
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FF018001D4; Thu, 17 Jul 2025 13:32:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BCB61956089; Thu, 17 Jul 2025 13:32:02 +0000 (UTC)
Date: Thu, 17 Jul 2025 14:31:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
Message-ID: <aHj7Ti_uzPv2Qshx@redhat.com>
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715124552.28038-2-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 15, 2025 at 09:45:51AM -0300, Fabiano Rosas wrote:
> Coverity has caught a bug in the formatting of time intervals for
> postcopy latency distribution display in 'info migrate'.
> 
> While bounds checking the labels array, sizeof is incorrectly being
> used. ARRAY_SIZE is the correct form of obtaining the size of an
> array.
> 
> Fixes: 3345fb3b6d ("migration/postcopy: Add latency distribution report for blocktime")
> Resolves: Coverity CID 1612248
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index cef5608210..bb954881d7 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -57,11 +57,9 @@ static const gchar *format_time_str(uint64_t us)
>      const char *units[] = {"us", "ms", "sec"};
>      int index = 0;
>  
> -    while (us > 1000) {
> +    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
>          us /= 1000;
> -        if (++index >= (sizeof(units) - 1)) {
> -            break;
> -        }
> +        index++;
>      }
>  
>      return g_strdup_printf("%"PRIu64" %s", us, units[index]);

It occurrs to me that this is the same basic algorithmic problem as
converting storage sizes from bytes to KB/MB/GB/etc.

We have size_to_str() which  does this conversion without needing any
loop at all.

Then there is freq_to_str() which has similar purpose but still uses
a loop, instead of the shortcut size_to_str has.

IMHO we should have a 'scaled_int_to_str' method that is common to
any place we need such scaled integer string conversions, and then
wrappers like  "size_to_str", "freq_to_str" and "duration_to_str"
that pass in the required list of unit strings, and the divisor
and requested decimal precision, etc.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


