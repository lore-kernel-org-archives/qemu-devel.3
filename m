Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99D7C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZb5y-0003gE-AX; Mon, 12 Feb 2024 13:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb5r-0003fr-O0
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:31:51 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb5q-0002vD-18
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:31:51 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-560c696ccffso7806411a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707762708; x=1708367508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8fldLeqquiqzvFhdLfh3UsrHhyviDfZSUyWCtk37W8=;
 b=Q+UPlklwfuxChju5UjyLnayKq9W5/aniaNPpMFgzb2R2/9T5M3gCGdAYY8nUg2NxnO
 LJ7/0unwttTaUsXL/qY9cE06+pTvXtfVfTlUwq/mzsvRha7Rrqcx1U4II18K91Oxu8zk
 B/gnaiaLahJ59sIhbU89xKGAD5z+pYq7CGyNIJ3pyUuXUV3crw96P6ihz36uxgbPPs1S
 5+lFGvzLV0sdRtzobN7tZ2lPOn4tSYfFgttclPIEg1rqkdp1s3YA7JX5cDMKrBLeDk/A
 rFVDfDz8raFsSit62+EWVRPRIGfc1eWmfCZpAdpJWlPqWlJxuqJdNG/JBvttMQ/obRJ1
 Kjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707762708; x=1708367508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8fldLeqquiqzvFhdLfh3UsrHhyviDfZSUyWCtk37W8=;
 b=hiABQcZ6US7iOFPFk84Xu2K0a1n+8PYQDUIX9GO1TF4V4awJ6kBLNboUrVN2ILwII7
 Zt2vqAFvXqBxsJKAxLebSBrxftde95S6nO9bQ9G7feZPeIei8PyKOgY5NTYpI6CpRgV6
 DJc5zZLZq/cdchqRNn0EAf4n/mdAB50tDQj6l8bc8XcbjWV7g1btsy6Z50Y6kkFqdlhd
 3RFuh35aCYyb4ORiKRK5+Ms7LrQ+TAMgkTvVWWLwEfYcSJTJ7l7Y1IUUfsz5f/WibhDt
 sYUtokvqEM8XfVVdQVGeIVpzxWrpj2KRykihGYAOdcTXeFe3HfAfJng09qJTd5nXJUre
 R9ug==
X-Gm-Message-State: AOJu0Yx+wMNHUZ5NETOge3AhEvwQ9B/Eu+G4Gn29BNaYZoTKyt4tlQaM
 eFfvFb9W6wZgpgh2fD9WDsIZkMSU6O6HIiNYOT9Ig6awly2wbrOXzs/jbwhilUUs/+JVN4aShZi
 lIHKW8YDx+6gyTAvXf09jE+8k/ij0SqhPMDAX6olTOQqIZ8W0
X-Google-Smtp-Source: AGHT+IGiO6oAQfJ6DPL7tgY/d4XE7rfkhcllviQmznpNY9U1hageaNa9VoKA/LD4uLro6Nuj6nwybqEVfaAI9f/eAjg=
X-Received: by 2002:a05:6402:22e3:b0:561:ea13:d3ff with SMTP id
 dn3-20020a05640222e300b00561ea13d3ffmr93846edb.10.1707762708623; Mon, 12 Feb
 2024 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20240209140505.2536635-1-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 18:31:37 +0000
Message-ID: <CAFEAcA9cSPNOMFpMFFQ-bZqqj4OMGNYBLTyEShwhXTte_E8n9A@mail.gmail.com>
Subject: Re: [PULL 00/17] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 9 Feb 2024 at 14:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 9e34f127f419b3941b36dfdfac79640dc81e97=
e2:
>
>   Merge tag 'pull-request-2024-02-06' of https://gitlab.com/thuth/qemu in=
to staging (2024-02-08 11:59:28 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to d87b258b75498d3e8563ec8ebaaf67efc27be945:
>
>   tests: Add case for LUKS volume with detached header (2024-02-09 12:50:=
38 +0000)
>
> ----------------------------------------------------------------
>  - LUKS support for detached headers
>  - Update x86 CPU model docs and script
>  - Add missing close of chardev QIOChannel
>  - More trace events o nTKS handshake
>  - Drop unsafe VNC constants
>  - Increase NOFILE limit during startup
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

