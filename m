Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247F9D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 14:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOzsC-0003mE-71; Fri, 28 Nov 2025 09:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOzs8-0003lc-KI
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOzs5-0005Ki-6T
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764341691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gO9sWONquAHYPTTdxlNvhNVMmYUgp2JazDEYXr9Z5FI=;
 b=Hgl9M9EY+r9Xq9sza4jM9nYwJXBJdw70EaueB7wvChtVwGcdlEQKc6/SP2/ybYxK29wZWR
 dPvobYKMQIn3o2ik7UQ6KCxBjTuA/Pe5XHkFVL6dT8ipm+/ZqOv+6dDulnBJI/TkmUtb0m
 vNQFlYbqjJ2fOV4UrNypVzWVaMnx4UE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-7NsfSnA9MF-1-mwlfvcNkw-1; Fri,
 28 Nov 2025 09:54:47 -0500
X-MC-Unique: 7NsfSnA9MF-1-mwlfvcNkw-1
X-Mimecast-MFC-AGG-ID: 7NsfSnA9MF-1-mwlfvcNkw_1764341686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E09195609E; Fri, 28 Nov 2025 14:54:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A4531800947; Fri, 28 Nov 2025 14:54:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7151B21E6A27; Fri, 28 Nov 2025 15:54:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com,  mst@redhat.com,  anisinha@redhat.com,
 gengdongjiu1@gmail.com,  peter.maydell@linaro.org,  pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH 3/5] target/arm/kvm: Exit on error from
 acpi_ghes_memory_errors()
In-Reply-To: <20251128150721.390604e9@imammedo> (Igor Mammedov's message of
 "Fri, 28 Nov 2025 15:07:21 +0100")
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-4-gshan@redhat.com>
 <20251128150721.390604e9@imammedo>
Date: Fri, 28 Nov 2025 15:54:42 +0100
Message-ID: <87a5061a31.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 27 Nov 2025 10:44:33 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>
>> A core dump is no sense as there isn't programming bugs related to
>> errors from acpi_ghes_memory_errors().
>> 
>> Exit instead of abort when the function returns errors, and the
>> excessive error message is also dropped.
>> 
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>  target/arm/kvm.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 0d57081e69..acda0b3fb4 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2460,8 +2460,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                                               paddr)) {
>>                      kvm_inject_arm_sea(c);
>>                  } else {
>> -                    error_report("failed to record the error");
>
> so with message gone, user will just see qemu silently exit?

No: acpi_ghes_memory_errors() reports with error_report().

But the stub doesn't.  If it can be called, it needs a suitable
error_report().  It it can't be called, it should abort().

>> -                    abort();
>> +                    exit(1);
>>                  }
>>              }
>>              return;


