Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 05:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIgci-0003eG-Vj; Tue, 11 Nov 2025 00:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIgcd-0003bZ-St
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 00:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIgcb-0000O6-A9
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 00:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762837727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12g85iCdCp1+GVbwWJx8GuCkJ0Ggke6K+P2042nRwdg=;
 b=OMXyamh2e/PnmmdcNtBpzdJqjq8PYX5N9tcx8naiJ/gPRceWkbba574AtS8KddPPEosCwc
 d6tcX6eNnrUa8JdPzJ8yMihgDZYFDGXmyS+iqW3pUoDE5oBz07YblkG5AKn5cAENs9iisT
 p3lTzsJ51kkpTT0GXz6daKDAKwpSeW8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-lrEmkTNvNAKNXA_SYkrzZQ-1; Tue,
 11 Nov 2025 00:08:46 -0500
X-MC-Unique: lrEmkTNvNAKNXA_SYkrzZQ-1
X-Mimecast-MFC-AGG-ID: lrEmkTNvNAKNXA_SYkrzZQ_1762837724
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45E8D1956061; Tue, 11 Nov 2025 05:08:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94279195608E; Tue, 11 Nov 2025 05:08:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 082E821E6A27; Tue, 11 Nov 2025 06:08:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org,  gengdongjiu1@gmail.com,  mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  peter.maydell@linaro.org,
 pbonzini@redhat.com,  shan.gavin@gmail.com
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
In-Reply-To: <2c3b388e-e002-466a-9b03-cafefcfc9d19@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 10 Nov 2025 15:54:07
 +0100")
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com>
 <2c3b388e-e002-466a-9b03-cafefcfc9d19@linaro.org>
Date: Tue, 11 Nov 2025 06:08:40 +0100
Message-ID: <87v7jhgnqf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 5/11/25 12:44, Gavin Shan wrote:
>> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
>> explicitly call abort() on errors. With this change, its return value
>> isn't needed any more.
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/acpi/ghes-stub.c    |  6 +++---
>>   hw/acpi/ghes.c         | 15 ++++-----------
>>   include/hw/acpi/ghes.h |  5 +++--
>>   target/arm/kvm.c       | 10 +++-------
>>   4 files changed, 13 insertions(+), 23 deletions(-)
>
>
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index f73908985d..35c7bbbb01 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table=
_data,
>>                        const char *oem_id, const char *oem_table_id);
>>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>                             GArray *hardware_errors);
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addres=
ses);
>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addre=
sses,
>> +                             Error **errp);
>
> This is an anti-pattern w.r.t. commit e3fe3988d78 ("error: Document
> Error API usage rules"), because it can be called with an errp distinct
> of &error_abort.
>
> If you really want to abort(), remove the errp argument, directly call
> abort() and rename as acpi_ghes_memory_abort_on_errors().

Since there are no callers that do not want abort() on error, this is
fine.

I think your patch is also fine in princple, but a few details are
wrong.  I'll point them out inline.

[...]


