Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A73C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIIa-0001Ve-Cz; Wed, 13 Mar 2024 02:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkIIX-0001VG-20
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkIIT-00077y-Pm
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710312064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/kV++lUUeiBr4UOrLPcxrX5Gp/TGALOULyj2c3tvDw=;
 b=ba7oSzpJ3O0T9itX8LZS362huZ2mUmMVZmpWPAEBC+WgF4f5pV+FpAKTXN9b19n9NRCji5
 9q1iu7aS5l0R5Q8Nyd/8+fEPU/701US1aH8m1VJB4Sl+drqREMcZlljIr4lJBeIYdntuoY
 qo7tKquQvkT+37hiiAHbqypR2qzpGAk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-RurN1rbwOfaXITLIzP_S-g-1; Wed,
 13 Mar 2024 02:41:02 -0400
X-MC-Unique: RurN1rbwOfaXITLIzP_S-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEC5828B7404;
 Wed, 13 Mar 2024 06:41:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85925492BC4;
 Wed, 13 Mar 2024 06:41:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57D3821E6A24; Wed, 13 Mar 2024 07:41:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lukas Stockner <lstockner@genesiscloud.com>,  qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pcie: Support PCIe Gen5/Gen6 link speeds
In-Reply-To: <20240312111631-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 12 Mar 2024 11:19:24 -0400")
References: <20240215012326.3272366-1-lstockner@genesiscloud.com>
 <20240312111631-mutt-send-email-mst@kernel.org>
Date: Wed, 13 Mar 2024 07:41:00 +0100
Message-ID: <87jzm6iqgz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Feb 15, 2024 at 02:23:26AM +0100, Lukas Stockner wrote:
>> diff --git a/qapi/common.json b/qapi/common.json
>> index f1bb841951..867a9ad9b0 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -107,10 +107,14 @@
>>  #
>>  # @16: 16.0GT/s
>>  #
>> +# @32: 32.0GT/s
>> +#
>> +# @64: 64.0GT/s
>> +#
>>  # Since: 4.0
>>  ##
>>  { 'enum': 'PCIELinkSpeed',
>> -  'data': [ '2_5', '5', '8', '16' ] }
>> +  'data': [ '2_5', '5', '8', '16', '32', '64' ] }
>>  
>>  ##
>>  # @PCIELinkWidth:
>> -- 
>
>
> I'll merge this but I really don't know how one documents
> that some enum options have been added since some version
> of qemu.

Common style:

    #
    # @16: 16.0GT/s
    #
    # @32: 32.0GT/s (since 9.0)
    #
    # @64: 64.0GT/s (since 9.0)
    #
    # Since: 4.0
    ##

Please add that for the merge.


