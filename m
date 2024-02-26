Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DB2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVbR-0007MA-Q0; Mon, 26 Feb 2024 02:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVbQ-0007M1-UE
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVbP-00057D-C1
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JOeOXEbmI6wBwhZ1IWRAD5hq6bI9ex93IjpEZdKhyE=;
 b=NupR1qUkT3UMeAOWGfyCJ4V858Qo/2tWfebNWeaCS4FTyle+MkeZ4bbPAs0+ts354MsS+M
 sfN9QHvM//sGcSRVLKl4TMFqfZ23GxyzXjmJQysnpk6agU7eKZBnsZ2NLauDIJt8yw/OVg
 rkui++jOXTsljWebudigQCJc+GnPoIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-14rTLr1UMq20bpj6A_354Q-1; Mon, 26 Feb 2024 02:40:40 -0500
X-MC-Unique: 14rTLr1UMq20bpj6A_354Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E078B108C065;
 Mon, 26 Feb 2024 07:40:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B19928CEC;
 Mon, 26 Feb 2024 07:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9175221E6767; Mon, 26 Feb 2024 08:40:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Leif Lindholm <quic_llindhol@quicinc.com>,  Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>,  Radoslaw Biernacki
 <rad@semihalf.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-block@nongnu.org,  John Snow
 <jsnow@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 3/3] hw/ide: Include 'ide_internal.h' from current path
In-Reply-To: <feffd329-59e0-0291-0dd6-76a625da190b@eik.bme.hu> (BALATON
 Zoltan's message of "Sun, 25 Feb 2024 21:28:33 +0100 (CET)")
References: <20240225171637.4709-1-philmd@linaro.org>
 <20240225171637.4709-4-philmd@linaro.org>
 <feffd329-59e0-0291-0dd6-76a625da190b@eik.bme.hu>
Date: Mon, 26 Feb 2024 08:40:37 +0100
Message-ID: <878r37lll6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Sun, 25 Feb 2024, Philippe Mathieu-Daud=C3=A9 wrote:
>> Rename "internal.h" as "ide_internal.h", and include
>
> Is there a convention about using underscore or dash in file names? The h=
eaders Thomas added are using - as well as ahci-allwinner.c, only ahci_inte=
rnal.h has _ (but there are others elsewhere such as pci_device.h). Maybe w=
e should be consistent at least within IDE and this series is now a good op=
portunity for renaming these headers to match. But it's just a small nit, t=
hanks for picking this up.

This is one of the many unnecessary inconsistencies we're inflicting on
ourselves.

We have more than 3600 file names containing '-', and more almost 2700
containing '_'.  Bizarrely, 68 of them contain both.

I strongly prefer '_' myself.

Zoltan is making a local consistency argument for '-'.

Let's use '-' here.


