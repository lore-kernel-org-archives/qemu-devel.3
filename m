Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBo8-0004cU-Gz; Mon, 03 Jun 2024 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEBo7-0004c9-E3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEBo4-0007n9-BR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717436955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3WmsIAxY9dZI8Ob+M+L7GaWD2FuzMHbC9UiUaK29h8=;
 b=PFDLzCD6mp+ACprR8pWJ0vH6xkhcCFbdV1knI9r/7gXtsVriLCV0A5YHAv4s8gPMknBd+8
 9ZO83FRKDWcvjvQhogUtOnQMkv7h9rYAoW1UdFBJREIlg5UaBYdWCgsICeHiMWj3hpnoOU
 QfDoR51C/riAlVJK3zU6ZbVx6E0qnDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-NjQgnmVYORm1RfYtZIBr8w-1; Mon, 03 Jun 2024 13:49:11 -0400
X-MC-Unique: NjQgnmVYORm1RfYtZIBr8w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4213530af1aso13431665e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436949; x=1718041749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3WmsIAxY9dZI8Ob+M+L7GaWD2FuzMHbC9UiUaK29h8=;
 b=MizhugFRmX7awHKPd/OK6jGNXwEsXOKNAopth8hyF2ZWVEesfnvf/Av/Q0L/IIiT+T
 WCDTgHRWLibKnHHKgtXK0tbMfVflGlbLf09A9Gf2ciIHPX6ST06w8rOzNdG+tAJafNtc
 /oUVzg97oL//u9NgyuwtgRTz7KtCTr+zAGMvVXAsQ+FUdqo/XI2hYkTRM/rI7fMRGbNb
 34IdyQS1l+J/Q3X+eWw8CAworbEaZgS+Ou/Sg4NCv372WKe+1/AOckQXu4W1JkODDuzh
 IXW/JC8M7jFI3s6vrsPb3b2xL6kiE5p3o42R3Xsb1EYKZzRSOYqASQIJrxYcywfnacEd
 UXTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3JEAnvBeEODiUvX5XolCmXcz6pYV0yqFxKn0aIrxF2GbGx4zmxyWxIqoU2JkTVXmkXlRWnJD534i8DcKO/VOiZdLjVk4=
X-Gm-Message-State: AOJu0YypHgFyHq7jyDFa5iWZo5SUVSdkWbnJB/C3NhsfB9TAU+WwMUQJ
 VoCZufQptSS2WOZp18fwSekeFI7O2wt3cHiKYn4NT386EwMAZJh3Cx3a/NqIySvQKj5rCP8XVvb
 ygFGzd63e2m2fzM+lsBn37+NYzoFWsWBUL8oxjON/bXHVQz1nXMvZ/OxtGc1MRG7h+9iH77Eevb
 sqVVrng3yFhnW1g/1Cua6gM+rEZ4M=
X-Received: by 2002:a05:600c:35d3:b0:421:3979:8c56 with SMTP id
 5b1f17b1804b1-42139798e83mr35575825e9.40.1717436949753; 
 Mon, 03 Jun 2024 10:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbqFSwLkxs+GBeIocBtExiVcPfbKM6EgGyLF1m1MX6JOlzDCzjAQE9DJuLFvOa78ksAYM5/5f36+d6Gk1jfME=
X-Received: by 2002:a05:600c:35d3:b0:421:3979:8c56 with SMTP id
 5b1f17b1804b1-42139798e83mr35575655e9.40.1717436949399; Mon, 03 Jun 2024
 10:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-8-pankaj.gupta@amd.com> <Zl2w6KktLnFxq83Y@redhat.com>
In-Reply-To: <Zl2w6KktLnFxq83Y@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 19:48:56 +0200
Message-ID: <CABgObfZwvvMRas2nbrOQiqKOpaLOVhqPxbY1eezrSxya-Z9mgw@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] i386/sev: Introduce 'sev-snp-guest' object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, 
 dovmurik@linux.ibm.com, armbru@redhat.com, michael.roth@amd.com, 
 xiaoyao.li@intel.com, thomas.lendacky@amd.com, isaku.yamahata@intel.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 3, 2024 at 2:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, May 30, 2024 at 06:16:19AM -0500, Pankaj Gupta wrote:
>
> > +# @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
> > +#     defined in the SEV-SNP firmware ABI (default: 0x30000)
> > +#
> > +# @guest-visible-workarounds: 16-byte, base64-encoded blob to report
> > +#     hypervisor-defined workarounds, corresponding to the 'GOSVW'
> > +#     parameter of the SNP_LAUNCH_START command defined in the SEV-SNP
> > +#     firmware ABI (default: all-zero)
> > +#
> > +# @id-block: 96-byte, base64-encoded blob to provide the 'ID Block'
> > +#     structure for the SNP_LAUNCH_FINISH command defined in the
> > +#     SEV-SNP firmware ABI (default: all-zero)
> > +#
> > +# @id-auth: 4096-byte, base64-encoded blob to provide the 'ID
> > +#     Authentication Information Structure' for the SNP_LAUNCH_FINISH
> > +#     command defined in the SEV-SNP firmware ABI (default: all-zero)
> > +#
> > +# @auth-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
> > +#     field defined SEV-SNP firmware ABI (default: false)
>
> In 'id-auth', 'auth' is short for 'authentication'
>
> In 'auth-key-enabled', 'auth' is short for 'author'.
>
> Shortening 'authentication' is a compelling win. Shorting 'author'
> is not much of a win.
>
> So to make it less ambiguous, how about '@author-key-enabled' for
> the field ?

Good idea.

Paolo


