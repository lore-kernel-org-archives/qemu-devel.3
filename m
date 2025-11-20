Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D317CCFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 19:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMA5g-0005Vy-Dx; Thu, 20 Nov 2025 14:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA5e-0005VK-Rv
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA5c-0006t7-Uu
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763665987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlhMzPTHuX4cLpmrLyGntMkPW4ErwgtosCfiUCW5AfA=;
 b=IQrmJDW07qCEHt8SrRKibPeDyW+skPO85/Vvr4SoiVG7CmI6MNuuMdti20RBVWGsHmSHit
 kT6l7JoUkNkL3b1adcLb8zl6rQZGoAjcOna20u0+yklMgMSa5wMFEGXyiI64OhWqQxJHuK
 LXAaRTMMchELQF4JlGhzZSogKDdB/DQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-FjAiVakzPqqK6eg0tFZr0Q-1; Thu,
 20 Nov 2025 14:13:03 -0500
X-MC-Unique: FjAiVakzPqqK6eg0tFZr0Q-1
X-Mimecast-MFC-AGG-ID: FjAiVakzPqqK6eg0tFZr0Q_1763665980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1531800370; Thu, 20 Nov 2025 19:12:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A99730044DC; Thu, 20 Nov 2025 19:12:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 214AA21E6A27; Thu, 20 Nov 2025 20:12:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 mst@redhat.com,  imammedo@redhat.com,  anisinha@redhat.com,
 gengdongjiu1@gmail.com,  peter.maydell@linaro.org,
 alistair@alistair23.me,  edgar.iglesias@gmail.com,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  palmer@dabbelt.com,  liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com,  sstabellini@kernel.org,
 anthony@xenproject.org,  paul@xen.org,  berrange@redhat.com,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 zhao1.liu@intel.com,  qemu-block@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
In-Reply-To: <072c1f11-1bb4-6f19-f847-e4ba07c148c3@eik.bme.hu> (BALATON
 Zoltan's message of "Thu, 20 Nov 2025 13:55:13 +0100 (CET)")
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
 <4fb0a736-4450-47c0-9f9e-6cb86a3b28ea@ventanamicro.com>
 <072c1f11-1bb4-6f19-f847-e4ba07c148c3@eik.bme.hu>
Date: Thu, 20 Nov 2025 20:12:54 +0100
Message-ID: <873468tt55.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 20 Nov 2025, Daniel Henrique Barboza wrote:
>> On 11/19/25 10:08 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> Nice cleanup
>>
>>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

[...]

>>> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>>> index b0bab3fe00..8531e1d121 100644
>>> --- a/hw/riscv/spike.c
>>> +++ b/hw/riscv/spike.c
>>> @@ -180,15 +180,7 @@ static void create_fdt(SpikeState *s, const 
>>> MemMapEntry *memmap,
>>>     static bool spike_test_elf_image(char *filename)
>>>   {
>>> -    Error *err = NULL;
>>> -
>>> -    load_elf_hdr(filename, NULL, NULL, &err);
>>> -    if (err) {
>>> -        error_free(err);
>>> -        return false;
>>> -    } else {
>>> -        return true;
>>> -    }
>>> +    return load_elf_hdr(filename, NULL, NULL, NULL);
>
> Does it worth to keep this function or could just be inlined at the two 
> callers now that it's equivalent with load_elf_hdr?

Palmer, Alistair, Daniel, got a preference?


