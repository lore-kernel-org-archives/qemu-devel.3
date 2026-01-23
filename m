Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C6BD7789C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 18:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjLka-0002J6-N1; Fri, 23 Jan 2026 13:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vjLkY-0002Hd-Gb
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:19:14 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vjLkW-0008Ul-Jc
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:19:14 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-658381b28e8so3275154a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 10:19:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192351; cv=none;
 d=google.com; s=arc-20240605;
 b=V3X5wmIrzOHEvhe92TY6esjIWWBmQcobF5l906JORauRdLG4nUCd+eXemdbBewEJMV
 tGZNnxC5vR0RBWXuNlnh3QTb9Y6CL9TbkQG8EY3+oWRqbWOHK/M4fVmA8ZoH4h02cLXJ
 wLj6qgT81K7/lXMwURCARVpQSjv6oI2K9/1JxvUGUgj547BYBABNk4kMpQrCObEERUfX
 Ln2DOaH7HckZpWODeI1sc3JJ5To8BYNQUyQtPlThcSRysCwf00cYAf2OkCxVHuHhxSqW
 /EksPw2puaO7Rw3b7hnznWKSWSZHVNVKz9pqwH3qK2nbnbPhhc8H6wzo/mPlHATlZkMx
 sOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EQdSi/Y2y4HKkqkF1j1QgtbiMIeWWElV/1cFJyacCZs=;
 fh=n99HhvwyUbp6dHv2meVbJdm15UZZ5NHnFjHS0TJy8E8=;
 b=HIuhLPoljwUU6wCD4FIjyZFGnfl1INeKCo5j3I1t/XHIHzRcJItxRHt0I3nmZHeCt4
 8YyiUdXqE8daOZFExmDAk3H1ItOkPkAzqyvjBtCjYN2yFE54jqGQ01GN7ZPdrbhEFxwi
 i8M4W51QrM91v4pwq9+TIFikmXsnhJD9x8Sw0fwnacXCqtmGcEn56Vu/gggaUG697yRe
 2LQjYLDwiGGbiRi6p//FcTJTPTwi4/UB+9ujYkIkjODyIyEPVBp8TCXVPvAHcIsLBuB3
 TKUchwzwao5uwN96R59JDHKspTGkvBgBknZS5/uRYqmmKTBHaLoszw9ozVl6AeTksfJV
 uZMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769192351; x=1769797151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQdSi/Y2y4HKkqkF1j1QgtbiMIeWWElV/1cFJyacCZs=;
 b=cmNKDgzq0BcWH+qUdagxRMI58D1cUqPRPyxgbLtyvTJWOPtbkKHCdNhi6pBY4pRZaz
 P0zOClDOPPe6pVQNrjhDQc2nLe5A9A0H7G08mxpbTqGvyQy2wfkvG4thkXgguCCLBAfM
 tDYUweP2w+DpX8I8RxckJBgL9tftWlHZeBVrih8Bj0hpAHIOaBkg+jbNrZHKaiCGl0Ts
 rP2TAKMVIumzzmMIxdDogT9n4R4AGs58pfp9J+YKwGPMMyPX/Ev0pxfQII6xWYCnYq0A
 49pFBpRRRZmblgASODB9WnOpMfppTwP1Qc9sFLVzJgzjtuZsT2Fi9ZTQOZ6hDw7VAR87
 TIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769192351; x=1769797151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EQdSi/Y2y4HKkqkF1j1QgtbiMIeWWElV/1cFJyacCZs=;
 b=OmGxqFz3hO3heZl899BSCUFjiqmhrfk/nyNq1DZFyp+/g+89j+K3BtlTDQ1zfehqiE
 2PnxgG0c0xAl24N5rht8Ui8CKcvads72wkDyhK5qTOvR0G7mFreINLLZbn+61gduuqhK
 ItF+09yRoM5VgY7TdTVUPwD3zDwkxpr9H0VPH/tfD6LQyvDMq9gDvXAJZbsm57vU2BAV
 UMrdQGv2osSCSh6eAglSkYwuTvwt3FDllpRLli6Z1LXPR2j2MN3BRqkg1KelqPJlkcfM
 eJSP7kN4Koxbriphz2qew82oRBoE+BCExPrvCo1VhnuN/Mn/ZbI57qfMOfpswQkAlAvm
 hU2A==
X-Gm-Message-State: AOJu0Ywwn1PZFHv7WVBWPf9R7B7WRsW4GFFJ/pC9AX+KXGU5ck6ZTuND
 HKQhQoptZ8GaE1IlSU4gX6v0PFouVdmfY9Mbs9DX0cOM3JWmg6NuhGPbpDZAjanDOZKRIwUyBvy
 nNqcBfY4Idkl/eVB3O3mmNFb3PpjZO/c=
X-Gm-Gg: AZuq6aIkdCSC6+cjmDjB2CcPe5n6PzfDH4Ya9mtKZsojNzFBn4RWmFU/eUgU0Wgsv+3
 RWPIykp2qRvoZSWkl/Zy1RCxkSu/hC3vCFlouEWDs78/B7Lm2dvl/79l/bPIiaVwYjyEAWlVsix
 IxjSsFmJEn19PQWP2/dc9CVo+YDGlCAM8XIeEeN/UISqBVlaczU1SKmAEaactcyb0EfPT833keF
 YrdR5MiMjx2P+M891fxA0jY0Gg7aGqshgILJ3Yoe3tWh5KgiFavjH8QwZ1kObgfHmKq5w==
X-Received: by 2002:a05:6402:21c4:b0:658:39b5:7177 with SMTP id
 4fb4d7f45d1cf-658487a3efdmr2809992a12.20.1769192350514; Fri, 23 Jan 2026
 10:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20260123085924.1392134-1-armbru@redhat.com>
In-Reply-To: <20260123085924.1392134-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 23 Jan 2026 13:18:57 -0500
X-Gm-Features: AZwV_QgU9ql3PURvdQRhpsQZkZM0WPduB5pbYn-Gm6vAeZ-RL52q_IfmfTT3x_Y
Message-ID: <CAJSP0QU-NBUGX+V0YNBUetoAtzdxoL5W6=xJEdGeiraOYRb_QQ@mail.gmail.com>
Subject: Re: [PATCH] qdev-monitor: Fix qdev ID validation regression
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Fri, Jan 23, 2026 at 4:00=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> User-created qdevs with ID show up at /machine/peripheral/ID.
>
> When we restricted QemOpts IDs to letters, digits, '-', '.', '_',
> starting with a letter in commit b560a9ab9be: (qemu-option: Reject
> anti-social IDs) a long time ago, this also covered qdev IDs.  Looks
> like this:
>
>     (qemu) device_add usb-mouse,id=3D/
>     qemu-system-x86_64: Parameter 'id' expects an identifier
>     Identifiers consist of letters, digits, '-', '.', '_', starting with =
a letter.
>     Try "help device_add" for more information
>
> QMP, however:
>
>     {"execute": "device_add", "arguments": {"driver": "usb-mouse", "id": =
"/"}}
>     {"return": {}}
>
> This creates a device with canonical path "/machine/peripheral//".
> That way is madness.
>
> We accidentally bypassed qdev ID validation for QMP when we cut the
> detour through QemuOpts in commit b30d8054642.
>
> Fix by validating IDs one layer down, in qdev_set_id().
>
> Arguably, QOM should protect itself from QOM path components
> containing '/', but let's just fix the regression for now.
>
> Fixes: be93fd53723c (qdev-monitor: avoid QemuOpts in QMP device_add)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  system/qdev-monitor.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

