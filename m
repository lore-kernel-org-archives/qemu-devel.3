Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B46CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvF1-00026X-Sr; Wed, 03 Jul 2024 04:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOvF0-00025z-Qy
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOvEy-0001wk-Hq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719994883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1sG4L3J3FTDnrOeRQB8NOiQhJruRWxrKbkhF+QWfjI=;
 b=MuAwnV9Vz0S0fqqNQDkILsAuLLMyLyHHRV1H0c3XbIzxoo0XrC+4piucuo/2Crrh5TXrfR
 EOUatlvtBvEMCQ8yBja4VkerxwZKnsU/eC4VEQ2vmGxMou8ZJ/0HbvubYH9Hz7zmYTsNoX
 KBC64ek/9XlX9qqeM8AeFexcyZynGDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-KPXqSiuUPIiSakufcMxDLw-1; Wed,
 03 Jul 2024 04:21:19 -0400
X-MC-Unique: KPXqSiuUPIiSakufcMxDLw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79A871956046; Wed,  3 Jul 2024 08:21:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD6381955F22; Wed,  3 Jul 2024 08:21:14 +0000 (UTC)
Date: Wed, 3 Jul 2024 09:21:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 3/5] hw/core: allow parameter=1 for SMP topology on any
 machine
Message-ID: <ZoUJ9yfkjkAzMSOd@redhat.com>
References: <20240517150227.32205-1-philmd@linaro.org>
 <20240517150227.32205-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517150227.32205-4-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

This patch fixes a regression that was introduced in QEMU 9.0,
reported by yet another user at:

  https://gitlab.com/qemu-project/qemu/-/issues/2420

Could you pull this patch into stable-9.0.  If you think testing
is important for stable, the following patch adds further unit
testing coverage too.

Daniel

