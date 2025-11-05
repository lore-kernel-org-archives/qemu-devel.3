Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF5CCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGXbF-0005xd-Cv; Wed, 05 Nov 2025 02:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGXbC-0005xB-7c
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGXbA-0004ZP-AL
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762326386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ydvj4qXxZ4ALg2iB228FPFiDHevq43XOtbLOJSolUC4=;
 b=IqkKlok1ezKddKX+5+fVG0UVfren75LrXBHWDKELjEfmTiodoGsXPRYyitwIHwol2as1o5
 3gIs8iu7jEH/36P8MNssdt6sWQ9M4KkaERayCmnLSpANYfS2itqqThovTGsV6LYifOP14p
 SkmmenEopkSmoDMYtCqQm25ybWJ3Od8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619--_t3hOBIP6e5dGdgNmX2zg-1; Wed,
 05 Nov 2025 02:06:25 -0500
X-MC-Unique: -_t3hOBIP6e5dGdgNmX2zg-1
X-Mimecast-MFC-AGG-ID: -_t3hOBIP6e5dGdgNmX2zg_1762326384
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D74A1800650; Wed,  5 Nov 2025 07:06:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E622519560A2; Wed,  5 Nov 2025 07:06:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43E7D21E6A27; Wed, 05 Nov 2025 08:06:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <CAJ307EgK9sqa6TNHRWo9uOkB=UXtu6CU+Zsaa_T6wcQjaUPngg@mail.gmail.com>
 (=?utf-8?Q?=22Cl=C3=A9ment?= Chigot"'s message of "Fri, 31 Oct 2025
 14:07:14 +0100")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 <87ms5cmtqh.fsf@pond.sub.org>
 <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
 <877bwbcy3e.fsf@pond.sub.org>
 <CAJ307EiBBKDiLAX=CCx3d9n6PQQ5JnBv8RCWZpQqartVzWcBKg@mail.gmail.com>
 <aQSkCSjgyoDRZCB6@redhat.com>
 <CAJ307EgK9sqa6TNHRWo9uOkB=UXtu6CU+Zsaa_T6wcQjaUPngg@mail.gmail.com>
Date: Wed, 05 Nov 2025 08:06:21 +0100
Message-ID: <878qglot5e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

> On Fri, Oct 31, 2025 at 12:57=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wr=
ote:

[...]

>> Imagine the simple case of a qcow2 image file used for the VM. You get
>> things stacked like this:
>>
>>         virtio-blk
>>             |
>>             v
>>           qcow2
>>             |
>>             v
>>           file
>>
>> You need to open them from bottom to top. Opening a qcow2 image must be
>> able to read from the file, so first the file layer must be opened. And
>> obvious a virtio-blk device can only use the image after the qcow2
>> layered has been opened.
>>
>> In your case, this is raw over vvfat. vvfat gets opened first, and then
>> raw gets instantiated on top of it. (If you use format=3Dvvfat, then the
>> raw layer is left away.)

Desirable, because it's simpler.

>> Top level options you give to -drive go to the topmost block driver. You
>> should be able to still set it on the vvfat level with -drive
>> format=3Draw,file.size=3D... Deciding which option goes to which node is
>> part of the (rather complicated) bdrv_open() logic in block.c.
>>
>> What raw does when a size option is given is that it just truncates the
>> lower level to the given size. So as vvfat doesn't know the size, it
>> still creates a 504 MB image, but raw shows only the first part of it to
>> the guest. This results not only in an invalid partition table, but also
>> means that as soon as vvfat decides to put a cluster after your limited
>> size, you'll see filesystem corruption in the guest.
>>
>> So your approach to deal with this in vvfat and create a smaller
>> filesystem to start with does look right to me.
>
> Ok thanks for the explanation. It's a bit counter-intuitive that
> "size" does not propagate to lower levels, especially if it generates
> wrong ones behind the scene.

Format "raw" was designed to do nothing, so we have a "do nothing"
format for the rigid "format over protocol" system.

We've long acquired the means to use a protocol without a format.  This
made "raw" redundant.  I advocate omitting it, because it only
complicates matters.

Except when you want the one feature "raw" provides beyond "do nothing":
carve a slice with options offset and size (commit 2fdc70452a5 "raw_bsd:
add offset and size options", 2016).

>                              But IIUC, this would be a much more
> complex patch (i.e. changing bdrv_open logic).

"size" is for slicing.  Can't see how it could simultaneously be
forwarded to the next block driver.

> Hence, I'm fine keeping this series narrowed to "format=3Dvvfat".
>
>
>> Kevin
>>


