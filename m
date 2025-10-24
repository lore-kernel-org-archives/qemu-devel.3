Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A52CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDHG-0001k4-S2; Fri, 24 Oct 2025 04:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCDHF-0001jl-Ee
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCDHC-0005U6-Gq
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761294956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=U/YMcayaIu6umHLLLvVXP/pil8Sdt7o9tSyto535lkw=;
 b=dnzlEG9H4QCDUhJFHmPOByreH0nhKhbCSsM22gW1nrZW52FbI5jwDHNr1PogIxQ4S9aitw
 9wYwn6cAy956xXtxSdGuJcW6sbj1SJ80dAPeDbWj6sduSXXqaA7IauALNyV7rd5tMCWEj6
 R677Ebn0cmP5q21cpUEz/1+uUwCm/ps=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-UEur_-YxOZO67qVR8GxNoQ-1; Fri,
 24 Oct 2025 04:35:52 -0400
X-MC-Unique: UEur_-YxOZO67qVR8GxNoQ-1
X-Mimecast-MFC-AGG-ID: UEur_-YxOZO67qVR8GxNoQ_1761294951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ECFA19541BD; Fri, 24 Oct 2025 08:35:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AB1730002DB; Fri, 24 Oct 2025 08:35:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BDF921E6A27; Fri, 24 Oct 2025 10:35:47 +0200 (CEST)
Resent-To: chigot@adacore.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 24 Oct 2025 10:35:47 +0200
Resent-Message-ID: <87ecqs3dek.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <aPqCJRNCjxcZ6jq5@redhat.com> (Kevin Wolf's message of "Thu, 23
 Oct 2025 21:29:41 +0200")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com>
Date: Fri, 24 Oct 2025 10:30:17 +0200
Message-ID: <87ms5g3dnq.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
>> This allows more flexibility to vvfat backend. The value for "Number of
>> Heads" and "Sectors per track" are based on SD specifications Part 2.

This is too terse to remind me of how vvfat picks cylinders, heads, and
sectors before this patch, so I need to go dig through the source code.
I figure it depends on configuration parameters @floppy and @fat-type
like this:

    floppy  fat-type    cyls heads secs   cyls*heads*secs*512
    false      12         64    16   63         31.5 MiB
    false      16       1024    16   63        504   MiB
    false      32       1024    16   63        504   MiB
    true       12         80     2   18       1440   KiB
    true       16         80     2   36       2880   KiB
    true       32         80     2   36       2880   KiB

How exactly does the new parameter @size change this?

>> Some limitations remains, the size parameter is recognized only when
>> "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxxx" is
>> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
>> FAT12. FAT32 has not been adjusted and thus still default to 504MB.

31.5MiB unless I'm mistaken.

I'm not sure what you're trying to convey in this paragraph.  As far as
I can tell, you're adding a @size parameter to vvfat, so of course it
doesn't affect raw.

>> Moreover, for flopyy, size=3D1M is creating a disk 1.44 MB, and size=3D2=
M a

floppy

>> disk of 2.88 MB. This avoids having to worry about float operations.

More on this part below.

>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>> ---
>>  block/vvfat.c | 165 ++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 141 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index 6526c585a2..4537c39d5c 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -1091,6 +1091,11 @@ static QemuOptsList runtime_opts =3D {
>>              .type =3D QEMU_OPT_BOOL,
>>              .help =3D "Do not add a Master Boot Record on this disk",
>>          },
>> +        {
>> +            .name =3D BLOCK_OPT_SIZE,
>> +            .type =3D QEMU_OPT_SIZE,
>> +            .help =3D "Virtual disk size"
>> +        },
>>          { /* end of list */ }
>>      },
>>  };
>
> Like in patch 1, you need additional changes, in particular to add the
> option to the QAPI schema in qapi/block-core.json.
>
>> @@ -1148,10 +1153,141 @@ static void vvfat_parse_filename(const char *fi=
lename, QDict *options,
>>      qdict_put_bool(options, "no-mbr", no_mbr);
>>  }
>>=20=20
>> +static void vvfat_get_size_parameters(uint64_t size, BDRVVVFATState *s,
>> +                                      bool floppy, Error **errp)
>> +{
>> +    if (floppy) {
>> +        /*
>> +         * Floppy emulation only supports 1.44 MB or 2.88 MB (default).
>> +         * In order to avoid floating operations ambiguity, 1 MB is
>> +         * recognized for 1.44 MB and 2 MB for 2.88 MB.
>> +         */
>> +        if (!size) {
>> +            size =3D 2 * 1024 * 1024;
>> +        } else {
>> +            if (size =3D=3D 1024 * 1024 && s->fat_type =3D=3D 16) {
>> +                error_setg(errp,
>> +                           "floppy FAT16 unsupported size; only support=
 2M "
>> +                           "(for an effective size of 2.88 MB)");
>> +            } else if (size !=3D 2 * 1024 * 1024 && size !=3D 1024 * 10=
24) {
>> +                error_setg(errp,
>> +                           "floppy unsupported size; should be 1MB (for=
 "
>> +                           "an effective size of 1.44 MB) or 2.88M (for=
 "
>> +                           "2.88MB)");
>> +            }
>> +        }
>
> This is horrible. To be fair, it's pretty hard to do something not
> horrible when the usual units to describe floppy sizes are already
> horrible. :-)

Yes :)

> But I'd still like us to do better here.
>
> To me it looks a bit like what we really want is an enum for floppy
> sizes (though is there any real reason why we have only those two?), but
> an arbitrary size for hard disks.
>
> Without the enum, obviously, users could specify 1440k and that would do
> the right thing. Maybe special casing whatever 1.44M and 2.88M result
> in and translating them into 1440k and 2880k could be more justifiable
> than special casing 1M and 2M, but it would still be ugly.
>
> Markus, do you have any advice how this should be represented in QAPI?

Maybe, but first I'd like to understand what @size does.


