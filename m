Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851AAC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADOf-0001ic-FR; Wed, 30 Apr 2025 15:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADOW-0001hS-PU; Wed, 30 Apr 2025 15:47:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADOU-00079i-Uz; Wed, 30 Apr 2025 15:47:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso113562f8f.2; 
 Wed, 30 Apr 2025 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746042417; x=1746647217; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQQqHwZFkeKj4s5nJT1gp7/F01IaqgJumqZGNwBFCnI=;
 b=SUfMuT6hSpX00reP82/wkUwT7yj58CDlEctKqSI01wA+7aTsT04IrmPhRoMoV+rSRJ
 qe3IHp/vF1c7cI54vfePXlPPWYrDkYSaH93IZIqG9gsIuXe9++/ZZdOuIN0GwmTOu8MN
 vCXtbJjsTmRQYldoeVxhVo75rdwJVnCoKSy3DAHSH4lyEi6JovIJThCTM2GuXc7HBcSY
 PgOK1H7gL+svS8svZ1GBqWQioG3E91fkkvVNbMIY71kt6KIA0V+FIA6dTI9VlfAuKr6p
 0MYjXJ44/aBlhSEyuqRCZKzd3/vIiaK3jqQHbP+v/FXfRxjB5WsrxwJOTJpqPI/sOgio
 2s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746042417; x=1746647217;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQQqHwZFkeKj4s5nJT1gp7/F01IaqgJumqZGNwBFCnI=;
 b=BTLts4DUQsTwxNCT29LRCLaWAAdIBQQ/6Tn1bEXBAOmFeZbdXOMsu0KQHWiKDVrwpg
 eJ0vowu6byitVRswNfFJk/PWmDQ2pMggWoI/zA9X2cD1Dk+AKAPmlxwrk/kwmUVVN2OL
 4OzFBiA9T1G0Q4spOimfxUf/DIfZtgTM2fO4/iDjpYIYZplBTZ/vmIT9MmXdMYqYbNUh
 kdrJtyvpyqmNrewQToIaLxxFeB5DYqpnutaxXxEAwlTxiYNzTXpnJJOkeZpqQpbdp+F4
 Z4nxNKbdlq1UmUN90LDnQwOoKqc7pI26ojTT13Tj5a4eZpjHfWF3TWeqrEK/4QTgVRLP
 vljg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYY22n8x+Z/bbBXzmIKA0dwJobwy0fXIL+xTMSQev6fQqRD+6cFLuJtO/XoC744oqE8dGzCKjE7JO4@nongnu.org
X-Gm-Message-State: AOJu0YzATjpBFMbvMmiQiY0Ijza+9XHX3oWuql8gwOhP71uz7XF7gORZ
 cmbamm0g7x/ZMVF0cM63cYoSQaZITM6UgXq36GkHwGDe4J/vlHJu
X-Gm-Gg: ASbGncvd4v/pi4LDV8Sq0A6N0hZBpCALsrqcgcpuxfxFQ63n7xSiyX5bntBjcwJha8w
 9KKtmN76VNfLPxcUui3A48dhfp5otqz+wSAgZ/Eg27zC/jSEJWBsimyvWHdd1dXyJGr5RBP4iVV
 Oht7rum/DxCSX4OQ+eep21p2l+ipo0+uCewrxdsdad4QoTVm+cAS+yq1sdqc2MdbN84FbHUYW9N
 wVH3peRE5VxmjV6oMEAA8gGfinuFWwiaEG7QpflOI+nPCfdXAJXIoKcGbCgt/FopqTnjfPyJgb6
 V0S+vJ5qbrDw1+tXstpT8WJgm3S9DGggplqYwWIAQUDpunYtGPLQc1AlGLj61Pek5/zKMPTa4sJ
 KoXlHFmddQYyxcSrF
