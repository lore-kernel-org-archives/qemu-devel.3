Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE110A62C4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kL3-0003cr-RP; Thu, 26 Mar 2026 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5kKz-0003cV-Dw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5kKx-0005CW-QE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774530082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgqnh8YCVC64TnA3VJFCquY3LHbWRG2/wHmvHeqgzDw=;
 b=GY+2M+RptLCcfW6nYQGPNPs6J5WUa0uNqKDh+50rdiJW4HX2kw6Y6wr940JLC9bLVo/+jK
 U6p3TjjguC1NAIzoIya+p09fEwYdjTPECe34bshRqIDb/RS+7+/IEdJ6ILuELznwpCqw1O
 eintz1vESrTBSIx5xrRSZx6rLf3JOT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-dkj09fOLMO2CHio9kGdSLw-1; Thu,
 26 Mar 2026 09:01:19 -0400
X-MC-Unique: dkj09fOLMO2CHio9kGdSLw-1
X-Mimecast-MFC-AGG-ID: dkj09fOLMO2CHio9kGdSLw_1774530071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F0EF1955F18; Thu, 26 Mar 2026 13:01:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 627103000223; Thu, 26 Mar 2026 13:01:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0600221E6937; Thu, 26 Mar 2026 14:01:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
 <berrange@redhat.com>,  <eblake@redhat.com>,
 <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
 <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
 <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
In-Reply-To: <20260326112921.000028e6.alireza.sanaee@huawei.com> (Alireza
 Sanaee's message of "Thu, 26 Mar 2026 11:29:21 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-2-alireza.sanaee@huawei.com>
 <87a4vuhnxy.fsf@pond.sub.org>
 <20260326112921.000028e6.alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 14:01:06 +0100
Message-ID: <87bjgag2y5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> On Thu, 26 Mar 2026 11:42:17 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> Hi Markus,
>
>> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
>> 
>> > Add a string tag property to HostMemoryBackend so that backends can be
>> > identified by a user-assigned name at runtime. Expose the property through
>> > QOM and add a host_memory_backend_find_by_tag() helper that walks the
>> > object tree to locate a backend by its tag.  
>> 
>> Why can't you use the QOM ID?
>> 
>> $ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
>> QEMU 10.2.90 monitor - type 'help' for more information
>> (qemu) info qom-tree /objects/fred
>> /fred (memory-backend-ram)
>>   /fred[0] (memory-region)
>> 
>>  
>
> Fair question. The ID would have been a solution if it had accepted GUIDs. CXL spec 
> requires GUIDs for extents as identification, hence new tag property.

Your commit message should state that this needs to be a GUID and why.

> alireza@blue-ocean:~/Downloads$ qemu-system-x86_64 -s -display none -monitor std
> io -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd76bb79,size=1M
> qemu-system-x86_64: -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd
> 76bb79,size=1M: Parameter 'id' expects an identifier
> Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.
>
> Thanks,
> Ali


