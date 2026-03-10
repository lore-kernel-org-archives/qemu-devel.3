Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D7FD2D74
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwf0-000467-EO; Tue, 10 Mar 2026 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzweu-00045f-Qh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:58:00 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzwes-0004q5-KN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:58:00 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ad8435f46so12710642d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 05:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147477; cv=none;
 d=google.com; s=arc-20240605;
 b=h6Pav72Pfz5aH6oPRhXXN//kcChbZ6mqItbOX9WeqoGb6aQaGq/lEc23d71ghxqNF/
 Ba4ys42jv43iR8eWx0X4oB0Be6TxvbQjOvto27ijpElS8p0aEGjA/tKg4/8Qm05eyp4p
 Fztz7cc48p9f0qhQRjTYfAMQQTTj1C8VQmiLOnkfqT0e6XvwwyHMM2cgyoKwMmv/qQs0
 c/uXi64Fyaz1odtppwvdQI+h65BhEtBrnou0ZGNDsLLdbyqZLYpEHY6CHYpxXHr1gkBc
 QdBNOy+BIfx5U6wbEOs3jmSlxJMfsahjoglkSiRneUGaPampr8lWMkMnOnfPxZRqmARD
 XcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uBwm0V3ExdSCtql/BDzXvgymk+csBNLQ0gUpHiPukxw=;
 fh=lDoAQeNI5c03e6qw2yeL0v97twxnVLoLIV5r8AeGPcE=;
 b=jXwn0klO7JE/0mSMBfImGDINUA0S7FyvwwB/20S86A6Rju4j4qEtciBRcvIT7U1+bf
 k1DY6Cu24o4mhdsDiLGdQdIxIb0RCBHoUwsF9sQj7B7DuqXwlpHz/p3fuFUAcgLYl0oh
 2i/I+qmRHupSHEOVgOj2sSU6YfoYaTPQ5LcPa8D4toaMHm+hkmspDEjJ+FyxuX9hZsjm
 1UOTIjHtERGpvTsNi/NHImY0tRGYVio55NgAiyeScK0etKtOpdGrDJEqtfRx1cvEiaVj
 6Cgss4q5oGf0XRNUascefmxTuHBRbxNXz9zA6mrJJt3R6nwT5Lb5sk86zpvgZ8+tqbqv
 NIEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773147477; x=1773752277; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uBwm0V3ExdSCtql/BDzXvgymk+csBNLQ0gUpHiPukxw=;
 b=Ph9Ui6Hlk5x7Ldi7QPXkqGyh2oq6sxDkuE657xeR83XIA4+MzWxHkjeNkz1oVuCh1D
 sHGwfy++pg0wKOKF1Fhn2YSBJxU1H2Q3vkSFwCJ0PmSlUWJ44gquPCy/Mz+jdcYEeuB1
 at52xG9oIZyFxnpXpbWNGDeYBZHs6xwDeLl2J6Cg0HPLcmC3asdKbF6eij2nPhhIGxf9
 ieCsz4n/qGKkoA9QCzIqSewmOoST7lATbxzLeBXZBpmhQuGDz+yZVhChsXQmYvdnsuAV
 wtugU9yKjRC8a83TknpXOWZR36JdLQ6V9hThhEaNEnnglrpuNaWlhaLg3f4e3pCax9zO
 GT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147477; x=1773752277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBwm0V3ExdSCtql/BDzXvgymk+csBNLQ0gUpHiPukxw=;
 b=SlwMrMkRvMTuF7058zRolebGe8HefaEiWUGs50ZPi1lWR0HQJ1T+vPziHRhKE5X/ae
 xiklknuouh8xgAYVfJa69wSpiGd6HLSPTgmeItmeK8WtuSeeMlU5HS1ek6yS0bdv75ZY
 WYkMCTYNYvqWAaO6Us1hXpRAlcpw4fRD6UWKZnXyzZAzrjqimhTRQymCPetcQ1IN7IpC
 EcPWcICSh+fi1g/dOYAjMOJL5CyIeUQE/QY5EWIAtSuMsQ7YPz1EvkRVQ5yh2nUHI1B7
 qR3kZBXbV8ebY5EhrNS8HEv75d20uPQqN1VMCjd2sYE+W4uBWoqs5XAU9ZVS1MSrC+kA
 0liA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLxTDc6Rw872rurrxRmB0dGa3seRvjXnI3Lvx1sSC6LIg67X9PJ0aUkfqDu1sqf4UFLM65yId3C9mP@nongnu.org
