Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D290DCFA473
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJhI-0007Tp-A2; Fri, 21 Nov 2025 00:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMJhD-0007Sm-S9
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMJh9-0005Fe-VN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763702911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEd9KlDvB7GskRmSaCjimoNXVvT4vORaDdSrmiFotWU=;
 b=irbbejLQ1p4WjQe3+gDVVpgAjq771xWpd2vSptQIF31tUlINS6/39TWnK/o7cPnKBol3mY
 sXrXm7lW4azxIz8Z5SarJ93hrVxueSb/imFIKDKUzkxa4KWJacXczgiAgPRE3MIjFNkOW2
 g4QRWv7aJSASOGzFwduy33991uIHdw0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-m_eSFKIbNuOvbL9nfv2Tzg-1; Fri,
 21 Nov 2025 00:28:26 -0500
X-MC-Unique: m_eSFKIbNuOvbL9nfv2Tzg-1
X-Mimecast-MFC-AGG-ID: m_eSFKIbNuOvbL9nfv2Tzg_1763702902
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C049180049F; Fri, 21 Nov 2025 05:28:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D431940E82; Fri, 21 Nov 2025 05:28:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF74721E6A27; Fri, 21 Nov 2025 06:28:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com,
 alistair.francis@wdc.com,  stefanb@linux.vnet.ibm.com,  kwolf@redhat.com,
 hreitz@redhat.com,  sw@weilnetz.de,  qemu_oss@crudebyte.com,
 groug@kaod.org,  mst@redhat.com,  imammedo@redhat.com,
 anisinha@redhat.com,  kraxel@redhat.com,  shentey@gmail.com,
 npiggin@gmail.com,  harshpb@linux.ibm.com,  sstabellini@kernel.org,
 anthony@xenproject.org,  paul@xen.org,  edgar.iglesias@gmail.com,
 elena.ufimtseva@oracle.com,  jag.raman@oracle.com,  sgarzare@redhat.com,
 pbonzini@redhat.com,  fam@euphon.net,  philmd@linaro.org,
 alex@shazbot.org,  clg@redhat.com,  peterx@redhat.com,  farosas@suse.de,
 lizhijian@fujitsu.com,  jasowang@redhat.com,
 samuel.thibault@ens-lyon.org,  michael.roth@amd.com,
 kkostiuk@redhat.com,  zhao1.liu@intel.com,  mtosatti@redhat.com,
 rathc@linux.ibm.com,  palmer@dabbelt.com,  liwei1518@gmail.com,
 dbarboza@ventanamicro.com,  zhiwei_liu@linux.alibaba.com,
 marcandre.lureau@redhat.com,  qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,  xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org
Subject: Re: [PATCH 02/14] hw/usb: Use error_setg_file_open() for a better
 error message
In-Reply-To: <aR-1jGX4Ck0f69zG@gallifrey> (David Alan Gilbert's message of
 "Fri, 21 Nov 2025 00:42:52 +0000")
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-3-armbru@redhat.com>
 <aR-1jGX4Ck0f69zG@gallifrey>
Date: Fri, 21 Nov 2025 06:28:14 +0100
Message-ID: <873468rm35.fsf@pond.sub.org>
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
>> The error message changes from
>> 
>>     open FILENAME failed
>> 
>> to
>> 
>>     Could not open 'FILENAME': REASON
>> 
>> where REASON is the value of strerror(errno).
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/usb/bus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
>> index 8dd2ce415e..47d42ca3c1 100644
>> --- a/hw/usb/bus.c
>> +++ b/hw/usb/bus.c
>> @@ -262,7 +262,7 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
>>          int fd = qemu_open_old(dev->pcap_filename,
>>                                 O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
>>          if (fd < 0) {
>> -            error_setg(errp, "open %s failed", dev->pcap_filename);
>> +            error_setg_file_open(errp, errno, dev->pcap_filename);
>
> Wouldn't it be easier to flip it to use qemu_open() ?

Mechanical change; I missed the obvious :)

I'll give it a try, along with the call in ui/ui-qmp-cmd.c [PATCH 09].
Thanks!

>
> Dave
>
>>              usb_qdev_unrealize(qdev);
>>              return;
>>          }
>> -- 
>> 2.49.0
>> 


