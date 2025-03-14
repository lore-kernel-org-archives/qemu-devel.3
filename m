Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD64C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 05:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsxkc-00062S-Vu; Fri, 14 Mar 2025 01:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsxkY-00060O-6c
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsxkW-0001B3-9S
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741930702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9Z2Rtg4ACrAEKd+XksEAetapjE5uBGfuAYUBunNPpY=;
 b=cRFcQ2rU95AsG4ZCvzqVw/Ylc/hoXlNdhpPWh1AjLqtaGc8U3CiZOvRxjSv6iaBdVnI/6r
 d6/tsDMl3erX+8o3bKskuvQTAUT9dPdLxKr72QEbert1Xw2Y+LNGU86btdQTwLRoeuYMYg
 iNd33r0MSzeqqF0NEsUHg5jaX41Ct9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-CX7r5WTIOhKCrLB3IX1dkA-1; Fri,
 14 Mar 2025 01:38:15 -0400
X-MC-Unique: CX7r5WTIOhKCrLB3IX1dkA-1
X-Mimecast-MFC-AGG-ID: CX7r5WTIOhKCrLB3IX1dkA_1741930694
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C4E19560B8; Fri, 14 Mar 2025 05:38:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E37B31828A98; Fri, 14 Mar 2025 05:38:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57D6421E675F; Fri, 14 Mar 2025 06:38:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
In-Reply-To: <10c55e3e-22f5-285d-7e38-3a6a08089302@loongson.cn> (bibo mao's
 message of "Fri, 14 Mar 2025 10:27:04 +0800")
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-3-maobibo@loongson.cn>
 <875xkdb4q5.fsf@pond.sub.org>
 <10c55e3e-22f5-285d-7e38-3a6a08089302@loongson.cn>
Date: Fri, 14 Mar 2025 06:38:09 +0100
Message-ID: <87v7scw4se.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bibo mao <maobibo@loongson.cn> writes:

On 2025/3/13 =E4=B8=8B=E5=8D=886:32, Markus Armbruster wrote:

[...]

>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..4674bd9163 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotp=
lug_dev,
>>      LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
>>      CPUState *cs =3D CPU(dev);
>>      CPUArchId *cpu_slot;
>> -    Error *err =3D NULL;
>>      LoongArchCPUTopo topo;
>>      int arch_id;
>>=20=20=20
>>      if (lvms->acpi_ged) {
>>          if ((cpu->thread_id < 0) || (cpu->thread_id >=3D ms->smp.thread=
s)) {
>> -            error_setg(&err,
>> +            error_setg(errp,
>>                         "Invalid thread-id %u specified, must be in rang=
e 1:%u",
>>                         cpu->thread_id, ms->smp.threads - 1);
>> -            goto out;
>> +            return;
>
> Hi Markus,
>
>  From APIs, it seems that function error_propagate() do much more than=20
> error appending, such as comparing dest_err with error_abort etc. Though=
=20
> caller function is local variable rather than error_abort/fatal/warn,=20
> error_propagate() seems useful. How about do propagate error and return=20
> directly as following:
>
> @@ -868,7 +868,8 @@ static void virt_cpu_pre_plug(HotplugHandler=20
> *hotplug_dev,
>              error_setg(&err,
>                         "Invalid thread-id %u specified, must be in=20
> range 1:%u",
>                         cpu->thread_id, ms->smp.threads - 1);
> -            goto out;
> +            error_propagate(errp, err);
> +            return;
>          }

This is strictly worse.  One, it's more verbose.  Two, the stack
backtrace on failure is less useful, which matters when @errp is
&error_abort, and when you set a breakpoint on error_handle(), abort(),
or exit().  Three, it doesn't actually add useful functionality.

To help you see the latter, let's compare the two versions, i.e.

   direct: error_setg(errp, ...)

and

   propagate: two steps, first error_setg(&err, ...), and then
   error_propagate(errp, err);

Cases: @errp can be NULL, &error_abort, &error_fatal, &error_warn, or a
non-null pointer to variable containing NULL.

1. @errp is NULL

   Direct does nothing.

   Propagate step 1 creates an error object, and stores it in @err.
   Step 2 frees the error object.  Roundabout way to do nothing.

2. @errp is &error_abort

   Direct creates an error object, reports it to stderr, and abort()s.
   Note that the stack backtrace shows where the error is created.

   Propagate step 1 creates an error object, and stores it in @err.
   Step 2 reports it to stderr, and abort()s.  No difference, except the
   stack backtrace shows where the error is propagated, which is less
   useful.

3. @errp is &error_fatal

   Direct creates an error object, reports it to stderr, frees it, and
   exit(1)s.

   Propagate step 1 creates an error object, and stores it in @err.
   Step 2 reports it to stderr, frees it, and exit(1)s.  No difference.

4. @errp is &error_warn

   Direct creates an error object, reports it to stderr, and frees it.

   Propagate step 1 creates an error object, and stores it in @err.
   Step 2 reports it to stderr, and frees it.  No difference.

5. @errp points to variable containing NULL

   Direct creates an error object, and stores it in the variable.

   Propagate step 1 creates an error object, and stores it in @err.
   Step 2 copies it to the variable.  No difference.

Questions?

[...]


