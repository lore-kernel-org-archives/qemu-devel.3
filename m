Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DBDCD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM3pk-0005F0-HI; Sun, 10 May 2026 09:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wM3pD-0004nx-GC
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:04:03 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wM3pB-0007BW-3D
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:04:03 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2985246fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1778418239; x=1779023039; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hsn9CXRQGRTi2t12/EzLwuhFetOhfbTAYhbLjS8PjE8=;
 b=ZokvumEM5jXICdnEiHFVFT9zhd/7iglvc57giJ8OHEKm7dUZrnAxHOTx5sswRUa/St
 aYvl/dmXvnm+Kv9oPhroJ1h+bpqu0Iqt5zvAKpcQA9gADGGTBBJImxV3szUvXhU8oJk5
 6vxcqdG0O/OQKNLB1wRwojwfcp3fNiHM71iVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778418239; x=1779023039;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hsn9CXRQGRTi2t12/EzLwuhFetOhfbTAYhbLjS8PjE8=;
 b=PLNTxf/PTgDNX5sa6LXggAg1G2SANTUqEPOtzF6XVXG//KMWe+2acoEQxk49FcN23j
 wVBHXyw1Nrv+QdgXkak0JIPVZ6Zj+Tc3/ZWEOq0hD1hoVhq0yRMuYn59OHIV5ycCMurC
 /RgUKxVLl3z/7NvHmRST+lEtgXQuxYiJqfZ0gqiWsl4u5wzzkqE/V13FLuN35Vali0fE
 ZFO6npWQ6gWyUvvesN+4p6TSOORF0/jkh0nns2zzf+T9CPPv2u1jx6Yehh9Adii/iTty
 +tCwb3aBXPTwYzzJDfxnXWr1eJmRepHgMl8mFrFUbySzs9KfDPsDScjK5t4216Pmuv2H
 RPgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qp8Vdlg57N/E2FZr4Wvm0zSi5XUaq7NrGewKE90T95eAc8Uk4OoR2eeKZIVeGyK+XSSJeGbBDyeCr@nongnu.org
X-Gm-Message-State: AOJu0Yx7BxtWllXOxPiI8w+JuTopfGX6eFI6zD3WjjfqoEWO16yupN3C
 B2paoJBdGSCZSgDW19QGASDuJF6uhijvCNnD24C8wVEJeH/75PmG7omR+I1XNLSzSMI=
X-Gm-Gg: Acq92OF28CRxVI8fIL8b1J7RE7kYYfGJ7LUh5/BC1P7qSBgVJoB58VVRksdSdMgiG2i
 tm4NRWaWei8O+dC34KGrXzOZg4idf5XI8C4hwGF1WxDXrF+soKnhDithm2+xlU+v/DzHN7NoTPf
 cCf64hbR0Lz9H+2DW0C+f7IW6We604S7xTreDPRGx10nsLL19Wup6NET3lPhgRM3AqfCGFvk5nE
 nCW3xFgFDkJHnGs7T9pqBzaPE8itskHhfVQftF8U5FbBUuDLKMaxbgTKcxjUKjR1PMZ+ixqc+6q
 ZgecaK8LDO5hCNOUjLEtZTg3Zdo5rFnBTL7qyQTm/ZQF4fbY4VWSSJW32XrrZ00vBSjuPLYCPwn
 IxtmUsixyo3kEEkqPTsOhvQHkq1Dli4W3S+lrpAuG3Drxim948+G6pKFf0nrHp7WNzfU2VZ3VuG
 buJyJ1s8kHpV51nB1kx+Gs452jzFzp
X-Received: by 2002:a05:6870:8256:b0:423:1cc1:f878 with SMTP id
 586e51a60fabf-43526b03e9bmr7721337fac.29.1778418238983; 
 Sun, 10 May 2026 06:03:58 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ac9a:d57b:981c:10e1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435574490b0sm7355865fac.17.2026.05.10.06.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 06:03:58 -0700 (PDT)
