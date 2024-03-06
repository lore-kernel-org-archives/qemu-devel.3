Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111DFC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoap-00086c-Iz; Wed, 06 Mar 2024 05:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhoaj-0007sz-GF; Wed, 06 Mar 2024 05:33:43 -0500
Received: from mail-dm6nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::604]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhoaS-0001dp-3V; Wed, 06 Mar 2024 05:33:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfw6s6T26ARS8OLHA6FlUjPtCxjo6/mf4EtbK/EtXLiMaYSYK+O4GLYtcab7G3McaoeG3SqDoDdZyonA2jp1GKl34c8tjqlzgv9P6EVY/rt36lQ4i24SjVyzYKKcGuuE323DA9Cex7mnFm1+W66Dg4Tp5JnpXLqAA61mktdOYPoVp4YDFzfRMMy8xrpy0C/7ZQXvv7ZPQCXOGJyZJcpEHwpp3JSGHsDsaDl/XKxlS3mybwUTYxmSrALteJY1smCbIseM8BGcMFRk3tICP0OafbpSkVc24JiSVMc9piDURxdyxBz2F5YtRdMz8X1lFbQVqmwkpRejjF8IKhpqaw4XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzBbfNmE7kNYhNyHukfWoeFLvEXcoQNix88HhP7dyWE=;
 b=mswSju2ivyVe7OmqUoen7SBNy1akDb/oCS3iMxK6MW7bpC1WT2Llkf0ILMHzm/btogDSmcicYlXnBSoIfY6lJTTQcr/9Zo+lHZkWo0K9EXEsPjmhJJoWOlWsiZJiZbym9d0RIxEmSEQASrh/Afi9KXdz77LF1RKXPpyjhq0CT0me1mIPTvApVrKVI97I5NuPUAZf7NC7IyKZFjIbVp8DT8nw1KKg8IWwmJdzHx1J8oEv8cbPI2LaR8KdiqdhURVS+Kjl2SL5ASmy/BLy6jvCBOCcrP0aRhYThznqetU4rKBG/xz3GIvv0tH4HR3i5scLj0XlA17o4Xfg+A0jrA+t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzBbfNmE7kNYhNyHukfWoeFLvEXcoQNix88HhP7dyWE=;
 b=iQ+edsJRAqi2+aIRkjyhtryITVIt+9fzNYKL32YMR+q7COOW+PJ9VcY7RpAqeqLTySbYBsdC8PIKtuoFRzLmYCIzQy+T1cu9osn8w9LTE3ESOg+th+71RuTkGmfeRmO6xrWeAVcMC6Qwhn/i/MKykYzcygzs1lYm9ELjqWsND556kDQww5ek+QYtCMsWk/SJSpBYMsfkEZV8PUb814Rd3Z2EpIRomh2CamdeOo2tu4CIQxuL6BS53W9GEg3Hv2RqElTnXs/BEVA7rWdpVeYDZrfpvIutUPG8k9IgBT66IshKJWOz/RoQXHRrJqlOXGnjgb7UnBxigbr8c334DEog5Q==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:33:17 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Wed, 6 Mar 2024
 10:33:17 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAvebIGAABSxAIAAAZo5gAA4QwCAAYEJMQ==
Date: Wed, 6 Mar 2024 10:33:17 +0000
Message-ID: <SA1PR12MB7199F1C81FDAF0DC2ADB26BBB0212@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
 <533ccbfc-7d90-42cd-9183-a5b128c41fad@redhat.com>
 <SA1PR12MB7199E6243CD2838335893CFCB0222@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240305103834.00004d49@Huawei.com>
