Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8A4C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEp0O-0005Tz-24; Tue, 13 May 2025 08:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEp0C-0005Nu-85
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:44:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEp05-0000TL-T0
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:44:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso5475418b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747140287; x=1747745087; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=30nM6y+HW1Zl6sJjnOuhtlFcxyZxgvEMvZRIk4Nvlps=;
 b=Ex/tHahXTSEI93vwCHFoQO2EbtRBGGtt5IMiZjcMl2P7wG0jAKyAQsY2JzoOD0NZP9
 Emoby51YN2EeNHUDdeT380QZglGvsmzDdfngx5Hv3JqS0So+8OPE9byv5TQmnf3Eiuvy
 RP1vVErFrYoDrJMgIjwPqQJzRuLwqzrEQwn08RL69vMuE8LEI1tuNLfEioTB11iavQNu
 0acd3e3QxQxw8RBnYnCRja7GFyRqkYLJfgsBETDRpYxhGvO7Q4BkBGVHM6A4AIRbAJ9B
 mtQtvklQ/iMZWJAw16qh5TFxaMqBfYL/xUa0qfXuuSGldW08PQligDn78d1dfpoNG7u7
 7qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747140287; x=1747745087;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30nM6y+HW1Zl6sJjnOuhtlFcxyZxgvEMvZRIk4Nvlps=;
 b=V3636QlcsfMegSeiS0if5lbxWfXUqHApmsXZKEXgWGuhafWO4BB/A8Nq2Ej1cgB8h+
 7mMADkvDx/ZLRXtHtTygpgcFSfw8KuHItlZ4A5eLUrM+i0XxSjOOuN8s3dmmtzM95oFO
 bVpmu97jFzcPtT6eAsKSrwcZm3h/xoHtwezUf/PKlMSLPFbQZBA4MEuoWLyKchhSC4fR
 n2fpEi68g3xCwsyKy4HPryYCnRR5E+nbPrusNvnTGIEl2dz94zoXliTPM56CiJbf3aVr
 2Bqy7tYd0nNm4/F/7ldH+DcqFNy6OtTSy8V44C6WcsiKzg96wPTsqLRclBOffG02XZUP
 a2Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrSFk6E9VFRpRLMg275rt0swOCAPINXdlilAwYl6L5hqogr8nsCGB29M/4h44pm8ClQrcy2YaCJhl3@nongnu.org
X-Gm-Message-State: AOJu0Yzoq/o5kdxy+SDK5bTAxOrKQxNuw+31LeTbyLWKFDUMzB285vhq
 ds+fuTl/9/n5a4Vzu0pKcriXVnx7ygHGaJ/jS1u1cvfRZ0RfF60F8J1QNupf/Zg=
X-Gm-Gg: ASbGnctBVYpkYxW3Jm6M69OYGgnz/HJC86uCxfPBZSDKux2qpFK5TnQCHUKLBPXpSeH
 LFOxexJBZApii9kjY+6kJMnSOPPG0mDRZLl3mdVdOK07qIp8ThsoJR5f0+XTks+AQbqLKQHwOiP
 qAEyPqxYz9TnCONCh5OVQHRGvAutsLQ2+2advlFV4oeOSYZGqbflWZpt+ywPQmKEaZxbLbtKEgA
 a6qoUnM0EhUcUtjtoxDGIgKAVc8Vpg9+mgRXG65/RwAOJrQkPmy8FWLfm24hojbhoZ1uw4l8j1w
 muToXg3klc4O1buVIrCSLXvRK7eWGz9IUxtOYsDmsdcIfwm5wiKlDnDfSJBHZBwEtSZc+89F0q0
 =
X-Google-Smtp-Source: AGHT+IHUmDONQ0TNQh6LIqxk4FiyU/P/nk3RD1g0QqoUbO53HMHve+MCiujYExotgKftmjD/UbM+Mw==
X-Received: by 2002:a05:6a20:6f0e:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-215abab9166mr23340621637.5.1747140287447; 
 Tue, 13 May 2025 05:44:47 -0700 (PDT)
