Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B646F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcjP-0002KL-BK; Mon, 09 Mar 2026 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1vzcjN-0002Ci-UC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:41:18 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1vzcjL-0005Zd-Bk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:41:17 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46704177508so599874b6e.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1773070873; x=1773675673; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozp4voi2vmxPSC+1BbazqQFfgtPjTjEV2LsqlNp0PTg=;
 b=NVq5t2nmNgFf2zSGg2tMgLxeNi7fXwS0K0+br9aG3y3RZ5Bzl80xI0iZ0VkFuapYhz
 iVP+VJRxRkzC8MmUhfDfWlofXUEVyUeAv2ifc/QAfOc0BpdKcrSgV7O/kCdEce+LNyYg
 5npWGntOPVMGnDOpL712hQXehfRuQ26n/YIO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773070873; x=1773675673;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ozp4voi2vmxPSC+1BbazqQFfgtPjTjEV2LsqlNp0PTg=;
 b=UzTIclZlgxciEwrpTznKy1iTuUDDqpYTLj7Ow7uHirjE073+k4rrLL9yOeM2fyRiTD
 yGmZSXGz+KCajn0at2NeGrRsxfHZTEQ1TabEPdyLsP5AshlRTtNC4218uloO/GNP0NHG
 hPq4KPfLZbdkBBfD75U3KSImAuiLeM3+s2R0vTzQ/g6hcE1Wp7znULZ1cmJ8C8yQjpzY
 0ttuVEV0D2Dly40pg3I+9r061TBIBD055EkPYG/GqoBfad3u8RhF4gDeQAGDlz1mT955
 F2nheHMvikgJTsIZsEo/7vy+FOiRoiHEyjit5YDLgysCeD4R0AKx6h0QNeOL37VHaSg/
 wVGA==
X-Gm-Message-State: AOJu0YyhglS1ZIhOZWzeMR0JOKnw12Yb0X07ceek88zkVPggvnWKo9lS
 JjUycpfzoOAInS9erOG5G2Kii09tPDoflznusLleKU9lTHIYl8bN/0USofWeY+MliYM=
X-Gm-Gg: ATEYQzyqr3X6H7zssVovf/caHpw5qGX+G49Xk8fvqTfe/Hj8HhrVhNxmMJvUQ0GmiPX
 4ZHEnYE+TloFXDNr1RbGPQy8LtvFIx7I/zC3Dzsr7b1oW5L0B91alpMtkyfTxHLCxZEAbUuix1w
 ZiIb+di6SI63lfjttBudhbC80atNb4nGIucDGsPvf9eQkW7LJ5NCmmChjwD8VYYblELdYPq6pKy
 gc0CZl/UYsTZQk9YanumsZdLKJ0oGGSU/jiC0zpxB9DdaftiXCO5AQGyk1VOovZ5AoQmkh1Nf9z
 JgYhqsPUy/Ol3CTRD94PoK94QaR3nYvMi/xHAomIudUhaiYP1xDoV6hPHfXXZ4k50BHkPQo7h4A
 4NCeEHQaIZ/uaMzlj+mXpSHFoBP8aoy/bbEbSunVlk4qqbtgGUCCkhkoEwrX6z1n0Ns64MAjkj9
 oHJFeZ5lJbezF+UOFm1TMdrJF4/FcJ
X-Received: by 2002:a05:6808:1905:b0:467:db5:8b1c with SMTP id
 5614622812f47-4670db5a12dmr1691207b6e.21.1773070873394; 
 Mon, 09 Mar 2026 08:41:13 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:1910:162d:85e0:dd83])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e67d8710sm8853571fac.10.2026.03.09.08.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:41:12 -0700 (PDT)
Date: Mon, 9 Mar 2026 10:41:08 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v2 04/10] hw/core/boards: Remove
 MachineClass::smbus_no_migration_support field
Message-ID: <aa7qFOP-GTATfG0u@mail.minyard.net>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="aNBtw5znb6DnsJPR"
Content-Disposition: inline
In-Reply-To: <20260309145013.44327-5-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=cminyard@mvista.com; helo=mail-oi1-x22b.google.com
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
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--aNBtw5znb6DnsJPR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 03:50:06PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> The MachineClass::smbus_no_migration_support boolean was only used
> by the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
> Remove it, along with pm_smbus_vmstate_needed().
>=20
> Use the unconditional VMSTATE_BOOL() and VMSTATE_STRUCT() macros.

Nice.

Acked-by: Corey Minyard <corey@minyard.net>

or do you want me to handle it?

