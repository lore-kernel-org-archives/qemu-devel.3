Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFACC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qwu-0008OU-Jh; Wed, 16 Sep 2026 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x6qwt-0008Dp-29
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:23 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x6qwp-0006fe-0R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789570154; x=1790174954; i=deller@gmx.de;
 bh=G/onJNDyDT62fhxnRRSZue2liLsPZRcOyDF3d1WQvIo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RN8lHSRbVFXylZ6p7pAMEE1Sy4gqZw96aCLvtfjzqXO2UYZLiQPMQuhhfiVAesPJ
 S6H5K9W8QiMw/XqVeOuUoISveN/i+oWuQcg5+ubK2fDcIn801d2i0c19gPZ4LNYAa
 T6acLBdosJhENwG8yUf3F3ijlHLMEDEXKuASx88sbClr1dGHE6gY6CnfifzuFmauW
 jlKq3/qVOyMXWYfGQbTNWkZpf03CotUqp079+di/M5gbxNoCI1zgWnvZd4xwZhdLD
 z6PRJ+iPGziUtAPBFzjrWO6QojHZmH7QRkWfcz856It7JQRhSfZah5PsWzN8GJBSd
 zee3GzYM18csszKdvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1xP4Hs0ATO-00Uh9o; Wed, 16
 Sep 2026 16:49:14 +0200
Message-ID: <1a8ee1d3-88a5-4827-a306-43df82caea87@gmx.de>
Date: Wed, 16 Sep 2026 16:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] ncr710: cleanups and fixes for request lifetime
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Keith Monahan <keith@techtravels.org>
References: <20260916132120.860910-1-pbonzini@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0geNdMrb7YtFB/+OrNNoE38BN6M6aMvdZCbp7HU/uIW74H/Y/Dr
 s2Wza4s0vuDq0TbLWy8rE7v2kxY0JkdYZKmciNJqGbrr910oxgt/R4Jy5+UYx5Eil3oZ6ih
 gieOS3wQWP7kZrf2RqOeNKr7zq/Z16nKeaIxObsj44XtCDDhTrSaBZJj0yV4pBvMqIE0FLj
 mNExjJJ0x3BuItU11BMQg==
UI-OutboundReport: notjunk:1;M01:P0:fsHSgt0pm0I=;8loCgtJc8+ZTvr/k4AT+MZVqxlj
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

Hello Paolo,

On 9/16/26 15:21, Paolo Bonzini wrote:
> The ncr710 HBA code is similar to lsi53c895a, but it can be simplified
> due to lack of support for tagged command queuing.  Perform a bunch
> of cleanups and copy over the fixes from commits up to
> d459131ff590c517bc89fa5867d4878b5eacbc30.

I haven't tested your patches yet, but the current version of the ncr710
driver hangs on HP-UX and *BSD guests (works only with Linux guests).
I assume your cleanups will not fix this?

In addition, Keith Monahan posted two weeks ago a patch which replaces
this driver by a new version which is based on top of the lsi53c895a
code base and which I tested successfully with Linux, HP-UX and *BSD guest=
s.
There were some discussions about it here:
https://patchew.org/QEMU/20260701213359.1855870-1-keith@techtravels.org/

Isn't there a chance to use his driver instead of trying to clean up
the existing driver?

Helge

>=20
> Paolo Bonzini (8):
>    ncr710: simplify ncr710_clear_pending_irq
>    ncr710: reuse ncr710_clear_pending_irq in ncr10_do_command
>    ncr710: remove weird p->req =3D=3D NULL case
>    ncr710: clean up ncr710_transfer_data
>    ncr710: do not load s->current in advance
>    ncr710: remove dead message in actions
>    ncr710: copy reference counting fixes over from lsi53c895a
>    ncr710: unify two conditionals
>=20
>   hw/scsi/ncr53c710.h |   3 +-
>   hw/scsi/ncr53c710.c | 167 ++++++++++++++++++++------------------------
>   2 files changed, 76 insertions(+), 94 deletions(-)
>=20


