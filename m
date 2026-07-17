Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A579C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjAB-0003GS-Dg; Fri, 17 Jul 2026 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkjA9-0003G9-Bj; Fri, 17 Jul 2026 10:03:37 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkjA7-0003q1-BX; Fri, 17 Jul 2026 10:03:37 -0400
Received: from [192.168.25.24] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id B95EF2003CE;
 Fri, 17 Jul 2026 16:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784297012;
 bh=+MlYpZbkoEMrnS7q6BYfb5kvm75cbu3mrWInxqAJF4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WctkdfdJ7eU0dXTcE1GyymBvY7rGHVzzAvzmJoV223e0Mqwgm910CCbSRvTnizXuJ
 nbYsI16OoQrvbZg9xQ5rkPVa0Wp19Kbnkt6t1pMiQS4Dkbp+ul10vgiWTLh6R0LMWk
 wSKIL6Q+wvxf2PpnNHTpo15EzG1akNc+1Tx+UuTBsBEpe7owVOuzAhl7l8CTpEQ63W
 coLsjMZjDVQTvyFSsDbA+eLsEyGykXBSHGkhfAEbhmVSdCN7y4b3d0ScFu+/uZgikM
 gTQvXMzfhk9sslMto5TaqrY0H+kIU5troZn0NIN4iPF4HZKUwS9DFl5fX1S0VEnwUn
 s5K8hc0w0TRXg==
From: emmanuel.blot@free.fr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: cminyard@mvista.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
Date: Fri, 17 Jul 2026 16:03:09 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <F564EA86-B103-410B-B55F-9A95F3785553@free.fr>
In-Reply-To: <CAFEAcA8dsSKrF3F53SWwyhcNR4XbvRG3N5k96Qkq4RLtpYuwWQ@mail.gmail.com>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
 <D5F0871C-4AC1-43D6-9BCD-C59A07236A1F@free.fr>
 <alomsclAchz2_bWy@mail.minyard.net>
 <CAFEAcA8dsSKrF3F53SWwyhcNR4XbvRG3N5k96Qkq4RLtpYuwWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; markup=markdown
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> If you want the bus hierarchy, we have that; it's not the same
> thing as the QOM ownership hierarchy.

This means that the ownership of a standalone device should either be the=
 board or the machine.

We end up with a very flat and wide list of devices. It is more correct i=
n term of ownership, but harder to pinpoint a device either from an API o=
r even browsing it with info qom-tree, except if we can define more or le=
ss canonical way to name it.

I do not think there is an API to traverse multiple buses and devices at =
once to reach a device though. Is there an alternative to locate a device=
 from a (string) description on how/where it is connected, if QOM path is=
 not the right idiom to use?

