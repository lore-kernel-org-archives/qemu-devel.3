Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E910F3DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 06:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6MkK-0000BL-3h; Sat, 28 Mar 2026 02:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w6MkI-0000BB-SL
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 02:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w6MkH-0002IH-Ay
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 02:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774677722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOl67eVYjM6XwA+2aoAT/RR6VujgC2WWk7a6aW7H6AI=;
 b=ZuDggVp99Z7LgOLNPmqXCggHXhuT+gJmUx7Z8UuQ13Yqv6Qo5vyECXdOTIJJ9OaaU+9tvr
 drzVUu0MDcFTcg+CNdbJIx4HGp2Hu6IqyHliUsf9C3LIepB9ygojUX3Dvu+RGjERrsRQVa
 OeQ6t8QerFAd2oBktPRfDX5/Jr5WdWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-QK3TLCZJNl6B8duKTuTrnw-1; Sat,
 28 Mar 2026 02:01:56 -0400
X-MC-Unique: QK3TLCZJNl6B8duKTuTrnw-1
X-Mimecast-MFC-AGG-ID: QK3TLCZJNl6B8duKTuTrnw_1774677715
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6AC19560BB; Sat, 28 Mar 2026 06:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 803171955D84; Sat, 28 Mar 2026 06:01:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 291A021E6937; Sat, 28 Mar 2026 07:01:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
 <berrange@redhat.com>,  <eblake@redhat.com>,
 <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
 <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
 <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260327151811.00005564.alireza.sanaee@huawei.com> (Alireza
 Sanaee's message of "Fri, 27 Mar 2026 15:18:11 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-10-alireza.sanaee@huawei.com>
 <87mrzuei5f.fsf@pond.sub.org>
 <20260327151811.00005564.alireza.sanaee@huawei.com>
Date: Sat, 28 Mar 2026 07:01:51 +0100
Message-ID: <87zf3s1ohc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> On Thu, 26 Mar 2026 16:15:40 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> Hi Markus,
>
> This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
> The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
>
> I would be happy to drop this patch, as this is extra.

So your motivation for adding the command is "just" testing.  Correct?

Can you think of other uses?

In particular, would a management application need this query to monitor
removal?

The description of feature @unstable may need to be adjusted for the
answers we work out here.

>
> Thanks,
> Ali


