Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73562C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZssE-0001X6-6L; Tue, 13 Feb 2024 08:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZss7-0001Sz-Fa
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZss4-0002ks-Vq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707831045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGGAbMKWVfT872nscfyaLtvWSr7w82HGq5w5Gkcq/fE=;
 b=UXSC/AVz9YSbmT/FtOsRfnnrHbujz2Esc+jMSXmXe3EXIhLUwa5q7WQ3k2L0Uv91LVKb8/
 sQRsnKk1F6kSBIsjr+nGECpYPNj0L6UayBIrbgQQmWFTlGgsen1qJqgIQW/1EhqntG03Wg
 WvFVd1/McSZ+dhb+hk749pQqaXbJpt0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-PfLeRZIbNii-0_bIXuiUVQ-1; Tue,
 13 Feb 2024 08:30:43 -0500
X-MC-Unique: PfLeRZIbNii-0_bIXuiUVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56CC91C2FE2A;
 Tue, 13 Feb 2024 13:30:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA9A492BF0;
 Tue, 13 Feb 2024 13:30:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4E1E21E66D5; Tue, 13 Feb 2024 14:30:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v3 0/3] Adjust the output of x-query-virtio-status
In-Reply-To: <20240213052503-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 13 Feb 2024 05:25:33 -0500")
References: <cover.1706883915.git.yong.huang@smartx.com>
 <20240213052503-mutt-send-email-mst@kernel.org>
Date: Tue, 13 Feb 2024 14:30:41 +0100
Message-ID: <87v86s7apq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Feb 02, 2024 at 10:32:14PM +0800, Hyman Huang wrote:
>> Sorry for the late post of version 3. The modifications are as follows:
>> 
>> v3:
>> - Rebase on master
>> - Use the refined commit message furnished by Markus for [PATCH v2 1/2] 
>> - Drop the [PATCH v2 2/2]
>> - Add [PATCH v3 2/3] to declare the decoding functions to static
>> - Add [PATCH v3 3/3] to Define VhostDeviceProtocols and
>>   VirtioDeviceFeatures as plain C types
>> 
>> Since Markus inspired all of the alterations above, we would like to
>> thank him for his contribution to this series.
>> 
>> Please review,
>> Yong
>
> Markus do you think you can take a look at this?

I intend to.  Sorry for the delay!


