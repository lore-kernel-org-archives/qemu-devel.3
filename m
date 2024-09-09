Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F083CCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snUEv-0004Av-I8; Sun, 08 Sep 2024 22:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1snUEt-0004AQ-RF
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1snUEs-0003J8-9s
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725849286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgubxgKdAZNELArefLEM+EL2IG1Pt1bPc5TRWEtglaY=;
 b=J7vNGFGzrgXxIx2Ln6HHn7pbHsR1EUw3HrHHfz0xOzVq4JnTx952tzFPcY7mnoZQ3pd7ca
 mGu1/16RBajqW7yfGE0ek9GCgcWV/k1oEXFBypc9zWJOYhccSJ01xyeOR7X5FMskzJ5JSs
 WxR3KeYnNt2XusU/HdqPJKJV3d3pcH4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-G-aIEofpNV2h_l3iAoJnxw-1; Sun, 08 Sep 2024 22:34:44 -0400
X-MC-Unique: G-aIEofpNV2h_l3iAoJnxw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d8b3af9e61so4111912a91.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 19:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725849283; x=1726454083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgubxgKdAZNELArefLEM+EL2IG1Pt1bPc5TRWEtglaY=;
 b=QGNVEue5uKYs1wLWRrHQzQbHdY6YXZV2Ml0HC6ruPt7QQeA0LZnTAxdquSFEx5RbN+
 eu0msJdgR51LHZuSVi/LmPItJ6yfN9ombPekywtdFQGopYXIttacaPQ1QLPZmIHP+3eF
 r6exgxpdK29Kivu6Dr8r/Eyp6E9Y0joHxQKWjSOtbG0w1LYgB2WvG9vSc34bOYDnEFj5
 hmb8QGztMd6otJJJNkJ1DtJQfZSJCAYqybmJewKKAjVrelesQSaV0NkKM5mS/4JyTYct
 nr803QgvRz//0vj1WBs9nyW1MT3dO+E03wTXrWKmBK8Q5j3OhhQdygAi8lX1qlY1XGFS
 C0WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPk2YZK/YICOhfovYYgidn4SocWUBjFL/2i9CoC0wUjThipH4xGhZJ886snyF0XnB48bljnyBI7IVT@nongnu.org
X-Gm-Message-State: AOJu0Yylc5H4gOExF4uAVCBagrhXCQ9Yhuod8d4JFIDcyPpjwxXoV7hf
 zP/sDTx73rHB0pFWvCLiwgfAvTI7YQYwTBf8ZhMjAk9BpND4eeFKRwyM60RarSUmlPDixuXMQK4
 D83YT0X7UMZiPYIy5RS8Lx/dsmZc05LkEwf/3spbs2Rz8qHMN27dX0YcELuDWA5MOajCq0vd9Ha
 zV8iKRHzBYl3noGImER1+GNsl6Llg=
X-Received: by 2002:a17:90b:180e:b0:2d3:b643:8386 with SMTP id
 98e67ed59e1d1-2dad50d926amr8215898a91.9.1725849283504; 
 Sun, 08 Sep 2024 19:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEwu2OehJG9FgIYcaVnJyLJ3eujrL8YS3HDtE8CfxB8WgdLjKHz3FkFOzTUhqQNSTv/9qM0o9XaVTvIHQZ+pE=
X-Received: by 2002:a17:90b:180e:b0:2d3:b643:8386 with SMTP id
 98e67ed59e1d1-2dad50d926amr8215889a91.9.1725849283117; Sun, 08 Sep 2024
 19:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240906055711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240906055711-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 10:34:32 +0800
Message-ID: <CACGkMEvxkVt7iFkTJT3u1fa9cAycoXyFq62Bq_f8Ebm6NLgpmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Report fatal errors from failure with pre-opened
 eBPF RSS FDs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Sep 6, 2024 at 5:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Sep 05, 2024 at 07:13:23PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > The virtio-net code for eBPF RSS is still ignoring errors when
> > failing to load the eBPF RSS program passed in by the mgmt app
> > via pre-opened FDs.
> >
> > This series re-factors the eBPF common code so that it actually
> > reports using "Error" objects. Then it makes virtio-net treat
> > a failure to load pre-opened FDs as a fatal problem. When doing
> > speculative opening of eBPF FDs, QEMU merely prints a warning,
> > and allows the software fallback to continue.
> >
> > Trace event coverage is significantly expanded to make this all
> > much more debuggable too.
>
>
> looks good
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Jason's tree.
>

Queued.

Thanks


