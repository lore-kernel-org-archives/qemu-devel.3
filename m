Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99010C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki8E-0007iC-FS; Fri, 17 Jul 2026 08:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wki8B-0007fU-Qp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:57:32 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wki89-0003jm-16
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:57:31 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44cd237446cso2847237fac.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1784293046; x=1784897846; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9cfNw9n/3Kgiq5JYlahgXoL63uVnLgvMj9UFBwfFQFo=;
 b=JCFYIzn+bovABRjdEGH2U2vfEXaMev6Qs2ameLVVOg00FefJ4S+9TjgtbrVkcH1PpG
 EWGNJlZ8eLJcydRl9PneorjmKMUr6UTdj8uB5HF7AHH2pqQqMCeNC7t3v1jdAwoosGpI
 75t0dYi55GczyPFhc1fwAw7dyngbRMIKdO7Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293046; x=1784897846;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9cfNw9n/3Kgiq5JYlahgXoL63uVnLgvMj9UFBwfFQFo=;
 b=QDN0bDBfAyG1MAfevNj/CJ28gfSrRMETXofTDy+MbWm08WPctqazSinKoKJJ0ETXWe
 b0a2RFvPRVnzSQJrLlmhgFq5mm4Jyf67TmSPf7ssFezmnFPGx+DBO4U+HWS4JLHZGr5C
 QjIt2k/pQRI2Jkwng6Aq7XWJrWFvb/wVW1Sjaol9yNw+Echp16L0MqgDOgdS9wyJ/1Yd
 /hmui1MCbupBx0065wcSkxTfVqOj/WkTk+uMXw3VYlurNOYio2yLk9TyjGmqB5FA8nxl
 wzwZ1Kj+sFeIy0bb+qZronVSY8Csyt0qg+4/x4Ex7KF58kNnrAHUpAZ+kirP1xgivwqW
 w45A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2bzOp6rlHVqh4cp6yEgEnSUuvk948ofjkSyu/E/SUdbojGRYK2/AbXUhjDxMhDjgrBQXc2ccQsM0t@nongnu.org
X-Gm-Message-State: AOJu0Yziv9AH68bombc8Y3UGheeVgtlJRV7f0NuAIli4jLW9Xz0/x+nz
 7aSzCxSwh9WUyNXUeoFBGJJ+N6C/Y12V71LfkncJTYnRtVJMRdcWr81PptOY/4GF/xs=
X-Gm-Gg: AfdE7cnKjN0qgfu1NZnZEYDPJu2NxgkAxKEmQCcofYFy3k1zsSjXyOo/rQC03XOcCU+
 DP67flv9aAh+b7EBvk6d4drgRGR/+iz2gE2VTNudT94i3oMJF2DwpNhqE/osw9YMPasOSjYUoBJ
 /fBlQH5jz/OzFDBm14RorNF3vN06TqLmOuDE8JVq6l+qWaZe0+St6blYEAYPsvPMuieP0hgrSIe
 SEDhhTif6tb32ONmQk/tkz5Y3gtGG1lrBRwSWROQdWHZmj/kutq0SBunpXP62KGxaMIAbRXI0kH
 yPoJ60xZHmkKK2XISa/X0JFVFQP1ubLcaLZ+UDLIm2DGliPP1gRijSd9LePuNFitsYcxnSR7Go8
 9bQQ56ZYW3EGIUIPKFxnpopD/SgAtIoHQLYl1p9EroKAYXbCLIz1mHkr5UGvbdZJOFoFYMm36Vi
 6z8Hq2BC5C07kWfT8irlw=
X-Received: by 2002:a05:6870:40c9:b0:439:c66d:2e5f with SMTP id
 586e51a60fabf-456904754ccmr1078613fac.24.1784293046411; 
 Fri, 17 Jul 2026 05:57:26 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4026:fe8a:98d1:9d51])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e61cee3sm1174337fac.9.2026.07.17.05.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:57:25 -0700 (PDT)
Date: Fri, 17 Jul 2026 07:57:21 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
Message-ID: <alomsclAchz2_bWy@mail.minyard.net>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
 <D5F0871C-4AC1-43D6-9BCD-C59A07236A1F@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="hK1Lx/WMqfHEEqqg"
