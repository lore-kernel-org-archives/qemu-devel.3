Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CEF3028C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 06:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w21RS-0008Cr-6J; Mon, 16 Mar 2026 02:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w21RQ-0008CY-6j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 02:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w21RN-0002fJ-FC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 02:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773642515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffpHoHpTksW2xdqaE0pCVmRuAHQ/pT3bpdJRFxvcpDs=;
 b=C8uKnJCm5p0lxDW8FeQN5M3dCxruDzS7kyGbnkDgOTh+M5T+9lHdN/Z3tuGm/rWWf0S9F6
 gpTmmn3GibQHc5Ri6PzTC5Cqxby3gxBfP4300vRqeDEFLAhqE+pgQHW2tThHMQDgPZ+X+c
 GxuU1ttdsg5TWcdRkMxXmyhU58TCBSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-BVwGjAMiMRKAkjQGlLYohA-1; Mon,
 16 Mar 2026 02:28:31 -0400
X-MC-Unique: BVwGjAMiMRKAkjQGlLYohA-1
X-Mimecast-MFC-AGG-ID: BVwGjAMiMRKAkjQGlLYohA_1773642510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EE4318005BE; Mon, 16 Mar 2026 06:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649341800361; Mon, 16 Mar 2026 06:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED7C821E6937; Mon, 16 Mar 2026 07:28:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Anton Johansson
 <anjo@rev.ng>, Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  stefanha@redhat.com,  Thomas Huth
 <thuth@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Mark Burton <mburton@qti.qualcomm.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PULL 00/16] gdbstub: Always infer base register index from GDB
 XML
In-Reply-To: <dd99087a-58bc-41db-820c-4a37b58c56ac@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 12 Mar 2026 11:06:08
 +0100")
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
 <CAFEAcA-FtvvZhgYJVHD+Btxjq4RXVdW88ysPhqTgOJPm7og25Q@mail.gmail.com>
 <dd99087a-58bc-41db-820c-4a37b58c56ac@linaro.org>
Date: Mon, 16 Mar 2026 07:28:25 +0100
Message-ID: <87bjgouw3a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 12/3/26 10:47, Peter Maydell wrote:
>> On Wed, 11 Mar 2026 at 01:38, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce11=
1711:
>>>
>>>    Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kra=
xel/qemu into staging (2026-03-10 13:32:30 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310
>>>
>>> for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:
>>>
>>>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] (20=
26-03-10 17:12:18 -0700)
>>>
>>> ----------------------------------------------------------------
>>> - [PATCH v4 00/16] gdbstub: Always infer base register index from GDB (=
=3D?UTF-8?q?Philippe=3D20Mathieu-Daud=3DC3=3DA9?=3D <philmd@linaro.org>)
>>>    Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1-phil=
md@linaro.org
>>>
>>> ----------------------------------------------------------------
>> Applied, thanks.
>
> As of this merged commit 769a37d8bd0:
>
>   v10.0: Total build units: 7797
>          (https://gitlab.com/qemu-project/qemu/-/jobs/9788294720)
>   v10.1: Total build units: 6443
>          (https://gitlab.com/qemu-project/qemu/-/jobs/11142814212)
>   v10.2: Total build units: 6367
>          (https://gitlab.com/qemu-project/qemu/-/jobs/12474666739)
> current: Total build units: 5679
>          (https://gitlab.com/qemu-project/qemu/-/jobs/11142814212)
>
> v10.2 -> v11.0 delta so far: 6367 - 5679 =3D 688  (-12%)
> v10.0 -> v11.0 delta so far: 7797 - 5679 =3D 2118 (-37%)

Lovely!  Thanks to everybody involved!

> I'd like to thanks Alex for pushing this effort forward, Pierrick
> Richard Anton and few others for the work done and reviews.
>
> (We are no down to 2 duplicated common symbols, then start the
> harder parts with duplicated target symbols...)


