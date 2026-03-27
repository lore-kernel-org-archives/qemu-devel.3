Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1D10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Ji-0002ld-8N; Fri, 27 Mar 2026 07:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w65JM-0002Wk-Iv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w65JK-0002Y1-2D
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774610703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNCT5ZoHgHqOwm6hSuQVycDXB94uRJgvK7uT2R8m9o8=;
 b=GrK5QXnp10YCuz1RhgHRr9KQBksBh+84y24JBS3RkmxBw7/H8MEk4oKkh5LYMmxLWOdOO3
 Ql+Vi+fGLb0nlRVF5JoZbF5f7oSJ21zfCJ5ebZO2DP6NsKbT2WjSJAKNn8oEua2+Vxmuxh
 zpYbKhf89rbyj6E+zBLOHjoEL7OHLTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-kqBgc_Q_ObOA5yxSaUVCaw-1; Fri,
 27 Mar 2026 07:25:00 -0400
X-MC-Unique: kqBgc_Q_ObOA5yxSaUVCaw-1
X-Mimecast-MFC-AGG-ID: kqBgc_Q_ObOA5yxSaUVCaw_1774610698
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CBD019560AE; Fri, 27 Mar 2026 11:24:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2D7F1955D84; Fri, 27 Mar 2026 11:24:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABAE821E6937; Fri, 27 Mar 2026 12:24:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,  <qemu-devel@nongnu.org>,
 <peterx@redhat.com>,  <farosas@suse.de>,  <lizhijian@fujitsu.com>,
 <eblake@redhat.com>,  <Emily.Deng@amd.com>,  <Victor.Zhao@amd.com>,
 <PengJu.Zhou@amd.com>,  <Qing.Ma@amd.com>
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
In-Reply-To: <9b6b3d6a-4f48-4e90-b2fc-7cfcc6c8651d@amd.com> (GuoQing Zhang's
 message of "Fri, 27 Mar 2026 18:27:07 +0800")
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <87h5q17gh8.fsf@pond.sub.org>
 <9b6b3d6a-4f48-4e90-b2fc-7cfcc6c8651d@amd.com>
Date: Fri, 27 Mar 2026 12:24:55 +0100
Message-ID: <87y0jd5xbs.fsf@pond.sub.org>
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

"Zhang, GuoQing (Sam)" <guoqzhan@amd.com> writes:

> On 2026/3/27 17:45, Markus Armbruster wrote:
>> Samuel Zhang <guoqing.zhang@amd.com> writes:
>>
>>> The default 1MB RDMA chunk size causes slow live migration because
>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>>
>>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>>> faster migration.
>>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>>
>>> Performance with RDMA live migration of 8GB RAM VM:
>>>
>>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>>> |-----------------------|----------|-------------------|
>>> | 1M (default)          | 37.915   |  1,007            |
>>> | 32M                   | 17.880   |  2,260            |
>>> | 1024M                 |  4.368   | 17,529            |
>>>
>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

[...]

>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 7134d4ce47..292d96c95a 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -806,7 +806,7 @@
>>>  #
>>>  # Features:
>>>  #
>>> -# @unstable: Members @x-checkpoint-delay and
>>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>>  #
>>>  # Since: 2.4
>>> @@ -831,6 +831,7 @@
>>>             'mode',
>>>             'zero-page-detection',
>>>             'direct-io',
>>> +           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>>>             'cpr-exec-command'] }
>>>  
>>>  ##
>>> @@ -1007,9 +1008,14 @@
>>>  #     is @cpr-exec.  The first list element is the program's filename,
>>>  #     the remainder its arguments.  (Since 10.2)
>>>  #
>>> +# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
>>> +#     Default is 1MiB.  Must be a power of 2 in the range
>>> +#     [1MiB, 1024MiB].  Only takes effect for RDMA migration.
>>
>> I believe it applies to channels whose migration address type is is
>> "rdma".  In MigrationChannel syntax
>>
>>      {"channel-type": ..., "addr": {"transport": "rdma", ...}}
>>
>> Correct?
>
>
> Correct! Is it OK to update the doc to the following one? Thank you!
>
> `Only takes effect when migration address transport is "rdma".`

The phrasing in the patch feels okay as is.  Perhaps "Only applies when
migrating via RDMA" to more closely match the description of
MigrationAddressType @rdma: Migrate via RDMA.

Either way, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

>>> +#     (Since 11.1)
>>> +#
>>>  # Features:
>>>  #
>>> -# @unstable: Members @x-checkpoint-delay and
>>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>>  #
>>>  # Since: 2.4
>>> @@ -1046,6 +1052,8 @@
>>>              '*mode': 'MigMode',
>>>              '*zero-page-detection': 'ZeroPageDetection',
>>>              '*direct-io': 'bool',
>>> +            '*x-rdma-chunk-size': { 'type': 'uint64',
>>> +                                    'features': [ 'unstable' ] },
>>>              '*cpr-exec-command': [ 'str' ]} }
>>  
>>>  ##