Content-Disposition: inline
In-Reply-To: <D5F0871C-4AC1-43D6-9BCD-C59A07236A1F@free.fr>
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=cminyard@mvista.com; helo=mail-oa1-x31.google.com
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
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--hK1Lx/WMqfHEEqqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 07:08:04PM +0200, Emmanuel Blot wrote:
>=20
>=20
> On 10 Jul 2026, at 18:05, Peter Maydell wrote:
>=20
> > On Wed, 1 Jul 2026 at 18:31, Emmanuel Blot <emmanuel.blot@free.fr> wrot=
e:
> >>
> >> Slaves created with i2c_slave_create_simple() were left unparented and
> >> showed up under /machine/unattached with no stable QOM path. Add each
> >> slave as a QOM child of its bus, named after its I2C address, so it has
> >> a deterministic and addressable QOM path.
> >
> > Should devices on a bus be QOM children of the bus, though?
> > I would expect that they ought to be QOM children of e.g.
> > the SoC or machine that created them.
> >
> > Do we do this for other bus types, e.g. PCI ?
>=20
> If we do not want a I2C device to be a child of its bus, an alternative p=
arent could be the master/controller of the bus. However as a controller ma=
y manage several buses, we need to add bus differentiator in the child name=
, such as bus_num:address.
>=20
> I do not think it makes more sense to have the I2C device to be a child o=
f the SoC rather than its dedicated controller.
>=20
> On machines that are statically defined rather than composed from the com=
mand line (BMCs, complex SoC-based machines, =E2=80=A6), all the I2C device=
s would appear as a =E2=80=9Cflat=E2=80=9D list of devices, with sometimes =
many instances of the same I2C device type belonging to very different sub-=
domains of the machine they instrument and/or drive.
>=20
> I tend to think that using a flat schema would likely make use of QOM pat=
hs more difficult to observe and reach a device at run time: one would have=
 to iterate the device and bus hierarchy rather than to use QOM path to acc=
ess a device, or special care would be required for naming device instances=
=2E I was viewing the role of the QOM paths as a way to expose the machine =
device hierarchy as a comprehensive and non-ambiguous representation.
>=20
> What are the cons for using the device/bus hierarchy for simple buses suc=
h as SPI & I2C?
> Is there any drawback to use the device & bus hierarchy to assign a defau=
lt/fallback QOM path to a device?
>=20
> Maybe it=E2=80=99s a matter of ownership? Neither the I2C. bus nor the I2=
C controller owns the device for sure.

Well, "own" doesn't have much of a meaning in this context.  It's a
matter of how it's connected.

I agree with you philosophically.  From a user's point of view, a
hierarchy is much more obvious.  Otherwise you will have to create a
fake hierarchy with the names or you won't be able to find anything.

I looked at https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org/
but not much came of that.

It would be ideal if the hierarchy was a natural part of the APIs that
register a device.  If you put a device on an I2C bus, it becomes a
child of that I2C bus automatically.

However, corner cases exist.  Multi-master I2C chips would have two
parent I2C busses connected to a single child I2C bus, for instance.
Anything multi-master would have this issue.  Thinking about it some
more, a PHY might be on an MDIO bus but also connects to the main
ethernet interface.  Lots of chips have SPI/I2C control interfaces but
them some other interface for passing data.  A GPIO that enables a
chip but that chip is on a CAN bus interface.

So if you did something like this, you would need some sort of "multiple
inheritance" to cover the corner cases or you would have to live with
the inconsistency.

Device tree, for instance, has a strict hierarchy, but then has ways to
reference the other interfaces that can also control a device.  IIRC
a PHY would sit on the MDIO bus for hierarchy and the ethernet device
has a reference that says "This is my PHY."

-corey

>=20
> Emmanuel.

--hK1Lx/WMqfHEEqqg
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDcxNzEyNTcy
MVowLwYJKoZIhvcNAQkEMSIEIKT2m/I9mN4SCK7pBv9/F7VE+p6pp02O5OAq8wUaFVgWMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAGpgopbSmKVvsn0ksi//fNO4gIARONFl
kQ1JXiNc91UpPpLtHg3x4dwL5gaOMZNRwlhqOCh/oSGZjtH7d1Ir5OA1xGEer9tflSQaVGAz
it+ndZ2/3kZnTVIicX36t3UxRvNeoEywU98XfolPZSskwfCl67NUyEhp9BgiFXssiYGzudP8
RY9r6+77WTMXzRBzYAeImLlQTDVYbzmg6TJwnij4LpwWEzzZeTX0orWJ7XC6aAuGFM+fVnQH
88VPAJZVW6u5dpiAK75Xbx481B2EYwmlGljhiV0F4c6tW8z6F7DRu0A8s8wKMr/CRbdK4guZ
VXv+ZiuYE3nLV/OkXDVCT1w=

--hK1Lx/WMqfHEEqqg--