X-Google-Smtp-Source: AGHT+IHtBoTnDbtBDQb0vc5V24JngDxIjhRBlqZmcj6g5uR8ftMvsloUw25nRdC/nTASNg0eBT7EhQ==
X-Received: by 2002:a05:6000:1785:b0:3a0:80dd:16d5 with SMTP id
 ffacd0b85a97d-3a08ff555bemr3591045f8f.55.1746042416400; 
 Wed, 30 Apr 2025 12:46:56 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc199fsm18057083f8f.55.2025.04.30.12.46.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:46:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 1/2] block/null: Report DATA if not reading zeroes
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <vwlluemb5ekotdzldygunjiztexa77263acgmimmeadwlkruit@rj2u6ydjs7zk>
Date: Wed, 30 Apr 2025 22:46:43 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DDEB504-7F24-4EC1-993E-523FADDC380A@gmail.com>
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-2-nirsof@gmail.com>
 <vwlluemb5ekotdzldygunjiztexa77263acgmimmeadwlkruit@rj2u6ydjs7zk>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 29 Apr 2025, at 0:49, Eric Blake <eblake@redhat.com> wrote:
>=20
> On Mon, Apr 28, 2025 at 01:58:59AM +0300, Nir Soffer wrote:
>> If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
>> BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
>> confuse users or other programs:
>>=20
>>    % qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, =
"zero": false, "data": false, "compressed": false}]
>>=20
>>    % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '1g'}}" &
>>=20
>>    % nbdinfo --map nbd://127.0.0.1
>>             0  1073741824    1  hole
>>=20
>> With this change we report DATA in this case:
>>=20
>>    % ./qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, =
"zero": false, "data": true, "compressed": false, "offset": 0}]
>=20
> Do we really want to represent the region as present?  I think we're
> okay (we guarantee that reads from the region will return sensible
> contents), and your next patch to allow control over what data is seen
> makes it even better.

I kept the existing behavior, but I think present=3Dfalse is relevant =
only if you have a backing file (like qcow2), so for null-co it makes =
sense to behave like file driver.

>=20
>=20
>>=20
>>    % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '1g'}}" &
>>=20
>>    % nbdinfo --map nbd://127.0.0.1
>>             0  1073741824    0  data
>>=20
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>> block/null.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>=20
>> diff --git a/block/null.c b/block/null.c
>> index dc0b1fdbd9..7ba87bd9a9 100644
>> --- a/block/null.c
>> +++ b/block/null.c
>> @@ -239,9 +239,7 @@ static int coroutine_fn =
null_co_block_status(BlockDriverState *bs,
>>     *map =3D offset;
>>     *file =3D bs;
>>=20
>> -    if (s->read_zeroes) {
>> -        ret |=3D BDRV_BLOCK_ZERO;
>> -    }
>> +    ret |=3D s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
>>     return ret;
>=20
> According to include/block/block-common.h,
>=20
> * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
> * BDRV_BLOCK_ZERO: offset reads as zero
> * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing =
raw data
>=20
> Or read differently, BDRV_BLOCK_DATA says an area is not sparse.  This
> patch is changing the null driver to report the entire image as either
> sparse and zero, or not sparse and not zero.
>=20
> For testing purposes, I think that is reasonable enough; it matches
> that file-posix.c always returns one or the other, when using only
> lseek() to probe things.  NBD has a bit finer-grained control (it has
> two bits, one for sparseness which is effectively !BDRV_BLOCK_DATA,
> and one for zero; where you can have something that is sparse but does
> not read as zero, such as SCSI that lacks coherent uninitialized
> read).  In fact, you could even have DATA|ZERO if we know something is
> allocated AND that it reads as zero (which will be the case in your
> next patch if the user explicitly asks for a read pattern of 0).

If we want this we can remove read_zeros, since read_pattern support =
reading zeros, and have:

    *read_pattern: uint8 (default unset)
    *block_status: =E2=80=9Cdata"|=E2=80=9Dzero=E2=80=9D (default data?)
    *allocated: bool (default true)

We can replace reads-zeros=3Don with read-pattern=3D0 in tests and docs, =
but it may break other users using null-co.

Maybe keep read_zeros for backward compatibility, and make it conflict =
with the new options?

>=20
> But for all of that thinking, in the end your patch makes sense to me.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org



