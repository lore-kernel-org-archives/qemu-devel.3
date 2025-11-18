Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC052CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFi3-0007mx-FX; Tue, 18 Nov 2025 02:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLFhy-0007i3-0Q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLFhp-0002I9-W7
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763449247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IahtJlzur2A22/iciWbX6Ex1pNbrlk7ZZjXbszgm5WY=;
 b=Bea0fFakfCp2jlPkDnAGj96SK0hPRotwvh6bvO0eLnVO/+x7QAYTpXpo3E4dWgBUeHRvl0
 y5dji88Y98YAk9pJ4MJNn0MvIyUmoxOoUP52sUoTewKSO+tF9cVynuY+n3abofuPrRHcXC
 nE8IT8jnlX86uOmBHSgV64YP036jeQE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-JBNE8cJJOXGhNgv3KzC04w-1; Tue, 18 Nov 2025 02:00:44 -0500
X-MC-Unique: JBNE8cJJOXGhNgv3KzC04w-1
X-Mimecast-MFC-AGG-ID: JBNE8cJJOXGhNgv3KzC04w_1763449242
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429cbed2b8fso2109719f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763449242; x=1764054042; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IahtJlzur2A22/iciWbX6Ex1pNbrlk7ZZjXbszgm5WY=;
 b=aQJBFkbAZbm1LjVAMMZMtqjCc6qdmoKBP8n74MV9v0AeX0m//FAK7esMY8NzliWLEn
 2lHnazckRv+hv0W5PAu0GrGMMMg9aOvNoI+A8YxLkNt7LDKDv6gK6ipal6rQFNM/N1id
 FPBefDRMXxngQwwQyok8bU4yH/spQY558afIAvhBx0vHL4oMud35J0zCcivQgyDRtv2F
 PgToH/1NhmbIgZPCdV+mJVrviLhoEGOlVB7FOZ+I3HiTVAeReYQrLf7WzeTSsn9Ia0Ma
 09iNe4tbTCV5G/KdGVqiDCfCS8XXedcgQU/n1FoogHviAQma178gsrL+GcKhEBSsJ/Rb
 gOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763449242; x=1764054042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IahtJlzur2A22/iciWbX6Ex1pNbrlk7ZZjXbszgm5WY=;
 b=g0fWXnSAbKadfTYcVyjQmAwByO1thlX1iLVadqOlXwO/FElaCQxRc2Es5TpdOrEi5D
 jtk5rQv7SrNRVQuLyjZZ8nvP2Yei4QxJOoUfcDpcjw8xvxgz1YwBzGopojwwnx1t07SY
 kbYmqo5uIkGY2c/T/IY3snZs1hZ8Twcftat8T/mBHhr3wZFpQraDvKp1E9phN2kQ8Qce
 I4xRlKYvCdcs4tEfhrTGeZCSMPhkeRPmH+3N014lJ2ajfsJivxqjdB/m6NC6rJ32CNuh
 vZdt5PlC7oHK4QOj4msGdaI7ZyCvndnmVWhgbFxUi5UiBsWBkLEA2ebS5ZGyx7XQo0JN
 pgSw==
X-Gm-Message-State: AOJu0YxG1d0j9S/32+1zOLJVTlJpzUUnAqm5tX7hhc5O0P0j/XPKOg71
 BfsPMcsqbAiDP8HH56bNgRFGLbCNtrOp0IzXZdZwbQ6mk50Gsf267cVDwagkOLMPo8jUw7X7/Dz
 tprboYeWimo5JfZb8W7SfqnFfeou1F3P8kR1TsAoPn8ERFwPjQpUjIojTMrQ0/VX3wlwp8xu4Ie
 DhsIZBsGs3db8qcX7b+MvmDood3wq7v/s=
X-Gm-Gg: ASbGnctLnCvHVX0GhUUVSLl2tgmj4Pk8An2j0SDD5y2ORgFdmf4WPtUwdls4kYUD67O
 uvCjxR+glaJi60iB/oiJuMcrz+vxIB3lCmVtjb1ZkP/2SlGFYeVcPi+nDiC7iFn1g0CrrJIPOSP
 1QjCGfb0a3NiME+DLzE5EmQEveuiwaVIwPRrdNb6NV60pjJ3KITSCSeHFSHMDrcXb5LbSy+2Kv6
 FfgdR/uAKsZPuT9h9/VJ9gigYR3b+qL0m7kzozOTLwcUW8qMjUXlG34w8iS0PYVb9/YhT4=
X-Received: by 2002:a05:6000:1842:b0:42b:55f3:6196 with SMTP id
 ffacd0b85a97d-42b5932342emr13124339f8f.4.1763449242367; 
 Mon, 17 Nov 2025 23:00:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqUQDXfj7ZqQ94t7tCcn0lkgdZZIPlJC39pz60cGDLogyA0/3GH2vPPhWqs9+puBDaqDX5nZA+L/bycnWIxPQ=
X-Received: by 2002:a05:6000:1842:b0:42b:55f3:6196 with SMTP id
 ffacd0b85a97d-42b5932342emr13124291f8f.4.1763449241737; Mon, 17 Nov 2025
 23:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20251117163107.372393-1-pbonzini@redhat.com>
 <87bjl0l74x.fsf@draig.linaro.org>
In-Reply-To: <87bjl0l74x.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 08:00:00 +0100
X-Gm-Features: AWmQ_bkivR1i9V9YEmg2Od3khLJr9C1b5nOanG7yneuszJU4fPoMhcdx7xRJSeA
Message-ID: <CABgObfaG9uLMyLvquGMDKEfzrhHfkzE+HLhLWUYMqD14UpHJdQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mtest2make: clean up and make dependencies more
 precise
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 17, 2025 at 9:46=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > You probably have never thought much about scripts/mtest2make.py, and i=
n
> > fact it has seen only a hendful of commits in the last few years.
> > The idea is pretty simple: gather the list of testsuites and their
> > dependencies, and turn a "make check-*" invocation into calling "ninja"
> > first and "meson test" second.  On top of that, it magically turns
> > SPEED=3Dthorough into invoking up to three suites named XYZ, XYZ-slow
> > and XYZ-thorough.
>
> Hmm this seemed to run too many tests:
>
>   make -j33 -k  -C /home/alex/lsrc/qemu.git/builds/all check-func-aarch64=
-thorough

oh, I never thought of doing that (as opposed to SPEED=3Dthorough).  I
will fix it and post v2.

Paolo


