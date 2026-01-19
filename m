Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4491FD29C2F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqCg-00079f-28; Mon, 19 Jan 2026 09:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqCY-000766-Cw
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqCT-0003lQ-OC
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768832749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yNva3xxyVUUtj0uYF2CDWmyf7Nf0/5PvuVxhcacgww=;
 b=Xf6Ud9boOf3dTBHPaDohHEzNnSYA4gmrdaeW7ki50xAKnf2sL44fkhLCYKZUsitf2fvsDc
 n4ND0xF5eW5rAgrhoaRge3ZDruhG0mahhaHR2wKd3c9k81bdtbM4ZVr2IV+Ik4d0f2zNOT
 kfRjAjNkvOT2pSVFrguETiebdmRopkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-ocU5SvDoOG-bXABs9bZirg-1; Mon,
 19 Jan 2026 09:25:43 -0500
X-MC-Unique: ocU5SvDoOG-bXABs9bZirg-1
X-Mimecast-MFC-AGG-ID: ocU5SvDoOG-bXABs9bZirg_1768832742
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0DFF1956063; Mon, 19 Jan 2026 14:25:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 669C81800B7F; Mon, 19 Jan 2026 14:25:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0EB221E692D; Mon, 19 Jan 2026 15:25:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kane Chen
 <kane_chen@aspeedtech.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,  "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to
 customize bus naming
In-Reply-To: <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Fri, 16 Jan 2026 06:16:44 +0100")
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org>
Date: Mon, 19 Jan 2026 15:25:36 +0100
Message-ID: <877btdn0gv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 1/15/26 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>> Cc'ing Markus.
>> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>
>>> Currently, the Aspeed I2C controller uses a static naming convention
>>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>>> object name conflicts in machine models that incorporate multiple I2C
>>> controllers, such as an Aspeed SoC paired with an external IO expander
>>> or a co-processor like the AST1700.
>>>
>> Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanage'
>> described here?
>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>> This problem isn't specific to I2C nor Aspeed.
>
>
> See the discussion here :
>
>   https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1353579441=
@kaod.org/
>
> The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
> controllers plus the I2C/I3C buses. We need to find a way to
> distinguish these groups at the QEMU machine level to be able
> to add devices on the right bus when using the command line.
>
> Suggestions welcome !

Please show me how to start a QEMU with the 48 I2C mentioned above,
complete with output of "info qtree".


