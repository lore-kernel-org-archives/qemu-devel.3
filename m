Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639CE81BD7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpT48-00048a-AB; Mon, 09 Feb 2026 10:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpT41-00048A-Go
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:20:38 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpT3z-0004aS-He
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:20:37 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79456d5ebf9so30667317b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770650433; cv=none;
 d=google.com; s=arc-20240605;
 b=aCtWMLT5Cu1/HH1Z94Y8Ni86bcK/fkMkdd3XPr/2smciouHYh0gF1Fn2g4LCx4hzt5
 sF+sAMinIdCemoIap/u5uIj5mnvP0gVI7GfUpj2eS4jYFzCNf657vRwEbmsfh1B6F7kU
 fiytP1TGomF5gbAjN/RcH6T4O5IM5Bqv/S70Bi55dKYWg4TLOTMU3FEYhlE9jVGDUBTn
 lT5cWeB6CMNz5wgQh9HDC6XKEmCwjZvVI3lso4+Ox/XYFhjhTQX3KNB9PLDCwzkpaCAe
 b40lcbznLlvDNHwjr4bpzqR+3D8kJIV/FJyEf46JnUh1hbn7ppElK2CF+/CucrAtzofE
 lwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3LkCFWFmHlt6KdVjr47JjGdqHnMFJ13CfffcYPYIxi4=;
 fh=AQP3f8eEnzqnxmPRZf5N3uYqKebgsT9ZWiEBDonE6VM=;
 b=J42MG5yzQKY3HiZ4EuYqcnFfsQkHGwjsJ/TyHRWQ1BUnWFpQ+wVe/WnsyaVogcQeiE
 n3QkJNDT+IlWUYmckFjMvZ3IhFn46G8uqGxRFNfUNgMP5Ju/oyW6Mj5RunrK3SDCPXfW
 KfVft5J9qhgnp0VTkDrj/4kO2m4ScqajnKheUWxOsZ7vH7Dwez+zzcyf07NvMlLVgcaG
 vlbEDSpWDV+IU0q/oGbMsUK2tWSBtu7syoTjt5w9GwjdA53tftwq8xuX2Ur6f6hpxbyQ
 ZmKEnLsw5Tjyk5Df5ZjrwdX7ZDCd4Po+IcQ6d8H1v5NwwgxjcnTEvDHGTTP2LQxDZ80Z
 LCzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770650433; x=1771255233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LkCFWFmHlt6KdVjr47JjGdqHnMFJ13CfffcYPYIxi4=;
 b=TlpwnxgX5HFZ762fSFVeNkVCRle+8Bbz6/ncCBYWj/T7zS/Uwha0q8zBvd5se6iaiU
 QogHj3Xk1L2awSW1285fdDY8nwI8JHboBMe2LHp9jpgH4YfJA/AftJJOigd9iAr4CG3m
 7IwqViqLulsB7S5V7Z4l0oJ/3Ok2cgcsTm3YFAY4KuhNY1bOauDiCsmBfxbY7ARUpffJ
 PG7jBWnmTGpLmOi0y/XCwblvznGxdn0WVD5wZ5TpJM+s51GegZMjTm1Uc+JlHVRGOqHR
 lqi6/EX7PnMhP7KZZ3hYcI4WEiPAfigZg7U7I8amJD12Lhln65yWY7vFyNG6I2FUlHae
 2qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770650433; x=1771255233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LkCFWFmHlt6KdVjr47JjGdqHnMFJ13CfffcYPYIxi4=;
 b=rj0eP2VFD13eGM+fEbivIyn26oK96FovD8MJTyjEj38cLL0KlS5mFJmEY89y3YUDog
 KgGYS5GSs+NREcvvvm90CfyYnJ58aqPWrjlW/V3A9C0vqP2lTZ31vHQNlI7nKcYPS7Mz
 bnZgZtrpaoigYdnBs+WphSV/41JhKNck+AYHkNc7EeiGso72nFhwzVFZ1Erh8dfijmat
 9v/vKX1W3EXqQFUj+V7JM/QVoJuhSMsiAlQ5u3cI19KqvbzbGl6/mGIftrl/UTIv1swT
 tePTEpAGh9IhZxN36h2ifk5XFL5DQazJPPhEfyt2jQa1n6rvSvNUUf0u274DzCrCyjRp
 v4mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUTbsAhV2AZF06tPd/l20Qc6rhP6h1G1/1SxO1qbxmFohbwUjUaJRy6q9cMIYvEBeFXWciAFfN5PR@nongnu.org
X-Gm-Message-State: AOJu0YySdMJr4o/BPDWU0ZeshZnEtHXj6halQIQ5UtA9PVepJrJj9khu
 bljnB64Yn5qPoD4UbxWqCQ1uLTSZ6FsnzaNCtQq4OtOpotsGMVm8vLsOuCkYkRFiYh1CGIjLeU0
 5ygpgwmtuRIYLqMAXesUT+Z1n33qs8NkYbopmMBK8Ug==
X-Gm-Gg: AZuq6aJjH9tXkBih2Rflrp+LHLWrBegCsmMybcwEoqPVd0v2vzaKgqHm17T6J+yeAIN
 +tYzY1DaVNStZn5MJf6oKVGoXTKuHoNbjcnjPg9dPT+/6ORPFXQb3xOtPJAC1dtshSCZKW2uWmT
 zTh4eQ/y+Zfc+okB0L0SDJYwXOqaaEDaJjOLKz0HAk5kopK0YXFd2Sf379cnvb78dBj3vIZNe1D
 Hvdo7iUmhsGyoFgQWRX+tjfttYY7yRdALaequ9IMG+EAl9bklQtvQ2yID7hqPng7gZKK6/IjJKN
 +pMkioVJB4WQU4T+2AqJksYtCEGL8M2JalE9BahMvyJdCqHOfFZ1ZIc=
X-Received: by 2002:a05:690c:f87:b0:796:3edd:7c2f with SMTP id
 00721157ae682-7963edd7da0mr38220827b3.13.1770650433263; Mon, 09 Feb 2026
 07:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-3-eric.auger@redhat.com>
 <87bjhyymx6.fsf@draig.linaro.org>
In-Reply-To: <87bjhyymx6.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Feb 2026 15:20:21 +0000
X-Gm-Features: AZwV_QiI-nohCUsxdl2IjZbycDubdZzkq2ewzyPIMEp9Ue3lsMW6mIvasdDobz0
Message-ID: <CAFEAcA-q8zCFkXuYs1vWcEMuSmha4kVsX3hoUermzh3DqYHy2Q@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] target/arm/machine: Improve traces on register
 mismatch during migration
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com, 
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 9 Feb 2026 at 15:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Eric Auger <eric.auger@redhat.com> writes:

> > +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
> > +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES=
];
> > +    int32_t cpreg_vmstate_missing_indexes_array_len;
> > +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMAL=
IES];
> > +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
> > +
>
> This seems a bit old school when we have GArray.

> > +    int arraylen =3D cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_=
ANOMALIES;
> >
> > +    cpu->cpreg_vmstate_indexes =3D g_renew(uint64_t, cpu->cpreg_vmstat=
e_indexes,
> > +                                         arraylen);
> > +    cpu->cpreg_vmstate_values =3D g_renew(uint64_t, cpu->cpreg_vmstate=
_values,
> > +                                        arraylen);
> > +    cpu->cpreg_vmstate_array_len =3D arraylen;
>
> I wonder if these would be candidates for fixing up as well.

These ones are the types they are because they need to match
what VMSTATE_VARRAY_INT32() expects -- these are the data
that goes out on the migration stream.

-- PMM

