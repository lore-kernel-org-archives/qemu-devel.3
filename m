Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EB8CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yJi-0003tt-Ev; Thu, 09 Oct 2025 17:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yJf-0003tN-Rl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:36:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yJd-0007Nv-UZ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:36:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so1660881f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760045807; x=1760650607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en60SiizG4qoGioX6w6/FkegkbZ4Y3jxv/Hq0XUoBao=;
 b=UhrNeUQ6qp94oiVfwuzMqd9i1iIeDF2hprdRIGOAn//fvfWvrGoPcRGGgnJbGXlt2Q
 nVNimLfetsxa0kdZN3wmm1+Ju+DMsJF39hqTqXqUq0dEKQivfjY1zD1/KgryWlpdKnXh
 dPPCaUUakerE7OaKRrErhVzm71ZmxmjIq92mJrEWkSyPsVuSh8clm7pLBEHxBqtutQGQ
 VL8VLUgs4cgIO3XftmzdvyIxfhcEQB0eV1xeItvmog/U8BIdsEFxg/v/Q0pHCwq2Bveb
 KehrfWwxjquMHniUuQNpdv97GFG8qrWW2MgJJw5mmMbggTwBBqXnYC7KyCkGMpMG1DY2
 3IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045807; x=1760650607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en60SiizG4qoGioX6w6/FkegkbZ4Y3jxv/Hq0XUoBao=;
 b=AbnRnONAVRs6VCk0hFEdTAlbbQbwRu1inzYT2KGfIhx8LYZ2FvPhh6uJ88JD4L77ER
 IGT71LFPs7HQFC3uJaMxPDGJm+iXxMcDCHHkmddTP0zp4cUV0aGudHn+sZpL7URqOOIO
 8Ja+FzhoCfOTtcU4gXjeSdGIIRQ/Xpe7WpyKwCdnK64AEJA1dyjekstgOIPAaBgg+h9A
 NcdJOM9Q5UzJqi6Ty5KWnASUC2HOLJZHz2vNuNri3k+vLCp+Xz3rkgSJxAHu6U7YXNhw
 wJBWz7m7SHDM+tu8vRxjPNsEvsKVQVS0QYrHrmkEaipKjBGp1kxUB7eMdB59n3GKCNPM
 Nt9Q==
X-Gm-Message-State: AOJu0YwNgOJbkqpJXWZu9ptJQAGLsto8X6sUdKHvh0spnEfH2lsGvaX7
 YtOLh6ghjl1V8BusVM0QofcpWeXfuyTVta20TMy5/IotyFnJ0rOwc5psQiWmsG6nzuHrzbgDSJ6
 9Gvvxvhb5FVtZpoObAwB8aIxarEnvcDo=
X-Gm-Gg: ASbGncvmf52BFpRaZ048gVUBd52gY1NZuqyXofMy7uHeRRlYsMGqL2kBgDOua0q2U3N
 4S1+ayRnjThzXO58P1yl+FfmNRHZbD9h86VJcRxuv910C4uBlvKtvKHK1MkQuWyVvRpDB2a5h36
 lWdR3lkhdAuE6aS/6+T2iVFWQqQbD2qV9rhbLYCDlNUNf6T3/4FmdwPnwgY7QKZAfjOYPMWMCb7
 iTxU+96Td/uORhrHSS4lwCqVKSmw7X6/jONa1bU9E3bf/wIAf0Mq42IKKYleOQ=
X-Google-Smtp-Source: AGHT+IEEibu9NqtNdi4PxG9hGv+MrOki49CFVM87VQ+zbQ+1lWqaPUavVlIOPp+X7SqEo3t8FYouWLGD3IfkOyulY9w=
X-Received: by 2002:a05:6000:4301:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-4266726d56emr5130047f8f.21.1760045806828; Thu, 09 Oct 2025
 14:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251009195943.438454-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Oct 2025 15:36:35 -0600
X-Gm-Features: AS18NWD2ZCdBv_jB1YHAg2d1DiO4DyNo5i3GqewYB5uU5FhL1OUgUZ_OfOjRMpQ
Message-ID: <CAATN3NrnVardwm9rXvHL_OhaotpWWEAiP0efL23G3h=nq4t4MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] linux-user/hexagon: Fix sigcontext
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, 
 =?UTF-8?Q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-wr1-x435.google.com
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

On Thu, Oct 9, 2025 at 1:59=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> In order to correspond with the kernel, we've now (1) moved the
> preds[] to the right offset and combined the representation as a single
> ulong "p3_0", (2), added the cs{0,1} registers, (3) added a pad for 48
> words, (4) added the user regs structure to an 8-byte aligned
> target_sigcontext structure.
>
> Co-authored-by: Alex R=C3=B8nne Petersen <alex@alexrp.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/signal.c | 209 ++++++++++++++++++++----------------
>  1 file changed, 117 insertions(+), 92 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

