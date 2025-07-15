Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F92C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubilv-0007aB-AM; Tue, 15 Jul 2025 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1ubiKY-00026k-Bd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1ubiKW-0006cT-2z
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752596188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//ZWEb+OCGbk6WWVyBpqReZhP4Q2lKMRmd+WCS2Ppkw=;
 b=A7pcDq2LJLnJ40e4cvVyLMaTRspqmHB4V0BlU7XMcY/RUeFCu3dpxIaO0A93axenBnnA/R
 tl2QYwSWF5ZBWUdRQjyuOBvdG4mmVOPXj7XicQbeNzM8+q1BhB6LeB9SV0eOVFo/MoGx0I
 aMiq+dlM1CWst7TRK0K0IatzbVZmyP4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-5484Nbg_MRGzUKdBSmKQJA-1; Tue, 15 Jul 2025 12:16:27 -0400
X-MC-Unique: 5484Nbg_MRGzUKdBSmKQJA-1
X-Mimecast-MFC-AGG-ID: 5484Nbg_MRGzUKdBSmKQJA_1752596186
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ab701d5317so57131041cf.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596186; x=1753200986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=//ZWEb+OCGbk6WWVyBpqReZhP4Q2lKMRmd+WCS2Ppkw=;
 b=YNwWQCoZ7hdq80M0NXvya9wq+lThaQ9lX85NQGttNoLJJEQGPLwfpGf+CkSjfd4Pjg
 SqLzxGKlv/H1VUDN+Zz41egYJyMBp+axaQRGPYwb87HV7lpPK7j+UPsW2QmEoO5k7VjF
 XESMdqjTyj3gCvH1JGvaLXnmoxF91ebM/FVtsjdy99IrR45036bfYRDFs4v1j93PPq8E
 fHk1A9qrz3nrTIzsLPUSmQMtUhRwfU75/rW/UZEQMsIgOCZo4DFcEc/X/aag96TD6MmQ
 YjDzQ+rsuVPtu2jzub8vt48aVQXDJa+VfDXXa0jnSwkom+1Df+ERG+ZkcIMqBH4mj5a2
 xPdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03e4E3iqvVlN0GmrEO5FaAtx4kzEjd8f8PkuGs54jHmOyq5xQh/NHWiQjzcNaQyzfSSfkOJat4P9d@nongnu.org
X-Gm-Message-State: AOJu0Ywx29I8aJOxHB5rOGDQduiZnFMpMxl8yrpbTHHbICXDlNHLUIbb
 c1S71wSYIiBJ+9DuIswCXX0i+K+okcpy2hPiibQyem40tNxxh/CRMpiUbZfO7YM8cbGQsXBv4fT
 7g1mVnfNZzLbxLOHLv5vnjObDp14xLjtLsrp12zhSIAvjRVpNgzAT4DQh9n5Ouy/ZTerudvmmvL
 SJRkChM3fm5LI0oxUtcHhNq2kXFL4e7E8=
X-Gm-Gg: ASbGncsJFECr/el8yhHRq/zsA/SvV9oif5/VdxhoZwkbmMZAYlkPYwUKaTU2XR3tXAJ
 ORqzd1IpuS1G7FemwcOfmNOVpS4DlNSuqmF2KoxtrzmbT6mjU7qced2WBRf/WZCjp2K3YcFkNoS
 Kl7Uyo1w2tkB/X8qSk5jl9jA==
X-Received: by 2002:ac8:5d16:0:b0:4ab:8b77:65ce with SMTP id
 d75a77b69052e-4ab90abae96mr587391cf.23.1752596186471; 
 Tue, 15 Jul 2025 09:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJcsd0q6abnb3JCzug3oD/emTfvG/yKqDg86GUmk23nOaN91iQHW++aC4StOu6zLlBFd2ICQQu3clbBtVLDJI=
X-Received: by 2002:ac8:5d16:0:b0:4ab:8b77:65ce with SMTP id
 d75a77b69052e-4ab90abae96mr587061cf.23.1752596186064; Tue, 15 Jul 2025
 09:16:26 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 09:16:24 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 09:16:24 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com> <aHZ7rpYFMWai-7RL@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aHZ7rpYFMWai-7RL@redhat.com>
Date: Tue, 15 Jul 2025 09:16:24 -0700
X-Gm-Features: Ac12FXwPblRStPVaHckJJW6xM_jkqDJyoXBQiFy_MpSK9wMWOxv5H2TE8fe62Uk
Message-ID: <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 05:02:54PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jul 15, 2025 at 05:44:25PM +0200, Cornelia Huck wrote:
> > Hmm. So
> > - request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* space)
> > - restructure to have two devices base off the same core functionality
> > - teach guest operating systems about the new device
> > - teach management software like libvirt about the new device
> >
> > Not sure how fast we can get an ID (or even how to go about it.) The
> > second step should be reasonably easy. The third step is the most
> > complex one, but at least teaching Linux should hopefully be easy
> > enough, and existing guest operating systems could continue to use the
> > existing device. The last step is probably not that bad.
> >
> > I can start down that path, if we have some consensus that this is the
> > right way to handle this.
> >
> > I'd still argue that patch 1 should be applied regardless :)
>
> This sounds like a hell of alot of busy work to fix a problem that, IIUC,
> does not actually exist from a functional POV - it is merely a perception
> issue that people might be put off by the "Intel 6300ESB" names.
>
> IMHO a better use of time is to expand documentation to clarify this is
> just fine for all PCI architectures, and change nothing in either QEMU
> or guest kernels.

Agreed that it's not the most high-reward endeavor, but IIRC users
were getting genuinely confused and annoyed by the string "Intel"
showing up in their aarch64 guests.

You can point them to documentation over and over again, or you can
work to prevent the confusion/annoyance from showing up in the first
place. Which of the two approaches is a better use of anyone's time
is up for debate.

I for one am grateful that someone put the time in all those years
ago and, as a result, PCI and USB controllers don't suffer from the
problem today. Ultimately it's up to Connie though.

--=20
Andrea Bolognani / Red Hat / Virtualization


