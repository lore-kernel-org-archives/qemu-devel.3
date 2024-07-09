Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D22AC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 05:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR2wT-0007AR-Js; Tue, 09 Jul 2024 00:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR2wM-00078R-4a
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 00:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR2wI-0001Ih-78
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 00:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720501131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pfw6FfZz+px5zFLIP9Sg5UaIlzcpiNvOKa34Kk17uN0=;
 b=hGtEUhAv7zHDJf+F00QEM0/sSxaaTcWDqxHAz3IG1ExXpznoQ442Qi4WUJxeGLMseP/nZ2
 wjL6qDAWBvLC4wmpKSXtA8hUy859qw4MVs/ko99uSXXSerlDS6NDnTCZAMs2dch3/9UW2V
 n64s28oeu1qnIolIoM//F1rOoR2eYUc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-1dtJauJdNFeQsGa5S2T4ow-1; Tue,
 09 Jul 2024 00:58:44 -0400
X-MC-Unique: 1dtJauJdNFeQsGa5S2T4ow-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06A571955F42; Tue,  9 Jul 2024 04:58:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1AE91955E85; Tue,  9 Jul 2024 04:58:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 365D621E668F; Tue,  9 Jul 2024 06:58:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  qemu-devel
 <qemu-devel@nongnu.org>,  Andreas Faerber <afaerber@suse.de>,  Alessandro
 Di Federico <ale@rev.ng>,  Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,
 bbauman@redhat.com,  Brian Cain <bcain@quicinc.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, dhedde@kalrayinc.com,  Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  Auger Eric <eric.auger@redhat.com>,
 felipe@nutanix.com,  iggy@theiggy.com,  Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>,  Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com,  Jim Shu <jim.shu@sifive.com>,
 jjherne@linux.vnet.ibm.com,  Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,  Luc Michel
 <luc@lmichel.fr>,  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com,  mimu@linux.vnet.ibm.com,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Wei Wang
 <wei.w.wang@intel.com>,  z.huo@139.com,  LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com,  Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: QEMU Community Call Agenda Items (July 9th, 2024)
In-Reply-To: <f27632d0-4215-48e9-af2b-0270eeb4ea17@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 8 Jul 2024 20:41:32
 +0200")
References: <87cynoszg2.fsf@draig.linaro.org>
 <f27632d0-4215-48e9-af2b-0270eeb4ea17@linaro.org>
Date: Tue, 09 Jul 2024 06:58:29 +0200
Message-ID: <87cynnjh56.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Cc: Block layer core maintainers

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 8/7/24 16:58, Alex Benn=C3=A9e wrote:
>> Hi,
>> The KVM/QEMU community call is at:
>>    https://meet.jit.si/kvmcallmeeting
>>    @
>>    9/7/2024 14:00 UTC
>> Are there any agenda items for the sync-up?
>
> - I don't remember who mentioned "3 phase reset and KVM",
>   maybe Daniel Barboza or Peter Xu.
>
> - Questions for block team:
>
>   . Are there plan to remove the legacy DriveInfo? What should
>     we use instead, blk_by_name() and/or blk_by_qdev_id()?
>
>   . Are there plan to move away from the IF_FOO (see blockdev::if_name)
>     or is it OK to use them and keep them in mind with new designs?
>
>   . To model one HW with multiple drives (at least 3), is there
>     a recommended way to create that from the CLI?


