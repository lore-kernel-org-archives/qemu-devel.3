Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09061C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXEM-0006y7-1f; Wed, 24 Apr 2024 03:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXEK-0006xo-2X
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXEI-0007lt-Ks
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713944386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idnZ3O5QpquEjnpHSPgjq3UMUhmcPJzmS7huwewbnII=;
 b=aguuor9ElsmeJvQRvrUIn9/mtJP4/KpG64wbHXAKdNAP4pdsJN7qn9vWBPc7FOkut0iTUm
 /74CTk3axsTBRSfCZejVKo7q2ARgDIQ2EfENePKvEg7wxGPWMGxYO55y8dmoh8AgCORziL
 FB9xEr7kg2WLOyTGs9DRwS5astzs7Y8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Q_f7iqQ6OY6GO0kRGxUzuA-1; Wed, 24 Apr 2024 03:39:37 -0400
X-MC-Unique: Q_f7iqQ6OY6GO0kRGxUzuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B199E812C54;
 Wed, 24 Apr 2024 07:39:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB521121312;
 Wed, 24 Apr 2024 07:39:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FE7921E6811; Wed, 24 Apr 2024 09:39:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Artyom Tarasenko <atar4qemu@gmail.com>,  Chris
 Wulff <crwulff@gmail.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Marek Vasut <marex@denx.de>,  Max Filippov
 <jcmvbkbc@gmail.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-ppc@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH-for-9.1 13/21] target/ppc: Replace qemu_printf() by
 monitor_printf() in monitor
In-Reply-To: <20240321154838.95771-14-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 21 Mar 2024 16:48:29
 +0100")
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-14-philmd@linaro.org>
Date: Wed, 24 Apr 2024 09:39:35 +0200
Message-ID: <87jzkn43bc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

My review comments to PATCH 05 apply.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