Date: Sun, 10 May 2026 08:03:53 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Chris Rauer <crauer@google.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/4] hw/i2c: Add designware i2c controller
Message-ID: <agCCOdfvlRVtCpYf@mail.minyard.net>
References: <20260507120524.111056-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="K5SL5gqZZmaSmDhk"
Content-Disposition: inline
In-Reply-To: <20260507120524.111056-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=cminyard@mvista.com; helo=mail-oa1-x34.google.com
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


--K5SL5gqZZmaSmDhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 10:05:18PM +1000, Nicholas Piggin wrote:
> Hi,
>=20
> This series contains the DW I2C model written by Chris Rauer and
> updated for the Tenstorrent Atlantis machine recently. There was
> some more review comment on that submission and so we decided to
> take the I2C device out of that series and work on it separately,
> see here:
>=20
> https://lore.kernel.org/qemu-devel/20260425131721.932250-1-joel@jms.id.au=
/T/#mb1ef2824c2f1f37bf4574dc1ef0fb95566c3a2f2
>=20
> The big thing suggested was to move to the QEMU register API. That
> is a big change and difficult to review, so I have split that and
> a some smaller changes out into their own patches. I don't expect
> detailed reviews on the register API patch -- it's quite mechanical
> and I did attempt to verify it by diff'ing register traces. But it
> would be good to make sure maintainers are happy to go that way.
>=20
> Unfortunately the patch 1 was quite well reviewed and tested so
> incremental changes would be preferable, but it is painful to maintain
> migration compatibility across these changes.

I had a few comments on the first patch, but they were all fixed in
later patches.  From my review this all looks good.

Yes, please squash these as you suggested in the second patch.

Acked-by: Corey Minyard <cminyard@mvista.com>

-corey

>=20
> Thanks,
> Nick
>=20
> Chris Rauer (1):
>   hw/i2c: Add designware i2c controller
>=20
> Nicholas Piggin (3):
>   [RFC] hw/i2c/designware_i2c: Switch to Fifo8
>   [RFC] hw/i2c/designware_i2c: Switch to QEMU register API
>   [RFC] hw/i2c/designware_i2c: add SMBUS_INTR_MASK
>=20
>  MAINTAINERS                     |   8 +
>  hw/i2c/Kconfig                  |   5 +
>  hw/i2c/designware_i2c.c         | 742 ++++++++++++++++++++++++++++++++
>  hw/i2c/meson.build              |   1 +
>  hw/i2c/trace-events             |   4 +
>  include/hw/i2c/designware_i2c.h |  56 +++
>  roms/seabios-hppa               |   2 +-
>  7 files changed, 817 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i2c/designware_i2c.c
>  create mode 100644 include/hw/i2c/designware_i2c.h
>=20
> --=20
> 2.53.0
>=20

--K5SL5gqZZmaSmDhk
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMDEzMDM1
M1owLwYJKoZIhvcNAQkEMSIEILJ+cnuF3wBQiaEr/e+Nv8byYZSg3WLXOQ9/agK6dHdJMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAAXhjSXk1Yyohfo0CSZA5wxWK8o69QJ6
P8B3Q36oe4yIQRC52JIlW2KZipongtmckE73zTb5bEfXKHsX5Tcxs22EE6jxb5uG62KO8zZr
dzfBRb1oBIMC7HjLXGbZItQ8ZPwHguze0Jl4q7d6FjpcifThreUQI+fV6gV830loVdC8DO9Z
H6ylOF5spoz6WwBKlKFNncEsuZgG9nzhzftmuE15qIWVUxOglHSdUpzugNHMzCs8FLyLItJw
FQvY9j1T1nm4YhhojvNLn/3KQyExWEwbKJluBwSP6SC1g3yc6vjfXpCuENnFtqUu+eqAlS1b
MtobJx2Y1e1OsmMZk0dvRYc=

--K5SL5gqZZmaSmDhk--

