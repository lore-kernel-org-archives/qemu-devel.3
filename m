Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB205EFCD99
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYbv-0004Uv-9x; Mon, 09 Mar 2026 07:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzYbe-0004SY-FF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzYbc-0005Lf-K2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773055019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMRWNj22r8FDh1jIngNjeJbyrmVNdMjDt/5/9aMrxfM=;
 b=dB2bk60D1tiYuxISHAMchadby6US9wSo0ZZGxWrjnRhm9kB8JUdO1jt0KJoX9gL1j/KXi5
 dx5iCjfiBYIuLVdbR9ahrSCI4CvH1nilhpcbXynyMLFEMAcDeu7fJA9ShUsRIHt/SbLkrZ
 hid+jDgbhX6VqNGr9RG+WG53Th9rjUo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Ux3GMVy3P1aV9yZFPVgH-Q-1; Mon, 09 Mar 2026 07:16:58 -0400
X-MC-Unique: Ux3GMVy3P1aV9yZFPVgH-Q-1
X-Mimecast-MFC-AGG-ID: Ux3GMVy3P1aV9yZFPVgH-Q_1773055017
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439ca4b3d0bso4103960f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 04:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773055017; cv=none;
 d=google.com; s=arc-20240605;
 b=UfLah+lNIPQw25E35rm8YttBWSkfVVyaI2UaT802yZoIhk9pP9bDZhpe9Q6ybIT52G
 N9ONZEUHNZhCANkq5dcpaC7m5tklwfeV8YidQGMGYKMP4Q+GOyRcOWiZIy2hXxvr7Uu7
 /n8QPwZL3qvPqQcHOfY7cJtMJuLWm0s74Wrn2QK1wnGntmr+Kh8TkL/q167JS0Zu+5/O
 u5vmFRkaZokV2G+mSYYOmWEDB/ncIZQfBjSDB2Td5OzWka1lXjDd1zU+pXe8GSV6snV8
 z2qXbJRs1I7ijFZDQWZUjEukxIybtoFoSpJxyIqpDXw2mZtCAabQjF1GeU6szzIiB7Yu
 772Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tMRWNj22r8FDh1jIngNjeJbyrmVNdMjDt/5/9aMrxfM=;
 fh=02l3VUujW5ciAbJioSEeWeTL7NHKZJiy6j9d5JhXhiM=;
 b=VrLBFzN5Jz10rghre45cbbBKLZS0xrKxviTnXzXyxjeQorBfHwWksukUGP7nuk5CQU
 PFAGr3gntrnfICCDW62UVgOhMIOoBBMSOFk8Gep/WfIVmfOwemzpWMJz9PvfGkUcouxG
 cBvqE/c8hINWeSssIMbve1POLqFelpMHEyARI7NnJ5sywQQGUmsNATKnuNCNXbZ14lMv
 X1Kr1woodeDOJG88aXT0YKhjUkYfPlnjaLfrAq+AHSN/CNXNuk9/78dcPBO/sInd9nRj
 2gdr0AxdrLStxFCxs0rImFE94TkCpfP8DMvhDCvfcfQuRkVbWbmT2aOgCGvWd3Lx2GwF
 toAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773055017; x=1773659817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMRWNj22r8FDh1jIngNjeJbyrmVNdMjDt/5/9aMrxfM=;
 b=Dm/CyKgD4sWhmRnewx4OJ9Nt2HBcocZ9vhj0mZUTD6bco/KV3qV+iL7AsRwlxez9rj
 ynmZVlpVu/+9agQ64Tuz7SOsPYm6Fck29sC8hlVFTIj7yGo5g3OQV66pT0ZTr+iUFoKk
 c3tbFr7vDZMLx2x+4XSh4SWwDSYSuYp1ZX+Ip88L15ek2huNkLqWXS3N6gaRyCOACDNo
 3zhwH7pvTunLExUvRgIqYbE3O0TyycgDXbGuKuRhwGIsgRkmuZDAWfuOniZHxWLadxVo
 9KXay8XwJ5lVQrVXpexRaiopu1ps6B64GynsXD93ChImxgC1b+c40syReQFLjFJmkV/C
 Hlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773055017; x=1773659817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMRWNj22r8FDh1jIngNjeJbyrmVNdMjDt/5/9aMrxfM=;
 b=FEV9WenusOw9jgd1JmkzwWtBWYMf42TM0Hf7hqMV23CN8F7b2XKnulXjuxAV6pdUkq
 dUYfsXiJncuEh/X05uFg93YD13T3RGHpOW6NB7Tcx/y3NK+ybAlfbduen6ikIqaBm8Cz
 GV6hs5v13arB5H1Tel7bC6ri4ByVjDGdcgtWmm46c+EddRwgSkRhwWp+X8XYPcZWaDce
 Ah6ebQnjZvGVkXCw3AvWohwB1OShkeBhlLDEJAM/qs8phqMwNiQERecezKr8AzN+2yQd
 t0Ch5dx6cX22X2ViWqiJw6ZrOcxtnR0nZvGuH4K0vpmch4i/UrebBeITL9s1hWamHtUF
 /ChA==
