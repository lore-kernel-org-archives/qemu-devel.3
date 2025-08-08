Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC72DC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukKU8-0001eY-Sy; Fri, 08 Aug 2025 06:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukKU7-0001c9-9O
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukKU5-0002vB-9k
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754649478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHExNf0ah0BKIunxTZU44AuEdhNit8xZe6EZrF8kR+0=;
 b=HvovDdIsErl+nYBaGf3cApx3ZyHcjAKCY+/8sBy4Pkwtc4PV2w65YDZiG9HmWyWlXo3RI5
 k4A16tT4uB01NIBrdWW4UusV7fQ3ceqabxU9C+w2A6VLyXEvRN57QHYGH5Z95la4SQ7OW5
 SMWVBVS/HQVVkRfxv8iqk1YD4vBYiPI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-baYZLkOTMf2kNv8mwnzNYw-1; Fri,
 08 Aug 2025 06:37:53 -0400
X-MC-Unique: baYZLkOTMf2kNv8mwnzNYw-1
X-Mimecast-MFC-AGG-ID: baYZLkOTMf2kNv8mwnzNYw_1754649472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B23C1800286; Fri,  8 Aug 2025 10:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7FC1954185; Fri,  8 Aug 2025 10:37:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7243421E6A27; Fri, 08 Aug 2025 12:37:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <shiju.jose@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <linux-cxl@vger.kernel.org>,
 <jonathan.cameron@huawei.com>,  <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
In-Reply-To: <20250807154346.2209-2-shiju.jose@huawei.com> (shiju jose's
 message of "Thu, 7 Aug 2025 16:43:40 +0100")
References: <20250807154346.2209-1-shiju.jose@huawei.com>
 <20250807154346.2209-2-shiju.jose@huawei.com>
Date: Fri, 08 Aug 2025 12:37:47 +0200
Message-ID: <87ldnuhzes.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

<shiju.jose@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> In qapi/cxl.json added fields of Common Event Record to a common
> structure CXLCommonEventBase.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Please split this patch for easier review:

1. CXLCommonEventBase.  Pure refactoring.

2. Add new members.


