Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87056C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAHv-0003PY-51; Thu, 20 Mar 2025 03:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvAHg-0003OC-JL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvAHc-0002YI-VY
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742455539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZO8WXhTrRRpiMePU8N0cVb5WgJI184a2nZrBdFGA7Ho=;
 b=ApLPhoDOnaPwxNR17kpvhM+cC+b1lyACVeDvT604o8XuZDuP2n3N7RL9FI8pXXUJrKlDZ5
 43uu8yoWYBdhn1LQZQZ2HV8ua9xIFuMUJaJm/Nb/b3AV5p+020yYyVWyjtZ86pTbKfXvRH
 ElSWt+1ZCbkG4k4/kx1dJE5DvmMSP0c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-vqEk_1nZOBOy-S0HyBtGuw-1; Thu,
 20 Mar 2025 03:25:32 -0400
X-MC-Unique: vqEk_1nZOBOy-S0HyBtGuw-1
X-Mimecast-MFC-AGG-ID: vqEk_1nZOBOy-S0HyBtGuw_1742455531
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5DA21809CA6; Thu, 20 Mar 2025 07:25:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE39180094A; Thu, 20 Mar 2025 07:25:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC52821E66C4; Thu, 20 Mar 2025 08:25:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/6] hw/loongarch/virt: Fix error handling in cpu plug
In-Reply-To: <c1e74ed3-f60a-0bd6-9806-b5ec111e466d@loongson.cn> (bibo mao's
 message of "Thu, 20 Mar 2025 14:30:35 +0800")
References: <20250320032158.1762751-1-maobibo@loongson.cn>
 <20250320032158.1762751-3-maobibo@loongson.cn>
 <875xk4i5wb.fsf@pond.sub.org>
 <c1e74ed3-f60a-0bd6-9806-b5ec111e466d@loongson.cn>
Date: Thu, 20 Mar 2025 08:25:25 +0100
Message-ID: <878qp0go4a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2025/3/20 =E4=B8=8B=E5=8D=882:16, Markus Armbruster wrote:
>> Bibo Mao <maobibo@loongson.cn> writes:
>>=20
>>> In function virt_cpu_plug(), it will send cpu plug message to interrupt
>>> controller extioi and ipi irqchip. If there is problem in this function,
>>> system should continue to run and keep state the same before cpu is
>>> added.
>>>
>>> Object cpuslot::cpu is set at last only when there is no any error.
>>> If there is, send cpu unplug message to extioi and ipi irqchip, and then
>>> return immediately.
>>>
>>> Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

[...]

>> Hmm.
>>=20
>> You're right about the problem: virt_cpu_plug() neglects to revert
>> changes when it fails.
>>=20
>> You're probably right to move the assignment to cpu_slot->cpu to the
>> end.  Anything you can delay until success is assured you don't have to
>> revert.  I say "probably" because the code that now runs before the
>> assignment might theoretically "see" the assignment, and I didn't
>> examine it to exclude that.
>>=20
>> Where I have doubts is the code to revert changes.
>>=20
>> The hotplug_handler_plug() error checkign suggests it can fail.
>>=20
>> Can hotplug_handler_unplug() fail, too?  The error checking in
>> virt_cpu_unplug() right above suggests it can.
>
> Basically from existing code about ipi/extioi hotplug handler, it is
> impossible to there is error, here is only for future use.

Aha.  More at the end of my reply.

> If there is error in function virt_cpu_plug(), undo() such as=20
> hotplug_handler_unplug() should be called. However if undo() reports=20
> error, I do not know how to handle it, here just discard error in=20
> function undo().

Steinbach's Guideline for Systems Programming: Never test for an error
condition you don't know how to handle.

This old quip is a funny way to say that errors we don't know how to
handle are *bad*, and should be avoided.

> Regards
> Bibo Mao
>>=20
>> What happens if it fails in virt_cpu_plug()?

You assure us this can't happen today.  Because of that, broken error
recovery is not an actual problem.

However, if things change some day so it can happen, broken error
recovery becomes an actual problem.

so, broken error recovery just "for future use" is actually just for
silent future breakage.

But is it broken?  This is what I'm trying to find out with my "what
happens if" question.

If it is broken, then passing &error_abort would likely be less bad:
crash instead of silent breakage.  Also makes it completely obvious in
the code that these errors are not handled, whereas broken error
handling looks like it is until you actually think about it.


