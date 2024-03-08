Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E863FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ric7j-00089J-TE; Fri, 08 Mar 2024 10:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ric7h-00088s-KJ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:27:01 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ric7a-0007Ff-TL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:27:01 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso81405466b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1709911611; x=1710516411; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e6fF84qOgCfbCnvQXCr7ZNpbBHM03v5U9YhZ2Fgrw8A=;
 b=BqeWc9WkM9ui660xWYbLOjgqdqEodbzxMRgjW6pB4EyUUGpdxiyZokVk7OCfElUryw
 QfB3o9U4ziP26h4Z4tGPIYTBpmO+jyhdkvomUeKCn7IJzc+dQwjhHRZvU/+ldst1bEze
 r1CqXBrBd84iM3FLUwXjxIEq65uckoDU2EaFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709911611; x=1710516411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6fF84qOgCfbCnvQXCr7ZNpbBHM03v5U9YhZ2Fgrw8A=;
 b=ZhVNty9ePgrZWqXEAlKaSY9cdHh1IS/dclmOUzkWGs0v04vApmDc4FtZJIUCzFHeqG
 zNh0qjGmQrqHndMvRfQ/9wnvW4nrOHwrUNamB+y1d7F7BJKrHcWy06I8iAlo2uMUI3i1
 /7CJgeg2MpvGYIA0waK2Uf8MwJN/4SlohyiIaC9j0mr4wWU8TzIUmy/GqSCp2O5NVOaJ
 9fl7U0ipyyUVObFMrhEk3JSrr6lSp0NLzbC/22O6iY6nnKezy9mOC4myvzPsPMlVa1gB
 PMpT0LeFiyh/lp5qCliDxoTn2fm9HJJIcnVh3/7QWs1vQVIm9aMk14tccZcuZa3qLqfw
 yIxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcy1VyEWGrirW8hKlW/PIUuJlK94a+bnSIbYx1sUi4X8Q+Q4fqmbAfJBfFv2zdKZ2wm+73Y3Uru7G6dyrkH0q/AI9QK0=
X-Gm-Message-State: AOJu0Yys5T1fUot1Etm/sH+x2zkpHLhF0gTenAgfGNfSGgnDK8ZHWHIh
 p4mkG7CB0lmdgwrK7wzSrEytIZl1w977Rfl3faTbIEI1IoZwHWXJPUIpxn2YIeI=
X-Google-Smtp-Source: AGHT+IF8bpS/Lw7LZTkiFNoNorWDHb16BGAHMIBNBfb5gg03OYucnJeZMZZLnORdZk+jn66CYtXHuw==
X-Received: by 2002:a17:907:100a:b0:a3e:b869:11b3 with SMTP id
 ox10-20020a170907100a00b00a3eb86911b3mr14901522ejb.55.1709911611379; 
 Fri, 08 Mar 2024 07:26:51 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 af1-20020a170906998100b00a45aa7cb029sm3914977ejc.36.2024.03.08.07.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:26:51 -0800 (PST)
Date: Fri, 8 Mar 2024 15:26:50 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 02/17] hw/net/xen_nic: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <eb9066fd-e332-41f4-a234-4ddcaed9564c@perard>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-3-zhao1.liu@linux.intel.com>
 <b353cdec-2d6e-4ab6-bd4e-3e9cee5091a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b353cdec-2d6e-4ab6-bd4e-3e9cee5091a1@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=anthony.perard@cloud.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 29, 2024 at 06:25:40PM +0100, Thomas Huth wrote:
> On 29/02/2024 15.38, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > As the comment in qapi/error, passing @errp to error_prepend() requires
> > ERRP_GUARD():
> > 
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > ...
> > * - It should not be passed to error_prepend(), error_vprepend() or
> > *   error_append_hint(), because that doesn't work with &error_fatal.
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > 
> > ERRP_GUARD() could avoid the case when @errp is the pointer of
> > error_fatal, the user can't see this additional information, because
> > exit() happens in error_setg earlier than information is added [1].
> > 
> > The xen_netdev_connect() passes @errp to error_prepend(), and its @errp
> > parameter is from xen_device_frontend_changed().
> > 
> > Though its @errp points to @local_err of xen_device_frontend_changed(),
> > to follow the requirement of @errp, add missing ERRP_GUARD() at the
> > beginning of this function.
> > 
> > [1]: Issue description in the commit message of commit ae7c80a7bd73
> >       ("error: New macro ERRP_GUARD()").
> > 
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paul Durrant <paul@xen.org>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/net/xen_nic.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
> > index 453fdb981983..89487b49baf9 100644
> > --- a/hw/net/xen_nic.c
> > +++ b/hw/net/xen_nic.c
> > @@ -351,6 +351,7 @@ static bool net_event(void *_xendev)
> >   static bool xen_netdev_connect(XenDevice *xendev, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       XenNetDev *netdev = XEN_NET_DEVICE(xendev);
> >       unsigned int port, rx_copy;
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

