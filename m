Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C4CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62aJ-0002Ew-5H; Tue, 07 Oct 2025 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v62aH-0002EY-Nf
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v62aG-0008De-9w
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759823887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ElF+1qd85RgZC5JlCsyBDTUMzLLkSrdoteNN6Gn3Wdo=;
 b=KYGnCGymlqcIL+5kqtKcYH6tB5ha6z+sY7x1Mpm2EXl8pVoah5m3/oZYN6qQVZwYDeGNj3
 PCsd4m7UsDO4jIAYK5Wj3mZ7HOv1T8vtxep9CpunFZPS8igcXk+Bpa+bzEk9KpA22uiveL
 906OrzO6AaKeoJOd1UqRIh30Y796UYg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-h_pxeo-HMM2TFKiyfJW2Vw-1; Tue,
 07 Oct 2025 03:58:04 -0400
X-MC-Unique: h_pxeo-HMM2TFKiyfJW2Vw-1
X-Mimecast-MFC-AGG-ID: h_pxeo-HMM2TFKiyfJW2Vw_1759823883
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A47919560B3; Tue,  7 Oct 2025 07:58:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC33930002CE; Tue,  7 Oct 2025 07:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52D2121E6A27; Tue, 07 Oct 2025 09:58:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Chandan <csomani@redhat.com>,  qemu-devel@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  "open
 list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH] block: enable stats-intervals for virtio-blk devs with
 -blockdev
In-Reply-To: <aNvJGWApjqZTJFpV@redhat.com> (Kevin Wolf's message of "Tue, 30
 Sep 2025 14:12:09 +0200")
References: <20250929235244.686567-1-csomani@redhat.com>
 <aNvJGWApjqZTJFpV@redhat.com>
Date: Tue, 07 Oct 2025 09:58:00 +0200
Message-ID: <87ikgri1o7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 30.09.2025 um 01:52 hat Chandan geschrieben:
>> This patch allows the stats-intervals.* flag to be used with
>> -blockdev. Stats collection is initialized for virtio-blk devices
>> at their time of creation. However, it is limited to just virtio-blk
>> devices for now.
>> 
>> Signed-off-by: Chandan <csomani@redhat.com>

[...]

>>  struct BlockBackendRootState {
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index dc6eb4ae23..dbb53296b1 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4771,6 +4771,9 @@
>>  # @force-share: force share all permission on added nodes.  Requires
>>  #     read-only=true.  (Since 2.10)
>>  #
>> +# @stats-intervals: #optional list of intervals for collecting I/O
>> +#                   statistics, in seconds (default: none)
>
> #optional is not a marker that is used anywhere else.

Because it gets rendered like this:

      * stats-intervals ([int], *optional*) -- #optional list of
        intervals for collecting I/O statistics, in seconds (default:
        none)

Drop it, please.

[...]