X-Gm-Message-State: AOJu0Yyl6Or6G+64XAj2/XNqTMx9ojiJbn75SjSJN7KvxW2nhh4o9Td3
 ToTiYrpCZYpgU3nzdD7voNHrjQefTT9f2N0GwTPARpH2KtjbavxWfbhvGErvEJlu08gUGQLQ5CE
 i9iEuI9+1q/a0dIc9mQBJCJWwCK45NJjg10K6A8ijXdAaxfOlSTLbfgra5VLRabcLQWzS2Ci5tn
 Ce160nuXxOke0QmiLmCWepYPmAHmQ/HCc=
X-Gm-Gg: ATEYQzyWWh2LFp6LyWA9E19pxNkkVIQJ+jyuqUBNiq14LWlHiyUQ/SFTJgwV7UbdOeL
 Z1IWJOS5o+bYm+987oPqi99rGzSX1c/a+4Twu5FXsnyCfOk5eEdLUjt7mK5WQFKYSaMQomAro5m
 LFLya1hR4IVW8kRaMYio6NEgw2Tgyghjf/Br9EzL2sst1ONiVdpawOMWM7auU9o1jRB4Mydgk3e
 I0+s/Fhlf/sLreBJMj9tOCk8njon73eddBHblOLUKvbMXZLQ/PllqiOnOuA8G4zZfylMm40u6SZ
 vuOXtnY=
X-Received: by 2002:a05:6000:25c2:b0:439:b788:73a3 with SMTP id
 ffacd0b85a97d-439da552f96mr19215837f8f.49.1773055016617; 
 Mon, 09 Mar 2026 04:16:56 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:439:b788:73a3 with SMTP id
 ffacd0b85a97d-439da552f96mr19215772f8f.49.1773055016111; Mon, 09 Mar 2026
 04:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
 <20260307181856.2209-3-mohamed@unpredictable.fr>
 <CABgObfZqDHL=kkto8i5VdpO+mEOfeZ9vYSMmVnS+T4cwNekzzA@mail.gmail.com>
 <28C201EE-89A9-4454-8F8A-4FD05B38E132@unpredictable.fr>
In-Reply-To: <28C201EE-89A9-4454-8F8A-4FD05B38E132@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Mar 2026 12:16:44 +0100
X-Gm-Features: AaiRm505qiKL1t8d_eTXuEKNHBQ0bv6N8X2aTEq0gCRv7qRwzTf7bNGrRXZskKw
Message-ID: <CABgObfZX0T1VCetJkTdRv9+9pHxubL8PRA0QDvR5W3chjP+=pA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] meson.build: older macOS targeting compatibility
 with macOS 15.4 SDK
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Pedro Barbuda <pbarbuda@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 9, 2026 at 9:38=E2=80=AFAM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
> Another way would be to have the has_function have -Werror which should b=
e enough to deal with
> this case properly. Does that sound better?

Yes, if that works it's better. For 11.1 we can look into adding
-Werror to all cc.has_function() calls.

> For meson not sure whether it actually picks up the definition from the h=
eader or tries to use a dummy
> definition though from looking at https://github.com/mesonbuild/meson/blo=
b/6e67be7492d6982d2baf153387f9adbdb480d099/mesonbuild/compilers/mixins/clik=
e.py#L738
> If it picks the definition from the header, having Werror there ought to =
be enough. Otherwise, won=E2=80=99t be caught...

If you have a "#include <>" in the prefix it will pick the declaration:

        if '#include' in prefix:
            head, main =3D self._have_prototype_templ()
        else:
            head, main =3D self._no_prototype_templ()

which is also something that we can add to 11.1.

Paolo