X-Gm-Message-State: AOJu0YwLjJd+5YE8Qfu4jiZ1UJ3IISiG50B2LQzijQqgb2Oex+oBlStT
 0CGSXHhaawoe5SzHSM6wqS43R0qClNDXNr0Ay/PfrH/33Q6rfexHKXLmg8hVH9l4z5YOIhpCv5I
 BZdzYHnsR/kQdXCK0A6UjPtWXlXCyk0hdd9BiXuasQA==
X-Gm-Gg: ATEYQzxvvzOQgZ7qkgVAwgOEL1ogPibGNaCsCJn7qOXvX6hmEU/X5yYWRwQBALAVJuO
 ziXfLHbXPMRDffStTm4DEF5UzlIAMxM64y83UvH0IrCYkk2o0UAZuMmlQfJZjPf2blhy9/0V3GF
 IfbGIGJBWgfM9KXZk+sIafnp0vScRIvNkCy7vs43CX/+Nl774+BRlcnMcvbdJn0yh5g4RqJ7q/M
 KfDj7g4cHgseeW0rc5UF+pYWvma5SPrsTPhYT6IA30Ufk34ccMiXGWA+NyytdZycBWPKdMFdqx/
 6axAIYQHlMM79E5JvJkc4ekPSVb7Bj1YrGHvmDjG9qoIZmd2nOOpVUrDcXjCiHqFafk=
X-Received: by 2002:a53:b5cd:0:b0:64c:f0d9:5907 with SMTP id
 956f58d0204a3-64d142a09b2mr11198374d50.52.1773147476891; Tue, 10 Mar 2026
 05:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260308160040.354186-2-alessandro@0x65c.net>
 <87jyvjamzb.fsf@pond.sub.org>
In-Reply-To: <87jyvjamzb.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 12:57:44 +0000
X-Gm-Features: AaiRm50RaglUmVTnC8YiXyTbQxoUvJennTID9Qq5FHKyAB8zwQ8GYZv9JSlCXgU
Message-ID: <CAFEAcA-3PNv+g-fW0Xi5YfyGJJ3pNnmYvjU7yW+rgpkdsANDcg@mail.gmail.com>
Subject: Re: [PATCH] qdev: Consolidate qdev_get_human_name() into
 qdev_get_printable_name()
To: Markus Armbruster <armbru@redhat.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, qemu-devel@nongnu.org,
 berrange@redhat.com, mst@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 10 Mar 2026 at 12:27, Markus Armbruster <armbru@redhat.com> wrote:
> Or simply use a cover letter.

Patchew doesn't correctly handle cover-letter + single patch,
so my recommendation is "cover letter if and only if there
is more than one patch".

> >  hw/block/block.c       |  5 ++---
> >  hw/core/qdev.c         | 19 ++++++++-----------
> >  include/hw/core/qdev.h | 13 -------------
> >  3 files changed, 10 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index f187fa025d..84e5298e2f 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -65,7 +65,6 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
> >  {
> >      int64_t blk_len;
> >      int ret;
> > -    g_autofree char *dev_id = NULL;
> >
> >      if (cpr_is_incoming()) {
> >          return true;
> > @@ -78,7 +77,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
> >          return false;
> >      }
> >      if (blk_len != size) {
> > -        dev_id = qdev_get_human_name(dev);
> > +        g_autofree const char *dev_id = qdev_get_printable_name(dev);
> >          error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
> >                     " bytes, %s block backend provides %" PRIu64 " bytes",
> >                     object_get_typename(OBJECT(dev)), dev_id, size,
>
> I believe this plugs a memory leak.

It doesn't -- the previous declaration of dev_id above also
is marked g_autofree. This patch is just moving the declarations
into a narrower scope.

> > -/**
> > - * qdev_get_human_name() - Return a human-readable name for a device
> > - * @dev: The device. Must be a valid and non-NULL pointer.
> > - *
> > - * .. note::
> > - *    This function is intended for user friendly error messages.
> > - *
> > - * Returns: A newly allocated string containing the device id if not null,
> > - * else the object canonical path.
> > - *
> > - * Use g_free() to free it.
> > - */
> > -char *qdev_get_human_name(DeviceState *dev);
>
> Please add a similarly nice contract to qdev_get_printable_name().

Mostly that is in
https://patchew.org/QEMU/20260307155046.3940197-1-peter.maydell@linaro.org/20260307155046.3940197-3-peter.maydell@linaro.org/

thanks
-- PMM

