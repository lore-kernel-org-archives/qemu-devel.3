Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE70CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRi2-0008Lj-1b; Mon, 25 Aug 2025 03:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRhy-0008Jr-TZ
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:33:39 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRhf-0002iU-TX
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:33:24 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61c21e50168so3274912a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756107193; x=1756711993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4JtGl6Aj5CTEecOVG02hFtOXc+WAhuvt/ouAqEc18A=;
 b=I/X/3EdzJKGVvvBUeYSdKKcAN2Lt2b9WhkwiJ5FTV4FfISRS2M1ydhfjSqRn7/6jD+
 H70PkVjBOpjCgsHh6XbKvhm03iTPNVIjH/E8KNlYl7TIWW7XXmeZBgBJHxwR6QxPnEYp
 wuRSRQwVXB4IvYLVdRaaDcnS2xJnKYzFlU+P0Fd8zDOmiZr04GCrzE5L1xF6Ugs82Eyi
 3m+4OdB9TA2Jp0ME7zSUz/Rv1A9jjJqLt8CIctUIqYkgjVs9i8QrXkR8MvVHURJ/bxym
 pkuQnQkOwyMlBEYgzAgf/4H1+5nIc2YDwNq+QBJMUoMH4H4N5WnqYAjlNTSkYiPrWILE
 WsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756107193; x=1756711993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4JtGl6Aj5CTEecOVG02hFtOXc+WAhuvt/ouAqEc18A=;
 b=utmKwbcN6mkzbQxw66OtKEJKSHcpfOFpeKpZFeVjE9GhN0oStQt2d1EZfmQxfSsgwh
 MDnYCKONwhRRQb6DteBcNtByxM+c4UEFQewxpanCNBVmzDbDoJ+FbgMtZsfwApmEmGz0
 nKmMUm87a+OH/GTj0aTPwlyKw7Yu7P378foXKSrHJW+Rh/FA4RgfYl8brXICLb/nNi9K
 WVw+7L/NMMNtqHL6Epa96wk9yVUNlGnnY/YUn5ukB6fJmZgc79F6g3OTEgQMCmOPcbBf
 DYT5ojUZcBm1aoScM8iBjCNSHjIWIrLVfwn8/E8Smx37BX47GJSoP1mwoQWWM5N32Cox
 yjfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGlCWdWu2qCtvftRr/qIpilFRDHzwHpbuQBBoeo+nAbypZcK+R1GSvG4MVsN/lbZyp56XIhxBNe04t@nongnu.org
X-Gm-Message-State: AOJu0Yx0M/sClLw9sXENVU/S1LgdMdISKF5zWxdBFd3NeGoZYGkwNXBE
 EZ/loRg3w6kcdac11LVSJVNwRlZ79vIs3om76x1IrbaEj2P0ERPxHyrXMFNYKV6/phLxCmpNjUE
 KSbAqmuPWiCNqoyttSr0hq3QxKUfymIMDycGBidHHMQ==
X-Gm-Gg: ASbGncsQ4czqsZvNOPkth29zyg2JDT+VqWU6am2GuVST1HYxOq0pT82SvxclpLbIYTN
 oN2NNr3L+Eu7aYFsl0yXZjfCxYCbqTBHmsh3rz6dyyuBRwed50uDIvLjtBSgFunapZJk3bI/wnX
 xFtHI+fg9EKKyYnoj1F0YrdJRdqtpjtturI39jGn2w7YjPZiFCpjQtlfQJwM6oh7DAidoLTS5eI
 JECDBEp5nwt7+D3JqQ=
X-Google-Smtp-Source: AGHT+IF35MB9ISjk24BdD1zacVavMPTeTUgOcfzEFN0XxtPHkJH0MZLiGhcFcfvcSxYlKnAn1IWznKPeeKrlv1WuUss=
X-Received: by 2002:a05:6402:3514:b0:61c:73e6:b61b with SMTP id
 4fb4d7f45d1cf-61c73e6c145mr1005949a12.25.1756107192844; Mon, 25 Aug 2025
 00:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-9-pbonzini@redhat.com>
 <aKwV49H1RE31Bue5@intel.com>
In-Reply-To: <aKwV49H1RE31Bue5@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:32:39 +0300
X-Gm-Features: Ac12FXyn2sWaaGoUr-n8g0_fkkL0UUAY5lZcY1ypYXx-CoRbctKeKHx3fLgr6eY
Message-ID: <CAAjaMXZFus_sj4P_SNgUiWQ9xEO_rRmYvf5VVDBfz_Z_S6TXmg@mail.gmail.com>
Subject: Re: [PATCH 08/14] rust: qdev: add minimal clock bindings
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tanishdesai37@gmail.com, 
 stefanha@redhat.com, berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, Aug 25, 2025 at 10:30=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> On Fri, Aug 22, 2025 at 02:26:49PM +0200, Paolo Bonzini wrote:
> > Date: Fri, 22 Aug 2025 14:26:49 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 08/14] rust: qdev: add minimal clock bindings
> > X-Mailer: git-send-email 2.50.1
> >
> > Add the minimal support that is needed by pl011's event and tracepoint.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/qemu-api/src/qdev.rs | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
>
> ...
>
> > +    pub const fn get(&self) -> u64 {
>
> get() sounds too general for Clock obj...maybe get_period()?

(Or just clock.period())

>
> > +        // SAFETY: Clock is returned by init_clock_in with zero value =
for period
> > +        unsafe { &*self.0.as_ptr() }.period
> > +    }
>
> Otherwise,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>

