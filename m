Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F627EA3F16
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpiu0-0006AM-EF; Tue, 10 Feb 2026 03:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpity-0006A2-AX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpitw-00034i-4k
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770711314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faMatI6O4KZNF22lZBXDifeF+eAcosXM17IviZ1bhUE=;
 b=G8BgOnZJjaywKbi/rbTgou+KsxKwEJe+Exe6soWmL5SPBjM478afabzY4YsJkVc1LZZJAd
 KSSfrNdBU/lpiIngIZ4XW0Nq5uBt7SPuTQVJ+muaTLkEgO/cEHju/E8z5mtdej4HVKp0hv
 spQoaSJc8jZkGWmBIg2FEaQjkKhfIPc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-aIDIJKFpPfiPSQdqo_Xpew-1; Tue, 10 Feb 2026 03:15:10 -0500
X-MC-Unique: aIDIJKFpPfiPSQdqo_Xpew-1
X-Mimecast-MFC-AGG-ID: aIDIJKFpPfiPSQdqo_Xpew_1770711309
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so21498645ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770711309; x=1771316109; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faMatI6O4KZNF22lZBXDifeF+eAcosXM17IviZ1bhUE=;
 b=Kxd+PPx91zjpnjjYhjUlYQsTyvtMp78vGAgfAcW+ApSjKxDy/i7UdgbJuWjnsD8eh4
 GZMqG3sP3TU5f7K9/OWA5E8h5fEt0xwF2jf1gkT422rytO9b2GMXoOfSNOAWMKCG62Mi
 x9mmQKPoJcf6nSywHqCOre1vm1ji2+MCuOXnNWOPdwbcD/TlqV0BFv5DrU5rJoxSfZPY
 1NyHNagVvAAdrCPVnSw5jCbz9FHe7mK27yBfNWnWtRrcJJH/uhOT7aofQgO623qnDF52
 MPL+35p6cyyKRM8k8fn2K0WUGe/QfHzvV0+U7dJAX3tR6/If3C+HfdMKQoUrqCn6986N
 MRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770711309; x=1771316109;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faMatI6O4KZNF22lZBXDifeF+eAcosXM17IviZ1bhUE=;
 b=Awkqg5Mk3ewXXw3ZHKEMb+qbLQdiGtP9iSDyt57h3M7AESuIzH209A6bki+m1kDYKe
 QY8Nprp3WvoiCrFbsG34DhwqVjR0k3yPkohkznucGhAWrhd0Obk3rnbCEktVM6berstW
 fx8vHnA7uYwttKpl3hRyQNMFYrWpc+PZL17ythJBglukqQbjKUECp8DL+uoqQimkPGeN
 8aZk0Gt6hVxgWPU6NEBWJU37iy8S3qdhwReMFdErVuffR6JFqWi4lehRYUAv6ybE8jSS
 PCCRDUW61miAspsIc7zCU0csIg/qob6r7xCAbJGo5m3e74bOyPifWNXJg/2KqO3jyy8y
 Aq/w==
X-Gm-Message-State: AOJu0YwbZjV+7TFKS9cxhfaoGAauRQ1UqOJd1jLGKHpRiAbJstswjf6G
 vK6hzepN29TaUvlvFTDEpv+T876ZQtBNAK2nbPI9zMHCO/vcJnW4bF8K4pjOsLdtpUVJoI5HR1T
 d/z06dYQ+YYotLj83VWqS7jKxANa+oeyKQFRqm91GDUeOtyTCdQLklqtR
