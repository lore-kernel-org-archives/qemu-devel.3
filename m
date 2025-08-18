Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDACA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 02:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unpIk-00086d-As; Sun, 17 Aug 2025 22:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1unpIh-00086S-8a
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 22:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1unpIe-000502-5s
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 22:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755482915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz31gaDXvGkc7O76/EwnAq2QwdqCXXtDb5HWo4gWZTg=;
 b=eaNcOebojJ1SOPIYsAYdfMEYk6XMzhTEcv2wXNOTtHc0uDbF0/KSbnPyD6rnewlNdX/7d6
 44dimp9WelPuaRJzw00JqeNqD1GpWZyyzE04Sc0syiuS6nhEgYr5Z3PGYfBr9WCYj2dvOv
 QoFkORJhePiWQpob8mRfHqg2qdEtees=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5RD3wXjqMEaM6Q2VYSDtWQ-1; Sun, 17 Aug 2025 22:08:34 -0400
X-MC-Unique: 5RD3wXjqMEaM6Q2VYSDtWQ-1
X-Mimecast-MFC-AGG-ID: 5RD3wXjqMEaM6Q2VYSDtWQ_1755482913
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32326de9d22so3519096a91.1
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 19:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755482913; x=1756087713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz31gaDXvGkc7O76/EwnAq2QwdqCXXtDb5HWo4gWZTg=;
 b=q0gfNPDEKZ50Zg6MZUzliAxkZ/de30gfrlC5LntvzzRme6x/QxpeqsyCT4f31BmR5y
 JlNhseHzaARDlkts0aJGt0QdkfDVNjDFG0wCychHWXXemXuW9pyWdT+mT/miRY8GSLP5
 tba6Z3/Ts5y3frMfpdc1rpE+w8M31QPci8MW2NsXj9ILXO9wNREy24WHEI4ntofKqM8A
 GhBFb7E1PzYvD/aK+oIdSmc3lgP8ZJaKfidU9/VvN5j2fAw5PeJtJ84AlxPeF5gU9yqP
 J9TxkEDeUUkuuQJExWB8PRyLC7dbm7RFGjf4UDDiVXt/pj3QVDQcA2s09LAUS6sW8yTI
 jLqA==
X-Gm-Message-State: AOJu0YzdDN1TLL7Ssr5eyC+B0mfJjlm5YAWWmBoGH7WxoW8NeXlg3/z8
 Dx2T0oQwaazZxypiDungwn7IvTuXy4xVrKpDBD2GklQmrofZy2ZTzFE7PMVYmSWz0OmgysbgH44
 LLilAtmifS703wuhuYWfziKqyta2lsLWFk4JvM/+L5KAKhpbtfnLBFtCObNhRW2CN9OS6L8YAFg
 0RS+KLossuz9jLi7m0Z4b6bwB24WB1wT4=
X-Gm-Gg: ASbGncv9Z1jk5oK5xsUjd8Ckm7MbxPeETgGqiMRqTNI4sxMhigzAgweZJX4LDaZFgEw
 pUv/o8EAw6BPh6wruP78i3syYZvy80TK4svFujgpBxrz6ovQVNokzPFJ/pP6pkRAKM4XUskIus0
 fjAX1dezq0bA8US87Hp+KC4kw=
X-Received: by 2002:a17:90b:3b4d:b0:321:1348:4438 with SMTP id
 98e67ed59e1d1-323296d963bmr19271621a91.7.1755482913062; 
 Sun, 17 Aug 2025 19:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw8vEE5l3SgNtNHWkrDIEh0+sLzZg3+Ue7vNh050ScuN6/NrhgRFXceYdNHLVBMs8VR8RTJqucpVpxtJDlwrA=
X-Received: by 2002:a17:90b:3b4d:b0:321:1348:4438 with SMTP id
 98e67ed59e1d1-323296d963bmr19271598a91.7.1755482912612; Sun, 17 Aug 2025
 19:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250807110806.409065-1-lvivier@redhat.com>
In-Reply-To: <20250807110806.409065-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Aug 2025 10:08:18 +0800
X-Gm-Features: Ac12FXxWXOdH_odxGzdo-vVXqbS72n9bDwNBq7dCnRxnjcQ9Cb5Li9KMb4nWp9Y
Message-ID: <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
To: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 7, 2025 at 7:08=E2=80=AFPM Laurent Vivier <lvivier@redhat.com> =
wrote:
>
> A race condition between guest driver actions and QEMU timers can lead
> to an assertion failure when the guest switches the e1000e from legacy
> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
> RDTR) is active, but the guest enables MSI-X before the timer fires,
> the pending interrupt cause can trigger an assert in
> e1000e_intmgr_collect_delayed_causes().
>
> This patch removes the assertion and executes the code that clears the
> pending legacy causes. This change is safe and introduces no unintended
> behavioral side effects, as it only alters a state that previously led
> to termination.
>
> - when core->delayed_causes =3D=3D 0 the function was already a no-op and
>   remains so.
>
> - when core->delayed_causes !=3D 0 the function would previously
>   crash due to the assertion failure. The patch now defines a safe
>   outcome by clearing the cause and returning. Since behavior after
>   the assertion never existed, this simply corrects the crash.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Consider rc3 is out. Can this be applied directly by maintainers or a
PULL request is expected?

Thanks


