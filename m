Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0DC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIn5-0006Ne-CD; Tue, 06 May 2025 09:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIn2-0006Mj-W6
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIn0-0003Ip-U0
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTFWcdPxsqLHY4LQYromqXGzoSfhWUDBvEPMMnDfDO8=;
 b=DIV3gpSk4ib33yBWjMEkM5GxqIEVf04iLqE1Ioh0ayABbDW/nu3ddjhAAOFwV/kLOuceRO
 d3ncHzu69vqCsVdlGJnx4hhcvM1JyVN5n3J2PvuhgeCQSmXgQ1+gTPX1b/nCsIZd5Oi5vr
 IE2kcPWvSTO/3u+dpjvQ1R5uTJ+AdMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-zMiDoMwkP7ibFvZF5wBRyQ-1; Tue, 06 May 2025 09:56:48 -0400
X-MC-Unique: zMiDoMwkP7ibFvZF5wBRyQ-1
X-Mimecast-MFC-AGG-ID: zMiDoMwkP7ibFvZF5wBRyQ_1746539807
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so41860895e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746539807; x=1747144607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTFWcdPxsqLHY4LQYromqXGzoSfhWUDBvEPMMnDfDO8=;
 b=dcdf9Nv06VKSry1qwFss+xIF4qTMAPJVzJF/1e/r0KaDJe0cDpeSAP99wibnT2S/yt
 uyMihvjRyOX9y/kwblNk/H51kZNR/7tjrNjtcxDUlq64TLoEP7677GcjHVbYQYzJVM7F
 isJGAH6iTVrcarBsCNAoJltnG2DDDRjbCoVIE+sWpLj77NpmYXR15bbd2t3y+GZqNfwQ
 QuGGXXxpm813tysQ1xpCIesJt7iVJnC5+tWe2rmq+NmIQIRF+agCryMrSxpjoGN1wy0z
 E6KxElLZVCI7E9uj/Fl8YOCZi0ca7VcrFnkYHqE+tnJO9RSi7TrYCdYjd7UmTmYXgf2S
 +nBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj75Ca7eRUmzA0gGzr4XuvOyEYQa6DLxW6SM/oQ6DiJC6hgw0JI2k8sTgsYTjw5llYhuM8BYQaqdZv@nongnu.org
X-Gm-Message-State: AOJu0YwjMGc3h6XKxz4wFg+WshvmdQ0VGbsGFSpczP5jrSwMIM1G1vUe
 FqIq7At35iMlcMV5W8iW6pV+MtGm8m4PPKpeXpBFSRg8XAWJfSJYFxhRG0zG3Edy2ul0h5AOmoP
 IdJQc25NzCkZWM/mB3bsXSTBh4mi7T/e8V+0qVWWFGUY8j7MZiBOBmhG1Hc5E4aVFHPdINJioB/
 H/R6gcoLocwNSKDOMO8fqwetLAiY8=
X-Gm-Gg: ASbGncsGv55iJ7Ka3MT7O7K0OxVwEOwavhEy3YPYeufxzvX8DiRz12Tjq6JYtacd5XF
 PQc58AwUq/yP3fpTIfbePduGCIAsg6k78hKby2u+6Bj89BW/Bj9MZNQCzyOLHtYhqcfUd
X-Received: by 2002:a05:6000:144f:b0:3a0:860f:d66e with SMTP id
 ffacd0b85a97d-3a09fd9645bmr10040822f8f.28.1746539807420; 
 Tue, 06 May 2025 06:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+nCPeAimjP7YCIwUKb1dU6yNJUfgrHX7pcXV5y+KSvYkhCTvOHoKE7SLC1N1gHasX+N9pya/cppRCoT4nPl8=
X-Received: by 2002:a05:6000:144f:b0:3a0:860f:d66e with SMTP id
 ffacd0b85a97d-3a09fd9645bmr10040794f8f.28.1746539807080; Tue, 06 May 2025
 06:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
 <875ximdj2i.fsf@pond.sub.org>
 <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
In-Reply-To: <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 15:56:35 +0200
X-Gm-Features: ATxdqUGFVtqxY_fhi75AWFYmWn2K8IeaJgF2ycUzXhX3SicEmmqI6BjX_MZlGAM
Message-ID: <CABgObfYhi4mRnsttEJnnOhBmwHGBgHtUJw6FKxwsp+KyMSSoAg@mail.gmail.com>
Subject: Re: [PATCH] Drop support for Python 3.8
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 6, 2025 at 12:49=E2=80=AFAM John Snow <jsnow@redhat.com> wrote:
> If there are no objections to moving to 3.9 as the minimum, I certainly d=
on't mind. Go right ahead and I'll clean up afterwards as part of my "delin=
t qapi" series in which I'd like to fix quite a few other things that are c=
urrently wonky. In fact, moving to 3.9 as a minimum might make all of that =
much easier for me and allow deeper cleanings.

Out of curiosity what is it that you'd like from 3.9? Based on
https://docs.python.org/3/whatsnew/3.9.html it strikes me as a small
release (it has types such as list[str], but then one might as well
wait for 3.10's union types).


