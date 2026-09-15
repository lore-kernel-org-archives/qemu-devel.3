Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE98C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RnN-0005DE-8j; Tue, 15 Sep 2026 07:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6RnL-0005Co-Fi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6RnJ-0008GN-2O
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789473467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cE66EXTqJcXgw8SyQfiuDOkHC8+JHm/gkM/apYzcEg8=;
 b=O1ZB7KIS7/pI1K/4UHtmiD0lU6QFr5Vjjm6vXNBEKvSawP6byabH6OEDirQ31btFXDUAn2
 trM/N5ALojHM6ByDn+RuGLKyksykcJHHgOjmU/w//+9CY6B+4iojG7Tzn4tD5JUnoM4njE
 QL68F8XTGh3MIDbytVtCSyO4hZHqq2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-nm0l6TzHMv6joifP7FtGPQ-1; Tue,
 15 Sep 2026 07:57:43 -0400
X-MC-Unique: nm0l6TzHMv6joifP7FtGPQ-1
X-Mimecast-MFC-AGG-ID: nm0l6TzHMv6joifP7FtGPQ_1789473462
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B463183019B; Tue, 15 Sep 2026 11:57:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E3E21956055; Tue, 15 Sep 2026 11:57:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81EB721E6A04; Tue, 15 Sep 2026 13:57:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 12/20] migration: Change HMP 'info
 migrate_parameters' output
In-Reply-To: <20260915000209.3692668-13-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 14 Sep 2026 21:02:00 -0300")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-13-farosas@suse.de>
Date: Tue, 15 Sep 2026 13:57:37 +0200
Message-ID: <87bj9ypw0e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> The output of 'info migrate_parameters' includes units of measurement
> for a few parameters. This is convenient for a user. However, having
> the units also means that every parameter must have its own separate
> piece of code to handle the formatting.
>
>>From a development and maintenance perspective, having a list of
> parameters explicitly written in several parts of the code brings
> annoyances: conflicts during rebase, extra hits when grepping,
> contributors need to mirror a change to various locations, etc.
>
> As the HMP output is not part of any ABI, remove the units from the
> output to avoid this requirement of having individualized code for
> every parameter. Next patches will take benefit from that and use
> generic code to output the parameters values in HMP.
>
> Aside from the units, also remove quotes from around the TLS options
> strings as this is inconsistent with all the other strings.
>
> Similarly, change block-bitmap-mapping format to remove the arrows
> (->) for the mappings as not all parameters represented as a list have
> this semantics. This requires updating one of the iotests.
>
> Before:                                      After:
>                      (unchanged entries omitted)
> announce-initial: 50 ms                      announce-initial: 50
> announce-max: 550 ms                         announce-max: 550
> announce-rounds: 5                           announce-rounds: 5
> announce-step: 100 ms                        announce-step: 100
> tls-creds: ''                                tls-creds:
> tls-hostname: ''                             tls-hostname:
> tls-authz: ''                                tls-authz:
> max-bandwidth: 134217728 bytes/second        max-bandwidth: 134217728
> avail-switchover-bandwidth: 0 bytes/second   avail-switchover-bandwidth: 0
> max-postcopy-bandwidth: 0 bytes/second       max-postcopy-bandwidth: 0
> downtime-limit: 300 ms                       downtime-limit: 300
> x-checkpoint-delay: 20000 ms                 x-checkpoint-delay: 20000
> xbzrle-cache-size: 67108864 bytes            xbzrle-cache-size: 67108864
> x-vcpu-dirty-limit-period: 1000 ms           x-vcpu-dirty-limit-period: 1000
> vcpu-dirty-limit: 1 MB/s                     vcpu-dirty-limit: 1
> x-rdma-chunk-size: 1048576 bytes             x-rdma-chunk-size: 1048576
> block-bitmap-mapping:                        block-bitmap-mapping:
>   'node-src' -> 'node-dst'                    bitmaps:
>     'bmap0' -> 'bmap0'                        name: bmap0 alias: bmap0
>                                               node-name: node-src alias: node-dst

I think the value of block-bitmap-mapping could be more legible.

@block-bitmap-mapping has the following structure (using JSON as
notation):

    [{"node-name": NODE-NAME1, "alias": NODE-ALIAS1,
      "bitmaps": [{"name": BITMAP-NAME1.1, "alias": BITMAP-ALIAS1.1,
                   "transform": {"persistent": PERS1.1}}
                  {"name": BITMAP-NAME1.2, "alias": BITMAP-ALIAS1.2,
                   "transform": {"persistent": PERS1.2}},
                   ...]},
     {"node-name": NODE-NAME2, "alias": NODE-ALIAS2,
      "bitmaps": [{"name": BITMAP-NAME2.1, ...}, ...]},
      ...]

As far as I can tell, it gets formatted like

    block-bitmap-mapping:
     bitmaps:
     name: BITMAP-NAME1.1 transform: persistent: PERS1.1 alias: ALIAS-NAME1.1
     name: BITMAP-NAME1.2 transform: persistent: PERS1.2 alias: ALIAS-NAME1.2
     node-name: NODE-NAME1 alias: NODE-ALIAS1
     name: BITMAP-NAME2.1 ...
     node-name: NODE-NAME2 alias: NODE-ALIAS2

Suggest to do it more like this

    block-bitmap-mapping:
      node-name: NODE-NAME1 alias: NODE-ALIAS1
        bitmaps:
          name: BITMAP-NAME1.1 alias: BITMAP-ALIAS1.1 persistent: PERS1.1
          name: BITMAP-NAME1.2 alias: BITMAP-ALIAS1.2 persistent: PERS1.2
      node-name: NODE-NAME2 alias: NODE-ALIAS2
        bitmaps:
          name: BITMAP-NAME2.1 ...

Or just dump as pretty-printed JSON and call it good.


