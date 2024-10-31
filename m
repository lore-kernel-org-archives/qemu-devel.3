Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AE7D5CCAC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 12:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6U34-0003Zc-LV; Thu, 31 Oct 2024 08:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t6U33-0003YP-Nn
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:13:09 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t6U2y-000510-MU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:13:06 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so905252e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730376781; x=1730981581; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eMWNaXkjORX+GkvdRZhTuaMZ7RsIVw64uLi9HVA9lU=;
 b=FHpprGQo36ElrIDDKCHV4o0Ds/7F4HV008RN/9OTTLpfc85EOYYEMeUjcHDg6Y8v98
 UHKDZ3GAI6Bq+O4g1G6K6KufdTfALuBiC6hn0MIVRQQCKNsFcHNgayPeGFXG20UcZ23W
 RcC7T0lCzRKJGug3v8gpZeseDbCneB8XOXBbjV+Vk/kxlJ/Fwfym+52CW5Gn1+5/kT7V
 llNqhycHggXXrSqOqxQtAIc7Ma5RL1d8g7Lt5sVzZTJy3cGZ2KGRDGYEY4YOZpP7rUPT
 ULS+ZysX6tElkG0MfyC5XRsdbOVtzBffie4+ph/wSL/hUfSfND23PqEaclfvpVW2L3CS
 p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730376781; x=1730981581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2eMWNaXkjORX+GkvdRZhTuaMZ7RsIVw64uLi9HVA9lU=;
 b=uXc9gA87OXsiqwLBYKbEJDNeA8BzzoOFh+E4NLsR46xan8Dw0m+sqxlrkwFZ5tvTSx
 hWNzLkn+zu2A0I8fVJYfudXyIl0c+5l43KiEpOFWPJpvR1QzamEblZqKRhOImxb5cYVW
 OQS6tn8mZpefWijTlsnEebZH3GWgurjoHJLjfVJCgZXS6d5p3J8nvjhxCllaGStM2veW
 dMF5ND4A4hlmNolg7eZH6ZLPhDgZvUGYHTfc1J9hGtj69mS02ELDx1NnFlBCXNgvb1br
 kf8WsbJwsD9gDevx0jybEvB78Glkq/pIi6VMsKqFTpw8XOPuZ4VNwlwf1Eoa66/72F1e
 GMGA==
X-Gm-Message-State: AOJu0Yw1HRDROJfhIuT2Ycm36G4uFD1CMfFmFpPGBrt8NaQOBW2td528
 fSwjNTds9Jt+DwUCpjfKzpZ2hD8vAzlX8wT2nS8HGMcQMHfluL9M3sJzOWQeQ2L1Ta5N86RRZL1
 LVZ6xa7vXG3ZR3ipLNe98ZowarO0=
X-Google-Smtp-Source: AGHT+IFiecuTcolYLuTc2NjJwKKyfwxmP0hetafQfoT900SxfIEOiOx4jABsVtoRM3alJm8c8PbBE7qwFoJt0nPKh/c=
X-Received: by 2002:a05:6512:ad6:b0:539:fb6f:cb8d with SMTP id
 2adb3069b0e04-53b348e1452mr9799747e87.27.1730376780876; Thu, 31 Oct 2024
 05:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241017144316.517709-1-r.peniaev@gmail.com>
 <CACZ9PQXT9xxuX40u_4J22d66hP73x4r8gUunPsMzhMS=MMTn9Q@mail.gmail.com>
 <CAJ+F1CKtXFiYyoT3QkubESiTUo4VxYt2Ed0g_QjgU8YasAeZjw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKtXFiYyoT3QkubESiTUo4VxYt2Ed0g_QjgU8YasAeZjw@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 31 Oct 2024 13:10:39 +0100
Message-ID: <CACZ9PQV5ZkKsCJRd5U8aj1B0txmPyha3CQDHeM3j75Kj4hJWfg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12f.google.com
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

On Thu, Oct 31, 2024 at 12:34=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Roman
>
> On Thu, Oct 31, 2024 at 3:12=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> Hi Marc-Andr=C3=A9,
>>
>> In this 5th version of the mux-be series it seems I addressed all the
>> comments and concerns. Could you please take a look once again?
>>
>
> I am not sure adding a "mux-be-id" option to all chardevs is the way to g=
o. To me it feels like working around the issue that arrays are not support=
ed on the CLI.

With CLI it seems not a problem: you can always use the ',,' sequence, or w=
e
can introduce another separator, for example ':'. With JSON I could not fin=
d
a working array example, but probably the same trick with any separator in =
a
string can work as well. What do you think?

> I would like others to comment..

Probably makes sense to ping them once again.

--
Roman