Received: from [192.168.31.160] ([117.143.176.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237704619sm7545043b3a.20.2025.05.13.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 05:44:46 -0700 (PDT)
Message-ID: <014499c850a828e2e8b0b55376c36b9f8e7a7c1e.camel@gmail.com>
Subject: Re: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding
 in fixed-scale mode
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Date: Tue, 13 May 2025 20:44:24 +0800
In-Reply-To: <66a308eb-6ab3-c51c-bcdb-fe5c79811914@eik.bme.hu>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-9-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879607C14D7E5BB7FCDAAD1FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ffa687c30c11429767d48c9d1358c729d1e49e8f.camel@gmail.com>
 <66a308eb-6ab3-c51c-bcdb-fe5c79811914@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42e.google.com
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

Hi,

On Tue, 2025-05-13 at 11:52 +0200, BALATON Zoltan wrote:
> On Tue, 13 May 2025, Weifeng Liu wrote:
> > Hi,
> >=20
> > On Tue, 2025-05-13 at 00:37 +0000, Kim, Dongwon wrote:
> > > Hi,
> > >=20
> > > > Subject: [PATCH 8/9] ui/gtk-gl-area: Render guest content with
> > > > padding in
> > > > fixed-scale mode
> > > >=20
> > > > In fixed-scale mode (zoom-to-fit=3Dfalse), we expect that scale
> > > > should not
> > > > change, meaning that if window size is larger than guest surface,
> > > > padding is
> > >=20
> > > # @zoom-to-fit: Zoom guest display to fit into the host window.=C2=A0=
 When
> > > #=C2=A0=C2=A0=C2=A0=C2=A0 turned off the host window will be resized =
instead.=C2=A0 In case
> > > the
> > > #=C2=A0=C2=A0=C2=A0=C2=A0 display device can notify the guest on wind=
ow resizes
> > > #=C2=A0=C2=A0=C2=A0=C2=A0 (virtio-gpu) this will default to "on", ass=
uming the guest will
> > > #=C2=A0=C2=A0=C2=A0=C2=A0 resize the display to match the window size=
 then.=C2=A0 Otherwise it
> > > #=C2=A0=C2=A0=C2=A0=C2=A0 defaults to "off".=C2=A0 (Since 3.1)
> > >=20
> > > Current definition says the host window should be resized to fit the
> > > size of the guest surface instead. Wouldn't padding accommodate this?
> > >=20
> >=20
> > Yeah, window will be resized to fit the size of guest surface in fixed-
> > scale mode. However, users are still allowed to resize the window to a
> > larger size and this is case where padding is required, otherwise the
> > fixed-scale assumption is broken. In fact, gl=3Doff mode employs paddin=
g
> > to preserve scale already but gl=3Don mode doesn't follow this behavior=
,
> > which, IMO, is a defect that this patch is trying to correct.
>=20
> I think current set of switches is not enough to describe all possible=
=20
> configs and this leads to inconsistency between display backends. Each=
=20
> display backend has different idea on how zoom-to-fit should work now.=
=20
> Maybe we need a new keep-aspect=3Doff or similar option to make it explic=
it=20
> then these can be set independently to decide if a full-screen zoom-to-fi=
t=20
> window should be stretched or padded. Currently it behaves differently=
=20
> depending on display backend or even options of one display backend as yo=
u=20
> say above. Fixing just one place won't solve the problem with other=20
> backends so maybe separating this option into a new one would end this=
=20
> inconsistency. I got requests from people for both padded or stretched=
=20
> behaviour so it seems some prefer one or the other and just zoom-to-fit=
=20
> can't set both.
>=20

Thank you for pointing out the demand for both stretched and padded
behavior =E2=80=94 allowing users to choose their preferred display makes a=
 lot
of sense. With the changes in this patch set, we can at least ensure
that all GTK-based backends behave consistently with regard to aspect
ratio. I=E2=80=99ll follow up with a separate patch set to introduce the ne=
w
keep-aspect=3Doff (or similar) option you suggested.

By the way, I=E2=80=99ve also been working on a =E2=80=9Cscale=E2=80=9D opt=
ion to let users
specify an exact zoom level. I deliberately left it out of this patch
set because I wanted to keep its scope narrowly focused on refactoring.
Once this set is merged, I=E2=80=99ll submit the new patch set with these
changes.

Best regards,
Weifeng

> Regards,
> BALATON Zoltan

