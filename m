Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE706C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36AI-00027c-NQ; Fri, 11 Apr 2025 00:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u36AE-000279-Iy
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u36AA-0000fQ-Qo
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744346324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTzIILfn+BEwNwtW56J6lhs9IhbQAvx+RqJINSsKWq4=;
 b=VkBtyULFCgAsYmU80ax7PDTkk3TnET+/FfMyaqSCelzJXx9GzIREXC4GGWKgnmdzAx471Z
 6uQ8UhyyKu8rID9iyqYzLLAlcdWU7DSjQ8JcI8FjcY0J1dEz0azuKT1T0uYLzy5T67BzvZ
 jTCCgX3SpZofZpAZxhqXJXEUeNdO//Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-36oH1RziO8KYTsgfbNR7zw-1; Fri,
 11 Apr 2025 00:38:41 -0400
X-MC-Unique: 36oH1RziO8KYTsgfbNR7zw-1
X-Mimecast-MFC-AGG-ID: 36oH1RziO8KYTsgfbNR7zw_1744346319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F0521801A12; Fri, 11 Apr 2025 04:38:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4676A1828A9F; Fri, 11 Apr 2025 04:38:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6AB821E6773; Fri, 11 Apr 2025 06:38:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <Z/iUiEXZj52CbduB@intel.com> (Zhao Liu's message of "Fri, 11 Apr
 2025 12:03:20 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org> <Z/iUiEXZj52CbduB@intel.com>
Date: Fri, 11 Apr 2025 06:38:35 +0200
Message-ID: <87frifxqgk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Markus
>
> On Thu, Apr 10, 2025 at 04:21:01PM +0200, Markus Armbruster wrote:
>> Date: Thu, 10 Apr 2025 16:21:01 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Introduce the kvm-pmu-filter object and support the PMU event with raw
>> > format.
>> 
>> Remind me, what does the kvm-pmu-filter object do, and why would we
>> want to use it?
>
> KVM PMU filter allows user space to set PMU event whitelist / blacklist
> for Guest. Both ARM and x86's KVMs accept a list of PMU events, and x86
> also accpets other formats & fixed counter field.

But what does the system *do* with these event lists?

> The earliest version uses custom parsing rules, which is not flexible
> enough to scale. So to support such complex configuration in cli, it's
> best to define and parse it via QAPI, and it's best to support the JSON
> way.
>
> Based on these considerations, I found "object" to be a suitable enough
> choice.
>
> Thus kvm-pmu-filter object handles all the complexity of parsing values
> from cli, and it can include some checks that QAPI cannot include (such
> as the 12-bit limit).
>
> Thanks,
> Zhao