On Fri, May 17, 2024 at 05:02:25PM +0200, Philippe Mathieu-Daudé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> This effectively reverts
> 
>   commit 54c4ea8f3ae614054079395842128a856a73dbf9
>   Author: Zhao Liu <zhao1.liu@intel.com>
>   Date:   Sat Mar 9 00:01:37 2024 +0800
> 
>     hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations
> 
> but is not done as a 'git revert' since the part of the changes to the
> file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
> Furthermore, we have to tweak the subsequently added unit test to
> account for differing warning message.
> 
> The rationale for the original deprecation was:
> 
>   "Currently, it was allowed for users to specify the unsupported
>    topology parameter as "1". For example, x86 PC machine doesn't
>    support drawer/book/cluster topology levels, but user could specify
>    "-smp drawers=1,books=1,clusters=1".
> 
>    This is meaningless and confusing, so that the support for this kind
>    of configurations is marked deprecated since 9.0."
> 
> There are varying POVs on the topic of 'unsupported' topology levels.
> 
> It is common to say that on a system without hyperthreading, that there
> is always 1 thread. Likewise when new CPUs introduced a concept of
> multiple "dies', it was reasonable to say that all historical CPUs
> before that implicitly had 1 'die'. Likewise for the more recently
> introduced 'modules' and 'clusters' parameter'. From this POV, it is
> valid to set 'parameter=1' on the -smp command line for any machine,
> only a value > 1 is strictly an error condition.
> 
> It doesn't cause any functional difficulty for QEMU, because internally
> the QEMU code is itself assuming that all "unsupported" parameters
> implicitly have a value of '1'.
> 
> At the libvirt level, we've allowed applications to set 'parameter=1'
> when configuring a guest, and pass that through to QEMU.
> 
> Deprecating this creates extra difficulty for because there's no info
> exposed from QEMU about which machine types "support" which parameters.
> Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
> a given machine type, or whether it will trigger deprecation messages.
> 
> Since there's no apparent functional benefit to deleting this deprecated
> behaviour from QEMU, and it creates problems for consumers of QEMU,
> remove this deprecation.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Ján Tomko <jtomko@redhat.com>
> Message-ID: <20240513123358.612355-2-berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/core/machine-smp.c       | 84 ++++++++++++-------------------------
>  tests/unit/test-smp-parse.c |  8 ++--
>  2 files changed, 31 insertions(+), 61 deletions(-)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 2b93fa99c9..5d8d7edcbd 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -118,76 +118,46 @@ void machine_parse_smp_config(MachineState *ms,
>      }
>  
>      /*
> -     * If not supported by the machine, a topology parameter must be
> -     * omitted.
> +     * If not supported by the machine, a topology parameter must
> +     * not be set to a value greater than 1.
>       */
> -    if (!mc->smp_props.modules_supported && config->has_modules) {
> -        if (config->modules > 1) {
> -            error_setg(errp, "modules not supported by this "
> -                       "machine's CPU topology");
> -            return;
> -        } else {
> -            /* Here modules only equals 1 since we've checked zero case. */
> -            warn_report("Deprecated CPU topology (considered invalid): "
> -                        "Unsupported modules parameter mustn't be "
> -                        "specified as 1");
> -        }
> +    if (!mc->smp_props.modules_supported &&
> +        config->has_modules && config->modules > 1) {
> +        error_setg(errp,
> +                   "modules > 1 not supported by this machine's CPU topology");
> +        return;
>      }
>      modules = modules > 0 ? modules : 1;
>  
> -    if (!mc->smp_props.clusters_supported && config->has_clusters) {
> -        if (config->clusters > 1) {
> -            error_setg(errp, "clusters not supported by this "
> -                       "machine's CPU topology");
> -            return;
> -        } else {
> -            /* Here clusters only equals 1 since we've checked zero case. */
> -            warn_report("Deprecated CPU topology (considered invalid): "
> -                        "Unsupported clusters parameter mustn't be "
> -                        "specified as 1");
> -        }
> +    if (!mc->smp_props.clusters_supported &&
> +        config->has_clusters && config->clusters > 1) {
> +        error_setg(errp,
> +                   "clusters > 1 not supported by this machine's CPU topology");
> +        return;
>      }
>      clusters = clusters > 0 ? clusters : 1;
>  
> -    if (!mc->smp_props.dies_supported && config->has_dies) {
> -        if (config->dies > 1) {
> -            error_setg(errp, "dies not supported by this "
> -                       "machine's CPU topology");
> -            return;
> -        } else {
> -            /* Here dies only equals 1 since we've checked zero case. */
> -            warn_report("Deprecated CPU topology (considered invalid): "
> -                        "Unsupported dies parameter mustn't be "
> -                        "specified as 1");
> -        }
> +    if (!mc->smp_props.dies_supported &&
> +        config->has_dies && config->dies > 1) {
> +        error_setg(errp,
> +                   "dies > 1 not supported by this machine's CPU topology");
> +        return;
>      }
>      dies = dies > 0 ? dies : 1;
>  
> -    if (!mc->smp_props.books_supported && config->has_books) {
> -        if (config->books > 1) {
> -            error_setg(errp, "books not supported by this "
> -                       "machine's CPU topology");
> -            return;
> -        } else {
> -            /* Here books only equals 1 since we've checked zero case. */
> -            warn_report("Deprecated CPU topology (considered invalid): "
> -                        "Unsupported books parameter mustn't be "
> -                        "specified as 1");
> -        }
> +    if (!mc->smp_props.books_supported &&
> +        config->has_books && config->books > 1) {
> +        error_setg(errp,
> +                   "books > 1 not supported by this machine's CPU topology");
> +        return;
>      }
>      books = books > 0 ? books : 1;
>  
> -    if (!mc->smp_props.drawers_supported && config->has_drawers) {
> -        if (config->drawers > 1) {
> -            error_setg(errp, "drawers not supported by this "
> -                       "machine's CPU topology");
> -            return;
> -        } else {
> -            /* Here drawers only equals 1 since we've checked zero case. */
> -            warn_report("Deprecated CPU topology (considered invalid): "
> -                        "Unsupported drawers parameter mustn't be "
> -                        "specified as 1");
> -        }
> +    if (!mc->smp_props.drawers_supported &&
> +        config->has_drawers && config->drawers > 1) {
> +        error_setg(errp,
> +                   "drawers > 1 not supported by this machine's CPU topology");
> +        return;
>      }
>      drawers = drawers > 0 ? drawers : 1;
>  
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 8994337e12..56165e6644 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -337,21 +337,21 @@ static const struct SMPTestData data_generic_invalid[] = {
>      {
>          /* config: -smp 2,dies=2 */
>          .config = SMP_CONFIG_WITH_DIES(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
> -        .expect_error = "dies not supported by this machine's CPU topology",
> +        .expect_error = "dies > 1 not supported by this machine's CPU topology",
>      }, {
>          /* config: -smp 2,clusters=2 */
>          .config = SMP_CONFIG_WITH_CLUSTERS(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
> -        .expect_error = "clusters not supported by this machine's CPU topology",
> +        .expect_error = "clusters > 1 not supported by this machine's CPU topology",
>      }, {
>          /* config: -smp 2,books=2 */
>          .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
>                                                  0, F, 0, F, 0, F, 0),
> -        .expect_error = "books not supported by this machine's CPU topology",
> +        .expect_error = "books > 1 not supported by this machine's CPU topology",
>      }, {
>          /* config: -smp 2,drawers=2 */
>          .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, T, 2, F, 0, F,
>                                                  0, F, 0, F, 0, F, 0),
> -        .expect_error = "drawers not supported by this machine's CPU topology",
> +        .expect_error = "drawers > 1 not supported by this machine's CPU topology",
>      }, {
>          /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
>          .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