In-Reply-To: <20240305103834.00004d49@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW4PR12MB6997:EE_
x-ms-office365-filtering-correlation-id: 24b5d24b-61b3-4865-2a84-08dc3dc8d626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZNlHW2nrp2yUSVsn1JondNB84qH95lFbzv72DKj6YFjXZhIwcW4Z4rInRumn7yG1Pd1UKb4n9ynyY3LpXbeFa+IKOP4qdl7yr6gkNOQSy3pTH2GlSYnA0xgEr+m4ueOMdE3cNNnooxxznmovjpLBkE4As2yHuaIWQjLY5gWB7v9GvoKHt0YUJpgfdbMlOrvIC2PN6RUJwAI0DpVocyez4uaK5nSuh/jQmZn8dImfTinuPRX2li0M/kprxWh5xC8zHtqO/vS/Irdqg20zAZ8F4++bdpNNPWJrXf5T1cb+kKe8lZNqOP+LH8ZpABCfZrz5FsEMrhVT11ONrKIDYkrkPWP3kz4R1cqCa881GvbdNrf4HV0zDiaywdQ8c3/dFlIjU0Ve6L2VUBD64iLVSQ2Xe9rVSZQdEJiQN93P9AnxRp4lhMPH9FCk4muGeR6t3eO1l13qpznQwt9K/yyneqCepAi7AVGKGGmVaWQYonmHtzb74tF/gEqw4+MKohLmioykdJNTYhvboMEwrnJ2r5qWpui41cwMJPP0jeMMHRHIx1BomAuPiBW3aOBJnviaFNxEEkAJ2RsaibS8hzFCtegR3FXXfGGf+zFCE+azrCFeSXwzjfjc61oAQQkJPCcYlGEwH1yH2hecTJ9MLqhJThgb/yVjGIto4nXYtnJdijzwoVky9mjYQlSY+iElHxWczB4+sozztFANNf7ajuBuHgd7F3raITEcuYevWiJzUzileY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CpvlHGjTZGukoDk1a0c0FVZzWx30Fs2Bu4YHQkTBMy4aQRBaNfOhfituwA?=
 =?iso-8859-1?Q?tiOV9ggOGsfIsz2gcq/Osnl8AlNqml/gVpF2GHU+Awwpy6lnUVRBEXwZzk?=
 =?iso-8859-1?Q?6DX6gcXPagChjYBarfZJzTB/CuOMsWtCQ/Yxj0to0xi6F0clH/G/6lqSnP?=
 =?iso-8859-1?Q?GPPtdvPIWhFNosipyjuCjfIxoL+9ouXaEkeNSv2rnVXvpL+4qCkIeCa29j?=
 =?iso-8859-1?Q?Jw+cDWpOlXEXl8OgRng34/+ggv7tfAx11ZX+bHEiSGsZgiqJ00UZQF6+Y9?=
 =?iso-8859-1?Q?yBJNicXzJKs2IB7RJEQyPmYI1K6xV00EBKED43wb+CVbSSi/CMdom41hxR?=
 =?iso-8859-1?Q?JHPXkhlbiBl06eXDzXtUCkcRxxY3zKeKGbzmLoNSv0/MPt6uf6yBI3kq/t?=
 =?iso-8859-1?Q?RzypgyZqIZnAZa7xomqjAvtloLIowZToNCKiVdyhY+tB5criUqouFAZm1q?=
 =?iso-8859-1?Q?9QiF7nLcamvaPh6kTsb/fr4I0KG95JHIhsLf1RgCf7INyDqAzrj/jSMTFu?=
 =?iso-8859-1?Q?0xwZpmpiStz2zJb10kmXrGxhzBCWkEezuOW2PnvUlZpCJmkhUYMSnlPgOt?=
 =?iso-8859-1?Q?7EpI+H743xdwFuK3bcE8EU/BIOM8yBwE8DifBJvRMMdtFW72yHnUg7fZCd?=
 =?iso-8859-1?Q?WTWOHCatVKqM7uiBKwl5J0ZM7Z/4gAWhatcoRY7imxDftHE+Oi3mZszz5h?=
 =?iso-8859-1?Q?qdvHStTmg0ow0dti/tyPhkUcfnMq53XwfufDduZa9JqaTkQVjT6YXsorE1?=
 =?iso-8859-1?Q?8rBphGV2pjiGoNX79ibWZksvUQh6wBDWmWjLIrv4V6L5lURxwOYP0UwVPp?=
 =?iso-8859-1?Q?jlq8D/8Gjjl18+kFsa/foOKEC8H9AjI5QLmJXN67GSC7QIgcWR/srxZJ3k?=
 =?iso-8859-1?Q?mDhkdE7LSSsKKFKbYmu9DmZ9nMzKtOmnf423nUgNIaMHW9L809FcZlSiPe?=
 =?iso-8859-1?Q?WBQvze4rUWnRMf8fZxb0jK7QApLAV+cEylfrFoaOZ0XBnb7MuclFMtIiN+?=
 =?iso-8859-1?Q?/U79YtqbHZ3eCQpeAPLtLuFOQrc9YEbyY8xdqlMmJ2x/lKBrArw9IaHQGL?=
 =?iso-8859-1?Q?Cseg7nIOUqfZJYGBn80vZtjvsaGCmsNrY+5w4I29hthrSAtYsf7kM4tZIT?=
 =?iso-8859-1?Q?A0UK6Y6gWHINUYakARcXsvDK1e1g4fmBx0ciRPAfcuH3qga800jJAhHsmw?=
 =?iso-8859-1?Q?OTEObhgvcMXKwNV9GMkky1RacYaQLDKEnvGe70rc5+PtM3zaFYVpcrOAYF?=
 =?iso-8859-1?Q?JDhwczkXMUIYYyAt/yYe9FKWx0DXbSS87upm071p943WqfqHr5WWAusBQR?=
 =?iso-8859-1?Q?zgeP1U6YHuJ3MVB6wFh4beTt3V0N/ymO2znvQfSFqicRn7Jbzppsltv46N?=
 =?iso-8859-1?Q?d7HHcTl6NuaBfSH5Z2HKSHy9IVdKKnv729eyBLrw8ubE/rpY5WCLgBHsi7?=
 =?iso-8859-1?Q?oQkIVZgezRa/XeQZ8mAu8hNhjJU7gs6d/UpVxNTnUVF0oyCXZ2zOlYTMnn?=
 =?iso-8859-1?Q?xJJs+NiHyPm0ellDb32iuR5AosSivFx/7XbHcGu76QFZF/pySR2MPce7hD?=
 =?iso-8859-1?Q?M8l5fvGcesUPzKs//YyyxSsCY3vndL17qSnMnSPZihvMMdPZhJvvxxLttC?=
 =?iso-8859-1?Q?V8Tc7qq5GkS2o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b5d24b-61b3-4865-2a84-08dc3dc8d626
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 10:33:17.4956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xlohh5V/iX6919t5lWDgDjjANl7voS6QIQ3Jt4DNkOgXjmNCzp2UxuGJvNKiDuOsl+TcTvsP5t9cpaTKoct2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
Received-SPF: softfail client-ip=2a01:111:f400:7e88::604;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

