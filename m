Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAFCC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9cF-0006PF-Sw; Fri, 11 Jul 2025 05:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9Y3-0002Nd-Rh
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9Xx-0005e5-US
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752224156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=93E0NS3IikR6YIPBJyl83eIIl5MO08TR3kYtdRY1Znk=;
 b=SuRCYxmUlWjqrrCKGBZ+HCTbaCoQshLxDLovtYbAHCjfnofMe+U6S66vVMlTva0KTo1UG+
 XQL/jMw6iqcdaEksPMOVz1gNLrxisuFAslgJfwX+3LQmvqfX7WQmMKbXcnzgnTRfltS5En
 5Elk4pTiHK95610xwKf3h2o4gRyxdgc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-P6RkQDokP4SqwzRhcymkDg-1; Fri,
 11 Jul 2025 04:55:53 -0400
X-MC-Unique: P6RkQDokP4SqwzRhcymkDg-1
X-Mimecast-MFC-AGG-ID: P6RkQDokP4SqwzRhcymkDg_1752224151
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E782195608D; Fri, 11 Jul 2025 08:55:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E44330001A1; Fri, 11 Jul 2025 08:55:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DD7421E6A27; Fri, 11 Jul 2025 10:55:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>,  Peter Xu
 <peterx@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Jason Wang <jasowang@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 08/18] qapi: add cross-references to migration.json
In-Reply-To: <20250711054005.60969-9-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:39:55 -0400")
References: <20250711054005.60969-1-jsnow@redhat.com>
 <20250711054005.60969-9-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 10:55:47 +0200
Message-ID: <87cya785t8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/migration.json | 68 ++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 59a213aeb6c..eda27c18102 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json

[...]

> @@ -1735,8 +1735,8 @@
>  #     list connected to a destination interface endpoint.
>  #
>  # @exit-on-error: Exit on incoming migration failure.  Default true.
> -#     When set to false, the failure triggers a MIGRATION event, and
> -#     error details could be retrieved with query-migrate.
> +#     When set to false, the failure triggers a :qapi:event:`MIGRATION`
> +#     event, and error details could be retrieved with `query-migrate`.
>  #     (since 9.1)

Suggest to have the the commit message note why we need :qapi:event:.
Perhaps like this:

  Note that a reference to MIGRATION needs to be disambiguated with a
  :qapi:event: prefix.  Without this, Sphinx complains

      more than one target found for 'any' cross-reference 'MIGRATION': could be :std:ref:`Migration framework` or :qapi:event:`QMP:migration.MIGRATION`

Aside: this fuzzy matching of references feels too clever by half.

>  #
>  # Since: 2.3

[...]


