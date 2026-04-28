Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD20FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfAZ-0004sn-8z; Tue, 28 Apr 2026 05:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHfAX-0004rx-N8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHfAV-0000Cv-H7
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777370149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smUO0xbx4TCfjHmrMuZQEsvIFH2xLLddgFcVPn94FE0=;
 b=KJ7dj5nwePKvmD6SMqmTuf5WwU63umWbiXHriqmtL8uAmmmxOivu7lfhNj2wbG0+QIgZk4
 0QYamusZmMO3UuXECCcQBlejXAaGQI/AkkS9piqtxL53WTkTUmMTsewkGcGFdzwf5e7Qdf
 WWpdCH3noKRgvUcxvh+U03EEDyNhzLQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-MBmnxP9YM8K8zvDBP0IVBA-1; Tue,
 28 Apr 2026 05:55:48 -0400
X-MC-Unique: MBmnxP9YM8K8zvDBP0IVBA-1
X-Mimecast-MFC-AGG-ID: MBmnxP9YM8K8zvDBP0IVBA_1777370147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04F5A1800576; Tue, 28 Apr 2026 09:55:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74686180047F; Tue, 28 Apr 2026 09:55:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1380E21E6A28; Tue, 28 Apr 2026 11:55:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Jind=C5=99ich_Makovi?=
 =?utf-8?Q?=C4=8Dka?=
 <makovick@gmail.com>,  qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick
 Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 2/2] ui/gtk: Turn clipboard flag into runtime option
In-Reply-To: <afBmZcEGoC7C5md5@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 28 Apr 2026 08:48:53 +0100")
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
 <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
 <87340f5yoy.fsf@pond.sub.org> <afBmZcEGoC7C5md5@redhat.com>
Date: Tue, 28 Apr 2026 11:55:44 +0200
Message-ID: <87wlxr2yu7.fsf@pond.sub.org>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Apr 28, 2026 at 09:30:37AM +0200, Markus Armbruster wrote:
>> Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com> writes:
>>=20
>> > - Compile the GTK clipboard support unconditionally
>> >
>> > - Introduce GTK clipboard option, defaulting to off
>>=20
>> Should the patch be split?
>>=20
>> > Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
>>=20
>> [...]
>>=20
>> > diff --git a/qapi/ui.json b/qapi/ui.json
>> > index e3da77632a..b2c42a7f57 100644
>> > --- a/qapi/ui.json
>> > +++ b/qapi/ui.json
>> > @@ -1319,6 +1319,9 @@
>> >  #
>> >  # GTK display options.
>> >  #
>> > +# @clipboard: Enable host-guest clipboard sharing.  Defaults to "off".
>> > +#     (Since 11.1)
>> > +#
>>=20
>> Educate ignorant me: what does it mean to share the clipboard?
>
> Conceptually the intent is to create a single logical clipboard
> spanning the host & guest. IOW, if the guest copies data into
> its clipboard that is made available to the host clipboard, and
> vica-verca.

Thanks!  Could the description text explain that without getting too
verbose?


