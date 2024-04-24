Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96330C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgOB-0003s8-7T; Wed, 24 Apr 2024 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzgO8-0003rv-QV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzgO6-00014P-VS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713979589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNZ2GSMyKTkCQIOnN2LNE4NSLe1XqgAYfruR0VO0M+g=;
 b=P3Haj4k5i1aR+2L1am/9zTNFQwY3Vuk3/cp7NozWpKIDKe+LGxv11ugsnLfctL2mjaNSnV
 wTbumX0o/XYirc6vRlLKzbvGQZD44dCHOjE+hPfA5wb9ahkC55d/nUebSFijM43uz/2wde
 nKPcOQvx5vBT7Txvg37XB/ZJBIHzosM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Ta705BcSOjWjRm34S_r5FQ-1; Wed, 24 Apr 2024 13:26:26 -0400
X-MC-Unique: Ta705BcSOjWjRm34S_r5FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DEF31815A81;
 Wed, 24 Apr 2024 17:26:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC10040C6CC0;
 Wed, 24 Apr 2024 17:26:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B030F21E66C8; Wed, 24 Apr 2024 19:26:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
 ira.weiny@intel.com,  dan.j.williams@intel.com,
 a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
 jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <Zik88BUMsMEFb0Nr@debian> (fan's message of "Wed, 24 Apr 2024
 10:10:08 -0700")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org> <Zik88BUMsMEFb0Nr@debian>
Date: Wed, 24 Apr 2024 19:26:23 +0200
Message-ID: <87pluebrk0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

fan <nifan.cxl@gmail.com> writes:

> On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
>> nifan.cxl@gmail.com writes:
>> 
>> > From: Fan Ni <fan.ni@samsung.com>
>> >
>> > Since fabric manager emulation is not supported yet, the change implements
>> > the functions to add/release dynamic capacity extents as QMP interfaces.
>> 
>> Will fabric manager emulation obsolete these commands?
>> 
>
> Hi Markus,
> Thanks for reviewing the patchset. This is v5 and we have sent out v7
> recently, there are a lot of changes from v5 to v7.
>
> FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Missed it because you neglected to cc: me for qapi/cxl.json :)

Thanks!


