Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B207C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXOZY-0002Oa-Dt; Fri, 26 Jul 2024 13:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sXOZV-0002Nw-Te
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sXOZT-0003hF-98
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722014252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OApdFCzqo5jT5gQz6j/mnTgntG4SRH6PuXi40PJMctc=;
 b=A9hXAh1rx93md+S+Spcw7CZEzwmIRIgu8g//w8YYZk8ridcjpaa7QILmVb8LRM68pMgorp
 QnqkcW2K/El2txnsnI/GO8Vzol6otEr+wNh30CVdJDTq1Yb5CNcoYRcQaioF0522IKsNFB
 gBN1oFwoBYsygixJwR+OVVLxp+YNIKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-WkSBkWIONfugRlYaHcwF6w-1; Fri, 26 Jul 2024 13:17:30 -0400
X-MC-Unique: WkSBkWIONfugRlYaHcwF6w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36835daf8b7so1787159f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 10:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722014249; x=1722619049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OApdFCzqo5jT5gQz6j/mnTgntG4SRH6PuXi40PJMctc=;
 b=LfF+qnL/Ud/yeKlbb9D3WbTe7gE0bhLc0qzVbRI9KDkHMXPCuvYFX3KxDXXe69MPAO
 ByvzkS//BqDc6WtKbbPoHX6ES0Nh80LbGpBTJxj+IDgGBNKHoAp8crPPArJbM3fATqCb
 w2dLCHhXKD7SulNPTx2X0l4iqR0Hd2uuAXlxuZFYkniAjaILzT5ASFjRnKFE0FRej8K+
 Nl3jt5a8/3cr+ooUeD3V6QADYBfXnlpOWpkX/89PE8f8zoO27jOswvPrhatkhiVXjyB2
 1rGwQgkx0qh82fuaVTOaMT2gGwOqmpmqNk0zBa5Ib6x05S5L2ImTExsXf5V917tzOUXI
 YlqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxeeiD7sTr5KaVebaXBluyGyzA0HTB87ugaHe7gTE8O6x/7KW75nD/j5mJK6hdns0gQL9fTxrlA2ySrzw5IR3L4VH59v4=
X-Gm-Message-State: AOJu0YywcK/JmuN4VzQfldWFvdX+zO2S3/BBmYVVXNr0/dqnOFxfAlhL
 y6uoUeez3sBNg1ZNhAo5I3m7B9vKBCdgSF5pDjuFOo1HmvdmSGwIZplZ7GcCxRF9hoVl8nib2pn
 EJeDQ/p4kaQqro27b8uY83BpdJa2EHdaaqm1Lh3cVrsHWoastIJsyJ39wS2CLMnJFeN7PL/cPjQ
 yHQvDmNYIa9fZ9JaDSw1oUEcGBmvI=
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr299724f8f.43.1722014249596; 
 Fri, 26 Jul 2024 10:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd1VNkfisws3kDZNVAAV056jx+FRvLl+xH4R2DpmtBRfzO3QhrpvL1Lk+cyt7pRxN2vcc4zzJXuPT7qynxKRI=
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr299705f8f.43.1722014249240; Fri, 26 Jul 2024
 10:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240724080858.46609-1-lei4.wang@intel.com>
 <CABgObfYHK+N68pOamxA4nT6iZUvEDeUN-AkNwEE9jgnig3AfNw@mail.gmail.com>
 <SA1PR11MB673499AE31632832A91042E3A8B42@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB673499AE31632832A91042E3A8B42@SA1PR11MB6734.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jul 2024 19:17:17 +0200
Message-ID: <CABgObfYQhnT0B+jQEBrqucSDnbrY1FBRhoRRdou-u5icNkbvMg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Raise the highest index value used for any
 VMCS encoding
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 3:12=E2=80=AFAM Li, Xin3 <xin3.li@intel.com> wrote:
> > Hi, can you put together a complete series that includes all that's nee=
ded for
> > nested FRED support?
>
> We can do it.
>
> Just to be clear, this patch is not needed to enable nested FRED, but to
> fix the following vmx test in kvm-unit-tests, otherwise we get:
>     FAIL: VMX_VMCS_ENUM.MAX_INDEX expected: 29, actual: 19

But neither bit is defined without nested FRED (and failures if you
use -cpu host,migratable=3Dno are expected).

Paolo


