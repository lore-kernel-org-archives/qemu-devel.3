Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16926C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdxM4-0004kb-VR; Sat, 24 Feb 2024 14:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdxM3-0004kQ-Ay
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 14:06:35 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdxM0-00089u-TN
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 14:06:35 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-512eb0f0616so2046017e87.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708801585; x=1709406385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnBYEUpcfxOBBv+CnhBeSl0C37kpDQCXoY37KCY9FuU=;
 b=f69B4FKJ8akHuhnSrxRKXxB7lYjB3A2KaBuF+AZRODbg1zKEQREFGgqlHBqMHMnZxN
 Z6P/VzN2VMBXjtx9tcYkSUC4wDSLWP4N8b9IwbU8kgQDhnUeA6ulEORMphpsbkc3oHD4
 OAaGMpPa6LeEPhNPZTCT5k3TOtSC0Rs9r239wu0SeYxnPeo8EDwVKunsifqB8f8DlnRj
 /pY2frug24dWG2ViH+dUyJU7VnhoMs1NKsULkxkeCHCKRsx0lPYQTLfDiOu3X0NSgaQq
 rcbhZZCDuDyAKBTMOPQz/uqlKrtGHhtro5+4EbTFl3/xKB0WzhyXD7qC+0IwX7Mw1rF3
 tuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708801585; x=1709406385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnBYEUpcfxOBBv+CnhBeSl0C37kpDQCXoY37KCY9FuU=;
 b=g7eG+ZIEaSJ10+1enoC1p0clqwSZeYUa2QMjOQmzwEqZuGdHgbAcpgWRvEv4gPwEy/
 t64fGVDcOxXPdEttWvvUByFO1JOEIWobIivpM29bs5VypPNhlN+DCB+f23regykWfFXB
 ymEXWIvkFPMqDOXLrDEsJYIAnQbAMTXQYYLiSfsCod+icAcGuFStfnbg5asvRU4FCwO1
 FGFqa/AGODW/1HjgW9LzKqKAcSpWGS3ve/t4yQ7gV7vjHU1NSvfYIPK3b1yohXtQsgsU
 E14eGFYItgVU18ijo3xxoj2pP84PmgPmOX+IFolXGLHVkQvdAfLVMdAxcPOvK7KJ0UcO
 6gsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhHr80CVTYcE5m3eIcHBTmlDaOAVTjg5B/re+QURtHLsSJVaEpCa7jT17QasX1vJCmTpITN83tBwqJyq9w3ybNTHZ0yog=
X-Gm-Message-State: AOJu0YwZP0KgYAx91Nv0ZA1zDzK/+3xrC8gscQxGjxqvtWx49x0J8JMY
 3dGqRI36YSWU0o9YboxeRX9f5U6Vmh+WPWftK2hoauZm4cDUaRcSowQ7NYNDK0uKCPThMobWO7w
 yBcjk6HMOLIk7gsFoa3r/RdDf1FIy7MSb2Ho0NQ==
X-Google-Smtp-Source: AGHT+IFGxN6Uq2JawQ+9hpGlwZW/9u0sxG0MR0mLrAVmJGO3pzDBm77UM8J6vS0A6ufxGmWyokGHwZf3/at+yKMpfwk=
X-Received: by 2002:a05:6512:3b2c:b0:512:f719:aec5 with SMTP id
 f44-20020a0565123b2c00b00512f719aec5mr270258lfv.9.1708801585360; Sat, 24 Feb
 2024 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
 <5265633a-9d28-44b9-96d7-a310c2a2a304@linaro.org>
 <CAAYibXgWXah+sLGLzTA4g+fufY7xDb3LY3P5T-DM+Ci04AME1A@mail.gmail.com>
In-Reply-To: <CAAYibXgWXah+sLGLzTA4g+fufY7xDb3LY3P5T-DM+Ci04AME1A@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Sat, 24 Feb 2024 11:06:14 -0800
Message-ID: <CAAYibXib+TWnJpV22E=adncdBmwXJRqgRjJXK7X71J=bDfaxDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lf1-x131.google.com
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

On Thu, Feb 22, 2024 at 8:38=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:
>
> On Fri, Feb 16, 2024 at 9:08=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 2/16/24 12:39, Hao Xiang wrote:
> > > +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> > > +{
> > > +    for (int i =3D 0; i < p->zero_num; i++) {
> > > +        void *page =3D p->host + p->zero[i];
> > > +        if (!buffer_is_zero(page, p->page_size)) {
> > > +            memset(page, 0, p->page_size);
> > > +        }
> > > +    }
> > > +}
> >
> > You should not check the buffer is zero here, you should just zero it.
>
> I will fix it in the next version.

I tested with zero out all pages but the performance is bad compared
to previously. In my test case, most pages are zero pages. I think
what happened is that the destination host already has the pages being
zero so performing a memcmp is much faster than memset on all zero
pages.

>
> >
> >
> > r~

