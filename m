Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0034EC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tupAk-0003Mo-BF; Wed, 19 Mar 2025 04:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tupAh-0003Lr-Nc
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tupAg-0007M1-2A
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742374384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C92hBXnysuak+24tdj+yY5c+42bdE0sQG5DkJrTpHAo=;
 b=gn1hQy2KFQYsGL904TCwcICom8M+kOhojjB3nZAmqMNnWGxc5X7tja9j5deXXNWnt+n+jn
 L4+4aFzVhIsu74FOLKbeQLSPKxJhBAlGIYGyqn0E4tOzys2m+Zb45ryn/dgcrw2ee/fXED
 r0bTtxho5dcKtStF7hCmfUq1FIjpPg4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5rfIloyfMHKNEQOfMXJqEQ-1; Wed,
 19 Mar 2025 04:53:00 -0400
X-MC-Unique: 5rfIloyfMHKNEQOfMXJqEQ-1
X-Mimecast-MFC-AGG-ID: 5rfIloyfMHKNEQOfMXJqEQ_1742374380
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5DA9180882E; Wed, 19 Mar 2025 08:52:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC091956095; Wed, 19 Mar 2025 08:52:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE3C421E66C5; Wed, 19 Mar 2025 09:52:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] target/loongarch: Set dest error with
 error_abort in virt_cpu_irq_init
In-Reply-To: <3d9c1bff-c1a5-5e87-e912-7246c2c8f512@loongson.cn> (bibo mao's
 message of "Wed, 19 Mar 2025 15:58:37 +0800")
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-5-maobibo@loongson.cn>
 <877c4l4km1.fsf@pond.sub.org>
 <3d9c1bff-c1a5-5e87-e912-7246c2c8f512@loongson.cn>
Date: Wed, 19 Mar 2025 09:52:54 +0100
Message-ID: <8734f91jx5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On 2025/3/19 =E4=B8=8B=E5=8D=882:09, Markus Armbruster wrote:
>> Bibo Mao <maobibo@loongson.cn> writes:
>>=20
>>> In function virt_cpu_irq_init(), there is notification with ipi and ext=
ioi
>>> interrupt controller for cpu creation. Local variable with error type is
>>> used, however there is no check with its return value.
>>=20
>> Good catch.
>>=20
>> When the first call fails, we pass non-null @err to the second call,
>> which is wrong.  If that one also fails, it'll likely trip
>> error_setv()'s assertion.
>>=20
>>> Here set dest error object with error_abort, rather than local variable=
, so
>>> application will abort to run if there is error.
>>=20
>> Why is failure impossible there?
> In plug hanlder of extioi/ipi, there is only warn_report() if object is=20
> not TYPE_LOONGARCH_CPU, parameter errp is not changed.
>
> With caller funciton virt_cpu_irq_init(), DEVICE(cs) is object with type=
=20
> TYPE_LOONGARCH_CPU always, so failure is impossible here.
>
>>=20
>> If failure is impossible, the code before the patch is harmlessly wrong.
> yes, it is harmlessly wrong.

Could use something like

    target/loongarch: Clean up virt_cpu_irq_init() error handling

    The Error ** argument must be NULL, &error_abort, &error_fatal, or a
    pointer to a variable containing NULL.  Passing an argument of the
    latter kind twice without clearing it in between is wrong: if the
    first call sets an error, it no longer points to NULL for the second
    call.
=20=20=20=20
    virt_cpu_irq_init() is wrong that way: it passes &err to
    hotplug_handler_plug() twice.  If both calls failed, this could trip
    error_setv()'s assertion.  Moreover, if just one fails, the Error
    object leaks.  Fortunately, these calls can't actually fail.

    Messed up in commit 50ebc3fc47f7 (hw/intc/loongarch_ipi: Notify ipi
    object when cpu is plugged) and commit 087a23a87c57
    (hw/intc/loongarch_extioi: Use cpu plug notification).

    Clean this up by clearing passing &error_abort instead.

    Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Note: I replaced the Fixes: tags by a "Messed up ..." paragraph, because
there is no bug to fix according to your explanation.

With something like that:
Acked-by: Markus Armbruster <armbru@redhat.com>

> Regards
> Bibo Mao
>>=20
>> If failure is possible, the code before the patch has a crash bug, and
>> the patch makes it crash harder, i.e. when either call fails instead of
>> when both fail.
>>=20
>>> Fixes: 50ebc3fc47fe (hw/intc/loongarch_ipi: Notify ipi object when cpu =
is plugged)
>>> Fixes: 087a23a87c57 (hw/intc/loongarch_extioi: Use cpu plug notificatio=
n)
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>


