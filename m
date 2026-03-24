Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32182F532DD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uUc-00015P-0o; Tue, 24 Mar 2026 01:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4uUX-00014g-Er
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4uUV-0002FL-8L
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774330785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+0YGFpQM3ulLCo5fVzKjgeZxiTy+YtVz/KSucLyu+w=;
 b=LkGDML6r7G254GZZfybQ6YDuHKV3SdlH+X1yRE5WQTdI6rrxeCTq7sx9KJAd/CsVMfhXtF
 pSfqNT8ibwxtgbhHXVgWXAI7WQTV7H9PJyYOb3907nt+ek28WbHabbQtm4MZafP5jg0YPy
 wnLPff42ubf9zjyB1n3QkQSjaS04ROk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-774wtRmgNCyRAqgfsT9jcg-1; Tue,
 24 Mar 2026 01:39:42 -0400
X-MC-Unique: 774wtRmgNCyRAqgfsT9jcg-1
X-Mimecast-MFC-AGG-ID: 774wtRmgNCyRAqgfsT9jcg_1774330781
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADD1B180047F; Tue, 24 Mar 2026 05:39:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18FB9180035F; Tue, 24 Mar 2026 05:39:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16CE521E6937; Tue, 24 Mar 2026 06:39:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Nathan Chen <nathanc@nvidia.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Michael S . Tsirkin" <mst@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Shannon
 Zhao <shannon.zhaosl@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,
 Matt Ochs <mochs@nvidia.com>,  Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
In-Reply-To: <CH3PR12MB7548E042617EA0BDFB34C55BAB4BA@CH3PR12MB7548.namprd12.prod.outlook.com>
 (Shameer Kolothum Thodi's message of "Mon, 23 Mar 2026 17:41:29
 +0000")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-6-nathanc@nvidia.com>
 <87341w9ftp.fsf@pond.sub.org>
 <e855b12b-5e1c-4590-8440-a29155a6c9b0@nvidia.com>
 <CH3PR12MB7548E042617EA0BDFB34C55BAB4BA@CH3PR12MB7548.namprd12.prod.outlook.com>
Date: Tue, 24 Mar 2026 06:39:37 +0100
Message-ID: <874im5wzty.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Shameer Kolothum Thodi <skolothumtho@nvidia.com> writes:

>> On 3/19/2026 5:14 AM, Markus Armbruster wrote:

[...]

>> > Any particular reason this is called @ssidsize and not @ssid-size?
>> 
>> I'm not sure there's a particular reason - this property was newly
>> introduced in the accel SMMUv3 series [0]. Should we include a patch to
>> change it to @ssid-size to match the format of other properties?

Separating words improves legibility.  docs/devel/qapi-code-gen.rst
section "Naming rules and reserved names":

    Command names, member names within a type, and feature names should
    be all lower case with words separated by a hyphen.

However, we have a compelling reason for @ssidsize:

> I don't think we should as that name was selected to match the SMMUv3
> IDR1 register filed name in the SMMUv3 specification.

Thanks!


