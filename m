Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F6C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 11:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFgd-0004Va-4H; Thu, 20 Jun 2024 07:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKFgZ-0004TE-Mb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:10:36 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKFgY-0002fJ-0c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:10:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6ef64b092cso83023666b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718881832; x=1719486632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2zUwJteB0RH5ONq0Oo6msZzYvChShMj/SFUdCGLD2w0=;
 b=kVMEMJcYMLIYNFXBShU/lWW2aFRPPhiKZig4aNJTcxld5L3FB47Bjmq0TK6iOXYEFC
 F5QFdnQjLQo+H2b36URfZwvL0RNbcDkLJTa56TCmMqdlPb42uQ5Xbb0I0LkrW8gyM3Dz
 t7PynopDUwWKA0QxXwH3X7K0xaZ76VFVDAh8e9dYP3ZMVJTMDWAS0QA2goxkW+CPqymu
 MUha7bswnSL+N/dP65OiwsJPaXAdlMR7Qog0NQ/oMQEdrkICy9bmSOkC5dO0fRhdReNQ
 yPu9BU13BpxIl49ZGe/96Q5ltxTK8YbwGZttJbfSLDbMzbRzsDfikLHImjLvT1+Wnv24
 NLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718881832; x=1719486632;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zUwJteB0RH5ONq0Oo6msZzYvChShMj/SFUdCGLD2w0=;
 b=ppSg33YkrHayKXZ6Qw6DWIGkwhYozSv/73JThPAMVyVoT83T3BFhmF3caghX0/apfE
 3YTfgFMirMexQI7fVSQE5MDPqjveEzUpLLPOpU+Lhc0AB6UMtQ+PHWO07ek9HtadfCDS
 9agrhoz637ZO2dEVSP8vuD6o5DS17TD2TpRyJ5dKdb1+vzA3GLRmOmlE0+NN4nEUjgPs
 mCYDWYVTNh0YWlfMf84aiZHdwHgIn/yhROQRIVRqYlVnBg7PjJHKK4K70rn8XQVbAlVt
 dSesLEgxp6x1ABBEetumjlouYWBjrQPs645AqoFxw1csKNzCcclj8TtSyMUhE5OVNF89
 y8uA==
X-Gm-Message-State: AOJu0Yxy145eDk5s4HSA+VRgLgYahOEV2/A8roFUAJzqGKn025XBEa5V
 LaxpvLfe1s4VNd+ZQ4ptDESp8AEb9J+2MwJix95y4KUi3+C0oL5PvqQEnNBN5c0=
X-Google-Smtp-Source: AGHT+IHCqdS1o4Rd3A6LGFV6xQYC94gksokkSK8ND4I+nxoWtjNs7sRWcakMnt8hnF9ldNSVAIcFXg==
X-Received: by 2002:a17:906:fe4d:b0:a6f:4b7d:599b with SMTP id
 a640c23a62f3a-a6fab64869dmr392665366b.33.1718881832272; 
 Thu, 20 Jun 2024 04:10:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fc5a5d64dsm30268866b.48.2024.06.20.04.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 04:10:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82BBB5F93C;
 Thu, 20 Jun 2024 12:10:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
In-Reply-To: <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Wed, 19 Jun 2024 23:13:59 +0300")
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
Date: Thu, 20 Jun 2024 12:10:27 +0100
Message-ID: <877cejdg4c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add mechanism to generate rust hw targets that depend on a custom
> bindgen target for rust bindings to C.
>
> This way bindings will be created before the rust crate is compiled.
>
> The bindings will end up in BUILDDIR/{target}-generated.rs and have the s=
ame name
> as a target:
>
> ninja aarch64-softmmu-generated.rs
>
<snip>
> +
> +# FIXME: These are the latest stable versions, refine to actual minimum =
ones.
> +msrv =3D {
> +  'rustc': '1.79.0',
> +  'cargo': '1.79.0',
> +  'bindgen': '0.69.4',
> +}

So for Debian Bookworm this comes out as:

  msrv =3D {
    'rustc': '1.79.0',
    'cargo': '1.79.0',
    'bindgen': '0.69.4',
  }

I shall have to see how close Trixie is ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

