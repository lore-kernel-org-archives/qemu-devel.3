Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5417C83038
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 19:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWK72-0002PK-GB; Mon, 30 Jun 2025 15:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1uWK6w-0002P1-VB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:24:16 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1uWK6r-0002Wv-Ar
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:24:13 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711756ae8c9so49307987b3.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751311447; x=1751916247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=087W3gVL7sk1pYvHtFT/YLIfaUJRYUtS8Vo2+U3u4Zk=;
 b=ZRN05kp2n4/0dXOXeR24/MZfyzWD1O0Wu7QzVtlu9uc+O5iUpVd5o7CkNUeiDyFp3D
 QQTnGCLu+Mhmm6LvUuSy0M8s7ieTYZz8r+a15kaK+sIU3mDlCasYMT+PZ6Sch5McJT9r
 drqa7Wvw2p2Cbnoj9ps5/hQ/5vA0iHhuZUsbrFKze7Y1Br4vg/CPK1tysgACSsPDAFIA
 abz9vuABhoFTsBfP1aIIS+NclOa9mwivCTQOy0wgpt2wvQ21oF9+WEImXyQdeE5QZEtO
 YVdD3v/2dh3IDNBlMH6wYojH6RVJJiaXe1rqJPgkAmsSY78TR6Ceesm4GYYMWWUZB6Yj
 k4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751311447; x=1751916247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=087W3gVL7sk1pYvHtFT/YLIfaUJRYUtS8Vo2+U3u4Zk=;
 b=PD4QzuzIlw+cjox48mOoQd1tLvog/1jqa3Du+vt50ZDxzVqZz3Z/mAloR6GQsGwwzV
 jYbh5VVvS88hrz3rgfYeQaW8PYG3iy3qLaY1bnGju2PqM1jUg05NJaN9Z/fM5KtY7V6h
 PbgCdrpA6S+GbGd7FzaBgYkYwYFRg14X3fULRVPGFBOVMMLolK0dEjQLqmd5YZHhh8S4
 sMeu2vL+tRDvfJsP50x/T4INqSkUQWJCbFDcLMJwq2rXRFIWYciGoBkuzrwNm9TgBnO/
 820PEf/t2DbAb8RQTR8PPlvlQr6DtmYxAjpjy96aR3CVNSAn4aNmT8nIAnWNHkfDxXDa
 XioQ==
X-Gm-Message-State: AOJu0Yz3YYKvaVNzObsekHh9/Bcm0thT9aDq/mVX4wCkqTTGPMG+TiDl
 WLfci5WYgcB742KjCb2J1sRKFhp6EJrv87FHfGX5ucgmadU+AtoswISfQ/8/+baKaercVkZgUeJ
 WpgxWanR9s58TPdbh8TcMEMVzR4eCiIw4LQ==
X-Gm-Gg: ASbGncuj1bfjXak2PVDWbNV3WJ08Ln6IY6vSVdpsBVGcbxVxG1jn91waT1e5Ua3YCn+
 d72eLob7PwFbeuCEd8U1bACjPJKp5J8Mq6iT2QvtMtEVa+ZYgLq6goEEknISZH4bC3d5cHiLw3W
 WCrYTApFgmoo01r4yaHviYpfIL2cSKvZrzMk91mKTvc2nB3C7AXQ0iS8gAL7viyfypHkFQn7L3P
 SnH9g==
X-Google-Smtp-Source: AGHT+IEKqv57DgyeX51cWLHfui6+Cbu+UIjHWjK8spdfA2JmnEYUdpqPnCe9icFE6KG7NSAPOcHNVPVv93TKoHOeEd0=
X-Received: by 2002:a05:690c:368e:b0:711:406f:7735 with SMTP id
 00721157ae682-71517160b01mr237354177b3.13.1751311447202; Mon, 30 Jun 2025
 12:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uyBMNSdKNtJWWTgNivj6dpDFzJJepkfpU5RN-wir9vQEQ@mail.gmail.com>
 <81d022a7-fdf7-4a03-9a3b-cb2635c96cda@linaro.org>
In-Reply-To: <81d022a7-fdf7-4a03-9a3b-cb2635c96cda@linaro.org>
From: mindentropy <mindentropy@gmail.com>
Date: Tue, 1 Jul 2025 00:53:55 +0530
X-Gm-Features: Ac12FXykGAlm_vBKXHar9GQQx1R0NKvVaHPuUDy1xYal_Vujt6HN3fGG5hD2vqo
Message-ID: <CAM2a4uxrzRKrQsnaNXwQO208V4WExg+MvweKfRwF+_RgXrFqxw@mail.gmail.com>
Subject: Re: Options to output the preprocessor code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x112b.google.com
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

On Tue, Jul 1, 2025 at 12:27=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> You can get verbose command for building by using make V=3D1, or ninja -v=
,
> depending which command you like to use.
>
> Then, you can get a preprocessed output by using '-E' gcc option.
> Don't forget to remove -o option, emitting the object file (or replace
> path).

Is there a Make rule to just generate the preprocessor output?

