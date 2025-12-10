Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DABD3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKRN-0002IL-ST; Wed, 10 Dec 2025 08:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKRL-000218-JC
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKRF-0001tG-HR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765374062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zb3h/yOe4FOOg1SjP81ys586cauCEduISxf/OpQdpyM=;
 b=MTKoG8eOKv6OqWAPZdeMTGoXmpfudbBqVNKYgTX8jz/5mZ3CgGavwgSWQpSmmt7Q0GgeVI
 ZHIN/U9BBx3CYys+iwyYUM3FTO5qeRQcSL0B3tqffeOHur3RjmIgtmw5pu3PhgZks5JjWJ
 0WI/MPHuTn5ddR5S2UGTxX0oRiazz6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-yh7vLgiONmyTDZ6J3rP7Qg-1; Wed, 10 Dec 2025 08:41:01 -0500
X-MC-Unique: yh7vLgiONmyTDZ6J3rP7Qg-1
X-Mimecast-MFC-AGG-ID: yh7vLgiONmyTDZ6J3rP7Qg_1765374060
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so5617954f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765374060; x=1765978860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb3h/yOe4FOOg1SjP81ys586cauCEduISxf/OpQdpyM=;
 b=lInEiA27xH5v1C/C+mKdWetxNv0knzoV384izPeC6JtL3nuJbMO79tEGXswG9NM17u
 eFl7Jo8PDYGarGvk1NTmARlXD2IDhuq2BekeabiBLEUTpyJnwtImgL6bj9hD0X8wQv71
 kqWxSke2hq9JlgdBj6oyVw5hZrMaSNQndjIMXeanIHeOhTyjQPgfB+5Zgwtensj0jiHw
 DkIlAGn4ZlNFjYue7ZQzUzEI7RpqaLTEWS7z9y6dw0wqeSJLo2uH4Cabt/ayBl5bLViV
 qQfqy5U3nzL2TyDBtkW5Van7SaGfg3CT4DrGYe2guzV+5kthNPGpfToJsuU6B6Tln8Wx
 +cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765374060; x=1765978860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zb3h/yOe4FOOg1SjP81ys586cauCEduISxf/OpQdpyM=;
 b=EjxgQhMLPNLKt6Rhwjfsmoy6hHh7dE0v5pJIbyOWiaqOU+Aqpwnn/scJvVXZDBX74u
 yLQy9ttcFV+UjLm0hfRGEAWPdUTRcJGjO+3MbhUPmbqod5yF/25hdv+ZLQHjWcNl7AQu
 xuq2Co3EKO8adBW1g2q6WXd5y0ftMUGxpAAcfL3bCU4zcSc7D7kDbHZi8ziPT62ml1rN
 bcWvn9dpxNK8hNNmNZG4q9U2dn1gk3fFZvhUOL6ByoOQy1TfD41UN1SSoE5o9ukG1+Tp
 mDIEVbWGmSlCKEn1NhgLuzEi/0dUxEpN4dmbBMp6HR42KekxtGcCXXxrjCP4HTtQxbl4
 X/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpA8o9wAeMdh6TiFAHFdwi41pEudpqpDAUd7XROCP85EkkfhOH8Tm46HRaZ/UJSTKA128s+V302qwm@nongnu.org
X-Gm-Message-State: AOJu0YykrLR0DZexzmZ6656WAovCHAUMPWWzkasVdG0gg2OQ4E6Q3Nb9
 mGHs+LzTv0NxwdeuibrYvjBHUwQ6NTXQr6nAlH2YO9iYsZLRVNUV2F952hQLFx0IR6KWM8961OY
 M3UoZVFv547u3wmww73x+b3IXIWHxZkN1PhJJj79bTNiiy5S2bYiuHFV8
X-Gm-Gg: AY/fxX5jLEOMWsaZSJFT3VodEX6LiWYXkyXhTQsKbPFOkrjUtP6Yso18FCPCAly6dba
 72svD77dWPaDOfVURaG3lCsgBsi8YP91bgvA1/Sfvu/AxjAQra81OOkwydVSRuNMaeuZ7PddP4b
 i1ftQF11YFwLcGxEbZAjznOP/iKqrBIzIGl+liYO9biU2Arxldq3BSvjP+cjxc5tNwoJQS1lvj4
 wBqBA4DBaxtDf/FHbtVBMTh7+1Xi93Ws5EcMVXyAixuXxBm52q+oTZKmWAyJL6JZWpiYpjfLATX
 lx8zI4OJIQjtCUsuRhg9dJQGI7TscIihR2u3BdOx2VQjSHTpuQC9CUsZIwOCDBqsUMMcoQ==
