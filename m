Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B86C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SyC-000142-Gq; Fri, 04 Sep 2026 08:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2SyB-00012j-0i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Sy9-0000Ep-2U
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788524670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lvvb1j6cIdK8CqlZOpzUplsTLYOdSAVskczGJOqt/4U=;
 b=RGjJ3V6NZoJDjvsDPUQBcLsap1UJ2RCG2C/rHSNbCVTh9pTMNpuHl/kpeNBk9d48v8QIq1
 SAECIM7vtN0U73RmZX5zk9E+YKKFE/ImtgPnfNqKolN/cPDPfJPluhxFIZuHufhrt+6r9t
 4hsaT7JnZEffWruYoKNGGB9vhfkupRo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Ne-ttKlzNgi65D2dA7Iudg-1; Fri, 04 Sep 2026 08:24:29 -0400
X-MC-Unique: Ne-ttKlzNgi65D2dA7Iudg-1
X-Mimecast-MFC-AGG-ID: Ne-ttKlzNgi65D2dA7Iudg_1788524668
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-910342dc2cfso11722446d6.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788524668; x=1789129468; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lvvb1j6cIdK8CqlZOpzUplsTLYOdSAVskczGJOqt/4U=;
 b=tglxQVNeRr9rAq/8gTSdjB7PlAb32FZhU08ZW9vTjrEE5Kbmde+JegCiQnHe0CVX8X
 0ldHsbfXBGv/wBXAggO0ciF7yfilwRSeSn7w1rXnQD8Aw+KMLshvxERPGilds2mtsHZo
 2Fh40w/XOumVaEwA9/or2QbGaMsOxmZZQqCW2zPOVzF4yIq58JvCwn06V0RH/z12LlSg
 65GGDP9geJKpZLaqMnK61V6J2WYmPa7kGsbogz7UfPUdDq0FjhAWagLU6NT8kfa8t0yf
 8QAfHuAUotbh5dc8OApmRNoE6yFwUaD9OZRcS7Ogg7H61MiOr69rZMUr7ftt+Xs6ZxN3
 Ojkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524668; x=1789129468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lvvb1j6cIdK8CqlZOpzUplsTLYOdSAVskczGJOqt/4U=;
 b=ck7c99misFJHTqtitdSAp5WlFCF+q4V0ujBOAoQlQaXiRtGh++r8qSKDTlBj6WPpAM
 RK9/Fsh/7zMbETzVDSuxy/or5bleojF19wSkAJaxazvHDJzHhhYS8Lwu5mmSvrXP2MX1
 bKEsE9sTGXI81FoPKa9K+kMzRya0K5KvW4NlfdpeDaTGuSZcfqqHkP9ABBqpNu6CgQ+p
 t9eE904iMvh8foEQbebLCCygQdvVXpo9jK+vbTv0r8bShSphbG8A6eXrNPMpp9CXqa8o
 BCL0Io3SnssQb2yBprk1T6iBCm5TYzmXYdlPEbm6pLVH7ha+/yZ7OsHI6TsUWUFMZ95r
 lxxw==
X-Gm-Message-State: AFuF++nZvrwRKD+W9XcKlK4S4cMz6bzktwTg4yQbe/plDi2IgrvFxJAU
 fyA02yvceZos1XYGfZ1mAinN6vFhr6MgOXPSDyHRVTSTSHN89mw5ydVdo/a2nEJgrqxNaaJgRy1
 Vy7RPoD7ekZNSbTobSib46yE4EMX1P2pa80A+MVy7tqJs6NbIZ33oUs1V
X-Gm-Gg: AYBFou1DI4Rkb8VlpTMm1Mh7ss20TwpmFhPwPhKlR/LNzr8DW9gFnt1pMMTIj7fF3f+
 1f7N/p0RNQd31rpIVgNIOBpMB5SNvzA/cKBCisnnyWGnXhNnEaAr7k4vvdP1l004Txq5w5UW4cf
 F1/7EzlmxdVdJpj/f43YEjtLtMebC5BK9TpafVsdv+gRSzDlctCTa7sVYeLBUN6mXh0wqKCKxuu
 TPc8vurLbgKnBpHOrw1z9Bt47smaKn6zx2xJJ22eOvIsz9fV/R377YDggwzrhi+v5UbXr2l2fpb
 d2sCuLDn40DusNVzduJ+uBHXDc5MPRsih7YkMnKAl2pGZII04i8E1yvHr/6Hp4gYyoY8
