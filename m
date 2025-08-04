Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F935C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqQX-0000nP-Kc; Mon, 04 Aug 2025 04:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uiqQU-0000k3-Rj
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uiqQS-0005wR-FN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754295606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LJ+4iCdHWofk7e13A9vDNRbDzbLrdNTpgHSEHKMAiA=;
 b=LwM1Tu0ZDPWbaSuRUScxUcSbUCZoyIEX9ozoQhR31AX1dbmUH0M83ddNOvz/2umaqkOlj2
 XpsxKVdf2pGRUH/XB4kpgZQ8VqI+mLQ0wQXOP/3W40DFEEipuSmc79b3hM3JedDCuU2n7j
 Z6Tm4g4jtlmL74skDCBS1KL8hOKN1CI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-Y30kQzkTMfyyvM0A6_5Glg-1; Mon, 04 Aug 2025 04:20:04 -0400
X-MC-Unique: Y30kQzkTMfyyvM0A6_5Glg-1
X-Mimecast-MFC-AGG-ID: Y30kQzkTMfyyvM0A6_5Glg_1754295604
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b061ad3cc0so27294241cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754295604; x=1754900404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LJ+4iCdHWofk7e13A9vDNRbDzbLrdNTpgHSEHKMAiA=;
 b=NXJFVyk11u+Q1eWmL+6eWOTwJx69k6EAXjblk8aNsKeIddsMNOTXMqfFwbRhk64tEn
 oyK/s5DwNL82NJ5sVTjy57spjuZpT34um1ngVC7lZm71jHpjR9hss4s+D5rEbxXmKhSK
 3nEHg8gNCqfHTy6J5zAiM1MXFAfYWezSXbNvxxKZMlHK6kCfchOMQ8c/eJ3a+1j3vaQy
 /D7rKRAi1y4cWyqQEMrCIss3nCOQ2X4wSsYMwlZr4hNzWswjBgFz66/x6DmkFjgiireQ
 VH/DLYCdf+WNzed7Qj6EMXmsRb8x9luHM0QyQ+ZCbYCwZ3/zGlrdzEfubEdICHFeFcDc
 TDqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx9BDC2VEOD+7wprJigDXhTGfUAakvnLK84Gyd/Ak/sBV2Bu5+3aIVc5/vAJ8BCRAZnjX0qaSlsTGU@nongnu.org
X-Gm-Message-State: AOJu0YzOw3YcD1Vb4B7UiFOr+JErFMktymSQRIvIr4jugDDIZvvIcowz
 wQ735B5VU8oiMUN+e8IpdD64caQqQy1K+4y5CaPP+0WqWN1yIlCZL1fePNLt4tlMywMscbNBqj5
 niT4JyAcp93KQTAcPk5hqlzvqdXgXcAsf6sFo6XSluntGjKN5xZTyGjWK
X-Gm-Gg: ASbGnctoYIUwWFDRZo+o5LPIwpCOifTh+1qEqEf6j0AZ1EnI3lps2dZgpCX9uAWFerz
 xYzNMOHiGtd6D4ZoF1QelkGVaMajx/BENF9ch+Gk9SDV7dvlgcdpVz6waHmyvWhUUDMTPdZrrxM
 PH5nPMX5Y5Jqi92iAQtBSaiJQh8N6L5PaS+KT4oQXyBBbzzUm8XQTpyoKVJe8f4HCzAEJ4q69S7
 tSsfAFY12j4d79m7jWc9bxq6QuvKuvvzh4c8eaVeV0onxa2iKqddwbV7ELGx+MLC8GoXy9fSc7J
 e2AHNrvDJ30EbbCjxCfRyQ/aQcU1Xvq9s2aIElNaU2aFR7pu
