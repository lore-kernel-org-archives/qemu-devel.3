Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47546C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 10:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSF7-00061h-O3; Wed, 09 Jul 2025 06:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZSDI-0003yI-1o
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 06:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZSDE-0006Jv-6H
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752057577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbO1x+o4IzvYRWEeMDGPtwj0ol1gexY4D9+kamtnK1A=;
 b=UdRbHSdWv5Umfmf+/IBsBX+ZcrbBjlJdwGwr7ueCNOyLZsQOoY9nBWZgmMISOX37oMslR0
 TM/cOY05WU0vWcJopX8UbUn8Urbz0G76Ig3p9eGpFUt/s3UIOZ9od6WjYxnSuzXioKfP7p
 h8uW5l+//KDl5r6verX3LCR8CYAZGoI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-9NMqvA6lOvuXgeE9JAGdWA-1; Wed,
 09 Jul 2025 06:39:34 -0400
X-MC-Unique: 9NMqvA6lOvuXgeE9JAGdWA-1
X-Mimecast-MFC-AGG-ID: 9NMqvA6lOvuXgeE9JAGdWA_1752057573
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828D3180047F; Wed,  9 Jul 2025 10:39:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D00EE3000198; Wed,  9 Jul 2025 10:39:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 278BB21E6A27; Wed, 09 Jul 2025 12:39:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Andrew Keesler <ankeesler@google.com>,  berrange@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/1] hw/display: Allow injection of virtio-gpu EDID name
In-Reply-To: <CAJ+F1C+qHhefC+Mg7jxK=TfYhVSMF2PZqwBcXLoGN29t34jFCg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 9 Jul 2025
 10:28:10 +0400")
References: <20250708170745.141040-1-ankeesler@google.com>
 <20250708170745.141040-2-ankeesler@google.com>
 <CAJ+F1C+qHhefC+Mg7jxK=TfYhVSMF2PZqwBcXLoGN29t34jFCg@mail.gmail.com>
Date: Wed, 09 Jul 2025 12:39:30 +0200
Message-ID: <87jz4hps0t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jul 8, 2025 at 9:07=E2=80=AFPM Andrew Keesler <ankeesler@google.c=
om> wrote:
>>
>> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
>> Identification Data) is propagated by QEMU such that a virtual display
>> presents legitimate metadata (e.g., name, serial number, preferred
>> resolutions, etc.) to its connected guest.
>>
>> This change adds the ability to specify the EDID name for a particular
>> virtio-vga display. Previously, every virtual display would have the same
>> name: "QEMU Monitor". Now, we can inject names of displays in order to t=
est
>> guest behavior that is specific to display names. We provide the ability=
 to
>> inject the display name from the frontend since this is guest visible
>> data. Furthermore, this makes it clear where N potential display outputs
>> would get their name from (which will be added in a future change).
>>
>> Note that we have elected to use a struct here for output data for
>> extensibility - we intend to add per-output fields like resolution in a
>> future change.
>>
>> It should be noted that EDID names longer than 12 bytes will be truncated
>> per spec (I think?).
>>
>> Testing: verified that when I specified 2 outputs for a virtio-gpu with
>> edid_name set, the names matched those that I configured with my vnc
>> display.
>>
>>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>>   -device '{"driver":"virtio-vga",
>>             "max_outputs":2,
>>             "id":"vga",
>>             "outputs":[
>>               {
>>                  "name":"AAA",
>>               },
>>               {
>>                  "name":"BBB",
>>               }
>>             ]}'
>>
>
> (there are still invalid trailing ',' in this example)

Yes:

    $ qemu-system-x86_64: -device {"driver":"virtio-vga", "max_outputs":2, =
"id":"vga", "outputs":[ { "name":"AAA", }, { "name":"BBB", }]}: JSON parse =
error, expecting value

Should be fixed for the merge.

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
>> Signed-off-by: Andrew Keesler <ankeesler@google.com>


