Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28753CFA476
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJyy-0001bl-Pu; Fri, 21 Nov 2025 00:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMJyn-0001Sf-Uh
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMJyl-0002Qv-Bd
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763704002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PL3yXLCkMFHCIh38uQXNnEtvLjSg5S3Sh+k5cm/3Mtg=;
 b=AWzxg42dSd5RBdEO7IpzgpYuniOsKzq+2dQdw8SCTJwUrAKvLXjjLZkJK//W5g/CZJumZD
 X/sxbhTz0Jehpq5LqGNJi9y3vwFrnrxlqca/Q5Gs8c4m/aLnU4tyUmZ+HvjjDT3+bpq3AR
 BCnFlBSGvixEZCFZpZrJyKltyqPkeT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-dw4h8ppxNGOwFwV5lUYlYA-1; Fri,
 21 Nov 2025 00:46:38 -0500
X-MC-Unique: dw4h8ppxNGOwFwV5lUYlYA-1
X-Mimecast-MFC-AGG-ID: dw4h8ppxNGOwFwV5lUYlYA_1763703994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBBCD1956050; Fri, 21 Nov 2025 05:46:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8A430044DC; Fri, 21 Nov 2025 05:46:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FAF521E6A27; Fri, 21 Nov 2025 06:46:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com,
 pizhenwei@bytedance.com,  alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com,  kwolf@redhat.com,  hreitz@redhat.com,
 sw@weilnetz.de,  qemu_oss@crudebyte.com,  groug@kaod.org,
 mst@redhat.com,  imammedo@redhat.com,  anisinha@redhat.com,
 kraxel@redhat.com,  shentey@gmail.com,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  sstabellini@kernel.org,  anthony@xenproject.org,
 paul@xen.org,  edgar.iglesias@gmail.com,  elena.ufimtseva@oracle.com,
 jag.raman@oracle.com,  sgarzare@redhat.com,  pbonzini@redhat.com,
 fam@euphon.net,  philmd@linaro.org,  alex@shazbot.org,  clg@redhat.com,
 peterx@redhat.com,  farosas@suse.de,  lizhijian@fujitsu.com,
 jasowang@redhat.com,  samuel.thibault@ens-lyon.org,
 michael.roth@amd.com,  kkostiuk@redhat.com,  zhao1.liu@intel.com,
 mtosatti@redhat.com,  rathc@linux.ibm.com,  palmer@dabbelt.com,
 liwei1518@gmail.com,  dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,  marcandre.lureau@redhat.com,
 qemu-block@nongnu.org,  qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org,  kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 11/14] error: Use error_setg_errno() to improve error
 messages
In-Reply-To: <aR-t5SzR2AdqlJtq@gallifrey> (David Alan Gilbert's message of
 "Fri, 21 Nov 2025 00:10:13 +0000")
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-12-armbru@redhat.com>
 <aR-t5SzR2AdqlJtq@gallifrey>
Date: Fri, 21 Nov 2025 06:46:28 +0100
Message-ID: <87o6owq6ob.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> A few error messages show numeric errno codes.  Use error_setg_errno()
>> to show human-readable text instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> ...
>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 337b415889..ef4885ef5f 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2349,8 +2349,7 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
>>          error_setg(errp, "RDMA ERROR: poll cm event timeout");
>>          return -1;
>>      } else if (ret < 0) {
>> -        error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
>> -                   errno);
>> +        error_setg_errno(errp, "RDMA ERROR: failed to poll cm event");
>
> Hasn't that lost the errno ?

Yes.  My build tree must have lost the ability to compile this file.  I
need to fix that.

Thanks!


