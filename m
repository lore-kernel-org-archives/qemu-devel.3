Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05868C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 03:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYHRU-0003ck-1j; Sun, 28 Jul 2024 23:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYHRR-0003c8-7V
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYHRP-00048N-Ok
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722225174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58Yf1d6D/y+wAgppMcR1J7jZGh4AHKBz5xefeGpwfxw=;
 b=ah8NNWGWmoQWJEAcEzBNn8LWXAXSV3H37MLcWCh/vxU5+oXrEOiiTIFl17RrIcYdlxkWHj
 mIsRPq22t2mCX5cl1Hp4G51OjH8GEewFdw1Wm5lF3We1w1eh0549OkBpV6aKDZXyZPNtWt
 bJeC8upZvEhnaZ8e5wdWjcs4+qfO8Pc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-aOCuPKqVNIqRp_0l3_rncA-1; Sun, 28 Jul 2024 23:52:52 -0400
X-MC-Unique: aOCuPKqVNIqRp_0l3_rncA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-70d14fc3317so2341195b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 20:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722225171; x=1722829971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58Yf1d6D/y+wAgppMcR1J7jZGh4AHKBz5xefeGpwfxw=;
 b=RAX/vm7gyZvvFiJDAGEjoem0OF7/4hZcopZBOak9GPN54BOJZBfsCLi+P9cIagRHRc
 A8sVYYHZvsW1OlihkkdeTEpYsuQiBrCijWAe9omFwBY2fB/Qq+s+Il136P9yEEWlhKll
 h1/SZiLTbJW28ZAJpxtiBmNoVoYBQXu2gTLqV7yn2b5zQdwwjY0k0GOJoNZ2c7vNu3aI
 pHGbRuxTmN5evRfu1xJ48d0A4gfTpna1tzbHmqWxSm3/4WkpbZXWY6c587bDFwb7ci82
 gh8WRxKBDYXfy2iJ3KnfGjF5OQhqAlQKEqcjpbfBdFRW/CEks1/sXOig/IGR2S47zFBR
 l8HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8oZzOHd6smN1c56taNTfuXmr0M7uBZ6NxM8RvNmePjzCO574rYwRgGRCcO1D5UDbyLBv0R/p01RFtVQyjWHehhJ00aiM=
X-Gm-Message-State: AOJu0YypxwGyM3Yc3bJwvw2wcJDg2kn/7AW5+ob6UxD6dHxX0yF8v13Z
 czPfhBfTfjLrcVmdKWbqkNgsya9u1jbOScjaI4e9xC/reXDoZRzQF7+5vBEP20iZBKcFiHT7bqY
 we3pxLM1W0IWeGh06vdCHdGLQXciAEJY0cTMKnPPMyVVHJSnSokPCMGMJY/7RPk28aaipwnvkP/
 7r1xMY/+NUoos0UQaV6TRWN0uC0Qw=
X-Received: by 2002:a05:6a20:cfa2:b0:1c4:82fa:a5a4 with SMTP id
 adf61e73a8af0-1c4a129fe72mr4134758637.18.1722225171014; 
 Sun, 28 Jul 2024 20:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHs3NtCOnYIJ8TXcJocZ6Tdjmi+Gqozy5GX+t6oLOrn8cU2dHXmhHDSeBmaq3KGGFu88zt0ews6tohoZEM48M=
X-Received: by 2002:a05:6a20:cfa2:b0:1c4:82fa:a5a4 with SMTP id
 adf61e73a8af0-1c4a129fe72mr4134729637.18.1722225170550; Sun, 28 Jul 2024
 20:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240726020656-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 11:52:39 +0800
Message-ID: <CACGkMEuA0OfX8_RCFLN-ARG2Lb+GUc1pKfV0yPWKYq6vPNtqPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org, 
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 2:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > USO features of virtio-net device depend on kernel ability
> > > to support them, for backward compatibility by default the
> > > features are disabled on 8.0 and earlier.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >
> > Looks like this patch broke migration when the VM starts on a host that=
 has
> > USO supported, to another host that doesn't..
>
> This was always the case with all offloads. The answer at the moment is,
> don't do this.

Sometimes, it's not easy for management to know this.

For example, in the past we suffered from the removal of UFO ....

> Long term, we need to start exposing management APIs
> to discover this, and management has to disable unsupported features.
>
> --
> MST
>

Thanks


