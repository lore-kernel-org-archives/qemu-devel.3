Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B139BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV95-0003Zw-O9; Mon, 12 May 2025 11:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEV91-0003Wq-6D
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEV8z-0006cE-Ds
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV73wcNQFlOn9H+VGZko9zPxOzSyXvcFGEr4s16QJzM=;
 b=f+Q07vVxVQbJF9CwKJU9g+27dl6Jm+i5HvceTYYEEYJupspJoThtZXMQpbrlJ0I2F+036A
 J3l7EuGPIu5SYkwyPEsSCN+jUjHNe8wWvgCYtBDUIoj/Un6+qY9TAWBoxR+W83Lhg4axhC
 RG1BNuhDnuNIesqtBvL6XeSMatpJjM0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-XV6fso3TNyqnK3os5hdLxg-1; Mon, 12 May 2025 11:32:36 -0400
X-MC-Unique: XV6fso3TNyqnK3os5hdLxg-1
X-Mimecast-MFC-AGG-ID: XV6fso3TNyqnK3os5hdLxg_1747063955
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2c72e6e51ceso1447923fac.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747063953; x=1747668753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TV73wcNQFlOn9H+VGZko9zPxOzSyXvcFGEr4s16QJzM=;
 b=wIUY77+1RdiSn9Hj2fDnlC8pEYW8cz8TfKZYi38jw1ZQXBCCfRuxCwGzUo1KJaA03n
 ebtnv4VcdnNQpnrMxc1XgsDaB2U+DhefI+EuTeuri5uA+RYQ83I1WQQvDUxhaIq5yn2F
 8j88HE6W/CqO1HClfoxxvbrpyNlpQ8coK6KWLl0BTILsJLBs0Fq28pyzlxAoSMOAb9N4
 +kpBwJYYgthxKi609nxZA5K76h8NcPuB44+QDV2XNxrHOqdYspRLythh7Ho7KLvDDS3e
 FK9O5cEIk++oWZ6KwYn7lS59QCJKqQFgPZTx6hXuzQOHCpcmbqsc5z3knyHZPEn+BX29
 E5pg==
X-Gm-Message-State: AOJu0YwS/J8KfgasZYEivpNVBehiM6Qd92WOiTgtKFIkIvhvTstkNDD9
 pmLXi8Rc6m/nX9mlTl0NX6zxTo6PXiOJecgUoRVB73nXjqLmrgdbJ1CIR+7tykfPiOe94fm2OA9
 DpJRV4XcOQGvU1rWHKHRxRyQYPKM5T90Yc5zoBgIFXio9NRAScmswwjRU7jrHCHbaFlXZMPhr8I
 LVwV+w7gmeQDMEf7JrrVgkf+Yczh+FTZOUq7/3gw==
X-Gm-Gg: ASbGncu5Vtrp9Pxapg+Is7bD8d3jrXmb0TduyGffuZKY6nTz8trmqayr8H5wmekn2FG
 wSuqiva6dsJepWjpk6SrkmZVxGyiJaCga0TDuTc1EruMSI2dpB+MnoUlXzxa0yuVsYXsF
X-Received: by 2002:a05:6870:b01f:b0:2c2:b9cc:afb8 with SMTP id
 586e51a60fabf-2dba420dca0mr6813476fac.7.1747063952494; 
 Mon, 12 May 2025 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUne/1srv24pUyqTUsq1t4n9Ymxk5oJ+OrDmlVNSdtiO/2Ad704sGNZSZ7QOmbpmrqjw4Nj7Pqnr03eyNL5Cg=
X-Received: by 2002:a17:90b:4fd2:b0:30a:3e8e:492c with SMTP id
 98e67ed59e1d1-30c3d650661mr19906857a91.32.1747063941182; Mon, 12 May 2025
 08:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
 <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
 <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
 <CABC6E67-C4C7-481F-BB96-BF60957D7A84@gmail.com>
In-Reply-To: <CABC6E67-C4C7-481F-BB96-BF60957D7A84@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 May 2025 17:32:08 +0200
X-Gm-Features: AX0GCFtdPQrLMnjbXmXY9PO9w_MYLjuvu-yvzQ4zP88fiRLBQeslotB6kcCsMEU
Message-ID: <CABgObfbD-yHee4TXKqQ2gw7N8dtuB1wKqPLD5jLKXtJ8hx2xSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust/qemu-api: Add initial logging support based on C
 API
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, now that GSoC selection is over I'm back. Sorry for the delay;
Tanish Desai will work mostly on tracing, so logging can remain yours.

On Tue, Apr 8, 2025 at 10:59=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:
> >Currently the #defines contain some holes for "private" mask bits. Turni=
ng these into an
> >enum without exposing all publicly, and changing the type of qemu_loglev=
el for
> >consistency, would result in undefined behavior. Or do you suggest to co=
nvert just
> >the public #defines into an enum to expose them to Rust, and keep the re=
st of
> >the C API including the type of qemu_loglevel as is?

Yes, only in Rust.

> >There are surely several tradeoffs and/or cleanups possible here, but th=
at's way beyond for
> >what I wanted to achieve -- which is closing a gap between C and Rust. M=
y main goal is just
> >to get my feet wet with Rust.

I understand, however there is no point in defining an API and then changin=
g it.

So we need to answer the questions I wrote a few messages ago, namely:

- the mapping the LOG_* constants into Rust (e.g. whether to keep the
uppercase SNAKE_CASE or switch to something like Log::GuestError).

- whether to keep the "qemu" prefix for the API (personal opinion: no)

I agree with not having macros such as log_guest_error! for now, or
not wrapping functions like qemu_log_trylock/qemu_log_unlock that
would be implemented as RAII (i.e. returning a "guard" object) in
Rust.

> >>Also, while this is good for now, later on we probably want to reimplem=
ent logging at a lower level via the std::fmt::Write trait.  But that's jus=
t for efficiency and your macro is indeed good enough to define what the AP=
I would look like.
> >
> >Can we live with an easy solution then for now? As you suggest below, fu=
rther abstractions like log_guest_error! can be built on top which further =
insulates client code from implementation details such as the representatio=
n of the mask bits.

Yes, of course.

Paolo


