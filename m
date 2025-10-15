Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F46BCCD190
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8w8e-0001x3-Ez; Wed, 15 Oct 2025 03:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8w8c-0001wW-Bo
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8w8V-00044S-PC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760514083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ei+eHJJQDJzK1X829xp+mvsXdsaNljBhodDj8sQxS8Y=;
 b=cU4hR28uVODn6mMm6IaA7P94gi2g4WMX1/TvsFaI/fITUIVbXD0xWFgDVoSTbtU0Eb8hZY
 fEvOYUpHGfWhu/D7+Q8IQDDfhRXbhXlQKsHS55lEmq0Fl1d8x0bbYB9/z8tqCka+2ulVJf
 bTYr9DBSfeK8uum5mbdh4/q2srm3KoE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-i-6Wv2EkNYK8oBFOyF30Sw-1; Wed,
 15 Oct 2025 03:41:20 -0400
X-MC-Unique: i-6Wv2EkNYK8oBFOyF30Sw-1
X-Mimecast-MFC-AGG-ID: i-6Wv2EkNYK8oBFOyF30Sw_1760514079
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B58991956086; Wed, 15 Oct 2025 07:41:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EC419560AD; Wed, 15 Oct 2025 07:41:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F3A821E6A27; Wed, 15 Oct 2025 09:41:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Eric
 Blake <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Laurent Vivier
 <lvivier@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 1/2] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
In-Reply-To: <gzn24uzbuady2ipi3uvuzyykqgkvp6ogbwsapghflkfyymgzrv@2bwdhvhwlzw3>
 (Gerd Hoffmann's message of "Wed, 15 Oct 2025 08:33:09 +0200")
References: <20251013104954.250166-1-kraxel@redhat.com>
 <20251013104954.250166-2-kraxel@redhat.com>
 <aO4QSE7oNqpNApFZ@redhat.com>
 <gzn24uzbuady2ipi3uvuzyykqgkvp6ogbwsapghflkfyymgzrv@2bwdhvhwlzw3>
Date: Wed, 15 Oct 2025 09:41:15 +0200
Message-ID: <87sefkfw84.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> > +static void handle_ovmf_log_range(GString *out,
>> > +                                  dma_addr_t start,
>> > +                                  dma_addr_t end,
>> > +                                  Error **errp)
>> > +{
>> > +    g_autofree char *buf = NULL;
>> 
>> Left-over variable - unfortunately gcc doens't warn about unused
>> vars when g_autofree is present :-(
>
> Fixed.
>
>> > +{ 'struct': 'FirmwareLog',
>> > +  'data': { '*version': 'str',
>> > +            '*log': 'str' } }
>> 
>> Having version be optional makes sense, but what is the semantics for
>> 'log' being optional. If the log is unavailable, wouldn't we be better
>> raising an error ?
>
> That is what the current implementation actually does.  I change it.

Drawback: when some Firmware provides version, but not log, the command
can't give us the version, because it fails.  Do we care?


