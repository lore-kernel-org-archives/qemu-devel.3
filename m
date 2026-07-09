Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F35C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whohm-0000La-BT; Thu, 09 Jul 2026 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whohl-0000L5-0u
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whohj-0006Cz-51
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783603333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z+rzWCKmZgMeoXLtJups2UO+1ErV3D9ZoDEB6/Kx3U=;
 b=NoI6DOPCRg4BIWbCrU/PpuFtxp2sD1v6nOG1qjPUvGwzrGT5mDxR7nSJUInbxugIHngf0Q
 qFvnJhayUltc243GnsdKcptmSUN5SW3mpPwv9BrHO8Ca4rAkf7Hx0Oa3hYLLDhBlPwUzOs
 da4sRRb4C3IbVoR7FN+jGTKYceqaCbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-1gMFYh49OdSdHk-p8uGJ_g-1; Thu,
 09 Jul 2026 09:22:12 -0400
X-MC-Unique: 1gMFYh49OdSdHk-p8uGJ_g-1
X-Mimecast-MFC-AGG-ID: 1gMFYh49OdSdHk-p8uGJ_g_1783603330
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE2A0195606F; Thu,  9 Jul 2026 13:22:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 695B11800347; Thu,  9 Jul 2026 13:22:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA72021E6920; Thu, 09 Jul 2026 15:22:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-arm@nongnu.org,  BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org,  Huacai Chen <chenhuacai@kernel.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: A few Machines crash when "no default audio driver available"
In-Reply-To: <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 (Peter Maydell's message of "Thu, 9 Jul 2026 14:01:19 +0100")
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
Date: Thu, 09 Jul 2026 15:22:05 +0200
Message-ID: <87zf00cn7m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cc: mainainters for "Overall Audio backends"
Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
>> and MIPS machine fuloong2e crashes.
>>
>> I run them like this:
>>
>> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio
>
>> Died when device_set_realized() tried to propagate a "no default audio
>> driver available" error to &error_abort.
>
> Is this something we want to have be a possibility the devices
> have to cope with? Can we have the "ignores all audio data"
> backend be always available instead?

There's plenty of precedence for /dev/null-like backends.

> Otherwise every audio device needs to cope with "there is no
> audio backend available" and implement "do nothing with the
> audio data" itself.

Yes.