-corey

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-5-philmd@linaro.org>
> ---
>  include/hw/core/boards.h  |  1 -
>  include/hw/i2c/pm_smbus.h |  7 -------
>  hw/acpi/piix4.c           |  8 +-------
>  hw/i2c/pm_smbus.c         |  7 -------
>  hw/i2c/smbus_eeprom.c     |  4 +---
>  hw/i2c/smbus_ich9.c       | 10 ++--------
>  6 files changed, 4 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 9ad2a7d5c97..e15dbcea83b 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -314,7 +314,6 @@ struct MachineClass {
>      bool auto_enable_numa_with_memhp;
>      bool auto_enable_numa_with_memdev;
>      bool ignore_boot_device_suffixes;
> -    bool smbus_no_migration_support;
>      bool nvdimm_supported;
>      bool numa_mem_supported;
>      bool auto_enable_numa;
> diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
> index dafe0df4f69..62bbd45e803 100644
> --- a/include/hw/i2c/pm_smbus.h
> +++ b/include/hw/i2c/pm_smbus.h
> @@ -44,13 +44,6 @@ typedef struct PMSMBus {
> =20
>  void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk=
);
> =20
> -/*
> - * For backwards compatibility on migration, older versions don't have
> - * working migration for pm_smbus, this lets us ignore the migrations
> - * for older machine versions.
> - */
> -bool pm_smbus_vmstate_needed(void);
> -
>  extern const VMStateDescription pmsmb_vmstate;
> =20
>  #endif /* PM_SMBUS_H */
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 138ac3d3940..43860d12278 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -205,11 +205,6 @@ static const VMStateDescription vmstate_cpuhp_state =
=3D {
>      }
>  };
> =20
> -static bool piix4_vmstate_need_smbus(void *opaque, int version_id)
> -{
> -    return pm_smbus_vmstate_needed();
> -}
> -
>  /*
>   * This is a fudge to turn off the acpi_index field,
>   * whose test was always broken on piix4 with 6.2 and older machine type=
s.
> @@ -238,8 +233,7 @@ static const VMStateDescription vmstate_acpi =3D {
>          VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
>          VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
>          VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
> -        VMSTATE_STRUCT_TEST(smb, PIIX4PMState, piix4_vmstate_need_smbus,=
 3,
> -                            pmsmb_vmstate, PMSMBus),
> +        VMSTATE_STRUCT(smb, PIIX4PMState, 3, pmsmb_vmstate, PMSMBus),
>          VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
>          VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
>          VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index ead53d2724d..5654d516382 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -443,13 +443,6 @@ static const MemoryRegionOps pm_smbus_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -bool pm_smbus_vmstate_needed(void)
> -{
> -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> -
> -    return !mc->smbus_no_migration_support;
> -}
> -
>  const VMStateDescription pmsmb_vmstate =3D {
>      .name =3D "pmsmb",
>      .version_id =3D 1,
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index d9ac556a0ab..693d4762205 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -88,11 +88,9 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t=
 *buf, uint8_t len)
> =20
>  static bool smbus_eeprom_vmstate_needed(void *opaque)
>  {
> -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>      SMBusEEPROMDevice *eeprom =3D opaque;
> =20
> -    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev))=
 &&
> -        !mc->smbus_no_migration_support;
> +    return eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev);
>  }
> =20
>  static const VMStateDescription vmstate_smbus_eeprom =3D {
> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
> index 956c9b59bbc..51513e73fde 100644
> --- a/hw/i2c/smbus_ich9.c
> +++ b/hw/i2c/smbus_ich9.c
> @@ -41,20 +41,14 @@ struct ICH9SMBState {
>      PMSMBus smb;
>  };
> =20
> -static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
> -{
> -    return pm_smbus_vmstate_needed();
> -}
> -
>  static const VMStateDescription vmstate_ich9_smbus =3D {
>      .name =3D "ich9_smb",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
> -        VMSTATE_BOOL_TEST(irq_enabled, ICH9SMBState, ich9_vmstate_need_s=
mbus),
> -        VMSTATE_STRUCT_TEST(smb, ICH9SMBState, ich9_vmstate_need_smbus, =
1,
> -                            pmsmb_vmstate, PMSMBus),
> +        VMSTATE_BOOL(irq_enabled, ICH9SMBState),
> +        VMSTATE_STRUCT(smb, ICH9SMBState, 1, pmsmb_vmstate, PMSMBus),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --=20
> 2.53.0
>=20

--aNBtw5znb6DnsJPR
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwOTE1NDEw
OFowLwYJKoZIhvcNAQkEMSIEIMO3HdNTxVWJ9fMuLUeRe9fNYLFHFELv2VaWC+MRL4iyMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAGnKZeXtiT2TsSjRDz08fKv/j8n28l3r
dWOS86UQXuKZhIPmtPJeGirrynN0x81xZSM4fTbRhmsPlZgXHlgyy14tOq4AcnFEV5NmWBc7
ik0/HV5MzEH6yutvT3OM+t3VFBk6ChwozBHiyZn2gtwNXrRhlQkq46FisLybj5klv5gBQ0oY
vi/tWLCDkgGEPWNhPZWcnsaHETE4RnKZob3TUkhhUriZ5TGgPi2aEmSim9tLjuMg80K8ksvH
z6en5Ugoul7+su3RVBB23OO+uaXydU3zQll/27hSIrZ417t0g5dq6jRfm7UdC1xNBx8AO9HI
XiO5g79Es2cTF/6dHFhzfHM=

--aNBtw5znb6DnsJPR--

