Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F025C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD03b-0002MM-Np; Fri, 31 May 2024 07:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD03V-0002LI-VB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD03S-0000Au-Dz
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrXf169kVCaHYgglOjYI5Ct9T/6NmM5FFA9dSl+lPlw=;
 b=hCTPUDdpQoCCjAM2RDdnWNaOvPCQwx6s8IcYU/ysIyFGxucWfcnbEEJwt+YVF9p52O+2V6
 nnwAYjzKUSpWfsf/hxz7fLe/AZp3//qI5ciJNkKUKKfoavtUACzJWA5f3KKtx655n+3AQb
 ByVRXQm8q63AZoaHqb/92RFXwlfmrGI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-eyrDIMTYMqyY0qbJA3MaXw-1; Fri, 31 May 2024 07:04:11 -0400
X-MC-Unique: eyrDIMTYMqyY0qbJA3MaXw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35e0f445846so349072f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153450; x=1717758250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrXf169kVCaHYgglOjYI5Ct9T/6NmM5FFA9dSl+lPlw=;
 b=JkhUZHmdSmSd+0NorXbmdhTSozukH3AvNb2W7KumZ5N2VsRZReXiCsAnXsd83U4s/h
 ACO9Fqs4/gi8wcAl5hBqWddWrdpiwsbKo3WWqxBuo+r01fQzwE6WsRT0usTcfm3+sRh7
 RYJFXWv9hU4LD0Wz3F17IAFjM9ZGrl5oQPbWeSCeW2VdiU7jGpKkwGR5il6D72CGyOFe
 ttBWY10+P6xztCWT33MkofwMPwJ2AD/nXksV81/QiZF9ucCLV2sgJDI4FRtIIry5+nUE
 j/1f+h8XzNnxIwRnkn4/432SAeFzBgOXyoqzZg8zs9vUc2VdAc6LdQxMjKpgAxWpmnr+
 O4uA==
X-Gm-Message-State: AOJu0YysSt+uOGqOr4906NvSt5sTAGnfxWDisMAMS3wAiRHLSFiLW7p3
 gjAnTg5b8HPczsJ1gZcpAOZIINYLxv07eRfn71FwVpUJk+fv7FoeLvMvv2Zqv4X8EamCVFDG0sj
 gScYKP01DyhkXD/e2qPgj/GYej2aTJNeogptBktw87RM5s86r2mclMBsLehRK/SnR3jmoL2Y7t8
 QXrg04elWtytjRefwmJquO3qQN6/8=
X-Received: by 2002:a5d:4003:0:b0:354:e4df:472f with SMTP id
 ffacd0b85a97d-35e0f272b5dmr1066910f8f.25.1717153450619; 
 Fri, 31 May 2024 04:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmFehOMMI/KFabXe/43YV9+whbMFVa9m+G9FPU/c0uHafhWnH55lclge4cujXx8/UJCfqXLi5mPsl+m5OkQGw=
X-Received: by 2002:a5d:4003:0:b0:354:e4df:472f with SMTP id
 ffacd0b85a97d-35e0f272b5dmr1066885f8f.25.1717153450215; Fri, 31 May 2024
 04:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-5-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-5-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:03:58 +0200
Message-ID: <CABgObfZb2oZ5R90pw7mkJEfNjwrcTwxT3AqKgUfguyKih7CXJw@mail.gmail.com>
Subject: Re: [PATCH v4 04/31] i386/sev: Introduce "sev-common" type to
 encapsulate common SEV state
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> -#define TYPE_SEV_GUEST "sev-guest"
> -OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
>
> +OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
> +OBJECT_DECLARE_TYPE(SevGuestState, SevGuestStateClass, SEV_GUEST)

A separate SevGuestStateClass is not necessary.

> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_USER_CREATABLE },
> -        { }
> -    }
> +    .class_size =3D sizeof(SevGuestStateClass),

Declaring .class_size is not needed either because it's the same as
the superclass.

Paolo


