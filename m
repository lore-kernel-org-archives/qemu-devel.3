Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB49D63936
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDjWr-0005bt-OY; Wed, 20 Nov 2024 07:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDjWm-0005bS-Eo
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 07:09:49 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDjWk-0002XG-Ts
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 07:09:48 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cfc035649bso5159689a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 04:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732104585; x=1732709385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDLyM/unrlgwRkQA8uYUyiVpUVCJWQAK2aPnQQmJNi8=;
 b=eoaxqhMYatoDAJLk5gvfhixMS2OSY+RdI75Ih95v6kzumcz1DWep7BDfgaPTEPQlXa
 6LjQ596SGA7jIv4c+cFoRy7e0GPuZlF8TNhErpd3wZ3X0PwJvr7onGF/O+6b4bPoaoVz
 AyJM6sU09vh1geto9P/QY0cHLCfrSGAccPwHLC2DdNtiVtCGkmUfTg0VJHUXswvpUvSy
 mqY7VXWAc6nSJB5V9m/ifUqPAJBZulyNGZsOJUcKkVXisIU9ZljSYHf6MFeu8iX+LCj8
 7c7PvdZSvkk7fuK43tqH93HlNXv0Bvsdz7VflxQi4pbbmq42l5l1soEBELpaoCl+H02F
 gcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732104585; x=1732709385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDLyM/unrlgwRkQA8uYUyiVpUVCJWQAK2aPnQQmJNi8=;
 b=F8OHJI65+lio4sIUjIMomq/PfQo9YVViiGRmb0+tVzsRxVXuFX5qJCNjg6lqZ3z7d6
 9+fQUP/N5MFZcYk7YvOHzzNaFRurwhc4irpDlCrX/AXYCwBOnlz4FHw7BWRbtDWVu4W6
 Fm199+23oNnEDXwsoIrvJ4EJwMdLq5Hb8S2PFERWwjWJ++SnlVwL5dmw9DIYk/uiH7we
 2oXkYe1FySyrOriVBPtdNjp4OgD3U4RfyOdKH3YGtGpJXU6hcv6mkRSh+U57h0etYOYv
 rRa/Z53qjY40hmBtX2hlp8d5GOnr1qk9HB8JdETI229iZJsF3kaKUrKvjcWffInLsIBs
 etuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTxgCfIk9ekkWfQQFBDw2n1ecLFBO/eQEE9632UuiWSajGgYzK4r7n4On0b5QsXRz0/HvIRUboX0Zr@nongnu.org
X-Gm-Message-State: AOJu0YytU62PUL+TJQs432sRH5YTesYKFkWCRzeB/RzFN/0kmiJEzXZ9
 Wv9YgjoxjqdYVi99WBE/P0gDfue98M2MDJeFq2RD/ENlCyscxD/B2H5opSbVVr+AtQBpiho34kL
 Z8ufomWNg6iSAukUXKB8SOjCGghGapMMMSUM+mA==
X-Google-Smtp-Source: AGHT+IGKfP+dMDJhGnVXc5kSc1sAOgBfEfmMOApdWBHu8TbFvNCwEgiAjdxsV092vEUeufLfVBHpbhMqupt2h97c3do=
X-Received: by 2002:a05:6402:4307:b0:5cf:b8f6:92c4 with SMTP id
 4fb4d7f45d1cf-5cff49fe8admr1623804a12.0.1732104584630; Wed, 20 Nov 2024
 04:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20241119212456.873660-1-clg@redhat.com>
In-Reply-To: <20241119212456.873660-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2024 12:09:33 +0000
Message-ID: <CAFEAcA9vJ8+tVOngfZUS_OFJsxuaYF=BDnARdi4QbvkmvTW6_A@mail.gmail.com>
Subject: Re: [PULL 0/1] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 19 Nov 2024 at 21:26, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d6=
79:
>
>   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20241119
>
> for you to fetch changes up to 9b0a36494a477541b543fa689c635cf4912fa641:
>
>   docs: aspeed: Reorganize the "Boot options" section (2024-11-19 19:12:1=
2 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Restructured the "Boot options" section in the aspeed documentation
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