X-Received: by 2002:a05:622a:28e:b0:4ab:6c5a:1fd2 with SMTP id
 d75a77b69052e-4af10a4a5f2mr131316191cf.29.1754295603901; 
 Mon, 04 Aug 2025 01:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHimGOMwtJHKpziDDpLElqWhx+NDWZjJoxiswXhwoh8DTIU3sVNDQwGthLcKF/w1GWFIyTylQ==
X-Received: by 2002:a05:622a:28e:b0:4ab:6c5a:1fd2 with SMTP id
 d75a77b69052e-4af10a4a5f2mr131315901cf.29.1754295603475; 
 Mon, 04 Aug 2025 01:20:03 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cdf4831sm55092446d6.75.2025.08.04.01.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 01:20:02 -0700 (PDT)
Received: by wheatley.localdomain (Postfix, from userid 1000)
 id 219E1C5FBE25; Mon, 04 Aug 2025 10:20:01 +0200 (CEST)
Date: Mon, 4 Aug 2025 10:20:01 +0200
From: Martin Kletzander <mkletzan@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Message-ID: <aJBtMUczl93scBnN@wheatley.k8r.cz>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
 <aIzhtcg-TNZE0zH8@redhat.com> <87v7n63lld.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h7gRRAnYEI3uFD4v"
Content-Disposition: inline
In-Reply-To: <87v7n63lld.fsf@suse.de>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--h7gRRAnYEI3uFD4v
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025 at 04:09:34PM -0300, Fabiano Rosas wrote:
>Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>
>> On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
>>> From: Martin Kletzander <mkletzan@redhat.com>
>>>
>>> When running all tests the expected "killed" messages are indented
>>> differently than the actual ones, by three more spaces.  Change it so
>>> that the messages match and tests pass.
>>
>> This would break the tests on my system and CI too.
>>
>> What distro are you seeing this on ?
>>
>> I'm guessing this is a different in either valgrind or C library ?
>>
>
>It's bash, we have an open issue about it:
>
>https://gitlab.com/qemu-project/qemu/-/issues/3050
>

Ah, good to know, thanks.  That's what I suspected, but haven't thought of
checking gitlab issues.  Sorry for the noise.

--h7gRRAnYEI3uFD4v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAmiQbTEACgkQCB/CnyQX
ht2aJg/+M8rw+4dfl07LHKdE2QApog5TYVN4xo64ACM3PPc67Q6ELM9nr3PzF58V
VxY+mAtxZbIvSNcYo4aqy+KcZUZVP5Vh0J7KVxyob70t8uDEKMJ08P67oi+m+W5/
71iGnYiQD7FVJTH6Fu9Aw8kV/EfTYpajcizTt0ExYPfsz01d9j/qqV7HpMSBLRV/
xmL0jh2rCHUmmCMkjFw5dVsjDh6cf39YELJBst0IouGihl1VC11ngvrdK1NBohgB
9t5oxhKfup7hP5hS9vZccrXGNC58AMtnK66cjtdAHh6AUPjdH56CcFAa8NFaiIht
lBjctjEOJn6dLwXzbSproM75AvN3fXVQJgoFbCGHFmDZY2R1xXeTBWy2aJdyyY3P
EzzIhhAw0tS5MOmvi9NrucvSsrnHWhphRnfYFG71s4GZ4lHmCyU+OSMjLsaIlnxn
KS+yI16Be01jDWMdk8wJ8C1xpsIgzs8sLaHmF7S7Rjxwl3lnrrZbcc/LlCcBY3xn
A8vNz0vimM3I/1UHi67l2V4+MdpM+CDPOIGwryMyzAgHrtBQiJixN2sNMIdTfO3j
ehuhjE4rp2QaOlDykGgY6T2WA11pprxsA5csNzrLKEP70BLFe2y8Opa/DDdhJHgj
gdh+JC7wqdAJmEDN+O39zQuSXkH0dblOM/Zb1UGyn3+sB89mASI=
=ymYO
-----END PGP SIGNATURE-----

--h7gRRAnYEI3uFD4v--


