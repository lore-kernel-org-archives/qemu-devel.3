Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88648C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJlvC-0003oB-An; Tue, 27 May 2025 00:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJlvA-0003o1-9c
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJlv8-0007NC-6q
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748320087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2/YrwlvZsq7+WWHYoQrrt0Mo4CmgOLW02oO+FtHWF0=;
 b=NQeX/UHRAYA9jsHCMPu34UsP7H8tTUUUxq/Wp1kaxSb8F7KNnsCfCeu3dzs5Y+okbJN+ur
 2WcE7DQl2NJWL8iUvUDaE1gJdQFJbHa7trW2fqHhEvT150ylFhx3EkedlD6XM4bo41YJjh
 T8kTAiXeieiFGSVHxUsJLWq3GXlka4Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-nTHphncVOq-TTXuOZfamwg-1; Tue,
 27 May 2025 00:28:03 -0400
X-MC-Unique: nTHphncVOq-TTXuOZfamwg-1
X-Mimecast-MFC-AGG-ID: nTHphncVOq-TTXuOZfamwg_1748320082
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E3A3180045B; Tue, 27 May 2025 04:28:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25D1A30001A1; Tue, 27 May 2025 04:28:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73FF921E66C3; Tue, 27 May 2025 06:27:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v9 00/55] QEMU TDX support
In-Reply-To: <792cbff4-6d25-4f39-8a18-3f7affdfe5cd@intel.com> (Xiaoyao Li's
 message of "Tue, 27 May 2025 09:30:53 +0800")
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
 <e994b189-d155-44d0-ae7d-78e72f3ae0de@redhat.com>
 <792cbff4-6d25-4f39-8a18-3f7affdfe5cd@intel.com>
Date: Tue, 27 May 2025 06:27:58 +0200
Message-ID: <87a56ywucx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 5/27/2025 12:12 AM, Paolo Bonzini wrote:
>> On 5/8/25 16:59, Xiaoyao Li wrote:
>>> This is the v9 series of TDX QEMU enabling. The series is also available
>>> at github:
>>> https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v9
>>>
>>> Note, this series has a dependency on
>>> https://lore.kernel.org/qemu-devel/20241217123932.948789-1- xiaoyao.li@intel.com/
>>>
>>> =============
>>> Changes in v9
>>>
>>> Comparing to v8, no big change in v9.
>>>
>>> V9 mainly collects Reviewed-by tags from Daniel and Zhao Liu (Thanks to
>>> their review!) and v9 does some small change according to the review
>>> feedback of them. Please see the individual patch for the detailed
>>> change history.
>>
>> Queued, thanks for your patience - this was a huge effort.

Started late fall 2023?  That's perseverance!

>> I'll wait until the kernel side is picked up and then send the pull request.
>
> Thanks, Paolo!
>
> And thanks to Gerd Hoffmann, Daniel, Markus, Zhao Liu, ... and all the people who helped review and provided valuable feedback.

You're welcome!


