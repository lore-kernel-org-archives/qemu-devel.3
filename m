Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB2EC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsF2j-0004nR-Dn; Wed, 12 Mar 2025 01:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsF2h-0004n1-Oy
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:54:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsF2e-0002Pn-Qg
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:54:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso952705a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741758846; x=1742363646; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nyses4+dwJXKoHGNcFkWWEIP7CgKXhFWc+BRHrXV89s=;
 b=UmhfiZd2wmiPEjSboz37k10eU9OvGeA4TT+J1/V4Jb4Db3bWYfSuhgNslDF7TRKNFb
 YNG+16wu8z13p4Caje997CsZFG1OtgNLg48R6p6vQT4SVfCqhMFRDYbUGRpCa2d4GJfs
 KbQHWEsqN0UlsXx+t1DFrsqdcNcRJP0bYpfpV6KdSGzQSJdCAKStPq9mvikYpBI0HpZn
 E+5HGgKXUpN7nuVCQARz/LROpccspeU2zf4UCs5fWDPge+5uJfe2HKbHKnq5XYs94cvT
 LOiGflImk0Yq9ePNrPXYkBpdzwcfy5XYs80jlJo876z6yAlgxaq/BE0565Z23y0DhPcU
 MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741758846; x=1742363646;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nyses4+dwJXKoHGNcFkWWEIP7CgKXhFWc+BRHrXV89s=;
 b=Xpm5ah353bM9GRGShTW06RL4c56KP5YPQoPDTNjBChJK0hXpTX/0S+dwCwGeK99cBo
 yzCuQHyuPWnenUs7n3NS5uDI470jiujCxk6NkdoDRyeFLxtE7xpNnDIIZuMihT9OWNaL
 H0lfjc+02x8los+o/nv6ygHycZD7GjgDs053PUmIM8zUutb+r9ovHrds/q1dtZLTueRh
 vGKgDeUMm6wPJh5BVBIoja0yky47wF7ageLuG8MlWrUNfnWICfWtCQ+2gRd28HhxXrGo
 24LvpEFBu4sROCClLdbzKvHsC789F5En9fsjI929I5W6aZRgV6iqhOtBEw2Gd2WsX7xS
 TjVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJMhgeXSQKppTAe6RklEVlZBwp3Oez4UomKCuR4KxXNvc61VkBi56aj2z7+28nkyiBo3qx0ln342qu@nongnu.org
X-Gm-Message-State: AOJu0Yz3Fy593V9Q1ImIlFXHSHM5/t1ns07lELb50kZTPXtuMmuYKm8g
 ajA/9K7rC23bhQuOat6+S8BOg3BO65L/FCr9JpcSbblZBF98AcYn
X-Gm-Gg: ASbGncv5OBYNI6gyPIEFh8EMpzf5Y01IUIIkKCOXVW2Q4Yd+naFDbOgCqGu5GKBrAUM
 QLAkg2fbO7l3j8E+uD8CQ2U3v4R8DOLanFX/jki8hHfmrmJOe+C+JnyhOyovYZTHOYpKRTa8tHM
 teaifvZFY0QEjtnDq6+5liLhb1IJnMBmvenXGlP9CiIYIhMn0Zk7FDmA5K1tv9EG1pJH626Z2C+
 /wZYT3h10ZWyIewMa9Oh+5ARpRZbBbYC0lLX/pZYZUcuduq2tBF3qMDmXI9+zhiT2t3G27JWyv4
 XDQjho5rmUvQucnCZmG0qw9xVEz62oGSKUAOQRJy
X-Google-Smtp-Source: AGHT+IFsUMjBl3de/9fQOa5gF8BQTJWpur4eiQne4pRX5URmRPzEZYbipKmH3k9R2q3Hq6PVIhdLsQ==
X-Received: by 2002:a17:90b:5206:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-30100528c7emr9199867a91.8.1741758845492; 
 Tue, 11 Mar 2025 22:54:05 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a8103esm108000305ad.146.2025.03.11.22.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 22:54:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 15:54:00 +1000
Message-Id: <D8E1Z9A6YNXM.25RJW09GTA0QD@gmail.com>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: Don't fail any precaching errors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250311131327.903329-1-npiggin@gmail.com>
 <Z9A8swNn6zBm57jC@redhat.com>
 <e019f7fe-8b36-4a50-89d4-409754c91030@redhat.com>
 <Z9BEfc1l_K_g85hc@redhat.com>
