Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F8CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2cq-0001KP-BH; Wed, 13 May 2026 01:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN2ci-0001HE-Jf
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN2cf-0007gq-GI
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778651948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7Wn2hc3Mc7tJZAjbtbPoD+OZ/TtFKtWe+p6RJ5Mtzc=;
 b=KC6ScO2xJRQ2W6Qxt05E0NrUGwejQJsD+9Qw+50Csm2IlS7CYabwIPwP6ikSnTuzAOgI1c
 5KblRllhx3VC6WVB78WGPPqXMCUVq3UDaVEnm7bQN8S07fnG5FDkR3vAzuXBSuymF8INK0
 TDMM6s24dZ9+ma9trQJdoQzlLjdnNMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-8zxtWuXuPTqfZYmljaCMug-1; Wed,
 13 May 2026 01:59:04 -0400
X-MC-Unique: 8zxtWuXuPTqfZYmljaCMug-1
X-Mimecast-MFC-AGG-ID: 8zxtWuXuPTqfZYmljaCMug_1778651942
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81F7C19560AA; Wed, 13 May 2026 05:59:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B29219560AB; Wed, 13 May 2026 05:59:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB4DA21E6A01; Wed, 13 May 2026 07:58:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 integration@gluster.org,  Zhao Liu <zhao1.liu@intel.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Li Zhijian <lizhijian@fujitsu.com>,  Glenn
 Miles <milesg@linux.ibm.com>,  Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,  Ben Chaney <bchaney@akamai.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Harsh Prateek Bora
 <harsh.prateek.bora@gmail.com>,  Caleb Schlossin <calebs@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
In-Reply-To: <e64c6822-8433-4e05-872e-976d9aa7f2b7@oracle.com> (Mark Kanda's
 message of "Tue, 12 May 2026 12:44:02 -0500")
References: <87y0hwbvbp.fsf@pond.sub.org>
 <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
 <e64c6822-8433-4e05-872e-976d9aa7f2b7@oracle.com>
Date: Wed, 13 May 2026 07:58:57 +0200
Message-ID: <87ik8rvoim.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Mark Kanda <mark.kanda@oracle.com> writes:

> On 5/6/26 7:26 AM, C=C3=A9dric Le Goater wrote:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 MAINTAINERS:3165: CheckPoint and Restart (CPR)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 R: Peter Xu <peterx@redhat.com>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 R: Fabiano Rosas <farosas@suse.de>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 R: Mark Kanda <mark.kanda@oracle.com>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 R: Ben Chaney <bchaney@akamai.com>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 S: Supported
>>
>> Since Steve has retired, I believe Mark has taken over and should
>> be promoted Maintainer. Correct ?
>
> Maciej Szmigiero (cc'd) will take over as CPR maintainer (thanks Maciej!).
> I will remain as a reviewer.
>
> Thanks/regards,
> -Mark

Can one of you post a patch to update MAINTAINERS?

Thanks!


