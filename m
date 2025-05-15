Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0E9C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTFu-00046w-D0; Thu, 15 May 2025 03:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFTFs-00046L-Gt
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFTFq-0006EE-IC
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747295023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMktAqtVjFdQ4jPA8on/MdgqREjgi3G2FE7cEE/DnEA=;
 b=VwC0VxgswdpZNkjmrdq3gNANv+9yuc5elPpqTRxMJGt58FNl279CennFgtmrPs8FBB8DbJ
 COjvjCrDWyBWlgyK6oJx66UKuEpwoq0m/aif4UWOlrE7LEEl6yY5FAjR1shzZoc1Hl175h
 QVdW6KdzLbLuiEb8AJGUMfvwZKsiWh8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-1lII2W0yNm6TILLZ7LJW1Q-1; Thu,
 15 May 2025 03:43:42 -0400
X-MC-Unique: 1lII2W0yNm6TILLZ7LJW1Q-1
X-Mimecast-MFC-AGG-ID: 1lII2W0yNm6TILLZ7LJW1Q_1747295021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E50519560AA; Thu, 15 May 2025 07:43:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD2031800268; Thu, 15 May 2025 07:43:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F220E21E6768; Thu, 15 May 2025 09:43:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
 query-sgx-capabilities
In-Reply-To: <aCWQNdZ0dy3641jE@intel.com> (Zhao Liu's message of "Thu, 15 May
 2025 14:56:53 +0800")
References: <20250513143131.2008078-1-zhao1.liu@intel.com>
 <87cyca4dbt.fsf@pond.sub.org> <aCWQNdZ0dy3641jE@intel.com>
Date: Thu, 15 May 2025 09:43:37 +0200
Message-ID: <87zffe2uae.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> On Thu, May 15, 2025 at 08:07:02AM +0200, Markus Armbruster wrote:
>> Date: Thu, 15 May 2025 08:07:02 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
>>  query-sgx-capabilities
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Hi all,
>> >
>> > There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
>> > their outputs are very similar and the documentation lacks clear
>> > differentiation.
>> >
>>  >From the codes, query-sgx is used to gather guest's SGX capabilities
>> > (including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
>> > query-sgx-capabilities is used to gather host's SGX capabilities 
>> > (descripted by SGXInfo as well).
>> >
>> > Therefore, fix their documentation to reflect this difference.
>> 
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> 
>> I'll take this through my tree unless Paolo is faster.
>
> Thanks Markus!
>
> I was also thinking you would like "SgxInfo" and "SgxEpcSection" instead
> of current "SGXInfo" and "SGXEPCSection".

These are indeed easier to read, especially the latter.

> But I'm not sure if modifying the old names has any compatibility issues
> for QAPI? If you think it's ok, I can continue to make the SGX naming
> styles more QAPI compliant.

Type names are not visible at the external interface, so changing them
is just fine.  That's a feature!


