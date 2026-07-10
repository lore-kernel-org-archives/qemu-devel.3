Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB46BC44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gA-0007uB-6y; Fri, 10 Jul 2026 02:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wi4g0-0007kj-RF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wi4fz-0005pQ-En
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783664730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v8q+3lUkMrowihgNvWTsOWIW9MlqhSBHDx1C+VszfsU=;
 b=Y8qxUmyI6hJK+pmkUoskHlceV58TFTMFR45ieC1huMTeDxs2CXIcLobsYvW1hqcNnkffdq
 O1vmwWMkWxEt0ze+otVlKvTGFWnwdJl0NtOybDXTVgq3tfgGGDrxYCWhOpuh1KNJ99ojtB
 /mGegdxouREKu2krz3Boodt253MKuFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-C-trBSPRMYWc0_bCbg-Gww-1; Fri,
 10 Jul 2026 02:25:27 -0400
X-MC-Unique: C-trBSPRMYWc0_bCbg-Gww-1
X-Mimecast-MFC-AGG-ID: C-trBSPRMYWc0_bCbg-Gww_1783664721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370881955F76; Fri, 10 Jul 2026 06:25:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F05180058C; Fri, 10 Jul 2026 06:25:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 380D421E6920; Fri, 10 Jul 2026 08:25:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  Markus Armbruster
 <armbru@redhat.com>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aditya Gupta <adityag@linux.ibm.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  "Alexey Kardashevskiy" <aik@ozlabs.ru>,  Alistair
 Francis <Alistair.Francis@wdc.com>,  Alistair Francis
 <alistair@alistair23.me>,  Antony Pavlov <antonynpavlov@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,  "Bernhard Beschow"
 <shentey@gmail.com>,  Bibo Mao <maobibo@loongson.cn>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Chao Liu <chao.liu@processmission.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  =?utf-8?Q?Cl=C3=A9me?=
 =?utf-8?Q?nt?= Chigot
 <chigot@adacore.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Dorjoy Chowdhury
 <dorjoychy111@gmail.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,  Farhan Ali <alifm@linux.ibm.com>,
 "Felipe Balbi" <balbi@kernel.org>,  Francisco Iglesias
 <francisco.iglesias@amd.com>,  Frederic Konrad <konrad.frederic@yahoo.fr>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,  Gautam Gala
 <ggala@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Hao Wu <wuhaotsh@google.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  "Helge Deller" <deller@gmx.de>,  Hendrik
 Brueckner <brueckner@linux.ibm.com>,  =?utf-8?Q?Herv=C3=A9?= Poussineau
 <hpoussin@reactos.org>,  Huacai Chen <chenhuacai@kernel.org>,  Jan Kiszka
 <jan.kiszka@web.de>,  Jared Rossi <jrossi@linux.ibm.com>,  Joel Stanley
 <joel@jms.id.au>,  Laurent Vivier <laurent@vivier.eu>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,  Michael Rolnik <mrolnik@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Niek Linnenbank <nieklinnenbank@gmail.com>,  "Palmer
 Dabbelt" <palmer@dabbelt.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@mailo.com>,  "Pierrick Bouvier"
 <pierrick.bouvier@oss.qualcomm.com>,  Ran Wang <wangran@bosc.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,  Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>,  Samuel Tardieu <sam@rfc1149.net>,  Sergio
 Lopez <slp@redhat.com>,  Song Gao <17746591750@163.com>,  Stafford Horne
 <shorne@gmail.com>,  Subbaraya Sundeep <sundeep.lkml@gmail.com>,  Thomas
 Huth <th.huth+qemu@posteo.eu>,  Tyrone Ting <kfting@nuvoton.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,  "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>,  "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Subject: Re: Call to clean up QOM onboard devices lacking a parent
In-Reply-To: <fee18020-dcfe-4d91-8384-5cc5f8321ff7@amazon.com> (Graf
 Alexander's message of "Thu, 9 Jul 2026 16:45:42 +0000")
References: <87se5scipx.fsf@pond.sub.org>
 <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
 <fee18020-dcfe-4d91-8384-5cc5f8321ff7@amazon.com>
Date: Fri, 10 Jul 2026 08:25:13 +0200
Message-ID: <87h5m7xsxi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Graf (AWS), Alexander" <graf@amazon.de> writes:

> Hi Markus,

[...]

> I'm also curious on whether there is anything that makes sysbus device 
> spawns both easy (as they are today) and at the same time fully QOM 
> parent compliant.
>
> I had a quick look at the vmapple machine and most of the offenders are 
> sysbus devices I spawn via qdev_new(). Would you want all of these to 
> get their parent declared via object_property_add_child()? If that's the 
> case, why don't we introduce a new qdev_new_child() which does that 
> automatically?

We do have such convenience functions at the QOM layer: object_new() and
object_property_add_child() etc., are basic building blocks, and
object_new_with_props() etc. combine them in useful ways.

We don't have such convenience functions at the qdev layer.  Can't see
why we couldn't add them.

Number of orphaned device types I see by bus_type:

    69      busless
    15      ISA
    33      PCI
    11      SSI
    209     System
    2       apple-desktop-bus
    23      i2c-bus
    2       sd-bus
    1       spapr-vio-bus
    2       usb-bus

Again, not a problem with the device types, but the code that creates
and realizes them.

Bus types commonly provide a layer above qdev for that.  Perhaps these
layers could also use convenience functions to more easily deal with
setting the QOM parent.


