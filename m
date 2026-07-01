Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB47C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevjJ-0005Rh-MI; Wed, 01 Jul 2026 10:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wevjI-0005R9-0x
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wevjG-0007mc-GK
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782915353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9TpchyD0oH5lX1oqWBrp5EL9pmjGpMnTwog+p205Q0=;
 b=W7+4+MBAOctYCeScPtFRic8rx9JYTMMP7LxidGwmX8aoMx5wbQ3Q55jRkj6QwV1XrwRa3c
 +9lm9CJAMrQ5W9KR8dUFHJlWZmRr6Zne7kg3Kqj+PBMrGmpcJf5/9niI7pAYuz5QSkaq5N
 yJ4Le1ozlSrPm/EbJo8JHkFDKPzExEo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-PrrlC1DIOg29c11_00a7eg-1; Wed,
 01 Jul 2026 10:15:48 -0400
X-MC-Unique: PrrlC1DIOg29c11_00a7eg-1
X-Mimecast-MFC-AGG-ID: PrrlC1DIOg29c11_00a7eg_1782915346
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00C04188E6DA; Wed,  1 Jul 2026 14:15:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20B561800610; Wed,  1 Jul 2026 14:15:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89A6121E6920; Wed, 01 Jul 2026 16:15:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Emmanuel Blot <eblot@meta.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,  William de Abreu
 Pinho <williampinho@meta.com>,  qemu-arm@nongnu.org,  Corey Minyard
 <cminyard@mvista.com>
Subject: Re: [PATCH v3 3/5] hw/i2c: parent slaves created with
 i2c_slave_create_simple
In-Reply-To: <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 1 Jul 2026
 08:29:26 +0200")
References: <20260627-i2c-adc128d818-anacapa-v3-0-cfb94270a980@meta.com>
 <20260627-i2c-adc128d818-anacapa-v3-3-cfb94270a980@meta.com>
 <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:15:40 +0200
Message-ID: <87echm4wz7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 28/6/26 02:45, Emmanuel Blot wrote:
>> Slaves created with i2c_slave_create_simple() were left unparented and
>> showed up under /machine/unattached with no stable QOM path. Add each
>> slave as a QOM child of its bus, named after its I2C address, so it has
>> a deterministic and addressable QOM path.
>
> +Markus
>
> Personally I never liked the idea of having buses being parents
> of the devices attached to them, but maybe it is simpler this way.
>
>> Signed-off-by: Emmanuel Blot <eblot@meta.com>

Patches haven't reached the list as far as I can tell.  I need them to
contribute to the discussion.  Emmanuel, please resend them.


