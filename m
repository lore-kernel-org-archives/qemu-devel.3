Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71893CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWau-0003Dq-9N; Wed, 07 Oct 2026 14:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWat-0003DQ-04
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWaq-0002BD-KG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791398539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Zm7X9FP3TfBAUq3AKrlY9Nk1qe1EMN0+TSaZKdtKEY=;
 b=CYmgDjw8CmcWNeqLQLlRLhWd1zLSusJgahWF/vyCCLMqELS3Nx7vEYGDwdsSkTsbm/APyU
 qyPuhAVcA+X+JmyosqJkzB+23uPnTPHkSGxY0PE+B+coTC1lCcewwIjyI2ZU5s1vuhY+A4
 rPqJl30lT7sJttFjRKEWTA5Z9slEgRo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-c_drskdsPL6FAenEhtpeJA-1; Wed, 07 Oct 2026 14:42:18 -0400
X-MC-Unique: c_drskdsPL6FAenEhtpeJA-1
X-Mimecast-MFC-AGG-ID: c_drskdsPL6FAenEhtpeJA_1791398537
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66c73057f18so4809039d50.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791398537; cv=none;
 d=google.com; s=arc-20260327;
 b=Y3Tuz+NN7PjrtibLgoCW03ACwrYP3wXcdUwf7T1hQJcubRholB6YV+WtdYHYfA0XmD
 Uk5nIxUsSg/wBCnGH0Y3FhELKsmOslmJklyBGlr+Z8feE4kQ9fuXNGNcY8NO5IqtXEoz
 MyNll+aeGFyb2iHvUCZMZuhTk1tW/Yk6BAAsD+D1BtKC0CI+gg3TI1BQngbM4Vp8+7/d
 wzA82d3Kb1C2xyMN66JnCIQbr8EJ/ytbXgTB/KlrCYAfqNVBPuQEEZ4Wpr0/nlRpQ/Yg
 b23ZPKquO2kXrt0zzoxlDp39wFZ4ycK2f5BLfbAV6NLHrIgzTYRORdvNNLk3Ai4nMk9v
 qLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Zm7X9FP3TfBAUq3AKrlY9Nk1qe1EMN0+TSaZKdtKEY=;
 fh=TaHjtwERhhcof444X8BKM4NsADvDIuiPj2FZTU0fUSU=;
 b=HAAOmcAf55COvJmdKcPobZg+rANxaRqDOGe50/b6fGlJNn/HV57pguUV9Np7AT/YI4
 QPPO2MJLR+qgKobtoACEvJd2rGHRBJTmuHIG3elf/4BcbtgQtl8GAvkp21dCxGHq0vFk
 eHPisB/nmWuf2+GPrpKK19kpiaL8Xzd2NTFNN2g6GtPEob5Saf5T6KLbqVCtZp+SmnQo
 M0Cqx2uUUWhj+bBXHK0cIyzEo9C2onB/nKQMcGc3URsk1cHRaz71Sxb+duwaarqfDK3x
 DkQeTeV7JQdydcnPGbfY6XpxxQBhJGj0w2FCBMtfwrkRvYFxbfscfgi+p7P3O0TenAmG
 W56g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791398537; x=1792003337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Zm7X9FP3TfBAUq3AKrlY9Nk1qe1EMN0+TSaZKdtKEY=;
 b=stckmY4JL71IMaOaYL6Arw5AMA6UoT3ACL9HpOhgEU0uCzYpll6vYvSmkQcYcY/w2V
 0pG3JcYdPTwhfsdc9NruIYWixt5M1VKIqGFEsVNzCNLbccdMsBEnIbaDhHHVgmS+fOUA
 3gMLFG7Av7sHKkuLm+G8HJk+hPkUphRGAi7n8diADrp/CVxnkeWIYOUe5wvKnuQQgRGP
 1ZPt4OOuHRzjvWJILHeFH46fgVvSfJ1qNy69GCA6luRkPTKwR2sjV6G4wBECocOxNPd2
 m+YIMDHseNZNdrixQ8evxAOfC7Hn9wnyASeWKjjpAdcDOVmM3fXRVt+/ouKa2taxiyBM
 t2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398537; x=1792003337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Zm7X9FP3TfBAUq3AKrlY9Nk1qe1EMN0+TSaZKdtKEY=;
 b=ZHn+YqaWEW7GZm+LXFn6IVoZRS/lMsl6XbqIk4fP0wZWM2XvWtyjJKtXBLuiavtxLs
 LacJhHpAi5V7QBIa2RqfBCkKOuke8LCOVLtAqgSf7oJMnprdiDkKkb9k22iOhR5aKrZz
 DwMl6DFCn8DfzRnRTvPsigp5ECDQ4otC2aqmp0esSp8fS6rzVLd5myP04X4IHHJX5XHM
 MxLMlpRBAFif9ChPewhx0Dosxd0zpjE6uRM5evQDKOKRegukZQtvqHKqEvgbmxrC6+5A
 AZiXzX1LhImcde2icwT0PVWbQAghZP/EahfyHjjQKrt3ksb8cTYqxtoVX5kz0F6ThBrL
 rXFw==
