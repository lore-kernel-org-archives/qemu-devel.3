Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD63CF58CC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 19:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLnaA-0003x4-0p; Wed, 19 Nov 2025 14:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLna9-0003wv-0t
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLna5-0003Sv-Ej
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763579463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wt/fub6z3HxiVa5B4/hE5RzRQKQVhOj7h1C0uZV+h1o=;
 b=fMShJisjfib4WijbCPZ7VXxKyPY5XaEQR/g2zxX9htbFCBmBLtph0cmuv49g2W6+j8vHXW
 ht3YpMYQ6Hy/AA+4BhaSjnvvXLX8A/Phv+Oog3RAIRlEVcCOKNWRxjQhiO7ZFQcHHgR2F9
 8eq0OpQ/XHM917cj9ODBdzLBVUMpV0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-yNpZLchdNUuuTavbCUxFWQ-1; Wed,
 19 Nov 2025 14:10:59 -0500
X-MC-Unique: yNpZLchdNUuuTavbCUxFWQ-1
X-Mimecast-MFC-AGG-ID: yNpZLchdNUuuTavbCUxFWQ_1763579455
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96A13195608F; Wed, 19 Nov 2025 19:10:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B530180047F; Wed, 19 Nov 2025 19:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E69F421E6A27; Wed, 19 Nov 2025 20:10:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 mst@redhat.com,  imammedo@redhat.com,  anisinha@redhat.com,
 gengdongjiu1@gmail.com,  peter.maydell@linaro.org,
 alistair@alistair23.me,  edgar.iglesias@gmail.com,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  palmer@dabbelt.com,  liwei1518@gmail.com,
 dbarboza@ventanamicro.com,  zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org,  anthony@xenproject.org,  paul@xen.org,
 berrange@redhat.com,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  eduardo@habkost.net,  marcel.apfelbaum@gmail.com,
 philmd@linaro.org,  wangyanan55@huawei.com,  zhao1.liu@intel.com,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,  xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/5] hw/nvram/xlnx-bbram: More idiomatic and simpler
 error reporting
In-Reply-To: <a36f938d-b35a-4605-ab77-6ed7dd419945@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 19 Nov 2025 19:39:14 +0300")
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-3-armbru@redhat.com>
 <a36f938d-b35a-4605-ab77-6ed7dd419945@yandex-team.ru>
Date: Wed, 19 Nov 2025 20:10:49 +0100
Message-ID: <87a50hx2h2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 19.11.25 16:08, Markus Armbruster wrote:
>> bbram_bdrv_error() interpolates a "detail" string into a template with
>> error_setg_errno(), then reports the result with error_report().
>> Produces error messages with an unwanted '.':
>>
>>      BLK-NAME: BBRAM backstore DETAIL failed.: STERROR
>>
>> Replace both calls of bbram_bdrv_error() by straightforward
>> error_report(), and drop the function.  This is less code, easier to
>> read, and the error message is more greppable.
>>
>> Also delete the unwanted '.'.
>
> Also, using "errp" name for local "Error *" (one star) variable is a bit misleading.

True.  I don't mention it, because I delete the variable.

My search for misleading uses of @errp led me here.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!