>> >> Jonathan, Alex, do you know how we may add tests that is dependent=0A=
>> >> on the vfio-pci device?=0A=
>> >=0A=
>> > There are none.=0A=
>> >=0A=
>> > This would require a host device always available for passthrough and=
=0A=
>> > there is no simple solution for this problem. Such tests would need to=
=0A=
>> > run in a nested environment under avocado: a pc/virt machine with an=
=0A=
>> > igb device and use the PF and/or VFs to check device assignment in a=
=0A=
>> > nested guests.=0A=
>> >=0A=
>> > PPC just introduced new tests to check nested guest support on two=0A=
>> > different HV implementations. If you have time, please take a look=0A=
>> > at tests/avocado/ppc_hv_tests.py for the framework.=0A=
>> >=0A=
>> > I will try to propose a new test when I am done with the reviews,=0A=
>> > not before 9.0 soft freeze though.=0A=
>>=0A=
>> Thanks for the information. As part of this patch, I'll leave out=0A=
>> this test change then.=0A=
>=0A=
> For BIOS table purposes it can be any PCI device. I've been testing=0A=
> this with a virtio-net-pci but something like virtio-rng-pci will=0A=
> do fine.=A0 The table contents doesn't care if it's vfio or not.=0A=
=0A=
Thanks, I was able to work this out with the virtio-rng-pci device.=0A=
=0A=
> I can spin a test as part of the follow up Generic Port series that=0A=
> incorporates both and pushes the limits of the hmat code in general.=0A=
> Current tests are too tame ;)=0A=
=0A=
Sure, that is fine by me.=0A=
FYI, this is how the test change looked like in case you were wondering.=0A=
=0A=
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c=0A=
index fe6a9a8563..8ac8e3f048 100644=0A=
--- a/tests/qtest/bios-tables-test.c=0A=
+++ b/tests/qtest/bios-tables-test.c=0A=
@@ -2157,6 +2157,29 @@ static void test_acpi_virt_oem_fields(void)=0A=
     g_free(args);=0A=
 }=0A=
=0A=
+static void test_acpi_virt_srat_gi(void)=0A=
+{=0A=
+    test_data data =3D {=0A=
+        .machine =3D "virt",=0A=
+        .tcg_only =3D true,=0A=
+        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",=0A=
+        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",=0A=
+        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.=
qcow2",=0A=
+        .ram_start =3D 0x40000000ULL,=0A=
+        .scan_len =3D 128ULL * 1024 * 1024,=0A=
+    };=0A=
+=0A=
+    data.variant =3D ".gi";=0A=
+    test_acpi_one(" -cpu cortex-a57"=0A=
+                  " -object memory-backend-ram,id=3Dram0,size=3D128M"=0A=
+                  " -numa node,memdev=3Dram0,nodeid=3D0"=0A=
+                  " -numa node,nodeid=3D1"=0A=
+                  " -device virtio-rng-pci,id=3Ddev0"=0A=
+                  " -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0=
,node=3D1",=0A=
+                  &data);=0A=
+=0A=
+    free_test_data(&data);=0A=
+}=0A=
=0A=
 int main(int argc, char *argv[])=0A=
 {=0A=
@@ -2312,6 +2335,7 @@ int main(int argc, char *argv[])=0A=
             if (qtest_has_device("virtio-iommu-pci")) {=0A=
                 qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);=0A=
             }=0A=
+            qtest_add_func("acpi/virt/gi", test_acpi_virt_srat_gi);=0A=
         }=0A=
     }=0A=
     ret =3D g_test_run();=0A=
--=0A=
2.34.1=0A=
=0A=
> Given I don't think we have clarification from ACPI spec side on=0A=
> the many to one mapping you are using, I'd just use a 1-1 in any=0A=
> test.=0A=
=0A=
Ack.=0A=

