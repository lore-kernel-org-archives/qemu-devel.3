Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7396C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQkc-0005yv-Ft; Fri, 09 Feb 2024 08:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rYQkY-0005y9-1F; Fri, 09 Feb 2024 08:17:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rYQkV-00025f-Rv; Fri, 09 Feb 2024 08:17:01 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9DBD54E604C;
 Fri,  9 Feb 2024 14:16:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Bu5rz1QhyhhC; Fri,  9 Feb 2024 14:16:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A900B4E6076; Fri,  9 Feb 2024 14:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A672B7456FE;
 Fri,  9 Feb 2024 14:16:53 +0100 (CET)
Date: Fri, 9 Feb 2024 14:16:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org, 
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@linux.intel.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH 0/7] hw/qdev: Split 'wiring' phase from 'realize'
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
Message-ID: <b815a3af-a1b2-a337-f66a-f900a89a756e@eik.bme.hu>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

Instead of adding a new method to devices, why not move wiring to the code 
that created/realized the device? Either it's the job of the code that 
created the device and wants to use it or if it's an internal object the 
device itself is created then it should be OK to wire it in the device 
realize method. I probably don't understand the problem fully, what I want 
to say is that device creation is complex enough now so trying to avoid 
adding more complexity to it would be a good thing.

Regards,
BALATON Zoltan

