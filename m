Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23DDC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNhI-0007zw-3H; Wed, 12 Jun 2024 09:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHNhF-0007tk-I7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHNhE-0000ZF-1d
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBfd6Z86Wbhg9+axntpREHq05oibhQASjFKI6YkK6pw=;
 b=b2Tq1MR0NBAfX/HnvXxamMg0a1/7Hb2S/SAfrp6tv/kFwtrk7ULamIXLN4wnDPgqT7/Iof
 /drNere/bdW6GBpUd7JjdAXmBxkXo7jDpDIvLPOeqX0UNnODg9EtY8Ol3e4D/qeTdG446F
 ODyfNmnvC9s0SmKPjdydQKWilYFiY1E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-BV-LNF3yOTOUy7iEhDe-LQ-1; Wed,
 12 Jun 2024 09:07:17 -0400
X-MC-Unique: BV-LNF3yOTOUy7iEhDe-LQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8566F1954B0B; Wed, 12 Jun 2024 13:07:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEA4730000C4; Wed, 12 Jun 2024 13:07:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C30B721E66E5; Wed, 12 Jun 2024 15:07:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-block@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
In-Reply-To: <18739a67-84bb-4fd3-adb6-0db0f0eb7af1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 12 Jun 2024 14:23:09
 +0200")
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-22-philmd@linaro.org>
 <87mswx5n63.fsf@pond.sub.org>
 <18739a67-84bb-4fd3-adb6-0db0f0eb7af1@linaro.org>
Date: Wed, 12 Jun 2024 15:07:13 +0200
Message-ID: <87plsmfgxq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> Michael, Konstantin, QERR_UNSUPPORTED is only used by QGA.
>
> Do you mind giving our maintainer's position on Markus
> analysis so we can know how to proceed with this definition?

Daniel Berrang=C3=A9 recently posted patches that get rid of most instances
of QERR_UNSUPPORTED:

    [PATCH 00/20] qga: clean up command source locations and conditionals
    https://lore.kernel.org/qemu-devel/20240604134933.220112-1-berrange@red=
hat.com/

I pointed out a possible opportunity to remove even more.

I think we should let the dust settle there, then figure out how to
eliminate remaining QERR_UNSUPPORTED, if any.


