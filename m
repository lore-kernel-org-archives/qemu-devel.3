Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A023C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljPz-0001ew-NN; Mon, 20 Jul 2026 04:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljPt-0001eU-TN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:32:03 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljPs-0002Tt-2J
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:32:01 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7dbcb505578so61402087b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536318; cv=none;
 d=google.com; s=arc-20260327;
 b=RyMntX0Vm8RfYUaIA8tHSTO2DZmItGBbQuvjxoucogVT84Pj9GaoI7Dw6M/eMz4Hgr
 ctH4ZhXr835VHiIdFIlE1wpATptJ5rUFZeR2jpH7Ugea7l6F6abMYvkBkFxVo8URHqBf
 1Lgh2SQyQ46TDE5mWe2ECjVNTFrbQWvNdzlg+7ActuCu5hnSKNE3Ak+UEiuRVACsZEuK
 eEaoocEYB4bVpLgN+GGd/xFtcVNm16stuIAkZTUeBjTEz0Z01LO8RgUh1T/cR3cmIumQ
 09ywGpQB9i5tQAMlgj/0cDRs0OFWJXp2hm92spGdzwJBJ06UuPe7I7iyHuxk+8SmjVbb
 onfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gIEnLpBMMVRyDO5mv5koU9MuFZKWGefAWsKxEU9XMzc=;
 fh=4NKQzDpksfHY6WJy7V3nk40+yqgJaRP/0yAq75KogA4=;
 b=UqOJ+PTiZcMZDAliFL+PMUztFaNJEPDvviuFcYAeQcU6R9/Sm5mNZhmeaKHo5Defja
 COdOkWZoNFuD6p/ZNOixjfK+k5qM+l36GKoQqtuEE3wj10I+BU6XMYeY52aA3NDGWKWX
 NGDxcroJxmsigmF0hzhEqaRjbr0JTP3rsRqlks8UilJwqtFtf4rhX3k2R2L2ef8kDcRG
 EOmX80uZMEMS33EFOwm+EElxGjeuLcrSXsY9zvVCGKE9+GDUCvwaHEmrj6HUQN9Sz4+4
 hnvqPFQuQ6LfsU+xQgej4KPYvoaCE8vbY05NgfJBuh14vuVS2KouBdeCdCWxGbLoeJDf
 ZI6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784536318; x=1785141118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gIEnLpBMMVRyDO5mv5koU9MuFZKWGefAWsKxEU9XMzc=;
 b=uJjy6vkdUVRLQdLJDJKH/Qdv1yLqceMTWoIpVc135lIAxh6rlAOi98pyscqWJpyUGC
 ptWhYmVBwiYTHbCBEihK3mT0aWntzAs++dmDs58rplclW1vTdeS7SdVpJUvhtrAHa5T4
 7xg5uwdP9ECp5MabGW1k5fQf8wyXogAwSeWIhlljLUzZZ6tXpwrZRNKo49dG0MLWOCJe
 zTgI2OijDfK9qBGCjmSJqDdhnRIyFMjal+ASgRKsFegLSJbQpaKwcTZoAImjH/DZK4ss
 o6ryIdf40cRjEuJ+a3MwhwegJobi+ZA2D6EB8dgsMDuHpQGYR97TbG6xZHybgnO85y08
 Xvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536318; x=1785141118;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gIEnLpBMMVRyDO5mv5koU9MuFZKWGefAWsKxEU9XMzc=;
 b=iewlaeIBYilel0q9IHZFPEgWdN5ANeNSEz+munTjHahuGVOFohT2iLrGXz1Z/SWguT
 CZbqnyIh7p55YIgPoAOWZcwsVOHVCGNqsZnRk8o8mDGXMAXvVcpHKHsA6iXHOiVjhfFU
 lC3humyjr0CQRvJnSUq7BTGiWdb0m/xWnRYPAYozrO9tzRS9C1g7iDkS2bKxcjxm6YDE
 8vi8mXXIIe3UeupPCHolROeD3Pwh3pT49wPTXVOVsF1qfTKULb2GCv+ePFTh7mle3xQl
 TxbjogJJ5go23Ld1BglpGSJvOZlePlPGqV96Q9lnjEmR7VnimrgB1fx2cgll8bpeAP+8
 ++6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4m1pdGwN9spIm/PNZ8577evvotA1MJPjABxki+uJofgpsgAkPiAQBG9vJVYYxWs9POOHIHXk+eiQ9@nongnu.org
X-Gm-Message-State: AOJu0Yz/6ckFay+zSwLWEgV0BPMRV5N9ZZegTj8eYtWAGhOOYpBrduqJ
 ea4NfnDpAsfHQZg3wE1oqEfDPxlHo6sqWWkPtE8rcykHYyTB8YvlqMrYTTEib4AL928rh2nEKfu
 B3j71mO71fQCjHWdGSw1C8LQ+PXomo85Kgs8wM2T04w==
X-Gm-Gg: AR+sD13uT+/ajvQ1fRXgZB2hDEN8bezJs82h3SK46Fg8L16kNEDzFXYIi/CUmRAvNTJ
 8WtaDmnK7tIUyVUrkVjO8akaZ4/R1dc2WeXlrlqUdvSuAofzfqRVWifgSBxCtcCV0PgzjU8KK90
 97x6AYjpYj9zOvBDxIdu/jwA8gUPFgK3cW62huEMPrzTd5rza8cVQqbMTPlMo2Qbto/ayztcEqn
 Oj+KbnHPd0zVpNw6m/OVTTcpWE1hUoGx3hcZxoXqDREORiegSS6b9nFtDy89ieCBhCfKF+yC74A
 QIqG6i42TOK328BKHJbpSIA0Ax64nVDnpho+srww4unFppXgn7wmnq4Y
X-Received: by 2002:a05:690c:67c4:b0:81c:e8ab:c4ed with SMTP id
 00721157ae682-81ef2602339mr31935267b3.51.1784536318550; Mon, 20 Jul 2026
 01:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
 <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
In-Reply-To: <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:31:46 +0100
X-Gm-Features: AUfX_mwK-B9ogPnyB6gisT2YbpG7xUmZp_KIhsZYEHwGHulq1Z2xjI5XA0QXmbE
Message-ID: <CAFEAcA9iSgrua_ekOQ=EaXp=Mcxwk52qK6AkRXCrH1KcRm_vTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 Jul 2026 at 08:49, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Brian,
>
> some random thoughts...
>
> On 15/7/26 20:56, Brian Cain wrote:
> > set_bit32()/test_bit32()/etc already let devices operate on
> > guest-visible uint32_t register arrays without depending on the
> > host's 'unsigned long' size. find_first_bit() has no such
> > equivalent, which pushes callers towards casting a uint32_t array
> > to 'unsigned long *'.
> >
> > Add find_first_bit32(), implemented the same way as find_first_bit().
> >
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
> >   1 file changed, 26 insertions(+), 4 deletions(-)
>
>
> > +/**
> > + * find_first_bit32 - find the first set bit in a memory region
> > + * @addr: The address to start the search at
>
> s/addr/ptr/?
>
> > + * @size: The maximum size to search
>
> Pre-existing, it is not clear this is expressed in bits. Neither if
> we expect it to be a multiple of 32, or @addr to be 32-bit aligbed.
>
> Maybe rename as @last_searched_bit?

Could we please stop bikeshedding this function? It's
a simple copy of the existing find_first_bit() but
with the type changed from 'unsigned long' to 'uint32_t'.
The comments and parameter names on that existing function
have been fine for years, and having the new function
pick different names and comment phrasing seems unnecessary
and obscures the parallels between the two functions.

thanks
-- PMM

