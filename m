Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E08CFA754
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 09:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy68b-0002Zs-0T; Tue, 08 Oct 2024 05:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sy68W-0002Z6-2E
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sy68U-0004qh-IG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728378243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIKgPx52tH4OBzVX5B9YC82zR79E6lpexUwcIvymyNs=;
 b=QCrymFJrWGsAWzYIabSAJwwYN0XLtzGUwCsnlbevWOEOE7ihV04eXcI8NuVEzVk7aAXHzJ
 zhTa5P40XetxxLwQLS8QL94hfZBbSeYsnajbmTa5YSAqOf8nyZCf51+JLbUQT9wFkv3Cju
 xmgUyoHKdIdEf92qVHPlCu+4CakC1Mw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-_SnPoMrDO-6HqgQyVWxuwQ-1; Tue, 08 Oct 2024 05:04:02 -0400
X-MC-Unique: _SnPoMrDO-6HqgQyVWxuwQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so2430419f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 02:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728378240; x=1728983040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIKgPx52tH4OBzVX5B9YC82zR79E6lpexUwcIvymyNs=;
 b=YAvl9NCgRiM9hnnHvQGfmwKQDD4tbAyi4SAh3kyZeYCb4NZVa6FTDgUJc/avjatrx1
 570PWx7dvMm+a/BXd1yZUGgMBLt1bylDkNG7vV/ItE+dZP5EqAbmJekrdvnEF71qHjiI
 K9yQL9I8vF2kns54sNyexmYdIWk/p+v1/ea9rq8DImHp/HHjbuLSh/fUGMjKogVOKOpd
 jj6sGEPIz3j7pWabts9whWVG6863wZ9bn+MyXMmO9+v9Sa28FiiEb+Jutr7WQ8yH246i
 gADL7c1jt10xsS2MtU4Gq8BX03hDQSY8rq+QU2tY5FiLtp4qqafzoPxvNfQqPDM2+LwX
 zbog==
X-Gm-Message-State: AOJu0YyTvFYgIKf/DD+v9AaybD6YWOiUQx9TlTW8OwY4WRd3mQ7kpyfl
 hmBTB7YAfL0LhEOP10SXSjtYd38sPh3ZYbG++etv57X/8KWLeUpTtlxCQnF99zBqV/lLxKKT1Mj
 IiZYfm5yNj6Ijubmm7519SJcaUNaOVShW9sySM0ZoNOdjzGVVqyvJrTz3v2O22V9cRuXx56pSfI
 VcaO4UAUL5nsnMMcRN+7fL/w/dKT0u80OWRNJjuQ==
X-Received: by 2002:a5d:6d0f:0:b0:374:c613:7c58 with SMTP id
 ffacd0b85a97d-37d29351dd9mr1847531f8f.29.1728378240255; 
 Tue, 08 Oct 2024 02:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFO8NM3fLpGKJtkPtCO9OGVi0lp/H6syD0CoBr9DMBUyNNPJLNdpTVlevkDNeaYclQjp1rdpgg5fikrngosuY=
X-Received: by 2002:a5d:6d0f:0:b0:374:c613:7c58 with SMTP id
 ffacd0b85a97d-37d29351dd9mr1847510f8f.29.1728378239834; Tue, 08 Oct 2024
 02:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241007171717.1436982-1-pbonzini@redhat.com>
 <ZwQmDzjojjAs-dQR@redhat.com>
In-Reply-To: <ZwQmDzjojjAs-dQR@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Oct 2024 11:03:47 +0200
Message-ID: <CABgObfYPHFyBShEY2Qxdg+2yG_7aXp-cN8rdkMB8Ha8v1Qe=Ew@mail.gmail.com>
Subject: Re: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 7, 2024 at 8:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> I think that in addition to the nightly job, the mappings.yml should
> add rust toolchain, and have a 'system-fedora-rust' job, since you
> say that Fedora 40 should already satisfy the min version requirement
> without needing nightly there.
>
> Even though the mappings.yml addition will add rust to /all/ containers
> this is fine - a perhaps even a good thing - as with any dep we have, it
> shows that QEMU does not mistakenly try to enable & use a feature on a
> rust version that is too old to work - it reflects that most developer
> envs will have rustc present, even when its too old for QEMU to use.

Ok, I'll work on adding bindgen support to lcitool and then do this as
a separate submission.

(BTW the fact that Fedora 40 works wasn't really a goal of Manos's
first submission; it just happens to have new-enough packages).

Paolo


