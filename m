Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F75D3B9B9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 01:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT8ss-0000bq-3t; Tue, 09 Dec 2025 20:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vT8sn-0000at-5U
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 20:20:45 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vT8sk-0001KX-7O
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 20:20:44 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4557f0e5ed2so263011b6e.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 17:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1765329638; x=1765934438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8oBGK1KdOABAnFfsP0qsJhYB/JHMqk9uhAK0zmDX3Y=;
 b=FG+ifRwSUYu5M9kTPlujRVvTdmq8jn/e8rUo/wh3PPN0pDjItFoX4hsWg9DD9QeLog
 IhtLPCb9h98y86A3IMLkBwGXfv7YgI/83EHcVX0rRkT/vwNwJj0OQhzIh649crAwKeLr
 zQjOAy2yhcfNxFJeqmP7bIEGtV+YiK+YizwqNKpS0oVYoaqyMBhUtGqwtAVjwH8DNdsq
 QvTQq5Pm6iT41qNqnpAcYvjTT6GN8U2wxTWbpgvVu4VMXmJoLvcBcB1R/b/pFZF1NnXg
 O9QAtaZVcuqoKXuqGA3Mk7OWP4m9pkSv4dYgddCkQTr/xnOTajmaIVFm6HxF5z2gM0bF
 x3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765329638; x=1765934438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8oBGK1KdOABAnFfsP0qsJhYB/JHMqk9uhAK0zmDX3Y=;
 b=Zu0lYfDlRRSp68iAxoK8aPKsAl35FMKsV8/btAPpnsnvSQXoptGj+DNM5YDlVusbN3
 BrWBwXqUrr4o38UOo8YFfDzrwMcG+oy0EuZmAgM7zWeBVoxAlPiv3uxt3afzk07roAzA
 TGAWJM2A1ztRMPK8/X9DwbF6yAjyyhD/0tCWjgO5UopzVgk7TsSJuYM5CzUDLUGMZCxX
 fTCRiwC0nsurg1zWeYKYfilfTiP3msQHz7ekF3KfJCR+5uwKPWVkhHeTiVERSOQQ17Aw
 Z+2ce8NEh6Jz+tDOFTomfwxKeAaca8haYu/99tBYkdIWXaxHwrKY2fkrZ3O1tBK9NSdA
 P7WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzmb+5JrSwUV9JHqlozC8Tm24SNbixt/WpUxDOq4n+xWabL5QFf+nl1ynpC0lDsGt+X587y6OHpmJ@nongnu.org
X-Gm-Message-State: AOJu0Yzh8oG0TbWCJv2oOk3XM1GToyqE+YZt1OVaQRxoFxd3+c4f5tzz
 D8yTssa0gN//M3mcz0MdAWlxvUzpnv+6WeybXR628L6TCppbSCn6IC6etCfp1kuwRq+Zu8gkj4L
 q9PMjiU6argKthF8HlnO5CoPwehPOEUrk7NtxDilExg==
X-Gm-Gg: ASbGncsbie0ttdh9LES9HA/ThwtDTji1SVs+7jLXCPQplTY4UnU6+fq5JQIDPL87zFg
 +MxSrZIFVWvZmg4NnCoGPadtuADmC+UTaWSqSa6e1RZWL0S17UBL+no+8c2g+8avje+cI0JxaBY
 9JUaYYlnyour3Xw5ZwbyugK9U+ra/0sqHNMJFdBZ1OuX6VyhrnNqxzeEtF5JSYfpLw5GFor4E7h
 HlIFrPSEp6MI+Lx/hJiT86OrWyNjs/0tX+2sigNEO0oBiOxjJ35o+SbiTsH5+2qOgs1Q7QE
X-Google-Smtp-Source: AGHT+IGprwzZta7P7pKbJtIa3Uhf87gr8aG7fSZQjW/0BCKR6CsZZHpkrGaCCr5JyUwK6sm35ork/AWTp2m10ajLRrI=
X-Received: by 2002:a05:6808:1583:b0:450:5db3:71cb with SMTP id
 5614622812f47-4557a1a9e68mr1671612b6e.17.1765329638470; Tue, 09 Dec 2025
 17:20:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
 <20251209022028-mutt-send-email-mst@kernel.org> <aTfpQO14axEvcOIT@redhat.com>
In-Reply-To: <aTfpQO14axEvcOIT@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 10 Dec 2025 01:20:26 +0000
X-Gm-Features: AQt7F2p1WutS6vK_FF6c8HApUzC9uKYC--xNUIcrn3ZAt7QrqCPHorE6F9hjKx8
Message-ID: <CAJ7pxeYbd+yq9VXob2zTShBd5Ph598kmjLJTsKdKzFikCbVLLA@mail.gmail.com>
Subject: Re: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing
 making communication unreliable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>, 
 Vishnu Pajjuri OS <vishnu@os.amperecomputing.com>, 
 Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oi1-x234.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ATTENTION=0.499 autolearn=no autolearn_force=no
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

Hi Daniel & Michael,

Many thanks for replying.

