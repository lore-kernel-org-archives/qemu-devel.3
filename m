Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA597CF58FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 21:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpVK-0006kk-RB; Wed, 19 Nov 2025 16:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpVJ-0006kC-Ja
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpVI-0005v9-89
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763586855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIa6AvnhB0sjknlJs2kcSDzWzFkWLghANMtJDSjIUc0=;
 b=il0Mcfv+goG7dZiIuHBac/RxoLsv7frr6bUKGTj1G+plII25ayZKhKxMqG8aqOzlLSH+8E
 4xxkrbDl+Q8XOSwSvlwkZ7mOoIjgMevLG9mLxtyTDGBXHZQuyhYABnzPDH1RMBIzRe/3Ls
 j3iV5vQ/pHbo5Pe09c4meNdCo0vnKls=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-USA0GWviPtCJgbpdDveSrw-1; Wed, 19 Nov 2025 16:14:14 -0500
X-MC-Unique: USA0GWviPtCJgbpdDveSrw-1
X-Mimecast-MFC-AGG-ID: USA0GWviPtCJgbpdDveSrw_1763586853
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63f9c4e3701so237887d50.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763586853; x=1764191653; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIa6AvnhB0sjknlJs2kcSDzWzFkWLghANMtJDSjIUc0=;
 b=PUTiy4CgDCHelL5zm7Uzc5PGuYjruxG3KHwzynLN8U++t4fdt7xkECBY2m2FolL4fe
 yTkxG0sJ2vVLqV7cMjfAQ51DN5ZKbptNJ6QFNi/RujZ6RYwJKYnWXTLiw60pJtSmfjSq
 nJyQh8NutqBrDFPTrhnWzE/r9Aq4t8TKbSN1IEqxNJvNkj1413DHNjcQb3ZfxOCJuK8g
 BPhq9JUoVScnzx+B+FDbGu1ROuM3kXXQvIInGeFgCDvU9GvvSOgz2SZvrHA/lJwQakOW
 ZRQ32x4mkNCFeLRt9KR+1Q9BxFgpF93GB9X8n2U++a8CL/0Y5GHYIvfNdmRNGZJnhsVl
 R5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763586853; x=1764191653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wIa6AvnhB0sjknlJs2kcSDzWzFkWLghANMtJDSjIUc0=;
 b=Yc0/K9aO0OI0P08Q9sZ9xxYT71Ey0Lgu3u706zZLsupVf4jTY/KZPb5+MzWsV/IXdp
 q+MSDFNa8h+QfwqbPbadHWbQZNdeW10yraRCnThfLghljsWBbR2d7BOC1n+9dcNY4Agu
 Qh+m4Q4NiKXLoAZzUQFtSvCS3Hgs8NpmUhi2NdX+Y2JHcFpzOhL1D6q+O0JmQkj9eEKL
 wm+TTDB9zxuDUj4K1wp+ILvMXjI1GNYhG/X08S2BcShy51w4oZFDwx3PD2cr0iad6n4f
 Dzvq1ZPKpzXJY/9uC7zjGBGCYcw87c59qvM6thYZTQ465inp5BPjl13nzNeQrSW4MLEX
 iiRA==
X-Gm-Message-State: AOJu0Yzg7sknZZqB58+ctWvk4Z4Ey6qMiZcySSr8R1uP9yRx1N24MwYT
 2DYFycMPIeamN+ZES6b3eBbUahax5TkYhbZnusWa6tgeSGmQU3U3o47F/CH3qj7AH0AlI2iS/Yw
 he6DYV9zbZgh6HeSlf500jla1582TZpcTffAA4OmWJrAEoTHsvKyAbEovUQi1ipWPUPWZhskoqz
 rFnXINnoWaKgFwE+zE/pHb0ZDEhxxqT00=
X-Gm-Gg: ASbGnctUwSDa+upkRKYcpWSRVSK4eSUkcXhxCeW9DkI0yxifzudwSntQHtpTtBUhiwi
 5PvCwx4M2Wm7Mf4GPktvYVNcVp8FkVjxObPN3aPSjO0c069wObgsByrRk2bUC0IYksJwywmRqFV
 qBrDrI+gogMENYdI/jttBMXZZnQqWzcc009tVMSyjGCIphFl1O6e/9bpA3U3otgRNO/mhUCyGmE
 HZkCdCMTfTeTKZ0KYkIJwGh5g==
X-Received: by 2002:a05:690e:250f:20b0:642:11db:f5f9 with SMTP id
 956f58d0204a3-642f79ee581mr492020d50.55.1763586853375; 
 Wed, 19 Nov 2025 13:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrQ3u6pHMOxtgdM3cR/OxP5tSooZ0Lqtm8GvVLeTQj7Nxy1Lrrevpdw1cYvQxHDSGAVw+lFF45IHe5migxJz8=
X-Received: by 2002:a05:690e:250f:20b0:642:11db:f5f9 with SMTP id
 956f58d0204a3-642f79ee581mr492007d50.55.1763586853125; Wed, 19 Nov 2025
 13:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-23-jsnow@redhat.com>
 <bedc5336-1359-4624-a3bd-519824eaf043@redhat.com>
In-Reply-To: <bedc5336-1359-4624-a3bd-519824eaf043@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Nov 2025 16:14:01 -0500
X-Gm-Features: AWmQ_bl02SNQqyWPoPkkbi2dejYUf_vqR29IpQiqoAw3rbX7SsZSc-kpDXAZ2_M
Message-ID: <CAFn=p-ZmtVKiwPoO5N1uA6WL_Uu9yGueRWv8E3P2EZL8mzfGYw@mail.gmail.com>
Subject: Re: [PATCH 22/22] python: delete qemu.qmp
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Nov 19, 2025 at 4:27=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 17/11/2025 19.51, John Snow wrote:
> > Begin relying on the external python-qemu-qmp dependency instead, to
> > prevent desync between the internal and external libraries.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> ...
> > diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse=
.py
> > index cf7e344bd53..e377ef6942f 100644
> > --- a/python/qemu/utils/qom_fuse.py
> > +++ b/python/qemu/utils/qom_fuse.py
> > @@ -47,7 +47,6 @@
> >
> >   import fuse
> >   from fuse import FUSE, FuseOSError, Operations
> > -
> >   from qemu.qmp import ExecuteError
> >
> >   from .qom_common import QOMCommand
>
> Nit: The above change looks unrelated.

It's actually related! "qemu.qmp" goes from being a "second party"
package to a "third party" package because of the removal. Thus, it
gets regrouped with other third party packages in the import order.

The import order is:

- first party (python stdlib)
- third party (PyPI stuff)
- second party (local imports, different package)
- local imports (local imports, same package)

>
> Apart from that:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>


