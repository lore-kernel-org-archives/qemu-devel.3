Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4203FA3727
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 08:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp1IH-0008Vu-6Z; Fri, 13 Sep 2024 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1IF-0008V3-KL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1IE-0004F8-6n
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726214676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AOCiWebeIf1kYOUexTOQ2z0M0umcclMVn52RuOr/Ok=;
 b=TnUD2b9r/jz7Ly/9NJ/BM0kjLuYKWULTvPSOneSZF2oliypeAXJlvckxrMZS9sXH+4QrWt
 Y5UXjW2CTVvBsbMNXjiCPnPFs8kESXWhjDIl80Ahkz4oEEOSxgbVsODTUWrGBiFL0/zWWh
 EuJ4JiMRwIAJQqk8wBAU2d6MbO9/4Qo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-UKZPT_9PMJ6N0xLn7lwyUg-1; Fri,
 13 Sep 2024 04:04:35 -0400
X-MC-Unique: UKZPT_9PMJ6N0xLn7lwyUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63DAF1955DD4; Fri, 13 Sep 2024 08:04:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A81E1956086; Fri, 13 Sep 2024 08:04:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8A9D21E6A28; Fri, 13 Sep 2024 10:04:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexandre Ratchov <alex@caoua.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Qiuhao Li
 <Qiuhao.Li@outlook.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Darren
 Kenny <darren.kenny@oracle.com>,  Bandan Das <bsd@redhat.com>,  Alexander
 Bulekov <alxndr@bu.edu>,  Markus Armbruster <armbru@redhat.com>,  Akihiko
 Odaki <akihiko.odaki@gmail.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Brad Smith <brad@comstyle.com>,  Volker
 =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 20/24] audio: Add sndio backend
In-Reply-To: <ZuBeYjju389c8MoI@vm1.arverb.com> (Alexandre Ratchov's message of
 "Tue, 10 Sep 2024 16:57:38 +0200")
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
 <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
 <ZuBXqSoohgbS-rF6@redhat.com> <ZuBeYjju389c8MoI@vm1.arverb.com>
Date: Fri, 13 Sep 2024 10:04:29 +0200
Message-ID: <87frq42d4i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Alexandre Ratchov <alex@caoua.org> writes:

> On Tue, Sep 10, 2024 at 03:28:57PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> >=20
>> > This is the single use of the ISC license in the more than 10k
>> > files in the repository. Just checking IIUC this document:
>> > https://www.gnu.org/licenses/quick-guide-gplv3.en.html
>> >=20
>> > ISC -> LGPLv2.1 -> GPLv2 -> GPLv3
>> >=20
>> > So ISC is compatible with GPLv2-or-later. Is that correct?
>>=20
>> ISC is a permissive license that's semantically pretty much equivalent
>> to either MIT or BSD 2 clause licenses and thus is broadly compatible
>> with most other licenses, including the various GPL variants/versions.
>>=20
>> None the less, since sndioaudio.c was a new file, it should have been
>> submitted using the GPLv2+, unless there was a reason it needed to
>> diverge and use ISC.
>>=20
>> An example justification for divering is if the new code is derived
>> from some non-QEMU source that was already ISC.
>>=20
>
> The ISC license is more permissive than GPLv2+ and compatible with it.
> The file uses this license for history reasons: initial versions of it
> used to be part of the OpenBSD ports repository, which uses ISC.
>
> If ISC is not appropriate for qemu, I agree to use GPLv2+ instead (I'm
> the author this file).

Let's adjust the license then.  Alexandre, care to post the patch?


