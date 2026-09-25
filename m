Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79469C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA37r-00025u-M5; Fri, 25 Sep 2026 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA37j-00025I-0G
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA37g-00023M-N4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790331943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=npPA1H08eVsX1lnx4AgDcO9T+0jOpOqvDj2LUq2fff8=;
 b=HvBoXRwxI61Zu8LyZrCkAaAbOgAjVJYa0KzO1ccKZSIiTxiHGe9njEF8NjpFwY2zVR3uqj
 BRMYueBhVMIiciueLXF5g0rErvEPuAjEyWfOQAzg5pQJdxol31hxf12EGhXuVEi0VFbu5C
 I0zep6TlgVhgZ/pxANJTaTYPVWtMRKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-j04ru2oMPDeEUov9Ep6znw-1; Fri,
 25 Sep 2026 06:25:40 -0400
X-MC-Unique: j04ru2oMPDeEUov9Ep6znw-1
X-Mimecast-MFC-AGG-ID: j04ru2oMPDeEUov9Ep6znw_1790331939
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA471800674; Fri, 25 Sep 2026 10:25:38 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1201956047; Fri, 25 Sep 2026 10:25:34 +0000 (UTC)
Date: Fri, 25 Sep 2026 11:25:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 08/14] qemu-options: Add qemu_opts_parse_list_noisily
Message-ID: <arZMHEVA1XavV2I1@redhat.com>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918223002.1892021-9-farosas@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 18, 2026 at 07:29:55PM -0300, Fabiano Rosas wrote:
> Add a wrapper similar to qemu_opts_parse_list() with the same
> objective, to free the non _list version,
> i.e. qemu_opts_parse_noisily() to be converted to receive the group
> name.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/monitor/block-hmp-cmds.c       |  2 +-
>  include/qemu/option.h                |  2 ++
>  monitor/hmp.c                        |  2 +-
>  net/net.c                            |  2 +-
>  qemu-img.c                           | 10 +++++-----
>  qemu-io-cmds.c                       |  2 +-
>  qemu-io.c                            |  7 ++++---
>  qemu-nbd.c                           |  6 +++---
>  storage-daemon/qemu-storage-daemon.c |  4 ++--
>  system/qdev-monitor.c                |  2 +-
>  system/tpm.c                         |  2 +-
>  system/vl.c                          |  6 +++---
>  tests/unit/test-replication.c        |  6 +++---
>  tools/qemu-vnc/qemu-vnc.c            |  2 +-
>  util/qemu-option.c                   | 14 ++++++++++++++
>  15 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 7bae4d425c..cbd64166ec 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -63,7 +63,7 @@ static void hmp_drive_add_node(MonitorHMP *hmp, const char *optstr)
>      QDict *qdict;
>      Error *err = NULL;
>  
> -    opts = qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
> +    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, optstr, false);
>      if (!opts) {
>          return;
>      }
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index dfe0d9b893..df68da9aa8 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -134,6 +134,8 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
>                            bool permit_abbrev, Error **errp);
>  QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
>                                 bool permit_abbrev, Error **errp);
> +QemuOpts *qemu_opts_parse_list_noisily(QemuOptsList *list, const char *params,
> +                                       bool permit_abbrev);
>  QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
>                                 Error **errp);
>  QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,


This is adding a new function and not removing an existnig function, but....

> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 488ec23937..fc32cfd1ff 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -897,7 +897,7 @@ static QDict *monitor_parse_arguments(MonitorHMP *mon,
>                  if (get_str(buf, sizeof(buf), &p) < 0) {
>                      goto fail;
>                  }
> -                opts = qemu_opts_parse_noisily(opts_list, buf, true);
> +                opts = qemu_opts_parse_list_noisily(opts_list, buf, true);
>                  if (!opts) {
>                      goto fail;
>                  }

...then the patch changes alot of callers to the new
function, which wasn't mentioned in the commit message.

Did you accidentally squash two patches together ? I'd
suggest the conversion of callers should be separate.

> diff --git a/qemu-img.c b/qemu-img.c
> index 2f63d31141..4996618a4e 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -161,7 +161,7 @@ static OutputFormat parse_output_format(const char *argv0, const char *arg)
>   * an odd number of ',' (or else a separating ',' following it gets
>   * escaped), or be empty (or else a separating ',' preceding it can
>   * escape a separating ',' following it).
> - * 
> + *
>   */
>  static bool is_valid_option_list(const char *list)
>  {

Extraneous change


> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index c8e552823b..c762eb20a3 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -971,6 +971,20 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>      return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
>  }
>  
> +/**
> + * Create a QemuOpts in @list and with options parsed from @params.
> + * If @permit_abbrev, the first key=value in @params may omit key=,
> + * and is treated as if key was @list->implied_opt_name.
> + * Report errors with error_report_err().  This is inappropriate in
> + * QMP context.  Do not use this function there!
> + * Return the new QemuOpts on success, null pointer on error.
> + */
> +QemuOpts *qemu_opts_parse_list_noisily(QemuOptsList *list, const char *params,
> +                                       bool permit_abbrev)
> +{
> +    return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
> +}

I guess this is why you moved the error reporting in the previous
patch. Personally I'd skip the previous patch and accept the
small duplicate code pattern between the two "noisily" methods.

> +
>  static bool qemu_opts_from_qdict_entry(QemuOpts *opts,
>                                         const QDictEntry *entry,
>                                         Error **errp)
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


