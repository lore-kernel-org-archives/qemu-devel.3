Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B2CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnEI-0000Cl-2S; Tue, 25 Nov 2025 02:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNnEF-0000AD-4c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:12:47 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNnED-0002F7-O0
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:12:46 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4ee05b2b1beso46029841cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764054765; x=1764659565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2h1lr6sIJOCsV1PGp+AAj6lj6eaGpUODZ9vUmZYJqSw=;
 b=eSVLomlirESNEhl6qilsp/RWD4I3iBRtOsSv0zVaj27tTxb2fH3BdcJ+fhfHwRnUxE
 OFTCZB5g5gPxcgcAH4zIvN9AYXmay+aOOLTNFQdTyBFKdM1wOAh3/GPSKj8V/1P19m58
 6mlZN5g+mPlxusfNcICXxrmDHopZUk6sraBdefD+caxJFWzB9e0NR2YGhvrzY3h4oYK8
 iEGVoC/j05P/IawnfCNKxxk9FYLIxjnzyv1oEExODqF4wOp03J8ppws35IFOC8PEJ6t2
 2Vyn8O6vyRNR0BucM7bKeH9CuWDaUoIUlYUJrfsgUQLdtiLcThXFcCvvfyCHZrzL4yqs
 9D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764054765; x=1764659565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2h1lr6sIJOCsV1PGp+AAj6lj6eaGpUODZ9vUmZYJqSw=;
 b=JbBcTCW2T+ndNS/PbGQAmega75ctwL/QB5vkp3zT3B41bYlMQ3W8sL2c2kwievkn9p
 3h/OjHcvKXaQWd+DVQjdz2XQamdDHsoy7shWF8SSjKz5pd0jzqGoE4HpNU5GCjAJ977L
 Hwhjx26EBsPEh/KcJTWy2kSalD9jT7Doe/yhc3S5dbMP4kECdmrMD3XHfwi6lbzhUBwk
 Mj5HV42ujlEobUTr7vvP+uVRy0D56xbc9Igoh9+MIiA3l9l2FxJZhZrbT/Cin8MM8Q3q
 7qjV1JfxhIYQCnogT/N5TcIje+jeZkSxI91l8Fgytt2pmDjucZ9iqKEGDVLeS0+Kyk0d
 Nivw==
X-Gm-Message-State: AOJu0YxVKd1tqTSOJ7LWIaTd/bhHHyix3ny5qkdYEBbGB6/V8ptWC5CY
 Cv0t1hLHUCyY/uAD0w3v2xMCslFV/4FAoNIBmQoe+q/aUjrln7cn5D7za7Ev5JydahhAY4LNwBp
 /+00ecK+UjUX17qNu+47wnTFkRZkXdlYu7btZ1rS0PQ==
X-Gm-Gg: ASbGnctsNaf0CVEV3zUjG6DrvligrLkbydlPNcWIbkZJQlKBBOhwuCFSl7FNMSCdUtf
 C02HU9bnv5uUEMN6/WkCjLbZe2Eww2EpHqcQaqU4wrY7XZPUWlpHnG+sSY/ND7WQMOc1ex1ENh2
 BE4YX60KvJKUtjI38cf4ZtAEoI46xxgBcuE8TfCNtktfPL2TcFva/zIH8Q8FBs3xyDQlyCP+Vsq
 YWbeYWbeI0dHMTnQtbuAgM0pH8ZrVwabX6avySzMgxhe7QbX/lF01FJwzdTnotGrwgI4VKvGOEP
 LHpn+4mbkcFr
X-Google-Smtp-Source: AGHT+IGJDNN1bvXZSqSEcVIDtzObaZDEVrWIXHd6wuA7ZaKU8p4gFaCfHNUeDMwsQYo6TQlyURePxUcecay5niGE61w=
X-Received: by 2002:a05:622a:18a8:b0:4ee:2459:3d6c with SMTP id
 d75a77b69052e-4ee5891752fmr175747061cf.58.1764054764478; Mon, 24 Nov 2025
 23:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20251125070554.2256181-1-armbru@redhat.com>
In-Reply-To: <20251125070554.2256181-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Nov 2025 11:12:33 +0400
X-Gm-Features: AWmQ_bl6d95R6sPqyFm1zNIvRPJb3gxGo2es-M-8BMXXmi-Om9PfoncWUXykX0o
Message-ID: <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix double-free on error path
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Tue, Nov 25, 2025 at 11:06=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
> Resolves: Coverity CID 1643463
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 6210454838..3203dc98e1 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
>   */
>  static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
>  {
> -    g_autoptr(Error) local_err =3D NULL;
> +    Error *local_err =3D NULL;
>
>      if (!migration_has_failed(migrate_get_current()) &&
>          object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
> --
> 2.49.0
>

Maybe warn_reportf_err() should take a Error **err instead, and clear
it (and accept NULL values)


--=20
Marc-Andr=C3=A9 Lureau