X-Gm-Gg: AZuq6aJsI/z2s2PKvBaYxRGUzs3dWreVHf4umGecRTd1ZcdeajR4XxlB2sD+wB09VXa
 k+a/ncy+3s1afk2kC8yyDnH+p6uyoID7xpywmu+7BhPLfFTYd825mOS8ueG7qB7Pu/v/k1inOeT
 Y4/hOXF/nAWjsYb5F+aTVAbQmOuMEPX86z9372VZNrBGPjblEqwIu3XAgheyO1nBCzerv8Q8nnB
 MXgkuWGlkDv1zkTqWmLu/mFdlRr0+iaMcYG7KtTZ3U/D7jY89theIb9GuMKTLKVv3pJjRxbgY5c
 pA7QuvbBmTnFp6vEytHEviipGNdxUnwQVAEs5a1dyKR8Pi9gLvzSCxAIrAFTgSYLW6olzzm4kor
 xyHzQnTKCgKPfSCmtdBoFmg/QOu6sdtbZ5PIDm63faMLVrF7evonzyXs0QhooykpyE0paSZw=
X-Received: by 2002:a17:902:d510:b0:2a0:c58c:fdd2 with SMTP id
 d9443c01a7336-2ab1055081emr17831675ad.26.1770711309109; 
 Tue, 10 Feb 2026 00:15:09 -0800 (PST)
X-Received: by 2002:a17:902:d510:b0:2a0:c58c:fdd2 with SMTP id
 d9443c01a7336-2ab1055081emr17831485ad.26.1770711308767; 
 Tue, 10 Feb 2026 00:15:08 -0800 (PST)
Received: from smtpclient.apple ([106.202.227.239])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c8ac5asm130172905ad.35.2026.02.10.00.15.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Feb 2026 00:15:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2 1/1] tests/data/acpi: disassemble-aml: rename and
 change interpreter line
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260210041248.14701-1-mohamed@unpredictable.fr>
Date: Tue, 10 Feb 2026 13:44:53 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Michael Tsirkin <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16284699-7807-4D95-A9C0-405BDA4D45EC@redhat.com>
References: <20260210041248.14701-1-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10 Feb 2026, at 9:42=E2=80=AFAM, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>=20
> /usr/bin/bash isn't guaranteed to be present. Switch
> to /usr/bin/env bash.
>=20
> Rename disassemle to disassemble in the same commit.
>=20
> Adapt the correponding message in rebuild-expected-aml.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/data/acpi/{disassemle-aml.sh =3D> disassemble-aml.sh} | 4 ++--
> tests/data/acpi/rebuild-expected-aml.sh                   | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
> rename tests/data/acpi/{disassemle-aml.sh =3D> disassemble-aml.sh} =
(92%)
>=20
> diff --git a/tests/data/acpi/disassemle-aml.sh =
b/tests/data/acpi/disassemble-aml.sh
> similarity index 92%
> rename from tests/data/acpi/disassemle-aml.sh
> rename to tests/data/acpi/disassemble-aml.sh
> index 89561d233d..62e1991ace 100755
> --- a/tests/data/acpi/disassemle-aml.sh
> +++ b/tests/data/acpi/disassemble-aml.sh
> @@ -1,4 +1,4 @@
> -#!/usr/bin/bash
> +#!/usr/bin/env bash
>=20
> outdir=3D
> while getopts "o:" arg; do
> @@ -7,7 +7,7 @@ while getopts "o:" arg; do
>         outdir=3D$OPTARG
>         ;;
>     \? )
> -        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o =
<output-directory>]"
> +        echo "Usage: ./tests/data/acpi/disassemble-aml.sh [-o =
<output-directory>]"
>         exit 1
>         ;;
>=20
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh =
b/tests/data/acpi/rebuild-expected-aml.sh
> index cbf9ffe0dd..af45cf3007 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -57,7 +57,7 @@ old_allowed_dif=3D`grep -v -e 'List of =
comma-separated changed AML files to ignore
> echo '/* List of comma-separated changed AML files to ignore */' > =
${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
>=20
> echo "The files were rebuilt and can be added to git."
> -echo "You can use ${SRC_PATH}/tests/data/acpi/disassemle-aml.sh to =
disassemble them to ASL."
> +echo "You can use ${SRC_PATH}/tests/data/acpi/disassemble-aml.sh to =
disassemble them to ASL."
>=20
> if [ -z "$old_allowed_dif" ]; then
>     echo "Note! Please do not commit expected files with source =
changes"
> --=20
> 2.50.1 (Apple Git-155)
>=20


