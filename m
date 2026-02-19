Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE52FE9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtA1t-0008Af-SR; Thu, 19 Feb 2026 14:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vtA1l-00088b-S2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vtA1k-0006jz-Bv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771530571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3w/nDo2pjgq2cNZmndgIWTj5G/TMoCC4ql/U8UAgL70=;
 b=ggNRbS/CvvOL374JY78mdhaeIODFFj6RzWFtRKn94nbVVwpMxOMSjlnZRn+ZwBOZvGEfcj
 QdK5a1F/u+MD0Md/Zi26gGTX8vnOLW6pDb3Fryp4+oeqCvSTGBCMPG28QW6PPWf1yPApZS
 FsK9Y5qSGhygCVkHZceh0JGHhRXwaHw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ltr1RllSPw-l9oGbYz-mAw-1; Thu, 19 Feb 2026 14:49:29 -0500
X-MC-Unique: ltr1RllSPw-l9oGbYz-mAw-1
X-Mimecast-MFC-AGG-ID: ltr1RllSPw-l9oGbYz-mAw_1771530569
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64adb64a043so2827232d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771530569; cv=none;
 d=google.com; s=arc-20240605;
 b=SlKz7OzkSolbsn4TsSsocAhkoQkGRxHrubLvfK2QadyUlDkIOLF3otHnCLNaQs7CIE
 g8wDc/ymKw6pjyPu2FIhb74oYXGSOE1DYTVIwAtKWeuhVrFkj5MGdstt0YiUPuXA9wQS
 I7uf5GDBvAUwujtmyA3Oe0r8S+6u4OoEw4tjm6Clc985eZzBTgexCyzsMdfgULb9peRj
 Ghk8/oGDbLedYvNDP5BmQFYWVc3kTv8TYpeSCJgiK6Lzic+SSX9wBiSZki9or2XzeU8C
 KBoJda8k2XC7L6Exad0vyAK6C7bH+Z5C0yEocDa4ac/DCKX5GESrFm0TvnIXh8x3fWmg
 sRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3w/nDo2pjgq2cNZmndgIWTj5G/TMoCC4ql/U8UAgL70=;
 fh=vx0Tp3VJSo8e81n3LMN5/HaTS3Pu+3rsK1iF7VPu1EM=;
 b=ldoWnptAc7uwxjZLi5HR6tFHbLUchTa5EcHHO1te+IzJmotXNATA0PhVZDtS4XKzD7
 +ZIiuwd0CNOP2L/SZSW/vs6r5iwXDP1dALKLjoISH1aCjmgntpiWt004zeYM5iofPr47
 AFPgxUG65kfL4V5Vrd58yYD87gTGu8VRrVTq3SuarCiR9MG3FnUWgQ1fIIo54m8hjoPt
 mVrBeGj17VvrpMqvbBA+Ofg0ru4UpkFaWr+n5wEhmqUbYcuIfvPAuAw9elz90XGDK6j9
 HcmzqPq/MatYDM6PmJkqi5FqUJ5LnNI8tUbANjAY+1jnZ1+6jaQzziPGbPYkLB3YilaH
 El6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771530569; x=1772135369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3w/nDo2pjgq2cNZmndgIWTj5G/TMoCC4ql/U8UAgL70=;
 b=oPrbGAV4PsqbRek9def3lIfgNG+cFxjTeAhkwInsiPaiU0sZBWa/Kp1FNjWKfTHSTV
 hy8j2CICxpvzWsoJaAu93bfhhc5zIFWEK51NqsfjxNhcZN7XBrsSsy63dYZrum1VFx+Q
 4xSyovZN8EcCVLqxbarZen9bGRngITXZFhKtBZ8VwDPs/9FhHTAYZFzL1GLP4Ecrq7M9
 hDXjixbffQYgy2J+j/19YvRYEk3Vc9PSq+ONiha6mObwe/ypyxjTcgirCRzrczQxdX25
 IQ/pANaFcP9yEP1mRTpg/BT4ujpdaUrHE9r4H7xz822SLzFs7a0DWZXIeMfE4NWYgHvj
 KDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771530569; x=1772135369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3w/nDo2pjgq2cNZmndgIWTj5G/TMoCC4ql/U8UAgL70=;
 b=MCUoK3Mitf7vYgBBEgZjY/HwtwdaQeoqn2WoPNpy3jpNIWCNKLCD9Y8zIL+eT9/0OT
 yYkOLaYA/onnTQZ709wkU0h8OjTQUyG09jkGLSTeplNlKMf9W8xREddjrWPHRUeuhXYS
 noLt0WauKvowKPHZ9WCytrZejRs5dqpMLK7PtHZ7kr9sjgAAu0Z7JgmxpgOrUgrt5b+c
 /XFJMCv/g0cFiTQaPEzirFCGUmMk3cXQlYd/s8aXK1akF5zebdxFAAG4Wl5pdKJDW8NY
 QMkgfiUJoFdzePjq1UZ6A8YhRZTMrFxG/ES0QEdgVgMTfNiNmUsayRvwJSwJjNudwqU9
 y4OA==
