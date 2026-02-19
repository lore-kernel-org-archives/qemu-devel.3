Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA83E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1It-0005Ii-TZ; Thu, 19 Feb 2026 05:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1IV-0005Fk-DO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:30:18 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1IQ-00051X-5z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:30:13 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-794719afcd4so7520567b3.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497009; cv=none;
 d=google.com; s=arc-20240605;
 b=DVW0Flow9rccuDa09T8fwmi+7RM9CaNpV7jN2f89zvcW38I5I4JvpBP622X6XdfTDY
 Kv4DJodvgaq9f4pzo5OWSPXwuz3sFdleKottFJMP2kuErVtPePhVsezuin4iktK5EngK
 OK+jMsGjEDXpYdr/MYUUED8+1du41C9egdokHPAlb0pIFxiuXbhilWrjmBoSQQ/wd4Z2
 Ow8Wf+19g/2GvZx6uesO9q8VxZkNELuzS3h7all5Hy4S//pDt0BpWttdO9+7V1vChkVS
 NuJsxYezUOjzR0tluJn07bPCn9lC6rqb7dAMqyzONJlyU+ml3y242eEDZEOCoiT/RBA3
 OWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+ebn6tOBtZqV9fwgzMapnao6wcIVQllIFXvo/tE4RGk=;
 fh=5Q281T3cc8WUg4epsyFmyhkHOeoXoHkugv2URdONmqQ=;
 b=FweGI3AbfuGf7AnxW40xTJ7Mu8++auf6FnC9sHUdvP4Y6BL/V1Ih0Ws5vcxwoBKD8p
 0K8EoeQHBW/IL/xDhtrFihoxHjvTDwr2eHyONtQvuaeTrJozxLClv0fJizoBexby2+e9
 8IYmXOgPkHXxJwvrffwly7JxEjCvslF7gvDUmxq6xANfmNvgl2ARkt+UehUplIGpJyJS
 sOyhPwmjMgvcWme9CwU/4UoviAl02CzRNYAifBET2iGAplUreYwUVN/P3gdogNupv+SW
 fZSGe1UK2uBjYKCu7mWLiacVH3s8CVSC2zhitSb565UDbxywCvRSeWwYBxGMbpoPoiEB
 ZcIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497009; x=1772101809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ebn6tOBtZqV9fwgzMapnao6wcIVQllIFXvo/tE4RGk=;
 b=LACkprfClg4RZ55oNDnluo7+3zvj/BeK6JYiS87cJsltkiCWFbvw/UTum9BTsk/wCg
 Ltl713eaGQVjao0FSs0qVYWbOnm4fGwYF+hOTUptAk8XonNYHZS9oSJAKRPO59nDIdhE
 d2wMq6gPn1HAXbqDtogu8r/jIJwmZpySvweSvloehXlA0XTEY158IiKhyWNX96Eb4bX9
 /z7LKeoymYXX1ylvw8fFkEHNr8YMSzH/rEntZBqo1tZYDdvENzmGT9v7ZNzBePk6R3yL
 xL6yAV2Fwxxdu6WZcrSgu/0uOWaG0RyMUi4oJ8es2sTu0U6lNIsq63fjBIFjlCFGb6kG
 MmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497009; x=1772101809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ebn6tOBtZqV9fwgzMapnao6wcIVQllIFXvo/tE4RGk=;
 b=GL4sNMGTBUi7YVKJHaVBDuaCHDjYfyCXYVs/S+RC34SSQ6CCMjtpGg+p7nlmrdta+u
 l8cUOagbwcvHamcbuD5gZZfXk7yGNbiB/bKgYN1hs2U0dIj4/KEFHAjdTnfbiWm/KihQ
 z8Y06hhbZ9WMQjBsExbuIIJVklyQJYr9DTtqO/TmpFGNy9pK6bZN/Qixfusa9dQA+Bgq
 5785sFjPeWwPNGJ8ffWx4k/d9+0z7mRJjHIV4pR1P5fyOxcspyOtrdqcbkFKwPz+yfcF
 L7ExKlUSEAQyykHZFLY1cs3hN+LFFM/qvyoGmDq957y1HxH59yQtbV4aLuurG2xS7O0Z
 Lt6w==
X-Gm-Message-State: AOJu0YxBnJ2nBk2EvuLUkZ5zOr3AYN85YQulu86zDUlVWwJAxqwtGU23
 YcsaE8Mnun6FmLX4wLp4kLQiKauVHESc1JwDmIicX04WDozNFzjtyt8vT9wBR0wrSqnnCc5OL8x
 GIaEP/Q7YoD0SjBzDO+xkiI/D9OpiHmUsqlWzz+5KPA==
X-Gm-Gg: AZuq6aIRoG977poCRJ3VxyDgOU9maKfSIU+Zu/KBjq1UeBT4/noCAjL61I68FM7PH+z
 bvHRl9xofHho4ffUXwb2KpoJIeDx3CSRVRl06TZ/JaOtofnO73UsawksZu4L1NP12AK+HhR6F+k
 d4OZTx2zzONnQ3pdO2K1oLlkG8yYGBK9x4Wp8XKai+JUnAWU4F6eQDjEw+O0vJgB9X/ZSOA8zi9
 OfoNt6Ns4gxoQ6I5XjUaloGZFqB6w6Vco/QN+XubT/8C50pPdghJWyefzhTxUjF5FRCHrMyH0PW
 IesMB0um3YHz4FQP8RMGMmHviOXUVyUluDjtDr51lh8JjsWOmiZ1zsh7MEsvZ19ZmD8=
X-Received: by 2002:a05:690e:d58:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64c198c72e3mr14198316d50.30.1771497008664; Thu, 19 Feb 2026
 02:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-27-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-27-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:29:56 +0000
X-Gm-Features: AZwV_Qg_axfkx92o_MWe_VehT43BwlY0PdtMBFZkMa4fmyQ0hFJFoyCHoR5sUdk
Message-ID: <CAFEAcA-08J-_dn22s858QtUPV32VM4OuAEgBV-WdmGGxvJSu0w@mail.gmail.com>
Subject: Re: [PATCH v6 26/27] util: add support for formatting thread info in
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 11 Feb 2026 at 15:29, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> After:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*'
>   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_x509_load TLS cred=
s x509 load creds=3D0x560db818e080 dir=3Dfish
>   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_get_path TLS creds=
 path creds=3D0x560db818e080 filename=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: (772366:main): Unable to access credentials fish/ca=
-cert.pem: No such file or directory

Even more output enabled by default that is pretty useless for most
uses of tracepoints and debug logging :-(

Please can we have this stuff all off-by-default? People
who want this extra info can enable it.

-- PMM

