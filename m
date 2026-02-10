Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB536EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkJQ-0002HO-TE; Tue, 10 Feb 2026 04:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpkJP-0002Ec-1T
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpkJM-0006HR-V5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770716736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYR4ACTZxw6c3AoV00aOWFHLlNH8Ypgbc/kjhLStVO0=;
 b=LFi2OWNMfIoJ5EPZRx0cn168j8pswRy23S4BR2D72Q+bwvugPqbaixKUHwEC25UDAZMWEn
 SiInijgHVb+POVgQ9VyY9Ft0KXVV8zI3HjAEkYhw8rWbsanNeT/UfW2GhPDhjQ1XiU3wlb
 Rk4iw2XKrN/CyQCvoIZUCLbg/mfuzWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-PNlAzuDnOW2Majol5RWMdw-1; Tue, 10 Feb 2026 04:45:34 -0500
X-MC-Unique: PNlAzuDnOW2Majol5RWMdw-1
X-Mimecast-MFC-AGG-ID: PNlAzuDnOW2Majol5RWMdw_1770716733
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4377274682fso383616f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716733; cv=none;
 d=google.com; s=arc-20240605;
 b=SqLwbUwvMyFrG+bC3NUocGO5+8Cp7P0W86kPQEKff42zrX1LnEv6OK1v8sjtrUfyIw
 Nyaj3hfCZUJSeD17+ReK6kj+ZMQjcYjr5tMkI6ChBPq+pEYe0uxAP87UuuuNV1JCHF7I
 L7/hmSsirrOmVH8jzSLihj5b4oOpJ4ex95ZNk0B4m3G2HowtBCdINaYAxGQSrXmCYi5b
 bqOKWmg1cvfStedwiU9vYcBNn1Rl6pJ2CBTTy2SzFlGtnzvz/MkNNz9tgf+u1kdtkbRJ
 I8YYpayjqQFE92W8R/Q/xHjTOy3Gir5C1HDijhgEkBR2vETCU/6CQKtPbtm5ZhhviBZq
 jhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yYR4ACTZxw6c3AoV00aOWFHLlNH8Ypgbc/kjhLStVO0=;
 fh=iCHo9JwxOgdLXVP3ccjoUbSsXbgp3QFJWlZpgq6e8HI=;
 b=lE86TTSofKEKUkXGLuDsweS1WwpNzo1m6hx9yCKk3/mKLVqCFoIEp/E3Qf3H6GXERi
 p2hRn0Ey8qjqT7pZnWppMewUDstC+XQiDnE5LAX57eHkNHwWUICYDoE2PrzRljylZndj
 16GhcrKVkS9xowbNpumXSD2eVh/NOfmNU57u9d3veNGPHIXlT2dnbhzV/GM319D7NX/y
 GZ9a11KppOfKqfM7kM8678xx7vDkYoBmOfIcK2uoKbR+OqHcEHptBiWE2ofGOgvVuw/U
 MNZCYsf93rCdTOjiJ0jqXOeexURE89dy8Uu4vzhfFEn83/vMTaF7cbTN0AVGXi5sJLAt
 8rLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770716733; x=1771321533; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYR4ACTZxw6c3AoV00aOWFHLlNH8Ypgbc/kjhLStVO0=;
 b=gGS7fR7eDP96yemF9I0NTsVa3YTGE/r1jSclab3qYVYZHSXtrOh656c2TiPIU59zj9
 2wZOyCc/LwnektYFslqx9Uy/jrJIYWKg8IB8n1J2cJYIjveME57rd0tNbl5pFO4wJasZ
 nLVf5ZbF2m5IdE0HOC3YD5ZC4rMlyb0EDQP6q0CUzwB/NB6X/CKDbEFFme7mmiWrsQyY
 65Jgh68cXfugKUmugkVv17pnyqNupNIRQ1YxrjEl2M6DTmgGY0cWod1UigCSCTsz6ela
 1MkjaGRviYpU1i8QSIJgWpQ/UhQJ2BR0Xe4G9CHcU+tgxUlNNLGbSwSB65CU2HGaXgN9
 FC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770716733; x=1771321533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yYR4ACTZxw6c3AoV00aOWFHLlNH8Ypgbc/kjhLStVO0=;
 b=O7PcLW8nWN8r/v4Lc7Ya3RnY0TeT18TlmMOS3lpN7bY9dPsNVR1Vw+51wZR20qbjlq
 rphnLdDfjexCJK4x39IAqMp9ajgOEAr6NtShBeGqFysyo3IDbT3wgLXCudaaDSVYWHfa
 cWbdl4e20VS5MST+fLzSaamwbmPgu/cKpryS48Fv8jSej2Ww9pIQ2Na+mQsgA4lVZw2Z
 snK+egKg1xP4nTDUCNyI4oN2knswYVlfhNxvhlX9w0yrgoEP40XS4kSRg3iQxqHeCv2k
 OqVIvM4FJAxE7CDOkGo1ftyrxJdDI0iq/pkXqLHgsAFdJEYQRLVztqM4kyQdIHWYZy2j
 WCtg==
