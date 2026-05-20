Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65DACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfPk-0001Si-O8; Wed, 20 May 2026 07:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wPfOm-000133-Ed
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wPfOk-00007R-1D
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779277657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIxYtkqv5oHysAV8NRlh9wUNP4ZnHp/rf/+kKVmJpH4=;
 b=eoxQitpHxEVVAPtCXfCo5U4oEVXpOa1H7RuGPKEfkOz2y5N9tBX6d4avT6aTt1BSEzoLv9
 W+TfMIZo679czFsDCaGDbVZLL26VmbJOlBZGXCdRcSuLUbIksJrTFanGSYVkSoDMP6mVp8
 3qgpe0Dg+LdDdJK/MOiWpPqCG3hCtDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-xPV6a7_tP-62Qw42OyKRUA-1; Wed,
 20 May 2026 05:34:07 -0400
X-MC-Unique: xPV6a7_tP-62Qw42OyKRUA-1
X-Mimecast-MFC-AGG-ID: xPV6a7_tP-62Qw42OyKRUA_1779269646
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A4AB19560B7; Wed, 20 May 2026 09:34:06 +0000 (UTC)
Received: from localhost (unknown [10.44.33.242])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ADA51956053; Wed, 20 May 2026 09:34:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Hanna Reitz
 <hreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-s390x
 <qemu-s390x@nongnu.org>
Subject: Re: [RFC PATCH] buildsys: Stop checking for ESA/390 host
In-Reply-To: <CABgObfYh0k=Cp-1zfg-EDSMRobbDkW0OpR1QD1tGAYmHDSuorw@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260519145859.91999-1-philmd@linaro.org>
 <CABgObfYh0k=Cp-1zfg-EDSMRobbDkW0OpR1QD1tGAYmHDSuorw@mail.gmail.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 20 May 2026 11:34:02 +0200
Message-ID: <87h5o2o25x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Tue, May 19 2026, Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il mar 19 mag 2026, 16:59 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=
 ha
> scritto:
>
>> We still build QEMU tools on 32-bit hosts (see commit
>> cf634dfcd8f), however no OS supported by QEMU still runs
>> on ESA/390 (Linux dropped support in release 4.1 in 2015).
>>
>
> If Linux still supports 31-bit *userspace binaries*, I would keep the
> configure check, so that 32-bit s390 is properly detected as an unsupport=
ed
> CPU:

FWIW, Linux removed support for the 31 bit compat code in v6.19 (late
last year); it is unclear if anyone had been using it recently anyway.

>
> elif check_define __s390__ ; then
>>   if check_define __s390x__ ; then
>>     cpu=3D"s390x"
>>   else
>>     cpu=3D"s390"
>>   fi
>>
>
> and perhaps keep the CPU_CFLAGS only from the other hunk:
>
>   s390)
>>     linux_arch=3Ds390
>>     CPU_CFLAGS=3D"-m31"
>>     ;;
>>
>
>    s390x)
>>      host_arch=3Ds390x
>>      linux_arch=3Ds390
>>

I'm also wondering if anyone had actually tried to use QEMU on such a
setup recently; I don't have a setup to test that in any case.


