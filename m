Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB92C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNKm-0001Ul-05; Thu, 22 Feb 2024 23:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNKk-0001QY-Il
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:38:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNKi-0001fe-NR
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:38:50 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so57776866b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708663126; x=1709267926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFHKaEw6873AAZ0VRAAKHbAgCQiveJ+OlQnJ34l1ObY=;
 b=RqSFmuFZZEvPr/My4+p64iP4uZf1BIH2lxKE1ZpTh1r7zhUAtDjbKw0PLhA3agUsTB
 HrcqcyiKJZtw9D7p1KV0/4n6axwW/Fl+kGTNDiVlndY5j/k97C65kvhUgUFsWIBRN0IL
 uPW8L/PVm291qHcj0aMLrvjyWKfqolQahYZnPuqI5JX8wExaHFuHWa1drHkPa2m6PC55
 i10lxu3I0wfvtphMbxVu+tFfli7IfVBH3loAcT1s0k3O/RyfdGIIUvvuCvqYlEfFtSx8
 O3g0aSWufkvmyqWpfv/PWPEJqcjvaRZfN0/7Jq2iM2tO/txnq0wH7PiFu6qMJ/usbhEQ
 /+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708663126; x=1709267926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFHKaEw6873AAZ0VRAAKHbAgCQiveJ+OlQnJ34l1ObY=;
 b=wiN7ETDQmX6gzNPaMuPNl1YsbWP6p7Ye+CV+Ns1gKeOKMyEz2La/lpCJBs5bUPCidU
 WvfWnE1z/qWkL1pABjJKkpkLXkpr//hBzTIJwVWEH8CCafBHYZug10gGsbrgYe1KqO4Z
 0dcyDI5AjxmXKSFjYM/h89H13WMZyUn1OfZ02cL2JASDqsP4EvVo/hPrUCZTF4jaSvIY
 8bG+bnhm0AkDZeDDa/kt4uLCIGTvR7OvbvNglb6E6mt1ouVze3sLnal3a7HtluF5L96x
 j1aTWoimArI1DyJX1i/TkEgcVFeJ2qqYx+lwJq1bGARdmiDw1eizixgIRY0q6CVwpih/
 skhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdhRknFf/RsshaN/wrtvCWBagJ+VdNdhHHCvqz/qw6uiP8NaIF7cWDJwcxrFiz/ERk2wX0CQvXqEq/Dnt4X+sDHs3flVE=
X-Gm-Message-State: AOJu0Yx1gba7gXSK/3+Br3ZC79d+0yMCFbc6AL0RkznSdtBwGQlv3zfj
 xu1SBagv7+jzyktczE3MnSB8b+/oAzcWRMX5y6yo+UtGlQK8+e8hd0EMvwxaZAXYiBO85TU0++d
 QmEGZyyk5wRUya9WeXVoZ7OIuIk6F8NehlVnHVA==
X-Google-Smtp-Source: AGHT+IHcL5LJNY+HgAmwWPPaJTqTOlbxyih5nlemzBXDv//UUhHFtCz7lDz3qncYBvCWKku24FAUEQvhkXmBbN6ZrXc=
X-Received: by 2002:a17:906:6d50:b0:a3f:a009:690 with SMTP id
 a16-20020a1709066d5000b00a3fa0090690mr416841ejt.14.1708663126137; Thu, 22 Feb
 2024 20:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
 <5265633a-9d28-44b9-96d7-a310c2a2a304@linaro.org>
In-Reply-To: <5265633a-9d28-44b9-96d7-a310c2a2a304@linaro.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:38:35 -0800
Message-ID: <CAAYibXgWXah+sLGLzTA4g+fufY7xDb3LY3P5T-DM+Ci04AME1A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 16, 2024 at 9:08=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/16/24 12:39, Hao Xiang wrote:
> > +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> > +{
> > +    for (int i =3D 0; i < p->zero_num; i++) {
> > +        void *page =3D p->host + p->zero[i];
> > +        if (!buffer_is_zero(page, p->page_size)) {
> > +            memset(page, 0, p->page_size);
> > +        }
> > +    }
> > +}
>
> You should not check the buffer is zero here, you should just zero it.

I will fix it in the next version.

>
>
> r~

