Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A205D6DDEA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBtGy-0005MS-0R; Fri, 15 Nov 2024 05:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBtGw-0005Lw-0b
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 05:09:50 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBtGu-0002hO-8k
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 05:09:49 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so2280091a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731665385; x=1732270185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8bbjQLj7ncJg0aHHV4jJUxiA9U18BXK41XU5eh+d1Q=;
 b=lSrk2aS/slCcv3dhQriTW5YGoBL/ZejHI5ZVyDQbsRYChgvyBScUlK5AIXSwLWb21f
 ZrhS+y+5Pck16WFBTvAlhMbBqWNpZgHZox0YnfKP0lv0O1gK5MpKvs9V+v/7gWFr25+l
 PcTwBaOIvnRF8psVKfibn/RBOpY4BBAgvKEiMw5CkWul+STPFU3PpuR/jyY+h4JTT5bK
 HDpZj+1fs7X8433fov5vy24Pl9gUSVSaVVQVm04h8hO+adCXmdHTZX26PT1tIKfa6dxU
 lhhFV6oQIXwCCGh0Ns/YUSbMpfBnHBzTRuA2bQeXRRjVw3ko6COw7eOxmuvhNb3WeyTF
 5ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731665385; x=1732270185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8bbjQLj7ncJg0aHHV4jJUxiA9U18BXK41XU5eh+d1Q=;
 b=UifGA+UWke1VNyJBu5xlUPMcrSIICgEt4pSBNqU7yCVy4YWVaTbzQVXuXqU8hfE5Ri
 vYcLYpORn/RkQAmO9istg18XvyZ5kzfvuaT9gercz3NGbiSJpOtApMlxTn0cFnYiiHsL
 v0dGrNqkJMeh50j2CrgX0WD/VKvrTnZL1IWImdawAw6m5RF7587LbVUhM9R4rI9ueNpQ
 haeI7e0w4Yu4EW99Idf6xQDjBmEU+AOHUebFy3jtH8XWv+dHIaoTZ6wHstzwKkn6Mvad
 w1sQKG2YR24Lf49aGNaCFNdxWM27P1UQ82Kcnd7wG0+cWj4tRgdkcbnQWybY8bOTrLr8
 /jJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA1j+4J/H4P3XsHlogXMOewiUnOsRo0+UWsdT+lztgvzsCj/L/Qfw+qJmhm0GY+7gYMiRgyHXmukLq@nongnu.org
X-Gm-Message-State: AOJu0Yylp2XgPjQJSbJY9/aCqAencycq61l3BUlSv+XypM2hr9d40atZ
 ITdC6TjfRxg2b4R+3pAoItzaNz14lF3XGb6cBuMxjz8WspfieclH9EIwWkQxW/PQBdANVA5LRdY
 wj66tSSdfFhpcE/PFOqM2Gvn1A1Moehz1bLTVGw==
X-Google-Smtp-Source: AGHT+IHntwj3VHcjpMgNDpYw5kwtXN+Gek7MjyW20JzcFAR2vNhTs8UVYmsCbvtuY+SZCcGXGJY80PSRfX9JPqaA+e0=
X-Received: by 2002:a05:6402:5206:b0:5cf:6093:9377 with SMTP id
 4fb4d7f45d1cf-5cf8fd32361mr1236604a12.23.1731665383715; Fri, 15 Nov 2024
 02:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20241114110101.44322-1-kraxel@redhat.com>
 <ZzXak8gl-IksvLkQ@redhat.com>
 <2svr2cmjdyjkbvjkc5jecfpa2xxzea4luuq5ecm7v6i7ubbrf6@7two2tspqqyj>
In-Reply-To: <2svr2cmjdyjkbvjkc5jecfpa2xxzea4luuq5ecm7v6i7ubbrf6@7two2tspqqyj>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 10:09:32 +0000
Message-ID: <CAFEAcA8Q8ESHRu1WCU6O=Kbm4RcyH_f1ULyRKQ0tejHcx9rhUQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Firmware 20241114 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 14 Nov 2024 at 11:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 14, 2024 at 11:10:11AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Nov 14, 2024 at 12:00:56PM +0100, Gerd Hoffmann wrote:
> > > The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d=
022432:
> > >
> > >   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/kraxel/qemu.git tags/firmware-20241114-pull-requ=
est
> > >
> > > for you to fetch changes up to 5916a3b20fdbfbfc2f987f1121e945100c8c3c=
d2:
> > >
> > >   x86/loader: add -shim option (2024-11-14 11:55:39 +0100)
> > >
> > > ----------------------------------------------------------------
> > > loader: fix efi binary loading via -kernel
> > > loader: support secure boot verification with direct kernel boot
> >
> > Hard feature freeze was two days ago, so I would have thought
> > the new secure boot feature should wait until 10.0 cycle ?
>
> Patches have been posted back in September.  This PR is a bit late
> because I was offline in October, and also because I didn't realize we
> are in freeze already due to being active mostly in edk2 these days.
>
> So, if an exception is out if question I'll have to wait until 10.0
> opens I guess ...
>
> > Their commits say they depend on new OVMF features and we've
> > not updated the OVMF binaries in this cycle, so do we even
> > have the OVMF feature needed for this to work[1] ?
>
> Nope.  I have a branch ready.  The plan is to submit that once the qemu
> changes are accepted.  edk2 is in freeze too, so this will not make the
> edk2 2024-11 stable tag.  If all goes well it'll land in 2025-02, which
> we should be able to put into qemu 10.0

If we aren't landing the firmware side until QEMU 10.0 either
then I think I agree with Daniel that the QEMU-side new
feature work also should wait until 10.0.

(I plan to try to be quite conservative with the release schedule
this cycle, because we don't have a lot of time between when
it's supposed to complete and the Christmas holidays, so we
can't afford to overrun the nominal release date by more than
a week.)

thanks
-- PMM

