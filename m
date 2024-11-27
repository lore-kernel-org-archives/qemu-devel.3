Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C33D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGH3w-0002Mt-3P; Wed, 27 Nov 2024 07:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGH3t-0002Mb-Ie
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGH3r-0002xI-Lu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732710146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4O6nW471G/UGmDhGC9d7nOGe3smH47tI63C5ANkA20=;
 b=dPLYGtd6/xZdSk7V1+B+TPOvdLDoW3Sp6KmrOqqhUT6wL17xlLKrJbnBhsh92i2TMC+PjQ
 gOoLeXtz+c5+HRjH2ybxS4ur0dLxJrnC/iyy5KyEy7h6eAzaTQ9fy3ZjWptwsXAr/6X4X6
 zXpUOEiu92PbW+WUrBwuoXBiNIcC5tw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-jqkG8ONBObWIV2A0OuA2EA-1; Wed, 27 Nov 2024 07:22:25 -0500
X-MC-Unique: jqkG8ONBObWIV2A0OuA2EA-1
X-Mimecast-MFC-AGG-ID: jqkG8ONBObWIV2A0OuA2EA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so451668f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732710144; x=1733314944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4O6nW471G/UGmDhGC9d7nOGe3smH47tI63C5ANkA20=;
 b=sGHZn45jUSXzIo8l1+OaFsMJYPuB/AvHRfcmqRvHG7pw8RU7ML1tjY3W3rYCs5kMrS
 WXGtBDoDKZW7ASU9dIl6yzqkFbRy56E+PtWNO7iELrdIVtMaF5pS71AvjeZl77k2qS0R
 OA/iUpN7HhdukTfVyt/DHMIv3BkGEkEDsdpCR+uP7Rih0CrY+iyjC9ENKQoankaMsKLS
 hJg997LPIsUFX8Swpu7tmroA4hJtmKZhuRAOJ9NrV4cFRyWjQiX6Gw/O6TIu10+aVNQ+
 bPkjK+OdSQOndhydoEECouyVwhEV/oKKJDYL9q9KxPj3jupaAIq7d0Jujuy09cco+51P
 TPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnHCmadrq8DScFaXd8bBFLyy2x1N/wYb7AJmytjNFbuV66RAQSCMz8NgshUJJCR5J0Ov82bOhOcUDh@nongnu.org
X-Gm-Message-State: AOJu0YyqcKFfHYWXoKdkW75F3HvdBvEwph7ZAEDJp8akD2rSit9iUPlk
 eOC/hVIJcRhjO0cQJ1viJzgTLM8RQW3XhKngo+e+LHu1/ScSAZjSwCR8Jn1ENZDuKbOhc0pxsFA
 KMJzcUVpXsGKwjRpUBT4HQojaqt7soLXCSDIEbcWnHiUGnPjJBkXQWZzFWBT+65YiHD93ZITDLp
 WUWbCc2kM0/eBN1+etHL4iwtc85Cg=
X-Gm-Gg: ASbGncsqVvTZnEZihzNIrKXyoCdanlp7whryhBdorW2nQjwvxzmDxyxNaflmb8Borth
 ncjBULs/jxxkQzwZF+R6GG23G8aDjtrg5
X-Received: by 2002:a05:6000:4020:b0:382:3c7b:9bd with SMTP id
 ffacd0b85a97d-385c6848da5mr1987031f8f.30.1732710144074; 
 Wed, 27 Nov 2024 04:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH7i/aixZ2h6p9/ETM0G64AKoUp3Ew2h8XZt+ILrrXyM60PBStkTVnfRqANJFicd611ZNTG1Xt6Q0W52jGI+k=
X-Received: by 2002:a05:6000:4020:b0:382:3c7b:9bd with SMTP id
 ffacd0b85a97d-385c6848da5mr1987016f8f.30.1732710143736; Wed, 27 Nov 2024
 04:22:23 -0800 (PST)
MIME-Version: 1.0
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
 <CAJSP0QVGP9RQ57V-+2Lo2Se0x0O1KuENT24HzOn2X3A3vmn73A@mail.gmail.com>
 <Z0cOKGl-46wg5NTG@redhat.com>
In-Reply-To: <Z0cOKGl-46wg5NTG@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Nov 2024 13:22:00 +0100
Message-ID: <CABgObfaZkCQMWH9oH5rLdqHB-B8t2n9uWSaYASsBzxiiMK1hRQ@mail.gmail.com>
Subject: Re: Rust in QEMU roadmap
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 27, 2024 at 1:18=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> I question the usefulness of the 'syslog' trace target. I can't see
> it being desirable as a option for 'production' builds, and it seems
> uneccessarily indirect for developers. What's its compelling USP ?
>
> WRT 'ftrace', IIUC, the Linux 'perf' command has built-in support
> for using USDT probes now:
>
>   https://www.brendangregg.com/perf.html#StaticUserTracing

I also wonder if 'ftrace' is duplicating 'log' these days. Anyhow, if
we can deprecate 'syslog' and 'ftrace' that would be good to know
independent of Rust.

Paolo

> WRT 'ust', in LTTng, I see reference to the ability to use USDT probes,
> so I wonder if we still need a dedicated 'ust' backend around ?
>
> Potentially we're down to three options 'log', 'simple', and 'dtrace'.
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


