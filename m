Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DADDE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 12:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsgxC-00035l-EV; Wed, 18 Feb 2026 07:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgwM-0002vL-DZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgwL-0001UK-0T
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771418759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyEfyRbcy2C+TTaR7sOWngqnVkpTbO8bpRi3N/UBO4Q=;
 b=LQ8RBdheddzm/8XkBGtw2v63+rig8qttuN+L8L7BJxxmm4OoCs3cYOZ2FQBEcKzi7ifa90
 BJtDa86bwJEs4us1TTzoW5UAOEcETsDaLeEc5+c8gB4y/NmA6leoItB9iPf6EJh1GVhae0
 0PXPbTau/LdVjCZpHtPZ21vIHkjg5fo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-NJLGHDRcO8C87ZQnhFz_3Q-1; Wed,
 18 Feb 2026 07:45:55 -0500
X-MC-Unique: NJLGHDRcO8C87ZQnhFz_3Q-1
X-Mimecast-MFC-AGG-ID: NJLGHDRcO8C87ZQnhFz_3Q_1771418754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95091195605B; Wed, 18 Feb 2026 12:45:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB42419560B5; Wed, 18 Feb 2026 12:45:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EC7C21E692D; Wed, 18 Feb 2026 13:45:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 19/27] util: fix interleaving of error & trace output
In-Reply-To: <20260211152508.732487-20-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:00
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-20-berrange@redhat.com>
Date: Wed, 18 Feb 2026 13:45:50 +0100
Message-ID: <87a4x6cj9d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

One more...

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The monitor_cur_hmp() function will acquire/release mutex locks, which
> will trigger trace probes, which can in turn trigger qemu_log() calls.
> vreport() calls monitor_cur() multiple times through its execution
> both directly and indirectly via error_vprintf().
>
> The result is that the prefix information printed by vreport() gets
> interleaved with qemu_log() output, when run outside the context of
> an HMP command dispatcher. This can be seen with:

[...]

> diff --git a/util/error-report.c b/util/error-report.c
> index f3aa24ec22..b34a2bc7bc 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c

[...]

> @@ -156,34 +176,34 @@ void loc_set_file(const char *fname, int lno)
>  /*
>   * Print current location to current monitor if we have one, else to std=
err.

This is now misleading.  Let's use

    * Print to @cur_mon if non-null, else to stderr.

>   */
> -static void print_loc(void)
> +static void print_loc(Monitor *cur)
>  {
>      const char *sep =3D "";
>      int i;

[...]


