Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78893CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6z0-0007md-W4; Fri, 12 Jun 2026 14:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wY6yz-0007mE-QI
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:51:57 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wY6yx-0004DN-Jw
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:51:57 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-660390a8999so1563455d50.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 11:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781290314; cv=none;
 d=google.com; s=arc-20240605;
 b=WD7qlxIehL88dYI1U7ndxvARf+UQx58zUh7MYDO21xTTCoYlcREjhK1b8K1s5tdXsK
 FhSFCE0gpRJlM/C/T9bJ6erv21KfppgI5j+IR3+O6D2Yf4N03jKjI95Ij17b23QhtAFS
 Nm9AjMhxiP2xhtK2USq+tgr67rR5Foqk5kIvDKqn5OjuQgF5Db/bi8DsNHgBaGz3KjQN
 DipFEXeuEbHI2IbiqFfdQ83jbkM0vMzCZI0tnNn/IFQZMt2Rc8f1m0JUijtkq2g/yEwO
 b3o5QF1gNy44sBjedmMYoYtc8+QRqCUMAbzEVwxaqcYjmr+OeQXrSv76jIAhhp+s3ZJk
 r/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nItO1iK+AI4fN7aNZ3blkxKNyLt+powS95ANb0OLSIo=;
 fh=VzQn70hT2MC4IC7u0R3/uSZ2e5K88XuxZuzwH4Te4/o=;
 b=eFJEiWo6oFkmtXrHQvRxNYcQ0cvJFlmW9SEJXDBGfa4XS/sxXEdKwuB5E35BvxiInu
 tw49OY25MXfchUHv/cFzQYz8ORhXyUvueL2dxBqXpfiYOjDwLmg9wRrqWIVuPFomtNv5
 R6hegSBoIoZJGv53YYIOrxJ6bbv9sSctuhlwXuJki+8trteEZfl7BdNu5fDfMivOAsfM
 QBda11daqFCFbcRa2x8WTmc78anmNadyWSo7T+MQowOLwHo08RNMOS0sSsznji2Z3ZYc
 rtvJaUkb/L143ZVrQBnxVkypLSEUFgERaiWi2QGIpTUYa5eEbYtB5djYQI0lvzJIgc5K
 0AGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781290314; x=1781895114;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nItO1iK+AI4fN7aNZ3blkxKNyLt+powS95ANb0OLSIo=;
 b=tpeYThf5mFZvO4aj5JD7wHMTG6O0VHendc7l9iLM3UQbzUr8JWq6bpwN8EW9ujjZQj
 N7xpkHZARjhhQuwCV1eWVxJMZRdP7TvyKf9hnxAKOO9di0RJIFxuwlDtsxlinUUyi7N8
 7yJvMd4tdr5xSMiGxSa5mTfNsIYFEWHRhiKHT91KEmULDyxPXYYZaYcnmT/IkWNmYe9G
 nCnBSHn5+H88myn/6c978va5DYpKWiNMLrx4Xf/8dVI0w4wBSX6jOZFDZdipeURmtlSy
 wF3XMLBvwT//4tDD4mQOrPhGlb1CmnZfTh7i7lmBKMGHQRfdp+Ty6RAgXQA682mAPdKU
 KxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781290314; x=1781895114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nItO1iK+AI4fN7aNZ3blkxKNyLt+powS95ANb0OLSIo=;
 b=IxPR5E6nOQIxF0Hq/YQijT7U9gaAlGTFeA3w1Rmu5ITw9ggC/2hSMFks12vHu57iiC
 qEaWNM2vpfYnI4hN/ADCG3Lj1phlIT8qyc5wqBc4dow/tjFkV57sacY82IyxXEI2fAvz
 aa8qHcLkfrdShanI1at2mnhHmXhqFBn938Rs2UBoJQv25AFGAo45oqHU74Kq/I+N6aGt
 AUJ3IuIhGH2ppO4iBmEfMorc8oVR2vkwHdIvTJPaoyCK9ZZi1tZjZHq6/p+yxXfSQWA+
 /oEasQi+q0RQDJgFn0ejMrQMRGJqs8hrNyW/+RLLf0tH+7khu/A43O6Ri2s58noGGSD+
 9RQQ==