X-Gm-Message-State: AOJu0Yxsk5sP26mFp/zcXWt8NspsjaVjNqApH3Ci5fYFLIgd1QtV5Nz9
 GgWjfJGc73DrHZ4gGqA40yD1DM1zzT4KOHfDxhmWUBM+L6RzLMta6OUhJnetq19qDxjRCieFiwz
 J+TMOt1pMuBU93nGGXPANV12DVccJNr8pM/72Reizk7F4UIuX8UlV8HwLrewsOGmtWH16J9TNvQ
 pQLoqX77uSZ3H3rnifxg1No3ymzaCOEd4=
X-Gm-Gg: AZuq6aJ2yyg5aYg9Nlyr47rxMdFRAA2wLchkul4Op5l7CtXWyB4ZZ67wvxZgWa6Mp2s
 xFKInuvcshxuwRxaBWPgUnMj4+tkKLc5jarjxyzIMYMIG9zGrPgLY6xS0oyb5p6XdvD3IobZFzy
 Ft/OB0bccN3zSdd4EC2X6kDseAV8QhobX/k7uUbMSgqMrKebiltNB68CVrCnJqDbmoVGzfr78J3
 Kpxk4OTSPmvWx2ZlhYvtJhW2ifkt4s0EE/vmHIOJH7i7zsfYJ7KZLaNgteg2SIcdlQxfMFOtobc
 D5iAHw==
X-Received: by 2002:a05:6000:22c4:b0:435:95ce:84cd with SMTP id
 ffacd0b85a97d-4362937e1bemr24098585f8f.54.1770716733392; 
 Tue, 10 Feb 2026 01:45:33 -0800 (PST)
X-Received: by 2002:a05:6000:22c4:b0:435:95ce:84cd with SMTP id
 ffacd0b85a97d-4362937e1bemr24098548f8f.54.1770716733015; Tue, 10 Feb 2026
 01:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20260202091753.28459-1-pbonzini@redhat.com>
 <9d0467df-a704-4058-be5e-68df9873a9b5@tls.msk.ru>
In-Reply-To: <9d0467df-a704-4058-be5e-68df9873a9b5@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Feb 2026 10:45:21 +0100
X-Gm-Features: AZwV_QjoeKSKUBBXVOZoEbmb87AhK6zuDQwjCIZV3or9uVrgjm6AjfjbfxzNUDg
Message-ID: <CABgObfZL4inrCbGAMBmAETvvhE74FJ01-B6gvqWO+ii4822BFw@mail.gmail.com>
Subject: Re: [PATCH] Revert "tcg/user: do not set exit_request gratuitously"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Andreas Schwab <schwab@suse.de>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 10, 2026 at 10:44=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
> On 2/2/26 12:17, Paolo Bonzini wrote:
> I'm picking this one up for stable-10.2.x
> (where the original commit is).
>
> Please let me know if I shouldn't.

Yes, that's good.

Paolo


