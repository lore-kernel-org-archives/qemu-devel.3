Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856A7D3517D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vSd-0002PR-HY; Wed, 01 Apr 2026 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vSS-0002Kg-DT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:18:08 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vSQ-0004WN-M9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:18:08 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59de8155501so7203603e87.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049483; cv=none;
 d=google.com; s=arc-20240605;
 b=NHIfWDwA9ZolyXlEez8m07V8jKi7U3RlIBGgE6dh/zDSwXRlZ1Zzyv2sgyRDuf3sYj
 KHuh27RtaFtEquI+a1PZJoKH42zwziOBn/7ilye4NWmH9pIb1hveLRm5YArmHzhKUh54
 Wc+LN9MUZ5bajbd0/24+gsV8GOUG0tS9dUoLtLYwtrjG5UwtFFFXMK6SR9e3erAlx7UF
 pQLX4kbOMn0c9YmT8VbUM+rhHQ5Cq7Mz8O53yTux6etVEF6HI+LFB+klsUYv1PFPv5aO
 LZkKfQECCAlYJLHBG20L7crca5igQjBeR3QPvKpvuESTZZXmLbzI3e0D1mwF/ZXaJUE1
 0chA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z2yLwqmcsbihhj0bVk6yxoD0p2no7pvDOY5On0dRTmY=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=Aq0/cgQvvuByBEgr5rLePgbLuWH44wR97TenUvwaUzwK/iR8pVLpKAv9XJ/ACaxl8K
 +N3wxj8PlmxXVmg/F/sq//1JO+p612X6YXe4zwzqWbEwb0RxklpxVlYn6T8jkHYUz9ee
 YAVPk3hjIhbK06JD2Olh8QD8fIo7daDz2TkjD7I3PfM+PVaY7xDuYO9n+3z86s6PDPyV
 fTRuOL2spErKqyCRZLJWPL1xYBkDjVKQj7qfbs40SprnqCWD0vC4elbswcpQ979KLG07
 dlqNmfJxY26C5n/UcIxiiCcDDeVKIs7UVKUnYFf3gL/XW0Msp+DVrZMyxJKSl9QXy/3n
 8R/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775049483; x=1775654283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2yLwqmcsbihhj0bVk6yxoD0p2no7pvDOY5On0dRTmY=;
 b=iGcsnmqBXwOCbWV/ZSargaNBfKBBq2JiyBZ53//e8LL+HkyajpezG2AVMri9Z5pQeW
 zKi6QlgC6JoKOht61yzvid/dlB1+yHQx6WGyXOSnpoiecOk+9oxqv7/kkTuNWlfYc9zx
 kIILDxPGiHJdYS0+ibbRPA11yA5vDxiOPIhis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775049483; x=1775654283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2yLwqmcsbihhj0bVk6yxoD0p2no7pvDOY5On0dRTmY=;
 b=DP1Z9NDgJOI0+JmM5Op/zFeir7tQlegV175sFjpHqJqe7o7XKiaseG4Myd2eSjRFOy
 8PmR/+7L7O2GeK6vAwwxIXWEa16x89UgKRGXXY0V7RTqnCk+RR1wsSkPt+GmsoNDpkk0
 pZQjgyuxZwpoeF0ej1yX9nRxUGgFh9pI6Hpk+2flzO6XI5vWJ4YltX9qb53ni6ODM/Aw
 NsVh3gdQesB9p/HAH/CFjxz5tzokfO2Nai0MQ2DOw6+sx0G6hbh9r2EbFRlwPOKRDO9I
 vDuTsgSWIPQR+pfHAFUKsqnJHGyU6Q5zLQpD5oLAHzNTO9pJ5x300HSyp9T75yuUlN22
 8Syw==
X-Gm-Message-State: AOJu0Yx0zn1r/+EY7nGfcrpSDsp4WdEMdhhO1DEk+3LhBlfQvxMYvJzS
 LH8Oz/8LApbzVp9BR7lYYrsKBer8O7PiqgUFoHZwTE5FTWipcR4005Qz3NyuVx4e3ftxR/4M2Gu
 iZFYoTa7YWR3Qj5hkNWey1mrU/OaZLMeays95wDfa4A==
X-Gm-Gg: ATEYQzyGONSJUw3Zfor2vbUY0+0Q4zybuVsnqG6Md9TeGlSB8vt3M4bU7mQco1/CDN5
 qrL98HdSsDwdnvY/+TeN02uJ5iSEIZ6EcNivbvbGe+UvC7ON37+N3gpvwH4br9hQ0ed1tFHeViL
 D7ItY7wLpUUaltbJ5im3XL+BAnRNrbyCdVnWtweQRB5isMJNIQFS82DHAVdk8hbB+OdwQbQzMJV
 +055qp9e2Rze0nXuc/JKk/1gmDgop+uHI4hcOnuU4m4SwqDsWWtGnGRFSgtbRfM062PJuy+ALo+
 G7cAxujkq+LRb6dyV2kE0NcjtcqPjsa5W90wDw==
X-Received: by 2002:a05:6512:2209:b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a2c1f215ebmr1231983e87.20.1775049482409; Wed, 01 Apr 2026
 06:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-5-peterx@redhat.com>
In-Reply-To: <20260326210532.379027-5-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 1 Apr 2026 15:17:50 +0200
X-Gm-Features: AQROBzAdTTiPESqiZiaBtDc5hDGyP1qXQYhkaYmo2U7RNnOyCQG2D_s6ApK3Lmc
Message-ID: <CAJqdLroWFeb93MDj7T9YuYSidsJrjSp8YCNeJEs1J=Ox_SW42A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/11] vmstate: Update max_elems early and check
 field compressable once
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12b.google.com
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

Am Do., 26. M=C3=A4rz 2026 um 22:05 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> QEMU has a trick in vmstate_save_vmsd_v(), where it will try to compress
> multiple JSON entries into one with a count to avoid duplicated entries.
>
> That only applies to the cases where vmsd_can_compress() should return
> true.  For example, vmsd_desc_field_start() later (who will take the
> updated max_elems as the last parameter) will ignore the value passed in
> when vmsd_can_compress() returns false.
>
> Do that check once at the start of loop, and use it to update max_elems, =
so
> that max_elems keeps 1 for uncompressable VMSD fields, which is more
> straightforward.
>
> This also paves way to make this counter work for ptr marker VMSD fields
> too.
>
> No functional change intended in this patch alone.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index e29a8c3f49..05badef42f 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -556,7 +556,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                  void *curr_elem =3D first_elem + size * i;
>                  const VMStateField *inner_field;
>                  bool is_null;
> -                int max_elems =3D n_elems - i;
> +                /* maximum number of elements to compress in the JSON bl=
ob */
> +                int max_elems =3D vmsd_can_compress(field) ? (n_elems - =
i) : 1;
>
>                  old_offset =3D qemu_file_transferred(f);
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> @@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                   * vs. nullptr). Search ahead for the next null/non-null=
 element
>                   * and start a new compressed array if found.
>                   */
> -                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
> +                if (vmdesc && max_elems > 1 &&
> +                    (field->flags & VMS_ARRAY_OF_POINTER) &&
>                      is_null !=3D is_prev_null) {
>
>                      is_prev_null =3D is_null;
> @@ -626,7 +628,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                  }
>
>                  /* Compressed arrays only care about the first element *=
/
> -                if (vmdesc_loop && vmsd_can_compress(field)) {
> +                if (vmdesc_loop && max_elems > 1) {
>                      vmdesc_loop =3D NULL;
>                  }
>              }
> --
> 2.50.1
>

