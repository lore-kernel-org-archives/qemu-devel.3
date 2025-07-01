Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62B1C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZjG-0005ML-GS; Tue, 01 Jul 2025 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWZjA-0005Ku-7y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWZj7-0001o2-UO
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751371476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1wQDv7i+UE5qB1RJHLYR+2M1eVSaLLN//9E/lyDscw=;
 b=P8NLzdJvt+BYR/44OKLkisQ9V1unhGXFOntbXNZyiQZ1AekjolIEIHo0pEvjmye5keq/rV
 SBVbpVFyBS4QlWbRVvp4To6gFetMwNOy/DDImtiJAip4wM2ojjOaiHjAZ5cEa5LKMI/kA2
 Pi4DSoQE7qRYTzlHVjUqw7Vp/lfKbZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-Aqn9mBViPJadGKjVELrKIA-1; Tue,
 01 Jul 2025 08:04:33 -0400
X-MC-Unique: Aqn9mBViPJadGKjVELrKIA-1
X-Mimecast-MFC-AGG-ID: Aqn9mBViPJadGKjVELrKIA_1751371472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 393E21800343; Tue,  1 Jul 2025 12:04:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.226.82])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6523F19560AB; Tue,  1 Jul 2025 12:04:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E345218000BA; Tue, 01 Jul 2025 14:04:28 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:04:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
Message-ID: <3s45ekea2lotfcyrldxjmaybxujmfjrxemozoivnc2tq3qxfew@naef2yhuealw>
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
 <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
 <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  Hi,

> > If those machine types need to set it to true. I think they can set it
> > after they have this property.
> nope it does not work like that. In case we really need to take care of
> this, this must be handled by compats.

ramfb is a sysbus device so it can only used for machine types where it
is explicitly enabled:

  # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
  hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
  hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
  hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
  hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
  hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
  hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);

So these six are the only machine types we have to worry about.

The three x86 machine types (pc, q35, microvm) will actually use the rom
(when booting with seabios).

For arm/riscv/loongarch virt we want disable the rom.

Everything else doesn't matter much because ramfb can not be used in the
first place, you'll get an error like this when trying:

  # qemu-default -M isapc -device ramfb
  qemu-system-x86_64: -device ramfb: Parameter 'driver' expects a dynamic sysbus device type for the machine

HTH & take care,
  Gerd