X-Received: by 2002:ad4:5d69:0:b0:910:321e:2ebb with SMTP id
 6a1803df08f44-9103eeee20bmr65673156d6.8.1788524668437; 
 Fri, 04 Sep 2026 05:24:28 -0700 (PDT)
X-Received: by 2002:ad4:5d69:0:b0:910:321e:2ebb with SMTP id
 6a1803df08f44-9103eeee20bmr65672536d6.8.1788524667802; 
 Fri, 04 Sep 2026 05:24:27 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910464bf898sm352576d6.7.2026.09.04.05.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:24:27 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:24:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 15/18] qapi/migration: Remove MigrationParameter
Message-ID: <apq4cH0QTHoAG4-m@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 02, 2026 at 07:15:43PM -0300, Fabiano Rosas wrote:
> This enum is convenient in two ways (just how enums work):
> 
> 1- It provides the number of migration parameters as its __MAX member.
> 
> 2- It allows iterating over an integer range and get a migration
>    parameter name string corresponding to that position in the enum.
> 
> The migration code doesn't have the need for (2) anymore.
> 
> Balancing the benefit of (1) versus the disadvantage of requiring
> migration.json to be updated in two different places whenever a
> parameter is added, experience shows that the latter churn is enough
> to decide to remove the enum.

I may have a slightly different feeling, but that takes a few things into
account, (1) we don't have issue duplicating docs for the two parameter
names anymore, (2) the dup is only about adding the same string once more
in qapi/, (3) we now have this migrate_mark_all_params_present() function
that must set all has_* fields, which the __MAX did help to guard a bit..

I think it's also fine to remove it completely, we just need to be more
careful instead on migrate_mark_all_params_present() later.  Which one is
easier to be forgotten?  I don't know..

Acked-by: Peter Xu <peterx@redhat.com>

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c |  6 +-----
>  qapi/migration.json | 36 ------------------------------------
>  2 files changed, 1 insertion(+), 41 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 5d17acdd881..f988b181f0e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1127,7 +1127,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
>   */
>  static void migrate_mark_all_params_present(MigrationParameters *p)
>  {
> -    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
>      bool *has_fields[] = {
>          &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
>          &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
> @@ -1144,10 +1143,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>          &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>      };
>  
> -    len = ARRAY_SIZE(has_fields);
> -    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
> -
> -    for (int i = 0; i < len; i++) {
> +    for (int i = 0; i < ARRAY_SIZE(has_fields); i++) {
>          *has_fields[i] = true;
>      }
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b1eaf7b0545..78c6e933cf1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -796,42 +796,6 @@
>        'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>    } }
>  
> -##
> -# @MigrationParameter:
> -#
> -# Migration parameters enumeration.  The enumeration values mirror the
> -# members of @MigrationParameters.
> -#
> -# Features:
> -#
> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> -#     @x-vcpu-dirty-limit-period are experimental.
> -#
> -# Since: 2.4
> -##
> -{ 'enum': 'MigrationParameter',
> -  'data': ['announce-initial', 'announce-max',
> -           'announce-rounds', 'announce-step',
> -           'throttle-trigger-threshold',
> -           'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'cpu-throttle-tailslow',
> -           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> -           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> -           'multifd-channels',
> -           'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level', 'multifd-zstd-level',
> -           'multifd-qatzip-level',
> -           'block-bitmap-mapping',
> -           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
> -           'vcpu-dirty-limit',
> -           'mode',
> -           'zero-page-detection',
> -           'direct-io',
> -           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> -           'cpr-exec-command'] }
> -
>  ##
>  # @migrate-set-parameters:
>  #
> -- 
> 2.53.0
> 

-- 
Peter Xu