X-Gm-Message-State: AOJu0YyzWFcRoAeMA0l2QiTHGZAekZkxImcjbJjJtOVJ/9kNEWZYsMMV
 A76QxGPggt8wRp/hB7U1Qsu6v8iobEUW/fanxEu0fnakqrCj3fyHWq1VZFHCdNEe1Lan72eOI+q
 5gYC9nH43I+k31Ad06hKa2x2A1m865hsEjeToHtctvA==
X-Gm-Gg: Acq92OG8KC2eck2Y0i26X1FPMxUt16mXsiGH9goRAcQZBH1gt83o0uq5B3e/R/HdjCR
 AiiqI2uWxH9UlVKHrSSm4uTicE+yHz4q789ESkDR/MHl/Qr9EGkd08i3RIksQYgSz7GFOITXJKb
 KIMMYouevHUPImkYcHz0DyBkv6vUqw/ZP2yACDkSfVU4i9D22ebcdSTTAJ+avYHYF4yJyc+8icV
 3YamM4ZZR5AyOcC7A1aZI0IuobdXIm4zESF4Jvv0OpVAyIIcUjgchc3Ea7/ygTCDuOhNobXlbTH
 vGasrcxsNE3Wd5F4puoS/kvXNzp5mLFikRPLdg==
X-Received: by 2002:a05:690e:c4a:b0:660:877f:a5bb with SMTP id
 956f58d0204a3-662851248bemr776635d50.51.1781290313925; Fri, 12 Jun 2026
 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <f6c93a7b-b5d7-4d36-b9b9-0302fe912465@oss.qualcomm.com>
In-Reply-To: <f6c93a7b-b5d7-4d36-b9b9-0302fe912465@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 12 Jun 2026 12:51:41 -0600
X-Gm-Features: AVVi8Ce5M4hZl3S6ZwDg5IIeo-b_QhOKczb3TCPmCRap0_1AESCcbiNOkScSlXg
Message-ID: <CANCZdfou33EWKkwr4g0wLAn9TuqMp_nxPpOe3HUs8092TEyUTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stacey Son <sson@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000675624065412f8ad"
Received-SPF: none client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000675624065412f8ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 3:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> Hi Warner,
>
> On 18/5/26 23:27, Warner Losh wrote:
> > Upstream the file, thread, socket and remaining signal system calls (to=
o
> > numerous to list here).
>
> While looking at other CPU related code path, I noticed the
> CPUState::random_seed field is left uninitialized. On Linux
> emulation it is initialized during SYS_fork. Add to your TODO?
>
> Again, this should be handled as common-user/, but that is for
> another day.
>

Yea, I think I'll add another commit to this series to cope with it. I'm
just getting around to dealing with the get/setsocketopt review comments so
I'll fold that in.

Warner

--000000000000675624065412f8ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 11,=
 2026 at 3:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi Warner,<br>
<br>
On 18/5/26 23:27, Warner Losh wrote:<br>
&gt; Upstream the file, thread, socket and remaining signal system calls (t=
oo<br>
&gt; numerous to list here).<br>
<br>
While looking at other CPU related code path, I noticed the<br>
CPUState::random_seed field is left uninitialized. On Linux<br>
emulation it is initialized during SYS_fork. Add to your TODO?<br>
<br>
Again, this should be handled as common-user/, but that is for<br>
another day.<br></blockquote><div><br></div><div>Yea, I think I&#39;ll add =
another commit to this series to cope with it. I&#39;m just getting around =
to dealing with the get/setsocketopt review comments so I&#39;ll fold that =
in.</div><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000675624065412f8ad--