X-Gm-Message-State: AFq9FYLn+wfsy7xeXg7pg5tVIBwPCe2nyZc3jBYNVc/7zQ5T76c/iwqi
 cDTbw8Kk3NDkM+IUFXpg2RQbE0eePiyv5+RnDOHRpJIQ69zRmV77K8x1BU6YZRc4XThGGPClMyL
 1WFzQb1aMcC8pphmwnzyw3zCcVfzLg7LuffeU3ADraXTmpe6k6ullur+x+TXfxmjy5U6DQaPp2b
 oxdb2Z0kQ8Y5vl9oqiZum1cntSEhvDvbrpjT05pHI=
X-Gm-Gg: AYBFou1Qk4Peal8TJOLZqbKWXCq4HZBPu6L3hdvjjgtR1SQU0+nNz5hM1QZ3sACR/LF
 JP29q9gQOSqkHzs7MwT3MuPXRL9U1u6gEh4g4AgFN3g96OdT40wovHWXhQkv3hzhPfpkmOShRI7
 OaXvm2Lpy3JBj6DFX2lSpoHa/H8UWE9k251ihwtmTaNFXYrOZw2YZIbsUM4fYvF1K+ZrzMKR9lP
 kMuEOKJcTqW1qiz
X-Received: by 2002:a05:690e:144c:b0:677:c1c9:8cad with SMTP id
 956f58d0204a3-6790a400d99mr2119087d50.101.1791398536989; 
 Wed, 07 Oct 2026 11:42:16 -0700 (PDT)
X-Received: by 2002:a05:690e:144c:b0:677:c1c9:8cad with SMTP id
 956f58d0204a3-6790a400d99mr2119073d50.101.1791398536489; Wed, 07 Oct 2026
 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260929192403.2972132-1-jsnow@redhat.com>
In-Reply-To: <20260929192403.2972132-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 7 Oct 2026 14:42:05 -0400
X-Gm-Features: AclHuK9WFhaBwTxl7LlYVgjev7rXSN_QMt6GoOO12tf3CXv2Po913BMljdMgcMc
Message-ID: <CAFn=p-YZUaFkncUis+=YpP1eMKruk1cfWRVu4xaxrtAZxjLf0A@mail.gmail.com>
Subject: Re: [PATCH] qapi/control: Turn the reference to qmp-spec.rst into a
 link
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 29, 2026 at 3:24=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> Add a new anchor to qmp-spec that allows us to cross-reference the
> Out-of-band execution section of the spec directly.
>
> Amend the documentation in qapi/control.json to use this new cross
> reference instead of a plaintext "see also".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Markus: With no feedback, I assume this is good to go?

> ---
>  docs/interop/qmp-spec.rst | 2 ++
>  qapi/control.json         | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
> index 563344160e6..ea713a96ac0 100644
> --- a/docs/interop/qmp-spec.rst
> +++ b/docs/interop/qmp-spec.rst
> @@ -119,6 +119,8 @@ Where:
>
>  The actual commands are documented in the :doc:`qemu-qmp-ref`.
>
> +.. _out-of-band execution:
> +
>  Out-of-band execution
>  ---------------------
>
> diff --git a/qapi/control.json b/qapi/control.json
> index ef63a8a261b..e97fe317af7 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -44,8 +44,7 @@
>  #     client connection, used for agreeing on particular QMP extension
>  #     behaviors.
>  #
> -# @oob: QMP ability to support out-of-band requests.  (Please refer to
> -#     qmp-spec.rst for more information on OOB)
> +# @oob: QMP ability to support :ref:`out-of-band execution` requests.
>  #
>  # Since: 2.12
>  ##
> --
> 2.55.0
>


