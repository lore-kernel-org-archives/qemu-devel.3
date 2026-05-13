Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC8FCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 11:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN88v-0005N3-26; Wed, 13 May 2026 07:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN88p-0005ML-DI
 for qemu-devel@nongnu.org; Wed, 13 May 2026 07:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN88n-0007NQ-00
 for qemu-devel@nongnu.org; Wed, 13 May 2026 07:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D/WiZP4Z9cVxnzv744WDIdArz5DQbHcBtGLVDOSGTo=;
 b=chZNPW/8KnD9xGIHDQEDgaGv7POUBh0ES5fQAUUpyMPbdUM8n8bAN1sVdsF2m/4rm9udhy
 YKKLRJtZpCBs0Vllz5vqW1uFM6d98HsFfgnFpnVQkiMNNVKmMQlT3/NksJTKJtdox88IZT
 +NHYkihOMPLfogGvi5d/E+/HlOiH8zM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-GLjbQ08rOTmO4BFL3259mQ-1; Wed,
 13 May 2026 07:52:36 -0400
X-MC-Unique: GLjbQ08rOTmO4BFL3259mQ-1
X-Mimecast-MFC-AGG-ID: GLjbQ08rOTmO4BFL3259mQ_1778673155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE3B195608D; Wed, 13 May 2026 11:52:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757D818004A3; Wed, 13 May 2026 11:52:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92E8521E6A01; Wed, 13 May 2026 13:52:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] hw/nvme: add 'info nvme-queues' HMP command
In-Reply-To: <agJvYo00GNefQNwS@gallifrey> (David Alan Gilbert's message of
 "Tue, 12 May 2026 00:08:02 +0000")
References: <cover.1778409416.git.mateusz.nowicki@posteo.net>
 <786a781251d3898b979656b9e5390e50bb35100f.1778409416.git.mateusz.nowicki@posteo.net>
 <agJvYo00GNefQNwS@gallifrey>
Date: Wed, 13 May 2026 13:52:30 +0200
Message-ID: <87jyt7r0g1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Mateusz Nowicki (mateusz.nowicki@posteo.net) wrote:
>> Add an 'info nvme-queues' HMP command that lists, for every emulated
>> NVMe controller, the admin SQ/CQ and every active I/O SQ/CQ.
>> 
>> For each queue the command prints:
>> 
>>   - the ring size, head and tail indices;
>>   - the associated CQ id (for SQ) or interrupt vector (for CQ);
>>   - the queue's PRP1 (DMA base address of the ring);
>>   - the BAR0-relative doorbell offset (SQyTDBL / CQyHDBL);
>>   - the current CQ phase tag.
>> 
>> The doorbell offsets are computed from CAP.DSTRD so they remain
>> correct if the emulation ever exposes a non-zero stride.
>> 
>> Useful when debugging the Linux NVMe driver against the QEMU
>> emulation - queue setup, doorbell rings, AERs held in the admin SQ
>> etc. - without attaching gdb to the QEMU process.
>> 
>> Example, with the long PRP1 ring address and BAR0-relative doorbell
>> offset replaced by '...'; phase tag column omitted for brevity:
>> 
>>   (qemu) info nvme-queues
>>   /machine/peripheral-anon/device[0]
>>   SQ 0  size=32    head=9     tail=9     cqid=0    prp1=...  SQTDBL=...
>>   CQ 0  size=32    head=8     tail=8     iv=0      prp1=...  CQHDBL=...
>>   SQ 1  size=1024  head=2     tail=2     cqid=1    prp1=...  SQTDBL=...
>>   CQ 1  size=1024  head=2     tail=2     iv=1      prp1=...  CQHDBL=...
>> 
>> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
>
> as the previous patch; looks OK from HMP but check where the json should live.
>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

Same answer.

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


