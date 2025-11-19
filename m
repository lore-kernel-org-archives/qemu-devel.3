Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1DCF58C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 19:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLncR-0005Mz-4L; Wed, 19 Nov 2025 14:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLnby-00053e-8n
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:13:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLnbw-0003Zk-UB
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763579579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40h3XLj9+PQ9YtwgX30Ek+MMJ2QDdr/Ci5vXiZEsl2A=;
 b=LYgG10ir+FU4SpT/B7ihc3nfpJ9OCELMtpaPsEn9sxR8WpYzmfu9JdmYLn/5aTUC9nN1S3
 10Eqe5XBiteiwa7dPrcigNDkhVBh72fzKuggFjtUOvKkEDv6KdxZu+/zJrKoRT6cDjDNJQ
 lkr05chC8YXzmBi0gadsesQzsJWDMUg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-ZZ9ZNeNsM7mLeavDfCwX8g-1; Wed,
 19 Nov 2025 14:12:56 -0500
X-MC-Unique: ZZ9ZNeNsM7mLeavDfCwX8g-1
X-Mimecast-MFC-AGG-ID: ZZ9ZNeNsM7mLeavDfCwX8g_1763579572
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EC18180034A; Wed, 19 Nov 2025 19:12:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B313C180047F; Wed, 19 Nov 2025 19:12:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3478021E6A27; Wed, 19 Nov 2025 20:12:47 +0100 (CET)
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
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
In-Reply-To: <bf44d9cd-806a-4d2c-8cff-0a88222959ed@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 19 Nov 2025 19:34:26 +0300")
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
 <bf44d9cd-806a-4d2c-8cff-0a88222959ed@yandex-team.ru>
Date: Wed, 19 Nov 2025 20:12:47 +0100
Message-ID: <875xb5x2ds.fsf@pond.sub.org>
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 19.11.25 16:08, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
>> ---
>>   include/hw/loader.h |  4 +++-
>>   hw/arm/boot.c       |  6 +-----
>>   hw/core/loader.c    |  8 ++++++--
>>   hw/riscv/spike.c    | 10 +---------
>>   4 files changed, 11 insertions(+), 17 deletions(-)
>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>> index d035e72748..6f91703503 100644
>> --- a/include/hw/loader.h
>> +++ b/include/hw/loader.h
>> @@ -188,8 +188,10 @@ ssize_t load_elf(const char *filename,
>>    *
>>    * Inspect an ELF file's header. Read its full header contents into a
>>    * buffer and/or determine if the ELF is 64bit.
>> + *
>> + * Returns true on success, false on failure.
>
> I don't really care, but IMO, it's obvious contract for bool+errp functions, not worth a comment.

Nearby function comments all have a "Returns" sentence.  I try to blend
in :)

>>    */
>> -void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>> +bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>>     ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>>                     bool big_endian, hwaddr target_page_size);