X-Received: by 2002:a5d:5f52:0:b0:429:8a71:d57 with SMTP id
 ffacd0b85a97d-42fa39db05dmr2891456f8f.27.1765374059948; 
 Wed, 10 Dec 2025 05:40:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZYZeixSrlivy6vXsXq2r+Ig30f6lToz9CZJJGDI1lxL4spxvkwM5lyCYk7mccjak+GzA08A==
X-Received: by 2002:a5d:5f52:0:b0:429:8a71:d57 with SMTP id
 ffacd0b85a97d-42fa39db05dmr2891424f8f.27.1765374059491; 
 Wed, 10 Dec 2025 05:40:59 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8fe8sm37733919f8f.2.2025.12.10.05.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:40:59 -0800 (PST)
Date: Wed, 10 Dec 2025 14:40:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] q35: Fix migration of SMRAM state
Message-ID: <20251210144055.3351d435@imammedo>
In-Reply-To: <20251203180851.6390-1-arbn@yandex-team.com>
References: <20251203180851.6390-1-arbn@yandex-team.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed,  3 Dec 2025 19:08:51 +0100
Andrey Ryabinin <arbn@yandex-team.com> wrote:

> mch_update_smbase_smram() essentially uses wmask[MCH_HOST_BRIDGE_F_SMBASE]
> to track SMBASE area state. Since 'wmask' state is not migrated is not
> migrated, the destination QEMU always sees
>  wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D=3D 0xff
>=20
> As a result, when mch_update() calls mch_update_smbase_smram() on the
> destination, it resets ->config[MCH_HOST_BRIDGE_F_SMBASE] and disables
> the smbase-window memory region=E2=80=94even if it was enabled on the sou=
rce.

[...]

> +static void mch_smbase_smram_post_load(MCHPCIState *mch)
> +{
> +    PCIDevice *pd =3D PCI_DEVICE(mch);
> +    uint8_t *reg =3D pd->config + MCH_HOST_BRIDGE_F_SMBASE;
> +
> +    if (!mch->has_smram_at_smbase) {
> +        return;
> +    }
> +
> +    if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D
> +            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +    } else if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
> +    }
> +}
You are correctly pointing to the issue about non-migratable wmask controll=
ing
config[], it should be other way around.

given reset already sets
  wmask[MCH_HOST_BRIDGE_F_SMBASE] && config[MCH_HOST_BRIDGE_F_SMBASE]
to default values, we don't need to do the same in mch_update_smbase_smram()
so we can just drop it.

Also I wouldn't introduce a dedicated mch_smbase_smram_post_load() though,
since mch_post_load() already calls mch_update_smbase_smram() indirectly,
I'd rather fix the later.

Would following work for you:

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a708758d36..7a85a349bd 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -431,31 +431,25 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
         return;
     }
=20
-    if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D
-            MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
-        return;
-    }
-
     /*
-     * default/reset state, discard written value
-     * which will disable SMRAM balackhole at SMBASE
+     * reg value can come either from register write/reset/migration
+     * source, update wmask to be in sync with it regardless of source
      */
-    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D=3D 0xff) {
-        *reg =3D 0x00;
+    switch (*reg) {
+    case MCH_HOST_BRIDGE_F_SMBASE_QUERY:
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D MCH_HOST_BRIDGE_F_SMBASE_L=
CK;
+        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
+        return;
+    case MCH_HOST_BRIDGE_F_SMBASE_LCK:
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
+        break;
+    case MCH_HOST_BRIDGE_F_SMBASE_IN_RAM:
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D MCH_HOST_BRIDGE_F_SMBASE_L=
CK;
+        break;
     }
=20
     memory_region_transaction_begin();
-    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
-        /* disable all writes */
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=3D
-            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        lck =3D true;
-    } else {
-        lck =3D false;
-    }
+    lck =3D *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;
     memory_region_set_enabled(&mch->smbase_blackhole, lck);
     memory_region_set_enabled(&mch->smbase_window, lck);
     memory_region_transaction_commit();

>  static int mch_post_load(void *opaque, int version_id)
>  {
>      MCHPCIState *mch =3D opaque;
> +
> +    mch_smbase_smram_post_load(mch);
>      mch_update(mch);
>      return 0;
>  }