In-Reply-To: <Z9BEfc1l_K_g85hc@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Mar 12, 2025 at 12:11 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 11, 2025 at 02:55:25PM +0100, Thomas Huth wrote:
>> On 11/03/2025 14.37, Daniel P. Berrang=C3=A9 wrote:
>> > On Tue, Mar 11, 2025 at 11:13:26PM +1000, Nicholas Piggin wrote:
>> > > The NetBSD archive is currently failing part-way through downloads,
>> > > which results in no clean HTTP error but a short transfer and checks=
um
>> > > error. This is treated as fatal in the precache download, and it hal=
ts
>> > > an entire set of tests even if some others could run.
>> > >=20
>> > > I hacked up this patch to get a bunch of CI tests going again for pp=
c
>> > > merge testing.
>> > >=20
>> > > Don't treat any precaching failures as errors.
>> > > This causes tests to be skipped when they try to fetch their asset.
>> > > Some CI results before/after patching:
>> > >=20
>> > > functional-system-fedora
>> > > https://gitlab.com/npiggin/qemu/-/jobs/9370860490 #bad
>> > > https://gitlab.com/npiggin/qemu/-/jobs/9373246826 #good
>> > >=20
>> > > functional-system-debian
>> > > https://gitlab.com/npiggin/qemu/-/jobs/9370860479 #bda
>> > > https://gitlab.com/npiggin/qemu/-/jobs/9373246822 #good
>> > >=20
>> > > This is making the tests skip. Is there a way to make the error more
>> > > prominent / obvious in the output? Should they fail instead? I think
>> > > there should be a more obvious indication of failure due to asset so
>> > > it does not go unnoticed.
>> > >=20
>> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > > ---
>> > >   tests/functional/qemu_test/asset.py | 9 +++------
>> > >   1 file changed, 3 insertions(+), 6 deletions(-)
>> > >=20
>> > > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/=
qemu_test/asset.py
>> > > index f0730695f09..3134ccb10da 100644
>> > > --- a/tests/functional/qemu_test/asset.py
>> > > +++ b/tests/functional/qemu_test/asset.py
>> > > @@ -174,14 +174,11 @@ def precache_test(test):
>> > >                   try:
>> > >                       asset.fetch()
>> > >                   except HTTPError as e:
>> > > -                    # Treat 404 as fatal, since it is highly likely=
 to
>> > > -                    # indicate a broken test rather than a transien=
t
>> > > -                    # server or networking problem
>> > > -                    if e.code =3D=3D 404:
>> > > -                        raise
>> > > -
>> >=20
>> > Why are you removing this ? The commit above does not make any referen=
ce
>> > to the problem being a missing URL (404 code). We want missing URLs to
>> > be fatal so that we identify when images we rely on are deleted by the=
ir
>> > host, as that is not a transient problem.
>> >=20
>> > >                       log.debug(f"HTTP error {e.code} from {asset.ur=
l} " +
>> > >                                 "skipping asset precache")
>> > > +                except:
>> > > +                    log.debug(f"Error from {asset.url} " +
>> > > +                              "skipping asset precache")
>> >=20
>> > So is the bit that actually deals with the exception you show in the
>> > jobs above.
>> >=20
>> > Best practice would be for us to define an 'AssetException' and use th=
at
>> > in assert.py when raising exceptions, or to wrap other exceptions in c=
ases
>> > where we propagate exceptions. Then this code can be move tailored to
>> > catch AssetException, instead of Exception.
>>=20
>> At least we should distinguish between "HTTP server bailed out early" (i=
n
>> which case we should likely skip the test), and "checksum of the asset d=
oes
>> not match" in which case we should rather fail the test since this is a =
hard
>> error that needs to be tackled if the file has been changed on the serve=
r
>> (otherwise this would go unnoticed and the test will never be run).

Yes, at least doing that would take care of this particular case. You
might like to have that case in the retry loop too, if possible.

I don't suppose the API can resume fetching from an offset and it might
be getting overkill to care so much, but that does allow the client to
see the error (wget attempts again after short xfer then gets a 503).

> In theory we are already distinguishing those cases. In the logs above,
> the stack traces come from a part of the code that indicates we have
> successfully downloaded the asset and now try to validate the result
> and failed.
>
> If the connection is terminating early, then our logic at:
>
>                 with tmp_cache_file.open("xb") as dst:
>                     with urllib.request.urlopen(self.url) as resp:
>                         copyfileobj(resp, dst)
>
> does not appear to be seeing a fatal error, otherwise we would
> have seen the log from
>
>             except Exception as e:
>                 self.log.error("Unable to download %s: %s", self.url, e)
>                 tmp_cache_file.unlink()
>                 raise
>
> and would never have got as far as comparing the checksums.
>
> So I'm wondering if 'copyfileobj' is not reliable in detecting
> premature termination of the http connection before all data
> has been sent.=20

It seems not. I posted a new series that tries to handle it. And
adds a new asset specific exception.

Thanks,
Nick


