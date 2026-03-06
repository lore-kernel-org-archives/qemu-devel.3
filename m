Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0496AF01819
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRZ1-0005v4-W1; Fri, 06 Mar 2026 04:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRYz-0005uF-HV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRYy-0002AG-8R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772789619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=jfHOyfoBdctw6DJ03oLrf+5aeaHKW/rZT/XX1CQVGDg=;
 b=LPFZYSQ2tyZMEOeHs1nCeYQzWShmbMQiX01Ytk4FkLZd5xZ4wY7Dc29vy240AiFkU1qlCT
 0wF8rfxdZi3qZyui3QYDpZpJsXmW83ywQ2QSCoUm1KRee6cOeoeGwpVv+3ZOcY7dNLH/jW
 5bV82uMypcj7kNe36hOVO3gTCIOFR/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-OGdnqbpUP0iJnttKwwH1Tg-1; Fri,
 06 Mar 2026 04:33:35 -0500
X-MC-Unique: OGdnqbpUP0iJnttKwwH1Tg-1
X-Mimecast-MFC-AGG-ID: OGdnqbpUP0iJnttKwwH1Tg_1772789613
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8D71956054; Fri,  6 Mar 2026 09:33:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D76C1800671; Fri,  6 Mar 2026 09:33:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E968B21E6A04; Fri, 06 Mar 2026 10:33:29 +0100 (CET)
Resent-To: balaton@eik.bme.hu, eduardo@habkost.net, zhao1.liu@intel.com,
 zide.chen@intel.com, peter.maydell@linaro.org, philmd@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 dapeng1.mi@linux.intel.com, devel@lists.libvirt.org,
 qemu-devel@nongnu.org, mark.caveayland@nutanix.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 06 Mar 2026 10:33:29 +0100
Resent-Message-ID: <87y0k5i9p2.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Zide Chen
 <zide.chen@intel.com>,  Dapeng Mi <dapeng1.mi@linux.intel.com>,
 qemu-devel@nongnu.org,  devel@lists.libvirt.org
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
In-Reply-To: <20260218105120.5e55ad07@imammedo> (Igor Mammedov's message of
 "Wed, 18 Feb 2026 10:51:20 +0100")
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com> <20260218105120.5e55ad07@imammedo>
Date: Fri, 06 Mar 2026 10:14:23 +0100
Message-ID: <87seadjp5c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Igor Mammedov <imammedo@redhat.com> writes:

> I might be totally wrong, but occasionally I've considered using
> object_set_properties_from_qdict() internally as much more compact form
> compared to 'object_new()/set_this_property and set that one too' noodle.

Clear signal our C interface to QOM object configuration is lacking.

Going through a QDict is disgusting, though.  There has to be a more
direct way.  One that doesn't involve building temporary trees just so
we can use existing visitors.

What if we could pass the entire configuration as a struct?  Instead of
setting properties one by one, pass a struct literal and be done.