X-Gm-Message-State: AOJu0YzvhCKM3ZfQuji4x1rKGMh/9Vfocp56bHyG5JAbDO6XEvIiRWoi
 sGqUP0gvcNAJVMWPK5e28ex6SyZGsVJAvau7szwPVVsaiBdG8dVX5SZxcxIICGJEt+i9JUvYF11
 VqWVnBkK7sWzsoFIl1O4r1Kp9OlNkKb+Gk6kCjCbYauelJTy+ITsBMdUA3kZykD7xAOVngVdnHN
 NON2SBeqCZFNboe1Fwp1YanfHGxy0Wrws=
X-Gm-Gg: AZuq6aL4R+/ibkUQimQpzZNQ/PgscL2v+PkbSYhMqLpbyKbkEM80hW5SHgQLdqsZ1Yh
 2M/vneb5WPwmybwINuk11Bl477l8qg4nLPmIfmS0FeU5f5PWchYmpNDaZ6pZFHRCUnV9JwJHoA2
 JVYba4oR4laHlbC4LS3xGcGoSm++oe3EjbyKdfym8z0RouRvK+h3bSm3XZ7SIY1V8TvDGXC3lz0
 nbUJcgEK4yb1X3jrZ+WITLa2cVk9o8MQJZMHA==
X-Received: by 2002:a05:690e:d46:b0:64a:efe4:7b47 with SMTP id
 956f58d0204a3-64c21b821afmr11968318d50.83.1771530569242; 
 Thu, 19 Feb 2026 11:49:29 -0800 (PST)
X-Received: by 2002:a05:690e:d46:b0:64a:efe4:7b47 with SMTP id
 956f58d0204a3-64c21b821afmr11968299d50.83.1771530568872; Thu, 19 Feb 2026
 11:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAPDLHD4XhjpmiJPNJi5kO20bbe51=RBgDoy1LF2wJ7sCaLbCzQ@mail.gmail.com>
In-Reply-To: <CAPDLHD4XhjpmiJPNJi5kO20bbe51=RBgDoy1LF2wJ7sCaLbCzQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 19 Feb 2026 14:49:17 -0500
X-Gm-Features: AaiRm52tppuT1ErIYZsL_cw4l3Etji_wR1_-SBViHWENfyzl2uD3jNAj0OURrA8
Message-ID: <CAFn=p-ZS1_tEWK04smp7KSHrH4TH3GACvf59+ZHY=kp0PkeZkg@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Joel Bueno <buenocalvachejoel@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Feb 9, 2026 at 5:10=E2=80=AFAM Joel Bueno <buenocalvachejoel@gmail.=
com> wrote:
>
> Adding jsnow, I forgot to initially add him! Also, bumping again. Thanks =
and sorry for the bumps.

Hi, sorry, what's the context here? I don't believe I've worked on
this device before, what type of review are you hoping for from me?

>
> On Wed, Jan 7, 2026 at 12:29 Joel Bueno <buenocalvachejoel@gmail.com> wro=
te:
>>
>> Is there any feedback on this patch series?
>>
>> On Sun, Dec 21, 2025 at 11:53 Joel Bueno <buenocalvachejoel@gmail.com> w=
rote:
>>>
>>> The Fast Read (0Bh) instruction requires 8 dummy clock cycles
>>> according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
>>> However, the current code adds 8 to needed_bytes, which represents
>>> bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
>>> communication (1 bit per clock edge), this results in 64 dummy
>>> clock cycles instead of 8.
>>>
>>> Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
>>> (64 clocks), matching the existing implementation for SST flash and
>>> the datasheet specifications.
>>>
>>> Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
>>> ---
>>>  hw/block/m25p80.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index a5336d92ff..21c2118b33 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
>>>          s->needed_bytes +=3D 1;
>>>          break;
>>>      case MAN_WINBOND:
>>> -        s->needed_bytes +=3D 8;
>>> +        s->needed_bytes +=3D 1;
>>>          break;
>>>      case MAN_NUMONYX:
>>>          s->needed_bytes +=3D numonyx_extract_cfg_num_dummies(s);
>>> --
>>> 2.51.0
>>>