On Tue, Dec 9, 2025 at 9:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Dec 09, 2025 at 02:24:44AM -0500, Michael S. Tsirkin wrote:
> > Hi guys,
> > who has ability to contact the list admins? Can help Salil?
>
> I'm not a list admin, but I have some observations below
>
> > ----- Forwarded message from Salil Mehta <salil.mehta@opnsrc.net> -----
> >
> > From: Salil Mehta <salil.mehta@opnsrc.net>
> > Date: Tue, 9 Dec 2025 00:44:04 +0000
> > To: "Michael S. Tsirkin" <mst@redhat.com>
> > Subject: [ATTENTION] Mails on qemu mailing list are disapapearing makin=
g communication unreliable
> > Message-ID: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.g=
mail.com>
> >
> > Hi Michael,
> >
> > I hope you are doing well.
> >
> > I=E2=80=99ve noticed that some emails are going missing from the qemu-d=
evel mailing
> > list. This has now happened multiple times, both with emails I have sen=
t from my
> > official address and with emails from other contributors.
> >
> > Over the past three months, I have consistently observed emails disappe=
aring
> > from the qemu-devel archives, which makes the mailing list communicatio=
n highly
> > unreliable.
>
> I can see patches arriving in my INBOX via qemu-devel from salil.mehta@op=
nsrc.net
> but no patches from salil.mehta@huawei.com
>
> I do see some (non-patch) emails from salil.mehta@huawei.com, but the
> mailing list is re-writing this From address for DMARC countermeasures
>
>  Salil Mehta via <qemu-devel@nongnu.org>
>
>
> Recapping mail delivery policies, DMARC requires a pass for *either*
> SPF or DKIM checks.
>
> SPF checks will always fail for mails forwarded via any mailing list.
>
> DKIM checks should still succeed *provided* the mailing list does not
> modify the message content, or certain headers. QEMU mailing list
> behaves in this respect generally, and applies countermeasures when
> appropriate.
>
> I see no  DKIM records huawei.com, but I do see SPF records.


Thanks for identifying this.

When you say there are no DKIM records for huawei.com, do you mean
that my @huawei.com mails do not contain any DKIM-Signature header,
or that a DKIM-Signature is present but cannot be validated against
a published key?

If there are SPF/DKIM/DMARC logs on the list side, would it be
possible to see whether DKIM validation is failing for my messages?


>
> This guarantees DMARC fail for any @huawei.com sender using any mailing
> list, however, the @huawei.com DMARC policy is only set to 'quarantine'.

Agreed. I will check with the IT department here about the DKIM
headers and whether the public key is being published correctly.


>
> That should not block delivery to list subscribers, merely suggest
> that MTAs put the mails in the Spam/Junk folder *if* DMARC fails.
>
> mailam is cautious and thus applying DMARC countermeasures to huawei.com
> addresses due to he missing DKIM records, in order to reduce the chance
> that the mails end up in Spam/Junk folders for list subscribers.
>
>
> This does not explain why messages might never appear in the list to
> begin with though.

Agreed.

>
> It is notable, however, that messages from salil.mehta@huawei.com
> do arrive if they are non-patch mails. Presumably those are via a
> normal email client

This is not always true.


>
> I wonder how Salil is sending patches ? Some tool like git send-email
> or git-publish ?

Mails disappear or not appear in the mailing list even when I reply
via outlook and the same happens when I sometimes use git-send-mail.

check these:
https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opn=
src.net/

AND

https://lore.kernel.org/qemu-devel/CAJ7pxea721f4EwqpDdcztgRoN-rsB2tqthf-_Kb=
+mmsRkK1GyQ@mail.gmail.com/

I'm replying to this broken link which existed but disappeared later.
 [not found] <20250930224037.224833-1-salil.mehta@huawei.com>


>
> If so I then wonder if the tool is NOT correctly configured to use an
> official huawei.com outbound SMTP relay ?
>
> While you can have git send-email deliver directly to lists.nongnu.org,
> the huawei.com SPF policy will almost certainly result in the mails
> getting either rejected or dropped, *UNLESS* they are relayed via one
> of the officially designated huawei.com SMTP relays.

This configuration is correct. With this configuration, no mail will be sen=
t
outside Huawei. There are other addresses as well in the TO/CC list.
I'll rule out this aspect.


> > For example, the attached .eml file is a message from Vishnu (Ampere) w=
hich
> > was sent to the list but later disappeared. This is starting to raise s=
erious
> > concerns about the reliability of the mailing list, and the broken comm=
unication
> > is creating confusion for everyone involved.
>
>
> In terms of mails from Vishnu, I see nothing in my INBOX from Vishnu.
>
> The mail quoted below has a From address of vishnu@amperemail.onmicrosoft=
.com,
> while people seem to sending to/cc for vishnu@os.amperecomputing.com
>
> Is that From address correct ? It seems like the latter is more likely to=
 be
> the canonical address for Ampere accounts.

It must be the correct one because I attached the .eml for the received mai=
l.
And I really don't have a clue how this address is different from  the
other i.e.
@os.amperecomputing.com

[+] Adding Vishnu to CC, maybe he can share more details and share his
.eml file.


>
> If not, perhaps that is triggering some rule that discards the mails when
> sending is amperemail.onmicrosoft.com

Could be. Do we have access to the logs to verify the reason?


Best regards
Salil.

> > From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
> > Date: Mon, 27 Oct 2025 13:58:59 +0530
> > To: Igor Mammedov <imammedo@redhat.com>, salil.mehta@opnsrc.net
> > Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
> >  salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
> >  jonathan.cameron@huawei.com, lpieralisi@kernel.org,
> >  peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.=
com,
> >  andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
> >  eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
> >  oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
> >  rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
> >  gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
> >  linux@armlinux.org.uk, darren@os.amperecomputing.com,
> >  ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
> >  gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
> >  miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.c=
om,
> >  wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
> >  jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
> >  shahuang@redhat.com, zhao1.liu@intel.com
> > Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like F=
eature
> >  for ARMv8+ Arch
> > Message-ID: <c2462372-f797-47f3-a96e-4872f9cedde5@amperemail.onmicrosof=
t.com>
> > In-Reply-To: <20251006160027.20067fe4@fedora>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

