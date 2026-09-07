Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A89C79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3V3j-0004Um-MM; Mon, 07 Sep 2026 04:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3V3i-0004UR-C5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3V2W-0004Qf-5v
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788770957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Io0H1GJ/dw2mo8xfSai0hRK1W/6Yvbo/1iXfLNcM4Ew=;
 b=bWHdg/X6fcrUwS8eERsbxa60iGDx1JLPFR6nnvv9qruQ4m4MqX126r05dL+VK/+L3pG35o
 XnahcGj81vzm9qZkRA3kkOzuAMujek0Jy/WeUqvTZwFZgJExdampB4rP6gveY9hr0h8Msc
 zK3dUOnpky5jMRB89149b5wY8jfL97U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-a78adVEqOB2guYjl-O9KQg-1; Mon,
 07 Sep 2026 04:49:14 -0400
X-MC-Unique: a78adVEqOB2guYjl-O9KQg-1
X-Mimecast-MFC-AGG-ID: a78adVEqOB2guYjl-O9KQg_1788770953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68BFF1956075; Mon,  7 Sep 2026 08:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C503D18001CE; Mon,  7 Sep 2026 08:49:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A6A221E6A04; Mon, 07 Sep 2026 10:49:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
 mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
 eblake@redhat.com,  armbru@redhat.com,  lorenzo.pieralisi@linaro.org,
 gshan@redhat.com,  enju.kohei@fujitsu.com,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
In-Reply-To: <20260903193611.1058589-4-mathieu.poirier@linaro.org> (Mathieu
 Poirier's message of "Thu, 3 Sep 2026 13:35:50 -0600")
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
Date: Mon, 07 Sep 2026 10:49:09 +0200
Message-ID: <87wlsxxx8a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> support the Arm Realm Management Extension (RME). It is instantiated by
> passing on the command-line:
>
>   -M virt,confidential-guest-support=<id>
>   -object rme-guest,id=<id>
>
> This is only the skeleton. Support will be added in following patches.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 776b13027fd8..52997c29a32d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1288,6 +1288,17 @@
>    'data': { '*pretty': 'bool',
>              '*close-action': 'MonitorQMPCloseAction' } }
>  
> +##
> +# @RmeGuestProperties:
> +#
> +# Properties for rme-guest objects.
> +#
> +# Since: 11.1

11.2 now.

> +##
> +{ 'struct': 'RmeGuestProperties',
> +  'base': 'ConfidentialGuestSupportProperties',
> +  'data': {} }
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1346,6 +1357,7 @@
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
>      'qtest',
> +    'rme-guest',
>      'rng-builtin',
>      'rng-egd',
>      { 'name': 'rng-random',
> @@ -1427,6 +1439,7 @@
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',
> +      'rme-guest':                  'RmeGuestProperties',
>        'rng-builtin':                'RngProperties',
>        'rng-egd':                    'RngEgdProperties',
>        'rng-random':                 { 'type': 'RngRandomProperties',

With the Since: fixed
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


