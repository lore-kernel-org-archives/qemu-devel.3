Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8B9C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixTI-000201-1U; Fri, 14 Feb 2025 10:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tixTF-0001zb-6E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tixTD-0007Oq-2U
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739546349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A55QoFH/rQCqFBx/bbwSo3JflX/jTWQEPepyTFD/Rhw=;
 b=PuROEVizOyfHv3Ct2Qw9KdI+0d45akKqZnObwd8ZcJtOjfF8AroqWXf/yxr359SdnOfgxm
 YXeyjPm33nA9N5xGRIBB8PW1vHXjCokfJRzx+pgHn3LrvH/uo2VY/QtxzTpvb26hth2noM
 HffH16VtgCOPHDVG48lo6vn6Qf53dkg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-Z9-bzg0nMlunvozPZaQDJA-1; Fri,
 14 Feb 2025 10:19:04 -0500
X-MC-Unique: Z9-bzg0nMlunvozPZaQDJA-1
X-Mimecast-MFC-AGG-ID: Z9-bzg0nMlunvozPZaQDJA_1739546342
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C0DE180087A; Fri, 14 Feb 2025 15:19:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD131800360; Fri, 14 Feb 2025 15:18:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03BE321E6A28; Fri, 14 Feb 2025 16:18:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,  Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,  Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>,  Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Lei Yang <leiyang@redhat.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  qemu-devel@nongnu.org,  devel@daynix.com
Subject: Re: [PATCH] qom: Use command line syntax for default values in help
In-Reply-To: <20250207-bool-v1-1-5749d5d6df24@daynix.com> (Akihiko Odaki's
 message of "Fri, 07 Feb 2025 14:53:43 +0900")
References: <20250207-bool-v1-1-5749d5d6df24@daynix.com>
Date: Fri, 14 Feb 2025 16:18:56 +0100
Message-ID: <87pljk1rmn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> object_property_help() uses the conventional command line syntax instead
> of the JSON syntax. In particular,
> - Key-value pairs are written in the command line syntax.
> - bool description passed to the function says on/off instead of
>   true/false.
>
> However, there is one exception: default values are formatted into JSON.
> While the command line and JSON syntaxes are consistent in many cases,
> there are two types where they disagree:
>
> string: The command line syntax omits quotes while JSON requires them.
>
> bool: JSON only accepts true/false for bool but the command line syntax
>       accepts on/off too, and on/off are also more popular than
>       true/false. For example, the docs directory has 2045 "on"
>       occurances while it has only 194 "true" occurances.
>       on/off are also accepted by OnOffAuto so users do not have to
>       remember the type is bool or OnOffAuto to use the values.
>
> Omit quotes for strings and use on/off for bools when formatting
> default values for better consistency.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


